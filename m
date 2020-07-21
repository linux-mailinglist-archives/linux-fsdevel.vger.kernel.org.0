Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9C2228C65
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 01:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731400AbgGUXBE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 19:01:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:48984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731334AbgGUXBA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 19:01:00 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 359C42080D;
        Tue, 21 Jul 2020 23:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595372460;
        bh=bm/93v1WSvC6J93NR1nVeFT9ERB8Qnq16lzUB1BPqPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yTeekrEWE34bWmgyoc8iAznT5bvWxJDueciA3ij6RH6rLKNuOnEk0MOy7iokq1aFB
         RuBNvzBsxiqhd7gPu+ZphlSWCK0lXcg6Pxg9KqXbYpGT8njiwXoXfX+quheoo8oXmE
         bhMmzYGK06j+1a+jUGVTDO7CMxfvYQHgh4nIFytI=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH 5/5] fs-verity: use smp_load_acquire() for ->i_verity_info
Date:   Tue, 21 Jul 2020 15:59:20 -0700
Message-Id: <20200721225920.114347-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200721225920.114347-1-ebiggers@kernel.org>
References: <20200721225920.114347-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Normally smp_store_release() or cmpxchg_release() is paired with
smp_load_acquire().  Sometimes smp_load_acquire() can be replaced with
the more lightweight READ_ONCE().  However, for this to be safe, all the
published memory must only be accessed in a way that involves the
pointer itself.  This may not be the case if allocating the object also
involves initializing a static or global variable, for example.

fsverity_info::tree_params.hash_alg->tfm is a crypto_ahash object that's
internal to and is allocated by the crypto subsystem.  So by using
READ_ONCE() for ->i_verity_info, we're relying on internal
implementation details of the crypto subsystem.

Remove this fragile assumption by using smp_load_acquire() instead.

Also fix the cmpxchg logic to correctly execute an ACQUIRE barrier when
losing the cmpxchg race, since cmpxchg doesn't guarantee a memory
barrier on failure.

(Note: I haven't seen any real-world problems here.  This change is just
fixing the code to be guaranteed correct and less fragile.)

Fixes: fd2d1acfcadf ("fs-verity: add the hook for file ->open()")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/verity/open.c         | 15 ++++++++++++---
 include/linux/fsverity.h |  9 +++++++--
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/fs/verity/open.c b/fs/verity/open.c
index d007db0c9304..bfe0280c14e4 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -221,11 +221,20 @@ struct fsverity_info *fsverity_create_info(const struct inode *inode,
 void fsverity_set_info(struct inode *inode, struct fsverity_info *vi)
 {
 	/*
-	 * Multiple processes may race to set ->i_verity_info, so use cmpxchg.
-	 * This pairs with the READ_ONCE() in fsverity_get_info().
+	 * Multiple tasks may race to set ->i_verity_info, so use
+	 * cmpxchg_release().  This pairs with the smp_load_acquire() in
+	 * fsverity_get_info().  I.e., here we publish ->i_verity_info with a
+	 * RELEASE barrier so that other tasks can ACQUIRE it.
 	 */
-	if (cmpxchg(&inode->i_verity_info, NULL, vi) != NULL)
+	if (cmpxchg_release(&inode->i_verity_info, NULL, vi) != NULL) {
+		/* Lost the race, so free the fsverity_info we allocated. */
 		fsverity_free_info(vi);
+		/*
+		 * Afterwards, the caller may access ->i_verity_info directly,
+		 * so make sure to ACQUIRE the winning fsverity_info.
+		 */
+		(void)fsverity_get_info(inode);
+	}
 }
 
 void fsverity_free_info(struct fsverity_info *vi)
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 78201a6d35f6..c1144a450392 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -115,8 +115,13 @@ struct fsverity_operations {
 
 static inline struct fsverity_info *fsverity_get_info(const struct inode *inode)
 {
-	/* pairs with the cmpxchg() in fsverity_set_info() */
-	return READ_ONCE(inode->i_verity_info);
+	/*
+	 * Pairs with the cmpxchg_release() in fsverity_set_info().
+	 * I.e., another task may publish ->i_verity_info concurrently,
+	 * executing a RELEASE barrier.  We need to use smp_load_acquire() here
+	 * to safely ACQUIRE the memory the other task published.
+	 */
+	return smp_load_acquire(&inode->i_verity_info);
 }
 
 /* enable.c */
-- 
2.27.0


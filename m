Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9246C228C60
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 01:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731406AbgGUXBE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 19:01:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:48990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbgGUXBA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 19:01:00 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9616A207BB;
        Tue, 21 Jul 2020 23:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595372459;
        bh=HkY2xoW+5h/KPN4NirPSCI6mZ1dMQTytJsLYKF1i9Kk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k3Gk9VGnsqGB5y+WMg5lND+8JiNxzRrc4VjLmUb1EIy9UlP7HqQV7CTx+ehe/RuD1
         XuaTIIvbwwLc5tFsjkcZoEyxBDu3L+o2yMrmwuMjDcbypkZuUM4Or6eNsG2RGZ5mhI
         VdEvSYtK16hT7PpUn/1yWdPuPeao//sgvXC/ASxo=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH 3/5] fscrypt: use smp_load_acquire() for ->s_master_keys
Date:   Tue, 21 Jul 2020 15:59:18 -0700
Message-Id: <20200721225920.114347-4-ebiggers@kernel.org>
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

super_block::s_master_keys is a keyring, which is internal to and is
allocated by the keyrings subsystem.  By using READ_ONCE() for it, we're
relying on internal implementation details of the keyrings subsystem.

Remove this fragile assumption by using smp_load_acquire() instead.

(Note: I haven't seen any real-world problems here.  This change is just
fixing the code to be guaranteed correct and less fragile.)

Fixes: 22d94f493bfb ("fscrypt: add FS_IOC_ADD_ENCRYPTION_KEY ioctl")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/keyring.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/crypto/keyring.c b/fs/crypto/keyring.c
index 7f8ac61a20d6..71d56f8e2870 100644
--- a/fs/crypto/keyring.c
+++ b/fs/crypto/keyring.c
@@ -213,7 +213,11 @@ static int allocate_filesystem_keyring(struct super_block *sb)
 	if (IS_ERR(keyring))
 		return PTR_ERR(keyring);
 
-	/* Pairs with READ_ONCE() in fscrypt_find_master_key() */
+	/*
+	 * Pairs with the smp_load_acquire() in fscrypt_find_master_key().
+	 * I.e., here we publish ->s_master_keys with a RELEASE barrier so that
+	 * concurrent tasks can ACQUIRE it.
+	 */
 	smp_store_release(&sb->s_master_keys, keyring);
 	return 0;
 }
@@ -234,8 +238,13 @@ struct key *fscrypt_find_master_key(struct super_block *sb,
 	struct key *keyring;
 	char description[FSCRYPT_MK_DESCRIPTION_SIZE];
 
-	/* pairs with smp_store_release() in allocate_filesystem_keyring() */
-	keyring = READ_ONCE(sb->s_master_keys);
+	/*
+	 * Pairs with the smp_store_release() in allocate_filesystem_keyring().
+	 * I.e., another task can publish ->s_master_keys concurrently,
+	 * executing a RELEASE barrier.  We need to use smp_load_acquire() here
+	 * to safely ACQUIRE the memory the other task published.
+	 */
+	keyring = smp_load_acquire(&sb->s_master_keys);
 	if (keyring == NULL)
 		return ERR_PTR(-ENOKEY); /* No keyring yet, so no keys yet. */
 
-- 
2.27.0


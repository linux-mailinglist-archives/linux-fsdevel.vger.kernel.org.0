Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA5526957E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Sep 2020 21:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgINTTJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 15:19:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:38950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgINTRN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 15:17:13 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26FAC21974;
        Mon, 14 Sep 2020 19:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600111032;
        bh=gM6sCpb5yU4vQNbnGfPapdqAJL/5qq1Q4OJTc+Ei+eM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EZ5oiRLwCH3xwkNGVtwTv6eCr+aNRI14JF44rWDpGU2I4q05noFrDS8cR4IGkTq1f
         qLvYJdpM7rEi7wnBBsXCaYdpllWmq1ew67s9LJ4kTd6cItjDGjhSCl8sm/rJUCYFgs
         Q/vmEtBsPfXli40LcCllmeTns7GTpC81QRb2e+cQ=
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v3 03/16] fscrypt: export fscrypt_d_revalidate
Date:   Mon, 14 Sep 2020 15:16:54 -0400
Message-Id: <20200914191707.380444-4-jlayton@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200914191707.380444-1-jlayton@kernel.org>
References: <20200914191707.380444-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ceph already has its own d_revalidate op so we can't rely on fscrypt
using that directly. Export this symbol so filesystems can call it
from their own d_revalidate op.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/crypto/fname.c       | 3 ++-
 include/linux/fscrypt.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index a1cb6c2c50c4..0d41eb4a5493 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -578,7 +578,7 @@ EXPORT_SYMBOL_GPL(fscrypt_fname_siphash);
  * Validate dentries in encrypted directories to make sure we aren't potentially
  * caching stale dentries after a key has been added.
  */
-static int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags)
+int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags)
 {
 	struct dentry *dir;
 	int err;
@@ -617,6 +617,7 @@ static int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags)
 
 	return valid;
 }
+EXPORT_SYMBOL_GPL(fscrypt_d_revalidate);
 
 const struct dentry_operations fscrypt_d_ops = {
 	.d_revalidate = fscrypt_d_revalidate,
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 95dddba3ed00..b547e1aabb00 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -204,6 +204,7 @@ int fscrypt_fname_disk_to_usr(const struct inode *inode,
 bool fscrypt_match_name(const struct fscrypt_name *fname,
 			const u8 *de_name, u32 de_name_len);
 u64 fscrypt_fname_siphash(const struct inode *dir, const struct qstr *name);
+int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags);
 
 /* bio.c */
 void fscrypt_decrypt_bio(struct bio *bio);
-- 
2.26.2


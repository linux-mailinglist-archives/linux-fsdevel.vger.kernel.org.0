Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53699269557
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Sep 2020 21:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgINTRi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 15:17:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:38960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgINTRN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 15:17:13 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B263C21BE5;
        Mon, 14 Sep 2020 19:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600111033;
        bh=oKXMY3huJ4gH9ve2CTeuG+2SJx1r8vcdkKAnbDC++Mw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pm/zGL7KXx+QZR4JPxbkkOgVJ9hpR5kYmu9R27peQQzPYlxy/HLskYeNVFwO4bDTD
         ANY5nJ1w+5+uAFFqizipW4UC31Z0bevrmaGBX8egjHUMN9afzQB++1InqVhHASfUNk
         tvpUsi7x4u9PYPVbWYYQN6K9NpACL34xpnl1qiZU=
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v3 04/16] fscrypt: add fscrypt_context_for_new_inode
Date:   Mon, 14 Sep 2020 15:16:55 -0400
Message-Id: <20200914191707.380444-5-jlayton@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200914191707.380444-1-jlayton@kernel.org>
References: <20200914191707.380444-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

CephFS will need to be able to generate a context for a new "prepared"
inode. Add a new routine for getting the context out of an in-core
inode.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/crypto/policy.c      | 35 ++++++++++++++++++++++++++++-------
 include/linux/fscrypt.h |  1 +
 2 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index 97cf07543651..0888f950367b 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -655,6 +655,31 @@ const union fscrypt_policy *fscrypt_policy_to_inherit(struct inode *dir)
 	return fscrypt_get_dummy_policy(dir->i_sb);
 }
 
+/**
+ * fscrypt_context_for_new_inode() - create an encryption context for a new inode
+ * @ctx: where context should be written
+ * @inode: inode from which to fetch policy and nonce
+ *
+ * Given an in-core "prepared" (via fscrypt_prepare_new_inode) inode,
+ * generate a new context and write it to ctx. ctx _must_ be at least
+ * FSCRYPT_SET_CONTEXT_MAX_SIZE bytes.
+ *
+ * Returns size of the resulting context or a negative error code.
+ */
+int fscrypt_context_for_new_inode(void *ctx, struct inode *inode)
+{
+	struct fscrypt_info *ci = inode->i_crypt_info;
+
+	BUILD_BUG_ON(sizeof(union fscrypt_context) != FSCRYPT_SET_CONTEXT_MAX_SIZE);
+
+	/* fscrypt_prepare_new_inode() should have set up the key already. */
+	if (WARN_ON_ONCE(!ci))
+		return -ENOKEY;
+
+	return fscrypt_new_context(ctx, &ci->ci_policy, ci->ci_nonce);
+}
+EXPORT_SYMBOL_GPL(fscrypt_context_for_new_inode);
+
 /**
  * fscrypt_set_context() - Set the fscrypt context of a new inode
  * @inode: a new inode
@@ -671,12 +696,9 @@ int fscrypt_set_context(struct inode *inode, void *fs_data)
 	union fscrypt_context ctx;
 	int ctxsize;
 
-	/* fscrypt_prepare_new_inode() should have set up the key already. */
-	if (WARN_ON_ONCE(!ci))
-		return -ENOKEY;
-
-	BUILD_BUG_ON(sizeof(ctx) != FSCRYPT_SET_CONTEXT_MAX_SIZE);
-	ctxsize = fscrypt_new_context(&ctx, &ci->ci_policy, ci->ci_nonce);
+	ctxsize = fscrypt_context_for_new_inode(&ctx, inode);
+	if (ctxsize < 0)
+		return ctxsize;
 
 	/*
 	 * This may be the first time the inode number is available, so do any
@@ -689,7 +711,6 @@ int fscrypt_set_context(struct inode *inode, void *fs_data)
 
 		fscrypt_hash_inode_number(ci, mk);
 	}
-
 	return inode->i_sb->s_cop->set_context(inode, &ctx, ctxsize, fs_data);
 }
 EXPORT_SYMBOL_GPL(fscrypt_set_context);
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index b547e1aabb00..a57d2a9869eb 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -148,6 +148,7 @@ int fscrypt_ioctl_get_policy_ex(struct file *filp, void __user *arg);
 int fscrypt_ioctl_get_nonce(struct file *filp, void __user *arg);
 int fscrypt_has_permitted_context(struct inode *parent, struct inode *child);
 int fscrypt_set_context(struct inode *inode, void *fs_data);
+int fscrypt_context_for_new_inode(void *ctx, struct inode *inode);
 
 struct fscrypt_dummy_policy {
 	const union fscrypt_policy *policy;
-- 
2.26.2


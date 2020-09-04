Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3517C25DF5F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 18:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgIDQHb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 12:07:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727847AbgIDQFo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:05:44 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92E512083B;
        Fri,  4 Sep 2020 16:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599235544;
        bh=maObR0k26i6l3VCpSdPMc8EVkXArEVCA/NN/0sCTNA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pg9ij8vOQRPizxmWVnptpV6RM0q4rhKsZ+wnI/bN/C9Zh/oLjAjBRCsBA6Ipq1VKr
         fw7x7feDUr4vsdgZJJHr1q0kuUNdf/4JsgTGXl7/na1HMHhErgSyCH1Zmrb1B9L7qr
         9cuwfWAW1HE56YHPlmMY3qT35TsvIIHZmIxLOwIo=
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        ebiggers@kernel.org
Subject: [RFC PATCH v2 04/18] fscrypt: add fscrypt_new_context_from_inode
Date:   Fri,  4 Sep 2020 12:05:23 -0400
Message-Id: <20200904160537.76663-5-jlayton@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200904160537.76663-1-jlayton@kernel.org>
References: <20200904160537.76663-1-jlayton@kernel.org>
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
 fs/crypto/policy.c      | 20 ++++++++++++++++++++
 include/linux/fscrypt.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index c56ad886f7d7..10eddd113a21 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -670,6 +670,26 @@ int fscrypt_set_context(struct inode *inode, void *fs_data)
 }
 EXPORT_SYMBOL_GPL(fscrypt_set_context);
 
+/**
+ * fscrypt_context_from_inode() - fetch the encryption context out of in-core inode
+ * @ctx: where context should be written
+ * @inode: inode from which to fetch context
+ *
+ * Given an in-core prepared, but not-necessarily fully-instantiated inode,
+ * generate an encryption context from its policy and write it to ctx.
+ *
+ * Returns size of the context.
+ */
+int fscrypt_new_context_from_inode(union fscrypt_context *ctx, struct inode *inode)
+{
+	struct fscrypt_info *ci = inode->i_crypt_info;
+
+	BUILD_BUG_ON(sizeof(*ctx) != FSCRYPT_SET_CONTEXT_MAX_SIZE);
+
+	return fscrypt_new_context_from_policy(ctx, &ci->ci_policy, ci->ci_nonce);
+}
+EXPORT_SYMBOL_GPL(fscrypt_new_context_from_inode);
+
 /**
  * fscrypt_set_test_dummy_encryption() - handle '-o test_dummy_encryption'
  * @sb: the filesystem on which test_dummy_encryption is being specified
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 16d673c50448..0ddbd27a2e58 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -157,6 +157,7 @@ int fscrypt_ioctl_get_policy_ex(struct file *filp, void __user *arg);
 int fscrypt_ioctl_get_nonce(struct file *filp, void __user *arg);
 int fscrypt_has_permitted_context(struct inode *parent, struct inode *child);
 int fscrypt_set_context(struct inode *inode, void *fs_data);
+int fscrypt_new_context_from_inode(union fscrypt_context *ctx, struct inode *inode);
 
 struct fscrypt_dummy_context {
 	const union fscrypt_context *ctx;
-- 
2.26.2


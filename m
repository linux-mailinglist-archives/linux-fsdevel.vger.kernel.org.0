Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F22623AFD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Nov 2022 05:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbiKJEgU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Nov 2022 23:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKJEgS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Nov 2022 23:36:18 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F70517A84
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Nov 2022 20:36:16 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id z6so402760qtv.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Nov 2022 20:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=m98HKgMqNEUDgcgEoGIIh7GcWwirLfsfmU0ROZKUP54=;
        b=spuyYn4SNLPdpbsLDW6KucXThJUaXeqfDEChHeavVARmGBey+lyicCELFrIzU74OOw
         v9qze1YDx1ZlFjSVidtrcGrpTUJZ7e/j7vb2okfXVne1OroO67lCo2tJXuApIjY4SPiw
         6jzlIeh8IYdsfLTuP2xNOhFaNHcxlwi3WKfmbs7neuo0hvC0PR+7limkphx5D2tbha5Z
         x3+/kCbro2XT6a3E57Nbv7fYXQnUMo/IQ+wYByebdWq/p9XRK6px4GgIJ5JXJ8ZcJZuq
         heAaoITovt7F1JY7p68ZiTWo17N/ZXhg8pEuonQHsQUjqM4QSyaEk2bpsCdEpiNbw+5p
         SlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m98HKgMqNEUDgcgEoGIIh7GcWwirLfsfmU0ROZKUP54=;
        b=6re+ItHMfH7fIf0/+QTEkZDfLQHv8USMLBxOye88DSCAVNkmNCYtz4Ha4eAYIBf1tR
         iGlWGKt1F1lRLsO3G1mBnptYYXUpJHb7UkBncH70GsusFu19FGUkf/nmeSPAAtagrJ5n
         hv+SJ0c96jvABt6yd69kcJNAUN9octhC1whv2+45B3SpsB8csDlbdNs5rsnTwhZ5oRo2
         KMhlx4SQj47AECj+PPn/Dq+eRv2XB7lFIL5tETLw5C/qWydQj479fmuSI85U1nWCPRat
         hvk5c1OZKizSeRwH1WKPihuTgfriH2YPE8bRcVjroIMN460ZUg1d2CqO3508B8iMj1XM
         MIjA==
X-Gm-Message-State: ACrzQf1yLygOgHu4tr3rfXw3cMnuMCOlKG4dLuN3ftG+4FS9BMXQAKXc
        Z8SWSgV2GcHYuZ/pK544RHH4np1nAtTN
X-Google-Smtp-Source: AMsMyM4Hmi3akg7BxLqwS6mCeLgmCnsoHmfkFFHkiSCJ5SY4BSLuPSYv4iRWgA0PWOAEdwtoh5KJ/A==
X-Received: by 2002:ac8:7fc3:0:b0:3a5:7bec:65ed with SMTP id b3-20020ac87fc3000000b003a57bec65edmr18660122qtk.200.1668054975695;
        Wed, 09 Nov 2022 20:36:15 -0800 (PST)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id w27-20020a05620a0e9b00b006ee949b8051sm11914578qkm.51.2022.11.09.20.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 20:36:15 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH] lsm,fs: fix vfs_getxattr_alloc() return type and caller error paths
Date:   Wed,  9 Nov 2022 23:36:14 -0500
Message-Id: <20221110043614.802364-1-paul@paul-moore.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The vfs_getxattr_alloc() function currently returns a ssize_t value
despite the fact that it only uses int values internally for return
values.  Fix this by converting vfs_getxattr_alloc() to return an
int type and adjust the callers as necessary.  As part of these
caller modifications, some of the callers are fixed to properly free
the xattr value buffer on both success and failure to ensure that
memory is not leaked in the failure case.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 fs/xattr.c                                |  5 +++--
 include/linux/xattr.h                     |  6 +++---
 security/apparmor/domain.c                |  3 +--
 security/commoncap.c                      | 22 ++++++++++------------
 security/integrity/evm/evm_crypto.c       |  5 +++--
 security/integrity/evm/evm_main.c         |  7 +++++--
 security/integrity/ima/ima.h              |  5 +++--
 security/integrity/ima/ima_appraise.c     |  6 +++---
 security/integrity/ima/ima_main.c         |  6 ++++--
 security/integrity/ima/ima_template_lib.c | 11 +++++------
 10 files changed, 40 insertions(+), 36 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 61107b6bbed29..f38fd969b5fcd 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -354,11 +354,12 @@ xattr_getsecurity(struct user_namespace *mnt_userns, struct inode *inode,
  * vfs_getxattr_alloc - allocate memory, if necessary, before calling getxattr
  *
  * Allocate memory, if not already allocated, or re-allocate correct size,
- * before retrieving the extended attribute.
+ * before retrieving the extended attribute.  The xattr value buffer should
+ * always be freed by the caller, even on error.
  *
  * Returns the result of alloc, if failed, or the getxattr operation.
  */
-ssize_t
+int
 vfs_getxattr_alloc(struct user_namespace *mnt_userns, struct dentry *dentry,
 		   const char *name, char **xattr_value, size_t xattr_size,
 		   gfp_t flags)
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index 4c379d23ec6e7..2218a9645b89d 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -68,9 +68,9 @@ int __vfs_removexattr_locked(struct user_namespace *, struct dentry *,
 int vfs_removexattr(struct user_namespace *, struct dentry *, const char *);
 
 ssize_t generic_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size);
-ssize_t vfs_getxattr_alloc(struct user_namespace *mnt_userns,
-			   struct dentry *dentry, const char *name,
-			   char **xattr_value, size_t size, gfp_t flags);
+int vfs_getxattr_alloc(struct user_namespace *mnt_userns,
+		       struct dentry *dentry, const char *name,
+		       char **xattr_value, size_t size, gfp_t flags);
 
 int xattr_supported_namespace(struct inode *inode, const char *prefix);
 
diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index 91689d34d2811..04a818d516047 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -311,10 +311,9 @@ static int aa_xattrs_match(const struct linux_binprm *bprm,
 			   struct aa_profile *profile, unsigned int state)
 {
 	int i;
-	ssize_t size;
 	struct dentry *d;
 	char *value = NULL;
-	int value_size = 0, ret = profile->xattr_count;
+	int size, value_size = 0, ret = profile->xattr_count;
 
 	if (!bprm || !profile->xattr_count)
 		return 0;
diff --git a/security/commoncap.c b/security/commoncap.c
index 5fc8986c3c77c..d4fc890955134 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -350,14 +350,14 @@ static __u32 sansflags(__u32 m)
 	return m & ~VFS_CAP_FLAGS_EFFECTIVE;
 }
 
-static bool is_v2header(size_t size, const struct vfs_cap_data *cap)
+static bool is_v2header(int size, const struct vfs_cap_data *cap)
 {
 	if (size != XATTR_CAPS_SZ_2)
 		return false;
 	return sansflags(le32_to_cpu(cap->magic_etc)) == VFS_CAP_REVISION_2;
 }
 
-static bool is_v3header(size_t size, const struct vfs_cap_data *cap)
+static bool is_v3header(int size, const struct vfs_cap_data *cap)
 {
 	if (size != XATTR_CAPS_SZ_3)
 		return false;
@@ -379,7 +379,7 @@ int cap_inode_getsecurity(struct user_namespace *mnt_userns,
 			  struct inode *inode, const char *name, void **buffer,
 			  bool alloc)
 {
-	int size, ret;
+	int size;
 	kuid_t kroot;
 	u32 nsmagic, magic;
 	uid_t root, mappedroot;
@@ -395,20 +395,18 @@ int cap_inode_getsecurity(struct user_namespace *mnt_userns,
 	dentry = d_find_any_alias(inode);
 	if (!dentry)
 		return -EINVAL;
-
-	size = sizeof(struct vfs_ns_cap_data);
-	ret = (int)vfs_getxattr_alloc(mnt_userns, dentry, XATTR_NAME_CAPS,
-				      &tmpbuf, size, GFP_NOFS);
+	size = vfs_getxattr_alloc(mnt_userns, dentry, XATTR_NAME_CAPS, &tmpbuf,
+				  sizeof(struct vfs_ns_cap_data), GFP_NOFS);
 	dput(dentry);
-
-	if (ret < 0 || !tmpbuf)
-		return ret;
+	/* gcc11 complains if we don't check for !tmpbuf */
+	if (size < 0 || !tmpbuf)
+		goto out_free;
 
 	fs_ns = inode->i_sb->s_user_ns;
 	cap = (struct vfs_cap_data *) tmpbuf;
-	if (is_v2header((size_t) ret, cap)) {
+	if (is_v2header(size, cap)) {
 		root = 0;
-	} else if (is_v3header((size_t) ret, cap)) {
+	} else if (is_v3header(size, cap)) {
 		nscap = (struct vfs_ns_cap_data *) tmpbuf;
 		root = le32_to_cpu(nscap->rootid);
 	} else {
diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index 708de9656bbd2..fa5ff13fa8c97 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -335,14 +335,15 @@ static int evm_is_immutable(struct dentry *dentry, struct inode *inode)
 				(char **)&xattr_data, 0, GFP_NOFS);
 	if (rc <= 0) {
 		if (rc == -ENODATA)
-			return 0;
-		return rc;
+			rc = 0;
+		goto out;
 	}
 	if (xattr_data->type == EVM_XATTR_PORTABLE_DIGSIG)
 		rc = 1;
 	else
 		rc = 0;
 
+out:
 	kfree(xattr_data);
 	return rc;
 }
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 23d484e05e6f2..bce72e80fd123 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -519,14 +519,17 @@ static int evm_xattr_change(struct user_namespace *mnt_userns,
 
 	rc = vfs_getxattr_alloc(&init_user_ns, dentry, xattr_name, &xattr_data,
 				0, GFP_NOFS);
-	if (rc < 0)
-		return 1;
+	if (rc < 0) {
+		rc = 1;
+		goto out;
+	}
 
 	if (rc == xattr_value_len)
 		rc = !!memcmp(xattr_value, xattr_data, rc);
 	else
 		rc = 1;
 
+out:
 	kfree(xattr_data);
 	return rc;
 }
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index be965a8715e4e..03b440921e615 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -326,7 +326,7 @@ enum integrity_status ima_get_cache_status(struct integrity_iint_cache *iint,
 enum hash_algo ima_get_hash_algo(const struct evm_ima_xattr_data *xattr_value,
 				 int xattr_len);
 int ima_read_xattr(struct dentry *dentry,
-		   struct evm_ima_xattr_data **xattr_value);
+		   struct evm_ima_xattr_data **xattr_value, int xattr_len);
 
 #else
 static inline int ima_check_blacklist(struct integrity_iint_cache *iint,
@@ -372,7 +372,8 @@ ima_get_hash_algo(struct evm_ima_xattr_data *xattr_value, int xattr_len)
 }
 
 static inline int ima_read_xattr(struct dentry *dentry,
-				 struct evm_ima_xattr_data **xattr_value)
+				 struct evm_ima_xattr_data **xattr_value,
+				 int xattr_len)
 {
 	return 0;
 }
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 3e0fbbd995342..88ffb15ca0e2e 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -221,12 +221,12 @@ enum hash_algo ima_get_hash_algo(const struct evm_ima_xattr_data *xattr_value,
 }
 
 int ima_read_xattr(struct dentry *dentry,
-		   struct evm_ima_xattr_data **xattr_value)
+		   struct evm_ima_xattr_data **xattr_value, int xattr_len)
 {
-	ssize_t ret;
+	int ret;
 
 	ret = vfs_getxattr_alloc(&init_user_ns, dentry, XATTR_NAME_IMA,
-				 (char **)xattr_value, 0, GFP_NOFS);
+				 (char **)xattr_value, xattr_len, GFP_NOFS);
 	if (ret == -EOPNOTSUPP)
 		ret = 0;
 	return ret;
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 040b03ddc1c77..0226899947d6a 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -293,7 +293,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	/* HASH sets the digital signature and update flags, nothing else */
 	if ((action & IMA_HASH) &&
 	    !(test_bit(IMA_DIGSIG, &iint->atomic_flags))) {
-		xattr_len = ima_read_xattr(file_dentry(file), &xattr_value);
+		xattr_len = ima_read_xattr(file_dentry(file),
+					   &xattr_value, xattr_len);
 		if ((xattr_value && xattr_len > 2) &&
 		    (xattr_value->type == EVM_IMA_XATTR_DIGSIG))
 			set_bit(IMA_DIGSIG, &iint->atomic_flags);
@@ -316,7 +317,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	if ((action & IMA_APPRAISE_SUBMASK) ||
 	    strcmp(template_desc->name, IMA_TEMPLATE_IMA_NAME) != 0) {
 		/* read 'security.ima' */
-		xattr_len = ima_read_xattr(file_dentry(file), &xattr_value);
+		xattr_len = ima_read_xattr(file_dentry(file),
+					   &xattr_value, xattr_len);
 
 		/*
 		 * Read the appended modsig if allowed by the policy, and allow
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 7bf9b15072202..4564faae7d673 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -601,16 +601,15 @@ int ima_eventevmsig_init(struct ima_event_data *event_data,
 	rc = vfs_getxattr_alloc(&init_user_ns, file_dentry(event_data->file),
 				XATTR_NAME_EVM, (char **)&xattr_data, 0,
 				GFP_NOFS);
-	if (rc <= 0)
-		return 0;
-
-	if (xattr_data->type != EVM_XATTR_PORTABLE_DIGSIG) {
-		kfree(xattr_data);
-		return 0;
+	if (rc <= 0 || xattr_data->type != EVM_XATTR_PORTABLE_DIGSIG) {
+		rc = 0;
+		goto out;
 	}
 
 	rc = ima_write_template_field_data((char *)xattr_data, rc, DATA_FMT_HEX,
 					   field_data);
+
+out:
 	kfree(xattr_data);
 	return rc;
 }
-- 
2.38.1


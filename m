Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA084F4CEA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 03:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245517AbiDEXgD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 19:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573562AbiDETWr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 15:22:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B9641F8E;
        Tue,  5 Apr 2022 12:20:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A12BDB81FA8;
        Tue,  5 Apr 2022 19:20:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8913C385A5;
        Tue,  5 Apr 2022 19:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649186444;
        bh=Xo1CqM/m1X0Vn5f0F5v27LeQtnut8KTTWWfaOHTaWOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t3VpB5aNzT1CC7ZDu0JZEN4+bIZMNItmwgKVe8wE+K7cAdlna1208D8npqq7dPRjG
         DGOMrJT93IUEi3ntzN09ioD+Hk0bY/1Xk6xpEkuhk6+z7po2Td1uynTEE0H59v6nvN
         ukQKLoErAW/rVG1pwtZJZVf4uI+inu0k2JBuMsOQsiQmIXIAYlQoBeXphsx8JKD7Rg
         OT7RZZkVIulM5lbIiM5n+LXzCEsxD0/rNhVPNo7gCGPVu/llGgPg+VmfOnKofdUc+2
         c6p4zeFyydyZHiVaiNpdiCFTzB3gQiWbZTaVNiIC2wnTHyD56d10zMH5Yi99Wxzwy3
         s5DvMBGZb21Xw==
From:   Jeff Layton <jlayton@kernel.org>
To:     idryomov@gmail.com, xiubli@redhat.com
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        lhenriques@suse.de
Subject: [PATCH v13 13/59] ceph: fscrypt_auth handling for ceph
Date:   Tue,  5 Apr 2022 15:19:44 -0400
Message-Id: <20220405192030.178326-14-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405192030.178326-1-jlayton@kernel.org>
References: <20220405192030.178326-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Most fscrypt-enabled filesystems store the crypto context in an xattr,
but that's problematic for ceph as xatts are governed by the XATTR cap,
but we really want the crypto context as part of the AUTH cap.

Because of this, the MDS has added two new inode metadata fields:
fscrypt_auth and fscrypt_file. The former is used to hold the crypto
context, and the latter is used to track the real file size.

Parse new fscrypt_auth and fscrypt_file fields in inode traces. For now,
we don't use fscrypt_file, but fscrypt_auth is used to hold the fscrypt
context.

Allow the client to use a setattr request for setting the fscrypt_auth
field. Since this is not a standard setattr request from the VFS, we add
a new field to __ceph_setattr that carries ceph-specific inode attrs.

Have the set_context op do a setattr that sets the fscrypt_auth value,
and get_context just return the contents of that field (since it should
always be available).

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/Makefile             |   1 +
 fs/ceph/acl.c                |   4 +-
 fs/ceph/crypto.c             |  76 ++++++++++++++++++++++++
 fs/ceph/crypto.h             |  36 ++++++++++++
 fs/ceph/inode.c              |  62 ++++++++++++++++++-
 fs/ceph/mds_client.c         | 111 ++++++++++++++++++++++++++++++++---
 fs/ceph/mds_client.h         |   7 +++
 fs/ceph/super.c              |   3 +
 fs/ceph/super.h              |  14 ++++-
 include/linux/ceph/ceph_fs.h |  21 ++++---
 10 files changed, 313 insertions(+), 22 deletions(-)
 create mode 100644 fs/ceph/crypto.c
 create mode 100644 fs/ceph/crypto.h

diff --git a/fs/ceph/Makefile b/fs/ceph/Makefile
index 50c635dc7f71..1f77ca04c426 100644
--- a/fs/ceph/Makefile
+++ b/fs/ceph/Makefile
@@ -12,3 +12,4 @@ ceph-y := super.o inode.o dir.o file.o locks.o addr.o ioctl.o \
 
 ceph-$(CONFIG_CEPH_FSCACHE) += cache.o
 ceph-$(CONFIG_CEPH_FS_POSIX_ACL) += acl.o
+ceph-$(CONFIG_FS_ENCRYPTION) += crypto.o
diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
index f4fc8e0b847c..427724c36316 100644
--- a/fs/ceph/acl.c
+++ b/fs/ceph/acl.c
@@ -139,7 +139,7 @@ int ceph_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 		newattrs.ia_ctime = current_time(inode);
 		newattrs.ia_mode = new_mode;
 		newattrs.ia_valid = ATTR_MODE | ATTR_CTIME;
-		ret = __ceph_setattr(inode, &newattrs);
+		ret = __ceph_setattr(inode, &newattrs, NULL);
 		if (ret)
 			goto out_free;
 	}
@@ -150,7 +150,7 @@ int ceph_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 			newattrs.ia_ctime = old_ctime;
 			newattrs.ia_mode = old_mode;
 			newattrs.ia_valid = ATTR_MODE | ATTR_CTIME;
-			__ceph_setattr(inode, &newattrs);
+			__ceph_setattr(inode, &newattrs, NULL);
 		}
 		goto out_free;
 	}
diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
new file mode 100644
index 000000000000..a513ff373b13
--- /dev/null
+++ b/fs/ceph/crypto.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/ceph/ceph_debug.h>
+#include <linux/xattr.h>
+#include <linux/fscrypt.h>
+
+#include "super.h"
+#include "crypto.h"
+
+static int ceph_crypt_get_context(struct inode *inode, void *ctx, size_t len)
+{
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct ceph_fscrypt_auth *cfa = (struct ceph_fscrypt_auth *)ci->fscrypt_auth;
+	u32 ctxlen;
+
+	/* Non existent or too short? */
+	if (!cfa || (ci->fscrypt_auth_len < (offsetof(struct ceph_fscrypt_auth, cfa_blob) + 1)))
+		return -ENOBUFS;
+
+	/* Some format we don't recognize? */
+	if (le32_to_cpu(cfa->cfa_version) != CEPH_FSCRYPT_AUTH_VERSION)
+		return -ENOBUFS;
+
+	ctxlen = le32_to_cpu(cfa->cfa_blob_len);
+	if (len < ctxlen)
+		return -ERANGE;
+
+	memcpy(ctx, cfa->cfa_blob, ctxlen);
+	return ctxlen;
+}
+
+static int ceph_crypt_set_context(struct inode *inode, const void *ctx, size_t len, void *fs_data)
+{
+	int ret;
+	struct iattr attr = { };
+	struct ceph_iattr cia = { };
+	struct ceph_fscrypt_auth *cfa;
+
+	WARN_ON_ONCE(fs_data);
+
+	if (len > FSCRYPT_SET_CONTEXT_MAX_SIZE)
+		return -EINVAL;
+
+	cfa = kzalloc(sizeof(*cfa), GFP_KERNEL);
+	if (!cfa)
+		return -ENOMEM;
+
+	cfa->cfa_version = cpu_to_le32(CEPH_FSCRYPT_AUTH_VERSION);
+	cfa->cfa_blob_len = cpu_to_le32(len);
+	memcpy(cfa->cfa_blob, ctx, len);
+
+	cia.fscrypt_auth = cfa;
+
+	ret = __ceph_setattr(inode, &attr, &cia);
+	if (ret == 0)
+		inode_set_flags(inode, S_ENCRYPTED, S_ENCRYPTED);
+	kfree(cia.fscrypt_auth);
+	return ret;
+}
+
+static bool ceph_crypt_empty_dir(struct inode *inode)
+{
+	struct ceph_inode_info *ci = ceph_inode(inode);
+
+	return ci->i_rsubdirs + ci->i_rfiles == 1;
+}
+
+static struct fscrypt_operations ceph_fscrypt_ops = {
+	.get_context		= ceph_crypt_get_context,
+	.set_context		= ceph_crypt_set_context,
+	.empty_dir		= ceph_crypt_empty_dir,
+};
+
+void ceph_fscrypt_set_ops(struct super_block *sb)
+{
+	fscrypt_set_ops(sb, &ceph_fscrypt_ops);
+}
diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
new file mode 100644
index 000000000000..6dca674f79b8
--- /dev/null
+++ b/fs/ceph/crypto.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Ceph fscrypt functionality
+ */
+
+#ifndef _CEPH_CRYPTO_H
+#define _CEPH_CRYPTO_H
+
+#include <linux/fscrypt.h>
+
+struct ceph_fscrypt_auth {
+	__le32	cfa_version;
+	__le32	cfa_blob_len;
+	u8	cfa_blob[FSCRYPT_SET_CONTEXT_MAX_SIZE];
+} __packed;
+
+#define CEPH_FSCRYPT_AUTH_VERSION	1
+static inline u32 ceph_fscrypt_auth_len(struct ceph_fscrypt_auth *fa)
+{
+	u32 ctxsize = le32_to_cpu(fa->cfa_blob_len);
+
+	return offsetof(struct ceph_fscrypt_auth, cfa_blob) + ctxsize;
+}
+
+#ifdef CONFIG_FS_ENCRYPTION
+void ceph_fscrypt_set_ops(struct super_block *sb);
+
+#else /* CONFIG_FS_ENCRYPTION */
+
+static inline void ceph_fscrypt_set_ops(struct super_block *sb)
+{
+}
+
+#endif /* CONFIG_FS_ENCRYPTION */
+
+#endif
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 6aba0391070d..2d9bade892cc 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -14,10 +14,12 @@
 #include <linux/random.h>
 #include <linux/sort.h>
 #include <linux/iversion.h>
+#include <linux/fscrypt.h>
 
 #include "super.h"
 #include "mds_client.h"
 #include "cache.h"
+#include "crypto.h"
 #include <linux/ceph/decode.h>
 
 /*
@@ -616,6 +618,10 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
 	INIT_WORK(&ci->i_work, ceph_inode_work);
 	ci->i_work_mask = 0;
 	memset(&ci->i_btime, '\0', sizeof(ci->i_btime));
+#ifdef CONFIG_FS_ENCRYPTION
+	ci->fscrypt_auth = NULL;
+	ci->fscrypt_auth_len = 0;
+#endif
 	return &ci->vfs_inode;
 }
 
@@ -624,6 +630,9 @@ void ceph_free_inode(struct inode *inode)
 	struct ceph_inode_info *ci = ceph_inode(inode);
 
 	kfree(ci->i_symlink);
+#ifdef CONFIG_FS_ENCRYPTION
+	kfree(ci->fscrypt_auth);
+#endif
 	kmem_cache_free(ceph_inode_cachep, ci);
 }
 
@@ -644,6 +653,7 @@ void ceph_evict_inode(struct inode *inode)
 	clear_inode(inode);
 
 	ceph_fscache_unregister_inode_cookie(ci);
+	fscrypt_put_encryption_info(inode);
 
 	__ceph_remove_caps(ci);
 
@@ -1023,6 +1033,16 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 		xattr_blob = NULL;
 	}
 
+#ifdef CONFIG_FS_ENCRYPTION
+	if (iinfo->fscrypt_auth_len && !ci->fscrypt_auth) {
+		ci->fscrypt_auth_len = iinfo->fscrypt_auth_len;
+		ci->fscrypt_auth = iinfo->fscrypt_auth;
+		iinfo->fscrypt_auth = NULL;
+		iinfo->fscrypt_auth_len = 0;
+		inode_set_flags(inode, S_ENCRYPTED, S_ENCRYPTED);
+	}
+#endif
+
 	/* finally update i_version */
 	if (le64_to_cpu(info->version) > ci->i_version)
 		ci->i_version = le64_to_cpu(info->version);
@@ -2079,7 +2099,7 @@ static const struct inode_operations ceph_symlink_iops = {
 	.listxattr = ceph_listxattr,
 };
 
-int __ceph_setattr(struct inode *inode, struct iattr *attr)
+int __ceph_setattr(struct inode *inode, struct iattr *attr, struct ceph_iattr *cia)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	unsigned int ia_valid = attr->ia_valid;
@@ -2119,6 +2139,43 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
 	}
 
 	dout("setattr %p issued %s\n", inode, ceph_cap_string(issued));
+#if IS_ENABLED(CONFIG_FS_ENCRYPTION)
+	if (cia && cia->fscrypt_auth) {
+		u32 len = ceph_fscrypt_auth_len(cia->fscrypt_auth);
+
+		if (len > sizeof(*cia->fscrypt_auth)) {
+			err = -EINVAL;
+			spin_unlock(&ci->i_ceph_lock);
+			goto out;
+		}
+
+		dout("setattr %llx:%llx fscrypt_auth len %u to %u)\n",
+			ceph_vinop(inode), ci->fscrypt_auth_len, len);
+
+		/* It should never be re-set once set */
+		WARN_ON_ONCE(ci->fscrypt_auth);
+
+		if (issued & CEPH_CAP_AUTH_EXCL) {
+			dirtied |= CEPH_CAP_AUTH_EXCL;
+			kfree(ci->fscrypt_auth);
+			ci->fscrypt_auth = (u8 *)cia->fscrypt_auth;
+			ci->fscrypt_auth_len = len;
+		} else if ((issued & CEPH_CAP_AUTH_SHARED) == 0 ||
+			   ci->fscrypt_auth_len != len ||
+			   memcmp(ci->fscrypt_auth, cia->fscrypt_auth, len)) {
+			req->r_fscrypt_auth = cia->fscrypt_auth;
+			mask |= CEPH_SETATTR_FSCRYPT_AUTH;
+			release |= CEPH_CAP_AUTH_SHARED;
+		}
+		cia->fscrypt_auth = NULL;
+	}
+#else
+	if (cia && cia->fscrypt_auth) {
+		err = -EINVAL;
+		spin_unlock(&ci->i_ceph_lock);
+		goto out;
+	}
+#endif /* CONFIG_FS_ENCRYPTION */
 
 	if (ia_valid & ATTR_UID) {
 		dout("setattr %p uid %d -> %d\n", inode,
@@ -2281,6 +2338,7 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
 		req->r_stamp = attr->ia_ctime;
 		err = ceph_mdsc_do_request(mdsc, NULL, req);
 	}
+out:
 	dout("setattr %p result=%d (%s locally, %d remote)\n", inode, err,
 	     ceph_cap_string(dirtied), mask);
 
@@ -2321,7 +2379,7 @@ int ceph_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	    ceph_quota_is_max_bytes_exceeded(inode, attr->ia_size))
 		return -EDQUOT;
 
-	err = __ceph_setattr(inode, attr);
+	err = __ceph_setattr(inode, attr, NULL);
 
 	if (err >= 0 && (attr->ia_valid & ATTR_MODE))
 		err = posix_acl_chmod(&init_user_ns, inode, attr->ia_mode);
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 7aa253be7edc..dcb800675dec 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -15,6 +15,7 @@
 
 #include "super.h"
 #include "mds_client.h"
+#include "crypto.h"
 
 #include <linux/ceph/ceph_features.h>
 #include <linux/ceph/messenger.h>
@@ -184,8 +185,52 @@ static int parse_reply_info_in(void **p, void *end,
 			info->rsnaps = 0;
 		}
 
+		if (struct_v >= 5) {
+			u32 alen;
+
+			ceph_decode_32_safe(p, end, alen, bad);
+
+			while (alen--) {
+				u32 len;
+
+				/* key */
+				ceph_decode_32_safe(p, end, len, bad);
+				ceph_decode_skip_n(p, end, len, bad);
+				/* value */
+				ceph_decode_32_safe(p, end, len, bad);
+				ceph_decode_skip_n(p, end, len, bad);
+			}
+		}
+
+		/* fscrypt flag -- ignore */
+		if (struct_v >= 6)
+			ceph_decode_skip_8(p, end, bad);
+
+		info->fscrypt_auth = NULL;
+		info->fscrypt_auth_len = 0;
+		info->fscrypt_file = NULL;
+		info->fscrypt_file_len = 0;
+		if (struct_v >= 7) {
+			ceph_decode_32_safe(p, end, info->fscrypt_auth_len, bad);
+			if (info->fscrypt_auth_len) {
+				info->fscrypt_auth = kmalloc(info->fscrypt_auth_len, GFP_KERNEL);
+				if (!info->fscrypt_auth)
+					return -ENOMEM;
+				ceph_decode_copy_safe(p, end, info->fscrypt_auth,
+						      info->fscrypt_auth_len, bad);
+			}
+			ceph_decode_32_safe(p, end, info->fscrypt_file_len, bad);
+			if (info->fscrypt_file_len) {
+				info->fscrypt_file = kmalloc(info->fscrypt_file_len, GFP_KERNEL);
+				if (!info->fscrypt_file)
+					return -ENOMEM;
+				ceph_decode_copy_safe(p, end, info->fscrypt_file,
+						      info->fscrypt_file_len, bad);
+			}
+		}
 		*p = end;
 	} else {
+		/* legacy (unversioned) struct */
 		if (features & CEPH_FEATURE_MDS_INLINE_DATA) {
 			ceph_decode_64_safe(p, end, info->inline_version, bad);
 			ceph_decode_32_safe(p, end, info->inline_len, bad);
@@ -650,8 +695,21 @@ static int parse_reply_info(struct ceph_mds_session *s, struct ceph_msg *msg,
 
 static void destroy_reply_info(struct ceph_mds_reply_info_parsed *info)
 {
+	int i;
+
+	kfree(info->diri.fscrypt_auth);
+	kfree(info->diri.fscrypt_file);
+	kfree(info->targeti.fscrypt_auth);
+	kfree(info->targeti.fscrypt_file);
 	if (!info->dir_entries)
 		return;
+
+	for (i = 0; i < info->dir_nr; i++) {
+		struct ceph_mds_reply_dir_entry *rde = info->dir_entries + i;
+
+		kfree(rde->inode.fscrypt_auth);
+		kfree(rde->inode.fscrypt_file);
+	}
 	free_pages((unsigned long)info->dir_entries, get_order(info->dir_buf_size));
 }
 
@@ -889,6 +947,7 @@ void ceph_mdsc_release_request(struct kref *kref)
 	put_cred(req->r_cred);
 	if (req->r_pagelist)
 		ceph_pagelist_release(req->r_pagelist);
+	kfree(req->r_fscrypt_auth);
 	put_request_session(req);
 	ceph_unreserve_caps(req->r_mdsc, &req->r_caps_reservation);
 	WARN_ON_ONCE(!list_empty(&req->r_wait));
@@ -2469,8 +2528,7 @@ static int set_request_path_attr(struct inode *rinode, struct dentry *rdentry,
 	return r;
 }
 
-static void encode_timestamp_and_gids(void **p,
-				      const struct ceph_mds_request *req)
+static void encode_mclientrequest_tail(void **p, const struct ceph_mds_request *req)
 {
 	struct ceph_timespec ts;
 	int i;
@@ -2483,6 +2541,20 @@ static void encode_timestamp_and_gids(void **p,
 	for (i = 0; i < req->r_cred->group_info->ngroups; i++)
 		ceph_encode_64(p, from_kgid(&init_user_ns,
 					    req->r_cred->group_info->gid[i]));
+
+	/* v5: altname (TODO: skip for now) */
+	ceph_encode_32(p, 0);
+
+	/* v6: fscrypt_auth and fscrypt_file */
+	if (req->r_fscrypt_auth) {
+		u32 authlen = ceph_fscrypt_auth_len(req->r_fscrypt_auth);
+
+		ceph_encode_32(p, authlen);
+		ceph_encode_copy(p, req->r_fscrypt_auth, authlen);
+	} else {
+		ceph_encode_32(p, 0);
+	}
+	ceph_encode_32(p, 0); // fscrypt_file for now
 }
 
 /*
@@ -2527,12 +2599,14 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
 		goto out_free1;
 	}
 
+	/* head */
 	len = legacy ? sizeof(*head) : sizeof(struct ceph_mds_request_head);
-	len += pathlen1 + pathlen2 + 2*(1 + sizeof(u32) + sizeof(u64)) +
-		sizeof(struct ceph_timespec);
-	len += sizeof(u32) + (sizeof(u64) * req->r_cred->group_info->ngroups);
 
-	/* calculate (max) length for cap releases */
+	/* filepaths */
+	len += 2 * (1 + sizeof(u32) + sizeof(u64));
+	len += pathlen1 + pathlen2;
+
+	/* cap releases */
 	len += sizeof(struct ceph_mds_request_release) *
 		(!!req->r_inode_drop + !!req->r_dentry_drop +
 		 !!req->r_old_inode_drop + !!req->r_old_dentry_drop);
@@ -2542,6 +2616,25 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
 	if (req->r_old_dentry_drop)
 		len += pathlen2;
 
+	/* MClientRequest tail */
+
+	/* req->r_stamp */
+	len += sizeof(struct ceph_timespec);
+
+	/* gid list */
+	len += sizeof(u32) + (sizeof(u64) * req->r_cred->group_info->ngroups);
+
+	/* alternate name */
+	len += sizeof(u32);	// TODO
+
+	/* fscrypt_auth */
+	len += sizeof(u32); // fscrypt_auth
+	if (req->r_fscrypt_auth)
+		len += ceph_fscrypt_auth_len(req->r_fscrypt_auth);
+
+	/* fscrypt_file */
+	len += sizeof(u32);
+
 	msg = ceph_msg_new2(CEPH_MSG_CLIENT_REQUEST, len, 1, GFP_NOFS, false);
 	if (!msg) {
 		msg = ERR_PTR(-ENOMEM);
@@ -2561,7 +2654,7 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
 	} else {
 		struct ceph_mds_request_head *new_head = msg->front.iov_base;
 
-		msg->hdr.version = cpu_to_le16(4);
+		msg->hdr.version = cpu_to_le16(6);
 		new_head->version = cpu_to_le16(CEPH_MDS_REQUEST_HEAD_VERSION);
 		head = (struct ceph_mds_request_head_old *)&new_head->oldest_client_tid;
 		p = msg->front.iov_base + sizeof(*new_head);
@@ -2612,7 +2705,7 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
 
 	head->num_releases = cpu_to_le16(releases);
 
-	encode_timestamp_and_gids(&p, req);
+	encode_mclientrequest_tail(&p, req);
 
 	if (WARN_ON_ONCE(p > end)) {
 		ceph_msg_put(msg);
@@ -2742,7 +2835,7 @@ static int __prepare_send_request(struct ceph_mds_session *session,
 		rhead->num_releases = 0;
 
 		p = msg->front.iov_base + req->r_request_release_offset;
-		encode_timestamp_and_gids(&p, req);
+		encode_mclientrequest_tail(&p, req);
 
 		msg->front.iov_len = p - msg->front.iov_base;
 		msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 2e945979a2e0..aab3ab284fce 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -88,6 +88,10 @@ struct ceph_mds_reply_info_in {
 	s32 dir_pin;
 	struct ceph_timespec btime;
 	struct ceph_timespec snap_btime;
+	u8 *fscrypt_auth;
+	u8 *fscrypt_file;
+	u32 fscrypt_auth_len;
+	u32 fscrypt_file_len;
 	u64 rsnaps;
 	u64 change_attr;
 };
@@ -280,6 +284,9 @@ struct ceph_mds_request {
 	struct mutex r_fill_mutex;
 
 	union ceph_mds_request_args r_args;
+
+	struct ceph_fscrypt_auth *r_fscrypt_auth;
+
 	int r_fmode;        /* file mode, if expecting cap */
 	int r_request_release_offset;
 	const struct cred *r_cred;
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 26d924dda721..1f52fc5b89bd 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -20,6 +20,7 @@
 #include "super.h"
 #include "mds_client.h"
 #include "cache.h"
+#include "crypto.h"
 
 #include <linux/ceph/ceph_features.h>
 #include <linux/ceph/decode.h>
@@ -1129,6 +1130,8 @@ static int ceph_set_super(struct super_block *s, struct fs_context *fc)
 	s->s_time_min = 0;
 	s->s_time_max = U32_MAX;
 
+	ceph_fscrypt_set_ops(s);
+
 	ret = set_anon_super_fc(s, fc);
 	if (ret != 0)
 		fsc->sb = NULL;
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 9eaaab34baae..a4dc7b81a6a4 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -434,6 +434,13 @@ struct ceph_inode_info {
 
 	struct work_struct i_work;
 	unsigned long  i_work_mask;
+
+#ifdef CONFIG_FS_ENCRYPTION
+	u32 fscrypt_auth_len;
+	u32 fscrypt_file_len;
+	u8 *fscrypt_auth;
+	u8 *fscrypt_file;
+#endif
 };
 
 static inline struct ceph_inode_info *
@@ -1038,7 +1045,12 @@ static inline int ceph_do_getattr(struct inode *inode, int mask, bool force)
 }
 extern int ceph_permission(struct user_namespace *mnt_userns,
 			   struct inode *inode, int mask);
-extern int __ceph_setattr(struct inode *inode, struct iattr *attr);
+
+struct ceph_iattr {
+	struct ceph_fscrypt_auth	*fscrypt_auth;
+};
+
+extern int __ceph_setattr(struct inode *inode, struct iattr *attr, struct ceph_iattr *cia);
 extern int ceph_setattr(struct user_namespace *mnt_userns,
 			struct dentry *dentry, struct iattr *attr);
 extern int ceph_getattr(struct user_namespace *mnt_userns,
diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
index 86bf82dbd8b8..2810b214fa3f 100644
--- a/include/linux/ceph/ceph_fs.h
+++ b/include/linux/ceph/ceph_fs.h
@@ -359,14 +359,19 @@ enum {
 
 extern const char *ceph_mds_op_name(int op);
 
-
-#define CEPH_SETATTR_MODE   1
-#define CEPH_SETATTR_UID    2
-#define CEPH_SETATTR_GID    4
-#define CEPH_SETATTR_MTIME  8
-#define CEPH_SETATTR_ATIME 16
-#define CEPH_SETATTR_SIZE  32
-#define CEPH_SETATTR_CTIME 64
+#define CEPH_SETATTR_MODE              (1 << 0)
+#define CEPH_SETATTR_UID               (1 << 1)
+#define CEPH_SETATTR_GID               (1 << 2)
+#define CEPH_SETATTR_MTIME             (1 << 3)
+#define CEPH_SETATTR_ATIME             (1 << 4)
+#define CEPH_SETATTR_SIZE              (1 << 5)
+#define CEPH_SETATTR_CTIME             (1 << 6)
+#define CEPH_SETATTR_MTIME_NOW         (1 << 7)
+#define CEPH_SETATTR_ATIME_NOW         (1 << 8)
+#define CEPH_SETATTR_BTIME             (1 << 9)
+#define CEPH_SETATTR_KILL_SGUID        (1 << 10)
+#define CEPH_SETATTR_FSCRYPT_AUTH      (1 << 11)
+#define CEPH_SETATTR_FSCRYPT_FILE      (1 << 12)
 
 /*
  * Ceph setxattr request flags.
-- 
2.35.1


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E43235E570
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 19:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345427AbhDMRvV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 13:51:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:44794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347380AbhDMRvR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 13:51:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A81D9613BA;
        Tue, 13 Apr 2021 17:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618336257;
        bh=zJgsspHgV/PZ9SjBq3awqnVHIWmjhnRcwJ/E59Hp29o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i2zMZ/2DwU72tarChJcWDWlmFIr7Bd0ybytYK5cB8DhxOKfe3MwQJyL5+zAEgnf/f
         T2lUTTVNCzYZhZRIwPqzcJW1VmmlihagttsXOekY7niCVkLRsoBZILmN1XUvmQBD0i
         StTtfjClcqAjo8Q0t75oZ9e6Rbq9QtVi6YPCZtyt4I7cKwFLswwDv8zB1eCCcPzaLD
         kjIFBBFr7idRdRxKEs2gyRAbQ7KoHo6+zsXS2Zid3BTtIpvZhwOLxoznXd1/7wmkU6
         00R6romULMNTa/xUYiKCnnPvnrS/PQePqrIBium0nY5QViZV6rHoZETQ/rMu4ahPPk
         zvWibvux97GEA==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        lhenriques@suse.de
Subject: [RFC PATCH v6 05/20] ceph: crypto context handling for ceph
Date:   Tue, 13 Apr 2021 13:50:37 -0400
Message-Id: <20210413175052.163865-6-jlayton@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210413175052.163865-1-jlayton@kernel.org>
References: <20210413175052.163865-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Store the fscrypt context for an inode as an encryption.ctx xattr,
and wire up the fscrypt operations to use it.

Add the decoding for the new fscrypt flag in the inode trace and
set the S_ENCRYPT flag on the inode if it's set.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/Makefile     |  1 +
 fs/ceph/crypto.c     | 42 ++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/crypto.h     | 24 ++++++++++++++++++++++++
 fs/ceph/file.c       |  2 ++
 fs/ceph/inode.c      |  6 ++++++
 fs/ceph/mds_client.c | 20 ++++++++++++++++++++
 fs/ceph/mds_client.h |  1 +
 fs/ceph/super.c      |  3 +++
 fs/ceph/xattr.c      |  5 +++++
 9 files changed, 104 insertions(+)
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
diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
new file mode 100644
index 000000000000..dbe8b60fd1b0
--- /dev/null
+++ b/fs/ceph/crypto.c
@@ -0,0 +1,42 @@
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
+	return __ceph_getxattr(inode, CEPH_XATTR_NAME_ENCRYPTION_CONTEXT, ctx, len);
+}
+
+static int ceph_crypt_set_context(struct inode *inode, const void *ctx, size_t len, void *fs_data)
+{
+	int ret;
+
+	WARN_ON_ONCE(fs_data);
+	ret = __ceph_setxattr(inode, CEPH_XATTR_NAME_ENCRYPTION_CONTEXT, ctx, len, XATTR_CREATE);
+	if (ret == 0)
+		inode_set_flags(inode, S_ENCRYPTED, S_ENCRYPTED);
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
+	.max_namelen		= NAME_MAX,
+};
+
+void ceph_fscrypt_set_ops(struct super_block *sb)
+{
+	fscrypt_set_ops(sb, &ceph_fscrypt_ops);
+}
diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
new file mode 100644
index 000000000000..189bd8424284
--- /dev/null
+++ b/fs/ceph/crypto.h
@@ -0,0 +1,24 @@
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
+#define	CEPH_XATTR_NAME_ENCRYPTION_CONTEXT	"encryption.ctx"
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
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 77fc037d5beb..989d947e81bb 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -595,6 +595,8 @@ static int ceph_finish_async_create(struct inode *dir, struct dentry *dentry,
 	iinfo.xattr_data = xattr_buf;
 	memset(iinfo.xattr_data, 0, iinfo.xattr_len);
 
+	iinfo.fscrypt = IS_ENCRYPTED(dir);
+
 	in.ino = cpu_to_le64(vino.ino);
 	in.snapid = cpu_to_le64(CEPH_NOSNAP);
 	in.version = cpu_to_le64(1);	// ???
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index e1c63adb196d..301bd859957d 100644
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
@@ -569,6 +571,7 @@ void ceph_evict_inode(struct inode *inode)
 	clear_inode(inode);
 
 	ceph_fscache_unregister_inode_cookie(ci);
+	fscrypt_put_encryption_info(inode);
 
 	__ceph_remove_caps(ci);
 
@@ -951,6 +954,9 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 		xattr_blob = NULL;
 	}
 
+	if (iinfo->fscrypt && !IS_ENCRYPTED(inode))
+		inode_set_flags(inode, S_ENCRYPTED, S_ENCRYPTED);
+
 	/* finally update i_version */
 	if (le64_to_cpu(info->version) > ci->i_version)
 		ci->i_version = le64_to_cpu(info->version);
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index e5af591d3bd4..e5efdf7a938e 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -183,6 +183,26 @@ static int parse_reply_info_in(void **p, void *end,
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
+		if (struct_v >= 6)
+			ceph_decode_8_safe(p, end, info->fscrypt, bad);
+
 		*p = end;
 	} else {
 		if (features & CEPH_FEATURE_MDS_INLINE_DATA) {
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 61d67eeef896..1522621d0f7e 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -88,6 +88,7 @@ struct ceph_mds_reply_info_in {
 	s32 dir_pin;
 	struct ceph_timespec btime;
 	struct ceph_timespec snap_btime;
+	bool fscrypt;
 	u64 rsnaps;
 	u64 change_attr;
 };
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 9b1b7f4cfdd4..cdac6ff675e2 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -20,6 +20,7 @@
 #include "super.h"
 #include "mds_client.h"
 #include "cache.h"
+#include "crypto.h"
 
 #include <linux/ceph/ceph_features.h>
 #include <linux/ceph/decode.h>
@@ -988,6 +989,8 @@ static int ceph_set_super(struct super_block *s, struct fs_context *fc)
 	s->s_time_min = 0;
 	s->s_time_max = U32_MAX;
 
+	ceph_fscrypt_set_ops(s);
+
 	ret = set_anon_super_fc(s, fc);
 	if (ret != 0)
 		fsc->sb = NULL;
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 1242db8d3444..997fa35ee507 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -4,6 +4,7 @@
 
 #include "super.h"
 #include "mds_client.h"
+#include "crypto.h"
 
 #include <linux/ceph/decode.h>
 
@@ -1125,6 +1126,10 @@ int __ceph_setxattr(struct inode *inode, const char *name,
 	if (!strncmp(name, XATTR_CEPH_PREFIX, XATTR_CEPH_PREFIX_LEN))
 		goto do_sync_unlocked;
 
+	/* Inform the MDS ASAP if we're setting the encryption context */
+	if (!strcmp(name, CEPH_XATTR_NAME_ENCRYPTION_CONTEXT))
+		goto do_sync_unlocked;
+
 	/* preallocate memory for xattr name, value, index node */
 	err = -ENOMEM;
 	newname = kmemdup(name, name_len + 1, GFP_NOFS);
-- 
2.30.2


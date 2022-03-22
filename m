Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844D64E40F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 15:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237633AbiCVORc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 10:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236536AbiCVOPC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:15:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F6BB5B;
        Tue, 22 Mar 2022 07:13:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30247B81D07;
        Tue, 22 Mar 2022 14:13:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A056C340EE;
        Tue, 22 Mar 2022 14:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647958405;
        bh=u6YBLmHj+6x2HWbXmJH8uXLwZZQy3P06n5/nE2suwLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rY0b5m6u5MFbsi0wpVRuzILy02Nsf/aUaaiJLC0dTmszU9+SDktctvMJPi5ptzgWZ
         HKduxBN7BHcG7MyY4zQWToSKt58xvds+CwMOg1C8v4gMJ2bDyc30KBdiMSXQtSj21e
         OiXIRALZeEct/lF8b3w+z6eha9KhvRq0sZrAwl97HLR60js0sx9vnhvlO/Kj2q2g8d
         Cep5WIIg8bUHaDPM1vj6l3Db5R1vWzlW6M/svtwzBOJCJCirDkWCQ41YLkV8FTMW2c
         ZtAlpIHjEuWJ+UYP9lhgt+iNJqqK00gl5MGcCjSHlbCq+symYA/Y7uMClSMA1e0kUt
         W5FICkZMq3Qhw==
From:   Jeff Layton <jlayton@kernel.org>
To:     idryomov@gmail.com, xiubli@redhat.com
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        lhenriques@suse.de
Subject: [RFC PATCH v11 06/51] ceph: crypto context handling for ceph
Date:   Tue, 22 Mar 2022 10:12:31 -0400
Message-Id: <20220322141316.41325-7-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220322141316.41325-1-jlayton@kernel.org>
References: <20220322141316.41325-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Have set_context do a setattr that sets the fscrypt_auth value, and
get_context just return the contents of that field.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/Makefile |  1 +
 fs/ceph/crypto.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/crypto.h | 29 ++++++++++++++++++
 fs/ceph/inode.c  |  3 ++
 fs/ceph/super.c  |  3 ++
 5 files changed, 112 insertions(+)
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
index 000000000000..6c3831c57c8d
--- /dev/null
+++ b/fs/ceph/crypto.h
@@ -0,0 +1,29 @@
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
+#ifdef CONFIG_FS_ENCRYPTION
+#define CEPH_FSCRYPT_AUTH_VERSION	1
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
index 7547b7de170f..2e0e321a58cb 100644
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
@@ -644,6 +646,7 @@ void ceph_evict_inode(struct inode *inode)
 	clear_inode(inode);
 
 	ceph_fscache_unregister_inode_cookie(ci);
+	fscrypt_put_encryption_info(inode);
 
 	__ceph_remove_caps(ci);
 
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index a859921bbe96..52ff78f0462a 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -20,6 +20,7 @@
 #include "super.h"
 #include "mds_client.h"
 #include "cache.h"
+#include "crypto.h"
 
 #include <linux/ceph/ceph_features.h>
 #include <linux/ceph/decode.h>
@@ -1128,6 +1129,8 @@ static int ceph_set_super(struct super_block *s, struct fs_context *fc)
 	s->s_time_min = 0;
 	s->s_time_max = U32_MAX;
 
+	ceph_fscrypt_set_ops(s);
+
 	ret = set_anon_super_fc(s, fc);
 	if (ret != 0)
 		fsc->sb = NULL;
-- 
2.35.1


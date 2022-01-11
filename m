Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A91148B6B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 20:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350474AbiAKTQZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 14:16:25 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60664 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346195AbiAKTQT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:16:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D43C5B81D0E;
        Tue, 11 Jan 2022 19:16:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 409A8C36AE3;
        Tue, 11 Jan 2022 19:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641928576;
        bh=rshLIGLkSgl5Gih0oNkQZSCF2++Y/JIFYSDjzwcuu74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tavmGHeBr4EQkz+QOIjUAdLEK8FtV0NC1o1hdvfVIAFbPsoDR6h2KywHLGPk33NLc
         ONemzx0d3rcnO9W+jfUrDxwSI5spfpchMRdInLZfc5Hj7ZDr8hILC9XLdRUnIyHdtZ
         J4ATUOe9oN3HCTomQaLrNNLsc5jDFKqGNZQGWNZd1gGXkmQbl4ZHsqTWtMbuPKCK0h
         XMetx6Jnlu70ExBCj4EQd/bp9zGLFqkwK7tduPoWLYIvwJ27lzAuMI9RcBvitqcM4x
         LbMEQhdffpGM3wrT7B8USWvSDO00tMRKJn5l56JKX65aTAdILOQnuJQ7lCD3SwWpTH
         oFC8dTU8oCa9w==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, idryomov@gmail.com
Subject: [RFC PATCH v10 08/48] ceph: add fscrypt_* handling to caps.c
Date:   Tue, 11 Jan 2022 14:15:28 -0500
Message-Id: <20220111191608.88762-9-jlayton@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111191608.88762-1-jlayton@kernel.org>
References: <20220111191608.88762-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/caps.c | 76 +++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 63 insertions(+), 13 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index f2f1e4db7b6b..87ee9766dc2e 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -13,6 +13,7 @@
 #include "super.h"
 #include "mds_client.h"
 #include "cache.h"
+#include "crypto.h"
 #include <linux/ceph/decode.h>
 #include <linux/ceph/messenger.h>
 
@@ -1214,15 +1215,12 @@ struct cap_msg_args {
 	umode_t			mode;
 	bool			inline_data;
 	bool			wake;
+	u32			fscrypt_auth_len;
+	u32			fscrypt_file_len;
+	u8			fscrypt_auth[sizeof(struct ceph_fscrypt_auth)]; // for context
+	u8			fscrypt_file[sizeof(u64)]; // for size
 };
 
-/*
- * cap struct size + flock buffer size + inline version + inline data size +
- * osd_epoch_barrier + oldest_flush_tid
- */
-#define CAP_MSG_SIZE (sizeof(struct ceph_mds_caps) + \
-		      4 + 8 + 4 + 4 + 8 + 4 + 4 + 4 + 8 + 8 + 4)
-
 /* Marshal up the cap msg to the MDS */
 static void encode_cap_msg(struct ceph_msg *msg, struct cap_msg_args *arg)
 {
@@ -1238,7 +1236,7 @@ static void encode_cap_msg(struct ceph_msg *msg, struct cap_msg_args *arg)
 	     arg->size, arg->max_size, arg->xattr_version,
 	     arg->xattr_buf ? (int)arg->xattr_buf->vec.iov_len : 0);
 
-	msg->hdr.version = cpu_to_le16(10);
+	msg->hdr.version = cpu_to_le16(12);
 	msg->hdr.tid = cpu_to_le64(arg->flush_tid);
 
 	fc = msg->front.iov_base;
@@ -1309,6 +1307,21 @@ static void encode_cap_msg(struct ceph_msg *msg, struct cap_msg_args *arg)
 
 	/* Advisory flags (version 10) */
 	ceph_encode_32(&p, arg->flags);
+
+	/* dirstats (version 11) - these are r/o on the client */
+	ceph_encode_64(&p, 0);
+	ceph_encode_64(&p, 0);
+
+#if IS_ENABLED(CONFIG_FS_ENCRYPTION)
+	/* fscrypt_auth and fscrypt_file (version 12) */
+	ceph_encode_32(&p, arg->fscrypt_auth_len);
+	ceph_encode_copy(&p, arg->fscrypt_auth, arg->fscrypt_auth_len);
+	ceph_encode_32(&p, arg->fscrypt_file_len);
+	ceph_encode_copy(&p, arg->fscrypt_file, arg->fscrypt_file_len);
+#else /* CONFIG_FS_ENCRYPTION */
+	ceph_encode_32(&p, 0);
+	ceph_encode_32(&p, 0);
+#endif /* CONFIG_FS_ENCRYPTION */
 }
 
 /*
@@ -1430,8 +1443,37 @@ static void __prep_cap(struct cap_msg_args *arg, struct ceph_cap *cap,
 		}
 	}
 	arg->flags = flags;
+#if IS_ENABLED(CONFIG_FS_ENCRYPTION)
+	if (ci->fscrypt_auth_len &&
+	    WARN_ON_ONCE(ci->fscrypt_auth_len != sizeof(struct ceph_fscrypt_auth))) {
+		/* Don't set this if it isn't right size */
+		arg->fscrypt_auth_len = 0;
+	} else {
+		arg->fscrypt_auth_len = ci->fscrypt_auth_len;
+		memcpy(arg->fscrypt_auth, ci->fscrypt_auth,
+			min_t(size_t, ci->fscrypt_auth_len, sizeof(arg->fscrypt_auth)));
+	}
+	/* FIXME: use this to track "real" size */
+	arg->fscrypt_file_len = 0;
+#endif /* CONFIG_FS_ENCRYPTION */
 }
 
+#define CAP_MSG_FIXED_FIELDS (sizeof(struct ceph_mds_caps) + \
+		      4 + 8 + 4 + 4 + 8 + 4 + 4 + 4 + 8 + 8 + 4 + 8 + 8 + 4 + 4)
+
+#if IS_ENABLED(CONFIG_FS_ENCRYPTION)
+static inline int cap_msg_size(struct cap_msg_args *arg)
+{
+	return CAP_MSG_FIXED_FIELDS + arg->fscrypt_auth_len +
+			arg->fscrypt_file_len;
+}
+#else
+static inline int cap_msg_size(struct cap_msg_args *arg)
+{
+	return CAP_MSG_FIXED_FIELDS;
+}
+#endif /* CONFIG_FS_ENCRYPTION */
+
 /*
  * Send a cap msg on the given inode.
  *
@@ -1442,7 +1484,7 @@ static void __send_cap(struct cap_msg_args *arg, struct ceph_inode_info *ci)
 	struct ceph_msg *msg;
 	struct inode *inode = &ci->vfs_inode;
 
-	msg = ceph_msg_new(CEPH_MSG_CLIENT_CAPS, CAP_MSG_SIZE, GFP_NOFS, false);
+	msg = ceph_msg_new(CEPH_MSG_CLIENT_CAPS, cap_msg_size(arg), GFP_NOFS, false);
 	if (!msg) {
 		pr_err("error allocating cap msg: ino (%llx.%llx) flushing %s tid %llu, requeuing cap.\n",
 		       ceph_vinop(inode), ceph_cap_string(arg->dirty),
@@ -1468,10 +1510,6 @@ static inline int __send_flush_snap(struct inode *inode,
 	struct cap_msg_args	arg;
 	struct ceph_msg		*msg;
 
-	msg = ceph_msg_new(CEPH_MSG_CLIENT_CAPS, CAP_MSG_SIZE, GFP_NOFS, false);
-	if (!msg)
-		return -ENOMEM;
-
 	arg.session = session;
 	arg.ino = ceph_vino(inode).ino;
 	arg.cid = 0;
@@ -1509,6 +1547,18 @@ static inline int __send_flush_snap(struct inode *inode,
 	arg.flags = 0;
 	arg.wake = false;
 
+	/*
+	 * No fscrypt_auth changes from a capsnap. It will need
+	 * to update fscrypt_file on size changes (TODO).
+	 */
+	arg.fscrypt_auth_len = 0;
+	arg.fscrypt_file_len = 0;
+
+	msg = ceph_msg_new(CEPH_MSG_CLIENT_CAPS, cap_msg_size(&arg),
+			   GFP_NOFS, false);
+	if (!msg)
+		return -ENOMEM;
+
 	encode_cap_msg(msg, &arg);
 	ceph_con_send(&arg.session->s_con, msg);
 	return 0;
-- 
2.34.1


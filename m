Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F2846EB91
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 16:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240151AbhLIPki (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 10:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240026AbhLIPkb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:40:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004CFC0617A2;
        Thu,  9 Dec 2021 07:36:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0CB5B82504;
        Thu,  9 Dec 2021 15:36:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6D4C341C7;
        Thu,  9 Dec 2021 15:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639064215;
        bh=JMW8VCQQ17vR5P64p2Hk8SDGIPaQhi5voew4xszVVdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R+lYbBsISxtvOvtdO6O+BcMFC/asr6GZW9vYCZNFgfmywShCPcGaKo1eu7JJ/MGsD
         TK2H1Oj6xr2l8zWf4VzJi1HfWnRTv3ovqWst4+7Ty50gEGN/MMhaSCY9SG3RAz9TXc
         zsae7Wvw0ON2CfZ+J8YUGNYN40NQm28oJa3n/Vhk/8SoXZ+4T/tXs0Eik7E9BvkQvJ
         mjV0E+JeO3lWXMBXkHl+/q/+cowAuHcr/SlC8k8mBUc6i6UEG2DiasjDLDvZVhAWrD
         av1QiJnqMXbItynGXMQqnjkGxNJl10Pq7Kq9sb01mKklb5JoWgAgHWWqTmL+rNVfaL
         zOBrN1dhroS5g==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/36] ceph: add fscrypt_* handling to caps.c
Date:   Thu,  9 Dec 2021 10:36:20 -0500
Message-Id: <20211209153647.58953-10-jlayton@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211209153647.58953-1-jlayton@kernel.org>
References: <20211209153647.58953-1-jlayton@kernel.org>
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
index 7d2fa952cb36..c1332c261b0d 100644
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
2.33.1


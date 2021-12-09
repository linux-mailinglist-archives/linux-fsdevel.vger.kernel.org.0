Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE7946EB94
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 16:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240025AbhLIPki (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 10:40:38 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44892 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240060AbhLIPkd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:40:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1237BB82504;
        Thu,  9 Dec 2021 15:36:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A883C341C3;
        Thu,  9 Dec 2021 15:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639064217;
        bh=vuOecgTtKvgYva2zzb88a0ulMDuai6zN625JxaUdur8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OrpyPpz0Ei3uEh9XAf1glleBUhSJiDXM1K4DBAoawMaxVbXF7tGb9ll3cr5FeSXt7
         Gaq/oANRSR9Z6rMqeRoEBlpa3CJsQx7v+0K/EFVKud6cBXZ7+VNJk01elL1mGbdNKJ
         ASve0nbUyGEnG5drqgpIxmbeqarMA/iOzguMU7Oe4tmYypddo0JTjTL0f+L4JO9IyF
         MXu8oOK7KGAJbWD/cTBXEwALYd/c/SF6pP5KQfaJFYMym2X50PqIrgc3g2iLqHVFRN
         oeq+rpQxGJ+ddfOvTfyAasEf6VGq+aY+2qmhICjjf5zLbYzO3resgzO8IkhWCnpPNj
         FOR9gKXPWkHDQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 12/36] ceph: decode alternate_name in lease info
Date:   Thu,  9 Dec 2021 10:36:23 -0500
Message-Id: <20211209153647.58953-13-jlayton@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211209153647.58953-1-jlayton@kernel.org>
References: <20211209153647.58953-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ceph is a bit different from local filesystems, in that we don't want
to store filenames as raw binary data, since we may also be dealing
with clients that don't support fscrypt.

We could just base64-encode the encrypted filenames, but that could
leave us with filenames longer than NAME_MAX. It turns out that the
MDS doesn't care much about filename length, but the clients do.

To manage this, we've added a new "alternate name" field that can be
optionally added to any dentry that we'll use to store the binary
crypttext of the filename if its base64-encoded value will be longer
than NAME_MAX. When a dentry has one of these names attached, the MDS
will send it along in the lease info, which we can then store for
later usage.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/mds_client.c | 40 ++++++++++++++++++++++++++++++----------
 fs/ceph/mds_client.h | 11 +++++++----
 2 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 34a4f6dbac9d..709f3f654555 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -306,27 +306,44 @@ static int parse_reply_info_dir(void **p, void *end,
 
 static int parse_reply_info_lease(void **p, void *end,
 				  struct ceph_mds_reply_lease **lease,
-				  u64 features)
+				  u64 features, u32 *altname_len, u8 **altname)
 {
+	u8 struct_v;
+	u32 struct_len;
+
 	if (features == (u64)-1) {
-		u8 struct_v, struct_compat;
-		u32 struct_len;
+		u8 struct_compat;
+
 		ceph_decode_8_safe(p, end, struct_v, bad);
 		ceph_decode_8_safe(p, end, struct_compat, bad);
+
 		/* struct_v is expected to be >= 1. we only understand
 		 * encoding whose struct_compat == 1. */
 		if (!struct_v || struct_compat != 1)
 			goto bad;
+
 		ceph_decode_32_safe(p, end, struct_len, bad);
-		ceph_decode_need(p, end, struct_len, bad);
-		end = *p + struct_len;
+	} else {
+		struct_len = sizeof(**lease);
+		*altname_len = 0;
+		*altname = NULL;
 	}
 
-	ceph_decode_need(p, end, sizeof(**lease), bad);
+	ceph_decode_need(p, end, struct_len, bad);
 	*lease = *p;
 	*p += sizeof(**lease);
-	if (features == (u64)-1)
-		*p = end;
+
+	if (features == (u64)-1) {
+		if (struct_v >= 2) {
+			ceph_decode_32_safe(p, end, *altname_len, bad);
+			ceph_decode_need(p, end, *altname_len, bad);
+			*altname = *p;
+			*p += *altname_len;
+		} else {
+			*altname = NULL;
+			*altname_len = 0;
+		}
+	}
 	return 0;
 bad:
 	return -EIO;
@@ -356,7 +373,8 @@ static int parse_reply_info_trace(void **p, void *end,
 		info->dname = *p;
 		*p += info->dname_len;
 
-		err = parse_reply_info_lease(p, end, &info->dlease, features);
+		err = parse_reply_info_lease(p, end, &info->dlease, features,
+					     &info->altname_len, &info->altname);
 		if (err < 0)
 			goto out_bad;
 	}
@@ -423,9 +441,11 @@ static int parse_reply_info_readdir(void **p, void *end,
 		dout("parsed dir dname '%.*s'\n", rde->name_len, rde->name);
 
 		/* dentry lease */
-		err = parse_reply_info_lease(p, end, &rde->lease, features);
+		err = parse_reply_info_lease(p, end, &rde->lease, features,
+					     &rde->altname_len, &rde->altname);
 		if (err)
 			goto out_bad;
+
 		/* inode */
 		err = parse_reply_info_in(p, end, &rde->inode, features);
 		if (err < 0)
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index e7d2c8a1b9c1..128901a847af 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -29,8 +29,8 @@ enum ceph_feature_type {
 	CEPHFS_FEATURE_MULTI_RECONNECT,
 	CEPHFS_FEATURE_DELEG_INO,
 	CEPHFS_FEATURE_METRIC_COLLECT,
-
-	CEPHFS_FEATURE_MAX = CEPHFS_FEATURE_METRIC_COLLECT,
+	CEPHFS_FEATURE_ALTERNATE_NAME,
+	CEPHFS_FEATURE_MAX = CEPHFS_FEATURE_ALTERNATE_NAME,
 };
 
 /*
@@ -45,8 +45,7 @@ enum ceph_feature_type {
 	CEPHFS_FEATURE_MULTI_RECONNECT,		\
 	CEPHFS_FEATURE_DELEG_INO,		\
 	CEPHFS_FEATURE_METRIC_COLLECT,		\
-						\
-	CEPHFS_FEATURE_MAX,			\
+	CEPHFS_FEATURE_ALTERNATE_NAME,		\
 }
 #define CEPHFS_FEATURES_CLIENT_REQUIRED {}
 
@@ -98,7 +97,9 @@ struct ceph_mds_reply_info_in {
 
 struct ceph_mds_reply_dir_entry {
 	char                          *name;
+	u8			      *altname;
 	u32                           name_len;
+	u32			      altname_len;
 	struct ceph_mds_reply_lease   *lease;
 	struct ceph_mds_reply_info_in inode;
 	loff_t			      offset;
@@ -117,7 +118,9 @@ struct ceph_mds_reply_info_parsed {
 	struct ceph_mds_reply_info_in diri, targeti;
 	struct ceph_mds_reply_dirfrag *dirfrag;
 	char                          *dname;
+	u8			      *altname;
 	u32                           dname_len;
+	u32                           altname_len;
 	struct ceph_mds_reply_lease   *dlease;
 
 	/* extra */
-- 
2.33.1


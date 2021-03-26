Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25FC334AD84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Mar 2021 18:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbhCZRcx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Mar 2021 13:32:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:48318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230229AbhCZRch (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Mar 2021 13:32:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 681DD61A13;
        Fri, 26 Mar 2021 17:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616779956;
        bh=MOB3lUzex0arW8xhnrg0Tjc0j91jO80EJ3WeS+U1vVg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n7L5D4RdZs+VhR2kjO1Co2pHXRzJyBc/Y8T/c7n1XfOh9jv+ULSUcpPAB140m++CT
         0OjFSXT1eSuwjsNzz9iDF3HUrR71T+QfDAcmx1kULl/x0M+QiiZuesnR+2wLRL+PFD
         aslQ8AfzCncj0TLd/0wIMiLutmgHP0TJrQ4fIH0V4kJ+tuYmQUE6ubYhft1c2Ik3/7
         zvBsdrfDils1JKTdiikAOOOPTHxYQPXlNpT8JvyUpioLUSXKcKqEdofn5OQQS3Unx4
         80uvOeQsCOJDRtuIYi5vLYYO39oUXQ5LocoU5BEmMS18czQ17lTthRJL1jKs01YK5a
         PVU9mMk9Z3xEg==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v5 11/19] ceph: decode alternate_name in lease info
Date:   Fri, 26 Mar 2021 13:32:19 -0400
Message-Id: <20210326173227.96363-12-jlayton@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210326173227.96363-1-jlayton@kernel.org>
References: <20210326173227.96363-1-jlayton@kernel.org>
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
index 814f74d88748..31a4c9674681 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -256,27 +256,44 @@ static int parse_reply_info_dir(void **p, void *end,
 
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
@@ -306,7 +323,8 @@ static int parse_reply_info_trace(void **p, void *end,
 		info->dname = *p;
 		*p += info->dname_len;
 
-		err = parse_reply_info_lease(p, end, &info->dlease, features);
+		err = parse_reply_info_lease(p, end, &info->dlease, features,
+					     &info->altname_len, &info->altname);
 		if (err < 0)
 			goto out_bad;
 	}
@@ -373,9 +391,11 @@ static int parse_reply_info_readdir(void **p, void *end,
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
index 2b18ea24c650..b6aeca9b241b 100644
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
 
@@ -93,7 +92,9 @@ struct ceph_mds_reply_info_in {
 
 struct ceph_mds_reply_dir_entry {
 	char                          *name;
+	u8			      *altname;
 	u32                           name_len;
+	u32			      altname_len;
 	struct ceph_mds_reply_lease   *lease;
 	struct ceph_mds_reply_info_in inode;
 	loff_t			      offset;
@@ -112,7 +113,9 @@ struct ceph_mds_reply_info_parsed {
 	struct ceph_mds_reply_info_in diri, targeti;
 	struct ceph_mds_reply_dirfrag *dirfrag;
 	char                          *dname;
+	u8			      *altname;
 	u32                           dname_len;
+	u32                           altname_len;
 	struct ceph_mds_reply_lease   *dlease;
 
 	/* extra */
-- 
2.30.2


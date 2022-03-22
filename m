Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A754E405A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 15:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236634AbiCVOPP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 10:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236426AbiCVOPC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:15:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D6C7EB0E;
        Tue, 22 Mar 2022 07:13:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44E95615B3;
        Tue, 22 Mar 2022 14:13:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0714DC340EC;
        Tue, 22 Mar 2022 14:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647958409;
        bh=BeiWjClR9/rWod7wBmw6bmaaS1SjP/iSiCIKrIaSi7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hfdl+d//FDgzlDGY4S134COgJb0shtdyXy+vVu5z2ynWlWscv1u60SiPjyytL8FeQ
         J3D71hbc7fIm/+zgRC1mIzHFf6DNPM0RcdW6VVBZdkMACoiVWGnmiYI+vyeiY3DArE
         J69mE+/NOennDHRhqkKpnTVAKhXXxP0qSDh68crQTA8+/+xN4mWqytm9vCUapIArNx
         /zZ9soJHaz1QdQFVpgbKh5Wln0d+GPjpT55RgKv7XF7RjPPL9WyYzckHjFWXya7uvf
         kQujdnZY1GTAzbvt+wGIE8n8ojmna4Ny/M4raE2H/vkoTLdL69fGHTTijftThC1MZw
         C2iZQ8uKYneuw==
From:   Jeff Layton <jlayton@kernel.org>
To:     idryomov@gmail.com, xiubli@redhat.com
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        lhenriques@suse.de
Subject: [RFC PATCH v11 11/51] ceph: decode alternate_name in lease info
Date:   Tue, 22 Mar 2022 10:12:36 -0400
Message-Id: <20220322141316.41325-12-jlayton@kernel.org>
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
Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 fs/ceph/mds_client.c | 43 +++++++++++++++++++++++++++++++++----------
 fs/ceph/mds_client.h | 11 +++++++----
 2 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 648816eb4228..49ba47baac8e 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -308,27 +308,47 @@ static int parse_reply_info_dir(void **p, void *end,
 
 static int parse_reply_info_lease(void **p, void *end,
 				  struct ceph_mds_reply_lease **lease,
-				  u64 features)
+				  u64 features, u32 *altname_len, u8 **altname)
 {
+	u8 struct_v;
+	u32 struct_len;
+	void *lend;
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
+	lend = *p + struct_len;
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
+	*p = lend;
 	return 0;
 bad:
 	return -EIO;
@@ -358,7 +378,8 @@ static int parse_reply_info_trace(void **p, void *end,
 		info->dname = *p;
 		*p += info->dname_len;
 
-		err = parse_reply_info_lease(p, end, &info->dlease, features);
+		err = parse_reply_info_lease(p, end, &info->dlease, features,
+					     &info->altname_len, &info->altname);
 		if (err < 0)
 			goto out_bad;
 	}
@@ -425,9 +446,11 @@ static int parse_reply_info_readdir(void **p, void *end,
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
index aab3ab284fce..2cc75f9ae7c7 100644
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
@@ -122,7 +123,9 @@ struct ceph_mds_reply_info_parsed {
 	struct ceph_mds_reply_info_in diri, targeti;
 	struct ceph_mds_reply_dirfrag *dirfrag;
 	char                          *dname;
+	u8			      *altname;
 	u32                           dname_len;
+	u32                           altname_len;
 	struct ceph_mds_reply_lease   *dlease;
 	struct ceph_mds_reply_xattr   xattr_info;
 
-- 
2.35.1


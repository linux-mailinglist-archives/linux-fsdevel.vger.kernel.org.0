Return-Path: <linux-fsdevel+bounces-70026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8535DC8E92C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 14:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DD033B6127
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 13:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E75269806;
	Thu, 27 Nov 2025 13:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iQIO59eu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XIpVu4mh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8205C1DEFE8
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 13:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764251209; cv=none; b=NcgycFHzb+/K0kVP+xvuWHilscdl7Ncem562reWx5L946voq1YqUA9A6TsmgialpJJP/PlZ++rnuKMAhyYHBf+zL1LzH0QfdbSjUex132jZpx1El4sH1Bdt113LTLKAU0KMuIRvDyyG4wFsxcNDNysSUsqELFX850J7GzI+imcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764251209; c=relaxed/simple;
	bh=fKwmArmGey7L7GjqjhIl2PDdMy7Xs52/q7vTX4jwf3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TGE7Dp7hHJHElAUFYr/VJRmA9nDGgP1SdwrKTu4lO8oWmlwK/eAXP/2kFJTq3w55XoxhNj6J9gXFYk9L8UpEh+F/IDA829I6TvLbrwlO6M6hmWUtsc18eC+oWGhL1cJr31VC+ZGNF19LEzMnu79KAL4y7ufKgF91cxHVWVHBChc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iQIO59eu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XIpVu4mh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764251206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9fbNVavPneORVV3+5YpE/yBOETNjQuihBvU60uRE+Bk=;
	b=iQIO59eunCPtrAF1x+XfiHhq3Z2ApkNNcVVKx8PGAFLCeBueeLxxCrCVecivgQXPERekzu
	W/AhYJgtmC48PBs0r1N00wdZch7WXj7kiLU4VguusqeSf7E9Tuwp9HNsxHp9QsD4Hs8gb/
	h7TlqGXxjnbo56MkFPk+oz7f6WmHbnI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-uQPa1-5vMwKzjGGTeJTjzQ-1; Thu, 27 Nov 2025 08:46:45 -0500
X-MC-Unique: uQPa1-5vMwKzjGGTeJTjzQ-1
X-Mimecast-MFC-AGG-ID: uQPa1-5vMwKzjGGTeJTjzQ_1764251204
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b2e2342803so161037385a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 05:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764251204; x=1764856004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fbNVavPneORVV3+5YpE/yBOETNjQuihBvU60uRE+Bk=;
        b=XIpVu4mhkJZ4DBKY4L+ZW3l2GonFfHHVlAkSqvMSH643qhMUlI5zpKkS6ZG1S0CpAB
         Jz6OToN4JvKUW1aDoKI9vEz5rE1rJSnKyCNQymziX2TJQy5fcrYH7VQJI9QunJX3zAVa
         E2bqEHO5fIes4U+1a6YhD8y1+9+ORwCha/5ycub/iVGx/2y9udb2zGnge6P94B+gvYzJ
         G2uEGYT9VbN3PfiplQOBPXYPkaHdmqdRk2m6Sl1w74mUIcywvqdSAbURpnL3E2QyM/6v
         g6m2bTA4LALrjqB12Tkgt+iUKAy7sG2ExmigLqdTAqeMx/x35CnXD6CyN4AQiblKHG+E
         7fjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764251204; x=1764856004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9fbNVavPneORVV3+5YpE/yBOETNjQuihBvU60uRE+Bk=;
        b=MS8VxzX798ha+c4Au1bLIjPp8bQKFkNK5Ph5xzbtXmK1zsisc7yBceUroUo3kAjyg1
         uQDIsJmAol5KAXuPrP4t7lVIHcBP30GALf3GFyCqfFYiGJ3HAVfKmNKH5z5C9vppvtTS
         dT6Li8a7A43wAesKn902ZoV9IjDq3HLvFFfFq+g8Xz3JsVGUL3XM7MSQM/OVkgmqJP8e
         w634+Rj5NziGv7mTvpS8rl8CCagsWo2LQd6nYUxq/BJlS2b5iGTdXUe2Wppdm/kQ4xJ0
         Z/4Ho9nr9mdq5IrHJYcXdow9K856y7Pg6o9uTDIBYIaDZMop0PUAHdXVp92OX5vFbSfA
         K6Rw==
X-Forwarded-Encrypted: i=1; AJvYcCVpdn/zKaBTXDilGGRbwWzD8sQbZ/ZXp56pPmwTv78K83eAEpgnlg5b230cMlEOBqcKS+dltY4vuKS5Lvz4@vger.kernel.org
X-Gm-Message-State: AOJu0YyVstoQKi9uCt24CKMIoZpSTdxfNAn9Vbu49r2uO5I2+pUl9srT
	9+oNTa9Kbefs5adOJlHnvy30f20OrXyxlrpC6nt1oZBnbuu0iU1NUYl1CIZAYN/d65p5mkIQZHm
	MuEmfru2dEciykJ7RBnWPApNcEQQ43rqDNjkHbfeSBuUWT3tPZItcZ/jkJqkrpUPlOyw=
X-Gm-Gg: ASbGnctVa+tj8Wk60KMamBIVOXoMbqtLjKP92AAZuQUTRLisjMC8DkicgJxw2oduT+y
	+b18opOkVykwatOnpFsyZOjml2lmGHXb8+yJ1z0dy1aT1/YwX7VJedPyAUc+ID0Ast+Mmx8VpUx
	MK3ZDmtT8d/1cdhHTAiPC8iuUM+CfmWCSES4Xe3/yhCxWAkDxoFKH3bcFbqHUnDFgXCd2IDzwmQ
	/XZl2ZRcHR2qwNccMWXF16nAkjDF9uLcf2INxReYiQLWB+94XNQcVLawdprQkNoi+J3FHyynHea
	1R1whCes/1TXueYjIZKNPBcrw/qu0P0VXpoz8zsQYtOBJRRdhlwH7eKa7j093O8uepi+QTSZtLC
	ZiO2fotIq01fyDBYBzCe14BjJuuivHDBRVBa8MVbl/wM=
X-Received: by 2002:a05:620a:3184:b0:8a0:fb41:7f3c with SMTP id af79cd13be357-8b4ebd702damr1528966785a.27.1764251204437;
        Thu, 27 Nov 2025 05:46:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+vSFs9NfoN4U05k763N5M46hygLmxTKtElLQqpKwIvoJ4HfHTT0i4Emc/2tePiiBuJUuYpg==
X-Received: by 2002:a05:620a:3184:b0:8a0:fb41:7f3c with SMTP id af79cd13be357-8b4ebd702damr1528963585a.27.1764251203953;
        Thu, 27 Nov 2025 05:46:43 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-886524fd33fsm9932946d6.24.2025.11.27.05.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 05:46:43 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	amarkuze@redhat.com,
	vdubeyko@redhat.com
Subject: [PATCH 2/3] ceph: parse subvolume_id from InodeStat v9 and store in inode
Date: Thu, 27 Nov 2025 13:46:19 +0000
Message-Id: <20251127134620.2035796-3-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251127134620.2035796-1-amarkuze@redhat.com>
References: <20251127134620.2035796-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for parsing the subvolume_id field from InodeStat v9 and
storing it in the inode for later use by subvolume metrics tracking.

The subvolume_id identifies which CephFS subvolume an inode belongs to,
enabling per-subvolume I/O metrics collection and reporting.

This patch:
- Adds subvolume_id field to struct ceph_mds_reply_info_in
- Adds i_subvolume_id field to struct ceph_inode_info
- Parses subvolume_id from v9 InodeStat in parse_reply_info_in()
- Adds ceph_inode_set_subvolume() helper to propagate the ID to inodes
- Initializes i_subvolume_id in inode allocation and clears on destroy

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/inode.c      | 19 +++++++++++++++++++
 fs/ceph/mds_client.c |  7 +++++++
 fs/ceph/mds_client.h |  1 +
 fs/ceph/super.h      |  2 ++
 4 files changed, 29 insertions(+)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index a6e260d9e420..c3fb4dac4692 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -638,6 +638,7 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
 
 	ci->i_max_bytes = 0;
 	ci->i_max_files = 0;
+	ci->i_subvolume_id = 0;
 
 	memset(&ci->i_dir_layout, 0, sizeof(ci->i_dir_layout));
 	memset(&ci->i_cached_layout, 0, sizeof(ci->i_cached_layout));
@@ -742,6 +743,8 @@ void ceph_evict_inode(struct inode *inode)
 
 	percpu_counter_dec(&mdsc->metric.total_inodes);
 
+	ci->i_subvolume_id = 0;
+
 	netfs_wait_for_outstanding_io(inode);
 	truncate_inode_pages_final(&inode->i_data);
 	if (inode->i_state & I_PINNING_NETFS_WB)
@@ -873,6 +876,18 @@ int ceph_fill_file_size(struct inode *inode, int issued,
 	return queue_trunc;
 }
 
+void ceph_inode_set_subvolume(struct inode *inode, u64 subvolume_id)
+{
+	struct ceph_inode_info *ci;
+
+	if (!inode || !subvolume_id)
+		return;
+
+	ci = ceph_inode(inode);
+	if (READ_ONCE(ci->i_subvolume_id) != subvolume_id)
+		WRITE_ONCE(ci->i_subvolume_id, subvolume_id);
+}
+
 void ceph_fill_file_time(struct inode *inode, int issued,
 			 u64 time_warp_seq, struct timespec64 *ctime,
 			 struct timespec64 *mtime, struct timespec64 *atime)
@@ -1087,6 +1102,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 	new_issued = ~issued & info_caps;
 
 	__ceph_update_quota(ci, iinfo->max_bytes, iinfo->max_files);
+	ceph_inode_set_subvolume(inode, iinfo->subvolume_id);
 
 #ifdef CONFIG_FS_ENCRYPTION
 	if (iinfo->fscrypt_auth_len &&
@@ -1594,6 +1610,8 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 			goto done;
 		}
 		if (parent_dir) {
+			ceph_inode_set_subvolume(parent_dir,
+						 rinfo->diri.subvolume_id);
 			err = ceph_fill_inode(parent_dir, NULL, &rinfo->diri,
 					      rinfo->dirfrag, session, -1,
 					      &req->r_caps_reservation);
@@ -1682,6 +1700,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 		BUG_ON(!req->r_target_inode);
 
 		in = req->r_target_inode;
+		ceph_inode_set_subvolume(in, rinfo->targeti.subvolume_id);
 		err = ceph_fill_inode(in, req->r_locked_page, &rinfo->targeti,
 				NULL, session,
 				(!test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags) &&
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 32561fc701e5..6f66097f740b 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -105,6 +105,8 @@ static int parse_reply_info_in(void **p, void *end,
 	int err = 0;
 	u8 struct_v = 0;
 
+	info->subvolume_id = 0;
+
 	if (features == (u64)-1) {
 		u32 struct_len;
 		u8 struct_compat;
@@ -243,6 +245,10 @@ static int parse_reply_info_in(void **p, void *end,
 			ceph_decode_skip_n(p, end, v8_struct_len, bad);
 		}
 
+		/* struct_v 9 added subvolume_id */
+		if (struct_v >= 9)
+			ceph_decode_64_safe(p, end, info->subvolume_id, bad);
+
 		*p = end;
 	} else {
 		/* legacy (unversioned) struct */
@@ -3962,6 +3968,7 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 			goto out_err;
 		}
 		req->r_target_inode = in;
+		ceph_inode_set_subvolume(in, rinfo->targeti.subvolume_id);
 	}
 
 	mutex_lock(&session->s_mutex);
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 0428a5eaf28c..bd3690baa65c 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -118,6 +118,7 @@ struct ceph_mds_reply_info_in {
 	u32 fscrypt_file_len;
 	u64 rsnaps;
 	u64 change_attr;
+	u64 subvolume_id;
 };
 
 struct ceph_mds_reply_dir_entry {
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index a1f781c46b41..69069c920683 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -385,6 +385,7 @@ struct ceph_inode_info {
 
 	/* quotas */
 	u64 i_max_bytes, i_max_files;
+	u64 i_subvolume_id;
 
 	s32 i_dir_pin;
 
@@ -1057,6 +1058,7 @@ extern struct inode *ceph_get_inode(struct super_block *sb,
 extern struct inode *ceph_get_snapdir(struct inode *parent);
 extern int ceph_fill_file_size(struct inode *inode, int issued,
 			       u32 truncate_seq, u64 truncate_size, u64 size);
+extern void ceph_inode_set_subvolume(struct inode *inode, u64 subvolume_id);
 extern void ceph_fill_file_time(struct inode *inode, int issued,
 				u64 time_warp_seq, struct timespec64 *ctime,
 				struct timespec64 *mtime,
-- 
2.34.1



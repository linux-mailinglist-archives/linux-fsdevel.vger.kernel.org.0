Return-Path: <linux-fsdevel+bounces-71980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C0643CD9492
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 13:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 89731301BCAA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 12:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C740B33291B;
	Tue, 23 Dec 2025 12:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B2B2L3x8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nMmS+h4t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70901338929
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 12:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766493325; cv=none; b=RSFT1BK0D2ugj/pv3FNL5bWvXcr2/vGxNHMoQ3w0jB1YGFtGnQmkFVW69gjnOd0nsX10FngVVH0/fAzBj08mvi/aXXTQIaYL2gkYUE5ZLUkZHabRGFtF5+IiZdT7qF3d5W23gFmDvi9Pt4lGi0vuqcyTfRNwwRFi1y3Oyj3/XWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766493325; c=relaxed/simple;
	bh=kaqBof1sKgiJIPiV/1INPtCHKMqmsKcOUSYudAkYT+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HFjYfccXVVBRfvoYTz0nH+P56pwt155aUDBHc2S3HxaiHcbnBjU7faP4h5dc4ZSIHczoXQuymLfSLcoDtaq2EIJ71QQC6IRjXWUyVZMSvuByPaeKErTLmDCuUA23H7OIuVOsL4Onp2G47fqX0Cnql6b3DlrLYk+RF7J2p9NeKsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B2B2L3x8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nMmS+h4t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766493322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hqMxPL5XkVhI64/cXZFXyo1vJ+jSBIkFaN8ilwgpRVI=;
	b=B2B2L3x8uJC1tdbaE5cZWWlynRfTYxNcmCd2XI2r/lgYfDoD1iS2tOp/TpNiGiyQS6q1Yd
	fyoTKYrJ53Dndz5EAYwZLy6IsLlzXYrSjadDdHZgIwhc0JBAGK6kRhwm7ENltl1E8dOaHO
	rXVGni+oNWyMEdBCpmbRzZ+OkOalrvw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-icgrAJ0wNeS_yp7ZURAEoA-1; Tue, 23 Dec 2025 07:35:18 -0500
X-MC-Unique: icgrAJ0wNeS_yp7ZURAEoA-1
X-Mimecast-MFC-AGG-ID: icgrAJ0wNeS_yp7ZURAEoA_1766493317
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b8012456296so517864666b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 04:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766493317; x=1767098117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqMxPL5XkVhI64/cXZFXyo1vJ+jSBIkFaN8ilwgpRVI=;
        b=nMmS+h4te88S9H+1hJTi1wj4pzVMbk165LXzWQa8fHIBJ7Pm9ZyQhtG+voD11pvkjN
         UN8FSk/Pj8EKUh+NH1X2MHzt6LZV8H3/FRNKYBWZXxwTjBjhBvweV3BKI0zHQMvQdZ12
         e4Y3Cfp+XW4IxW/yUmnOZ6UeaucQAAXkDF3zaWrS+zemp25NlHaFDHf+5FujPmzVOkNK
         2iKGBeweDSu+3FZ37e6YBBrerW6somYhia6mBPFIGRKXvay+WMoz3dZvgrIbUg1evXfj
         wp+I3iVi5Me4XiAYhK+/+y19v06yVpMXNjse+pyFk/ZAhzsUMLp2OPwJhzpRatUOhXL1
         yxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766493317; x=1767098117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hqMxPL5XkVhI64/cXZFXyo1vJ+jSBIkFaN8ilwgpRVI=;
        b=A9TfrWauj3sTaHCR42CSO6PAW9Awyfuk6uEDk0QInUgdFchkogsmVyW1khF4wnQrG1
         Z/aK5coCINUG6fStjL0UUXySuSg2qopcI/v8OuOv92DRiaYS5ulEZYzkW8g3Yho7ylql
         SKRoWuwHakOwNuKFL6FTFg8ANEFTML8n5Dh/bCwounmEj8rPF9gknRhA7U+acc+0F27W
         pzCAQqbrxmWKqkFkT6cd3OoJUdHkWukhKMhZ7ua6AVNLfa82T87xQB4W2r2Cx+MJBMIp
         LTQPAxXgwueZIw6luIW0s3TvXZ2nRzkrwYPymQh3h5t1+Ma778qtHRBzRX+qIa6xvFQK
         oIXw==
X-Forwarded-Encrypted: i=1; AJvYcCUPZFALHXqThwLhk35N7yqxEdFDk9VCr/njH7C4is5qmgP/QNmFyTfnGadO9ZjQrbMRO0IvLdnh1q/O02TO@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1SVyYmIHP4X8zWBxor5Worzyn6/riCfh6CQX7CkikY8eJKbC5
	shl4Z63jj5Yjrv48zSN/9NsJYsV5L28n5Y61xfpQR1veE/D9rfAbmf/TEmsOLpfFjSjDtDxNVkb
	+nhi5wKnZm3aoKMXOLfR6JbTBQ7ed13UhVT8IQqq1xtRbDnbfBGKAjj3yqhhvCHq7CcI=
X-Gm-Gg: AY/fxX7N01r/rNGwkNBDyIwig7U1LdUjk0PbDLTVC7DDuob6qLBt+isfnO6H8fsGtFJ
	QY/7iWnD22xsXbMk9IBjCoMMtB0f39DuZRWNO8R9gC9yzDCn1Z2WTn57kZJAMr6vJaD37QSM3LZ
	xafLA+KYsip2fieTUjbpbpGL8SL37mW0Xpc7c48MS17BPY6noLHssUv6q7hQffAy5rRgmpNgu7a
	8scDWzxE8OBMNeOEMBhTNz4ZJMEqIIvujLUg/BaNaqTN+Z9r1I/XmGjEavBehP0q9gpkHAw7Tp6
	f7TGoi1kkYEcus6Y+pRLSjwOx9tPMS/O441cSEt8P5igBcttPevIUC3nX0sTtdWPdeGJXvnbdSV
	nDeHCrnsQ3SetHQl8EbRV4K63VkiikJ5jI0jq+ADitas=
X-Received: by 2002:a17:906:c147:b0:b73:6b24:14ba with SMTP id a640c23a62f3a-b8036f31e99mr1390798166b.8.1766493317251;
        Tue, 23 Dec 2025 04:35:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgWe8eXxEiIOXCMyC1LFicRQ8TXqNXrmDQ2idetyZDBM6I0eOtlJ/NAaWd+DTAXovl0Gh6/w==
X-Received: by 2002:a17:906:c147:b0:b73:6b24:14ba with SMTP id a640c23a62f3a-b8036f31e99mr1390794666b.8.1766493316735;
        Tue, 23 Dec 2025 04:35:16 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f13847sm1353357366b.57.2025.12.23.04.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 04:35:16 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	amarkuze@redhat.com,
	vdubeyko@redhat.com
Subject: [PATCH v4 2/3] ceph: parse subvolume_id from InodeStat v9 and store in inode
Date: Tue, 23 Dec 2025 12:35:09 +0000
Message-Id: <20251223123510.796459-3-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251223123510.796459-1-amarkuze@redhat.com>
References: <20251223123510.796459-1-amarkuze@redhat.com>
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
 fs/ceph/inode.c      | 23 +++++++++++++++++++++++
 fs/ceph/mds_client.c |  7 +++++++
 fs/ceph/mds_client.h |  1 +
 fs/ceph/super.h      |  2 ++
 4 files changed, 33 insertions(+)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index a6e260d9e420..835049004047 100644
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
@@ -873,6 +876,22 @@ int ceph_fill_file_size(struct inode *inode, int issued,
 	return queue_trunc;
 }
 
+/*
+ * Set the subvolume ID for an inode. Following the FUSE client convention,
+ * 0 means unknown/unset (MDS only sends non-zero IDs for subvolume inodes).
+ */
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
@@ -1087,6 +1106,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 	new_issued = ~issued & info_caps;
 
 	__ceph_update_quota(ci, iinfo->max_bytes, iinfo->max_files);
+	ceph_inode_set_subvolume(inode, iinfo->subvolume_id);
 
 #ifdef CONFIG_FS_ENCRYPTION
 	if (iinfo->fscrypt_auth_len &&
@@ -1594,6 +1614,8 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 			goto done;
 		}
 		if (parent_dir) {
+			ceph_inode_set_subvolume(parent_dir,
+						 rinfo->diri.subvolume_id);
 			err = ceph_fill_inode(parent_dir, NULL, &rinfo->diri,
 					      rinfo->dirfrag, session, -1,
 					      &req->r_caps_reservation);
@@ -1682,6 +1704,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 		BUG_ON(!req->r_target_inode);
 
 		in = req->r_target_inode;
+		ceph_inode_set_subvolume(in, rinfo->targeti.subvolume_id);
 		err = ceph_fill_inode(in, req->r_locked_page, &rinfo->targeti,
 				NULL, session,
 				(!test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags) &&
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index d7d8178e1f9a..099b8f22683b 100644
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
@@ -251,6 +253,10 @@ static int parse_reply_info_in(void **p, void *end,
 			ceph_decode_skip_n(p, end, v8_struct_len, bad);
 		}
 
+		/* struct_v 9 added subvolume_id */
+		if (struct_v >= 9)
+			ceph_decode_64_safe(p, end, info->subvolume_id, bad);
+
 		*p = end;
 	} else {
 		/* legacy (unversioned) struct */
@@ -3970,6 +3976,7 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
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
index a1f781c46b41..c0372a725960 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -385,6 +385,7 @@ struct ceph_inode_info {
 
 	/* quotas */
 	u64 i_max_bytes, i_max_files;
+	u64 i_subvolume_id;	/* 0 = unknown/unset, matches FUSE client */
 
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



Return-Path: <linux-fsdevel+bounces-70466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3E9C9C0EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 16:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D34F4E48F2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 15:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECC93246F7;
	Tue,  2 Dec 2025 15:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DSWZbSV1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="O5oNi0Nr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58C33246EC
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Dec 2025 15:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764691083; cv=none; b=uvbeoT7GaI+QWbeugNqX3wDUafp67tFOMNMKLzYvQkwjbWC7sTroZuMPrrpv2J9x8kl7/OGCOlAKBV5EHJuF9vA7Auu4edYdjarQwv7970+nvAHproMXmkLup0NPYtywKLm+7ONE2jhUqBsESj/vtxBY0HiFuHhMdcTAaU6f+xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764691083; c=relaxed/simple;
	bh=kaqBof1sKgiJIPiV/1INPtCHKMqmsKcOUSYudAkYT+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TeZBCDBsbeGK1W8tZvnwQ/X93KdWlWJZDMuSrCR3ZuW4MDZ3if+skQoohWWvJUao7vgOzG6SWXIBtiOGE9MMJc0ee7yS3XTE0m2IOtJ26IKqWIbhm+3Zrwp7OK2PLESeRIFuxtpCMT8X9oEENg/RqLCDs1mUBK4Vg8KckmO0CUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DSWZbSV1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=O5oNi0Nr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764691080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hqMxPL5XkVhI64/cXZFXyo1vJ+jSBIkFaN8ilwgpRVI=;
	b=DSWZbSV1eBpwP0VRMEXD/oxOxQB7BQrbaLYOspuA+d3g7F2+/OYrbXhUE30M9J3pUpIvdy
	7Dzg4qUQMr90v0n/m5sHjUAQ3v9U/pLH3mCP5tnc3O2xrmHg8rLr83GFQBqmIIcyOibNqu
	yr+rNnP6WrLknWlhIKjosKgA6PB7/iA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-XKPVJD2yN2-mKC3dRga8pQ-1; Tue, 02 Dec 2025 10:57:59 -0500
X-MC-Unique: XKPVJD2yN2-mKC3dRga8pQ-1
X-Mimecast-MFC-AGG-ID: XKPVJD2yN2-mKC3dRga8pQ_1764691078
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b721aa1dac9so413709166b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 07:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764691078; x=1765295878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqMxPL5XkVhI64/cXZFXyo1vJ+jSBIkFaN8ilwgpRVI=;
        b=O5oNi0Nrv/Hbi5CmfpKkM7jvlR7kBbOvMQ46tWYbxUzWLWP19ORKYG2tEotmptCgHR
         M2jywPCVfFYPEWirzEjVfNrGknK4M+oCrUPPmlTvKL9LV5KAh13/Kf2WgTQsCQZiq84A
         LuytBKsPlosPbESiq4xixaLcCsGDxw4R2/RrSRFEg3+uOqfhCtvKsUBec3AICM5sAQRG
         JJOORgFlKsSz7HC0ids40hQuYK4R5b2zWipJ/wos8ZxGFL/+LLOIv6wz0bdLeO8LGsy6
         0pRVuxGiGclAFbCHsZQYVmBw8zeoSDEaHaD6OAmKoepKPfgYimJnMvORFBCpw7nlMng0
         rJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764691078; x=1765295878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hqMxPL5XkVhI64/cXZFXyo1vJ+jSBIkFaN8ilwgpRVI=;
        b=G/GJcxdlro85o0K/IIKcf/5Fb52IRo5YextyXWd5i2crR3mSk3C5oGBVdmDZgNx+jb
         PSJkFMof1+tyMQon9gl5yf1KtPK1deBYKrBzYi7NfLTcrxUQbY6fxMjL0N1JVOrehcuH
         lslJCDNMtOcXxVWIo3S+C4++vDcDHGPohedje9sbvn3eFre3m7avzfQi/JNu5nObFwKZ
         5n/7OT4bcUfGFV0PKCma6QujHzzypLfvjtKnvqqFH8VtQfLo6ZYx/OGGvPAFYh+yKD6G
         uoWMNLhj+9mJ6bVpPQ7x2younbTwUiucFNh+KxM3/2KgFkTRM+ZC6FBYbBXBY80I/+o1
         wXIA==
X-Forwarded-Encrypted: i=1; AJvYcCVaUEI9Vi1u/SKRocMpFF72KWWa/scdp5s/FP44sZ7zs25jqVzAXxkUaZEIsdmz4CxIn6vlwITHsud7jLYV@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3wCkXARrFUbpzlFkTdANOxEmUp2g9b9DbuWDMqDIdIpIBDBPb
	Vgf2y3R2RPbLXLafo8Z+pwiWRIaAAuVRiULAfeiUimkFt5xQD5x9Za9vUaBuC9Zzi3gYgc9+XzR
	1p0S1a4JMaJLSX9Z3EZntDJCXK5LI28h6KMjwdGa1kiEaLj/ZDPlf6asqRrqz7BW3j2I=
X-Gm-Gg: ASbGncuEPe5eyZbhl6D9Eq4BfXboK425ltJtqhyCRdpzauFQBeeGKXfZic39chXWLzc
	d1DBLyFMLuIqlKpeyJoRWaDFgNMpeWNKSNkiwM3oBVOq4NCH4UDYI4HONAL5vLqUfXiMK7juu76
	p2UGuw5m8pnQ3yk9W7WTJUaSRALPqbGvZLSjFhDRaBWHvrzfVid4Ygo5bqutJ+M6rgaUTlZFm1A
	QoV8UyNB7CzQqg2YN8JW4mVGwXPlZ7D/8bX3Wh3ByKoRWk4rrOKEdNYnAu7kFPL8ApgMUrmguPF
	j53Ba4oIM0VKOg/gWtA/Aa9gbAjLF+Ge55a76g4Vtb0zkhQ6KDJyMZxB801OXWWcvtn8LZJrNLg
	XPrDn7yIbg7a0FDJkRMZlpVAQmG+wHCcjbyifXpvdOHQ=
X-Received: by 2002:a17:907:a089:b0:b07:87f1:fc42 with SMTP id a640c23a62f3a-b79c22a5d8emr397208866b.16.1764691078111;
        Tue, 02 Dec 2025 07:57:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjdZv8KMaBO3zQ+rul0W9hsy3SqTURT4DIGmx3xlCt2vSazqIJsqXecnaknqHe/kMDv+bsSg==
X-Received: by 2002:a17:907:a089:b0:b07:87f1:fc42 with SMTP id a640c23a62f3a-b79c22a5d8emr397206266b.16.1764691077713;
        Tue, 02 Dec 2025 07:57:57 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f59eb3f6sm1520702366b.55.2025.12.02.07.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 07:57:57 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	amarkuze@redhat.com,
	vdubeyko@redhat.com
Subject: [PATCH v2 2/3] ceph: parse subvolume_id from InodeStat v9 and store in inode
Date: Tue,  2 Dec 2025 15:57:49 +0000
Message-Id: <20251202155750.2565696-3-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251202155750.2565696-1-amarkuze@redhat.com>
References: <20251202155750.2565696-1-amarkuze@redhat.com>
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



Return-Path: <linux-fsdevel+bounces-70571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A8EC9FA2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 16:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9A363001065
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 15:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6780F317715;
	Wed,  3 Dec 2025 15:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gIr9SkAO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="h9JApdpM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF2A31329E
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 15:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764776797; cv=none; b=YRPwrxE17iy+gHGH25q9tph66+WW11lYHzuEXfizsxYYA2ptX2oLN8LCAOB9RgQsuEDBJTI2puKaoZNaCeuvEsPLaPteNavSACHz1IblMGbvYDYs4Z25D0fx+TJkKK56lve+CQGDu+9Adpd+RE0/zVlNYdH2AFwv5+EHaqNPlss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764776797; c=relaxed/simple;
	bh=kaqBof1sKgiJIPiV/1INPtCHKMqmsKcOUSYudAkYT+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kdZr7pX12TP9NhgUvchzCLuDSukDbyJNXckD/FpPTCV+mgQu+ajRyJWI2A1sc2dTz9yqAu0qtd5Fc2Pcaz+AjzNy0mySdcPuabvFcUGBqyCTSxH8iZY/+31XWL7lfSl8ev3PuEHsSgDhFpMVNRhInyytRZQOvbPr0xUJBWmvVsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gIr9SkAO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=h9JApdpM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764776794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hqMxPL5XkVhI64/cXZFXyo1vJ+jSBIkFaN8ilwgpRVI=;
	b=gIr9SkAOC1tJsIwxmSxpI4f8lL0mK6r4wkFEE+BJg5OIz3AR8v7we/Blwc5gW83GkE0r0g
	ekuXoqyWkr1dwrJKlnENv6nsrPTC5PS9XOEiM3TX29rWe8Y0mJYbMjWohZxSyMsrLTrLpj
	aIMmv/aiKxSN/62Ndz55e2H+x8HczRA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-ra1XslBTOiWP7YQJzQBbAw-1; Wed, 03 Dec 2025 10:46:33 -0500
X-MC-Unique: ra1XslBTOiWP7YQJzQBbAw-1
X-Mimecast-MFC-AGG-ID: ra1XslBTOiWP7YQJzQBbAw_1764776792
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6418122dd7bso4798297a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Dec 2025 07:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764776792; x=1765381592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqMxPL5XkVhI64/cXZFXyo1vJ+jSBIkFaN8ilwgpRVI=;
        b=h9JApdpMAjt9A2SVtl6bQjB/JBdPkM00cWtc3y0jPBzqbFJ6Urd3KAkWDjZpF8Bh6W
         K22pCOyY9ygHSMNvj326sUQlmv0I0QBpYjnayHuPzyZDtvjcj3RptEjQogDMi9phmkep
         VXiUKI9ZXLsUkDYHgooXH4IKVZoZkMs/VhIPFeSm30lJQ+nAb+9eoYD9YIcHYbjCtsPk
         IT+HdBOUdFTpsGTwE0NzNCWop9ZjC8WeT54Zvqk0pvuiXNvBq3TEcR4CGVvMRSnnfX75
         cQH7ZyGdL4/26gfJoHgyAShmtpmPKqWMsHVRvZgaGB9la0+zKhADPGicaLa3lgX9EUk3
         1dSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764776792; x=1765381592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hqMxPL5XkVhI64/cXZFXyo1vJ+jSBIkFaN8ilwgpRVI=;
        b=iVKqzZTgcg2oncTw7Ip1WxwahUfERpdA6KC8yafaEEhl6rM9eHV8OPgTNXDgpU36h8
         eeGfyoN0YZcYaFzqps1GRJ3lXAftlOtVoocB552+NrkTh4CqGRtVTna8rflTWrzNtfJG
         yUGmcS6AQyOcbqyuQ+Cd6E65IkGfSZ52sLYCCLXBwMryS2M2ct/geTZ3/mjpdCLrMNe0
         Uuj4WpTW6nRLyVHVqVwK8oxQKfPpdatvd5Pyng6vWA3zORtJ6IxOTdjcqX9DQKWvnWtt
         lCdUirvz4jlJE+26SxKm0J1DrrdEBL8Z/8SdJaiUsFnI2f7aQi9g6FYPGl5XQqh2LRTV
         NVPg==
X-Forwarded-Encrypted: i=1; AJvYcCXt1r3YQJwrzjzaJ0fKPUVArAqZJtbVTyOdgm6S9SD/I56mwqWm5lmR4a+z8Fq7vcj5lk0Cglw4kSfov8el@vger.kernel.org
X-Gm-Message-State: AOJu0YytROqd+3gMKOpNPeIIRtuyVn1GvFiBqTbpUYdeqQb7DW80n8Rm
	QDCjjkXu3yPCIRaANT46HN8D4lY14Az6GXaJV1naZhQBtiB5oxgGFXwO2/CAi3Vizax+YC5wBRf
	Zny0gaNoxWxjEWQvVRPVDK8hRCjZAJ+VfQj/GxOhYx7xqyX8cok8HpDzAw0jdwDeYhm4YeqmX8q
	4vgQjA
X-Gm-Gg: ASbGnct8c+VGzsvlP3CB9bt+yqBNFGGGSwlz038Q7/cdi/pPfpDaT0h8lk2frISSvUs
	AG/iEkLnnlkAIjDQ67Wpwapup5Ze0m2bXx9F7aucOboNOdi4G2P9nExlqTKXFAJIsKTv49x1JNN
	74zGMDn1IGA9rn1z3KvDRwl1S+Jk9gyQU/gZEAz0G4hD4+92KtN/dYJOBsuBOMk2kY2TGOt2AKE
	YKOzc+qAlW0SVz6NWRrYFYvbSScX7ETFS8Jtoe4OH3SJSCzemuiYZgT1SAzH9Va9vGEPuhmtMzO
	Unppt8LnVYJfyfjr0gWufoROk44KoGjo6zQB18+iewbOqUSXrOZVRSTj19d1nDqrGSyzvpCK7hs
	KXfocBnHNxgbAqxYdKxbQToUSMIPu08JvnusbYULs5Wg=
X-Received: by 2002:a05:6402:84f:b0:647:8538:fcf4 with SMTP id 4fb4d7f45d1cf-6479c402183mr2555866a12.10.1764776791939;
        Wed, 03 Dec 2025 07:46:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbgSdvrjmqjkHGOvfGSqQXYyZSOpzxGTWL7SvNBNH5DBgcSU9/LOa9pJiQwGUiJC2VskiWsQ==
X-Received: by 2002:a05:6402:84f:b0:647:8538:fcf4 with SMTP id 4fb4d7f45d1cf-6479c402183mr2555811a12.10.1764776791439;
        Wed, 03 Dec 2025 07:46:31 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647510519efsm18529786a12.29.2025.12.03.07.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 07:46:31 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	amarkuze@redhat.com,
	vdubeyko@redhat.com
Subject: [PATCH v3 2/4] ceph: parse subvolume_id from InodeStat v9 and store in inode
Date: Wed,  3 Dec 2025 15:46:23 +0000
Message-Id: <20251203154625.2779153-3-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251203154625.2779153-1-amarkuze@redhat.com>
References: <20251203154625.2779153-1-amarkuze@redhat.com>
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



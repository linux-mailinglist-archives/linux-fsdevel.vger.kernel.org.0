Return-Path: <linux-fsdevel+bounces-70572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0F9C9FB4B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 16:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5C7E30A662F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 15:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FBA31A06C;
	Wed,  3 Dec 2025 15:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gKK6/d+a";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="V+jMRtjw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384183191D0
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 15:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764776803; cv=none; b=gfj6senBH4IrTet8d8g8BrCpkAqcuYhhpEXRWXFhL9ouwV4g0ktho+hafdnez3V8bMDaRJnNjBMMCofaQFbuyZNxaG5f18nMjtrMrMt4n7Y+fdBhxAJoz3K+/P+0V2cY9/YDTEJc/6atDwuVHKUHh3FHYi3iqnoto6Kq1m78rqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764776803; c=relaxed/simple;
	bh=JHdqLQasiSaDsG6hzj7hHSkr4dBFeWMYWdNhHvHfB1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tqE2f94BzDHpUyqct+2XW63jUp8YOJ/jAX0APsaP9ObgooeSZppseWtJdHAtufXCtChJLcxCdaKag7lz7cc1SuI6uwPxhYSj7niuv0nijM81zD91J/ahNycg2OyLqQIKS0kYyn3T/yx2bQVh8U3Q7bbqXqwepouP7HN0/+3sy7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gKK6/d+a; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=V+jMRtjw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764776799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6JXlzybZUGb9ac6rIwGm1Zry8cZ1Wz1VfSxTmScAYOk=;
	b=gKK6/d+a097dEuuaoITV7Fj0Bg4Ys6WTXqQBihDXuKNHHlIIu2ZWVxio9e5f6NA5foeNIZ
	W+Mb3rb6K1RaA4RYt24sinFzKzA0q3R1ohELUJKSs5k5vAtiKJ932rp5wUKeUd9ZoKX8/6
	TfyMTyKeosC/r6ql107FTbr+VbadFgI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-kx-pNgwtOYCxMta5njExzw-1; Wed, 03 Dec 2025 10:46:38 -0500
X-MC-Unique: kx-pNgwtOYCxMta5njExzw-1
X-Mimecast-MFC-AGG-ID: kx-pNgwtOYCxMta5njExzw_1764776797
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-64161017e34so8833256a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Dec 2025 07:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764776797; x=1765381597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JXlzybZUGb9ac6rIwGm1Zry8cZ1Wz1VfSxTmScAYOk=;
        b=V+jMRtjwjtgxuDau7iglYwZ5I+k5poSOu0HIIS/jPzK/CeefS7luBMnBYoLqjn+oPG
         YGpHU4XZFXNE+725HwRZ/FiJnvHifH7mcjDlbgY5SdsL7NNHv/yOH3RD1Awz2Ktxzu3D
         EztitE+2PBaoxlxMnYlsm/jvSg//q2ldlJHJulxp7qviweHw86XkXFh7AoMHOaMrd74P
         y1bGmVOByO/6hYRV3bHZGIPGem4lugk/x5fwhl0oXd2BWug/f8ixdk0/oTq7bRd5XtCB
         vjwVsHxFY2aYLbOgHWlUnQ+wuBHqMJsoK2mKHRRiXS5O6IB0iupYL80DyR/FYlUtKe57
         VTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764776797; x=1765381597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6JXlzybZUGb9ac6rIwGm1Zry8cZ1Wz1VfSxTmScAYOk=;
        b=Y9Yuta/9syUkypF9KL1usBN7bF0XeVmBxTySNycYQA0AtFoPLcAzzC4fGdC6Kdf8Wq
         qn3MNRc+k++LGR5VpPNACUCDuiKn6j+lf3oYMFdcRoruBGRYejYa00vZemVytE+NmYNm
         ts4G79CGHYhXHXz5nQW4H+Ta9q4P3REeOUSzwIN6EG3sSqeVJxhvqlq7ZqWJcffpS7OA
         aVATn+w4t8ZT+TKY7sDIbEBcxFqqECBPxHdpnmLCzzZKdzMeJnHljKoKzeS/M9WmsIyS
         4ys2919m38KGCYa+ozIaeliupZYdSvivzBF6SD4Pb41tuuXAqOt6vzCSQDyIx63nuaXo
         DDig==
X-Forwarded-Encrypted: i=1; AJvYcCWjEbvT5Z2upmkjC6axV7SX7Vw2E+P/urtknbHd30un3aig3LY84dK5+vgWPam6c5nqUjrE3uPy+18WLJw6@vger.kernel.org
X-Gm-Message-State: AOJu0Yxaz2Cu0x0d31Ar8dgzyULc2gO8bTzgmSESusO8Sx1rEsrU/N5d
	TNAn9lR5wBedTbGfk2rn/bWag1Of67LUoibJNTbYYCUZq6FF0aXfuJ/Nrtc5HBqkK4CAqFMpBaT
	xxUzkTn/am8N5l+SwTdKxLjPY0GXbbn/g9P2d9+WONVfduTACRhnzIjTZVt9tCOM9I8c=
X-Gm-Gg: ASbGnctKfmgAhIKco+6EmCEr1cxQ+NJvyKE9oDrtB5aUbXmAaUtun3+mhWunOiYULru
	fCPoKJgL8SED4CXOKHhG0Qso2iz447nYJDrT5EI/72lnIV4TXSGtENpz5qOqYnjSLges18Saqd2
	7ssS/AQieEX5y7yM5YhQYpbT+BmBK+a0tZTPAny4q/i3OrxqQ/Mah4IGoTXl7osdcjEqJYFcQbJ
	KBQ0uK8DXltiJP8RinbgWG7xaza22UqvlRW+qgq72SxWhYx3oyumuiI0imPJb+TPUwxSiRaEG1a
	PvYQeOkMVM5ieB88y+Z2YeQpxQleOwRIPv/v0667RqWrzYYXUAVC14vm6+4xwo/bJzTtZav3BO/
	TzR9890IniJNTIFIHL0BiENPlbDUO3laPPhtC3GFhQIc=
X-Received: by 2002:a05:6402:144a:b0:640:7529:b8c7 with SMTP id 4fb4d7f45d1cf-6479c3d5aacmr2442870a12.1.1764776796710;
        Wed, 03 Dec 2025 07:46:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZoI6jiNPSd0g1kxdlPWFKbFGpywr1JFSRIcjvVBnKTGCBvMHTc9MP/rIdVEkBtr0Ue9uBQw==
X-Received: by 2002:a05:6402:144a:b0:640:7529:b8c7 with SMTP id 4fb4d7f45d1cf-6479c3d5aacmr2442845a12.1.1764776796287;
        Wed, 03 Dec 2025 07:46:36 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647510519efsm18529786a12.29.2025.12.03.07.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 07:46:35 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	amarkuze@redhat.com,
	vdubeyko@redhat.com
Subject: [PATCH v3 4/4] ceph: adding CEPH_SUBVOLUME_ID_NONE
Date: Wed,  3 Dec 2025 15:46:25 +0000
Message-Id: <20251203154625.2779153-5-amarkuze@redhat.com>
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

1. Introduce CEPH_SUBVOLUME_ID_NONE constant (value 0) to make the
   unknown/unset state explicit and self-documenting.

2. Add WARN_ON_ONCE if attempting to change an already-set subvolume_id.
   An inode's subvolume membership is immutable - once created in a
   subvolume, it stays there. Attempting to change it indicates a bug.
---
 fs/ceph/inode.c             | 32 +++++++++++++++++++++++++-------
 fs/ceph/mds_client.c        |  5 +----
 fs/ceph/subvolume_metrics.c |  7 ++++---
 fs/ceph/super.h             | 10 +++++++++-
 4 files changed, 39 insertions(+), 15 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 835049004047..257b3e27b741 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -638,7 +638,7 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
 
 	ci->i_max_bytes = 0;
 	ci->i_max_files = 0;
-	ci->i_subvolume_id = 0;
+	ci->i_subvolume_id = CEPH_SUBVOLUME_ID_NONE;
 
 	memset(&ci->i_dir_layout, 0, sizeof(ci->i_dir_layout));
 	memset(&ci->i_cached_layout, 0, sizeof(ci->i_cached_layout));
@@ -743,7 +743,7 @@ void ceph_evict_inode(struct inode *inode)
 
 	percpu_counter_dec(&mdsc->metric.total_inodes);
 
-	ci->i_subvolume_id = 0;
+	ci->i_subvolume_id = CEPH_SUBVOLUME_ID_NONE;
 
 	netfs_wait_for_outstanding_io(inode);
 	truncate_inode_pages_final(&inode->i_data);
@@ -877,19 +877,37 @@ int ceph_fill_file_size(struct inode *inode, int issued,
 }
 
 /*
- * Set the subvolume ID for an inode. Following the FUSE client convention,
- * 0 means unknown/unset (MDS only sends non-zero IDs for subvolume inodes).
+ * Set the subvolume ID for an inode.
+ *
+ * The subvolume_id identifies which CephFS subvolume this inode belongs to.
+ * CEPH_SUBVOLUME_ID_NONE (0) means unknown/unset - the MDS only sends
+ * non-zero IDs for inodes within subvolumes.
+ *
+ * An inode's subvolume membership is immutable - once an inode is created
+ * in a subvolume, it stays there. Therefore, if we already have a valid
+ * (non-zero) subvolume_id and receive a different one, that indicates a bug.
  */
 void ceph_inode_set_subvolume(struct inode *inode, u64 subvolume_id)
 {
 	struct ceph_inode_info *ci;
+	u64 old;
 
-	if (!inode || !subvolume_id)
+	if (!inode || subvolume_id == CEPH_SUBVOLUME_ID_NONE)
 		return;
 
 	ci = ceph_inode(inode);
-	if (READ_ONCE(ci->i_subvolume_id) != subvolume_id)
-		WRITE_ONCE(ci->i_subvolume_id, subvolume_id);
+	old = READ_ONCE(ci->i_subvolume_id);
+
+	if (old == subvolume_id)
+		return;
+
+	if (old != CEPH_SUBVOLUME_ID_NONE) {
+		/* subvolume_id should not change once set */
+		WARN_ON_ONCE(1);
+		return;
+	}
+
+	WRITE_ONCE(ci->i_subvolume_id, subvolume_id);
 }
 
 void ceph_fill_file_time(struct inode *inode, int issued,
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 2b831f48c844..f2a17e11fcef 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -122,10 +122,7 @@ static int parse_reply_info_in(void **p, void *end,
 	u32 struct_len = 0;
 	struct ceph_client *cl = mdsc ? mdsc->fsc->client : NULL;
 
-	info->subvolume_id = 0;
-	doutc(cl, "subv_metric parse start features=0x%llx\n", features);
-
-	info->subvolume_id = 0;
+	info->subvolume_id = CEPH_SUBVOLUME_ID_NONE;
 
 	if (features == (u64)-1) {
 		ceph_decode_8_safe(p, end, struct_v, bad);
diff --git a/fs/ceph/subvolume_metrics.c b/fs/ceph/subvolume_metrics.c
index 111f6754e609..37cbed5b52c3 100644
--- a/fs/ceph/subvolume_metrics.c
+++ b/fs/ceph/subvolume_metrics.c
@@ -136,8 +136,9 @@ void ceph_subvolume_metrics_record(struct ceph_subvolume_metrics_tracker *tracke
 	struct ceph_subvol_metric_rb_entry *entry, *new_entry = NULL;
 	bool retry = false;
 
-	/* 0 means unknown/unset subvolume (matches FUSE client convention) */
-	if (!READ_ONCE(tracker->enabled) || !subvol_id || !size || !latency_us)
+	/* CEPH_SUBVOLUME_ID_NONE (0) means unknown/unset subvolume */
+	if (!READ_ONCE(tracker->enabled) ||
+	    subvol_id == CEPH_SUBVOLUME_ID_NONE || !size || !latency_us)
 		return;
 
 	do {
@@ -403,7 +404,7 @@ void ceph_subvolume_metrics_record_io(struct ceph_mds_client *mdsc,
 	}
 
 	subvol_id = READ_ONCE(ci->i_subvolume_id);
-	if (!subvol_id) {
+	if (subvol_id == CEPH_SUBVOLUME_ID_NONE) {
 		atomic64_inc(&tracker->record_no_subvol);
 		return;
 	}
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index a03c373efd52..731df0fcbcc8 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -386,7 +386,15 @@ struct ceph_inode_info {
 
 	/* quotas */
 	u64 i_max_bytes, i_max_files;
-	u64 i_subvolume_id;	/* 0 = unknown/unset, matches FUSE client */
+
+	/*
+	 * Subvolume ID this inode belongs to. CEPH_SUBVOLUME_ID_NONE (0)
+	 * means unknown/unset, matching the FUSE client convention.
+	 * Once set to a valid (non-zero) value, it should not change
+	 * during the inode's lifetime.
+	 */
+#define CEPH_SUBVOLUME_ID_NONE 0
+	u64 i_subvolume_id;
 
 	s32 i_dir_pin;
 
-- 
2.34.1



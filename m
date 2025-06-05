Return-Path: <linux-fsdevel+bounces-50750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B378ACF49F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 18:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A5FC3A379C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 16:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABA1275104;
	Thu,  5 Jun 2025 16:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KYyaMaQV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC885272E60
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jun 2025 16:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749142055; cv=none; b=GMBNvxc7B+EnfoCkk7CyYLn6ny/IEz6zuKxTayU2DnPEk7Nq09MvyJaRlnfHSkTs2mqrS01u+QlJFL9slmZXFvPob0tHCp/sozUwK+ij4QaCkpZL++XlaKvAyrRvxnTxx/5eng3/OyCJTaBx6ISnHV5HeOMOfQH65Ng7e0rc93M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749142055; c=relaxed/simple;
	bh=XmHhNssjpSk+ZbQZOhHAGLP+xyBn3DJDo+MV66XLtbw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=ZrMX3qh8sK0u83YpA5TsZLzxEZEQENHmCW5ikzcGPSj9FKFS2C1oKNf1x//CkErplMCkRZELs2nkK/RIu1gRLbyYMbZH4lbwGl/ruLW2tWdgC3K/MwJn+fBW9XRSLIE4KkFLWcD+CTFLwsrHX5qK3wkLPHvfYYTYusnMs5XYtAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=KYyaMaQV; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250605164730epoutp04684d708c66ebb80371c322ac513a54dc~GM22Mfio41969519695epoutp04l
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jun 2025 16:47:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250605164730epoutp04684d708c66ebb80371c322ac513a54dc~GM22Mfio41969519695epoutp04l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1749142050;
	bh=q4/v40AehpwOQQnjSG3msiXZyJm8SE+5iJo1AydbOvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KYyaMaQVOyLwMZYgh15rdD1/PXHC7eDuyFY0brVi1MW1mXoFO7nHehkdYEaSrj7LH
	 HTnrwdumfvR8js+JDAH9afd8NLrUHH82g9e6DYwJTwqpUA/XZ6P8LdgDaoI5J3kB6p
	 8rMSmMHo5IWOzuBz1Tt9szahZiMVbC1ucDnNbkgE=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250605164730epcas5p238d8c521e8bf657bd06ae268a5843dd1~GM21oii-R1244512445epcas5p2A;
	Thu,  5 Jun 2025 16:47:30 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.181]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4bCr343xqzz6B9m5; Thu,  5 Jun
	2025 16:47:28 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250605150743epcas5p11a40e74bba0b8a8f9c24c3ff31051665~GLfuUlI__1133911339epcas5p1z;
	Thu,  5 Jun 2025 15:07:43 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250605150741epsmtip1006507851ce4f841fd5767cd16e9baf9~GLfsl6zWH0257802578epsmtip1D;
	Thu,  5 Jun 2025 15:07:41 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: vincent.fu@samsung.com, jack@suse.cz, anuj1072538@gmail.com,
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org,
	hch@infradead.org, martin.petersen@oracle.com, ebiggers@kernel.org,
	adilger@dilger.ca
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com, Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH for-next v2 1/2] block: introduce pi_size field in
 blk_integrity
Date: Thu,  5 Jun 2025 20:37:28 +0530
Message-Id: <20250605150729.2730-2-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250605150729.2730-1-anuj20.g@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250605150743epcas5p11a40e74bba0b8a8f9c24c3ff31051665
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250605150743epcas5p11a40e74bba0b8a8f9c24c3ff31051665
References: <20250605150729.2730-1-anuj20.g@samsung.com>
	<CGME20250605150743epcas5p11a40e74bba0b8a8f9c24c3ff31051665@epcas5p1.samsung.com>

Introduce a new pi_size field in struct blk_integrity to explicitly
represent the size (in bytes) of the protection information (PI) tuple.
This is a prep patch.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 drivers/nvme/host/core.c | 1 +
 drivers/scsi/sd_dif.c    | 1 +
 include/linux/blkdev.h   | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f69a232a000a..a9a2a0ca9797 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1868,6 +1868,7 @@ static bool nvme_init_integrity(struct nvme_ns_head *head,
 	}
 
 	bi->tuple_size = head->ms;
+	bi->pi_size = head->pi_size;
 	bi->pi_offset = info->pi_offset;
 	return true;
 }
diff --git a/drivers/scsi/sd_dif.c b/drivers/scsi/sd_dif.c
index ae6ce6f5d622..9c39a82298da 100644
--- a/drivers/scsi/sd_dif.c
+++ b/drivers/scsi/sd_dif.c
@@ -53,6 +53,7 @@ void sd_dif_config_host(struct scsi_disk *sdkp, struct queue_limits *lim)
 		bi->flags |= BLK_INTEGRITY_REF_TAG;
 
 	bi->tuple_size = sizeof(struct t10_pi_tuple);
+	bi->pi_size = bi->tuple_size;
 
 	if (dif && type) {
 		bi->flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 332b56f323d9..1ed604b70e0f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -120,6 +120,7 @@ struct blk_integrity {
 	unsigned char				pi_offset;
 	unsigned char				interval_exp;
 	unsigned char				tag_size;
+	unsigned char				pi_size;
 };
 
 typedef unsigned int __bitwise blk_mode_t;
-- 
2.25.1



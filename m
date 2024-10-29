Return-Path: <linux-fsdevel+bounces-33128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C259B4D96
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 16:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AB9FB25274
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 15:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30818198A36;
	Tue, 29 Oct 2024 15:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="CCoMFHMV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92737197A77
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 15:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730215203; cv=none; b=jL4+fkYJSDT6MW6LsfTOwJyMeZmZIazLAQ7iSvdXV7BRlV4i57JwnTebzCV34/B9D5fM2BS69INufjauEHHAN+N8tqA8isd+s0e27b2i8WxFysj6qdlwYydVQ4eAiLv228VX2u7FyXPISoqgvLLuBB7WW7CUkBNveCFJPD4vxW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730215203; c=relaxed/simple;
	bh=I8/Qo8zmSvbDl9OhqTDCEq29os3x4jVXWXNHkXfOpYg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fvrbqzl9ipPdtJIyEjZ4W5uiEq58tWWCHpj06r6RgDOanI4qU6kMquqhqmm2uARWb4PvRBkXNBCscIUnELGCsh/VUjFXWVqv5C+xwo4swdE7X2MvPTU+jxRpCo2AiUbsPgehv5Ks+qIR3llsA+o/5m714Qd3d82E6y5i5lOkCH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=CCoMFHMV; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49T71GKK000853
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 08:20:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=aps8B5vbC0snCPQCS1odsvarjIZlBhTaPnTsg871jzs=; b=CCoMFHMVFLtC
	8TG79XGavrREbxROokffs4StQPUxSVy942Ee4PC6TqUWrkPjxbQSb6or157j9YYm
	JcN5DLuaeS3+ZJFrMrfU6cA+ApxUsUyAj4sq5YuztHEFJCc4cyYCyDx8jRckiSQc
	fslDE+lhnqbUYSckOl+LcV5fdIERSbHFxa72jGQGYfb6DxlQQkx5mW6dVxs/Ayo5
	LfubTbWLFic9jCmlfys5Jc86q+qqi/5nl8RhakEUWAn2AMZ15wlarplWAkIYMwYJ
	zRtW/FhtrT37CA8LuHhRXNTltlYIzt4P35fQ3GsIvdMe1Bud38irtLmseQrSLSmO
	yX1xEkwfUA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42jtxwauub-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 08:20:00 -0700 (PDT)
Received: from twshared26373.08.ash9.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 29 Oct 2024 15:19:47 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 2AD5E14920EAA; Tue, 29 Oct 2024 08:19:44 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <io-uring@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <hch@lst.de>, <joshi.k@samsung.com>,
        <javier.gonz@samsung.com>, <bvanassche@acm.org>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv10 7/9] block: export placement hint feature
Date: Tue, 29 Oct 2024 08:19:20 -0700
Message-ID: <20241029151922.459139-8-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241029151922.459139-1-kbusch@meta.com>
References: <20241029151922.459139-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: zxj2ZgktGwHA3N-wRWY20yQeqnG_OUn5
X-Proofpoint-ORIG-GUID: zxj2ZgktGwHA3N-wRWY20yQeqnG_OUn5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

From: Keith Busch <kbusch@kernel.org>

Add a feature flag for devices that support generic placement hints in
write commands. This is in contrast to data lifetime hints.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-settings.c   | 2 ++
 block/blk-sysfs.c      | 3 +++
 include/linux/blkdev.h | 3 +++
 3 files changed, 8 insertions(+)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 921fb4d334fa4..7e3bb3cec7032 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -518,6 +518,8 @@ int blk_stack_limits(struct queue_limits *t, struct q=
ueue_limits *b,
 		t->features &=3D ~BLK_FEAT_NOWAIT;
 	if (!(b->features & BLK_FEAT_POLL))
 		t->features &=3D ~BLK_FEAT_POLL;
+	if (!(b->features & BLK_FEAT_PLACEMENT_HINTS))
+		t->features &=3D ~BLK_FEAT_PLACEMENT_HINTS;
=20
 	t->flags |=3D (b->flags & BLK_FLAG_MISALIGNED);
=20
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 85f48ca461049..51e0b99c2210a 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -260,6 +260,7 @@ static ssize_t queue_##_name##_show(struct gendisk *d=
isk, char *page)	\
 QUEUE_SYSFS_FEATURE_SHOW(poll, BLK_FEAT_POLL);
 QUEUE_SYSFS_FEATURE_SHOW(fua, BLK_FEAT_FUA);
 QUEUE_SYSFS_FEATURE_SHOW(dax, BLK_FEAT_DAX);
+QUEUE_SYSFS_FEATURE_SHOW(placement_hints, BLK_FEAT_PLACEMENT_HINTS);
=20
 static ssize_t queue_zoned_show(struct gendisk *disk, char *page)
 {
@@ -497,6 +498,7 @@ QUEUE_RW_ENTRY(queue_poll_delay, "io_poll_delay");
 QUEUE_RW_ENTRY(queue_wc, "write_cache");
 QUEUE_RO_ENTRY(queue_fua, "fua");
 QUEUE_RO_ENTRY(queue_dax, "dax");
+QUEUE_RO_ENTRY(queue_placement_hints, "placement_hints");
 QUEUE_RW_ENTRY(queue_io_timeout, "io_timeout");
 QUEUE_RO_ENTRY(queue_virt_boundary_mask, "virt_boundary_mask");
 QUEUE_RO_ENTRY(queue_dma_alignment, "dma_alignment");
@@ -626,6 +628,7 @@ static struct attribute *queue_attrs[] =3D {
 	&queue_wc_entry.attr,
 	&queue_fua_entry.attr,
 	&queue_dax_entry.attr,
+	&queue_placement_hints_entry.attr,
 	&queue_poll_delay_entry.attr,
 	&queue_virt_boundary_mask_entry.attr,
 	&queue_dma_alignment_entry.attr,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 90a19ea889276..c577a607591de 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -333,6 +333,9 @@ typedef unsigned int __bitwise blk_features_t;
 #define BLK_FEAT_RAID_PARTIAL_STRIPES_EXPENSIVE \
 	((__force blk_features_t)(1u << 15))
=20
+/* supports generic write placement hints */
+#define BLK_FEAT_PLACEMENT_HINTS	((__force blk_features_t)(1u << 16))
+
 /*
  * Flags automatically inherited when stacking limits.
  */
--=20
2.43.5



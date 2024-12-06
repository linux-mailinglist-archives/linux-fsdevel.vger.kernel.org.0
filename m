Return-Path: <linux-fsdevel+bounces-36589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 302289E63A9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 02:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62AF716A8F8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 01:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925BF13A888;
	Fri,  6 Dec 2024 01:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="JlMQby/y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190B0193
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 01:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733450007; cv=none; b=uGUYWig3UuilVImp65Qbum49fPXpRv4qFxzFLEHihP/+UHIsIKiYCbVd6cvTs8AU0wJT+yd3Ly8ssD8m+NBAQW34LoAHPkNoyz0oc4U8arU6izdlzrT0gNdi75RrdIseJKqtxrez4qW4INxk6KcZFcrT2Vd5XFIOyF6oXA4Kmyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733450007; c=relaxed/simple;
	bh=TCNBtOVAlz4CYyfyNN08IAP8Ch7Vv7aWrtZDtfmR0VA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MA7poDTr/OsD0ZcFjPNs1XwY8H2JwdUGz9F4B6Hg+m+J63Ny/fdSu/5TLmKMH6GFbMzr1y8JXmalnJpEGcDq3o6dZ9bXgrLqYSubePVCAfbFFTI3bc9uksW0r7BO8NCH6zTlcN8ex1VUUa8JX4C0z9Ri8AnXN0TDZzNzxB28c50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=JlMQby/y; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B603IVD012398
	for <linux-fsdevel@vger.kernel.org>; Thu, 5 Dec 2024 17:53:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=29G8/mCPCEmN9MtdiNCjD+XztU6EWmg+eIHaaiD06/k=; b=JlMQby/y2Eku
	0vOi6Y74b8SkU5qFOYpmibZ40iLDFQjQtwLD/kh5utUz2YnGIm6Dtd5oYNHXY9Wa
	YYsqdHSPlTM7iMhNHS7v8xQD7A2BvAf45tz1fXivx02kPwb53Z2NxXUlmcZ27pT8
	Ie8xCc6MkMv4n39zNh8quAnjpRmfI7lObWGoeMiRgd5gqbt0uEZHpjh1c4a5aAoR
	PDqar0S+MLv0/r5+QBzfosbqH3QLm2LcJ+TktcZMmu9QB5UGeCHwf6T9O5k1zMvy
	klpjONh83Mfy3cbLuJx2OH/PbNWnopQ5+TGXope5tVb7sNQVDwxP2eQ4wLpx/8gL
	1cKePzcb/A==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43bgr8udwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 05 Dec 2024 17:53:24 -0800 (PST)
Received: from twshared32179.32.frc3.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 6 Dec 2024 01:53:22 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 20F4A15B21153; Thu,  5 Dec 2024 17:53:09 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
        <io-uring@vger.kernel.org>
CC: <sagi@grimberg.me>, <asml.silence@gmail.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv11 05/10] block: introduce max_write_streams queue limit
Date: Thu, 5 Dec 2024 17:53:03 -0800
Message-ID: <20241206015308.3342386-6-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241206015308.3342386-1-kbusch@meta.com>
References: <20241206015308.3342386-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: HYZsgXbGcNrnfTjHbVC7ETjYlmKipOBJ
X-Proofpoint-ORIG-GUID: HYZsgXbGcNrnfTjHbVC7ETjYlmKipOBJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01

From: Keith Busch <kbusch@kernel.org>

Drivers with hardware that support write streams need a way to export how
many are available so applications can generically query this.

Signed-off-by: Keith Busch <kbusch@kernel.org>
[hch: renamed hints to streams, removed stacking]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/ABI/stable/sysfs-block | 7 +++++++
 block/blk-sysfs.c                    | 3 +++
 include/linux/blkdev.h               | 9 +++++++++
 3 files changed, 19 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/sta=
ble/sysfs-block
index 0cceb2badc836..f67139b8b8eff 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -506,6 +506,13 @@ Description:
 		[RO] Maximum size in bytes of a single element in a DMA
 		scatter/gather list.
=20
+What:		/sys/block/<disk>/queue/max_write_streams
+Date:		November 2024
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RO] Maximum number of write streams supported, 0 if not
+		supported. If supported, valid values are 1 through
+		max_write_streams, inclusive.
=20
 What:		/sys/block/<disk>/queue/max_segments
 Date:		March 2010
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 4241aea84161c..c514c0cb5e93c 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -104,6 +104,7 @@ QUEUE_SYSFS_LIMIT_SHOW(max_segments)
 QUEUE_SYSFS_LIMIT_SHOW(max_discard_segments)
 QUEUE_SYSFS_LIMIT_SHOW(max_integrity_segments)
 QUEUE_SYSFS_LIMIT_SHOW(max_segment_size)
+QUEUE_SYSFS_LIMIT_SHOW(max_write_streams)
 QUEUE_SYSFS_LIMIT_SHOW(logical_block_size)
 QUEUE_SYSFS_LIMIT_SHOW(physical_block_size)
 QUEUE_SYSFS_LIMIT_SHOW(chunk_sectors)
@@ -446,6 +447,7 @@ QUEUE_RO_ENTRY(queue_max_hw_sectors, "max_hw_sectors_=
kb");
 QUEUE_RO_ENTRY(queue_max_segments, "max_segments");
 QUEUE_RO_ENTRY(queue_max_integrity_segments, "max_integrity_segments");
 QUEUE_RO_ENTRY(queue_max_segment_size, "max_segment_size");
+QUEUE_RO_ENTRY(queue_max_write_streams, "max_write_streams");
 QUEUE_RW_LOAD_MODULE_ENTRY(elv_iosched, "scheduler");
=20
 QUEUE_RO_ENTRY(queue_logical_block_size, "logical_block_size");
@@ -580,6 +582,7 @@ static struct attribute *queue_attrs[] =3D {
 	&queue_max_discard_segments_entry.attr,
 	&queue_max_integrity_segments_entry.attr,
 	&queue_max_segment_size_entry.attr,
+	&queue_max_write_streams_entry.attr,
 	&queue_hw_sector_size_entry.attr,
 	&queue_logical_block_size_entry.attr,
 	&queue_physical_block_size_entry.attr,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 08a727b408164..ce2c3ddda2411 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -399,6 +399,8 @@ struct queue_limits {
 	unsigned short		max_integrity_segments;
 	unsigned short		max_discard_segments;
=20
+	unsigned short		max_write_streams;
+
 	unsigned int		max_open_zones;
 	unsigned int		max_active_zones;
=20
@@ -1240,6 +1242,13 @@ static inline unsigned int bdev_max_segments(struc=
t block_device *bdev)
 	return queue_max_segments(bdev_get_queue(bdev));
 }
=20
+static inline unsigned short bdev_max_write_streams(struct block_device =
*bdev)
+{
+	if (bdev_is_partition(bdev))
+		return 0;
+	return bdev_limits(bdev)->max_write_streams;
+}
+
 static inline unsigned queue_logical_block_size(const struct request_que=
ue *q)
 {
 	return q->limits.logical_block_size;
--=20
2.43.5



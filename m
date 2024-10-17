Return-Path: <linux-fsdevel+bounces-32229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE319A2826
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 18:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28639B296EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 16:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8451DF727;
	Thu, 17 Oct 2024 16:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="IpsQFmON"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C921DF247
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Oct 2024 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729181432; cv=none; b=NyXQxpwnOZpV0SUDw1acMZDIFVB4BisCPZoWWCYCwwfjru+bTOnh4KMEDbyoSj20f2SAFvMB0BSW/m9YGqsN8BenaCLFqZCLdVP8gPy9Ao6EkMdJqlKolekDlAnsebripkFNfTqhuGIWpndbl/hvRS+lCfxTUPywwuA9hOOpyx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729181432; c=relaxed/simple;
	bh=p/pdlwEOz7x4atHfPH22yaUj+cFfP6Ldj5Fdo1PQsAg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RADT/Cb6t6BI5sZxAAmp9noEtqmex66GINA4Qw+PkYDOhz0m1aorrFnshOGou7u2kmDLM2w6E6jXflRiCSBnTF+rwRLswt6JKs4c+Tgq5eM6bVLXERceSRUXeyyW+hl8/LoR8QrPiVr7Ly/ZpLHWi8j29kyUJw5nBwV/py4JshQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=IpsQFmON; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HCgsBF003824
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Oct 2024 09:10:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=8XyX8u59mNjnQPnGrxzikA04q0KGVl3u3qy1AjZng4g=; b=IpsQFmON4IMW
	CH/iLUNJvCbdArXLLYsgLxtHPtSmunWocZc6QSNJUgBUeoJdHYieF6TQTIksvdln
	7Z9xPLofaq/X2vsdEDJpYSB3/+UjVzv4sj2ZUn0QEOT0uF2iekQaLEQyctRrWLdX
	a3qhXO7MdefRTbpkdejv4s7txNh2yjT4sESFXtxiAYfC1fNGbxu4rGibsrBrfYLK
	rKsphDuZCxF2Y1Eb+de/UdcJKLurqYJuescb0DpZ73MvSrYZ7iDi+4yWiH1US/Bu
	t5V+xB0T7zDgkhiWoiEfIX1KDgR1Zazem27gFeqbeoJZhg3ePEH9TDn6qMKhn+SC
	6TsjdCIi7g==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42a9tjkbjn-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Oct 2024 09:10:30 -0700 (PDT)
Received: from twshared4085.05.ash9.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 17 Oct 2024 16:10:23 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 2C20E143A4AFC; Thu, 17 Oct 2024 09:10:14 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <axboe@kernel.dk>, <hch@lst.de>, <io-uring@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <joshi.k@samsung.com>,
        <javier.gonz@samsung.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv8 4/6] fs: introduce per-io hint support flag
Date: Thu, 17 Oct 2024 09:09:35 -0700
Message-ID: <20241017160937.2283225-5-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241017160937.2283225-1-kbusch@meta.com>
References: <20241017160937.2283225-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: YHfkg_dy8TLaela61ErU-72jN2LnD0b5
X-Proofpoint-GUID: YHfkg_dy8TLaela61ErU-72jN2LnD0b5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01

From: Keith Busch <kbusch@kernel.org>

A block device may support write hints on a per-io basis. The raw block
file operations can effectively use these, but real filesystems are not
ready to make use of this. Provide a file_operations flag to indicate
support, and set it for the block file operations.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/fops.c       | 2 +-
 include/linux/fs.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index d0b16d3975fd6..15a63e26161ea 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -869,7 +869,7 @@ const struct file_operations def_blk_fops =3D {
 	.splice_write	=3D iter_file_splice_write,
 	.fallocate	=3D blkdev_fallocate,
 	.uring_cmd	=3D blkdev_uring_cmd,
-	.fop_flags	=3D FOP_BUFFER_RASYNC,
+	.fop_flags	=3D FOP_BUFFER_RASYNC | FOP_PER_IO_HINTS,
 };
=20
 static __init int blkdev_init(void)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 04e875a37f604..026dc9801dc20 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2117,6 +2117,8 @@ struct file_operations {
 #define FOP_HUGE_PAGES		((__force fop_flags_t)(1 << 4))
 /* Treat loff_t as unsigned (e.g., /dev/mem) */
 #define FOP_UNSIGNED_OFFSET	((__force fop_flags_t)(1 << 5))
+/* File system can handle per-io hints */
+#define FOP_PER_IO_HINTS       ((__force fop_flags_t)(1 << 6))
=20
 /* Wrap a directory iterator that needs exclusive inode access */
 int wrap_directory_iterator(struct file *, struct dir_context *,
--=20
2.43.5



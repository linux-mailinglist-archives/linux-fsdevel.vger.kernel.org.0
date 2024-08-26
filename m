Return-Path: <linux-fsdevel+bounces-27206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F357E95F7B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 19:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA2EF282182
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 17:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B661990A7;
	Mon, 26 Aug 2024 17:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aHNL1THi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E71198A36
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 17:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724692473; cv=none; b=W/w/vewnBEvC9hNrClbFanDBOReORlVcTSKCA23Zhjz+bwnj4Tt5b5nw/ljpCX6/sdf3bNJeoPb9OoCj061g4CZr5NamnfzfGf1MUV+WDNN7pBmCV9PNsZpe5KkVI3V4a3ND0eZeBpzNA59MKvxqe9vU/ohz7hgUt9YCUp4joVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724692473; c=relaxed/simple;
	bh=tWd5IIy35vE30hYu41t/Mbu9amvaqfDTedWn194Fx2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=bh/I9ITbrCUyJzKX/wqyHGXTTzuR87gKjI0ZMdB0W+YQ4QX4VZxbwudS3niCFkyzNWB0filxrSJB/1LrgZyERemSAeNuJUsuB8qWWq809tIpJQrZkV0ILyd0Q+TSxDeb38r7YiGzWYF9qW5FmL+WqPD/K20YxO7KQ3v9Opphtwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=aHNL1THi; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240826171430epoutp0290c3f7c29c2de5d621f8b1a90b47a2f0~vVqn1lh4P2048020480epoutp021
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 17:14:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240826171430epoutp0290c3f7c29c2de5d621f8b1a90b47a2f0~vVqn1lh4P2048020480epoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724692470;
	bh=5tUKFADzd7xUVDEaIuNQBV6ClteUtrL2aFLyNyXedxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aHNL1THiEHhEmCRokdU8knTuvgsSymAyuhlTlxo5pnMmOJ9QY5GJqy5xd8NjKrmgn
	 KtBE6HF40PRjV5pMfG0rW5sqYneCfXRHF+F+KiZVSBS/OeqLDsiro0OHFglZuySsI9
	 GkfJEaG6hifEQRg6/nW1tdlTMPRTmA3NT351UUDA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240826171429epcas5p3d316437e37abe737b9cf1feb46a0bb13~vVqm84GMM2945329453epcas5p33;
	Mon, 26 Aug 2024 17:14:29 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Wsy2q4HHZz4x9Pq; Mon, 26 Aug
	2024 17:14:27 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5D.A0.09640.3F7BCC66; Tue, 27 Aug 2024 02:14:27 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240826171426epcas5p13c5ffabd6a05ee357bf4e9f78bc5de44~vVqkF41jA0279002790epcas5p1G;
	Mon, 26 Aug 2024 17:14:26 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240826171426epsmtrp1c1c4ac8931df3d1325ad85cb6dd79fd8~vVqkE3uYz0078300783epsmtrp1H;
	Mon, 26 Aug 2024 17:14:26 +0000 (GMT)
X-AuditID: b6c32a49-a57ff700000025a8-ad-66ccb7f3091c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F7.B2.07567.1F7BCC66; Tue, 27 Aug 2024 02:14:26 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240826171422epsmtip2e4bb622f4f1ead189d76183395aa4693~vVqgSFzYe0841308413epsmtip2O;
	Mon, 26 Aug 2024 17:14:21 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
	brauner@kernel.org, jack@suse.cz, jaegeuk@kernel.org, jlayton@kernel.org,
	chuck.lever@oracle.com, bvanassche@acm.org
Cc: linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com, vishak.g@samsung.com,
	javier.gonz@samsung.com, Nitesh Shetty <nj.shetty@samsung.com>, Kanchan
	Joshi <joshi.k@samsung.com>
Subject: [PATCH v4 4/5] sd: limit to use write life hints
Date: Mon, 26 Aug 2024 22:36:05 +0530
Message-Id: <20240826170606.255718-5-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240826170606.255718-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0xTZxjOudAe2LodLupHswh0mQY3oJ1t/SAyXEQ9C2ZilhjjlmADBwqU
	tullE3djY8N5qQiCSEHBG0pxMK6iXEQ6JAwoU1AEKbcBRjrGpZuOQehOOXXz3/O+3/O8z/e8
	3zkE5vU7h08kKnW0RilTCDgeeJ05cGOQ/UZXvLBw7A1YZs3kQJt5AYFn5hYx6LA+QeFAy00U
	lpa1obAgLx2FExVGDFZmEvC3ITsXLpaYuLDNMcOB2a0PEdg0+Da8f3EXbGzqwGFRySQXHu+v
	58Cr7SsorFsqwmC5bRaHPcZC7ra1VG9fFNUzXIlTZ7J/4VC93XqqynSUQ1Vf/ppqKLajVMNA
	GoeanxzEqZM1JoTqKv6ZS9mr1ke/eiB5q5yWxdEaf1oZq4pLVCaEC6I+itkeI5EKRUGiULhF
	4K+UpdDhgsjd0UE7ExVMXIH/pzKFnmlFy7RaQch7WzUqvY72l6u0unABrY5TqMXqYK0sRatX
	JgQraV2YSCh8V8IQDybLpyzTuHrM49Bg00U8DbERxxB3ApBiUNTZzTmGeBBeZAMCzJeGuWyx
	gIBeazvOFs+Yk4c27IVk1tTvYjUh4OlfI67CjoASYwYjIQgOGQh+Pa139n3IdBRU/vjPqglG
	NqAgx/jEzTnKmwwFf8zU4E6Mk2+Bmv7vVjGP6RvuduGsnR/Iv/+c68TuZBhwzM1yWY4n6Mif
	WOVgDCe9tgBzGgAy3R2cXhxbvQUgI8H0iQPsHG8w3V7DZTEfPM3McOFkMDo+6vL6AtRXn3Rj
	cQRIW37k5hyDMWEqboWwVq8Bw9IEyk7ngR8yvFh2ABjOnnQp14Gxs5ddmAKdK+MIux8Ds6wj
	ZdgpxM/4UgLjSwmM/7sVI5gJ8aXV2pQEWitRi5T0Z/+9bKwqpQpZ/ew3fVCPWEfnglsRlEBa
	EUBgAh/e+t6OeC9enCz1MK1RxWj0ClrbikiYFWdh/DWxKua/UepiROJQoVgqlYpDN0tFgnU8
	2/fn4rzIBJmOTqZpNa15oUMJd34amjSSd2d4W+FGt8eTfYaleWG5T22drz1+5lFeTMbevCT9
	qFzc+6B553azD8CmWi54Xj9yqtr3/RxDdH1m7Y67X147XkOfuN5TuKPnguTNv3M7XnkWdXCf
	b3jZSPFCpuPmg+CC/n2dbZZxy4xff/CN8wGWW38eWjYPVH8yVOmpqsAWefyvzGtvO0bO9YFJ
	TaS9cT/cOzRlMkZ5tzw2dlu/Lc5JSbqEvrPSnLF5/hvrh4db9JGvtzvm5+U/rckPqzM+v3ZH
	lxQYUKHJkkfk5KIbrjZb9qSWFrjtxhS2ztsLpR/T/LFG6t6W0nvlZdKzWZ+nei9f2T98dNEQ
	e74PCbF0ReTu6RPgWrlMtAnTaGX/Ajzz1zR/BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsWy7bCSvO6n7WfSDO6vZrZYfbefzeL14U+M
	FtM+/GS2+H/3OZPFzQM7mSxWrj7KZDF7ejOTxZP1s5gtNvZzWDy+85nd4ueyVewWR/+/ZbOY
	dOgao8XeW9oWlxa5W+zZe5LFYv6yp+wW3dd3sFksP/6PyWLb7/nMFutev2exOD9rDruDmMfl
	K94e5+9tZPGYNukUm8fls6Uem1Z1snlsXlLvsXvBZyaP3Tcb2Dw+Pr3F4tG3ZRWjx5kFR9g9
	Pm+SC+CJ4rJJSc3JLEst0rdL4Mp4du4VS8FDropbexexNDC+5uhi5OSQEDCReL/qOnsXIxeH
	kMBuRom5K/cxQiTEJZqv/WCHsIUlVv57DmYLCXxklFixqLyLkYODTUBT4sLkUpBeEYHJTBJN
	D7ewgDjMAkeZJNpaFjGDNAgLWEq8ewuS4ORgEVCV2HK9BczmBYr3HjvDArFAXmLmpe9gCzgF
	rCT+f3gPtcxSYuWZ5ewQ9YISJ2c+AatnBqpv3jqbeQKjwCwkqVlIUgsYmVYxSqYWFOem5yYb
	FhjmpZbrFSfmFpfmpesl5+duYgTHqZbGDsZ78//pHWJk4mA8xCjBwawkwit3+WSaEG9KYmVV
	alF+fFFpTmrxIUZpDhYlcV7DGbNThATSE0tSs1NTC1KLYLJMHJxSDUxXhDqYm44/uszXw3Hf
	+qTy0xe1j5pOXV6az1rkLeGfebx542ebtIodq/ZM4xdIKrK6WxFx5+G7or/Hw38W7hY0vGpU
	Z7fy5hJfz3k1nGKce85r3Vmdc+v5sgmLry/93ssmK6IQUte808BQS+aG3Yai5Z++xGfWPXx4
	OFhuilWBOP92410PHlQ0mZ0q6/ErbCp/euaKmPv3uIs9W/avPrnMkTHQZ6ao6QKZJqn4zhQ5
	E+Ufk7U5NazPCFrGrXTSDbPmOVwX5zmlzrTSijm2WE/2Ytehe06MbN+ehwmVz2dhs5r4OcKs
	RrmDW3l6+z9li+bt6RlfPk/e4Pfg/b5tckI7ni2PzYpJvPzjZ9GpT0osxRmJhlrMRcWJAMUC
	7xRCAwAA
X-CMS-MailID: 20240826171426epcas5p13c5ffabd6a05ee357bf4e9f78bc5de44
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240826171426epcas5p13c5ffabd6a05ee357bf4e9f78bc5de44
References: <20240826170606.255718-1-joshi.k@samsung.com>
	<CGME20240826171426epcas5p13c5ffabd6a05ee357bf4e9f78bc5de44@epcas5p1.samsung.com>

From: Nitesh Shetty <nj.shetty@samsung.com>

The incoming hint value maybe either life hint or placement hint.
Make SCSI interpret only temperature-based write life hints.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/scsi/sd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 699f4f9674d9..32b8a841c497 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1191,8 +1191,8 @@ static u8 sd_group_number(struct scsi_cmnd *cmd)
 	if (!sdkp->rscs)
 		return 0;
 
-	return min3((u32)rq->write_hint, (u32)sdkp->permanent_stream_count,
-		    0x3fu);
+	return min3((u32)WRITE_LIFE_HINT(rq->write_hint),
+			(u32)sdkp->permanent_stream_count, 0x3fu);
 }
 
 static blk_status_t sd_setup_rw32_cmnd(struct scsi_cmnd *cmd, bool write,
@@ -1390,7 +1390,8 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
 		ret = sd_setup_rw16_cmnd(cmd, write, lba, nr_blocks,
 					 protect | fua, dld);
 	} else if ((nr_blocks > 0xff) || (lba > 0x1fffff) ||
-		   sdp->use_10_for_rw || protect || rq->write_hint) {
+		   sdp->use_10_for_rw || protect ||
+		   WRITE_LIFE_HINT(rq->write_hint)) {
 		ret = sd_setup_rw10_cmnd(cmd, write, lba, nr_blocks,
 					 protect | fua);
 	} else {
-- 
2.25.1



Return-Path: <linux-fsdevel+bounces-56764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C45B1B60B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 16:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4711D4E281A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 14:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB82827AC57;
	Tue,  5 Aug 2025 14:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="PmyZpKkd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC9127A44C
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Aug 2025 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754403107; cv=none; b=j+o0nmobdsMtpBNOqDCwRBlo7/l8Gtdc3elZ4c9tQgb5H/CXLLCT+zddKMYBXuVWnvQBm5Fkks4gqV3thBSCL1Lqp1ZDzgdmVydrLp6cfo97KzMR1ck38MrOnurxIfA1HOgQLNzBE/KLXSIdbieBW964U1jtuw/ABOQcDOePGI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754403107; c=relaxed/simple;
	bh=T38d36O6jE3OZut66S1BIIGBnUYM/bO7UHb8Lrjuqu0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QU5wPiSx1iUcTWVvXj9We1NwAXe5LK83yk3WF+qEXYImitfIe5WWy+WQGBxFGx/OJ9ZDqx5dpgHjksG5baeJovSYrh53cvB5T2qBzua8z7/M7K4fLU+ZjC/PWvU3pfmAEczvwXWhrNFXhLM7iQ6pIJw/SX4fFxoWsNXGS2xR2UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=PmyZpKkd; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575CYLgc022527
	for <linux-fsdevel@vger.kernel.org>; Tue, 5 Aug 2025 07:11:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=RuONH4h6XBh6KQsjcqoAAXlkSkTgfCY/q+o6rZEieIM=; b=PmyZpKkd6p1k
	bChFn1fBRuLunXGeBBKs4OQPVSevQYML1POFr36ZoZyvbM4JSkaqj2NLYjNPPL/C
	ctYo8o3r47li8mn8nJfk/ofH/g5odGNTXy2yxCKQBUaoGcuHOPz2LaUuur2U7s4Q
	6HCRW0oS57cDM4KrC9BuwS51XtOEngpEQOlQKrqiSHDS8HVHeJZt7CQmttIktpl7
	Yt+zTEYckkiStN7IIrp/rCzjTv6HccH3p9GLTgC/YJdhcK+iOlEJsO4aX1awZllI
	r4yklqJ8FCkC6ggVrnm1r8nd8mh/lbdKZqv7Qi4hzZA9p2AM+AQs82x89I2Z9XfR
	/Z3GnWKPJA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48b5t3vthw-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 05 Aug 2025 07:11:45 -0700 (PDT)
Received: from twshared25333.08.ash9.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 5 Aug 2025 14:11:38 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 000EB4FDD53; Tue,  5 Aug 2025 07:11:23 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <snitzer@kernel.org>, <axboe@kernel.dk>, <dw@davidwei.uk>,
        <brauner@kernel.org>, Keith Busch <kbusch@kernel.org>,
        Hannes Reinecke
	<hare@suse.de>
Subject: [PATCHv2 5/7] block: remove bdev_iter_is_aligned
Date: Tue, 5 Aug 2025 07:11:21 -0700
Message-ID: <20250805141123.332298-6-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250805141123.332298-1-kbusch@meta.com>
References: <20250805141123.332298-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=O9U5vA9W c=1 sm=1 tr=0 ts=68921121 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=x-sBDG6hxYFL5DTe09MA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDEwNCBTYWx0ZWRfX9v1sTRVEy4uT GyNAj7Du0mV2VkuWubdsfcPVDYWRwnsb1GixJQUT8NbN7TcQkSRwubrlk9MScUZoWK5YAKziHVr 6yKb4i+I/XBB/F/i2Cqfkwc6vN1wjSHv0YTrPeFRiTnZuDgKEknW8/5xiqy4gkgI18MUdyontIg
 hWXEf1tHqEyV8OeZRd61fpNQygS6MgFFbmirqaxNQCA7nr4tK/ewL4DNeDnhOv0eSad0f3WGVep dsGG6/Isp4hiqlZXOE9eZm0g7Y22EcQe9QMxeZu9l7n7qOYqZ7kmbI7CGsFACCMx39VW5SFtglp dgKhEpPnDol+5+2FJh4xv/EfqYnK6F7Hm7PRotcaUil3Lwl96xUKS2K6hoqN8RMJB0UVcLetYZE
 cymyBIzzo0pXzumre16lFLXkkYpaghwv5S/HOrLM/xCxm9sPhJnvhmBx619rYwtO6UD6V9fV
X-Proofpoint-GUID: 3euMNPepZ3Iw6aSSx3r9OHW0eZfl2mgA
X-Proofpoint-ORIG-GUID: 3euMNPepZ3Iw6aSSx3r9OHW0eZfl2mgA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

No more callers.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 include/linux/blkdev.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 95886b404b16b..f86aecbb87385 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1589,13 +1589,6 @@ static inline unsigned int bdev_dma_alignment(stru=
ct block_device *bdev)
 	return queue_dma_alignment(bdev_get_queue(bdev));
 }
=20
-static inline bool bdev_iter_is_aligned(struct block_device *bdev,
-					struct iov_iter *iter)
-{
-	return iov_iter_is_aligned(iter, bdev_dma_alignment(bdev),
-				   bdev_logical_block_size(bdev) - 1);
-}
-
 static inline unsigned int
 blk_lim_dma_alignment_and_pad(struct queue_limits *lim)
 {
--=20
2.47.3



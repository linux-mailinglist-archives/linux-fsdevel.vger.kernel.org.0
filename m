Return-Path: <linux-fsdevel+bounces-59378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF85B384AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 16:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCA8D188F40D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 14:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBB935E4EC;
	Wed, 27 Aug 2025 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="aGeA7xjh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F9135A290
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 14:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756304008; cv=none; b=O4cYfXeCE6sVIRDFwhF9pcffmaY0b8dxhENaN9uxKvtE0T72f3LhJ84qhKjKq3n11ejQKAiYAbbAnYz8510CgVcJeEwg73D308iEe2FjkX7pGljA6lmz4P4/fRxapz9T8Z1ZdDzyz+U10aR59A0jEHAlDyOjjk5cGZ4ZO4U6f4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756304008; c=relaxed/simple;
	bh=ninOjM1MQ4tM9muoBz2+WRG73bpJGvheL2RNP5oKp2Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jzEXze6MYly//JuJLcJZJ19aRtV4D6wlEmuilJFeUqIrejX6hEm+cq51s7CNpMcmH/QOUbaKBtpP3TbTLRpqOnLSsD5g2JHG1qN8yVPU8V1RkKa/4h9ROneq9oWm00UrMdv49r7j9FDisdyNTAnAKmmseJQ/W+0I1B/R8kK/0lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=aGeA7xjh; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57R4s9EZ763685
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 07:13:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=b49CrMrY1HUy4eAHENr0tp0XBojJ1jNrZOXvPvEc61s=; b=aGeA7xjh3nVq
	hMsUkEgcn23itFnFReq4jQqrwX/9QZuNOOKnWtB1jgV8rOBPKkMY3lwwTV5KLbmd
	bSNj1MuJFbo4QQpQhEWTlF/be7x/vO1AfTu0acWo7OT8KFh3S+DRRgaAwZn9QtxU
	bwFhim2ObYMk/44fzfcvcRlBS5S5HmsWk+RKYMDUvopHvpchAF79i//Fx6ihqOek
	TDQZ1J4ZkRIbokX+Pwjqrk9yeJ4gdeVB8hvSQM9LK7Nm+SZeWK9NHMSYBQ6LhG5a
	PKykMEjn9CDmbtYcIca9o+ty5QlPw5kl2Nx5VE1JGrIB2X+RJxf1XBGyQDkvkD+E
	QeycavkEHw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48sud32jy8-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 07:13:24 -0700 (PDT)
Received: from twshared7571.34.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Wed, 27 Aug 2025 14:13:15 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id E18E210CF627; Wed, 27 Aug 2025 07:13:03 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC: <linux-xfs@vger.kernel.org>, <linux-ext4@vger.kernel.org>, <hch@lst.de>,
        <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Hannes Reinecke
	<hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCHv4 6/8] block: remove bdev_iter_is_aligned
Date: Wed, 27 Aug 2025 07:12:56 -0700
Message-ID: <20250827141258.63501-7-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250827141258.63501-1-kbusch@meta.com>
References: <20250827141258.63501-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: mUqk1X678unCdHskMqTSqn5LQMCq5G3-
X-Authority-Analysis: v=2.4 cv=PqeTbxM3 c=1 sm=1 tr=0 ts=68af1284 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=xM7hJ6YyiNa3_SwsFokA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI3MDEyMSBTYWx0ZWRfX6OpCnHYEdujP
 M5xWOKHgJVaDa70WywHONxYwu6XeGATcmtUjd47gAIKdFPZk7HtS0XySfcUMRMipXMucBM8a0qo
 l2fW5JDa1i0SVwLe0//ycSZ85sD9J3e2Dho5RzW/wdURDbul0OIbxbBOhcN6HvyOz+H/sbV8BPs
 hkI8tm04FmES4D5uO3e7SBNw0pW8LqE9xf0iwP5GuR0liHhLfeDnhJBHAZjyp+R3CJQUqqErQqv
 oIq+KHRr6DdyZy9R70NZZgErB0YhANQuJG1Ehu4gqElBZNAXUKzOGDshyk2tGTgsj/+g8Z15cMZ
 3sW5U2Q1R6NZV98NmCGD1iWv3nGd45sH5/iM1Dqlbjr07c9ktXTrxM9ayIOJ8E=
X-Proofpoint-GUID: mUqk1X678unCdHskMqTSqn5LQMCq5G3-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_03,2025-08-26_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

No more callers.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 36500d576d7e9..221f6d7c0beb1 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1590,13 +1590,6 @@ static inline unsigned int bdev_dma_alignment(stru=
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



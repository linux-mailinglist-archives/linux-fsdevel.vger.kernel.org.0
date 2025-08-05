Return-Path: <linux-fsdevel+bounces-56762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5A4B1B626
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 16:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A32901890E28
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 14:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1C927A10D;
	Tue,  5 Aug 2025 14:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="RDeEiszB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C8A272E6B
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Aug 2025 14:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754403102; cv=none; b=dAuP53q1SwExGWW0DAroC5R2fn9CgQFSJZxDzmRniuzEsescUau9D9rRJNhBA+L5sTUvnj8Q2cqCd7qszLvQEqoWUtCbNgDrKkAbIe/YOzocb6IBphv56xFNYIcG9zr/ul3vHlxr0Zz/J9GiV6krpCrI+8hBn6HL0epfuTB3GQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754403102; c=relaxed/simple;
	bh=Kdc9xGN9AcSWoWHghDPfa3FV5WggL3IWn9sG9vpZcFk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=guw3Wq63Y3Vh94OVlAUSl7wL7wnjrxwE6HjPcqKnpAS0Bd1luX9OcflGL93Kfoz+obV0JJ85p4LpXwh2cW5Q8Jn9rg2oPHVSu/MUu0Sxm2m5/qA8qvwVHI68Vda9Z4YFuVrE/VN74qPxbxawYl6XyzKehJZe4Dru90C1h0PDneU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=RDeEiszB; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575CYIVP022219
	for <linux-fsdevel@vger.kernel.org>; Tue, 5 Aug 2025 07:11:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=nxCXPs3DLBfSPrI4Om
	DSE09/Da+yCPHrQnIW6i4cpmU=; b=RDeEiszBLEs3Ehvfc4KicGGhML4FbIPXDK
	LOWg5iXH5rK/eAe2cyJGbfTynbFAj+th7jBJwnM+c4pQjTwU4DY2jZtBLE+0Axnf
	TE+APCs6zbGjqna2vYbyxB+KqVjj6pTGzu28guYQZNGChfgMnOUCt4SQnXkVE/iN
	iTTwzorfVJxOwNPoUdTBQB4AE6trJq787T14A3FddPnYGp/qGGDforTrp5+oiKii
	yugagW9621qwurYuQja0rlWYpGgGIY9MKa5hhCSAfC+c18IX6gIgcrgHv6d/Upiu
	gVi0o/ZmqSpQWKp4MzpmQ7DOOiEd5wvb3Z+2tLKJY6xT85DVnjMg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48b5t3vta0-19
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 05 Aug 2025 07:11:40 -0700 (PDT)
Received: from twshared25333.08.ash9.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 5 Aug 2025 14:11:37 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 9AB254FDD4A; Tue,  5 Aug 2025 07:11:23 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <snitzer@kernel.org>, <axboe@kernel.dk>, <dw@davidwei.uk>,
        <brauner@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 0/7] direct-io: even more flexible io vectors
Date: Tue, 5 Aug 2025 07:11:16 -0700
Message-ID: <20250805141123.332298-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=O9U5vA9W c=1 sm=1 tr=0 ts=6892111c cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=5bCI7YQ4g9DT-SdEb_oA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDEwNCBTYWx0ZWRfXwO9kF1fbY2e1 blD0U/KQZ+i0zMBaJUlVeII0VXNOaI/oIuSDFvauEu70NMxfvMA8S4K+ALGYquCZt8ao+siTW/R Uwa5BxP5N2wxGa8csb6gVwVQpCbdRV0iRd1Tv+CWnh4CkAbak7t6hQBs2ZD9D8BwOhQGppSuP5b
 3knsCVAvVD2zgQhpKO6KMRmxeWsOP2hIgK/J+YuFA0H/OEITsq2kqZz3FmyfIPobrLn5PlbXeq7 tNss9KOJiF9p5GKGAM8JKZCc5o9P36R51dVf05kDiPXhpdra0Ssj6FuzJvYo1djcx31dNczsD0K v3dh9e8zWbwIQ5QCGZf7GoROxH5UvIXgC0jDP829GEbDNSPcFXKl+GpV6bsiXzeVewCNIlkhZlf
 qg6MNH+i7feutIHp9cJrxx5i4oFnEvZsb1Syy6VpgdPmw/lHgzLHJuAOB9fZTfDHINKv43S2
X-Proofpoint-GUID: JQgA-mJCMA7GXm3BTOf6JGrAYCaHTitJ
X-Proofpoint-ORIG-GUID: JQgA-mJCMA7GXm3BTOf6JGrAYCaHTitJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

This series removes the direct io requirement that io vector lengths
align to the logical block size.

Changes from v1:

 - Fixed the return value when attempting to align a built bio to a
   block size multiple.

 - Added reviews

Keith Busch (7):
  block: check for valid bio while splitting
  block: align the bio after building it
  block: simplify direct io validity check
  iomap: simplify direct io validity check
  block: remove bdev_iter_is_aligned
  blk-integrity: use simpler alignment check
  iov_iter: remove iov_iter_is_aligned

 block/bio-integrity.c  |  4 +-
 block/bio.c            | 60 +++++++++++++++++---------
 block/blk-merge.c      |  5 +++
 block/fops.c           |  4 +-
 fs/iomap/direct-io.c   |  3 +-
 include/linux/blkdev.h |  7 ----
 include/linux/uio.h    |  2 -
 lib/iov_iter.c         | 95 ------------------------------------------
 8 files changed, 50 insertions(+), 130 deletions(-)

--=20
2.47.3



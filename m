Return-Path: <linux-fsdevel+bounces-36594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 435FD9E63B7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 02:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 047B82856B2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 01:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC4E1552F5;
	Fri,  6 Dec 2024 01:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="LviDA6Le"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8F71474AF
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 01:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733450014; cv=none; b=MykLviLNbgxzocH4SDyfIxgSKFmp7HlJBrHsMN41CjtsXYWc48axOC7iT3QRN1l4eFfASg2jGHgREaJcsj9XtKUtsFyHnamxUhpuiklX37rHzfQdbnr6yTHik794pNrmqhadQ21tO6ZuTozkORq+OAGoCMZGzi3A6tH+b0IB5ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733450014; c=relaxed/simple;
	bh=bphxMXlIQATdUL67IFgKwOjenQ9Bah68ksQgsI/+rdw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ecBgDXASU07kz9DiQIo1AFEfbvktuw11hdax7Vji2n7QhHVbcQNtNu+62V951ZRmV7GwSrnTeK4oYAwMDFQi2o+BcwVsbdRpLk6i/QXRYvbU7L8MUKowkL8Y1jy4UXATOI7WKsbvIhv89JdR7oe+GpHLu+EfavFgPTjD3me0GzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=LviDA6Le; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 4B605ewb013917
	for <linux-fsdevel@vger.kernel.org>; Thu, 5 Dec 2024 17:53:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=N6QJZ2jdiu9UH+vLXQ
	lsk+NJB6RNvYfSL8jeMy0Efqw=; b=LviDA6LewbUvCfamYOMr+0mwCJG9IW+FFl
	STB3fqyTPEWWzwlRkxT6XtKmqJiFOdUtgGE+q/tEyBlNtqTOf6KMU2SCIfxmTIcU
	pyvqlBi4SZ/yo3c/0FrzSQBsOmVFpzsHfUY5P1JT4oq1NGkPfuLSAEW4SOi5bU9o
	Yv5jhLBSFy4icQ/eSQc0FZEc5Rj6ED5wX4oQP2u+KHF8HTKSAlDtZdOkWFJRgp1r
	Dq+l7G2QeHJNIjKf1TzDQ/t9szsvQW4qe5oSpSXxM7gQVchDn9nQ5plTN6gbuPr1
	CmENm6DGECC3aPVYC1cSwgFZrkH893LTAwr+blExIiwzlOj7a5lg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 43bmrwh5m2-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 05 Dec 2024 17:53:31 -0800 (PST)
Received: from twshared11145.37.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 6 Dec 2024 01:53:24 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id C476E15B21147; Thu,  5 Dec 2024 17:53:08 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
        <io-uring@vger.kernel.org>
CC: <sagi@grimberg.me>, <asml.silence@gmail.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv11 00/10] block write streams with nvme fdp
Date: Thu, 5 Dec 2024 17:52:58 -0800
Message-ID: <20241206015308.3342386-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: JCPseeaylCQHbmWceLT5inEV-3lXr_-g
X-Proofpoint-ORIG-GUID: JCPseeaylCQHbmWceLT5inEV-3lXr_-g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

From: Keith Busch <kbusch@kernel.org>

Changes from v10:

 Merged up to block for-6.14/io_uring, which required some
 new attribute handling.

 Not mixing write hints usage with write streams. This effectively
 abandons any attempts to use the existing fcntl API for use with
 filesystems in this series.

 Exporting the stream's reclaim unit nominal size.

Christoph Hellwig (5):
  fs: add a write stream field to the kiocb
  block: add a bi_write_stream field
  block: introduce a write_stream_granularity queue limit
  block: expose write streams for block device nodes
  nvme: add a nvme_get_log_lsi helper

Keith Busch (5):
  io_uring: protection information enhancements
  io_uring: add write stream attribute
  block: introduce max_write_streams queue limit
  nvme: register fdp queue limits
  nvme: use fdp streams if write stream is provided

 Documentation/ABI/stable/sysfs-block |  15 +++
 block/bdev.c                         |   6 +
 block/bio.c                          |   2 +
 block/blk-crypto-fallback.c          |   1 +
 block/blk-merge.c                    |   4 +
 block/blk-sysfs.c                    |   6 +
 block/bounce.c                       |   1 +
 block/fops.c                         |  23 ++++
 drivers/nvme/host/core.c             | 160 ++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h             |   5 +
 include/linux/blk_types.h            |   1 +
 include/linux/blkdev.h               |  16 +++
 include/linux/fs.h                   |   1 +
 include/linux/nvme.h                 |  73 ++++++++++++
 include/uapi/linux/io_uring.h        |  21 +++-
 io_uring/rw.c                        |  38 ++++++-
 16 files changed, 359 insertions(+), 14 deletions(-)

--=20
2.43.5



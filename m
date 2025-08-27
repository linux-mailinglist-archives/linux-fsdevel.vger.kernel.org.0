Return-Path: <linux-fsdevel+bounces-59374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B68B384A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 16:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3805368522C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 14:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DED35E4DC;
	Wed, 27 Aug 2025 14:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Na4uw6Gd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6491035CEA0
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 14:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756304003; cv=none; b=phZAyixlNe7W2JvR4KrWmD8GZKdDwwz8rJU4Ig3XtsnvFNvyt+vthL04aPMUNqLie3dIbjCQz3Bss/fy6ADbF0GIjRDpRTXkf4WfOgv6S3bWshdXw4EfaJYShiCnnJ3MnoDIeGvFg4cMo37xlh/bIuEi784nuGYZtCb+0X/YGEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756304003; c=relaxed/simple;
	bh=D+qLXcG8rjQNPu/cyOULZd20WAPqIqz3VONd48zdQik=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hh296A3Bcjw6J3ofqK7DANkjgUWOej7CgKdGnxL5ukuk+U50z8IPS0BQN80wJtvBskdYaBqVspBwhR7bmQeB3QG2qzWtPNzQhTsKo4gkaylZf/dhJA2HfY6ioifQMMpN7QwKeqimTGOAMv3sFO5fPtWBVnkhiFljduUw8D+pXSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Na4uw6Gd; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57R7SJ0Z1299130
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 07:13:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=/Qt6QVTxd6TJstz9g1
	J001UpoSAm0PdHWdX38furYnw=; b=Na4uw6GdU0LhMwQBAJgKpuJqv4+Uhp5UMz
	HUpE8Z/ZgSZiDqRM6w21Reo1lSIlX7s8Y5Lk2p1NduHGpH7TtKc3uWpqqEp0sV5S
	cl/fnHrNQ1WiUQ6eOSAwrisiiOqlmJ9Tps1mFOpgSs9zIoo75hgJW+9O7gwcwk/U
	+vO5Ti9iia156k57UnrzFYvXfEcIRVkaLCfbKRP/ZDIr+cYJT49T6xK6+1dAEuNh
	bLZ/L/UazcFVQbmwVOP2fpQUajwT01cueYyUs9pN7YwqjfuAskWaN/3Lqcg1S/jY
	4Gii457ywyb+iHq42No38CXr+kBptAekGZvL0YpXf4sXroUKXfTQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48swmva0at-15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 07:13:17 -0700 (PDT)
Received: from twshared0973.10.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Wed, 27 Aug 2025 14:13:06 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 7F14810CF611; Wed, 27 Aug 2025 07:13:03 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC: <linux-xfs@vger.kernel.org>, <linux-ext4@vger.kernel.org>, <hch@lst.de>,
        <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 0/8] 
Date: Wed, 27 Aug 2025 07:12:50 -0700
Message-ID: <20250827141258.63501-1-kbusch@meta.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI3MDEyMSBTYWx0ZWRfX2RyNdn7qliFe
 anSjcZHaslkW6BI0d/4x8WnaYEyHmgHhUvg/XgMULId1NFmzMjHAbgZA/ry122luI7HG9wv4ZDX
 AVL7o6PEz1lmjh9h0IeKZ5+TfiWVI5KktbBoSD7fRh7pNbN+fjbv5cEjxdTCVvfQexoKrKDMqdw
 U3lIfXjRFEa96lwAKEmfsFjZHl3x2pwZJhV8wOhmbhoyaJ3ErdFGGsA8Sl5WHI0WtsZ/mq0j8Pu
 IBYf38vRaN4ZxWtqieC2AJsJQTRLrzAhFHzb4ooaWSKUc4pOxhmEdQomcSkPUv8Y+UF4GQVG+PF
 n6jssnNQs8Fpv68/jv1Wdxmo0X53vYE3Vy4Ek5CBVxhz4K8y7p8Rqq97qNeQA0=
X-Proofpoint-ORIG-GUID: UJ8e6YGA3JKqzlloRR6nR-0RAnaVJ_Xz
X-Authority-Analysis: v=2.4 cv=NKnV+16g c=1 sm=1 tr=0 ts=68af127d cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=bZ6uR2C94leCsy_9LK0A:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: UJ8e6YGA3JKqzlloRR6nR-0RAnaVJ_Xz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_03,2025-08-26_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

Previous version:

  https://lore.kernel.org/linux-block/20250819164922.640964-1-kbusch@meta=
.com/

This series removes the direct io requirement that io vector lengths
align to the logical block size. There are two primary benefits from
doing this:

  1. It allows user space more flexibility in what kind of io vectors
     are accepted, removing the need to bounce their data to specially
     aligned buffers.

  2. By moving the alignment checks to later when the segments are
     already being checked, we remove one more iov walk per IO, reducing
     CPU utilization and submission latency.

Same as previously, I've tested direct IO on raw block, xfs, ext4, and bt=
rfs.

Changes from v3:

  - Added reviews

  - Code style and comment updates

Keith Busch (8):
  block: check for valid bio while splitting
  block: add size alignment to bio_iov_iter_get_pages
  block: align the bio after building it
  block: simplify direct io validity check
  iomap: simplify direct io validity check
  block: remove bdev_iter_is_aligned
  blk-integrity: use simpler alignment check
  iov_iter: remove iov_iter_is_aligned

 block/bio-integrity.c  |  4 +-
 block/bio.c            | 64 ++++++++++++++++++----------
 block/blk-map.c        |  2 +-
 block/blk-merge.c      | 21 ++++++++--
 block/fops.c           | 10 ++---
 fs/iomap/direct-io.c   |  5 +--
 include/linux/bio.h    | 13 ++++--
 include/linux/blkdev.h | 21 ++++++----
 include/linux/uio.h    |  2 -
 lib/iov_iter.c         | 95 ------------------------------------------
 10 files changed, 92 insertions(+), 145 deletions(-)

--=20
2.47.3



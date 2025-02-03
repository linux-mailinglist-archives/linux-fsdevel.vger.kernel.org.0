Return-Path: <linux-fsdevel+bounces-40645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD20FA262A8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 19:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FC50165D57
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 18:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1834515C158;
	Mon,  3 Feb 2025 18:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Oh1LcRbb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCCB770E2
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 18:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738608110; cv=none; b=Pbv3XthCrjFguWQz2be53/u3tI/qSpp8eRFpIe+lkxdrZ5Y+y0frRNfRN2eWmqNsg7sUn/vwHBUWU2AWZRWGyVNw4Lcm9Xk59Fi2ax22pVeWXiTkWJfvCcLvbGIounne8FmX10VHXgKpznE0lTp+zTwHfkaZgKLBe83U2xbKBw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738608110; c=relaxed/simple;
	bh=jGBOyTMxd9LBptAGrMlxqGFgBEc8xTnk1LL6MSBn3dc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n37J9QFwg8bNsAke2oZjeh/mwccMKfW3lPdAo6gHeGVym5s3TuA7K9BVKixlqKJiQOaUORJbNAiSCFNn2/2cbv+00bylGeZhdjhMZoIlzC/UIljO5xm7mzA2Mo4PVU/GAB0KBSVUEzsPIPb8iz/EW9eVtmX2yPcgTWfNF34SZs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Oh1LcRbb; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 513IHqS9006896
	for <linux-fsdevel@vger.kernel.org>; Mon, 3 Feb 2025 10:41:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=KMmG5gJPTqu1RsuNuX
	10Ml6gX7oOZqPZjeqbhOhxPB4=; b=Oh1LcRbbUPxefNDABEAQXrYS0O5V3SFY+5
	x776MigOcbrj8bT3C9IRiYTShwSWg9tKoPOiFgTmjcf0HUXoCQFmQntKfW0pxAp3
	JN1BLRIoBXGJsM1aEztEcBOSQhWMQTOYuP3jg60luPC3kkSfcfpQGFPIiUi52DZI
	x8kWzP141SYy0FhAy/hxgPGXA6+xVBOk1tyFgNyV4UCU/8otm3qa9F2jis9SKO0r
	ISyXY/FRL0K1kfUIVjg+fX0O6gZC5kLpwi5A1Cc4yhk6Kgo0rTI0GzCt1tSlVxuH
	012vXwEeJfDJXMFzKpHk0a23rg/p3Tpg3zk5YOwiJMc/OhSxOHsA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 44k21sgqqb-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 03 Feb 2025 10:41:47 -0800 (PST)
Received: from twshared29376.33.frc3.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 3 Feb 2025 18:41:43 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id E8684179C261F; Mon,  3 Feb 2025 10:41:30 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <io-uring@vger.kernel.org>,
        <linux-block@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <asml.silence@gmail.com>,
        <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv2 00/11] block write streams with nvme fdp
Date: Mon, 3 Feb 2025 10:41:18 -0800
Message-ID: <20250203184129.1829324-1-kbusch@meta.com>
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
X-Proofpoint-ORIG-GUID: 8Y-xEXcjlg4c_lx18JXKxFZEVTg6Seid
X-Proofpoint-GUID: 8Y-xEXcjlg4c_lx18JXKxFZEVTg6Seid
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_08,2025-01-31_02,2024-11-22_01

From: Keith Busch <kbusch@kernel.org>

Changes since v14:

  Merged to latest nvme, block, and io_uring trees

  Replaced vmalloc with kvmalloc (Christoph)

Christoph Hellwig (7):
  fs: add a write stream field to the kiocb
  block: add a bi_write_stream field
  block: introduce a write_stream_granularity queue limit
  block: expose write streams for block device nodes
  nvme: add a nvme_get_log_lsi helper
  nvme: pass a void pointer to nvme_get/set_features for the result
  nvme: add FDP definitions

Keith Busch (4):
  block: introduce max_write_streams queue limit
  io_uring: enable per-io write streams
  nvme: register fdp parameters with the block layer
  nvme: use fdp streams if write stream is provided

 Documentation/ABI/stable/sysfs-block |  15 +++
 block/bio.c                          |   2 +
 block/blk-crypto-fallback.c          |   1 +
 block/blk-merge.c                    |   4 +
 block/blk-sysfs.c                    |   6 +
 block/bounce.c                       |   1 +
 block/fops.c                         |  23 ++++
 drivers/nvme/host/core.c             | 191 ++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h             |   7 +-
 include/linux/blk_types.h            |   1 +
 include/linux/blkdev.h               |  10 ++
 include/linux/fs.h                   |   1 +
 include/linux/nvme.h                 |  77 +++++++++++
 include/uapi/linux/io_uring.h        |   4 +
 io_uring/io_uring.c                  |   2 +
 io_uring/rw.c                        |   1 +
 16 files changed, 340 insertions(+), 6 deletions(-)

--=20
2.43.5



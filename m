Return-Path: <linux-fsdevel+bounces-32226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD7B9A2810
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 18:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F85F1C212E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 16:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F18C1DEFD9;
	Thu, 17 Oct 2024 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="keMyyjtL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143121DEFCD
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Oct 2024 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729181412; cv=none; b=USCXuh06DNRopVXaofzQtmxYitlmSqgkrOltzk7f7YEl5nqHe5isvd93WRDXRcv3jy3DtCUCo/qGUXwtHfA9CD5yAmXhClwpIycnVtJB1rRfhl+7Vp31WZ34v4i0i6hXIsN2Gp7ikXP94tpmbgk290ObFqEBYAaiLlvfy9SUexk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729181412; c=relaxed/simple;
	bh=8ORMPad2HTS604lXUVSlFDlE8XbLD6RWU8f6sgsUi5g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PvVR91Rg1Qw/fiHFN/sCNfOVh4K+aTYL4pLT0/V+ZTBSjhljXt/m/89No4fFfK3h/kH2E+5WMYkSbXHLklxuIGPwfqQX/DQBku+hI0+p3CN1seFhq9kFTSDczzrDGUezA6YsTjDQ585zmzQaECsuJq6EmHVxV8uzJGRPjNT5rvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=keMyyjtL; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HCh3tX025716
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Oct 2024 09:10:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=tOGBz/rCTzSIryNyP6
	GSBMTEgXEhA57kzrdrwgMPCHA=; b=keMyyjtLol7RAtcGNTKxI8QlK8k1swjkdm
	BiSlJO6MXMXYySC0e+iQbnJSOskLIQL9EaV6JOcOHwD9zjcCqRY9liXDf5yppcmY
	1mEGzozq7e/0qC1J+rdBx02eumeTwc0T28Fo6di9qY1m7OWMUj3i2Uby9BBSoKQE
	DUSbZtRtjITPRW+QjwPA1zuBIQOGkIXfitGmqXz1Txh2nBWkNwS0dt7QmJuUtSyY
	Tne2S7b9fQxTM0wC+ULNdGBssW/Y5/ZMR1MJcDGt9SULIoJnJ0GxDNt1I4z2iYz1
	V9qk9KMQcbyOmhA8/YNTFlb0NGXoaimjxZ6oW7++bO0g7LxbKu8g==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42b1auj6ap-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Oct 2024 09:10:09 -0700 (PDT)
Received: from twshared16035.07.ash9.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 17 Oct 2024 16:10:07 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id DC738143A4A96; Thu, 17 Oct 2024 09:09:57 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <axboe@kernel.dk>, <hch@lst.de>, <io-uring@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <joshi.k@samsung.com>,
        <javier.gonz@samsung.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv8 0/6] write hints for nvme fdp
Date: Thu, 17 Oct 2024 09:09:31 -0700
Message-ID: <20241017160937.2283225-1-kbusch@meta.com>
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
X-Proofpoint-GUID: nuK2rQxBYc5qu5jtfuMchWGxNMQ0zb5j
X-Proofpoint-ORIG-GUID: nuK2rQxBYc5qu5jtfuMchWGxNMQ0zb5j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

From: Keith Busch <kbusch@kernel.org>

Changes from v7:

  Limits io_uring per-io hints to raw block, and only if the block
  device registers a new queue limit indicating support for it.

  The per-io hints are opaque to the kernel.

  Minor changelog and code organization changes.

  I don't really understand the io_uring suggestions, so I just made the
  write_hint a first class field without the "meta" indirection. It's
  kind of like ioprio, which has it's own field too. Actually, might be
  neat if we could use ioprio since it already has a "hints" field that
  is currently only used by command duration limits.

Kanchan Joshi (3):
  block, fs: restore kiocb based write hint processing
  io_uring: enable per-io hinting capability
  nvme: enable FDP support

Keith Busch (3):
  block: use generic u16 for write hints
  block: introduce max_write_hints queue limit
  fs: introduce per-io hint support flag

 Documentation/ABI/stable/sysfs-block |  7 +++
 block/blk-settings.c                 |  3 +
 block/blk-sysfs.c                    |  3 +
 block/fops.c                         | 10 ++--
 drivers/nvme/host/core.c             | 82 ++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h             |  5 ++
 fs/aio.c                             |  1 +
 fs/cachefiles/io.c                   |  1 +
 fs/direct-io.c                       |  2 +-
 fs/iomap/direct-io.c                 |  2 +-
 include/linux/blk-mq.h               |  3 +-
 include/linux/blk_types.h            |  2 +-
 include/linux/blkdev.h               | 12 ++++
 include/linux/fs.h                   | 10 ++++
 include/linux/nvme.h                 | 19 +++++++
 include/uapi/linux/io_uring.h        |  4 ++
 io_uring/rw.c                        | 10 +++-
 17 files changed, 166 insertions(+), 10 deletions(-)

--=20
2.43.5



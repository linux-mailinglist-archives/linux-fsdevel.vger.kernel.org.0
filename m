Return-Path: <linux-fsdevel+bounces-33127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C29FF9B4D93
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 16:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 858D1285FBD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 15:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60DE198A31;
	Tue, 29 Oct 2024 15:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="EkBldLnO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3454B197543
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 15:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730215203; cv=none; b=tzojiE5/XKFCih1qKMRixz7AYdy3pradZEwD8aNlsQvZDuOj0chKWS567+sZbYmpeUcaPUToGdTAcz0WEvTh9nFWHIvGmJ9+/x62U2IwPp3EVkhbidMHKNpv+3ZqrQ70H2qecRpAvdGI8OoR6K8WoIhW++dfDvaOCK9sRW5cptU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730215203; c=relaxed/simple;
	bh=u5K3D5yLSkHuUgTsOePWDLML5bOnFkPsgBx7WMm9Kok=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Xmn/CrwUk/BG+vYgvRgE9AIgvv1fO/sY2dNy74ACh5ii4d/qOONCmnmHl9YyXDQfEEyF5rr7gDIkDZX92v/0Hu8kJ18gn2h1ruaCk8mgP5lF4xPVpty+nurorN5jfFo9hnCV58Tke3s1MRJxkJM+lZTTqKfb8BZO25QN1xze9oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=EkBldLnO; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49T72Trr012612
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 08:20:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=XgvQBUxMc4oBRDRyps
	Eh3gf2mVo+uaeROl5mqKEtNEM=; b=EkBldLnO1a5HwaERD48j8+tJYInobYCnto
	+7gK6kCnzA59H/PerqdNJH6U57UXRpA4P265FoAfDfBvquW4SsqUAf5bwseHRogt
	GNm2UQseW/y1/FI6TVRnHIlTrwl4QyDP028+Pa5WSrtYsoETwdCIbRKIYrG4jysk
	1s5MTTyxmeHVTFXstQalE8mUKJSHB+9MhSBjgAWo2IYYcj0bGf6KaNfaML12mw/I
	stlMrECM7iIqHeb2R8SbLqg4nf1qnIPeSVi8XfuEzan3LBxv3nMUs9sI+vALdfmK
	QgBOe7Lu8P/1YchdWUt9SMoKE9RbPsQKcatwmHxw87SeazTjAThA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42jty7asby-15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 08:20:00 -0700 (PDT)
Received: from twshared10900.35.frc1.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 29 Oct 2024 15:19:58 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id D97AA14920E9A; Tue, 29 Oct 2024 08:19:43 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <io-uring@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <hch@lst.de>, <joshi.k@samsung.com>,
        <javier.gonz@samsung.com>, <bvanassche@acm.org>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv10 0/9] write hints with nvme fdp, scsi streams
Date: Tue, 29 Oct 2024 08:19:13 -0700
Message-ID: <20241029151922.459139-1-kbusch@meta.com>
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
X-Proofpoint-ORIG-GUID: iUZiFgZpdl6WBqhXdWnvA5igBhVrdoe9
X-Proofpoint-GUID: iUZiFgZpdl6WBqhXdWnvA5igBhVrdoe9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

From: Keith Busch <kbusch@kernel.org>

Changes from v9:

  Document the partition hint mask

  Use bitmap_alloc API

  Fixup bitmap memory leak

  Return invalid value if user requests an invalid write hint

  Added and exported a block device feature flag for indicating generic
  placement hint support

  Added statx write hint max field

  Added BUILD_BUG_ON check for new io_uring SQE fields.

  Added reviews

Kanchan Joshi (2):
  io_uring: enable per-io hinting capability
  nvme: enable FDP support

Keith Busch (7):
  block: use generic u16 for write hints
  block: introduce max_write_hints queue limit
  statx: add write hint information
  block: allow ability to limit partition write hints
  block, fs: add write hint to kiocb
  block: export placement hint feature
  scsi: set permanent stream count in block limits

 Documentation/ABI/stable/sysfs-block | 13 +++++
 block/bdev.c                         | 18 ++++++
 block/blk-settings.c                 |  5 ++
 block/blk-sysfs.c                    |  6 ++
 block/fops.c                         | 31 +++++++++-
 block/partitions/core.c              | 44 ++++++++++++++-
 drivers/nvme/host/core.c             | 84 ++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h             |  5 ++
 drivers/scsi/sd.c                    |  2 +
 fs/stat.c                            |  1 +
 include/linux/blk-mq.h               |  3 +-
 include/linux/blk_types.h            |  4 +-
 include/linux/blkdev.h               | 15 +++++
 include/linux/fs.h                   |  1 +
 include/linux/nvme.h                 | 19 +++++++
 include/linux/stat.h                 |  1 +
 include/uapi/linux/io_uring.h        |  4 ++
 include/uapi/linux/stat.h            |  3 +-
 io_uring/io_uring.c                  |  2 +
 io_uring/rw.c                        |  3 +-
 20 files changed, 253 insertions(+), 11 deletions(-)

--=20
2.43.5



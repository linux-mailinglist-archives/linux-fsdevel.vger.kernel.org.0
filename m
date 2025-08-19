Return-Path: <linux-fsdevel+bounces-58330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC1FB2CA78
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 19:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08AD83BC206
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 17:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF173019C0;
	Tue, 19 Aug 2025 17:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="AQqJaPyd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6187F2FFDF0
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 17:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755624117; cv=none; b=rK5QBDLy9YizaobHDFRf8sJHtAFmHqo5TvsFr1IUEezaUUhVc6ZM2GRXOMk5cnHWhHR49FzdZsB9VIBCAf2gG6tuLuSgLF0LNfjLUeur20zBxUAyLhTZzqH4hbXV1hlstYvejJdfPdmwnAiYtUhuYIRifLq8hq5LtskBkyOFuJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755624117; c=relaxed/simple;
	bh=u8CUQOY8/EREFQYCcY9v/DJloGR6JgP5IHbgTrpSkCA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YIkNIzlIq4DzrNb3Xi+O++pGwPC4vp8EPjNti6Ktsd/HQidYZO4T5PV+VFqDCOE5F2cMEBrvAAye0jCdJFtBwefttg245dGjg5ZSaUrqkOqoHmreDd3TxLCxf3SZLNf7l/yuf6qSFKKVCj29JSych4lCcUolnwn9OGaKdUf0ZDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=AQqJaPyd; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 57JFU33H1487476
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 10:21:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=KtCwlMEhG0RsGldP36
	Ve6P74IWk64MUyHAtcgQQUDzk=; b=AQqJaPyd9vJSsaY8zFXsJYfocwBIEwFFxS
	76nthlUQ6vDPSs386508HVdXq84bQQDBATrDLsc0zDHx5r5HivWDbr6aHcvlPV8b
	7C7LxI754W9gQ6TBcFXeeqQqMAFgQA+lOeVtE/jEcBIlcO5vuhC1NCuiIKpkHQ/V
	5wcEU9ocPkGiQDTumDNdDRelnRm4bJJncquiE6eP4P2X7x1OQaPlOw+DjVhg/IQ8
	V4OqLIfZWviESnBTLatLvDbJt9bWaiyPfB7cLsshzAVcsSCeI4mJ7JL4cTG4rN0Q
	u4bFOv0D8/IShKQjjLjUpQpZLb3I2bujBL70WHmRngXaO4I0Eodw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 48muy9153p-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 10:21:54 -0700 (PDT)
Received: from twshared51809.40.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 19 Aug 2025 17:21:52 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 67233C89F1A; Tue, 19 Aug 2025 09:49:48 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <snitzer@kernel.org>, <axboe@kernel.dk>, <dw@davidwei.uk>,
        <brauner@kernel.org>, <hch@lst.de>, <martin.petersen@oracle.com>,
        <djwong@kernel.org>, <linux-xfs@vger.kernel.org>,
        <viro@zeniv.linux.org.uk>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 0/8] direct-io: even more flexible io vectors
Date: Tue, 19 Aug 2025 09:49:14 -0700
Message-ID: <20250819164922.640964-1-kbusch@meta.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE2MSBTYWx0ZWRfXxPOs/gDdcHmm
 FlDHzzHV+l4awfe5po1ELYnmVRhLZQOP6DfTZ7EgcFSItNd8al4tXaqYOJtu7qMhTRMW4PzjLE1
 lVd4ROwyocaewi2WEO8YdwoUIXRQbfOxlOBT93Ft/n46XTZsACb52pnpOV8z6l1ftY605BePl4V
 d68RKi5txLSRt2Z9EKJxyVDIxtHkmd9W/WzHnnWyR6p1oMat1EKDoodPmYQpg9QZ0a7IO/ztffs
 4/S0I8fP6q3zf8Vvd7+vEdbXsRty2KA8rCeDuT8xfOxpF0uYqJbRthiVeYjF4joWyUk8o4fYxyB
 2nATaK64XHmvYfslBLjKzy9S/Wi+UQyru74pTx8gxcwJLUphXsDSbCxJymySWxLPk5vESSFnDxw
 x+9b512kBTqNngmDuHGxsx+iDw6V6gZqQJzWgCisNdz2g8vslcDxe24mX2rRRbJuE/KBZNO0
X-Proofpoint-GUID: WA5PpYnTXpWXq9fHu_37S-ISLC5y1SlJ
X-Proofpoint-ORIG-GUID: WA5PpYnTXpWXq9fHu_37S-ISLC5y1SlJ
X-Authority-Analysis: v=2.4 cv=Qatmvtbv c=1 sm=1 tr=0 ts=68a4b2b2 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=9U2CUVk9dIh-JB3WyvAA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

Previous version:

  https://lore.kernel.org/linux-block/20250805141123.332298-1-kbusch@meta=
.com/

This series removes the direct io requirement that io vector lengths
align to the logical block size.

I tested this on a few raw block device types including nvme,
virtio-blk, ahci, and loop. NVMe is the only one I tested with 4k
logical sectors; everything else was 512.

On each of those, I tested several iomap filesystems: xfs, ext4, and
btrfs. I found it interesting that each behave a little
differently with handling invalid vector alignments:

  - XFS is the most straight forward and reports failures on invalid
    vector conditions, same as raw blocks devices.

  - EXT4 falls back to buffered io for writes but not for reads.

  - BTRFS doesn't even try direct io for any unusual alignments; it
    chooses buffered io from the start.

So it has been a little slow going figuring out which results to expect
from various tests, but I think I've got all the corner cases covered. I
can submit the tests cases to blktests and fstests for consideration
separately, too.

I'm not 100% sure where we're at with the last patch. I think Mike
initially indicated this was okay to remove, but I could swear I read
something saying that might not be the case anymore. I just can't find
the message now. Mike?

Changes from v2:

  Include vector lengths when validating a split. The length check is
  only valid for r/w commands, and skipped for passthrough
  DRV_IN/DRV_OUT commands.

  Introduce a prep patch having bio_iov_iter_get_pages() take the
  caller's desired length alignment.

  Additional code comments explaing less obvious error conditions.

  Added reviews on the patches that haven't changed.

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
 block/blk-merge.c      | 20 +++++++--
 block/fops.c           | 13 +++---
 fs/iomap/direct-io.c   |  6 +--
 include/linux/bio.h    | 13 ++++--
 include/linux/blkdev.h | 20 +++++----
 include/linux/uio.h    |  2 -
 lib/iov_iter.c         | 95 ------------------------------------------
 10 files changed, 94 insertions(+), 145 deletions(-)

--=20
2.47.3



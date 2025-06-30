Return-Path: <linux-fsdevel+bounces-53314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A606AED832
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 11:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DDBA3A585F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 09:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F3224469C;
	Mon, 30 Jun 2025 09:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AkxU8CAn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB9823B63D
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 09:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751274533; cv=none; b=kAC1WLdLJbqdnUwp32FSrPmf6iH1VPLvW0jiP7R98EkQsiYVixgNWwcsVAZ/3Dj/PjTGzaJLKA0PYVOBfg7xdjE6Sy8EByNN3+PAyVNi/g9bKr0Le/aNqmw53AUAztstazmkQ7QwH4BLeI2TuDOhZaywJA5O0ObJEzCyPeOCOJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751274533; c=relaxed/simple;
	bh=JYH8KYXiVde6jihot4RcOkySptuG4EStrz3h8Ir18ZY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=ssPnvzJV27uSK/Wd+5Nr1wGjggvmcWp0/8hWe3kZXIKSz8revLATqS84O9YfMjnu1V6FYpwLHKxL4tmiD1hHABPQMFCZnfy/gBwLA6/sH5PLG5H6p3beW/2IDWnPyuodRczR+trzgWdefo5JF37MEE8u/qyw8YsaWUzFU49zrNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=AkxU8CAn; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250630090842epoutp04563dac4fbbe73c429e4319b6299c0d3b~NxuZSc98u2313223132epoutp04T
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 09:08:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250630090842epoutp04563dac4fbbe73c429e4319b6299c0d3b~NxuZSc98u2313223132epoutp04T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751274522;
	bh=GgS+k17VlS3z5f+lStV0zi9JYkR/O/BiLDiSucjLPyA=;
	h=From:To:Cc:Subject:Date:References:From;
	b=AkxU8CAnHa1JkUGk9Sr6h5b2fSI7LyS86MEPkxgOB9QbGJRQrTLwvaQLCJdDWOppT
	 pTfq3iHN1mC+AZpio0d0Q2wg23Ix6IYrkSEJ2klo+X2KC+ngrOBfYtygB4Ix5Z15HT
	 CdKNlVwU1pCOaJSx6k4m6QLLNHoz0+l4O98DNnBM=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250630090841epcas5p4d240f5b83654cef1436b16dc399f8cb3~NxuYr60gy2849528495epcas5p43;
	Mon, 30 Jun 2025 09:08:41 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.174]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4bW0h84NnGz3hhT9; Mon, 30 Jun
	2025 09:08:40 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250630090606epcas5p42edec1dfe34f53c9f1448acb0964bb8f~NxsHinA8m1010310103epcas5p4O;
	Mon, 30 Jun 2025 09:06:06 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250630090603epsmtip2ad17b3a3e395080ea4a974cffd9163a8~NxsFZLARt1109511095epsmtip2X;
	Mon, 30 Jun 2025 09:06:03 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: vincent.fu@samsung.com, jack@suse.cz, anuj1072538@gmail.com,
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org,
	hch@infradead.org, martin.petersen@oracle.com, ebiggers@kernel.org,
	adilger@dilger.ca
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com, Anuj Gupta
	<anuj20.g@samsung.com>
Subject: [PATCH for-next v5 0/4] add ioctl to query metadata and protection
 info capabilities
Date: Mon, 30 Jun 2025 14:35:44 +0530
Message-Id: <20250630090548.3317-1-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250630090606epcas5p42edec1dfe34f53c9f1448acb0964bb8f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250630090606epcas5p42edec1dfe34f53c9f1448acb0964bb8f
References: <CGME20250630090606epcas5p42edec1dfe34f53c9f1448acb0964bb8f@epcas5p4.samsung.com>

Hi all,

This patch series adds a new ioctl to query metadata and integrity
capability.

Patch 1 renames tuple_size field to metadata_size
Patch 2 adds a pi_tuple_size field in blk_integrity struct which is later
used to export this value to the user as well.
Patch 3 allows computing right pi_offset value.
Patch 4 introduces a new ioctl to query integrity capability.

v4->v5
add a pad field in the user structure to align it (Christoph)
get rid of overly long lines (Christoph)
add missing nvme prefix to the patch desc (Christoph)

v3->v4
rename tuple_size to metadata_size to inflect right meaning (Martin)
rectify the condition in blk_validate_integrity_limits when csum type is
none (Christoph)
change uapi field comment to more friendly formats (Christoph)
add comments regarding ioctl behaviour when bi is NULL (Christoph)
remove the reserved fields and use different scheme for extensibility
(Christian)
Other misc code improvements (Christoph)
set pi_tuple_size and pi_offset in NVMe only if csum type is not NONE

v2->v3
better naming for uapi struct fields (Martin)
validate integrity fields in blk-settings.c (Christoph)

v1 -> v2
introduce metadata_size, storage_tag_size and ref_tag_size field in the
uapi struct (Martin)
uapi struct fields comment improvements (Martin)
add csum_type definitions to the uapi file (Martin)
add fpc_* prefix to uapi struct fields (Andreas)
bump the size of rsvd and hence the uapi struct to 32 bytes (Andreas)
use correct value for ioctl (Andreas)
use clearer names for CRC (Eric)


Anuj Gupta (4):
  block: rename tuple_size field in blk_integrity to metadata_size
  block: introduce pi_tuple_size field in blk_integrity
  nvme: set pi_offset only when checksum type is not
    BLK_INTEGRITY_CSUM_NONE
  fs: add ioctl to query metadata and protection info capabilities

 block/bio-integrity-auto.c        |  4 +--
 block/blk-integrity.c             | 54 +++++++++++++++++++++++++++-
 block/blk-settings.c              | 44 +++++++++++++++++++++--
 block/ioctl.c                     |  4 +++
 block/t10-pi.c                    | 16 ++++-----
 drivers/md/dm-crypt.c             |  4 +--
 drivers/md/dm-integrity.c         | 12 +++----
 drivers/nvdimm/btt.c              |  2 +-
 drivers/nvme/host/core.c          |  7 ++--
 drivers/nvme/target/io-cmd-bdev.c |  2 +-
 drivers/scsi/sd_dif.c             |  3 +-
 include/linux/blk-integrity.h     | 11 ++++--
 include/linux/blkdev.h            |  3 +-
 include/uapi/linux/fs.h           | 59 +++++++++++++++++++++++++++++++
 14 files changed, 195 insertions(+), 30 deletions(-)

-- 
2.25.1



Return-Path: <linux-fsdevel+bounces-52008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB13ADE336
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 07:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 501D43A5D2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 05:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF6B1FCF41;
	Wed, 18 Jun 2025 05:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aAOLhqhy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471821E5B60
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 05:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750225969; cv=none; b=A0LkJXdMdQcTX4gi62rmYsGxKVz57iwh5P1u2eoDA6sF7FuABRITI2cKYN7CzZUedxVlY0XhbMFjAyWr8Jmbw4pgwLIlaBfIIAvV2tVJoh0j6TJmp24E9hxcowREzeMhzWrSBa7Vp88mSeIC9oK9CxBXa4KoZM+WvfBNRr311hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750225969; c=relaxed/simple;
	bh=BuOv1tP2vKVvDWNIWwXAqWP69Va9MNtYy6TXp2uG75Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=YSiVzWvmDr0eMOOLIrreni4xxdlmjPRQ0S+vHTcoD6ZvjmIKkUhmXQFAuAA+hBWqyzMa1BQ3kslBBJsfuaxcObQqbTmV6dzk8/9nf/jFRsFcLp60yNBZrF4d5V3eDFoCaiPgu7gM0qWlU0q95YL+P8onvfHKpdcTV6kQlKbtF9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=aAOLhqhy; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250618055245epoutp01a1fb599ec3823bdb01c445779e844f2c~KDT4ASWWR1092910929epoutp01z
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 05:52:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250618055245epoutp01a1fb599ec3823bdb01c445779e844f2c~KDT4ASWWR1092910929epoutp01z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750225965;
	bh=AOP00Fc2F9qiSQmOiA4tBYgC5vacOd3AhpFCbS+QFf0=;
	h=From:To:Cc:Subject:Date:References:From;
	b=aAOLhqhy+8kWXebUX2kjKAUEbQ5eiAsM+bcM1mphbBNATPBN9roEinhTpWc8e+xz/
	 UTpiZ2eJxd14dkqv9fEUYEUxGwZa0ME2IHt5jYXPn2ddBCPNuLRiOsmMAtBWUDoKCd
	 EWfxugLF03L5Q6+c93IlKDImOpPBfGmkfqSjQudE=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250618055244epcas5p21028bfe100b6e774490d4a7d06c69f84~KDT3GFXw92873428734epcas5p2W;
	Wed, 18 Jun 2025 05:52:44 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.180]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4bMXvZ34bfz3hhTJ; Wed, 18 Jun
	2025 05:52:42 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250618055210epcas5p397b5ca1dc472e3008af707391a5fa628~KDTXvhuhH2388423884epcas5p3N;
	Wed, 18 Jun 2025 05:52:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250618055208epsmtip25a760335121f4cf32d5bf2c18a82aad7~KDTVpu8533161231612epsmtip2S;
	Wed, 18 Jun 2025 05:52:08 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: vincent.fu@samsung.com, jack@suse.cz, anuj1072538@gmail.com,
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org,
	hch@infradead.org, martin.petersen@oracle.com, ebiggers@kernel.org,
	adilger@dilger.ca
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com, Anuj Gupta
	<anuj20.g@samsung.com>
Subject: [PATCH for-next v4 0/4] add ioctl to query metadata and protection
 info capabilities
Date: Wed, 18 Jun 2025 11:21:49 +0530
Message-Id: <20250618055153.48823-1-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250618055210epcas5p397b5ca1dc472e3008af707391a5fa628
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250618055210epcas5p397b5ca1dc472e3008af707391a5fa628
References: <CGME20250618055210epcas5p397b5ca1dc472e3008af707391a5fa628@epcas5p3.samsung.com>

Hi all,

This patch series adds a new ioctl to query metadata and integrity
capability.

Patch 1 renames tuple_size field to metadata_size
Patch_2 adds a pi_tuple_size field in blk_integrity struct which is later
used to export this value to the user as well.
Patch 3 allows computing right pi_offset value.
Patch 4 introduces a new ioctl to query integrity capability.

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
  set pi_offset only when checksum type is not BLK_INTEGRITY_CSUM_NONE
  fs: add ioctl to query metadata and protection info capabilities

 block/bio-integrity-auto.c        |  4 +--
 block/blk-integrity.c             | 54 ++++++++++++++++++++++++++++++-
 block/blk-settings.c              | 44 +++++++++++++++++++++++--
 block/ioctl.c                     |  4 +++
 block/t10-pi.c                    | 16 ++++-----
 drivers/md/dm-crypt.c             |  4 +--
 drivers/md/dm-integrity.c         | 12 +++----
 drivers/nvdimm/btt.c              |  2 +-
 drivers/nvme/host/core.c          |  7 ++--
 drivers/nvme/target/io-cmd-bdev.c |  2 +-
 drivers/scsi/sd_dif.c             |  3 +-
 include/linux/blk-integrity.h     | 11 +++++--
 include/linux/blkdev.h            |  3 +-
 include/uapi/linux/fs.h           | 45 ++++++++++++++++++++++++++
 14 files changed, 181 insertions(+), 30 deletions(-)

-- 
2.25.1



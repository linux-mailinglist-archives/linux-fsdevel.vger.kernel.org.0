Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFC62806E9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 20:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733113AbgJASjI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 14:39:08 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24680 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733085AbgJASjD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:39:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601577543; x=1633113543;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NV5uXusiJdcbhwTsDSi3QoePq27Ek8RGGCfo9PXzbOs=;
  b=pIeJ/7x2BlS8H1OI0QARZfUuy241k1QNpU5n629PvtL2YkQBYmjDVTlI
   W4+FR+RGw2FzxxdznT3Ry6b6bnVbRFEoUJ6wxQ5gC3a5437CEMd9TVQYR
   I7C0sBrV2skr3/UI5NDgck2Xvx4QioU/BmgMkuG20ZhnxC+42/ZeTPYQm
   z1MZYvpBgcxmCEtznomUaTmicimGj7LRO/ZkyBn8aaZdx+zwq70pMN0aL
   uOwa3mK1P9FmNcSNqclCRX3LKyhwKvcX9C7pUAvtjlNhn1OFvwdgQTBnJ
   V6yd+j9Hz6mo6WFvXzLsKSvQ9pjcQeZpBIr3QXSsSYHv7eOFMZ48C6DBR
   g==;
IronPort-SDR: Lfq83t8VEJHgC3xGrGSjHcLJK+f9X1i4X8UVoPLQmJZmZpPj4aybdM7m5ucYzZGPmdNbB7tY1P
 9kSh6jYLnIcg8fsMGJ9Ao6AEaHaGorc6zjm3qwpCZjIsQC2oG2KqXDweQyNje6BoBN+iSf9kx7
 tIvbK6dSOhu1uzTr6uoUQlmuOl8/FPkYmCQPZFNQWCwypxQS70F5hQ+pEyJaxmA8NxS+JreZQh
 DdxK+pFj8f7B2//LY/DX8lvF4wSjP6tKe9caovDXuEvDBpfjRi9xQ8mCI5ik4IHnkCG4P3JpLP
 BmY=
X-IronPort-AV: E=Sophos;i="5.77,324,1596470400"; 
   d="scan'208";a="150036826"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 02:38:37 +0800
IronPort-SDR: CXMtjfo3MG8sABznyQFz6O1BNVhMHI3oUnC7Fa4LOdDwiAdLwbeisV/WMkkivst2uYrGkCh1Iq
 QAlsotS17/cQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 11:24:33 -0700
IronPort-SDR: pDVH33KBuAZwEOR7oDJsbeyuV1LTz7tSX65ZnF5hmbdh0QqBngZS+nTkMn9YI8VqeLOeomFZUA
 M8qb+3mQSiJQ==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Oct 2020 11:38:36 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v8 30/41] btrfs: avoid async metadata checksum on ZONED mode
Date:   Fri,  2 Oct 2020 03:36:37 +0900
Message-Id: <d5d67df81d6fe0f602948f9f65ed64c361b567b3.1601574234.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
References: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In ZONED, btrfs uses per-FS zoned_meta_io_lock to serialize the metadata
write IOs.

Even with these serialization, write bios sent from btree_write_cache_pages
can be reordered by async checksum workers as these workers are per CPU and
not per zone.

To preserve write BIO ordering, we can disable async metadata checksum on
ZONED.  This does not result in lower performance with HDDs as a single CPU
core is fast enough to do checksum for a single zone write stream with the
maximum possible bandwidth of the device. If multiple zones are being
written simultaneously, HDD seek overhead lowers the achievable maximum
bandwidth, resulting again in a per zone checksum serialization not
affecting performance.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/disk-io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 87c978fecaa2..5ce5b18f9dc4 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -813,6 +813,8 @@ static blk_status_t btree_submit_bio_start(void *private_data, struct bio *bio,
 static int check_async_write(struct btrfs_fs_info *fs_info,
 			     struct btrfs_inode *bi)
 {
+	if (btrfs_fs_incompat(fs_info, ZONED))
+		return 0;
 	if (atomic_read(&bi->sync_writers))
 		return 0;
 	if (test_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags))
-- 
2.27.0


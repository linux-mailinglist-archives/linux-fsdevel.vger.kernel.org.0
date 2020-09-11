Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F144E266757
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 19:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgIKRls (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 13:41:48 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38415 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbgIKMkS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:40:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599828017; x=1631364017;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WmMbx7y4lRUJiChOmOKWKn0KLU8szrq48BUWvF+sBVc=;
  b=DNg2WY4nwGkdqG8F1sWYPJZL/xTP5g2TyFXVq57nt9voWdYk8/UZOgSv
   rCIogvycYsfWG/Uls15901Pnt/yvzHxIIHFsKV7Qnhf8P8y6Wj9PIijXH
   BGWIhyYXZ9DAlJxDseP+ySdzGvZFdWPnJoimvsYg8DD7sHx4aCGlt8rPR
   rwnODeEwJEftfk9F9yE4E1Fu6VGF6rhu4szHE64Kx64+8wBWVbeFBqfar
   jL69JTw3gn+QeRO+UOU38bcnUHj3dvfA5XztZCXIfiQZTU3qG6I25HyCf
   K20D2muM690g4DP5EnzQGkmb8C9BrwMBMetFEGZJXHFtCGa7rtNHKa+6j
   Q==;
IronPort-SDR: ykGp51hbU/scfFrV6LpAyLLhCQ5ctkgsODmk+VhSp/3eBQKkHqZg0SSelWowV0B6hVKJ3Xtc7n
 JDY5oBSwjWHgz7/q+gS+3Qhb1jPJwfK/5cacAFY+HUEAS5BL9XzNN7c8H+rgf5MwlROIcy7Gw1
 TvvhU+zvGyUWhuYuGVN9l/WdiF4ZlMpZQUSmJYOaiQXjAab0JuOHmKu9XLJIBCPDlH2jlWVRjF
 0yiXWA3i3scHEMa6Wr9tdLm/REIz4KcBQaoKK7tQuRcEUQfpRScAIpSLn9yTb+wg7vt3Lail11
 +oA=
X-IronPort-AV: E=Sophos;i="5.76,415,1592841600"; 
   d="scan'208";a="147126020"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 20:33:48 +0800
IronPort-SDR: imGcMdtZHSEEU4X0gKlgjSx0KPp6M+zMmPK/x5TPEEqwGxy9kV/aKHBzdspaisjBLtS7I7VIMO
 Jbz7xE63pEDA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 05:20:09 -0700
IronPort-SDR: AI+qUQYruDYibBbPGDNJoVVnha4hHdpm2jSmB0DtrWHFjuqoJzyem5OoqTXIlChgvmLdjZtfdF
 I2S8rXaYmn2w==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2020 05:33:46 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v7 28/39] btrfs: avoid async metadata checksum on ZONED mode
Date:   Fri, 11 Sep 2020 21:32:48 +0900
Message-Id: <20200911123259.3782926-29-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200911123259.3782926-1-naohiro.aota@wdc.com>
References: <20200911123259.3782926-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
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
index a50436d89d30..cd768030b7bb 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -865,6 +865,8 @@ static blk_status_t btree_submit_bio_start(void *private_data, struct bio *bio,
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


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 228C7265FA7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 14:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgIKMih (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 08:38:37 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38370 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgIKMgl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599827800; x=1631363800;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AxoyH1Na5xYglRGmAc7fmJ7ZNxnXvK3wCr4zK84pZ9A=;
  b=em5Fejbz++rLvzV10/EHR55fxAXbaU0S2lxM2pzoClfRFnNTonhJZw//
   UzCl4PIJ03YivLUI72ynkTuPdIyVD8NcaKG98Lw8F1Fdl1W2fRUYmItBy
   71eo/2jy+chuQ59ey6L1UL4FllqQXGKcXaEHbKpoTJ9T4m/Iy43nlkLn/
   NUtYImfcvCzsKQ3f1axn05lAMCYaOCnC07XOOyX1+DbeJvozdsVjXLHWz
   Y5hoYVtWwUMGUVzoepQkzVWfax7qFM9QsTvUEZtVCktF1BYLyH894D3Nc
   3NDLevie/BQ08+4fpa7+rh0xxNkF10oyudVOAN6fQRFVsIrmUNbqxVIza
   w==;
IronPort-SDR: A8wajh9IrX2Jt8nLeYBpMgmO+OjbF2i5xr1MslPifeXBlRa4Pp4L8PTlzk1GBTMhDmAbtu7Rel
 ZHJmJ1s4peRLH12ninQ+7X5Oseuft7l0JnKIq6krhC7TD6mtEN1uWTdDCzs50qNiskzAR+R6vs
 PS3gauwqJGhn/fcYj70A70xcpxbAVefa7r3m2sYPAtoZncnpokNyJI+OfjkSen7H2PiFdCHRYq
 wNoRrOGGHGMNa8jmb3RKqi3hQIYpQsLk4EHKeqBZ900fsmGOJlwAiSuKfWFAfL6PH8DQX5W1JT
 AR0=
X-IronPort-AV: E=Sophos;i="5.76,415,1592841600"; 
   d="scan'208";a="147125998"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 20:33:35 +0800
IronPort-SDR: c7PbvuJAVNI94CL4KAYnPJYa5Fs49JynyzidPEYoHlBIiceGnzJv2aFykFx5J7dsR8nSxmf0rT
 cQ4XvnyrSTJg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 05:19:56 -0700
IronPort-SDR: VqqENO74fcIR3IHgKtmZABoXjVVU6Em/Tr/SQXuHGpR0hzyZ2NxTkJmqO5z4c0klfsj0FJDRMv
 WTnKweeSzXdw==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2020 05:33:33 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v7 19/39] btrfs: limit bio size under max_zone_append_size
Date:   Fri, 11 Sep 2020 21:32:39 +0900
Message-Id: <20200911123259.3782926-20-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200911123259.3782926-1-naohiro.aota@wdc.com>
References: <20200911123259.3782926-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Zone append write command cannot exceed the max zone append size. This
commit limits the page merging into a bio.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent_io.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 53bac37bc4ac..63cdf67e6885 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3041,6 +3041,7 @@ static int submit_extent_page(unsigned int opf,
 	size_t page_size = min_t(size_t, size, PAGE_SIZE);
 	sector_t sector = offset >> 9;
 	struct extent_io_tree *tree = &BTRFS_I(page->mapping->host)->io_tree;
+	struct btrfs_fs_info *fs_info = tree->fs_info;
 
 	ASSERT(bio_ret);
 
@@ -3058,6 +3059,11 @@ static int submit_extent_page(unsigned int opf,
 		if (btrfs_bio_fits_in_stripe(page, page_size, bio, bio_flags))
 			can_merge = false;
 
+		if (fs_info->max_zone_append_size &&
+		    bio_op(bio) == REQ_OP_WRITE &&
+		    bio->bi_iter.bi_size + size > fs_info->max_zone_append_size)
+			can_merge = false;
+
 		if (prev_bio_flags != bio_flags || !contig || !can_merge ||
 		    force_bio_submit ||
 		    bio_add_page(bio, page, page_size, pg_offset) < page_size) {
-- 
2.27.0


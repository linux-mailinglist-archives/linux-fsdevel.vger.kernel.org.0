Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD51726676A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 19:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgIKRml (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 13:42:41 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38372 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgIKMgw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:36:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599827812; x=1631363812;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6DLiwTztLtmP5Fw1686Z6IAlkdY2BsouY3JllIlppog=;
  b=eLEc2LJYDo1IkAib2ZaFQwG6n8PdKd8RYGFOwOs3T5aVgvp62yYXKtiY
   BT38WuEyJejX8jCdPEePJ1Vs26nh8TT5wYlCzTlGOR8lpBSs8GOPeV7zY
   8kNcOBD2WngzsNRGAD2RTwLcChe28HuCaTsWg4Qc0d6TF1cPOvnlwHjQV
   jhPNPpXIldaQANjc2P4sj71Fh4UtCUnZvQ2aL52ZHBsNHCOPGzB4HKwG+
   ipOFmf6UFp8KlAvcUWGHb3ru6jVJIvTm0oWT0s0i27QmVKfMrF1nXkqcZ
   hl1mYI1IBxUBbSKax4EzEVZPRKFY3JUrnEMIhIrj25ZfQocfTA0FA6HiB
   g==;
IronPort-SDR: h5Wt0oXj/NvcFzAegdzH81KIpIJ+2V/9F1/JHtH4ubH8ILIOJUJrTpFLCFcSVNh1mo2/Dn8OXn
 S2HvFRXclK/5cbaC4ZIu6yzGSOg4xwyihqwp8Y+DXFew0rGj0ubspX2QpPf/bHtdjCF7xw3Lpw
 BGeGRY14NZAn32FBoGfTnrnW7gVRMk+Fm/x1Na08WS//lcCbnjfF+cMepVmVWUE20U4+Ts7f+9
 T3OZNXYlSlCbNP1KlXWrbqL5h+dcteME9sRTY5q9IP5kqutaytYj3NTkB7plyjTBRp81sedFdH
 QZI=
X-IronPort-AV: E=Sophos;i="5.76,415,1592841600"; 
   d="scan'208";a="147126001"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 20:33:37 +0800
IronPort-SDR: eKB6jaVxIqKnxUXDP5xlHVsFeMDDdSQ/iiEOPAZLep6NS+2kpoEmceFRPKCEirzi33uasIrkYT
 TKDqYKwcYHfA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 05:19:57 -0700
IronPort-SDR: fNzYYCNYxjsUkKElF/FQg16xwkHLyCh2lhTj83Nm2XxOKcrw/Rz2HfkFjcPssF79rmNajI0U57
 9RVG7XlDBJQg==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2020 05:33:35 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v7 20/39] btrfs: limit ordered extent size to max_zone_append_size
Date:   Fri, 11 Sep 2020 21:32:40 +0900
Message-Id: <20200911123259.3782926-21-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200911123259.3782926-1-naohiro.aota@wdc.com>
References: <20200911123259.3782926-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With zone append writing, the logical address must be modified to match the
actual written physical address. If multiple bios serve one ordered extent,
the bios can reside in a non-contiguous physical region, resulting in the
non-contiguous logical region. It is troublesome to handle such a case, so
one ordered extent must be served by one bio, limited to
max_zone_apend_size. Thus, this commit limits the size of an ordered extent
as well.

This size limitation results in file extents fragmentation. In the future,
we can merge contiguous ordered extents as an optimization.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent_io.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 63cdf67e6885..c21d1dbe314e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1865,6 +1865,7 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 				    u64 *end)
 {
 	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	u64 max_bytes = BTRFS_MAX_EXTENT_SIZE;
 	u64 delalloc_start;
 	u64 delalloc_end;
@@ -1873,6 +1874,10 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 	int ret;
 	int loops = 0;
 
+	if (fs_info && fs_info->max_zone_append_size)
+		max_bytes = ALIGN_DOWN(fs_info->max_zone_append_size,
+				       PAGE_SIZE);
+
 again:
 	/* step one, find a bunch of delalloc bytes starting at start */
 	delalloc_start = *start;
-- 
2.27.0


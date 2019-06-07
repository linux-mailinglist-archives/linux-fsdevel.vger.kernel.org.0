Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD0A238B21
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 15:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbfFGNLu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 09:11:50 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:53172 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729358AbfFGNLt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 09:11:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559913109; x=1591449109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G3/Vp9VLrbcnr4kDWzhgsEYPsCzzkH9MlcwAXXNhHIo=;
  b=c8At71QNzQX/coXo2dMike0BNOtREKGvOTTFplmHO3GmmA05Rc06jl1c
   xVgpreB729Xsh7CKdhRykCUiWmEtYTMStfTVa6G5UJlEyYBpCNxAJQUxw
   QegiWMMXCJGrFNzbmg37B+and7XNDA1hEO9Qs1hqLuc8g/UwFixRfntxY
   7gplsbkF5y3RQdJE9YODjQv75rq9ZjfqQSPazfMUYeH8v6FjbExFALKJB
   SF1b2u3NmARADPjfVr3OLf8N1/JDoGrKT5Oq0WUTTYldqMglIPeCIR39y
   ovCNJuxJDtZ+gt6Li++y3RK9GoNAjYSsXzcqXt6ktEgzngBcYTLUpWPVk
   A==;
X-IronPort-AV: E=Sophos;i="5.63,563,1557158400"; 
   d="scan'208";a="110027830"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2019 21:11:49 +0800
IronPort-SDR: 9HRUwnprtHIERKiJEx5srnFM0FYVpgMfJ4KbrNjIqOozau4YZsyi4TQhgZBMGz6F4S20Qye2z5
 YgaTKQ45qY+xGXDXKO8MJ3NVe1NwFWLtpm/DiqayyCml7Q6BtORZY6cXt07C2cvpWld4PRppjY
 lJDlwB16NsEtXhC8uokTsq+RoHPinq+jEp33ngdG/fa3hyvWYoepnn+TIcafK+kVlsvdb+iAT+
 nk/4yXaJciC0DkdWcYFwyUp35kFmw+OguiIc5Y51SKvJdNMQruNZXldpSPHRw+IdoD8E3Bc4Ge
 HkMR3Uhd8CQ91nxIcyx0bgYD
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 07 Jun 2019 05:49:06 -0700
IronPort-SDR: ZwcGTQv9TuHReFMxKoQ8KBHBcJz3oTri1VPGAZ0U2gxiK1TvAiEca/JACj07y+j4Q4Y/Isiy4D
 CNnhp892FCdZR249ARAbn+daosKOHxSOTwxPTE62Bt56vekU3GnfjQNq2TjK5BIH/R11svxlGA
 JesDCp5XQ9x5qVXj57ahV7xf9nJGsBIWCpraViQ7DJ5uhO62jHZaJ2wnS8mDFewTwB3K2h+O/j
 5mzp9jv292y7jVTYo3PfhkfXLSZw7oMknNjx+Xfwmf9pT2o1umymTJUgZm72RszVcE67QWou+c
 3ws=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 06:11:47 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 16/19] btrfs: wait existing extents before truncating
Date:   Fri,  7 Jun 2019 22:10:22 +0900
Message-Id: <20190607131025.31996-17-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607131025.31996-1-naohiro.aota@wdc.com>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When truncating a file, file buffers which have already been allocated but
not yet written may be truncated.  Truncating these buffers could cause
breakage of a sequential write pattern in a block group if the truncated
blocks are for example followed by blocks allocated to another file. To
avoid this problem, always wait for write out of all unwritten buffers
before proceeding with the truncate execution.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/inode.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 89542c19d09e..4e8c7921462f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5137,6 +5137,17 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 		btrfs_end_write_no_snapshotting(root);
 		btrfs_end_transaction(trans);
 	} else {
+		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+
+		if (btrfs_fs_incompat(fs_info, HMZONED)) {
+			u64 sectormask = fs_info->sectorsize - 1;
+
+			ret = btrfs_wait_ordered_range(inode,
+						       newsize & (~sectormask),
+						       (u64)-1);
+			if (ret)
+				return ret;
+		}
 
 		/*
 		 * We're truncating a file that used to have good data down to
-- 
2.21.0


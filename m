Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEC438B2C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 15:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbfFGNLZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 09:11:25 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:53165 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729052AbfFGNLV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 09:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559913081; x=1591449081;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Sceo+E3qPLPcf84lMk/uwJwqo0EhyjB73konNzrUp0U=;
  b=nRDRC0+9/ZqL7o5LijwfvLGmhVQagD8pC0NoD6oPEaffmrwAiCYoNlum
   IL9KmCT5L5sCb616+Bf2tlWoAXt22BVNQQ2R/SvlIZ1ogkJrK49xyZGpA
   9/eGKX0/w1xoE0ynjvgNPxut+bcDPhWhaMN/ZtolcRGYQoHmJ0QHZT86/
   Fu9oXNXTM5/L2o+GTdiGKa5aynekNiOWHiF/SQa4uS7zOo83roERBOHa/
   QLCgYmxwFNp4p6jG3mWHHYfOjs8bhhVmOhBPz3mzWQtrm1OoTuYPCIW5d
   s9LdVQftFPViZVRqesp3pL0ld6A0cFKSOMmwEZWLQQ9xNBez+fiduTB3i
   A==;
X-IronPort-AV: E=Sophos;i="5.63,563,1557158400"; 
   d="scan'208";a="110027777"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2019 21:11:21 +0800
IronPort-SDR: PgjCzsjCngKeHtkpHB6v/6nAfh2E+la86qnVmyMmonkjaUb3+U1viEfGdnYyn5gPopchosiPRx
 pmp5ukB/FYPwXAQS7JbBcwc0mk6hK1ORRUlZkDC6JEYb1EuP09qBcZOXvOP21wIlwW30yxTmcW
 ctoJpHCyNYEZpHFdEbj+g+Mklaj5ZPEsXfYSdgKufl5UnrPWuADnOEX4pcvWuAZ8/dc6ggbx71
 2oY2pHlAKCMn6E0z6MB6ZwtWxcMlfytE7US14pamjQH60pVflMcz6rlYd8/CbWe/cDQC2rPo1u
 yYiZF/h2KGKKr23KW2a38tWf
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 07 Jun 2019 05:48:38 -0700
IronPort-SDR: 5ucARHwTib91o21SkMfarKE2KT4zGnVxo8EVkI21T36K4fSonyOo3Xu5NjiqAVPJrbuMVyiQvP
 6iyQaugsHN91BVlRA6GdFB6ryWu9GZeD8KdPC+V2m+s3n7RdMSLpZhUUqMe0mrcC5pM+kzeEFt
 E/M5VRqrj+cCG4OLKVK9u90ntv3gB8ZLNc22JG9b0XeEN6iA4Ot0G3oeDykf4fjm7mGGTerptv
 KqX3M0mmEbuxDfUWqbEdDfLCls0DikrDjDTzWtxUnUXEpxusBOjIAZIoEobzh72gh2tvKk9PXr
 FTc=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 06:11:19 -0700
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
Subject: [PATCH 04/19] btrfs: disable fallocate in HMZONED mode
Date:   Fri,  7 Jun 2019 22:10:10 +0900
Message-Id: <20190607131025.31996-5-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607131025.31996-1-naohiro.aota@wdc.com>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fallocate() is implemented by reserving actual extent instead of
reservations. This can result in exposing the sequential write constraint
of host-managed zoned block devices to the application, which would break
the POSIX semantic for the fallocated file.  To avoid this, report
fallocate() as not supported when in HMZONED mode for now.

In the future, we may be able to implement "in-memory" fallocate() in
HMZONED mode by utilizing space_info->bytes_may_use or so.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 89f5be2bfb43..e664b5363697 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3027,6 +3027,10 @@ static long btrfs_fallocate(struct file *file, int mode,
 	alloc_end = round_up(offset + len, blocksize);
 	cur_offset = alloc_start;
 
+	/* Do not allow fallocate in HMZONED mode */
+	if (btrfs_fs_incompat(btrfs_sb(inode->i_sb), HMZONED))
+		return -EOPNOTSUPP;
+
 	/* Make sure we aren't being give some crap mode */
 	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
 		     FALLOC_FL_ZERO_RANGE))
-- 
2.21.0


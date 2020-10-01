Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80C02806C4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 20:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732845AbgJASiL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 14:38:11 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24680 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732824AbgJASiL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601577491; x=1633113491;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ActMtzcr2+7CfSK+3pP+twewHCLI8xF4oYxSkgupwuk=;
  b=rS1+fKrRFhUXZ5uOgPpX9eg8m69SompI7aVVkt+Uq7JvG22no7VQNwG1
   hscuRt6li2v5tZTWbSGtfo7OTZeOQSFr7XcKC1jDBP5VBMdpg5N2VIMk4
   2XDQQDkI9VZnHRz7OpLPBFgk2giC+qtktXfvqBjj/WBI3S7snSicIp0Fl
   jyid5ehJqzOnSS1U1swbw1RtlEKbd+eISRrrZa1cr8Me2szauUYfRSpLu
   HsaBQy4W8cNQeeiShfIPY3qAXJvluVwUrBpErcllXVUCya89EfLlBeDtu
   Y7uGU7NU2dosacjwwIa8+jgz1QLi1BG862S/yHC430JSt5XxGEDzUR+l9
   Q==;
IronPort-SDR: AM+vEakLdT4pLB6LCzitXCrLfZwAVtxwEWzvrO1qvlrnY23Ikf5/bMQAkRYaAUZdkahSGdlk3+
 Chj2QMcRH//4DQ05401ercVgYFurVGkRixYjM02luZCo8j5zMUkhtUE6EWU0mpiyjpIlbCvGVK
 u4VQVSBwx+xaEZcfBjXqRuKiE98CLHaXlovaRrev6Oj3IPXrhuAMTfRQ+ww+g3PYCUC9ZZza/h
 0ViE+Bp7SVg3BosFZuHquRULgV7ZhBZ2yxszUgGJbX85boOLFcDIWPsKNI64z9LHA3Vk4cyN9R
 ZfE=
X-IronPort-AV: E=Sophos;i="5.77,324,1596470400"; 
   d="scan'208";a="150036783"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 02:38:10 +0800
IronPort-SDR: k7gW9FdvLEDLLJuXYcv+OWevNY5JqQCI/IPxxnQbu8BR+SPNVNkGWRgt+Rbc2JcsQz1dMDj96y
 M4oSPOjau+Cg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 11:24:07 -0700
IronPort-SDR: CF+VKRvEaJIZFwSeA1Ik/8Jn3Pl19e6O+TZl92PM5bewCS+jAL1gIwx2OF7V0ADDGCkKskLWki
 KV4Oav8rfILw==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Oct 2020 11:38:09 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v8 08/41] btrfs: disable fallocate in ZONED mode
Date:   Fri,  2 Oct 2020 03:36:15 +0900
Message-Id: <3743047aa305f5592b972013d60739b0c4ba77b6.1601574234.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
References: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fallocate() is implemented by reserving actual extent instead of
reservations. This can result in exposing the sequential write constraint
of host-managed zoned block devices to the application, which would break
the POSIX semantic for the fallocated file.  To avoid this, report
fallocate() as not supported when in ZONED mode for now.

In the future, we may be able to implement "in-memory" fallocate() in ZONED
mode by utilizing space_info->bytes_may_use or so.

Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 038e0afaf3d0..60a01e1347ba 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3341,6 +3341,10 @@ static long btrfs_fallocate(struct file *file, int mode,
 	alloc_end = round_up(offset + len, blocksize);
 	cur_offset = alloc_start;
 
+	/* Do not allow fallocate in ZONED mode */
+	if (btrfs_fs_incompat(btrfs_sb(inode->i_sb), ZONED))
+		return -EOPNOTSUPP;
+
 	/* Make sure we aren't being give some crap mode */
 	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
 		     FALLOC_FL_ZERO_RANGE))
-- 
2.27.0


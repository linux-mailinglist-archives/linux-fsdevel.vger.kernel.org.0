Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BF45A3548
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Aug 2022 09:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbiH0HBq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Aug 2022 03:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbiH0HBg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Aug 2022 03:01:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9359D24F3E;
        Sat, 27 Aug 2022 00:01:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26D55B82783;
        Sat, 27 Aug 2022 07:01:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88DB1C43470;
        Sat, 27 Aug 2022 07:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661583693;
        bh=0xuShhm2dGVlVdS35K/psQMXih/7EA3C0nxlthmzrd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pedZYWIoNW+9lCIp8+WakPS5vapg3nIeS1G4/mysv6CfIZndcJTyFf+55ZsuA+aoX
         Xdxp1ueHBL0vwGMKdhP0aU5LtCqsXe8WsW8LhTz8F7hpOiJnrPVkiKkzcu3lp+y0E7
         llWBt5CZ4CIdjIhOsdRdJYxaxOIwvwI9gQB12Oj/V61yCCzR2tpROudUnv4gbqNlLl
         8UlxBfBIyMt3TQf7vsDjgDAw3nyZWmoGWLAu9ea3XxRiDAsbBFueT1r59i4i2W4diN
         G5c+MDjU1hRMW+b3c3tnXbKIMnNrsaWpg/h9XW7XmikreLpz2cX9EqaF6JT/a64zmD
         s/bGohFpVzqcg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v5 8/8] xfs: support STATX_DIOALIGN
Date:   Fri, 26 Aug 2022 23:58:51 -0700
Message-Id: <20220827065851.135710-9-ebiggers@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220827065851.135710-1-ebiggers@kernel.org>
References: <20220827065851.135710-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Add support for STATX_DIOALIGN to xfs, so that direct I/O alignment
restrictions are exposed to userspace in a generic way.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/xfs/xfs_iops.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 45518b8c613c9a..f51c60d7e2054a 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -604,6 +604,16 @@ xfs_vn_getattr(
 		stat->blksize = BLKDEV_IOSIZE;
 		stat->rdev = inode->i_rdev;
 		break;
+	case S_IFREG:
+		if (request_mask & STATX_DIOALIGN) {
+			struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
+			struct block_device	*bdev = target->bt_bdev;
+
+			stat->result_mask |= STATX_DIOALIGN;
+			stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
+			stat->dio_offset_align = bdev_logical_block_size(bdev);
+		}
+		fallthrough;
 	default:
 		stat->blksize = xfs_stat_blksize(ip);
 		stat->rdev = 0;
-- 
2.37.2


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFE257DAE1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 09:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbiGVHOW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jul 2022 03:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234344AbiGVHOH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jul 2022 03:14:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A6A93C37;
        Fri, 22 Jul 2022 00:14:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BABD6218C;
        Fri, 22 Jul 2022 07:14:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0077C385A5;
        Fri, 22 Jul 2022 07:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658474046;
        bh=vRMBs3p3k29TcKDOjHrOzYfkIvFsVQJZG7mrxyu++ts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eKeG5bGyliUl/1pyKmdtZZa0HOvtmSTtj9U4sC95NA5D8IDsq+Vegw9IPhy3zbjWv
         VqBDKe1x8aTlQjYpZmOMT+hUh8Aesxl0g1m7dUutCmVaHepkeaFHOzBQ+bMhojs9ly
         /WvlzVL8NEAuDYHcRJY4G6MbYT3B+y7a85CKNjHSv7sa9w11u6gXPuSWPqIx6s8FEq
         CBjT4NrDoDakb2YfI9wXiBl4aVMWoXX5NaOKuAMrM65vruCbF1lQRkQWGIdtzy3DOj
         HyUTCFpCWZcPAT8omY/l/15TzbUHaoqDQY9UCrKT6K/a1YkdC2IqrFuYv6I7tmEbOh
         F8uJYZfxDcI0A==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v4 9/9] xfs: support STATX_DIOALIGN
Date:   Fri, 22 Jul 2022 00:12:28 -0700
Message-Id: <20220722071228.146690-10-ebiggers@kernel.org>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220722071228.146690-1-ebiggers@kernel.org>
References: <20220722071228.146690-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS autolearn=ham
        autolearn_force=no version=3.4.6
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
 fs/xfs/xfs_iops.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 29f5b8b8aca69a..bac3f56141801e 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -605,6 +605,15 @@ xfs_vn_getattr(
 		stat->blksize = BLKDEV_IOSIZE;
 		stat->rdev = inode->i_rdev;
 		break;
+	case S_IFREG:
+		if (request_mask & STATX_DIOALIGN) {
+			struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
+
+			stat->result_mask |= STATX_DIOALIGN;
+			stat->dio_mem_align = target->bt_logical_sectorsize;
+			stat->dio_offset_align = target->bt_logical_sectorsize;
+		}
+		fallthrough;
 	default:
 		stat->blksize = xfs_stat_blksize(ip);
 		stat->rdev = 0;
-- 
2.37.0


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EB862D311
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Nov 2022 06:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239073AbiKQF6X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 00:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239238AbiKQF6S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 00:58:18 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE0267F7D
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Nov 2022 21:58:17 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id y13so781853pfp.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Nov 2022 21:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9n9O99DT3hdP5b/wuKlzATIr4coy1fWTQAg6hgeOeE=;
        b=4rQcWcTqKAblzYTp3N7PZdaSDPKrwD2ossVggsKjYLCUE2q4LWa9HQjTsVhg4mDGQZ
         rAKbJl/hBZeTXVSCcHPMereO+ECKOhFCyHhp79905nPfbJBLFIxhGLXLdQDmSE1LNy8d
         odcc2tTQbFP275+MBT9jMkd210R0PNfQNPe/q423xdJ7UyVcxqRUXqoEPADirsC8wL0u
         dMXYM5ooOYYJ67+hphCagZAqpWfqJupJZKEG5ignEm0tlYRBaQKJbJfpUTt/RZp+jkwA
         xIBoZbObpOMhHfMCJ7QEH6SKjtzq4B4R23/OL23R6BSY19ucw9UvTf1o76q0hkOTHvma
         /5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u9n9O99DT3hdP5b/wuKlzATIr4coy1fWTQAg6hgeOeE=;
        b=HmoclKheyyT4b+tukWpBigCQ2deoEHluvgNUytbG8OEfYTI8jR+irEUXkw4C6s0GwS
         +ETzRSMGmi0rZUOGVzXc5jIybpubcJRmp8aV/XL/f2EXyommJtl+wMGHOJAt7H55QsQr
         NyGb/eLDBwcmSXfhtU2YmfTFjxD1wJ2PKod0MKurcX5oPPzvzr2s1tm65RZaaEA9wbYc
         pVvRTcG1EE4sPO0Pi5+u2IG3GcUHoXlWX3qdtDwXeumA4CAwIhRqcrj8ruK5lmE0PtPY
         1dPKZ8pT3SoodVRAXo/6QPDNNp9gmOo+jf/8cMm1oI+fdaNo6qdDWAUb8dMm6qG1/D8G
         XHQw==
X-Gm-Message-State: ANoB5pnGW+PVmB7oBwXz7eUrmEwJTNtWiHXyR857rv3srMX1pD1M/pEr
        t7CU4yNKJQnSGpULYLDfoZBsuvKJCfnvAQ==
X-Google-Smtp-Source: AA0mqf4H+TdyoPaVXrTIh1GLu5U6Dc8OhubZWJ5EL/R9gT9aaDgxJeVnzIpuo0dtGCF+gLD7E6JHAA==
X-Received: by 2002:a63:2049:0:b0:46f:a711:551b with SMTP id r9-20020a632049000000b0046fa711551bmr763037pgm.313.1668664696557;
        Wed, 16 Nov 2022 21:58:16 -0800 (PST)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au. [49.181.106.210])
        by smtp.gmail.com with ESMTPSA id 72-20020a62184b000000b0056bb0357f5bsm66060pfy.192.2022.11.16.21.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 21:58:15 -0800 (PST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ovXue-00FBpN-BN; Thu, 17 Nov 2022 16:58:12 +1100
Received: from dave by discord.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1ovXue-0025cd-0z;
        Thu, 17 Nov 2022 16:58:12 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 6/9] xfs: xfs_bmap_punch_delalloc_range() should take a byte range
Date:   Thu, 17 Nov 2022 16:58:07 +1100
Message-Id: <20221117055810.498014-7-david@fromorbit.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221117055810.498014-1-david@fromorbit.com>
References: <20221117055810.498014-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

All the callers of xfs_bmap_punch_delalloc_range() jump through
hoops to convert a byte range to filesystem blocks before calling
xfs_bmap_punch_delalloc_range(). Instead, pass the byte range to
xfs_bmap_punch_delalloc_range() and have it do the conversion to
filesystem blocks internally.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/xfs_aops.c      | 16 ++++++----------
 fs/xfs/xfs_bmap_util.c | 10 ++++++----
 fs/xfs/xfs_bmap_util.h |  2 +-
 fs/xfs/xfs_iomap.c     |  8 ++------
 4 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 5d1a995b15f8..6aadc5815068 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -114,9 +114,8 @@ xfs_end_ioend(
 	if (unlikely(error)) {
 		if (ioend->io_flags & IOMAP_F_SHARED) {
 			xfs_reflink_cancel_cow_range(ip, offset, size, true);
-			xfs_bmap_punch_delalloc_range(ip,
-						      XFS_B_TO_FSBT(mp, offset),
-						      XFS_B_TO_FSB(mp, size));
+			xfs_bmap_punch_delalloc_range(ip, offset,
+					offset + size);
 		}
 		goto done;
 	}
@@ -455,12 +454,8 @@ xfs_discard_folio(
 	struct folio		*folio,
 	loff_t			pos)
 {
-	struct inode		*inode = folio->mapping->host;
-	struct xfs_inode	*ip = XFS_I(inode);
+	struct xfs_inode	*ip = XFS_I(folio->mapping->host);
 	struct xfs_mount	*mp = ip->i_mount;
-	size_t			offset = offset_in_folio(folio, pos);
-	xfs_fileoff_t		start_fsb = XFS_B_TO_FSBT(mp, pos);
-	xfs_fileoff_t		pageoff_fsb = XFS_B_TO_FSBT(mp, offset);
 	int			error;
 
 	if (xfs_is_shutdown(mp))
@@ -470,8 +465,9 @@ xfs_discard_folio(
 		"page discard on page "PTR_FMT", inode 0x%llx, pos %llu.",
 			folio, ip->i_ino, pos);
 
-	error = xfs_bmap_punch_delalloc_range(ip, start_fsb,
-			i_blocks_per_folio(inode, folio) - pageoff_fsb);
+	error = xfs_bmap_punch_delalloc_range(ip, pos,
+			round_up(pos, folio_size(folio)));
+
 	if (error && !xfs_is_shutdown(mp))
 		xfs_alert(mp, "page discard unable to remove delalloc mapping.");
 }
diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 04d0c2bff67c..867645b74d88 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -590,11 +590,13 @@ xfs_getbmap(
 int
 xfs_bmap_punch_delalloc_range(
 	struct xfs_inode	*ip,
-	xfs_fileoff_t		start_fsb,
-	xfs_fileoff_t		length)
+	xfs_off_t		start_byte,
+	xfs_off_t		end_byte)
 {
+	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_ifork	*ifp = &ip->i_df;
-	xfs_fileoff_t		end_fsb = start_fsb + length;
+	xfs_fileoff_t		start_fsb = XFS_B_TO_FSBT(mp, start_byte);
+	xfs_fileoff_t		end_fsb = XFS_B_TO_FSB(mp, end_byte);
 	struct xfs_bmbt_irec	got, del;
 	struct xfs_iext_cursor	icur;
 	int			error = 0;
@@ -607,7 +609,7 @@ xfs_bmap_punch_delalloc_range(
 
 	while (got.br_startoff + got.br_blockcount > start_fsb) {
 		del = got;
-		xfs_trim_extent(&del, start_fsb, length);
+		xfs_trim_extent(&del, start_fsb, end_fsb - start_fsb);
 
 		/*
 		 * A delete can push the cursor forward. Step back to the
diff --git a/fs/xfs/xfs_bmap_util.h b/fs/xfs/xfs_bmap_util.h
index 24b37d211f1d..6888078f5c31 100644
--- a/fs/xfs/xfs_bmap_util.h
+++ b/fs/xfs/xfs_bmap_util.h
@@ -31,7 +31,7 @@ xfs_bmap_rtalloc(struct xfs_bmalloca *ap)
 #endif /* CONFIG_XFS_RT */
 
 int	xfs_bmap_punch_delalloc_range(struct xfs_inode *ip,
-		xfs_fileoff_t start_fsb, xfs_fileoff_t length);
+		xfs_off_t start_byte, xfs_off_t end_byte);
 
 struct kgetbmap {
 	__s64		bmv_offset;	/* file offset of segment in blocks */
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index ea96e8a34868..09676ff6940e 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1126,12 +1126,8 @@ xfs_buffered_write_delalloc_punch(
 	loff_t			offset,
 	loff_t			length)
 {
-	struct xfs_mount	*mp = XFS_M(inode->i_sb);
-	xfs_fileoff_t		start_fsb = XFS_B_TO_FSBT(mp, offset);
-	xfs_fileoff_t		end_fsb = XFS_B_TO_FSB(mp, offset + length);
-
-	return xfs_bmap_punch_delalloc_range(XFS_I(inode), start_fsb,
-				end_fsb - start_fsb);
+	return xfs_bmap_punch_delalloc_range(XFS_I(inode), offset,
+			offset + length);
 }
 
 static int
-- 
2.37.2


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8527A266A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 20:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236826AbjIOSoJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 14:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236842AbjIOSni (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:43:38 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050:0:465::202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EE6449D;
        Fri, 15 Sep 2023 11:40:44 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RnNK84kWKz9sWQ;
        Fri, 15 Sep 2023 20:39:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
        s=MBO0001; t=1694803196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rdyOm0E20W1O08Haq+wboPt6O9fnOeXgM7VNGHdT/wc=;
        b=YWBaYLR8wP7FiydPN5L35PApcVVJVdWdr9JQ0wve5greLck+YNw4kh4nrPZG0I3Irb8ki0
        iuokOs97BSQFNTgm6YhdORbefrutGfT1KELpkS/3XMgdCJ9oOH4CtnvKt/LPo0PALntzFv
        p3aHYP5rCYGypOCX8eQG6C8LNjayrhZbhVYUtmATnzcj1I2hW2uQpwW6y/BQVis0Zw0/VG
        5DwtrDMNHLI60IzV77LR+S96bZ65EDdStUam1CBD+ng7P3QZexi7+Gw76NWeAcNZn30u4d
        ZF4HNoSpiJ8j4mP9R3KSBmGwbUH3gqxJZAlgZODdsgOKSUDIhWjurPKl2hsTaw==
From:   Pankaj Raghav <kernel@pankajraghav.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     p.raghav@samsung.com, david@fromorbit.com, da.gomez@samsung.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, djwong@kernel.org, linux-mm@kvack.org,
        chandan.babu@oracle.com, mcgrof@kernel.org, gost.dev@samsung.com
Subject: [RFC 23/23] xfs: set minimum order folio for page cache based on blocksize
Date:   Fri, 15 Sep 2023 20:38:48 +0200
Message-Id: <20230915183848.1018717-24-kernel@pankajraghav.com>
In-Reply-To: <20230915183848.1018717-1-kernel@pankajraghav.com>
References: <20230915183848.1018717-1-kernel@pankajraghav.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Pankaj Raghav <p.raghav@samsung.com>

Enabling a block size > PAGE_SIZE is only possible if we can
ensure that the filesystem allocations for the block size is treated
atomically and we do this with the min order folio requirement for the
inode. This allows the page cache to treat this inode atomically even
if on the block layer we may treat it separately.

For instance, on x86 this enables eventual usage of block size > 4k
so long as you use a sector size set of 4k.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/xfs/xfs_icache.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index aacc7eec2497..81f07503f5ca 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -73,6 +73,7 @@ xfs_inode_alloc(
 	xfs_ino_t		ino)
 {
 	struct xfs_inode	*ip;
+	int			min_order = 0;
 
 	/*
 	 * XXX: If this didn't occur in transactions, we could drop GFP_NOFAIL
@@ -88,7 +89,8 @@ xfs_inode_alloc(
 	/* VFS doesn't initialise i_mode or i_state! */
 	VFS_I(ip)->i_mode = 0;
 	VFS_I(ip)->i_state = 0;
-	mapping_set_large_folios(VFS_I(ip)->i_mapping);
+	min_order = max(min_order, ilog2(mp->m_sb.sb_blocksize) - PAGE_SHIFT);
+	mapping_set_folio_orders(VFS_I(ip)->i_mapping, min_order, MAX_PAGECACHE_ORDER);
 
 	XFS_STATS_INC(mp, vn_active);
 	ASSERT(atomic_read(&ip->i_pincount) == 0);
@@ -313,6 +315,7 @@ xfs_reinit_inode(
 	dev_t			dev = inode->i_rdev;
 	kuid_t			uid = inode->i_uid;
 	kgid_t			gid = inode->i_gid;
+	int			min_order = 0;
 
 	error = inode_init_always(mp->m_super, inode);
 
@@ -323,7 +326,8 @@ xfs_reinit_inode(
 	inode->i_rdev = dev;
 	inode->i_uid = uid;
 	inode->i_gid = gid;
-	mapping_set_large_folios(inode->i_mapping);
+	min_order = max(min_order, ilog2(mp->m_sb.sb_blocksize) - PAGE_SHIFT);
+	mapping_set_folio_orders(inode->i_mapping, min_order, MAX_PAGECACHE_ORDER);
 	return error;
 }
 
-- 
2.40.1


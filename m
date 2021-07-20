Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313283CFAB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 15:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238491AbhGTMzM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 08:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239186AbhGTMyn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 08:54:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5859C0613DC;
        Tue, 20 Jul 2021 06:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=qsT43CipimafMmxEpg8bQKSV7PTZo0vJSwQ7HUQRrb8=; b=Xvej2gTGdIYsL3l/g0nViM+1XP
        iL5vh2nG1thg0xpNekjc6n1kJ2Jey/oDndquUGmha8nIsB11rznCS0wb3uxqDcG+1MTWj3lvc1oKS
        w9jqJAXcIargsVwXNvjSwTxr+HtZmdn4cFpN+XuL8Svbn20ABaemlFEcz8UAohrM3FO5rG6uMMEBy
        Sj0UnfRBRIe0FjCcdMpn4Z5KJ+ItVR7vub3eRvymhIG2rG3M4ONt2HqfZqnGDH6YwyoGT4vmjY7Ua
        zahxgylnD1qXqSCIG3bdxta796/XfBbtyQ01yYKoqd5bznPRKZ6c2eZVybnF6bvCY3tT2MSpBx21p
        bDhqbEWw==;
Received: from [2001:4bb8:193:7660:5612:5e3c:ba3d:2b3c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5psk-0089GA-Bd; Tue, 20 Jul 2021 13:34:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.com>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/4] ext2: make ext2_iomap_ops available unconditionally
Date:   Tue, 20 Jul 2021 15:33:38 +0200
Message-Id: <20210720133341.405438-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210720133341.405438-1-hch@lst.de>
References: <20210720133341.405438-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ext2_iomap_ops will be used for the FIEMAP support going forward,
so make it available unconditionally.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext2/inode.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index dadb121beb22..3e9a04770f49 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -799,7 +799,6 @@ int ext2_get_block(struct inode *inode, sector_t iblock,
 
 }
 
-#ifdef CONFIG_FS_DAX
 static int ext2_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		unsigned flags, struct iomap *iomap, struct iomap *srcmap)
 {
@@ -852,10 +851,6 @@ const struct iomap_ops ext2_iomap_ops = {
 	.iomap_begin		= ext2_iomap_begin,
 	.iomap_end		= ext2_iomap_end,
 };
-#else
-/* Define empty ops for !CONFIG_FS_DAX case to avoid ugly ifdefs */
-const struct iomap_ops ext2_iomap_ops;
-#endif /* CONFIG_FS_DAX */
 
 int ext2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		u64 start, u64 len)
-- 
2.30.2


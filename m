Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A653CFAE2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 15:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238548AbhGTNBI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 09:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239138AbhGTM4s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 08:56:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AECC061574;
        Tue, 20 Jul 2021 06:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=0VqP0qkGy3bATyaDMquHKGpU7hxT8hYMW7iyfm2k68U=; b=f3RiGJP5h6k+zbsV2JO1mx4hN9
        22zpMrLwPBfQNWYeypjGnNJyyadL2P65DRWGb5M0u9YDyTFyIubS1oLsx6j/hI9hoRRG5Wut64z84
        cSNxOELSkTxk9SZN8lyA0M5kOaQZ5e3UJbMDUzsgWliO7Fqe3PPe8MAbnaLK6fkJkGkjkG20QaM+A
        GqPiAdhcT0DiGJEZJ87c3prOfGLrzc41F5+wtKzf/aGq6ktevpWaPJZNErFO5i9zeALal9425qH78
        EYsOwWWgIPuKKxe9XwWHTdp21b+/Wv3lvCJIFZNVIgYTgFisvcrkJIqbPDCeJvQfKLT7vNgvIhnRy
        wAJbfrbA==;
Received: from [2001:4bb8:193:7660:5612:5e3c:ba3d:2b3c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5puI-0089Ox-CH; Tue, 20 Jul 2021 13:36:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.com>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/4] hpfs: use iomap_fiemap to implement ->fiemap
Date:   Tue, 20 Jul 2021 15:33:40 +0200
Message-Id: <20210720133341.405438-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210720133341.405438-1-hch@lst.de>
References: <20210720133341.405438-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

hpfs is the last user of generic_block_fiemap, so add a trivial
iomap_ops based on the ext2 version and switch to iomap_fiemap.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/hpfs/file.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/fs/hpfs/file.c b/fs/hpfs/file.c
index c3a49aacf20a..fb37f57130aa 100644
--- a/fs/hpfs/file.c
+++ b/fs/hpfs/file.c
@@ -9,6 +9,7 @@
 
 #include "hpfs_fn.h"
 #include <linux/mpage.h>
+#include <linux/iomap.h>
 #include <linux/fiemap.h>
 
 #define BLOCKS(size) (((size) + 511) >> 9)
@@ -116,6 +117,47 @@ static int hpfs_get_block(struct inode *inode, sector_t iblock, struct buffer_he
 	return r;
 }
 
+static int hpfs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
+		unsigned flags, struct iomap *iomap, struct iomap *srcmap)
+{
+	struct super_block *sb = inode->i_sb;
+	unsigned int blkbits = inode->i_blkbits;
+	unsigned int n_secs;
+	secno s;
+
+	if (WARN_ON_ONCE(flags & (IOMAP_WRITE | IOMAP_ZERO)))
+		return -EINVAL;
+
+	iomap->bdev = inode->i_sb->s_bdev;
+	iomap->offset = offset;
+
+	hpfs_lock(sb);
+	s = hpfs_bmap(inode, offset >> blkbits, &n_secs);
+	if (s) {
+		n_secs = hpfs_search_hotfix_map_for_range(sb, s,
+				min_t(loff_t, n_secs, length));
+		if (unlikely(!n_secs)) {
+			s = hpfs_search_hotfix_map(sb, s);
+			n_secs = 1;
+		}
+		iomap->type = IOMAP_MAPPED;
+		iomap->flags = IOMAP_F_MERGED;
+		iomap->addr = (u64)s << blkbits;
+		iomap->length = (u64)n_secs << blkbits;
+	} else {
+		iomap->type = IOMAP_HOLE;
+		iomap->addr = IOMAP_NULL_ADDR;
+		iomap->length = 1 << blkbits;
+	}
+
+	hpfs_unlock(sb);
+	return 0;
+}
+
+static const struct iomap_ops hpfs_iomap_ops = {
+	.iomap_begin		= hpfs_iomap_begin,
+};
+
 static int hpfs_readpage(struct file *file, struct page *page)
 {
 	return mpage_readpage(page, hpfs_get_block);
@@ -192,7 +234,14 @@ static sector_t _hpfs_bmap(struct address_space *mapping, sector_t block)
 
 static int hpfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo, u64 start, u64 len)
 {
-	return generic_block_fiemap(inode, fieinfo, start, len, hpfs_get_block);
+	int ret;
+
+	inode_lock(inode);
+	len = min_t(u64, len, i_size_read(inode));
+	ret = iomap_fiemap(inode, fieinfo, start, len, &hpfs_iomap_ops);
+	inode_unlock(inode);
+
+	return ret;
 }
 
 const struct address_space_operations hpfs_aops = {
-- 
2.30.2


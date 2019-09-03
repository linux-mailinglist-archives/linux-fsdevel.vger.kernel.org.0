Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF1BCA63B6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 10:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfICISp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 04:18:45 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3552 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726452AbfICISo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 04:18:44 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 6E25654F8C19C09BEE56;
        Tue,  3 Sep 2019 16:18:42 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 3 Sep 2019 16:18:41 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 3 Sep 2019 16:18:41 +0800
Date:   Tue, 3 Sep 2019 16:17:49 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Gao Xiang <hsiangkao@aol.com>, Chao Yu <yuchao0@huawei.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <linux-fsdevel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-erofs@lists.ozlabs.org>, Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 00/21] erofs: patchset addressing Christoph's comments
Message-ID: <20190903081749.GA89379@architecture4>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
 <20190902124645.GA8369@infradead.org>
 <20190902142452.GE2664@architecture4>
 <20190902152323.GB14009@infradead.org>
 <20190902155037.GD179615@architecture4>
 <20190903065803.GA11205@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190903065803.GA11205@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme701-chm.china.huawei.com (10.1.199.97) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

On Mon, Sep 02, 2019 at 11:58:03PM -0700, Christoph Hellwig wrote:
> On Mon, Sep 02, 2019 at 11:50:38PM +0800, Gao Xiang wrote:
> > > > You means killing erofs_get_meta_page or avoid erofs_read_raw_page?
> > > > 
> > > >  - For killing erofs_get_meta_page, here is the current erofs_get_meta_page:
> > > 
> > > > I think it is simple enough. read_cache_page need write a similar
> > > > filler, or read_cache_page_gfp will call .readpage, and then
> > > > introduce buffer_heads, that is what I'd like to avoid now (no need these
> > > > bd_inode buffer_heads in memory...)
> > > 
> > > If using read_cache_page_gfp and ->readpage works, please do.  The
> > > fact that the block device inode uses buffer heads is an implementation
> > > detail that might not last very long and should be invisible to you.
> > > It also means you can get rid of a lot of code that you don't have
> > > to maintain and others don't have to update for global API changes.
> > 
> > I care about those useless buffer_heads in memory for our products...
> > 
> > Since we are nobh filesystem (a little request, could I use it
> > after buffer_heads are fully avoided, I have no idea why I need
> > those buffer_heads in memory.... But I think bd_inode is good
> > for caching metadata...)
> 
> Then please use read_cache_page with iomap_readpage(s), and write
> comment explaining why your are not using read_cache_page_gfp.

I implement a prelimitary version, but I have no idea it is a really
cleanup for now.

From 001e3e64c81e4ced0d22b147e6abf90060e704b5 Mon Sep 17 00:00:00 2001
From: Gao Xiang <gaoxiang25@huawei.com>
Date: Tue, 3 Sep 2019 16:13:00 +0800
Subject: [PATCH] erofs: use iomap_readpage for erofs_get_meta_page

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/Kconfig |  1 +
 fs/erofs/data.c  | 91 ++++++++++++++++++++++++++----------------------
 2 files changed, 51 insertions(+), 41 deletions(-)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 9d634d3a1845..c9eeb0bf4737 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -3,6 +3,7 @@
 config EROFS_FS
 	tristate "EROFS filesystem support"
 	depends on BLOCK
+	select FS_IOMAP
 	help
 	  EROFS (Enhanced Read-Only File System) is a lightweight
 	  read-only file system with modern designs (eg. page-sized
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 3881c0689134..34c6e05fab71 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -5,6 +5,9 @@
  * Created by Gao Xiang <gaoxiang25@huawei.com>
  */
 #include "internal.h"
+#include <linux/iomap.h>
+#include <linux/mpage.h>
+#include <linux/sched/mm.h>
 #include <linux/prefetch.h>
 
 #include <trace/events/erofs.h>
@@ -51,54 +54,60 @@ static struct bio *erofs_grab_raw_bio(struct super_block *sb,
 	return bio;
 }
 
-struct page *erofs_get_meta_page(struct super_block *sb, erofs_blk_t blkaddr)
+static int erofs_meta_iomap_begin(struct inode *inode, loff_t pos,
+				  loff_t length, unsigned int flags,
+				  struct iomap *iomap)
 {
-	struct inode *const bd_inode = sb->s_bdev->bd_inode;
-	struct address_space *const mapping = bd_inode->i_mapping;
-	/* prefer retrying in the allocator to blindly looping below */
-	const gfp_t gfp = mapping_gfp_constraint(mapping, ~__GFP_FS);
-	struct page *page;
-	int err;
-
-repeat:
-	page = find_or_create_page(mapping, blkaddr, gfp);
-	if (!page)
-		return ERR_PTR(-ENOMEM);
-
-	DBG_BUGON(!PageLocked(page));
-
-	if (!PageUptodate(page)) {
-		struct bio *bio;
+	const unsigned int blkbits = inode->i_blkbits;
+
+	iomap->flags = 0;
+	iomap->bdev = I_BDEV(inode);
+	iomap->offset = round_down(pos, 1 << blkbits);
+	iomap->addr = iomap->offset;
+	iomap->length = round_up(length, 1 << blkbits);
+	iomap->type = IOMAP_MAPPED;
+	return 0;
+}
 
-		bio = erofs_grab_raw_bio(sb, blkaddr, 1, true);
+static const struct iomap_ops erofs_meta_iomap_ops = {
+	.iomap_begin = erofs_meta_iomap_begin,
+};
 
-		if (bio_add_page(bio, page, PAGE_SIZE, 0) != PAGE_SIZE) {
-			err = -EFAULT;
-			goto err_out;
-		}
+static int
+erofs_meta_get_block(struct inode *inode, sector_t iblock,
+		     struct buffer_head *bh, int create)
+{
+	bh->b_bdev = I_BDEV(inode);
+	bh->b_blocknr = iblock;
+	set_buffer_mapped(bh);
+	return 0;
+}
 
-		submit_bio(bio);
-		lock_page(page);
+static int erofs_read_meta_page(void *file, struct page *page)
+{
+	/* in case of getting some pages with buffer_heads */
+	if (i_blocksize(page->mapping->host) == PAGE_SIZE &&
+	    !page_has_buffers(page))
+		return iomap_readpage(page, &erofs_meta_iomap_ops);
+
+	/*
+	 * cannot use blkdev_readpage or blkdev_get_block directly
+	 * since static in block_dev.c
+	 */
+	return mpage_readpage(page, erofs_meta_get_block);
+}
 
-		/* this page has been truncated by others */
-		if (page->mapping != mapping) {
-			unlock_page(page);
-			put_page(page);
-			goto repeat;
-		}
+struct page *erofs_get_meta_page(struct super_block *sb, erofs_blk_t blkaddr)
+{
+	struct inode *const bd_inode = sb->s_bdev->bd_inode;
+	struct address_space *const mapping = bd_inode->i_mapping;
+	unsigned int nofs_flag;
+	struct page *page;
 
-		/* more likely a read error */
-		if (!PageUptodate(page)) {
-			err = -EIO;
-			goto err_out;
-		}
-	}
+	nofs_flag = memalloc_nofs_save();
+	page = read_cache_page(mapping, blkaddr, erofs_read_meta_page, NULL);
+	memalloc_nofs_restore(nofs_flag);
 	return page;
-
-err_out:
-	unlock_page(page);
-	put_page(page);
-	return ERR_PTR(err);
 }
 
 static int erofs_map_blocks_flatmode(struct inode *inode,
-- 
2.17.1



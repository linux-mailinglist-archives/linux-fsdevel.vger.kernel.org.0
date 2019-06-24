Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F34950292
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 08:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfFXGyj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 02:54:39 -0400
Received: from verein.lst.de ([213.95.11.211]:52857 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbfFXGyj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 02:54:39 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 6D2FE68AFE; Mon, 24 Jun 2019 08:54:08 +0200 (CEST)
Date:   Mon, 24 Jun 2019 08:54:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs: Move mark_inode_dirty out of __generic_write_end
Message-ID: <20190624065408.GA3565@lst.de>
References: <20190618144716.8133-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618144716.8133-1-agruenba@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

At least for xfs we don't need the mark_inode_dirty at all.  Can you
solve your gfs2 requirements on top of something like the patch below?
Note that in general it seems like you should try to only update the
on-disk inode size in writeback completion anyway, otherwise you can
have a stale i_size update before the data was actually written.


diff --git a/fs/iomap.c b/fs/iomap.c
index c98107a6bf81..fcf2cbd39114 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -785,6 +785,7 @@ iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
 		unsigned copied, struct page *page, struct iomap *iomap)
 {
 	const struct iomap_page_ops *page_ops = iomap->page_ops;
+	loff_t old_size = inode->i_size;
 	int ret;
 
 	if (iomap->type == IOMAP_INLINE) {
@@ -796,7 +797,12 @@ iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
 		ret = __iomap_write_end(inode, pos, len, copied, page, iomap);
 	}
 
-	__generic_write_end(inode, pos, ret, page);
+	if (pos + ret > inode->i_size)
+		i_size_write(inode, pos + ret);
+	unlock_page(page);
+
+	if (old_size < pos)
+		pagecache_isize_extended(inode, old_size, pos);
 	if (page_ops && page_ops->page_done)
 		page_ops->page_done(inode, pos, copied, page, iomap);
 	put_page(page);

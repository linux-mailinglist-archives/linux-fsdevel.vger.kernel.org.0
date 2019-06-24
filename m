Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E796851A66
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 20:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfFXSWv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 14:22:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45249 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbfFXSWv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 14:22:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 97CC53001822;
        Mon, 24 Jun 2019 18:22:50 +0000 (UTC)
Received: from max.com (unknown [10.40.205.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B9956090E;
        Mon, 24 Jun 2019 18:22:46 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs: Move mark_inode_dirty out of __generic_write_end
Date:   Mon, 24 Jun 2019 20:22:43 +0200
Message-Id: <20190624182243.22447-1-agruenba@redhat.com>
In-Reply-To: <20190624065408.GA3565@lst.de>
References: <20190618144716.8133-1-agruenba@redhat.com> <20190624065408.GA3565@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 24 Jun 2019 18:22:50 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 24 Jun 2019 at 08:55, Christoph Hellwig <hch@lst.de> wrote:
> At least for xfs we don't need the mark_inode_dirty at all.  Can you
> solve your gfs2 requirements on top of something like the patch below?
> Note that in general it seems like you should try to only update the
> on-disk inode size in writeback completion anyway, otherwise you can
> have a stale i_size update before the data was actually written.
>
>
> diff --git a/fs/iomap.c b/fs/iomap.c
> index c98107a6bf81..fcf2cbd39114 100644
> --- a/fs/iomap.c
> +++ b/fs/iomap.c
> @@ -785,6 +785,7 @@ iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
>                 unsigned copied, struct page *page, struct iomap *iomap)
>  {
>         const struct iomap_page_ops *page_ops = iomap->page_ops;
> +       loff_t old_size = inode->i_size;
>         int ret;
>
>         if (iomap->type == IOMAP_INLINE) {
> @@ -796,7 +797,12 @@ iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
>                 ret = __iomap_write_end(inode, pos, len, copied, page, iomap);
>         }
>
> -       __generic_write_end(inode, pos, ret, page);
> +       if (pos + ret > inode->i_size)
> +               i_size_write(inode, pos + ret);
> +       unlock_page(page);
> +
> +       if (old_size < pos)
> +               pagecache_isize_extended(inode, old_size, pos);
>         if (page_ops && page_ops->page_done)
>                 page_ops->page_done(inode, pos, copied, page, iomap);
>         put_page(page);

That would work, but I don't like how this leaves us with a vfs function
that updates i_size without bothering to dirty the inode very much.

How about if we move the __generic_write_end call into the page_done
callback and leave special handling to the filesystem code if needed
instead?  The below patch seems to work for gfs2.

Thanks,
Andreas

---
 fs/gfs2/bmap.c   | 42 ++++++++++++++++++++++++++++++++++++------
 fs/gfs2/incore.h |  1 +
 fs/iomap.c       |  5 +++--
 3 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 93ea1d529aa3..7569770e6871 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -991,10 +991,13 @@ static void gfs2_write_unlock(struct inode *inode)
 static int gfs2_iomap_page_prepare(struct inode *inode, loff_t pos,
 				   unsigned len, struct iomap *iomap)
 {
-	unsigned int blockmask = i_blocksize(inode) - 1;
+	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
-	unsigned int blocks;
+	unsigned int blockmask, blocks;
 
+	if (!(gfs2_is_stuffed(ip) || gfs2_is_jdata(ip)))
+		return 0;
+	blockmask = i_blocksize(inode) - 1;
 	blocks = ((pos & blockmask) + len + blockmask) >> inode->i_blkbits;
 	return gfs2_trans_begin(sdp, RES_DINODE + blocks, 0);
 }
@@ -1005,10 +1008,33 @@ static void gfs2_iomap_page_done(struct inode *inode, loff_t pos,
 {
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
+	loff_t old_size;
+
+	if (!page)
+		goto out;
 
-	if (page && !gfs2_is_stuffed(ip))
+	/*
+	 * Avoid calling __generic_write_end here to prevent mark_inode_dirty
+	 * from being called for each page: it's relatively expensive on gfs2,
+	 * so we defer that to gfs2_iomap_end.
+	 */
+	old_size = inode->i_size;
+	if (pos + copied > old_size) {
+		i_size_write(inode, pos + copied);
+		set_bit(GIF_SIZE_CHANGED, &ip->i_flags);
+	}
+
+	unlock_page(page);
+
+	if (old_size < pos)
+		pagecache_isize_extended(inode, old_size, pos);
+
+	if (gfs2_is_jdata(ip) && !gfs2_is_stuffed(ip))
 		gfs2_page_add_databufs(ip, page, offset_in_page(pos), copied);
-	gfs2_trans_end(sdp);
+
+out:
+	if (current->journal_info)
+		gfs2_trans_end(sdp);
 }
 
 static const struct iomap_page_ops gfs2_iomap_page_ops = {
@@ -1106,8 +1132,7 @@ static int gfs2_iomap_begin_write(struct inode *inode, loff_t pos,
 		gfs2_trans_end(sdp);
 	}
 
-	if (gfs2_is_stuffed(ip) || gfs2_is_jdata(ip))
-		iomap->page_ops = &gfs2_iomap_page_ops;
+	iomap->page_ops = &gfs2_iomap_page_ops;
 	return 0;
 
 out_trans_end:
@@ -1160,6 +1185,11 @@ static int gfs2_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 	if ((flags & (IOMAP_WRITE | IOMAP_DIRECT)) != IOMAP_WRITE)
 		goto out;
 
+	if (test_bit(GIF_SIZE_CHANGED, &ip->i_flags)) {
+		clear_bit(GIF_SIZE_CHANGED, &ip->i_flags);
+		mark_inode_dirty(inode);
+	}
+
 	if (!gfs2_is_stuffed(ip))
 		gfs2_ordered_add_inode(ip);
 
diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index c9af93ac6c73..9f620807b396 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -396,6 +396,7 @@ enum {
 	GIF_ORDERED		= 4,
 	GIF_FREE_VFS_INODE      = 5,
 	GIF_GLOP_PENDING	= 6,
+	GIF_SIZE_CHANGED	= 7,
 };
 
 struct gfs2_inode {
diff --git a/fs/iomap.c b/fs/iomap.c
index 12654c2e78f8..b5c761827966 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -788,9 +788,10 @@ iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
 		ret = __iomap_write_end(inode, pos, len, copied, page, iomap);
 	}
 
-	__generic_write_end(inode, pos, ret, page);
 	if (page_ops && page_ops->page_done)
-		page_ops->page_done(inode, pos, copied, page, iomap);
+		page_ops->page_done(inode, pos, ret, page, iomap);
+	else
+		__generic_write_end(inode, pos, ret, page);
 	put_page(page);
 
 	if (ret < len)
-- 
2.20.1


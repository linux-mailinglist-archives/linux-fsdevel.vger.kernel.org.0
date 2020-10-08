Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B32287C1E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 21:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbgJHTME (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 15:12:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47058 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725887AbgJHTMD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 15:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602184321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QbdDebepqcegjZq6ZjaMiCH83nW5pPyZ79jW0+d2E5o=;
        b=fvRyzOiskfyUCu7sVmSvKQ0bMnmkw5pon2dEUfTVzo3g53UfMyWRHNKDMzT/H2ojwukxqY
        gJeiomEuuzquMcJ6WgLNflqjZYSvK0Q2Ls1izZSJHZFlmJrj8K57BoZYy4ZxkGUNx1jHkg
        VQLwInCkRYkbEVMGZk6SSfosrgahe8c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-575-gSyoyZyTO1ikvJiB0e_aPA-1; Thu, 08 Oct 2020 15:12:00 -0400
X-MC-Unique: gSyoyZyTO1ikvJiB0e_aPA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E26131084D70;
        Thu,  8 Oct 2020 19:11:58 +0000 (UTC)
Received: from bfoster (ovpn-112-249.rdu2.redhat.com [10.10.112.249])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D5775C1D0;
        Thu,  8 Oct 2020 19:11:57 +0000 (UTC)
Date:   Thu, 8 Oct 2020 15:11:55 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] xfs: flush new eof page on truncate to avoid post-eof
 corruption
Message-ID: <20201008191155.GD702156@bfoster>
References: <20201007143509.669729-1-bfoster@redhat.com>
 <20201007153359.GC49547@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007153359.GC49547@magnolia>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 07, 2020 at 08:33:59AM -0700, Darrick J. Wong wrote:
> On Wed, Oct 07, 2020 at 10:35:09AM -0400, Brian Foster wrote:
> > It is possible to expose non-zeroed post-EOF data in XFS if the new
> > EOF page is dirty, backed by an unwritten block and the truncate
> > happens to race with writeback. iomap_truncate_page() will not zero
> > the post-EOF portion of the page if the underlying block is
> > unwritten. The subsequent call to truncate_setsize() will, but
> > doesn't dirty the page. Therefore, if writeback happens to complete
> > after iomap_truncate_page() (so it still sees the unwritten block)
> > but before truncate_setsize(), the cached page becomes inconsistent
> > with the on-disk block. A mapped read after the associated page is
> > reclaimed or invalidated exposes non-zero post-EOF data.
> > 
> > For example, consider the following sequence when run on a kernel
> > modified to explicitly flush the new EOF page within the race
> > window:
> > 
> > $ xfs_io -fc "falloc 0 4k" -c fsync /mnt/file
> > $ xfs_io -c "pwrite 0 4k" -c "truncate 1k" /mnt/file
> >   ...
> > $ xfs_io -c "mmap 0 4k" -c "mread -v 1k 8" /mnt/file
> > 00000400:  00 00 00 00 00 00 00 00  ........
> > $ umount /mnt/; mount <dev> /mnt/
> > $ xfs_io -c "mmap 0 4k" -c "mread -v 1k 8" /mnt/file
> > 00000400:  cd cd cd cd cd cd cd cd  ........
> > 
> > Update xfs_setattr_size() to explicitly flush the new EOF page prior
> > to the page truncate to ensure iomap has the latest state of the
> > underlying block.
> > 
> > Fixes: 68a9f5e7007c ("xfs: implement iomap based buffered write path")
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > ---
> > 
> > This patch is intentionally simplistic because I wanted to get some
> > thoughts on a proper fix and at the same time consider something easily
> > backportable. The iomap behavior seems rather odd to me in general,
> > particularly if we consider the same kind of behavior can occur on
> > file-extending writes. It's just not a user observable problem in that
> > case because a sub-page write of a current EOF page (backed by an
> > unwritten block) will zero fill the rest of the page at write time
> > (before the zero range essentially skips it due to the unwritten block).
> > It's not totally clear to me if that's an intentional design
> > characteristic of iomap or something we should address.
> > 
> > It _seems_ like the more appropriate fix is that iomap truncate page
> > should at least accommodate a dirty page over an unwritten block and
> > modify the page (or perhaps just unconditionally do a buffered write on
> > a non-aligned truncate, similar to what block_truncate_page() does). For
> > example, we could push the UNWRITTEN check from iomap_zero_range_actor()
> > down into iomap_zero(), actually check for an existing page there, and
> > then either zero it or skip out if none exists. Thoughts?
> 
> I haven't looked at this in much depth yet, but I agree with the
> principle that iomap ought to handle the case of unwritten extents
> fronted by dirty pagecache.
> 

Ok. What I was originally thinking above turned out to be too
inefficient. However, it occurred to me that we already have an
efficient cache scanning mechanism in seek data/hole, so I think
something like the appended might be doable. Thoughts?

Brian

--- 8< ---

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index bcfc288dba3f..676d8d2ae7c7 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -944,6 +944,26 @@ static int iomap_zero(struct inode *inode, loff_t pos, unsigned offset,
 	return iomap_write_end(inode, pos, bytes, bytes, page, iomap, srcmap);
 }
 
+static void
+iomap_zero_range_skip_uncached(struct inode *inode, loff_t *pos,
+		loff_t *count, loff_t *written)
+{
+	unsigned dirty_offset, bytes = 0;
+
+	dirty_offset = page_cache_seek_hole_data(inode, *pos, *count,
+				SEEK_DATA);
+	if (dirty_offset == -ENOENT)
+		bytes = *count;
+	else if (dirty_offset > *pos)
+		bytes = dirty_offset - *pos;
+
+	if (bytes) {
+		*pos += bytes;
+		*count -= bytes;
+		*written += bytes;
+	}
+}
+
 static loff_t
 iomap_zero_range_actor(struct inode *inode, loff_t pos, loff_t count,
 		void *data, struct iomap *iomap, struct iomap *srcmap)
@@ -953,12 +973,19 @@ iomap_zero_range_actor(struct inode *inode, loff_t pos, loff_t count,
 	int status;
 
 	/* already zeroed?  we're done. */
-	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN)
+	if (srcmap->type == IOMAP_HOLE)
 		return count;
 
 	do {
 		unsigned offset, bytes;
 
+		if (srcmap->type == IOMAP_UNWRITTEN) {
+			iomap_zero_range_skip_uncached(inode, &pos, &count,
+				&written);
+			if (!count)
+				break;
+		}
+
 		offset = offset_in_page(pos);
 		bytes = min_t(loff_t, PAGE_SIZE - offset, count);
 
diff --git a/fs/iomap/seek.c b/fs/iomap/seek.c
index 107ee80c3568..4f5e4eca9906 100644
--- a/fs/iomap/seek.c
+++ b/fs/iomap/seek.c
@@ -70,7 +70,7 @@ page_seek_hole_data(struct inode *inode, struct page *page, loff_t *lastoff,
  *
  * Returns the resulting offset on successs, and -ENOENT otherwise.
  */
-static loff_t
+loff_t
 page_cache_seek_hole_data(struct inode *inode, loff_t offset, loff_t length,
 		int whence)
 {
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 4d1d3c3469e9..437ae0d708d6 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -184,6 +184,9 @@ loff_t iomap_seek_data(struct inode *inode, loff_t offset,
 		const struct iomap_ops *ops);
 sector_t iomap_bmap(struct address_space *mapping, sector_t bno,
 		const struct iomap_ops *ops);
+loff_t page_cache_seek_hole_data(struct inode *inode, loff_t offset,
+		loff_t length, int whence);
+
 
 /*
  * Structure for writeback I/O completions.


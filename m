Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09844294063
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Oct 2020 18:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394567AbgJTQV6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Oct 2020 12:21:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52656 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2394564AbgJTQV6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Oct 2020 12:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603210916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jZPGLZ2UbwWnE4Ol+iBC2Ktt9/JehuIliPNFTbfixlw=;
        b=ZFKLR5K/CX6Ls5IsVODFv0RnK5l5Xup0lya9xbOLx0ic16d6njrdtWBeWwnaPc0JZOHydD
        malvXXqyiprqrDGqMvcyC+JpYPlAdVDgesNJyhg6PUyOcw2G7kkPdEmJ8aVoPaVTRQI4QU
        i755GN6UaSIPz7m+Aeo54Y/bHewd6E8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-asueB6viO_-JQMx1PkJbCQ-1; Tue, 20 Oct 2020 12:21:54 -0400
X-MC-Unique: asueB6viO_-JQMx1PkJbCQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28C38879517;
        Tue, 20 Oct 2020 16:21:53 +0000 (UTC)
Received: from bfoster (ovpn-112-249.rdu2.redhat.com [10.10.112.249])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AC6261002C19;
        Tue, 20 Oct 2020 16:21:52 +0000 (UTC)
Date:   Tue, 20 Oct 2020 12:21:50 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/2] iomap: zero cached pages over unwritten extents on
 zero range
Message-ID: <20201020162150.GB1272590@bfoster>
References: <20201012140350.950064-1-bfoster@redhat.com>
 <20201012140350.950064-3-bfoster@redhat.com>
 <20201015094901.GC21420@infradead.org>
 <20201019165519.GB1232435@bfoster>
 <20201019180144.GC1232435@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019180144.GC1232435@bfoster>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 19, 2020 at 02:01:44PM -0400, Brian Foster wrote:
> On Mon, Oct 19, 2020 at 12:55:19PM -0400, Brian Foster wrote:
> > On Thu, Oct 15, 2020 at 10:49:01AM +0100, Christoph Hellwig wrote:
> > > > +iomap_zero_range_skip_uncached(struct inode *inode, loff_t *pos,
> > > > +		loff_t *count, loff_t *written)
> > > > +{
> > > > +	unsigned dirty_offset, bytes = 0;
> > > > +
> > > > +	dirty_offset = page_cache_seek_hole_data(inode, *pos, *count,
> > > > +				SEEK_DATA);
> > > > +	if (dirty_offset == -ENOENT)
> > > > +		bytes = *count;
> > > > +	else if (dirty_offset > *pos)
> > > > +		bytes = dirty_offset - *pos;
> > > > +
> > > > +	if (bytes) {
> > > > +		*pos += bytes;
> > > > +		*count -= bytes;
> > > > +		*written += bytes;
> > > > +	}
> > > 
> > > I find the calling conventions weird.  why not return bytes and
> > > keep the increments/decrements of the three variables in the caller?
> > > 
> > 
> > No particular reason. IIRC I had it both ways and just landed on this.
> > I'd change it, but as mentioned in the patch 1 thread I don't think this
> > patch is sufficient (with or without patch 1) anyways because the page
> > can also have been reclaimed before we get here.
> > 
> 
> Christoph,
> 
> What do you think about introducing behavior specific to
> iomap_truncate_page() to unconditionally write zeroes over unwritten
> extents? AFAICT that addresses the race and was historical XFS behavior
> (via block_truncate_page()) before iomap, so is not without precedent.
> What I'd probably do is bury the caller's did_zero parameter into a new
> internal struct iomap_zero_data to pass down into
> iomap_zero_range_actor(), then extend that structure with a
> 'zero_unwritten' field such that iomap_zero_range_actor() can do this:
> 

Ugh, so the above doesn't quite describe historical behavior.
block_truncate_page() converts an unwritten block if a page exists
(dirty or not), but bails out if a page doesn't exist. We could still do
the above, but if we wanted something more intelligent I think we need
to check for a page before we get the mapping to know whether we can
safely skip an unwritten block or need to write over it. Otherwise if we
check for a page within the actor, we have no way of knowing whether
there was a (possibly dirty) page that had been written back and/or
reclaimed since ->iomap_begin(). If we check for the page first, I think
that the iolock/mmaplock in the truncate path ensures that a page can't
be added before we complete. We might be able to take that further and
check for a dirty || writeback page, but that might be safer as a
separate patch. See the (compile tested only) diff below for an idea of
what I was thinking.

Brian

--- 8< ---

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index bcfc288dba3f..2cdfcff02307 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1000,17 +1000,56 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 }
 EXPORT_SYMBOL_GPL(iomap_zero_range);
 
+struct iomap_trunc_priv {
+	bool *did_zero;
+	bool has_page;
+};
+
+static loff_t
+iomap_truncate_page_actor(struct inode *inode, loff_t pos, loff_t count,
+		void *data, struct iomap *iomap, struct iomap *srcmap)
+{
+	struct iomap_trunc_priv	*priv = data;
+	unsigned offset;
+	int status;
+
+	if (srcmap->type == IOMAP_HOLE)
+		return count;
+	if (srcmap->type == IOMAP_UNWRITTEN && !priv->has_page)
+		return count;
+
+	offset = offset_in_page(pos);
+	if (IS_DAX(inode))
+		status = dax_iomap_zero(pos, offset, count, iomap);
+	else
+		status = iomap_zero(inode, pos, offset, count, iomap, srcmap);
+	if (status < 0)
+		return status;
+
+	if (priv->did_zero)
+		*priv->did_zero = true;
+	return count;
+}
+
 int
 iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 		const struct iomap_ops *ops)
 {
+	struct iomap_trunc_priv priv = { .did_zero = did_zero };
 	unsigned int blocksize = i_blocksize(inode);
 	unsigned int off = pos & (blocksize - 1);
+	loff_t ret;
 
 	/* Block boundary? Nothing to do */
 	if (!off)
 		return 0;
-	return iomap_zero_range(inode, pos, blocksize - off, did_zero, ops);
+
+	priv.has_page = filemap_range_has_page(inode->i_mapping, pos, pos);
+	ret = iomap_apply(inode, pos, blocksize - off, IOMAP_ZERO, ops, &priv,
+			  iomap_truncate_page_actor);
+	if (ret <= 0)
+		return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(iomap_truncate_page);
 


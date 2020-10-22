Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D752961BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Oct 2020 17:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368666AbgJVPiZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Oct 2020 11:38:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39076 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S368663AbgJVPiY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Oct 2020 11:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603381102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m4Asgev83Tka7r7j/POCa1VlBTVdBlqPCEudBLFgiIE=;
        b=IesIYjY4npRC5CPzlrOfX6QYhNxOMIernaCXoF9sa4HbHE0DFmM4NAuFVrjTVAjmj0Fac7
        TDEYRyuM/u00WoEilFoZdMF9GwtRoZplVFeSYuECV2CH9nOWD6/n+YFSG90wzz4TJ8ZrBv
        WUih/LYjd7FcLnpqPHF8KZLosXJqGd0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-Iw8-ioMaPw2beEBXi4twzg-1; Thu, 22 Oct 2020 11:38:20 -0400
X-MC-Unique: Iw8-ioMaPw2beEBXi4twzg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72DC4879517;
        Thu, 22 Oct 2020 15:38:19 +0000 (UTC)
Received: from bfoster (ovpn-113-186.rdu2.redhat.com [10.10.113.186])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D878110013D0;
        Thu, 22 Oct 2020 15:38:18 +0000 (UTC)
Date:   Thu, 22 Oct 2020 11:38:17 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2] iomap: zero cached page over unwritten extent on
 truncate page
Message-ID: <20201022153817.GA1370765@bfoster>
References: <20201021133329.1337689-1-bfoster@redhat.com>
 <20201021162547.GL9832@magnolia>
 <20201021165907.GA1328297@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021165907.GA1328297@bfoster>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 21, 2020 at 12:59:07PM -0400, Brian Foster wrote:
> On Wed, Oct 21, 2020 at 09:25:47AM -0700, Darrick J. Wong wrote:
> > On Wed, Oct 21, 2020 at 09:33:29AM -0400, Brian Foster wrote:
> > > iomap_truncate_page() relies on zero range and zero range
> > > unconditionally skips unwritten mappings. This is normally not a
> > > problem as most users synchronize in-core state to the underlying
> > > block mapping by flushing pagecache prior to calling into iomap.
> > > This is not the case for iomap_truncate_page(), however. XFS calls
> > > iomap_truncate_page() on truncate down before flushing the new EOF
> > > page of the file. This means that if the new EOF block is unwritten
> > > but covered by a dirty or writeback page (i.e. awaiting unwritten
> > > conversion after writeback), iomap fails to zero that page. The
> > > subsequent truncate_setsize() call does perform page zeroing, but
> > > doesn't dirty the page. Therefore if the new EOF page is written
> > > back after calling into iomap but before the pagecache truncate, the
> > > post-EOF zeroing is lost on page reclaim. This exposes stale
> > > post-EOF data on mapped reads.
> > > 
> > > Rework iomap_truncate_page() to check pagecache state before calling
> > > into iomap_apply() and use that info to determine whether we can
> > > safely skip zeroing unwritten extents. The filesystem has locked out
> > > concurrent I/O and mapped operations at this point but is not
> > > serialized against writeback, unwritten extent conversion (I/O
> > > completion) or page reclaim. Therefore if a page does not exist
> > > before we acquire the mapping, we can be certain that an unwritten
> > > extent cannot be converted before we return and thus it is safe to
> > > skip. If a page does exist over an unwritten block, it could be in
> > > the dirty or writeback states, convert the underlying mapping at any
> > > time, and thus should be explicitly written to avoid racing with
> > > writeback. Finally, since iomap_truncate_page() only targets the new
> > > EOF block and must now pass additional state to the actor, open code
> > > the zeroing actor instead of plumbing through zero range.
> > > 
> > > This does have the tradeoff that an existing clean page is dirtied
> > > and causes unwritten conversion, but this is analogous to historical
> > > behavior implemented by block_truncate_page(). This patch restores
> > > historical behavior to address the data exposure problem and leaves
> > > filtering out the clean page case for a separate patch.
> > > Fixes: 68a9f5e7007c ("xfs: implement iomap based buffered write path")
> > > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > > ---
> > > 
> > > v2:
> > > - Rework to check for cached page explicitly and avoid use of seek data.
> > > v1: https://lore.kernel.org/linux-fsdevel/20201012140350.950064-1-bfoster@redhat.com/
> > 
> > Has the reproducer listed in that email been turned into a fstest case
> > yet? :)
> > 
> 
> Heh.. that reproducer actually required customization to manufacture the
> problem. I'll have to think more about a generic reproducer.
> 
> FWIW, I've also just come across a similar post-eof data exposure
> failure with this patch, so I'll need to dig into that first and
> foremost and figure out whether this is still incorrect/insufficient for
> some reason...
> 

This actually turned out to be a similar, but separate issue. With the
unwritten problem addressed by this patch, similar post-eof stale data
exposure is possible on truncate down if the new EOF happens to land on
a data fork hole covered by a cow block. I suspect the cow fork block
exists simply due to cow fork preallocation/alignment on overwrite of a
nearby shared block, but then is subsequently written over and the page
dirtied. Similar to the data fork unwritten block problem,
iomap_truncate_page() sees the hole and does nothing even though there
happens to be a dirty page covering the new EOF of the file.

A prospective fix for that one could be to move the IOMAP_ZERO check in
xfs_buffered_write_iomap_begin() a few lines down just after the
immediately following xfs_is_cow_inode() branch. This allows
iomap_truncate_page() to find the "effective" mapping as if it were a
write request (since a write may have previously occurred) and behave
accordingly. That said, I'm not sure that is generally appropriate
because a zero range would unconditionally treat cow blocks as real file
blocks, even if they are transient in nature (i.e., over a hole and
never written).

FWIW, testing that tweak triggers a new zero range problem related to
collapse range. If zero range is modified to find cow fork mappings over
holes, the iomap_zero_range() call via xfs_free_file_space() can issue a
buffered write if it happens to land on a cow fork block that otherwise
isn't mapped in the data fork or cached. This occurs after the data fork
range has been unmapped and thus shortly thereafter writeback completion
drops the cow fork block back into the previously unmapped range of the
data fork. If the free_file_space() occurs for a collapse range, the
collapse ultimately runs into an existing block where it's attempting to
shift (i.e. expecting a hole) and fails.

I think that particular side effect is fixable by cancelling reflink
blocks in the target range of xfs_free_file_space() immediately after
the data fork range is unmapped, but I'm still not convinced moving the
IOMAP_ZERO check is the right approach in the first place. Given all of
this whack-a-mole, I'm kind of wondering if it would be better (at least
as an initial step) to split off a new xfs_truncate_page_iomap_begin()
handler where XFS can potentially fudge the mapping returned to iomap
based on what it wants to see happen. For example, if there's a
dirty||writeback page covering an unwritten data block or cow block,
call it a normal mapping so iomap does the overwrite. If there's an
uncached cow block over a data fork hole, return a hole, etc. Then
again, that idea makes the original patch [1] a heck of a lot more
appealing than I originally thought it was (particularly for a bug that
goes back to v4.8 or so). :P Thoughts? Better ideas?

Brian

[1] https://lore.kernel.org/linux-xfs/20201007143509.669729-1-bfoster@redhat.com/

> > > 
> > >  fs/iomap/buffered-io.c | 41 ++++++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 40 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > index bcfc288dba3f..2cdfcff02307 100644
> > > --- a/fs/iomap/buffered-io.c
> > > +++ b/fs/iomap/buffered-io.c
> > > @@ -1000,17 +1000,56 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
> > >  }
> > >  EXPORT_SYMBOL_GPL(iomap_zero_range);
> > >  
> > > +struct iomap_trunc_priv {
> > > +	bool *did_zero;
> > > +	bool has_page;
> > > +};
> > > +
> > > +static loff_t
> > > +iomap_truncate_page_actor(struct inode *inode, loff_t pos, loff_t count,
> > > +		void *data, struct iomap *iomap, struct iomap *srcmap)
> > > +{
> > > +	struct iomap_trunc_priv	*priv = data;
> > > +	unsigned offset;
> > > +	int status;
> > > +
> > > +	if (srcmap->type == IOMAP_HOLE)
> > > +		return count;
> > > +	if (srcmap->type == IOMAP_UNWRITTEN && !priv->has_page)
> > > +		return count;
> > > +
> > > +	offset = offset_in_page(pos);
> > > +	if (IS_DAX(inode))
> > > +		status = dax_iomap_zero(pos, offset, count, iomap);
> > > +	else
> > > +		status = iomap_zero(inode, pos, offset, count, iomap, srcmap);
> > > +	if (status < 0)
> > > +		return status;
> > > +
> > > +	if (priv->did_zero)
> > > +		*priv->did_zero = true;
> > > +	return count;
> > > +}
> > > +
> > >  int
> > >  iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
> > >  		const struct iomap_ops *ops)
> > >  {
> > > +	struct iomap_trunc_priv priv = { .did_zero = did_zero };
> > >  	unsigned int blocksize = i_blocksize(inode);
> > >  	unsigned int off = pos & (blocksize - 1);
> > > +	loff_t ret;
> > >  
> > >  	/* Block boundary? Nothing to do */
> > >  	if (!off)
> > >  		return 0;
> > > -	return iomap_zero_range(inode, pos, blocksize - off, did_zero, ops);
> > > +
> > > +	priv.has_page = filemap_range_has_page(inode->i_mapping, pos, pos);
> > 
> > Er... shouldn't that second 'pos' be 'pos + blocksize - off - 1', like
> > the apply call below?  I guess it doesn't matter since we're only
> > interested in the page at pos, but the double usage of pos caught my
> > eye.
> > 
> 
> Yeah. I'll fix that up.
> 
> > I also wonder, can you move this into the actor so that you can pass
> > *did_zero straight through without the two-item struct?
> > 
> 
> I don't think so because the idea was to explicitly check for page
> presence prior to getting the mapping.
> 
> Brian
> 
> > --D
> > 
> > > +	ret = iomap_apply(inode, pos, blocksize - off, IOMAP_ZERO, ops, &priv,
> > > +			  iomap_truncate_page_actor);
> > > +	if (ret <= 0)
> > > +		return ret;
> > > +	return 0;
> > >  }
> > >  EXPORT_SYMBOL_GPL(iomap_truncate_page);
> > >  
> > > -- 
> > > 2.25.4
> > > 
> > 
> 


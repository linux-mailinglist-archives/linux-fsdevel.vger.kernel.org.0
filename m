Return-Path: <linux-fsdevel+bounces-33785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 098529BEFDC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 15:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88A6D1F22088
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 14:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAAF200CB7;
	Wed,  6 Nov 2024 14:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZMS7olAi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47ED17DFF2
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Nov 2024 14:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730902324; cv=none; b=BhAcblE6kGlVzhkrWzXrESOKlI7UPHiqw8S+XZnLs8dDcnHOXysotgILrPrxIFFVXbT1EOLYqnc6wRapA3WUpyBtHQKbqgQpi5Oxtp1tJP5l/jrrqkZm3HWLggWoULHx+RTTd+9PiPxy9hm8gbJqk6YOvwOSWFmAeKJSj00Wjpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730902324; c=relaxed/simple;
	bh=yAs94Meuuh4e3cAc9zxE6yTpXkpRFqEoZ0r75jYfv6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fvw7QhhTRRsjQIwWnbAWyLkATRa+20QeImRsI1S54lDfhcs8wknqotTaKBuEeSSpKmEkblk9bfyZ9nwtqlQX5o5WEyUTvRWhgP7G2CYn9b8wpxexyYn4yTxHs8+Pu0BVXRJ9QPI5dN/dnCYgeS+fAzGKdHM6TU2Zk+k6vSwh6XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZMS7olAi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730902320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1u1ZrDlZ7AKa6t96EqZxGJvbXSRf8uXdogw4OF6zlhE=;
	b=ZMS7olAiyDyZSYVx1a6EFUvBbTfCeNFE41qIV9sweewegMPzEr0bnWz+y/3pQ2eLasBzoo
	vrwVb4pBpVLaoNsmCmhmopWqJdLUMtliuVq4um8tZwqdJiK/x5VPu5G6/tzG5dcIe6lSUK
	eoa7A50MXVWAUbH2VIVxUrE+Ask7Nso=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-Z50rSVoDP7iftURoHHTgQQ-1; Wed,
 06 Nov 2024 09:11:57 -0500
X-MC-Unique: Z50rSVoDP7iftURoHHTgQQ-1
X-Mimecast-MFC-AGG-ID: Z50rSVoDP7iftURoHHTgQQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3B0811956096;
	Wed,  6 Nov 2024 14:11:56 +0000 (UTC)
Received: from bfoster (unknown [10.22.64.111])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 96A9A30000DF;
	Wed,  6 Nov 2024 14:11:55 +0000 (UTC)
Date: Wed, 6 Nov 2024 09:13:28 -0500
From: Brian Foster <bfoster@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iomap: elide flush from partial eof zero range
Message-ID: <Zyt5iA3A8Bj16nvW@bfoster>
References: <20241031140449.439576-1-bfoster@redhat.com>
 <20241031140449.439576-3-bfoster@redhat.com>
 <20241106001130.GP21836@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106001130.GP21836@frogsfrogsfrogs>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Nov 05, 2024 at 04:11:30PM -0800, Darrick J. Wong wrote:
> On Thu, Oct 31, 2024 at 10:04:48AM -0400, Brian Foster wrote:
> > iomap zero range flushes pagecache in certain situations to
> > determine which parts of the range might require zeroing if dirty
> > data is present in pagecache. The kernel robot recently reported a
> > regression associated with this flushing in the following stress-ng
> > workload on XFS:
> > 
> > stress-ng --timeout 60 --times --verify --metrics --no-rand-seed --metamix 64
> > 
> > This workload involves repeated small, strided, extending writes. On
> > XFS, this produces a pattern of post-eof speculative preallocation,
> > conversion of preallocation from delalloc to unwritten, dirtying
> > pagecache over newly unwritten blocks, and then rinse and repeat
> > from the new EOF. This leads to repetitive flushing of the EOF folio
> > via the zero range call XFS uses for writes that start beyond
> > current EOF.
> > 
> > To mitigate this problem, special case EOF block zeroing to prefer
> > zeroing the folio over a flush when the EOF folio is already dirty.
> > To do this, split out and open code handling of an unaligned start
> > offset. This brings most of the performance back by avoiding flushes
> > on zero range calls via write and truncate extension operations. The
> > flush doesn't occur in these situations because the entire range is
> > post-eof and therefore the folio that overlaps EOF is the only one
> > in the range.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> 
> Cc: <stable@vger.kernel.org> # v6.12-rc1
> Fixes: 7d9b474ee4cc37 ("iomap: make zero range flush conditional on unwritten mappings")
> 
> perhaps?
> 

Hmm.. I am reluctant just because I was never super convinced at whether
this was all that important. A test robot called it out and it just
seemed easy enough to improve.

> > ---
> >  fs/iomap/buffered-io.c | 42 ++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 38 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 60386cb7b9ef..343a2fa29bec 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -227,6 +227,18 @@ static void ifs_free(struct folio *folio)
> >  	kfree(ifs);
> >  }
> >  
> > +/* helper to reset an iter for reuse */
> > +static inline void
> > +iomap_iter_init(struct iomap_iter *iter, struct inode *inode, loff_t pos,
> > +		loff_t len, unsigned flags)
> 
> Nit: maybe call this iomap_iter_reset() ?
> 

Sure, I like that.

> Also I wonder if it's really safe to zero iomap_iter::private?
> Won't doing that leave a minor logic bomb?
> 

Indeed, good catch.

> > +{
> > +	memset(iter, 0, sizeof(*iter));
> > +	iter->inode = inode;
> > +	iter->pos = pos;
> > +	iter->len = len;
> > +	iter->flags = flags;
> > +}
> > +
> >  /*
> >   * Calculate the range inside the folio that we actually need to read.
> >   */
> > @@ -1416,6 +1428,10 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
> >  		.len		= len,
> >  		.flags		= IOMAP_ZERO,
> >  	};
> > +	struct address_space *mapping = inode->i_mapping;
> > +	unsigned int blocksize = i_blocksize(inode);
> > +	unsigned int off = pos & (blocksize - 1);
> > +	loff_t plen = min_t(loff_t, len, blocksize - off);
> >  	int ret;
> >  	bool range_dirty;
> >  
> > @@ -1425,12 +1441,30 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
> >  	 * mapping converts on writeback completion and must be zeroed.
> >  	 *
> >  	 * The simplest way to deal with this is to flush pagecache and process
> > -	 * the updated mappings. To avoid an unconditional flush, check dirty
> > -	 * state and defer the flush until a combination of dirty pagecache and
> > -	 * at least one mapping that might convert on writeback is seen.
> > +	 * the updated mappings. First, special case the partial eof zeroing
> > +	 * use case since it is more performance sensitive. Zero the start of
> > +	 * the range if unaligned and already dirty in pagecache.
> > +	 */
> > +	if (off &&
> > +	    filemap_range_needs_writeback(mapping, pos, pos + plen - 1)) {
> > +		iter.len = plen;
> > +		while ((ret = iomap_iter(&iter, ops)) > 0)
> > +			iter.processed = iomap_zero_iter(&iter, did_zero);
> > +
> > +		/* reset iterator for the rest of the range */
> > +		iomap_iter_init(&iter, inode, iter.pos,
> > +			len - (iter.pos - pos), IOMAP_ZERO);
> 
> Nit: maybe one more tab ^ here?
> 
> Also from the previous thread: can you reset the original iter instead
> of declaring a second one by zeroing the mappings/processed fields,
> re-expanding iter::len, and resetting iter::flags?
> 

I'm not sure what you mean by "declaring a second one." I think maybe
you're suggesting whether we could just zero out the fields that need to
be, rather than reinit the whole thing...?

Context: I originally had this opencoded and created the helper to clean
up the code. I opted to memset the whole thing to try and avoid creating
a dependency that would have to be updated if the iter code ever
changed, but the ->private thing kind of shows how that problem goes
both ways.

Hmmmmm.. what do you think about maybe just fixing up the iteration path
to reset these fields? We already clear them in iomap_iter_advance()
when another iteration is expected. On a first pass, I don't see
anywhere where the terminal case would care if they were reset there as
well.

I'll have to double check and test of course, but issues
notwithstanding, I suspect that would allow the original logic of just
tacking the remaining length onto iter.len and continuing on. Hm?

> I guess we'll still do the flush if the start of the zeroing range
> aligns with an fsblock?  I guess if you're going to do a lot of small
> extensions then once per fsblock isn't too bad?
> 

Yeah.. we wouldn't be partially zeroing the EOF block in that case, so
would fall back to default behavior. Did you have another case/workload
in mind you were concerned about?

BTW and just in case you missed the analysis in the original report
thread [1], the performance hit here could also be partially attributed
to commit 5ce5674187c34 ("xfs: convert delayed extents to unwritten when
zeroing post eof blocks"). I'm skeptical that an unconditional physical
block allocation per write extension is always a good idea over perhaps
something more based on a heuristic, but as often with XFS I'm a bit too
apathetic of the obstruction^Wreview process to dig into that one..

I do have another minimal iomap patch to warn about the post-eof zero
range angle. I'll tack that onto the next version of this series for
discussion. Thanks for the feedback.

Brian

[1] https://lore.kernel.org/linux-xfs/ZxkE93Vz3ZQaAFO1@bfoster/

> --D
> 
> > +		if (ret || !iter.len)
> > +			return ret;
> > +	}
> > +
> > +	/*
> > +	 * To avoid an unconditional flush, check dirty state and defer the
> > +	 * flush until a combination of dirty pagecache and at least one
> > +	 * mapping that might convert on writeback is seen.
> >  	 */
> >  	range_dirty = filemap_range_needs_writeback(inode->i_mapping,
> > -					pos, pos + len - 1);
> > +					iter.pos, iter.pos + iter.len - 1);
> >  	while ((ret = iomap_iter(&iter, ops)) > 0) {
> >  		const struct iomap *s = iomap_iter_srcmap(&iter);
> >  		if (s->type == IOMAP_HOLE || s->type == IOMAP_UNWRITTEN) {
> > -- 
> > 2.46.2
> > 
> > 
> 



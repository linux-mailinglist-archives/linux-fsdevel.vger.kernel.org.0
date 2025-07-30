Return-Path: <linux-fsdevel+bounces-56331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16165B16137
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 15:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ADAD18910C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 13:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59A1154426;
	Wed, 30 Jul 2025 13:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="idYOLlXB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C8F224CC
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Jul 2025 13:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753881372; cv=none; b=acV8uK5Ev8tkY/PSm2Z+R7Un1DS1bfGP8htXUToeBJHORQr+b/0Y+PtAXpblJUEvzWhbfdvTlwzs2x6a9FKEmuURiKLNG2jeb8mhd9GiDAEFloYRSJ6Z5XNd6rlYRnidYgs9Aq5RJHGYANXMegaR1yY/wKtGiieVgwzMyg/m85Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753881372; c=relaxed/simple;
	bh=mjH4Qcl5wuZQBJLZQkHrKCDAWwcscV/53RyoyUICz1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BE6bTG5zZjwOLbE7KQpUjiaW+isIRA9U8ZoYgiOnfcf6Qf5HP3KsNFhMHLopEkDSULsN2MukcznY3br23Nf+oZRZaRQK/2BYdkOaDQI4sCp5f8nupHiEr/eckjHmE62jM31Hj+cTPqLEoNn2oOiX+6ZVLaReuc6SUwKRPJcMZI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=idYOLlXB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753881368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/R4VJQYylD0cJM8RenirIT0juBtWEm7zoMApnGZxEM8=;
	b=idYOLlXBiSj3O9KboNVx0pTPq6OdY8lW+Lku9Y7W0mkJQIrRhdUI7byng1RTSm1VlNi2f+
	PJDtqJMk1vrrkqUdRMwFft+y+XQg8IQMiPH9ma7qJzbYaapVLiAUD4LP4J5IsD1XU9tbwl
	5MaUN7KeSdHea1GFlUKH1gc3Ujj721g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-vq_f7hZvP8i9-orONA7vXg-1; Wed,
 30 Jul 2025 09:16:07 -0400
X-MC-Unique: vq_f7hZvP8i9-orONA7vXg-1
X-Mimecast-MFC-AGG-ID: vq_f7hZvP8i9-orONA7vXg_1753881365
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6F4B61801368;
	Wed, 30 Jul 2025 13:15:59 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.142])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 929CB1800285;
	Wed, 30 Jul 2025 13:15:57 +0000 (UTC)
Date: Wed, 30 Jul 2025 09:19:52 -0400
From: Brian Foster <bfoster@redhat.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, hch@infradead.org, willy@infradead.org,
	"Darrick J. Wong" <djwong@kernel.org>,
	Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v3 3/7] iomap: optional zero range dirty folio processing
Message-ID: <aIob-GhQ4zk-OLz5@bfoster>
References: <20250714204122.349582-1-bfoster@redhat.com>
 <20250714204122.349582-4-bfoster@redhat.com>
 <20250715052259.GO2672049@frogsfrogsfrogs>
 <e6333d2d-cc30-44d3-8f23-6a6c5ea0134d@huaweicloud.com>
 <aHpQxq6mDyLL1Nfj@bfoster>
 <09b7c1cf-7bfa-4798-b9de-f49620046664@huaweicloud.com>
 <01b0261c-45b9-4076-ab3c-4ae33f535600@huaweicloud.com>
 <6dd1071f-c92c-416c-9a20-b5a99d5fb292@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dd1071f-c92c-416c-9a20-b5a99d5fb292@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, Jul 28, 2025 at 08:57:28PM +0800, Zhang Yi wrote:
> On 2025/7/21 16:47, Zhang Yi wrote:
> > On 2025/7/19 19:07, Zhang Yi wrote:
> >> On 2025/7/18 21:48, Brian Foster wrote:
> >>> On Fri, Jul 18, 2025 at 07:30:10PM +0800, Zhang Yi wrote:
> >>>> On 2025/7/15 13:22, Darrick J. Wong wrote:
> >>>>> On Mon, Jul 14, 2025 at 04:41:18PM -0400, Brian Foster wrote:
> >>>>>> The only way zero range can currently process unwritten mappings
> >>>>>> with dirty pagecache is to check whether the range is dirty before
> >>>>>> mapping lookup and then flush when at least one underlying mapping
> >>>>>> is unwritten. This ordering is required to prevent iomap lookup from
> >>>>>> racing with folio writeback and reclaim.
> >>>>>>
> >>>>>> Since zero range can skip ranges of unwritten mappings that are
> >>>>>> clean in cache, this operation can be improved by allowing the
> >>>>>> filesystem to provide a set of dirty folios that require zeroing. In
> >>>>>> turn, rather than flush or iterate file offsets, zero range can
> >>>>>> iterate on folios in the batch and advance over clean or uncached
> >>>>>> ranges in between.
> >>>>>>
> >>>>>> Add a folio_batch in struct iomap and provide a helper for fs' to
> >>>>>
> >>>>> /me confused by the single quote; is this supposed to read:
> >>>>>
> >>>>> "...for the fs to populate..."?
> >>>>>
> >>>>> Either way the code changes look like a reasonable thing to do for the
> >>>>> pagecache (try to grab a bunch of dirty folios while XFS holds the
> >>>>> mapping lock) so
> >>>>>
> >>>>> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> >>>>>
> >>>>> --D
> >>>>>
> >>>>>
> >>>>>> populate the batch at lookup time. Update the folio lookup path to
> >>>>>> return the next folio in the batch, if provided, and advance the
> >>>>>> iter if the folio starts beyond the current offset.
> >>>>>>
> >>>>>> Signed-off-by: Brian Foster <bfoster@redhat.com>
> >>>>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
> >>>>>> ---
> >>>>>>  fs/iomap/buffered-io.c | 89 +++++++++++++++++++++++++++++++++++++++---
> >>>>>>  fs/iomap/iter.c        |  6 +++
> >>>>>>  include/linux/iomap.h  |  4 ++
> >>>>>>  3 files changed, 94 insertions(+), 5 deletions(-)
> >>>>>>
> >>>>>> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> >>>>>> index 38da2fa6e6b0..194e3cc0857f 100644
> >>>>>> --- a/fs/iomap/buffered-io.c
> >>>>>> +++ b/fs/iomap/buffered-io.c
> >>>> [...]
> >>>>>> @@ -1398,6 +1452,26 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
> >>>>>>  	return status;
> >>>>>>  }
> >>>>>>  
> >>>>>> +loff_t
> >>>>>> +iomap_fill_dirty_folios(
> >>>>>> +	struct iomap_iter	*iter,
> >>>>>> +	loff_t			offset,
> >>>>>> +	loff_t			length)
> >>>>>> +{
> >>>>>> +	struct address_space	*mapping = iter->inode->i_mapping;
> >>>>>> +	pgoff_t			start = offset >> PAGE_SHIFT;
> >>>>>> +	pgoff_t			end = (offset + length - 1) >> PAGE_SHIFT;
> >>>>>> +
> >>>>>> +	iter->fbatch = kmalloc(sizeof(struct folio_batch), GFP_KERNEL);
> >>>>>> +	if (!iter->fbatch)
> >>>>
> >>>> Hi, Brian!
> >>>>
> >>>> I think ext4 needs to be aware of this failure after it converts to use
> >>>> iomap infrastructure. It is because if we fail to add dirty folios to the
> >>>> fbatch, iomap_zero_range() will flush those unwritten and dirty range.
> >>>> This could potentially lead to a deadlock, as most calls to
> >>>> ext4_block_zero_page_range() occur under an active journal handle.
> >>>> Writeback operations under an active journal handle may result in circular
> >>>> waiting within journal transactions. So please return this error code, and
> >>>> then ext4 can interrupt zero operations to prevent deadlock.
> >>>>
> >>>
> >>> Hi Yi,
> >>>
> >>> Thanks for looking at this.
> >>>
> >>> Huh.. so the reason for falling back like this here is just that this
> >>> was considered an optional optimization, with the flush in
> >>> iomap_zero_range() being default fallback behavior. IIUC, what you're
> >>> saying means that the current zero range behavior without this series is
> >>> problematic for ext4-on-iomap..? 
> >>
> >> Yes.
> >>
> >>> If so, have you observed issues you can share details about?
> >>
> >> Sure.
> >>
> >> Before delving into the specific details of this issue, I would like
> >> to provide some background information on the rule that ext4 cannot
> >> wait for writeback in an active journal handle. If you are aware of
> >> this background, please skip this paragraph. During ext4 writing back
> >> the page cache, it may start a new journal handle to allocate blocks,
> >> update the disksize, and convert unwritten extents after the I/O is
> >> completed. When starting this new journal handle, if the current
> >> running journal transaction is in the process of being submitted or
> >> if the journal space is insufficient, it must wait for the ongoing
> >> transaction to be completed, but the prerequisite for this is that all
> >> currently running handles must be terminated. However, if we flush the
> >> page cache under an active journal handle, we cannot stop it, which
> >> may lead to a deadlock.
> >>
> >> Now, the issue I have observed occurs when I attempt to use
> >> iomap_zero_range() within ext4_block_zero_page_range(). My current
> >> implementation are below(based on the latest fs-next).
> >>
> >> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> >> index 28547663e4fd..1a21667f3f7c 100644
> >> --- a/fs/ext4/inode.c
> >> +++ b/fs/ext4/inode.c
> >> @@ -4147,6 +4147,53 @@ static int ext4_iomap_buffered_da_write_end(struct inode *inode, loff_t offset,
> >>  	return 0;
> >>  }
> >>
> >> +static int ext4_iomap_buffered_zero_begin(struct inode *inode, loff_t offset,
> >> +			loff_t length, unsigned int flags, struct iomap *iomap,
> >> +			struct iomap *srcmap)
> >> +{
> >> +	struct iomap_iter *iter = container_of(iomap, struct iomap_iter, iomap);
> >> +	struct ext4_map_blocks map;
> >> +	u8 blkbits = inode->i_blkbits;
> >> +	int ret;
> >> +
> >> +	ret = ext4_emergency_state(inode->i_sb);
> >> +	if (unlikely(ret))
> >> +		return ret;
> >> +
> >> +	if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
> >> +		return -EINVAL;
> >> +
> >> +	/* Calculate the first and last logical blocks respectively. */
> >> +	map.m_lblk = offset >> blkbits;
> >> +	map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
> >> +			  EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
> >> +
> >> +	ret = ext4_map_blocks(NULL, inode, &map, 0);
> >> +	if (ret < 0)
> >> +		return ret;
> >> +
> >> +	/*
> >> +	 * Look up dirty folios for unwritten mappings within EOF. Providing
> >> +	 * this bypasses the flush iomap uses to trigger extent conversion
> >> +	 * when unwritten mappings have dirty pagecache in need of zeroing.
> >> +	 */
> >> +	if ((map.m_flags & EXT4_MAP_UNWRITTEN) &&
> >> +	    map.m_lblk < EXT4_B_TO_LBLK(inode, i_size_read(inode))) {
> >> +		loff_t end;
> >> +
> >> +		end = iomap_fill_dirty_folios(iter, map.m_lblk << blkbits,
> >> +					      map.m_len << blkbits);
> >> +		if ((end >> blkbits) < map.m_lblk + map.m_len)
> >> +			map.m_len = (end >> blkbits) - map.m_lblk;
> >> +	}
> >> +
> >> +	ext4_set_iomap(inode, iomap, &map, offset, length, flags);
> >> +	return 0;
> >> +}
> >> +
> >> +const struct iomap_ops ext4_iomap_buffered_zero_ops = {
> >> +	.iomap_begin = ext4_iomap_buffered_zero_begin,
> >> +};
> >>
> >>  const struct iomap_ops ext4_iomap_buffered_write_ops = {
> >>  	.iomap_begin = ext4_iomap_buffered_write_begin,
> >> @@ -4611,6 +4658,17 @@ static int __ext4_block_zero_page_range(handle_t *handle,
> >>  	return err;
> >>  }
> >>
> >> +static inline int ext4_iomap_zero_range(struct inode *inode, loff_t from,
> >> +					loff_t length)
> >> +{
> >> +	WARN_ON_ONCE(!inode_is_locked(inode) &&
> >> +		     !rwsem_is_locked(&inode->i_mapping->invalidate_lock));
> >> +
> >> +	return iomap_zero_range(inode, from, length, NULL,
> >> +				&ext4_iomap_buffered_zero_ops,
> >> +				&ext4_iomap_write_ops, NULL);
> >> +}
> >> +
> >>  /*
> >>   * ext4_block_zero_page_range() zeros out a mapping of length 'length'
> >>   * starting from file offset 'from'.  The range to be zero'd must
> >> @@ -4636,6 +4694,8 @@ static int ext4_block_zero_page_range(handle_t *handle,
> >>  	if (IS_DAX(inode)) {
> >>  		return dax_zero_range(inode, from, length, NULL,
> >>  				      &ext4_iomap_ops);
> >> +	} else if (ext4_test_inode_state(inode, EXT4_STATE_BUFFERED_IOMAP)) {
> >> +		return ext4_iomap_zero_range(inode, from, length);
> >>  	}
> >>  	return __ext4_block_zero_page_range(handle, mapping, from, length);
> >>  }
> >>
> >> The problem is most calls to ext4_block_zero_page_range() occur under
> >> an active journal handle, so I can reproduce the deadlock issue easily
> >> without this series.
> >>
> >>>
> >>> FWIW, I think your suggestion is reasonable, but I'm also curious what
> >>> the error handling would look like in ext4. Do you expect to the fail
> >>> the higher level operation, for example? Cycle locks and retry, etc.?
> >>
> >> Originally, I wanted ext4_block_zero_page_range() to return a failure
> >> to the higher level operation. However, unfortunately, after my testing
> >> today, I discovered that even though we implement this, this series still
> >> cannot resolve the issue. The corner case is:
> >>
> >> Assume we have a dirty folio covers both hole and unwritten mappings.
> >>
> >>    |- dirty folio  -|
> >>    [hhhhhhhhuuuuuuuu]                h:hole, u:unwrtten
> >>
> >> If we punch the range of the hole, ext4_punch_hole()->
> >> ext4_zero_partial_blocks() will zero out the first half of the dirty folio.
> >> Then, ext4_iomap_buffered_zero_begin() will skip adding this dirty folio
> >> since the target range is a hole. Finally, iomap_zero_range() will still
> >> flush this whole folio and lead to deadlock during writeback the latter
> >> half of the folio.
> >>
> >>>
> >>> The reason I ask is because the folio_batch handling has come up through
> >>> discussions on this series. My position so far has been to keep it as a
> >>> separate allocation and to keep things simple since it is currently
> >>> isolated to zero range, but that may change if the usage spills over to
> >>> other operations (which seems expected at this point). I suspect that if
> >>> a filesystem actually depends on this for correct behavior, that is
> >>> another data point worth considering on that topic.
> >>>
> >>> So that has me wondering if it would be better/easier here to perhaps
> >>> embed the batch in iomap_iter, or maybe as an incremental step put it on
> >>> the stack in iomap_zero_range() and initialize the iomap_iter pointer
> >>> there instead of doing the dynamic allocation (then the fill helper
> >>> would set a flag to indicate the fs did pagecache lookup). Thoughts on
> >>> something like that?
> >>>
> >>> Also IIUC ext4-on-iomap is still a WIP and review on this series seems
> >>> to have mostly wound down. Any objection if the fix for that comes along
> >>> as a followup patch rather than a rework of this series?
> >>
> >> It seems that we don't need to modify this series, we need to consider
> >> other solutions to resolve this deadlock issue.
> >>
> >> In my v1 ext4-on-iomap series [1], I resolved this issue by moving all
> >> instances of ext4_block_zero_page_range() out of the running journal
> >> handle(please see patch 19-21). But I don't think this is a good solution
> >> since it's complex and fragile. Besides, after commit c7fc0366c6562
> >> ("ext4: partial zero eof block on unaligned inode size extension"), you
> >> added more invocations of ext4_zero_partial_blocks(), and the situation
> >> has become more complicated (Althrough I think the calls in the three
> >> write_end callbacks can be removed).
> >>
> >> Besides, IIUC, it seems that ext4 doesn't need to flush dirty folios
> >> over unwritten mappings before zeroing partial blocks. This is because
> >> ext4 always zeroes the in-memory page cache before zeroing(e.g, in
> >> ext4_setattr() and ext4_punch_hole()), it means if the target range is
> >> still dirty and unwritten when calling ext4_block_zero_page_range(), it
> >> must has already been zeroed. Was I missing something? Therefore, I was
> >> wondering if there are any ways to prevent flushing in
> >> iomap_zero_range()? Any ideas?
> >>
> > 
> > The commit 7d9b474ee4cc ("iomap: make zero range flush conditional on
> > unwritten mappings") mentioned the following:
> > 
> >   iomap_zero_range() flushes pagecache to mitigate consistency
> >   problems with dirty pagecache and unwritten mappings. The flush is
> >   unconditional over the entire range because checking pagecache state
> >   after mapping lookup is racy with writeback and reclaim. There are
> >   ways around this using iomap's mapping revalidation mechanism, but
> >   this is not supported by all iomap based filesystems and so is not a
> >   generic solution.
> > 
> > Does the revalidation mechanism here refer to verifying the validity of
> > the mapping through iomap_write_ops->iomap_valid()? IIUC, does this mean
> > that if the filesystem implement the iomap_valid() interface, we can
> > always avoid the iomap_zero_range() from flushing dirty folios back?
> > Something like below:
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 73772d34f502..ba71a6ed2f77 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -1522,7 +1522,10 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
> > 
> > 			if (range_dirty) {
> > 				range_dirty = false;
> > -				status = iomap_zero_iter_flush_and_stale(&iter);
> > +				if (write_ops->iomap_valid)
> > +					status = iomap_zero_iter(&iter, did_zero, write_ops);
> > +				else
> > +					status = iomap_zero_iter_flush_and_stale(&iter);
> > 			} else {
> > 				status = iomap_iter_advance_full(&iter);
> > 			}
> >
> 
> The above diff will trigger
> WARN_ON_ONCE(folio_pos(folio) > iter->inode->i_size) in iomap_zero_iter()
> on XFS. I revised the 'diff' and ran xfstests with several main configs
> on both XFS and ext4(with iomap infrastructure), and everything seems to
> be working fine so far. What do you think?
> 

A couple things here.. First, I don't think it's quite enough to assume
zeroing is safe just because a revalidation callback is defined. I have
multiple (old) prototypes around fixing zero range, one of which was
centered around using ->iomap_valid(), so I do believe it's technically
possible with further changes. That's what the above "There are ways
around this using the revalidation mechanism" text was referring to
generally.

That said, I don't think going down that path is the right solution
here. I opted for the folio batch approach in favor of that one because
it is more generic, for one. Based on a lot of the discussion around
this series, it also seems to be more broadly useful. For example, there
is potential to use for other operations, including buffered writes. If
that pans out (no guarantees of course), then the fill thing becomes
more of a generic iomap step vs. something called by the fs. That likely
means the flush this is trying to work around can also go away entirely.

I.e., the flush is really just a fallback mechanism for fs' that don't
care or know any better, since there is no guarantee the callback fills
the batch and a flush is better than silent data corruption. So I'd
really like to avoid trying to reinvent things here if at all possible.
I'm curious if the tweaks proposed in the previous reply would be
sufficient for ext4. If so, I can dig into that after rolling the next
version of this series..

Brian

> Thanks,
> Yi.
> 
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 73772d34f502..a75cdb22bab0 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1444,9 +1444,6 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero,
>  			break;
>  		}
> 
> -		/* warn about zeroing folios beyond eof that won't write back */
> -		WARN_ON_ONCE(folio_pos(folio) > iter->inode->i_size);
> -
>  		folio_zero_range(folio, offset, bytes);
>  		folio_mark_accessed(folio);
> 
> @@ -1515,22 +1512,44 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
>  				 srcmap->type != IOMAP_UNWRITTEN))
>  			return -EIO;
> 
> -		if (!iter.fbatch &&
> -		    (srcmap->type == IOMAP_HOLE ||
> -		     srcmap->type == IOMAP_UNWRITTEN)) {
> -			s64 status;
> +		if (iter.fbatch || (srcmap->type != IOMAP_HOLE &&
> +				    srcmap->type != IOMAP_UNWRITTEN)) {
> +			iter.status = iomap_zero_iter(&iter, did_zero,
> +						      write_ops);
> +			continue;
> +		}
> 
> -			if (range_dirty) {
> -				range_dirty = false;
> -				status = iomap_zero_iter_flush_and_stale(&iter);
> -			} else {
> -				status = iomap_iter_advance_full(&iter);
> -			}
> -			iter.status = status;
> +		/*
> +		 * No fbatch, and the target is either a hole or an unwritten
> +		 * range, skip zeroing if the range is not dirty.
> +		 */
> +		if (!range_dirty) {
> +			iter.status = iomap_iter_advance_full(&iter);
>  			continue;
>  		}
> 
> -		iter.status = iomap_zero_iter(&iter, did_zero, write_ops);
> +		/*
> +		 * The range is dirty, if the given filesystm does not specify
> +		 * a revalidation mechanism, flush the entire range to prevent
> +		 * mapping changes that could race with writeback and reclaim.
> +		 */
> +		if (!write_ops->iomap_valid) {
> +			range_dirty = false;
> +			iter.status = iomap_zero_iter_flush_and_stale(&iter);
> +			continue;
> +		}
> +
> +		/*
> +		 * The filesystem specifies an iomap_valid() helper. It is safe
> +		 * to zero out the current range if it is unwritten and dirty.
> +		 */
> +		if (srcmap->type == IOMAP_UNWRITTEN &&
> +		    filemap_range_needs_writeback(mapping, iter.pos,
> +						  iomap_length(&iter)))
> +			iter.status = iomap_zero_iter(&iter, did_zero,
> +						      write_ops);
> +		else
> +			iter.status = iomap_iter_advance_full(&iter);
>  	}
>  	return ret;
>  }
> 
> 



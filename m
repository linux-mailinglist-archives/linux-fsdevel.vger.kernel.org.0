Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A236366F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 18:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235632AbiKWR0g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 12:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236459AbiKWR0f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 12:26:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41C08DA6A
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 09:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669224336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DVBjseWk6NsvMFRo4FrpZoWzmnsYbk3PTXYDioqWBPc=;
        b=ZLXTofQP2vJUZLyigcWakLo1M6DgKFG8Cic9uGWNbKwD7JKasH6GmfCE3AE+jMZC8cGE2R
        21q/v8C/Hb8NEmIjW+Q7IBh7sH1sAa0zUPosX7XkBTWplZwmcNeyUSmeWMaT6u+LyZhkc+
        jKknx1DxmTDOzF65463/1qXDHtxvfxM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-531-ZcfnhPYjNqabJcAshpJdoQ-1; Wed, 23 Nov 2022 12:25:32 -0500
X-MC-Unique: ZcfnhPYjNqabJcAshpJdoQ-1
Received: by mail-qk1-f198.google.com with SMTP id x2-20020a05620a448200b006fa7dad5c1cso23162854qkp.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 09:25:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVBjseWk6NsvMFRo4FrpZoWzmnsYbk3PTXYDioqWBPc=;
        b=o+IFvOqyYqo/d1KzM4es3FyclhZKYGPjBJrM+U18o69nu63hp4mBpbLM2mDgP5/Tm9
         yEm955JtTD9R/r7R+7qua4aaW8upA7Xky+4GZlH+O0iZAW8CnXWEaq88FOhuf2ZCHwWt
         A28aXMbFw01EcAYameTZ8L7YYvEzOYo7U8AMgbig7e5tu2yCErxpgMrIS7eQ7wQC+ML7
         tSOORwVsIARnsFvCY/CX+rOd5ajxWtR4RHXb4oK1J4h+5FrVaTJ2VH7u4VdrGj3uHfjX
         JuYvynuj/eQUt+QU09GGLMFnQMpm8WTX5p6GPQlIfN/+Bf6xCrqp4Ab8qINnehfbEIcg
         TIUA==
X-Gm-Message-State: ANoB5pm0DkQoOF0p+wqy7+qHXbCuQ0HB4Hgss2ad9siYhF1/QYJOS/18
        EoSLLpoT9JQ1cl7MLEH6hthlGE9Gh9AtY1mqiaj1Oa1/UWWeD5xmnkl13R7JopNRcRs310eVzDe
        d2g+Fl7cejcp7t60BfsqAVRv+vQ==
X-Received: by 2002:a05:620a:2b41:b0:6fb:f2dc:eca4 with SMTP id dp1-20020a05620a2b4100b006fbf2dceca4mr12933442qkb.505.1669224331765;
        Wed, 23 Nov 2022 09:25:31 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6mgS0GKj4OyBrd5rBWZzr0CUqYfcmIATbkGJgHuOmcfRA3BlaWVnSFYWQFMN8QwfQSE+rxCQ==
X-Received: by 2002:a05:620a:2b41:b0:6fb:f2dc:eca4 with SMTP id dp1-20020a05620a2b4100b006fbf2dceca4mr12933407qkb.505.1669224331271;
        Wed, 23 Nov 2022 09:25:31 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id do25-20020a05620a2b1900b006fba0a389a4sm3255296qkb.88.2022.11.23.09.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 09:25:30 -0800 (PST)
Date:   Wed, 23 Nov 2022 12:25:35 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 5/9] xfs: buffered write failure should not truncate the
 page cache
Message-ID: <Y35Xjxt9mKKKqob9@bfoster>
References: <20221115013043.360610-1-david@fromorbit.com>
 <20221115013043.360610-6-david@fromorbit.com>
 <Y3TsPzd0XzXXIzQv@bfoster>
 <20221117004133.GD3600936@dread.disaster.area>
 <Y3e+7XH5gq5gc97u@bfoster>
 <20221121231304.GM3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121231304.GM3600936@dread.disaster.area>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 22, 2022 at 10:13:04AM +1100, Dave Chinner wrote:
> On Fri, Nov 18, 2022 at 12:20:45PM -0500, Brian Foster wrote:
> > On Thu, Nov 17, 2022 at 11:41:33AM +1100, Dave Chinner wrote:
> > > On Wed, Nov 16, 2022 at 08:57:19AM -0500, Brian Foster wrote:
> > > > On Tue, Nov 15, 2022 at 12:30:39PM +1100, Dave Chinner wrote:
> > > > > From: Dave Chinner <dchinner@redhat.com>
> > > > > 
> > > > ...
> > > > > 
> > > > > Signed-off-by: Dave Chinner <dchinner@redhat.com> ---
> > > > > fs/xfs/xfs_iomap.c | 151
> > > > > ++++++++++++++++++++++++++++++++++++++++++--- 1 file
> > > > > changed, 141 insertions(+), 10 deletions(-)
> > > > > 
> > > > > diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c index
> > > > > 7bb55dbc19d3..2d48fcc7bd6f 100644 --- a/fs/xfs/xfs_iomap.c
> > > > > +++ b/fs/xfs/xfs_iomap.c @@ -1134,6 +1134,146 @@
> > > > > xfs_buffered_write_delalloc_punch( end_fsb - start_fsb); }
> > > > >  
> > > > ...
> > > > > +/* + * Punch out all the delalloc blocks in the range given
> > > > > except for those that + * have dirty data still pending in
> > > > > the page cache - those are going to be + * written and so
> > > > > must still retain the delalloc backing for writeback.  + * +
> > > > > * As we are scanning the page cache for data, we don't need
> > > > > to reimplement the + * wheel - mapping_seek_hole_data() does
> > > > > exactly what we need to identify the + * start and end of
> > > > > data ranges correctly even for sub-folio block sizes. This +
> > > > > * byte range based iteration is especially convenient
> > > > > because it means we don't + * have to care about variable
> > > > > size folios, nor where the start or end of the + * data
> > > > > range lies within a folio, if they lie within the same folio
> > > > > or even if + * there are multiple discontiguous data ranges
> > > > > within the folio.  + */ +static int
> > > > > +xfs_buffered_write_delalloc_release( +	struct inode
> > > > > *inode, +	loff_t			start_byte, +
> > > > > loff_t			end_byte) +{ +	loff_t
> > > > > punch_start_byte = start_byte; +	int
> > > > > error = 0; + +	/* +	 * Lock the mapping to avoid races
> > > > > with page faults re-instantiating +	 * folios and
> > > > > dirtying them via ->page_mkwrite whilst we walk the +	 *
> > > > > cache and perform delalloc extent removal. Failing to do
> > > > > this can +	 * leave dirty pages with no space
> > > > > reservation in the cache.  +	 */ +
> > > > > filemap_invalidate_lock(inode->i_mapping); +	while
> > > > > (start_byte < end_byte) { +		loff_t
> > > > > data_end; + +		start_byte =
> > > > > mapping_seek_hole_data(inode->i_mapping, +
> > > > > start_byte, end_byte, SEEK_DATA);
> > > > 
> > > > FWIW, the fact that mapping seek data is based on uptodate
> > > > status means that seek behavior can change based on prior
> > > > reads.
> > > 
> > > Yup. It should be obvious that any page cache scan based
> > > algorithm will change based on changing page cache residency.
> > > 
> > > > For example, see how seek hole/data presents reads of
> > > > unwritten ranges as data [1]. The same thing isn't observable
> > > > for holes because iomap doesn't check the mapping in that
> > > > case, but underlying iop state is the same and that is what
> > > > this code is looking at.
> > > 
> > > Well, yes.  That's the fundamental, underlying issue that this
> > > patchset is addressing for the write() operation: that the page
> > > cache contents and the underlying filesystem extent map are not
> > > guaranteed to be coherent and can be changed independently of
> > > each other.
> > > 
> > > The whole problem with looking exclusively at filesystem level
> > > extent state (and hence FIEMAP) is that the extent state doesn't
> > > tell us whether the is uncommitted data over the range of the
> > > extent in the page cache.  The filesystem extent state and page
> > > cache data *can't be coherent* in a writeback caching
> > > environment. This is the fundamental difference between what the
> > > filesystem extent map tells us (FIEMAP) and what querying the
> > > page cache tells us (SEEK_DATA/SEEK_HOLE).
> > > 
> > > This is also the underlying problem with iomap_truncate_page() -
> > > it fails to query the page cache for data over unwritten
> > > extents, so fails to zero the post-EOF part of dirty folios over
> > > unwritten extents and so it all goes wrong...
> > > 
> > > > The filtering being done here means we essentially only care
> > > > about dirty pages backed by delalloc blocks. That means if you
> > > > get here with a dirty page and the portion of the page
> > > > affected by this failed write is uptodate, this won't punch an
> > > > underlying delalloc block even though nothing else may have
> > > > written to it in the meantime.
> > > 
> > > Hmmm. IOMAP_F_NEW implies that the newly allocated delalloc
> > > iomap will not span ranges that have pre-existing *dirty* data
> > > in the page cache. Those *must* already have (del)allocated
> > > extents, hence the iomap for the newly allocated delalloc extent
> > > will always end before pre-existing dirty data in the page cache
> > > starts.
> > > 
> > > Hence the seek scan range over an IOMAP_F_NEW IOMAP_DELALLOC map
> > > precludes stepping into ranges that have pre-existing cached
> > > dirty data.
> > > 
> > > We also can't get a racing write() to the same range right now
> > > because this is all under IOLOCK_EXCL, hence we only ever see
> > > dirty folios as a result of race with page faults. page faults
> > > zero the entire folio they insert into the page cache and
> > > iomap_folio_mkwrite_iter() asserts that the entire folio is
> > > marked up to date. Hence if we find a dirty folio outside the
> > > range the write() dirtied, we are guaranteed that the entire
> > > dirty folio is up to date....
> > > 
> > > Yes, there can be pre-existing *clean* folios (and clean
> > > partially up to date folios) in the page cache, but we won't
> > > have dirty partially up to date pages in the middle of the range
> > > we are scanning. Hence we only need to care about the edge cases
> > > (folios that overlap start and ends). We skip the partially
> > > written start block, and we always punch up to the end block if
> > > it is different from the last block we punched up to. If the end
> > > of the data spans into a dirty folio, we know that dirty range
> > > is up to date because the seek scan only returns ranges that are
> > > up to date. Hence we don't punch those partial blocks out....
> > > 
> > > Regardless, let's assume we have a racing write that has
> > > partially updated and dirtied a folio (because we've moved to
> > > XFS_IOLOCK_SHARED locking for writes). This case is already
> > > handled by the mapping_seek_hole_data() based iteration.
> > > 
> > > That is, the mapping_seek_hole_data() loop provides us with
> > > *discrete ranges of up to date data* that are independent of
> > > folio size, up-to-date range granularity, dirty range tracking,
> > > filesystem block size, etc.
> > > 
> > > Hence if the next discrete range we discover is in the same
> > > dirty folio as the previous discrete range of up to date data,
> > > we know we have a sub-folio sized hole in the data that is not
> > > up to date.  Because there is no data over this range, we have
> > > to punch out the underlying delalloc extent over that range. 
> > > 
> > > IOWs, the dirty state of the folio and/or the granularity of the
> > > dirty range tracking is irrelevant here - we know there was no
> > > data in the cache (dlean or dirty) over this range because it is
> > > discontiguous with the previous range of data returned.
> > > 
> > > IOWs, if we have this "up to date" map on a dirty folio like
> > > this:
> > > 
> > > Data		+-------+UUUUUUU+-------+UUUUUUU+-------+
> > > Extent map	+DDDDDDD+DDDDDDD+DDDDDDD+DDDDDDD+DDDDDDD+
> > > 
> > > Then the unrolled iteration and punching we do would look like
> > > this:
> > > 
> > > First iteration of the range:
> > > 
> > > punch_start: V +-------+UUUUUUU+-------+UUUUUUU+-------+
> > > 
> > > SEEK_DATA:		V +-------+UUUUUUU+-------+UUUUUUU+-------+
> > > SEEK_HOLE:			^ Data range:		+UUUUUUU+
> > > Punch range:	+-------+ Extent map:
> > > +-------+DDDDDDD+DDDDDDD+DDDDDDD+DDDDDDD+
> > > 
> > > Second iteration:
> > > 
> > > punch_start			V
> > > +-------+UUUUUUU+-------+UUUUUUU+-------+ SEEK_DATA:
> > > V +-------+UUUUUUU+-------+UUUUUUU+-------+ SEEK_HOLE:
> > > ^ Data range:				+UUUUUUU+ Punch
> > > range:			+-------+ Extent map:
> > > +-------+DDDDDDD+-------+DDDDDDD+DDDDDDD+
> > > 
> > > Third iteration:
> > > 
> > > punch_start					V
> > > +-------+UUUUUUU+-------+UUUUUUU+-------+ SEEK_DATA: - moves
> > > into next folio in cache ....  Punch range:
> > > +-------+ ......  Extent map:
> > > +-------+DDDDDDD+-------+DDDDDDD+-------+ ......  (to end of
> > > scan range or start of next data)
> > > 
> > > As you can see, this scan does not care about folio size,
> > > sub-folio range granularity or filesystem block sizes.  It also
> > > matches exactly how writeback handles dirty, partially up to
> > > date folios, so there's no stray delalloc blocks left around to
> > > be tripped over after failed or short writes occur.
> > > 
> > > Indeed, if we move to sub-folio dirty range tracking, we can
> > > simply add a mapping_seek_hole_data() variant that walks dirty
> > > ranges in the page cache rather than up to date ranges. Then we
> > > can remove the inner loop from this code that looks up folios to
> > > determine dirty state. The above algorithm does not change - we
> > > just walk from discrete range to discrete range punching the
> > > gaps between them....
> > > 
> > > IOWs, the algorithm is largely future proof - the only thing
> > > that needs to change if we change iomap to track sub-folio dirty
> > > ranges is how we check the data range for being dirty. That
> > > should be no surprise, really, the surprise should be that we
> > > can make some simple mods to page cache seek to remove the need
> > > for checking dirty state in this code altogether....
> > > 
> > > > That sort of state can be created by a prior read of the range
> > > > on a sub-page block size fs, or perhaps a racing async
> > > > readahead (via read fault of a lower offset..?), etc.
> > > 
> > > Yup, generic/346 exercises this racing unaligned, sub-folio mmap
> > > write vs write() case. This test, specifically, was the reason I
> > > moved to using mapping_seek_hole_data() - g/346 found an endless
> > > stream of bugs in the sub-multi-page-folio range iteration code
> > > I kept trying to write....
> > > 
> > > > I suspect this is not a serious error because the page is
> > > > dirty and writeback will thus convert the block. The only
> > > > exception to that I can see is if the block is beyond EOF
> > > > (consider a mapped read to a page that straddles EOF, followed
> > > > by a post-eof write that fails), writeback won't actually map
> > > > the block directly.
> > > 
> > > I don't think that can happen. iomap_write_failed() calls
> > > truncate_pagecache_range() to remove any newly instantiated
> > > cached data beyond the original EOF. Hence the delalloc punch
> > > will remove everything beyond the original EOF that was
> > > allocated for the failed write. Hence when we get to writeback
> > > we're not going to find any up-to-date data beyond the EOF block
> > > in the page cache, nor any stray delalloc blocks way beyond
> > > EOF....
> > > 
> > 
> > It can happen if the page straddles eof. I don't think much of the
> > above relates to the behavior I'm describing. This doesn't require
> > racing writes, theoretical shared write locking, the IOMAP_F_NEW
> > flag or core iteration algorithm are not major factors, etc.
> > 
> > It's easier to just use examples. Consider the following sequence
> > on a bsize=1k fs on a kernel with this patch series. Note that my
> > xfs_io is hacked up to turn 'pwrite -f' into a "fail" flag that
> > triggers the -EFAULT error check in iomap_write_iter() by passing
> > a bad user buffer:
> > 
> > # set eof and make sure entire page is uptodate (even posteof)
> > $XFS_IO_PROG -fc "truncate 1k" -c "mmap 0 4k" -c "mread 0 4k"
> > $file # do a delalloc and open/close cycle to set dirty release
> > $XFS_IO_PROG -c "pwrite 0 1" -c "close" -c "open $file" $file #
> > fail an appending write to a posteof, discontig, uptodate range on
> > already dirty page $XFS_IO_PROG -c "pwrite -f 2k 1" -c fsync -c
> > "fiemap -v" $file
> > 
> Firstly, can you tell me which patchset you reproduced this on? Just
> a vanilla kernel, thev version of the patchset in this thread or the
> latest one I sent out?
> 

This series.

> Secondly, can you please send a patch with that failed write
> functionality upstream for xfs_io - it is clearly useful.
> 

Sure. It trivially passes a NULL buffer, but I can post an RFC for now
at least.

> > wrote 1/1 bytes at offset 0
> > 1.000000 bytes, 1 ops; 0.0003 sec (3.255 KiB/sec and 3333.3333 ops/sec)
> > pwrite: Bad address
> > /mnt/file:
> >  EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
> >    0: [0..1]:          22..23               2   0x0
> >    1: [2..3]:          hole                 2
> >    2: [4..5]:          0..1                 2   0x7
> > 
> > So clearly there's a posteof delalloc (FIEMAP_EXTENT_DELALLOC == 0x4) block
> > there that hasn't been written to.
> 
> Ok, so this is failing before even iomap_write_begin() is called,
> so it's a failed write that has not touched page cache state, but
> has allocated a delalloc block beyond EOF.
> 

Yes.

> This is a case that writeback handles because writeback
> is supposed skip writeback for pages and blocks beyond EOF. i.e.
> iomap_writepage_map() is passed the current EOF to terminate the
> writeback mapping loop when the folio being written back spans EOF.
> Hence iomap_writepage_map never walks past EOF and so does not ever
> iterate filesystem blocks that contain up to date data beyond in the
> page cache beyond EOF. That's why writeback leaves that stray
> delalloc block beyond, even though it's covered by up to date data.
> 
> IOWs, it appears that the problem here is that the page cache
> considers data in the folio beyond EOF to be up to date and contain
> data, whilst most filesystems do not consider data beyond EOF to be
> valid. This means there is a boundary condition that
> mapping_seek_hole_data() doesn't handle correctly - it completely
> ignores EOF and so SEEK_DATA for an offset past EOF will report data
> beyond EOF if the file has been mmap()d and the last folio faulted
> in.
> 
> This specific boundary condition behaviour is hidden by
> iomap_seek_data() and shmem_file_llseek() by not allowing seeks to
> start and/or end beyond EOF. Hence they never calls
> mapping_seek_hole_data() with a start byte beyond EOF and so will
> not ever try to find data in the page caceh beyond EOF.
> 
> That looks easy enough to fix - just consider any data range
> returned that is beyond i_size_read() to require punching, and then
> the semantics match writeback ignoring anything beyond EOF....
> 
> > I call this a landmine because it's an
> > unexpected/untracked instance of post-eof delalloc. I.e., post-eof block
> > reclamation won't pick it up because the inode was never tagged for speculative
> > preallocation:
> 
> Of course - this wasn't allocated by speculative preallocation -
> that doesn't kick in until the file is >64kB in length, so
> xfs_bmapi_reserve_delalloc() doesn't set the flag saying there's
> post-eof preallocation to trim away on the inode.
> 
> > > > It may convert if contiguous with delalloc blocks inside EOF (and
> > > > sufficiently sized physical extents exist), or even if not, should
> > > > still otherwise be cleaned up by the various other means we
> > > > already have to manage post-eof blocks.
> > > >
> > > > So IOW there's a tradeoff being made here for possible spurious
> > > > allocation and I/O and a subtle dependency on writeback that
> > > > should probably be documented somewhere.
> > > 
> > > As per above, I don't think there is any spurious/stale allocation
> > > left behind by the punch code, nor is there any dependency on
> > > writeback to ignore it such issues.
> > > 
> > 
> > The same sort of example as above (but within eof) demonstrates the
> > writeback dependency. I.e., with this series alone the punch code leaves
> > behind an in-eof uptodate delalloc block, but writeback comes along and
> > maps it regardless because it also only has uptodate granularity within
> > the dirty folio.
> 
> This "unflushable delalloc extent" case can't happen within EOF. The
> page fault initialises the folio full of zeroes, so when we get the
> failed write, the only change is that we now have a single delalloc
> block within EOF that writeback will iterate over, allocate and
> write all the up to date zeros to it.
> 
> Sure, this error path might cause a small amount of extra IO over
> the dirty folio, but it does not cause any other sort of issue.
> THere are no stray delalloc blocks, there are no data corruption
> issues, there are no stale data exposure issues, etc. Leaving a
> delalloc block under up-to-date page cache data should not cause
> a user vsible issue.
> 

This is why I suggested a comment might be sufficient.

> > When writeback changes to only map dirty sub-ranges, clearly that no
> > longer happens and the landmine turns into a stale delalloc leak. This
> > is also easy to reproduce with the last dirty range RFC patches pulled
> > on top of this series.
> 
> No, not even then. If we have sub-folio dirty ranges, we know this
> failed write range is *still clean* and so we'll punch it out,
> regardless of whether it is inside or outside EOF.
> 

At this point I suspect we're talking past eachother and based on
previous discussion, I think we're on the same page wrt to what actually
needs to happen and why.

> > It may be possible to address that by doing more aggressive punching
> > past the i_size boundary here, but that comes with other tradeoffs.
> 
> Tradeoffs such as .... ?
> 

When I wrote that I was thinking about the potential for odd
interactions with speculative preallocation. For example, consider the
case where the write that allocates speculative prealloc happens to
fail, how xfs_can_free_eofblocks() is implemented, etc.

I'm not explicitly saying it's some catastrophic problem, corruption
vector, etc., or anything like that. I'm just saying it's replacing one
potential wonky interaction with another, and thus introduces different
considerations for things that probably don't have great test coverage
to begin with.

I suppose it might make some sense for the iomap mechanism to invoke the
callback for post-eof ranges, but then have the fs handle that
particular case specially if appropriate. So for example if an XFS inode
sees a post-eof punch and is tagged with post-eof prealloc, it might
make more sense to either punch the whole of it out or just leave it
around to be cleaned up later vs. just punch out a subset of it. But I
don't have a strong opinion either way and still no objection to simply
documenting the quirk for the time being.

> > For example, if the target folio of a failed write
> > was already dirty and the target (sub-folio) range was previously an
> > Uptodate hole before the failing write may have performed delayed
> > allocation, we have no choice but to skip the punch for that sub-range
> > of the folio because we can't tell whether sub-folio Uptodate ranges
> > were actually written to or not. This means that delalloc block
> > allocations may persist for writes that never succeeded.
> 
> I can add something like that, though I'd need to make sure it is
> clear that this is not a data corruption vector, just an side effect
> of a highly unlikely set of corner case conditions we only care
> about handling without corruption, not efficiency or performance.
> 

I couldn't think of any such issues for upstream XFS, at least. One
reason is that delalloc blocks convert to unwritten extents by default,
so anything converted that wasn't directly targeted with writes should
remain in that state. Another fallback is that iomap explicitly zeroes
cache pages for post-eof blocks on reads, regardless of extent type. Of
course those were just initial observations and don't necessarily mean
problems don't exist. :)

FWIW, the more subtle reason I commented on these quirks, but isn't so
relevant upstream, is that if this work is going to get backported to
older/stable/distro kernels it might be possible for this to land in
kernels without one or both of those previously mentioned behaviors (at
which point there very well might be a vector for stale data exposure or
a subtle feature dependency, depending on context, what the final patch
series looks like, etc.).

Brian

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 


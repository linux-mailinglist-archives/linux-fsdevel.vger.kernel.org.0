Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6A762FB84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Nov 2022 18:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242324AbiKRRVr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Nov 2022 12:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235215AbiKRRVp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Nov 2022 12:21:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2588E089
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Nov 2022 09:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668792043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6+yVPT4MmupD7qMkZYRvJOseSG5Fp9ohhssX7w71Skc=;
        b=KWaYTvCt0DcO6JDvQHJjCPyZj7ZUKywnRqMbceshMLcEGuoKuQtbZN5eoC16mJ0RRqAAro
        RmvdbRBsZSxpuibAjE+73LxiSrOZ1sPQ1PiEwAw84r2vQWcTPf7ZAdFCy6XvaErsaj6qK8
        xtELf/EhoJVchCPi2+z5xlSOPgns5PA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-16-auW1_qfuNES48F3zCC8p7A-1; Fri, 18 Nov 2022 12:20:42 -0500
X-MC-Unique: auW1_qfuNES48F3zCC8p7A-1
Received: by mail-qt1-f198.google.com with SMTP id i13-20020ac8764d000000b003a4ec8693dcso5498904qtr.14
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Nov 2022 09:20:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+yVPT4MmupD7qMkZYRvJOseSG5Fp9ohhssX7w71Skc=;
        b=D6+xhNkGwCK7LEYqWWn0pe+mxjKq1sCOjxdh+EvZ9597Ss/RYg/XIwhRaOJzWhiPlP
         Q+8UJsFWeOlov2bQaJDF6PvMNhU1kUzAQs0/q02De0almILXG68+E7lpX63ZDA73/hRl
         cp2jBJws4mqFVP+U3R3Uih/IqyUCj5NmWES/G2DgtCe89aLLNqDUeMaVNi8mc+9sYdKo
         AbbG9XISq6DYwmR0Oj/pPMSIo0I0pJyGBnIWSjx65qnSOgf41Dai35pYKIeEj8w38l/a
         xLu5ma5JBgE14MaoHarssUcDwIA/rMLHiwK8Lw1/cY0roikbDJCsVOK98/hdor8GI3py
         QiwA==
X-Gm-Message-State: ANoB5plgh6uP32mLbQsiAzSfsWfUqXlma2eLl4QNWVFwBZwckCGxrb0Y
        xAnEeCtZ8NIAMHRtMsnw2pDWUcO2R3mgxDII5TD2R8P36MFh8twphIm62r8Yq0++iRQRDg7/Wh/
        h6pDPuu66Y/GjkCA7uT/s7XU3Zw==
X-Received: by 2002:a05:620a:6011:b0:6e8:1fa:13e9 with SMTP id dw17-20020a05620a601100b006e801fa13e9mr6680040qkb.393.1668792041513;
        Fri, 18 Nov 2022 09:20:41 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5y2q166QiLwTrf7DkgypwFY3Npsq6MKhExituxvBowbtaAaEog1hpaFxhkqrcvApmcumtndw==
X-Received: by 2002:a05:620a:6011:b0:6e8:1fa:13e9 with SMTP id dw17-20020a05620a601100b006e801fa13e9mr6680004qkb.393.1668792041035;
        Fri, 18 Nov 2022 09:20:41 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id az20-20020a05620a171400b006ec771d8f89sm2758837qkb.112.2022.11.18.09.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 09:20:40 -0800 (PST)
Date:   Fri, 18 Nov 2022 12:20:45 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 5/9] xfs: buffered write failure should not truncate the
 page cache
Message-ID: <Y3e+7XH5gq5gc97u@bfoster>
References: <20221115013043.360610-1-david@fromorbit.com>
 <20221115013043.360610-6-david@fromorbit.com>
 <Y3TsPzd0XzXXIzQv@bfoster>
 <20221117004133.GD3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117004133.GD3600936@dread.disaster.area>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 17, 2022 at 11:41:33AM +1100, Dave Chinner wrote:
> On Wed, Nov 16, 2022 at 08:57:19AM -0500, Brian Foster wrote:
> > On Tue, Nov 15, 2022 at 12:30:39PM +1100, Dave Chinner wrote:
> > > From: Dave Chinner <dchinner@redhat.com>
> > > 
> > ...
> > > 
> > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > ---
> > >  fs/xfs/xfs_iomap.c | 151 ++++++++++++++++++++++++++++++++++++++++++---
> > >  1 file changed, 141 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> > > index 7bb55dbc19d3..2d48fcc7bd6f 100644
> > > --- a/fs/xfs/xfs_iomap.c
> > > +++ b/fs/xfs/xfs_iomap.c
> > > @@ -1134,6 +1134,146 @@ xfs_buffered_write_delalloc_punch(
> > >  				end_fsb - start_fsb);
> > >  }
> > >  
> > ...
> > > +/*
> > > + * Punch out all the delalloc blocks in the range given except for those that
> > > + * have dirty data still pending in the page cache - those are going to be
> > > + * written and so must still retain the delalloc backing for writeback.
> > > + *
> > > + * As we are scanning the page cache for data, we don't need to reimplement the
> > > + * wheel - mapping_seek_hole_data() does exactly what we need to identify the
> > > + * start and end of data ranges correctly even for sub-folio block sizes. This
> > > + * byte range based iteration is especially convenient because it means we don't
> > > + * have to care about variable size folios, nor where the start or end of the
> > > + * data range lies within a folio, if they lie within the same folio or even if
> > > + * there are multiple discontiguous data ranges within the folio.
> > > + */
> > > +static int
> > > +xfs_buffered_write_delalloc_release(
> > > +	struct inode		*inode,
> > > +	loff_t			start_byte,
> > > +	loff_t			end_byte)
> > > +{
> > > +	loff_t			punch_start_byte = start_byte;
> > > +	int			error = 0;
> > > +
> > > +	/*
> > > +	 * Lock the mapping to avoid races with page faults re-instantiating
> > > +	 * folios and dirtying them via ->page_mkwrite whilst we walk the
> > > +	 * cache and perform delalloc extent removal. Failing to do this can
> > > +	 * leave dirty pages with no space reservation in the cache.
> > > +	 */
> > > +	filemap_invalidate_lock(inode->i_mapping);
> > > +	while (start_byte < end_byte) {
> > > +		loff_t		data_end;
> > > +
> > > +		start_byte = mapping_seek_hole_data(inode->i_mapping,
> > > +				start_byte, end_byte, SEEK_DATA);
> > 
> > FWIW, the fact that mapping seek data is based on uptodate status means
> > that seek behavior can change based on prior reads.
> 
> Yup. It should be obvious that any page cache scan based algorithm
> will change based on changing page cache residency.
> 
> > For example, see how
> > seek hole/data presents reads of unwritten ranges as data [1]. The same
> > thing isn't observable for holes because iomap doesn't check the mapping
> > in that case, but underlying iop state is the same and that is what this
> > code is looking at.
> 
> Well, yes.  That's the fundamental, underlying issue that this
> patchset is addressing for the write() operation: that the page
> cache contents and the underlying filesystem extent map are not
> guaranteed to be coherent and can be changed independently of each
> other.
> 
> The whole problem with looking exclusively at filesystem level
> extent state (and hence FIEMAP) is that the extent state doesn't
> tell us whether the is uncommitted data over the range of the extent
> in the page cache.  The filesystem extent state and page cache data
> *can't be coherent* in a writeback caching environment. This is the
> fundamental difference between what the filesystem extent map tells
> us (FIEMAP) and what querying the page cache tells us
> (SEEK_DATA/SEEK_HOLE).
> 
> This is also the underlying problem with iomap_truncate_page() - it
> fails to query the page cache for data over unwritten extents, so
> fails to zero the post-EOF part of dirty folios over unwritten
> extents and so it all goes wrong...
> 
> > The filtering being done here means we essentially only care about dirty
> > pages backed by delalloc blocks. That means if you get here with a dirty
> > page and the portion of the page affected by this failed write is
> > uptodate, this won't punch an underlying delalloc block even though
> > nothing else may have written to it in the meantime.
> 
> Hmmm. IOMAP_F_NEW implies that the newly allocated delalloc iomap
> will not span ranges that have pre-existing *dirty* data in the
> page cache. Those *must* already have (del)allocated extents, hence
> the iomap for the newly allocated delalloc extent will always end
> before pre-existing dirty data in the page cache starts.
> 
> Hence the seek scan range over an IOMAP_F_NEW IOMAP_DELALLOC map
> precludes stepping into ranges that have pre-existing cached dirty
> data.
> 
> We also can't get a racing write() to the same range right now
> because this is all under IOLOCK_EXCL, hence we only ever see dirty
> folios as a result of race with page faults. page faults zero the
> entire folio they insert into the page cache and
> iomap_folio_mkwrite_iter() asserts that the entire folio is marked
> up to date. Hence if we find a dirty folio outside the range the
> write() dirtied, we are guaranteed that the entire dirty folio is up
> to date....
> 
> Yes, there can be pre-existing *clean* folios (and clean partially
> up to date folios) in the page cache, but we won't have dirty
> partially up to date pages in the middle of the range we are
> scanning. Hence we only need to care about the edge cases (folios
> that overlap start and ends). We skip the partially written start
> block, and we always punch up to the end block if it is different
> from the last block we punched up to. If the end of the data spans
> into a dirty folio, we know that dirty range is up to date because
> the seek scan only returns ranges that are up to date. Hence we
> don't punch those partial blocks out....
> 
> Regardless, let's assume we have a racing write that has partially
> updated and dirtied a folio (because we've moved to
> XFS_IOLOCK_SHARED locking for writes). This case is already handled
> by the mapping_seek_hole_data() based iteration.
> 
> That is, the mapping_seek_hole_data() loop provides us with
> *discrete ranges of up to date data* that are independent of folio
> size, up-to-date range granularity, dirty range tracking, filesystem
> block size, etc.
> 
> Hence if the next discrete range we discover is in the same dirty
> folio as the previous discrete range of up to date data, we know we
> have a sub-folio sized hole in the data that is not up to date.
> Because there is no data over this range, we have to punch out the
> underlying delalloc extent over that range. 
> 
> IOWs, the dirty state of the folio and/or the granularity of the
> dirty range tracking is irrelevant here - we know there was no data
> in the cache (dlean or dirty) over this range because it is
> discontiguous with the previous range of data returned.
> 
> IOWs, if we have this "up to date" map on a dirty folio like this:
> 
> Data		+-------+UUUUUUU+-------+UUUUUUU+-------+
> Extent map	+DDDDDDD+DDDDDDD+DDDDDDD+DDDDDDD+DDDDDDD+
> 
> Then the unrolled iteration and punching we do would look like this:
> 
> First iteration of the range:
> 
> punch_start:
> 		V
> 		+-------+UUUUUUU+-------+UUUUUUU+-------+
> 
> SEEK_DATA:		V
> 		+-------+UUUUUUU+-------+UUUUUUU+-------+
> SEEK_HOLE:			^
> Data range:		+UUUUUUU+
> Punch range:	+-------+
> Extent map:	+-------+DDDDDDD+DDDDDDD+DDDDDDD+DDDDDDD+
> 
> Second iteration:
> 
> punch_start			V
> 		+-------+UUUUUUU+-------+UUUUUUU+-------+
> SEEK_DATA:				V
> 		+-------+UUUUUUU+-------+UUUUUUU+-------+
> SEEK_HOLE:					^
> Data range:				+UUUUUUU+
> Punch range:			+-------+
> Extent map:	+-------+DDDDDDD+-------+DDDDDDD+DDDDDDD+
> 
> Third iteration:
> 
> punch_start					V
> 		+-------+UUUUUUU+-------+UUUUUUU+-------+
> SEEK_DATA: - moves into next folio in cache
> ....
> Punch range:					+-------+ ......
> Extent map:	+-------+DDDDDDD+-------+DDDDDDD+-------+ ......
> 			(to end of scan range or start of next data)
> 
> As you can see, this scan does not care about folio size, sub-folio
> range granularity or filesystem block sizes.  It also matches
> exactly how writeback handles dirty, partially up to date folios, so
> there's no stray delalloc blocks left around to be tripped over
> after failed or short writes occur.
> 
> Indeed, if we move to sub-folio dirty range tracking, we can simply
> add a mapping_seek_hole_data() variant that walks dirty ranges in
> the page cache rather than up to date ranges. Then we can remove the
> inner loop from this code that looks up folios to determine dirty
> state. The above algorithm does not change - we just walk from
> discrete range to discrete range punching the gaps between them....
> 
> IOWs, the algorithm is largely future proof - the only thing that
> needs to change if we change iomap to track sub-folio dirty ranges
> is how we check the data range for being dirty. That should be no
> surprise, really, the surprise should be that we can make some
> simple mods to page cache seek to remove the need for checking dirty
> state in this code altogether....
> 
> > That sort of state
> > can be created by a prior read of the range on a sub-page block size fs,
> > or perhaps a racing async readahead (via read fault of a lower
> > offset..?), etc.
> 
> Yup, generic/346 exercises this racing unaligned, sub-folio mmap
> write vs write() case. This test, specifically, was the reason I
> moved to using mapping_seek_hole_data() - g/346 found an endless
> stream of bugs in the sub-multi-page-folio range iteration code I
> kept trying to write....
> 
> > I suspect this is not a serious error because the page is dirty
> > and writeback will thus convert the block. The only exception to
> > that I can see is if the block is beyond EOF (consider a mapped
> > read to a page that straddles EOF, followed by a post-eof write
> > that fails), writeback won't actually map the block directly.
> 
> I don't think that can happen. iomap_write_failed() calls
> truncate_pagecache_range() to remove any newly instantiated cached
> data beyond the original EOF. Hence the delalloc punch will remove
> everything beyond the original EOF that was allocated for the failed
> write. Hence when we get to writeback we're not going to find any
> up-to-date data beyond the EOF block in the page cache, nor any
> stray delalloc blocks way beyond EOF....
> 

It can happen if the page straddles eof. I don't think much of the above
relates to the behavior I'm describing. This doesn't require racing
writes, theoretical shared write locking, the IOMAP_F_NEW flag or core
iteration algorithm are not major factors, etc.

It's easier to just use examples. Consider the following sequence on a
bsize=1k fs on a kernel with this patch series. Note that my xfs_io is
hacked up to turn 'pwrite -f' into a "fail" flag that triggers the
-EFAULT error check in iomap_write_iter() by passing a bad user buffer:

# set eof and make sure entire page is uptodate (even posteof)
$XFS_IO_PROG -fc "truncate 1k" -c "mmap 0 4k" -c "mread 0 4k" $file
# do a delalloc and open/close cycle to set dirty release
$XFS_IO_PROG -c "pwrite 0 1" -c "close" -c "open $file" $file
# fail an appending write to a posteof, discontig, uptodate range on already dirty page
$XFS_IO_PROG -c "pwrite -f 2k 1" -c fsync -c "fiemap -v" $file

wrote 1/1 bytes at offset 0
1.000000 bytes, 1 ops; 0.0003 sec (3.255 KiB/sec and 3333.3333 ops/sec)
pwrite: Bad address
/mnt/file:
 EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
   0: [0..1]:          22..23               2   0x0
   1: [2..3]:          hole                 2
   2: [4..5]:          0..1                 2   0x7

So clearly there's a posteof delalloc (FIEMAP_EXTENT_DELALLOC == 0x4) block
there that hasn't been written to. I call this a landmine because it's an
unexpected/untracked instance of post-eof delalloc. I.e., post-eof block
reclamation won't pick it up because the inode was never tagged for speculative
preallocation:

$ xfs_spaceman -c "prealloc -s" /mnt
$ xfs_io -c "fiemap -v" /mnt/file 
/mnt/file:
 EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
   0: [0..1]:          22..23               2   0x0
   1: [2..3]:          hole                 2
   2: [4..5]:          0..1                 2   0x7

At the same time, it's not an observable problem in XFS because inode
reclaim will eventually truncate that block off due to the delalloc
block check, which will prevent any sort of space accounting corruption.
I also don't think anybody will miss a single block dangling off like
that in the meantime. The only other odd side effect I can think of is
if this happened and the user performed an explicit post-eof fallocate,
reclaim could now lop that off due to the last resort delalloc block
check. That can still technically happen anyways as a side effect of
speculative prealloc so I don't see that as a major problem either.

The more important point here is that just because XFS can handle this
situation reasonably gracefully doesn't mean every other filesystem
expects it.

> > It may convert if contiguous with delalloc blocks inside EOF (and
> > sufficiently sized physical extents exist), or even if not, should
> > still otherwise be cleaned up by the various other means we
> > already have to manage post-eof blocks.
> >
> > So IOW there's a tradeoff being made here for possible spurious
> > allocation and I/O and a subtle dependency on writeback that
> > should probably be documented somewhere.
> 
> As per above, I don't think there is any spurious/stale allocation
> left behind by the punch code, nor is there any dependency on
> writeback to ignore it such issues.
> 

The same sort of example as above (but within eof) demonstrates the
writeback dependency. I.e., with this series alone the punch code leaves
behind an in-eof uptodate delalloc block, but writeback comes along and
maps it regardless because it also only has uptodate granularity within
the dirty folio.

When writeback changes to only map dirty sub-ranges, clearly that no
longer happens and the landmine turns into a stale delalloc leak. This
is also easy to reproduce with the last dirty range RFC patches pulled
on top of this series.

The changes you describe above to seek out and punch all !dirty delalloc
ranges should address both of these problems, because the error handling
code doesn't consider i_size the way writeback does.

> > The larger concern is that if
> > writeback eventually changes based on dirty range tracking in a way that
> > breaks this dependency, that introduces yet another stale delalloc block
> > landmine associated with this error handling code (regardless of whether
> > you want to call that a bug in this code, seek data, whatever), and
> > those problems are difficult enough to root cause as it is.
> 
> If iomap changes how it tracks dirty ranges, this punch code only
> needs small changes to work with that correctly. There aren't any
> unknown landmines here - if we change dirty tracking, we know that
> we have to update the code that depends on the existing dirty
> tracking mechanisms to work correctly with the new infrastructure...
> 

I'm just pointing out there are side effects / corner cases that don't
depend on the complicated shared locking / racing write fault scenarios
described above. Therefore, this code probably needs to be fixed at the
same time dirty range tracking is enabled to not introduce stale
delalloc problems for XFS.

In the meantime, I don't think any fs developer just looking to use or
debug the iomap layer and considering this punch error handling
mechanism should be expected to immediately connect the dots between it
using pagecache seek, that depending on Uptodate, the pagecache seek
behavior implications of that, writeback potentially not mapping
post-eof ranges, and therefore possibly needing to know that the fs in
question may need its own custom post-eof error handling if dangling
post-eof blocks aren't expected anywhere else for that fs.

It may be possible to address that by doing more aggressive punching
past the i_size boundary here, but that comes with other tradeoffs.
Short of that, I was really just asking for a more descriptive comment
for the punch mechanism so these quirks are not lost before they can be
properly fixed up or are apparent to any new users besides XFS this
might attract in the meantime. For example, something like the following
added to the _punch_delalloc() comment (from v3):

"
...

Note that since this depends on pagecache seek data, and that depends on
folio Uptodate state to identify data regions, the scanning behavior
here can be non-deterministic based on the state of cache at the time of
the failed operation. For example, if the target folio of a failed write
was already dirty and the target (sub-folio) range was previously an
Uptodate hole before the failing write may have performed delayed
allocation, we have no choice but to skip the punch for that sub-range
of the folio because we can't tell whether sub-folio Uptodate ranges
were actually written to or not. This means that delalloc block
allocations may persist for writes that never succeeded.

This can similarly skip punches beyond EOF for failed post-eof writes,
except note that writeback will not explicitly map blocks beyond i_size.
Therefore, filesystems that cannot gracefully accommodate dangling
post-eof blocks via other means may need to check for and handle that
case directly after calling this function.

These quirks should all be addressed with proper sub-folio dirty range
tracking, at which point we can deterministically scan and punch
non-dirty delalloc ranges at the time of write failure.
"

... but I also don't want to go in circles just over a comment, so I'm
content that it's at least documented on the list here.

Brian

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 


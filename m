Return-Path: <linux-fsdevel+bounces-21488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE22E904813
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 02:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DB6AB21C28
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 00:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2BB1C2D;
	Wed, 12 Jun 2024 00:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+ITRMJK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B59F394;
	Wed, 12 Jun 2024 00:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718152680; cv=none; b=JylFMU1yMP9EC+lA25Sd7zKheJGYzcE31kFKGzfefuL2E6wpCqZCPGihkLkeFK6RKAR4aXg30oyJHDloVg07YGtsdckwmMFO1edbIxj/gmHVog7kPQ7J1+dUlo3bwd+Wf5gqf+m5GL70HIX5lnzS2VlE8JEyF8nFwKHBI1el2gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718152680; c=relaxed/simple;
	bh=WKYSwU41NVgu39hBxM+tlpMz/u8cDEUiLTmwDqv05kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8M5HkZRmQgp/gvwdo6vIljEy/Dmuq27Kri3gbsroENBeFLZwEAiFQIrjQ74cPpduMT1Qki9Qqa5xOj99iZUJc3CrR5ecALWGDdgaAAiNpR+eJ/Uw4FHOsxSmE6Sm2GeVcFgxy+vt/METabM5pZKsW9YYlblzrOML/66QIU1yus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+ITRMJK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9BEEC2BD10;
	Wed, 12 Jun 2024 00:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718152679;
	bh=WKYSwU41NVgu39hBxM+tlpMz/u8cDEUiLTmwDqv05kc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l+ITRMJK4orVZ0sAKwyvSm6AWLFLhl0RP1LULwdemB7zNQuPE67N7jIMwpKXctwX0
	 9UDy7018LgpcN3zZiaH429qmlh0jMYfJADW0ctqFQ04J1J1V9gx0mG0lkGSPdtVd2f
	 FZI0XyX7W11xTinIV870aLTOFzoKYCtzrp5xJAoVQ9Oo1otzHZY3BJdP0Et7lwqQa2
	 VAPJ0nqKFOB1+xTEfx0UimjT3KKXV4nfUO/chmamIOD1Aupz8CAYCH+ZQVmClguP81
	 wiSXKLe50i9irosMkgifHlxcxQm5UdbQfxK4W27AzTDVwSjeTqjusH9QcDnpQ1TecK
	 VWTxXMJ8hNYtQ==
Date: Tue, 11 Jun 2024 17:37:59 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH] Documentation: document the design of iomap and how to
 port
Message-ID: <20240612003759.GE52987@frogsfrogsfrogs>
References: <20240608001707.GD52973@frogsfrogsfrogs>
 <ZmVNblggFRgR8bnJ@infradead.org>
 <20240609155506.GT52987@frogsfrogsfrogs>
 <20240610141808.vdsflgcbjmgc37dt@quack3>
 <20240610215928.GV52987@frogsfrogsfrogs>
 <ZmepL9161HEfmBNU@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmepL9161HEfmBNU@dread.disaster.area>

On Tue, Jun 11, 2024 at 11:32:31AM +1000, Dave Chinner wrote:
> On Mon, Jun 10, 2024 at 02:59:28PM -0700, Darrick J. Wong wrote:
> > On Mon, Jun 10, 2024 at 04:18:08PM +0200, Jan Kara wrote:
> > > On Sun 09-06-24 08:55:06, Darrick J. Wong wrote:
> > > >        * validity_cookie is a magic freshness value set by the
> > > >          filesystem that should be used to detect stale mappings. For
> > > >          pagecache operations this is critical for correct operation
> > > >          because page faults can occur, which implies that filesystem
> > > >          locks should not be held between ->iomap_begin and
> > > >          ->iomap_end. Filesystems with completely static mappings
> > > >          need not set this value. Only pagecache operations
> > > >          revalidate mappings.
> > > > 
> > > >          XXX: Should fsdax revalidate as well?
> > > 
> > > AFAICT no. DAX is more like using direct IO for everything. So no writeback
> > > changing mapping state behind your back (and that's the only thing that is
> > > not serialized with i_rwsem or invalidate_lock). Maybe this fact can be
> > > mentioned somewhere around the discussion of iomap_valid() as a way how
> > > locking usually works out?
> > 
> > <nod> I'll put that in the section about iomap_valid, which documents
> > the whole mechanism more thoroughly:
> > 
> > "iomap_valid: The filesystem may not hold locks between ->iomap_begin
> > and ->iomap_end because pagecache operations can take folio locks, fault
> > on userspace pages, initiate writeback for memory reclamation, or engage
> > in other time-consuming actions.  If a file's space mapping data are
> > mutable, it is possible that the mapping for a particular pagecache
> > folio can change in the time it takes to allocate, install, and lock
> > that folio.
> > 
> > "For the pagecache, races can happen if writeback doesn't take i_rwsem
> > or invalidate_lock and updates mapping information.  Races can also
> > happen if the filesytem allows concurrent writes.  For such files, the
> > mapping *must* be revalidated after the folio lock has been taken so
> > that iomap can manage the folio correctly.
> > 
> > "fsdax does not need this revalidation because there's no writeback and
> > no support for unwritten extents.
> > 
> > "The filesystem's ->iomap_begin function must sample a sequence counter
> > into struct iomap::validity_cookie at the same time that it populates
> > the mapping fields.  It must then provide a ->iomap_valid function to
> > compare the validity cookie against the source counter and return
> > whether or not the mapping is still valid.  If the mapping is not valid,
> > the mapping will be sampled again."
> 
> Everything is fine except for the last paragraph. Filesystems do not
> need to use a sequence counter for the validity cookie - they can
> use any mechanism they want to determine that the extent state has
> changed. If they can track extent status on a fine grained basis
> (e.g. ext4 has individual extent state cache entries) then that
> validity cookie could be a pointer to the filesystem's internal
> extent state cache entry.
> 
> There's also nothing that says the cookie needs to remain a u64;
> I've been toying with replacing it with a pointer to an xfs iext
> btree cursor and checking that the cursor still points to the same
> extent that iomap was made from. Hence we get fine grained extent
> checks and don't have to worry about changes outside the range of
> the iomap causing spurious revalidation failures.
> 
> IOWs, the intention of the cookie is simply an opaque blob that the
> filesystem can keep whatever validity information in it that it
> wants - a sequence counter is just one of many possible
> implementations. hence I think this should be rephrased to reflect
> this.
> 
> "The filesystem's ->iomap_begin function must write the data it
> needs to validate the iomap into struct iomap::validity_cookie at
> the same time that it populates the mapping fields.  It must then
> provide a ->iomap_valid function to compare the validity cookie
> against the source data and return whether or not the mapping is
> still valid.  If the mapping is not valid, the mapping will be
> sampled again.
> 
> A simple validation cookie implementation is a sequence counter. If
> the filesystem bumps the sequence counter every time it modifies the
> inode's extent map, it can be placed in the struct
> iomap::validity_cookie during ->iomap_begin. If the value in the
> cookie is found to be different to the value the filesystem holds
> when it is passed back to ->iomap_valid, then the iomap should
> considered stale and the validation failed."

Ok, I'll rework my last paragraph and add yours after it:

"Filesystems subject to this kind of race must provide a ->iomap_valid
function to decide if the mapping is still valid.  If the mapping is not
valid, the mapping will be sampled again.  To support making the
validity decision, the filesystem's ->iomap_begin function may set
struct iomap::validity_cookie at the same time that it populates the
other iomap fields.

"A simple validation cookie implementation is a sequence counter.  If
the filesystem bumps the sequence counter every time it modifies the
inode's extent map, it can be placed in the struct
iomap::validity_cookie during ->iomap_begin.  If the value in the cookie
is found to be different to the value the filesystem holds when the
mapping is passed back to ->iomap_valid, then the iomap should
considered stale and the validation failed."

> > > >    These struct kiocb flags are significant for buffered I/O with
> > > >    iomap:
> > > > 
> > > >        * IOCB_NOWAIT: Only proceed with the I/O if mapping data are
> > > >          already in memory, we do not have to initiate other I/O, and
> > > >          we acquire all filesystem locks without blocking. Neither
> > > >          this flag nor its definition RWF_NOWAIT actually define what
> > > >          this flag means, so this is the best the author could come
> > > >          up with.
> > > 
> > > RWF_NOWAIT is a performance feature, not a correctness one, hence the
> > > meaning is somewhat vague. It is meant to mean "do the IO only if it
> > > doesn't involve waiting for other IO or other time expensive operations".
> > > Generally we translate it to "don't wait for i_rwsem, page locks, don't do
> > > block allocation, etc." OTOH we don't bother to specialcase internal
> > > filesystem locks (such as EXT4_I(inode)->i_data_sem)
> 
> But we have support for this - the IOMAP_NOWAIT flag tells the
> filesystem iomap methods that it should:
> 
> 	a) not block on internal mapping operations; and
> 	b) fail with -EAGAIN if it can't map the entire range in a
> 	   single iomap.
> 
> XFS implements these semantics for internal locks and operations
> needed for mapping operations, and any filesystem that uses iomap
> -should- be doing the same thing.
> 
> > > and we get away with
> > > it because blocking on it under constraints we generally perform RWF_NOWAIT
> > > IO is exceedingly rare.
> > 
> > I hate this flag's undocumented nature.  It now makes *documenting*
> > things around it hard.  How about:
> 
> But it is documented.
> 
> RWF_NOWAIT (since Linux 4.14)
> 
>       Do not wait for data which is not immediately available.  If
>       this flag is specified, the preadv2() system call will return
>       instantly if  it  would have  to  read data from the backing
>       storage or wait for a lock. [...]
> 
> Yes, not well documented. But the *intent* is clear. It's basically
> the same thing as O_NONBLOCK:
> 
> O_NONBLOCK or O_NDELAY
>       When  possible,  the file is opened in nonblocking mode.
>       Neither the open() nor any subsequent I/O operations on the
>       file descriptor which is returned will cause the calling
>       process to wait.
> 
> That's what we are supposed to be implementing with IOCB_NOWAIT -
> don't block the submitting task if at all possible.

Sorry.  I didn't realize that it /had/ been documented, just not in the
kernel.

"IOCB_NOWAIT: Do not wait for data which is not immediately available.
XFS and ext4 appear to reject the IO unless the mapping data are already
in memory, the filesystem does not have to initiate other I/O, and the
kernel can acquire all filesystem locks without blocking."

> > "IOCB_NOWAIT: Neither this flag nor its associated definition
> > RWF_NOWAIT actually specify what this flag means.  Community
> > members seem to think that it means only proceed with the I/O if
> > it doesn't involve waiting for expensive operations.  XFS and ext4
> > appear to reject the IO unless the mapping data are already in
> > memory, the filesystem does not have to initiate other I/O, and
> > the kernel can acquire all filesystem locks without blocking."
> 
> I think the passive-aggressive nature of this statement doesn't read
> very well. Blaming "community members" for organic code development
> that solved poorly defined, undocumented bleeding edge issues isn't
> a winning strategy. And other developers don't care about this; they
> just want to know what they should be implementing.

Some day soon I'll be gone and you won't have me poisoning the
community anymore.

> So let's just make a clear statement about the intent of
> IOCB_NOWAIT, because that is *always* been very clear right from the
> start, even though there was no way we could implement the intent
> right from the start.
> 
> "IOCB_NOWAIT: Perform a best effort attempt to avoid any operation
> that would result in blocking the submitting task. This is similar
> in intent to O_NONBLOCK for network APIs - it is intended for
> asynchronous applications to keep doing other work instead of
> waiting for the specific unavailable filesystem resource to become
> available.
> 
> This means the filesystem implementing IOCB_NOWAIT semantics need to
> use trylock algorithms.  They need to be able to satisfy the entire
> IO request range in a single iomap mapping. They need to avoid
> reading or writing metadata synchronously. They need to avoid
> blocking memory allocations. They need to avoid waiting on
> transaction reservations to allow modifications to take place. And
> so on.
> 
> If there is any doubt in the filesystem developer's mind as to
> whether any specific IOCB_NOWAIT operation may end up blocking, then
> they should return -EAGAIN as early as possible rather than start
> the operation and force the submitting task to block."
> 
> This clearly documents the intent and what the submitters are
> expecting from filesystems when this flag is set. IT also tells
> filesystem implementers the way to handle IOCB_NOWAIT if they
> haven't actually coded any of this - abort at the top of the IO
> stack with -EAGAIN - and applications using this will work
> correctly.

Yes, that's better.  Thank you for that.

> > > >     Direct Writes
> > > > 
> > > >    A direct I/O write initiates a write I/O to the storage device to
> > > >    the caller's buffer. Dirty parts of the pagecache are flushed to
> > > >    storage before initiating the write io. The pagecache is
> > > >    invalidated both before and after the write io. The flags value
> > > >    for ->iomap_begin will be IOMAP_DIRECT | IOMAP_WRITE with any
> > > >    combination of the following enhancements:
> > > > 
> > > >        * IOMAP_NOWAIT: Write if mapping data are already in memory.
> > > >          Does not initiate other I/O or block on filesystem locks.
> 
> IOMAP_NOWAIT is not specific to direct IO. It is supported for both
> buffered reads and writes in iomap and XFS.
> 
> It also tends to imply "don't allocate new blocks" for journalling
> filesysetms because that requires journal space reservation (which
> blocks), memory allocation, metadata creation and metadata IO.
> 
> > > >        * IOMAP_OVERWRITE_ONLY: Allocating blocks and zeroing partial
> > > >          blocks is not allowed. The entire file range must to map to
> > > 							     ^^ extra "to"
> > > 
> > > >          a single written or unwritten extent. The file I/O range
> > > >          must be aligned to the filesystem block size.
> 
> 
> > > This seems to be XFS specific thing? At least I don't see anything in
> > > generic iomap code depending on this?
> > 
> > Hmm.  XFS bails out if the mapping is unwritten and the directio write
> > range isn't aligned to the fsblock size.
> 
> I think that is wrong. IOMAP_OVERWRITE_ONLY is specifically for
> allowing unaligned IO to be performed without triggering allocation
> or sub-block zeroing. It requests a mapping to allow a pure
> overwrite to be performed, otherwise it fails.
> 
> XFS first it checks if allocation is required. If so, it bails.
> 
> Second it checks if the extent spans the range requested. If not, it
> bails.
> 
> Finally, it checks if the extent is IOMAP_WRITTEN. If not, it bails.
> 
> > I think the reason for that is
> > because we'd have to zero the unaligned regions outside of the write
> > range, and xfs can't do that without synchronizing.  (Or we didn't think
> 
> Right, it enables an optimistic fast path for unaligned direct
> IOs. We take the i_rwsem shared, attempt the fast path, if it is
> rejected with -EAGAIN we drop the shared lock, take it exclusive
> and run the IO again without IOMAP_DIO_OVERWRITE_ONLY being set
> to allow allocation and/or sub-block zeroing to be performed.
> 
> I think this needs to be written in terms of what a "pure overwrite"
> is. We use that term repeatedly in the iomap code (e.g. for FUA
> optimisations), and IOMAP_OVERWRITE_ONLY is a mechanism for the
> caller to ask "give me a pure overwrite mapping for this range or
> fail with -EAGAIN". This is the mechanism that provides the required
> IOMAP_DIO_OVERWRITE_ONLY semantics.
> 
> 
> "Pure Overwrite: A write operation that does not require any
> metadata or zeroing operations to perform during either submission
> or completion. This implies that the fileystem must have already
> allocated space on disk as IOMAP_WRITTEN and the filesystem must not
> place any constaints on IO alignment or size - the only constraints
> on IO alignment are device level (minimum IO size and alignment,
> typically sector size).
> 
> IOMAP_DIO_OVERWRITE_ONLY: Perform a pure overwrite for this range or
> fail with -EAGAIN.
> 
> This can be used by filesystems with complex unaligned IO
> write paths to provide an optimised fast path for unaligned writes.
> If a pure overwrite can be performed, then serialisation against
> other IOs to the same filesystem block(s) is unnecessary as there is
> no risk of stale data exposure or data loss.
> 
> If a pure overwrite cannot be performed, then the filesystem can
> perform the serialisation steps needed to provide exclusive access
> to the unaligned IO range so that it can perform allocation and
> sub-block zeroing safely.
> 
> IOMAP_OVERWRITE_ONLY: The caller requires a pure overwrite to be
> performed from this mapping. This requires the filesystem extent
> mapping to already exist as an IOMAP_MAPPED type and span the entire
> range of the write IO request. If the filesystem cannot map this
> request in a way that allows the iomap infrastructure to perform
> a pure overwrite, it must fail the mapping operation with -EAGAIN."

Yes, that's a much better explanation.  I'll incorporate those.  Thank
you.

--D

> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 


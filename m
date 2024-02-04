Return-Path: <linux-fsdevel+bounces-10215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 430B0848CD8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 11:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF1112827E3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 10:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167AD1B7F6;
	Sun,  4 Feb 2024 10:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kafq9Iek"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716C71B7E8;
	Sun,  4 Feb 2024 10:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707042444; cv=none; b=dtW2aDu/vvfSfIj8IY882H2fJuPuecck8HEPZisfBuiOIjLdeX+k3wP6O3t1wDmWouJHDvaLibwD/5L2ZcZdmUrZmLIldvlFjchKZo++cFVH8awnB91ikcDBCXfZeKfTu6d+SGIW8y7VparFfjpYxJjyNjRN6VDTJZvBlIShqOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707042444; c=relaxed/simple;
	bh=eRn6mGis/5MC/A4ZLbE2ZigSPKpwJQDM2mzbPkMGT0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lx01gq6elmut68rKHvt/BdPuYL1bXpPoWJBVTVdcmBxWcllUyIm5HDVMBbwSyvr/ueoImthjzxfnZ+YQhyv4Z/fwHW4e4WP4L3mDuZSq95WxtoOtQOGEQh2jR/VqwR/+dIgxSq5TAjKz51bWCDUH45mOIpED54LQCB/E2V/W+rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kafq9Iek; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E1CC433F1;
	Sun,  4 Feb 2024 10:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707042443;
	bh=eRn6mGis/5MC/A4ZLbE2ZigSPKpwJQDM2mzbPkMGT0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kafq9IekWwYhs0YfkLChWrJRxH+nD6MJ3ClCNld27T580Vo4EiSzg4iOib6L44jn9
	 jHsUpWoUIarEDLktRKn8q0OOdI3XYR1s9V1/MubO9GYbFoESgLCQanXMfCxYB95qKH
	 nc92SiNV99F/pzBKHfutrnC9v7NhFT1aI28aQ8YGG6j8AYZjg8a/n8zAFvnC29EPhw
	 LEFzM6b1LIiwfgKJY/KpTHldlH2e4yfqtCMTNR274K6DhcbawQZQ8iYF9iI4yrkoGO
	 spsRRPO/DDfXyurAf96DpxtB2DfUq2wjzceddWITQn/m1oZUIE84FxI9RpbT8gjeTe
	 iFCFd+zdktptA==
Date: Sun, 4 Feb 2024 11:27:12 +0100
From: Mike Rapoport <rppt@kernel.org>
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
	surenb@google.com, kernel-team@android.com, aarcange@redhat.com,
	peterx@redhat.com, david@redhat.com, axelrasmussen@google.com,
	bgeffon@google.com, willy@infradead.org, jannh@google.com,
	kaleshsingh@google.com, ngeoffray@google.com, timmurray@google.com
Subject: Re: [PATCH v2 2/3] userfaultfd: protect mmap_changing with rw_sem in
 userfaulfd_ctx
Message-ID: <Zb9mgL8XHBZpEVe7@kernel.org>
References: <20240129193512.123145-1-lokeshgidra@google.com>
 <20240129193512.123145-3-lokeshgidra@google.com>
 <20240129210014.troxejbr3mzorcvx@revolver>
 <CA+EESO6XiPfbUBgU3FukGvi_NG5XpAQxWKu7vg534t=rtWmGXg@mail.gmail.com>
 <20240130034627.4aupq27mksswisqg@revolver>
 <Zbi5bZWI3JkktAMh@kernel.org>
 <20240130172831.hv5z7a7bhh4enoye@revolver>
 <CA+EESO7W=yz1DyNsuDRd-KJiaOg51QWEQ_MfpHxEL99ZeLS=AA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+EESO7W=yz1DyNsuDRd-KJiaOg51QWEQ_MfpHxEL99ZeLS=AA@mail.gmail.com>

On Tue, Jan 30, 2024 at 06:24:24PM -0800, Lokesh Gidra wrote:
> On Tue, Jan 30, 2024 at 9:28 AM Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
> >
> > * Mike Rapoport <rppt@kernel.org> [240130 03:55]:
> > > On Mon, Jan 29, 2024 at 10:46:27PM -0500, Liam R. Howlett wrote:
> > > > * Lokesh Gidra <lokeshgidra@google.com> [240129 17:35]:
> > > >
> > > > > > > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > > > > > > index 58331b83d648..c00a021bcce4 100644
> > > > > > > --- a/fs/userfaultfd.c
> > > > > > > +++ b/fs/userfaultfd.c
> > > > > > > @@ -685,12 +685,15 @@ int dup_userfaultfd(struct vm_area_struct *vma, struct list_head *fcs)
> > > > > > >               ctx->flags = octx->flags;
> > > > > > >               ctx->features = octx->features;
> > > > > > >               ctx->released = false;
> > > > > > > +             init_rwsem(&ctx->map_changing_lock);
> > > > > > >               atomic_set(&ctx->mmap_changing, 0);
> > > > > > >               ctx->mm = vma->vm_mm;
> > > > > > >               mmgrab(ctx->mm);
> > > > > > >
> > > > > > >               userfaultfd_ctx_get(octx);
> > > > > > > +             down_write(&octx->map_changing_lock);
> > > > > > >               atomic_inc(&octx->mmap_changing);
> > > > > > > +             up_write(&octx->map_changing_lock);
> > > >
> > > > On init, I don't think taking the lock is strictly necessary - unless
> > > > there is a way to access it before this increment?  Not that it would
> > > > cost much.
> > >
> > > It's fork, the lock is for the context of the parent process and there
> > > could be uffdio ops running in parallel on its VM.
> >
> > Is this necessary then?  We are getting the octx from another mm but the
> > mm is locked for forking.  Why does it matter if there are readers of
> > the octx?
> >
> > I assume, currently, there is no way the userfaultfd ctx can
> > be altered under mmap_lock held for writing. I would think it matters if
> > there are writers (which, I presume are blocked by the mmap_lock for
> > now?)  Shouldn't we hold the write lock for the entire dup process, I
> > mean, if we remove the userfaultfd from the mmap_lock, we cannot let the
> > structure being duplicated change half way through the dup process?
> >
> > I must be missing something with where this is headed?
> >
> AFAIU, the purpose of mmap_changing is to serialize uffdio operations
> with non-cooperative events if and when such events are being
> monitored by userspace (in case you missed, in all the cases of writes
> to mmap_changing, we only do it if that non-cooperative event has been
> requested by the user). As you pointed out there are no correctness
> concerns as far as userfaultfd operations are concerned. But these
> events are essential for the uffd monitor's functioning.
> 
> For example: say the uffd monitor wants to be notified for REMAP
> operations while doing uffdio_copy operations. When COPY ioctls start
> failing with -EAGAIN and uffdio_copy.copy == 0, then it knows it must
> be due to mremap(), in which case it waits for the REMAP event
> notification before attempting COPY again.
> 
> But there are few things that I didn't get after going through the
> history of non-cooperative events. Hopefully Mike (or someone else
> familiar) can clarify:
> 
> IIUC, the idea behind non-cooperative events was to block uffdio
> operations from happening *before* the page tables are manipulated by
> the event (like mremap), and that the uffdio ops are resumed after the
> event notification is received by the monitor.

The idea was to give userspace some way to serialize processing of
non-cooperative event notifications and uffdio operations running in
parallel. It's not necessary to block uffdio operations from happening
before changes to the memory map, but with the mmap_lock synchronization
that already was there adding mmap_chaning that will prevent uffdio
operations when mmap_lock is taken for write was the simplest thing to do.

When CRIU does post-copy restore of a process, its uffd monitor reacts to
page fault and non-cooperative notifications and also performs a background
copy of the memory contents from the saved state to the address space of
the process being restored.

Since non-cooperative events may happen completely independent from the
uffd monitor, there are cases when the uffd monitor couldn't identify the
order of events, like  e.g. what won the race on mmap_lock, the process
thread doing fork or the uffd monitor's uffdio_copy.

In the fork vs uffdio_copy example, without mmap_changing, if the
uffdio_copy takes the mmap_lock first, the new page will be present in the
parent by the time copy_page_range() is called and the page will appear in
the child's memory mappings by the time uffd monitor gets notification
about the fork event. However, if the fork() is the first to take the
mmap_lock, the new page will appear in the parent address space after
copy_page_range() and it won't be mapped in the child's address space.

With mmap_changing and current locking with mmap_lock, we have a guarantee
that uffdio_copy will bail out if fork already took mmap_lock and the
monitor can act appropriately.
 
> 1) Why in the case of REMAP prep() is done after page-tables are
> moved? Shouldn't it be done before? All other non-cooperative
> operations do the prep() before.

mremap_userfaultfd_prep() is done after page tables are moved because it
initializes uffd context on the new_vma and if the actual remap fails,
there's no point of doing it.
Since mrpemap holds mmap_lock for write it does not matter if mmap_changed
is updated before or after page tables are moved. In the time between
mmap_lock is released and the UFFD_EVENT_REMAP is delivered to the uffd
monitor, mmap_chaging will remain >0 and uffdio operations will bail out.

> 2) UFFD_FEATURE_EVENT_REMOVE only notifies user space. It is not
> consistently blocking uffdio operations (as both sides are acquiring
> mmap_lock in read-mode) when remove operation is taking place. I can
> understand this was intentionally left as is in the interest of not
> acquiring mmap_lock in write-mode during madvise. But is only getting
> the notification any useful? Can we say this patch fixes it? And in
> that case shouldn't I split userfaultfd_remove() into two functions
> (like other non-cooperative operations)?

The notifications are useful because uffd monitor knows what memory should
not be filled with uffdio_copy. Indeed there was no interest in taking
mmap_lock for write in madvise, so there could be race between madvise and
uffdio operations. This race essentially prevents uffd monitor from running
the background copy in a separate thread, and with your change this should
be possible.

> 3) Based on [1] I see how mmap_changing helps in eliminating duplicate
> work (background copy) by uffd monitor, but didn't get if there is a
> correctness aspect too that I'm missing? I concur with Amit's point in
> [1] that getting -EEXIST when setting up the pte will avoid memory
> corruption, no?

In the fork case without mmap_changing the child process may be get data or
zeroes depending on the race for mmap_lock between the fork and
uffdio_copy and -EEXIST is not enough for monitor to detect what was the
ordering between fork and uffdio_copy.
 
> > > > > > > @@ -783,7 +788,9 @@ bool userfaultfd_remove(struct vm_area_struct *vma,
> > > > > > >               return true;
> > > > > > >
> > > > > > >       userfaultfd_ctx_get(ctx);
> > > > > > > +     down_write(&ctx->map_changing_lock);
> > > > > > >       atomic_inc(&ctx->mmap_changing);
> > > > > > > +     up_write(&ctx->map_changing_lock);
> > > > > > >       mmap_read_unlock(mm);
> > > > > > >
> > > > > > >       msg_init(&ewq.msg);
> > > >
> > > > If this happens in read mode, then why are you waiting for the readers
> > > > to leave?  Can't you just increment the atomic?  It's fine happening in
> > > > read mode today, so it should be fine with this new rwsem.
> > >
> > > It's been a while and the details are blurred now, but if I remember
> > > correctly, having this in read mode forced non-cooperative uffd monitor to
> > > be single threaded. If a monitor runs, say uffdio_copy, and in parallel a
> > > thread in the monitored process does MADV_DONTNEED, the latter will wait
> > > for userfaultfd_remove notification to be processed in the monitor and drop
> > > the VMA contents only afterwards. If a non-cooperative monitor would
> > > process notification in parallel with uffdio ops, MADV_DONTNEED could
> > > continue and race with uffdio_copy, so read mode wouldn't be enough.
> > >
> >
> > Right now this function won't stop to wait for readers to exit the
> > critical section, but with this change there will be a pause (since the
> > down_write() will need to wait for the readers with the read lock).  So
> > this is adding a delay in this call path that isn't necessary (?) nor
> > existed before.  If you have non-cooperative uffd monitors, then you
> > will have to wait for them to finish to mark the uffd as being removed,
> > where as before it was a fire & forget, this is now a wait to tell.
> >
> I think a lot will be clearer once we get a response to my questions
> above. IMHO not only this write-lock is needed here, we need to fix
> userfaultfd_remove() by splitting it into userfaultfd_remove_prep()
> and userfaultfd_remove_complete() (like all other non-cooperative
> operations) as well. This patch enables us to do that as we remove
> mmap_changing's dependency on mmap_lock for synchronization.

The write-lock is not a requirement here for correctness and I don't see
why we would need userfaultfd_remove_prep().

As I've said earlier, having a write-lock here will let CRIU to run
background copy in parallel with processing of uffd events, but I don't
feel strongly about doing it.

> > > There was no much sense to make MADV_DONTNEED take mmap_lock in write mode
> > > just for this, but now taking the rwsem in write mode here sounds
> > > reasonable.
> > >
> >
> > I see why there was no need for a mmap_lock in write mode, but I think
> > taking the new rwsem in write mode is unnecessary.
> >
> > Basically, I see this as a signal to new readers to abort, but we don't
> > need to wait for current readers to finish before this one increments
> > the atomic.
> >
> > Unless I missed something, I don't think you want to take the write lock
> > here.
> What I understood from the history of mmap_changing is that the
> intention was to enable informing the uffd monitor about the correct
> state of which pages are filled and which aren't. Going through this
> thread was very helpful [2]
> 
> [2] https://lore.kernel.org/lkml/1527061324-19949-1-git-send-email-rppt@linux.vnet.ibm.com/

-- 
Sincerely yours,
Mike.


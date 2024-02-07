Return-Path: <linux-fsdevel+bounces-10623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B3784CDF8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 16:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CC53B28957
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 15:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47DC7F7FD;
	Wed,  7 Feb 2024 15:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdJyBcfh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188BA7E775;
	Wed,  7 Feb 2024 15:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707319665; cv=none; b=LmTByKhUqqNKpGz31RkeMRlW+jCMkd9czueCLfSKefVrlF7fA2F6f1EVWNg+kYh/5lHLrfKWGqdPbr2u1J/6B0K6+w36vPzwhMXDztlxzbdsMj+ejXpNVSed9F0cjioUkjIIxw81DtcMtljI+mXgm5uCgJxDKGvKOzQk/nD8F8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707319665; c=relaxed/simple;
	bh=Wpz6YO32Qj0aa5MgpAxe/gu7xxnOiMKkMHU89Lo/BS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMBRApwkpxlHc12xx0PNqglLOJ91vi1WTyhCFNSfr1lTxENDaW+mShuAWgbad6p01ibHP/LQ93uYt7fCXZUNPL9qXtiNpYNpmGMSpJ0dfPEDmUHz0ZgLpqG3k9EBCPD9F1EvlRwE8F0cVn1yiMJj3ueAw365ssRdANjpcwiv5rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdJyBcfh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDCBC433C7;
	Wed,  7 Feb 2024 15:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707319664;
	bh=Wpz6YO32Qj0aa5MgpAxe/gu7xxnOiMKkMHU89Lo/BS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PdJyBcfhBDugPqfPAHL60XArKC2R50gNcdevNydbNpntpB4hLQISmk+WvQz7ExJDC
	 BnjEi16qiL+uUkmniRIt1RsDgBSF5k0jpliADyYSSFkFX0W/Pl2dewzvm+c8fpAvbu
	 JQx7pQ+aXo7bsJIwGvplzWHtlbtl5mdKbGTUngISuIeYG3C/1J9eHtQqvg24oUDoJa
	 MUuXi5UfS/5Jn1xIHp9P1A16Va9pv3WErzdoSRR6QErvLz99M99eJedf6zKHULEtww
	 3FFY+q2LKz3vMWSnNkBQIws27BPo8ZjZejR4lUtsf7CwtDNhTLL1DvA6c/0DyKJi3X
	 D8zf0Ses6KFCQ==
Date: Wed, 7 Feb 2024 17:27:23 +0200
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
Message-ID: <ZcOhW8NR9XWhVnKS@kernel.org>
References: <20240129193512.123145-1-lokeshgidra@google.com>
 <20240129193512.123145-3-lokeshgidra@google.com>
 <20240129210014.troxejbr3mzorcvx@revolver>
 <CA+EESO6XiPfbUBgU3FukGvi_NG5XpAQxWKu7vg534t=rtWmGXg@mail.gmail.com>
 <20240130034627.4aupq27mksswisqg@revolver>
 <Zbi5bZWI3JkktAMh@kernel.org>
 <20240130172831.hv5z7a7bhh4enoye@revolver>
 <CA+EESO7W=yz1DyNsuDRd-KJiaOg51QWEQ_MfpHxEL99ZeLS=AA@mail.gmail.com>
 <Zb9mgL8XHBZpEVe7@kernel.org>
 <CA+EESO7RNn0aQhLxY+NDddNNNT6586qX08=rphU1-XmyoP5mZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+EESO7RNn0aQhLxY+NDddNNNT6586qX08=rphU1-XmyoP5mZQ@mail.gmail.com>

On Mon, Feb 05, 2024 at 12:53:33PM -0800, Lokesh Gidra wrote:
> On Sun, Feb 4, 2024 at 2:27 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > > 3) Based on [1] I see how mmap_changing helps in eliminating duplicate
> > > work (background copy) by uffd monitor, but didn't get if there is a
> > > correctness aspect too that I'm missing? I concur with Amit's point in
> > > [1] that getting -EEXIST when setting up the pte will avoid memory
> > > corruption, no?
> >
> > In the fork case without mmap_changing the child process may be get data or
> > zeroes depending on the race for mmap_lock between the fork and
> > uffdio_copy and -EEXIST is not enough for monitor to detect what was the
> > ordering between fork and uffdio_copy.
> 
> This is extremely helpful. IIUC, there is a window after mmap_lock
> (write-mode) is released and before the uffd monitor thread is
> notified of fork. In that window, the monitor doesn't know that fork
> has already happened. So, without mmap_changing it would have done
> background copy only in the parent, thereby causing data inconsistency
> between parent and child processes.

Yes.
 
> It seems to me that the correctness argument for mmap_changing is
> there in case of FORK event and REMAP when mremap is called with
> MREMAP_DONTUNMAP. In all other cases its only benefit is by avoiding
> unnecessary background copies, right?

Yes, I think you are right, but it's possible I've forgot some nasty race
that will need mmap_changing for other events.

> > > > > > > > > @@ -783,7 +788,9 @@ bool userfaultfd_remove(struct vm_area_struct *vma,
> > > > > > > > >               return true;
> > > > > > > > >
> > > > > > > > >       userfaultfd_ctx_get(ctx);
> > > > > > > > > +     down_write(&ctx->map_changing_lock);
> > > > > > > > >       atomic_inc(&ctx->mmap_changing);
> > > > > > > > > +     up_write(&ctx->map_changing_lock);
> > > > > > > > >       mmap_read_unlock(mm);
> > > > > > > > >
> > > > > > > > >       msg_init(&ewq.msg);
> > > > > >
> > > > > > If this happens in read mode, then why are you waiting for the readers
> > > > > > to leave?  Can't you just increment the atomic?  It's fine happening in
> > > > > > read mode today, so it should be fine with this new rwsem.
> > > > >
> > > > > It's been a while and the details are blurred now, but if I remember
> > > > > correctly, having this in read mode forced non-cooperative uffd monitor to
> > > > > be single threaded. If a monitor runs, say uffdio_copy, and in parallel a
> > > > > thread in the monitored process does MADV_DONTNEED, the latter will wait
> > > > > for userfaultfd_remove notification to be processed in the monitor and drop
> > > > > the VMA contents only afterwards. If a non-cooperative monitor would
> > > > > process notification in parallel with uffdio ops, MADV_DONTNEED could
> > > > > continue and race with uffdio_copy, so read mode wouldn't be enough.
> > > > >
> > > >
> > > > Right now this function won't stop to wait for readers to exit the
> > > > critical section, but with this change there will be a pause (since the
> > > > down_write() will need to wait for the readers with the read lock).  So
> > > > this is adding a delay in this call path that isn't necessary (?) nor
> > > > existed before.  If you have non-cooperative uffd monitors, then you
> > > > will have to wait for them to finish to mark the uffd as being removed,
> > > > where as before it was a fire & forget, this is now a wait to tell.
> > > >
> > > I think a lot will be clearer once we get a response to my questions
> > > above. IMHO not only this write-lock is needed here, we need to fix
> > > userfaultfd_remove() by splitting it into userfaultfd_remove_prep()
> > > and userfaultfd_remove_complete() (like all other non-cooperative
> > > operations) as well. This patch enables us to do that as we remove
> > > mmap_changing's dependency on mmap_lock for synchronization.
> >
> > The write-lock is not a requirement here for correctness and I don't see
> > why we would need userfaultfd_remove_prep().
> >
> > As I've said earlier, having a write-lock here will let CRIU to run
> > background copy in parallel with processing of uffd events, but I don't
> > feel strongly about doing it.
> >
> Got it. Anyways, such a change needn't be part of this patch, so I'm
> going to keep it unchanged.

You mean with a read lock?

-- 
Sincerely yours,
Mike.


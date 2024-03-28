Return-Path: <linux-fsdevel+bounces-15531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85ED689031C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 16:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2495C1F21309
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 15:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608D012F599;
	Thu, 28 Mar 2024 15:33:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0855AFC11;
	Thu, 28 Mar 2024 15:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711639996; cv=none; b=VxWTV1TgIaHx9xyv/u8+xnusr9PaXibMBRK+c4C//g7NAp1sDv4u2VBXEWh7FyuJ+M5QlS4YfqSVUam48FelnKWdEgPWhTNjNbFiTz/2QIM0eIxMCVXRCWu+P22QDf4uBXDp+H0yftgOJdiclXWV/W+FWR/xJyD4BfcFXzTI4Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711639996; c=relaxed/simple;
	bh=fAKnJ+l/CeeAUwTfc1KZGm5gtMUfkHA9P1HwOy5rWGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKEnPGFwqM5jwNyO+kwJBuLXwW/4qiO48mLHFtV7QhocZ2jgb76eAyCTHtevl4TL/EBKSrAvuWbcga/sjNBPYeSGWITctFR0kofBZcxeN9gcblV44HenecthKmBz1pZufx+LIjP7UrFbSOn95BFNHRkD80/17qAnfCSjym4reU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C99C433F1;
	Thu, 28 Mar 2024 15:33:12 +0000 (UTC)
Date: Thu, 28 Mar 2024 15:33:10 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Doug Anderson <dianders@chromium.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
	Dave Martin <Dave.Martin@arm.com>, Oleg Nesterov <oleg@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	Matthew Wilcox <willy@infradead.org>,
	Eric Biederman <ebiederm@xmission.com>, Jan Kara <jack@suse.cz>,
	Kees Cook <keescook@chromium.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] regset: use kvzalloc() for regset_get_alloc()
Message-ID: <ZgWNtmcyZOMZR1Fi@arm.com>
References: <20240205092626.v2.1.Id9ad163b60d21c9e56c2d686b0cc9083a8ba7924@changeid>
 <CAD=FV=WgGuJLBWmXBOU5oHMvWP2M1cSMS201K8HpyXSYiBPJXQ@mail.gmail.com>
 <CAD=FV=U82H41q3sKxZK_i1ffaQuqwFo98MLiPhSo=mY8SWLJcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=U82H41q3sKxZK_i1ffaQuqwFo98MLiPhSo=mY8SWLJcA@mail.gmail.com>

On Thu, Mar 28, 2024 at 07:16:37AM -0700, Doug Anderson wrote:
> On Mon, Feb 26, 2024 at 3:55 PM Doug Anderson <dianders@chromium.org> wrote:
> > On Mon, Feb 5, 2024 at 9:27 AM Douglas Anderson <dianders@chromium.org> wrote:
> > > While browsing through ChromeOS crash reports, I found one with an
> > > allocation failure that looked like this:
> > >
> > >   chrome: page allocation failure: order:7,
> > >           mode:0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO),
> > >           nodemask=(null),cpuset=urgent,mems_allowed=0
> > >   CPU: 7 PID: 3295 Comm: chrome Not tainted
> > >           5.15.133-20574-g8044615ac35c #1 (HASH:1162 1)
> > >   Hardware name: Google Lazor (rev3 - 8) with KB Backlight (DT)
> > >   Call trace:
> > >   ...
> > >   warn_alloc+0x104/0x174
> > >   __alloc_pages+0x5f0/0x6e4
> > >   kmalloc_order+0x44/0x98
> > >   kmalloc_order_trace+0x34/0x124
> > >   __kmalloc+0x228/0x36c
> > >   __regset_get+0x68/0xcc
> > >   regset_get_alloc+0x1c/0x28
> > >   elf_core_dump+0x3d8/0xd8c
> > >   do_coredump+0xeb8/0x1378
> > >   get_signal+0x14c/0x804
> > >   ...
> > >
> > > An order 7 allocation is (1 << 7) contiguous pages, or 512K. It's not
> > > a surprise that this allocation failed on a system that's been running
> > > for a while.
> > >
> > > More digging showed that it was fairly easy to see the order 7
> > > allocation by just sending a SIGQUIT to chrome (or other processes) to
> > > generate a core dump. The actual amount being allocated was 279,584
> > > bytes and it was for "core_note_type" NT_ARM_SVE.
> > >
> > > There was quite a bit of discussion [1] on the mailing lists in
> > > response to my v1 patch attempting to switch to vmalloc. The overall
> > > conclusion was that we could likely reduce the 279,584 byte allocation
> > > by quite a bit and Mark Brown has sent a patch to that effect [2].
> > > However even with the 279,584 byte allocation gone there are still
> > > 65,552 byte allocations. These are just barely more than the 65,536
> > > bytes and thus would require an order 5 allocation.
> > >
> > > An order 5 allocation is still something to avoid unless necessary and
> > > nothing needs the memory here to be contiguous. Change the allocation
> > > to kvzalloc() which should still be efficient for small allocations
> > > but doesn't force the memory subsystem to work hard (and maybe fail)
> > > at getting a large contiguous chunk.
> > >
> > > [1] https://lore.kernel.org/r/20240201171159.1.Id9ad163b60d21c9e56c2d686b0cc9083a8ba7924@changeid
> > > [2] https://lore.kernel.org/r/20240203-arm64-sve-ptrace-regset-size-v1-1-2c3ba1386b9e@kernel.org
> > >
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > >
> > > Changes in v2:
> > > - Use kvzalloc() instead of vmalloc().
> > > - Update description based on v1 discussion.
> > >
> > >  fs/binfmt_elf.c | 2 +-
> > >  kernel/regset.c | 6 +++---
> > >  2 files changed, 4 insertions(+), 4 deletions(-)
> >
> > Just wanted to check in to see if there's anything else that I need to
> > do here. Mark's patch to avoid the order 7 allocations [1] has landed,
> > but we still want this kvzalloc() because the order 5 allocations
> > can't really be avoided. I'm happy to sit tight for longer but just
> > wanted to make sure it was clear that we still want my patch _in
> > addition_ to Mark's patch and to see if there was anything else you
> > needed me to do.
> >
> > Thanks!
> >
> > [1] https://lore.kernel.org/r/20240213-arm64-sve-ptrace-regset-size-v2-1-c7600ca74b9b@kernel.org
> 
> I'm not trying to be a pest here, so if this is on someone's todo list
> and they'll get to it eventually then feel free to tell me to go away
> and I'll snooze this for another few months. I just want to make sure
> it's not forgotten.
> 
> I've been assuming that someone like Al Viro or Christian Brauner
> would land this patch eventually and I know Al responded rather
> quickly to my v1 [2]. I think all of Al's issues were resolved by Mark
> Brown's patch [1] (which has landed in the arm64 tree) and my updating
> of the patch description in v2. I see that Al and Christian are
> flagged as maintainers of "fs/binfmt_elf.c" which is one of the two
> files I'm touching, so that's mostly why I was assuming they would
> land it.
> 
> ...but I realize that perhaps my assumptions are wrong and this needs
> to go through a different maintainer. In this case (if I'm reading it
> correctly) Al and Christian are listed because the file is under "fs"
> even though this isn't _really_ much of a filesystem-related patch.
> Perhaps this needs to go through something like Andrew Morton's tree
> since he often picks up patches that have nowhere else to land? If
> someone else has suggestions, I'm all ears. I'm also happy to repost
> this patch in case it helps with a maintainer applying it.

FWIW, for this patch:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Yeah, normally Al or Christian would take it but with their ack we can
also take it through the arm64 tree (or Andrew can pick it up through
the mm tree).

With Mark's fix, I assume this is no longer urgent, cc stable material,
but rather something nice in the future to reduce the risk of allocation
failure on this path.

-- 
Catalin


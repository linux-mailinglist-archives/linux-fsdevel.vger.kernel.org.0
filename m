Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D67A462763
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 00:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236829AbhK2XDl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 18:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237101AbhK2XBo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 18:01:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E9EC0F4B30;
        Mon, 29 Nov 2021 12:56:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2298BB81643;
        Mon, 29 Nov 2021 20:56:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26FAC53FAD;
        Mon, 29 Nov 2021 20:56:11 +0000 (UTC)
Date:   Mon, 29 Nov 2021 20:56:08 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/3] btrfs: Avoid live-lock in search_ioctl() on hardware
 with sub-page faults
Message-ID: <YaU+aDG5pCAba57r@arm.com>
References: <YZ6arlsi2L3LVbFO@casper.infradead.org>
 <YZ6idVy3zqQC4atv@arm.com>
 <CAHc6FU4-P9sVexcNt5CDQxROtMAo=kH8hEu==AAhZ_+Zv53=Ag@mail.gmail.com>
 <20211127123958.588350-1-agruenba@redhat.com>
 <YaJM4n31gDeVzUGA@arm.com>
 <CAHc6FU7BSL58GVkOh=nsNQczRKG3P+Ty044zs7PjKPik4vzz=Q@mail.gmail.com>
 <YaTEkAahkCwuQdPN@arm.com>
 <CAHc6FU6zVi9A2D3V3T5zE71YAdkBiJTs0ao1Q6ysSuEp=bz8fQ@mail.gmail.com>
 <YaTziROgnFwB6Ddj@arm.com>
 <CAHk-=wiZgAgcynfLsop+D1xBUAZ-Z+NUBxe9mb-AedecFRNm+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiZgAgcynfLsop+D1xBUAZ-Z+NUBxe9mb-AedecFRNm+w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 29, 2021 at 10:40:38AM -0800, Linus Torvalds wrote:
> On Mon, Nov 29, 2021 at 7:36 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > That's what this series does when it probes the whole range in
> > fault_in_writeable(). The main reason was that it's more efficient to do
> > a read than a write on a large range (the latter dirtying the cache
> > lines).
> 
> The more this thread goes on, the more I'm starting to think that we
> should just make "fault_in_writable()" (and readable, of course) only
> really work on the beginning of the area.
> 
> Not just for the finer-granularity pointer color probing, but for the
> page probing too.

I have patches for the finer-granularity checking of the beginning of
the buffer. They need a bit of testing, so probably posting them
tomorrow.

> I'm looking at our current fault_in_writeable(), and I'm going
> 
>  (a) it uses __put_user() without range checks, which is really not great

For arm64 at least __put_user() does the access_ok() check. I thought
only unsafe_put_user() should skip the checks. If __put_user() can write
arbitrary memory, we may have a bigger problem.

>  (b) it looks like a disaster from another standpoint: essentially
> user-controlled loop size with no limit checking, no preemption, and
> no check for fatal signals.

Indeed, the fault_in_*() loop can get pretty long, bounded by how much
memory can be faulted in the user process. My patches for now only
address the outer loop doing the copy_to_user() as that can be
unbounded.

> Now, (a) should be fixed with a access_ok() or similar.
> 
> And (b) can easily be fixed multiple ways, with one option simply just
> being adding a can_resched() call and checking for fatal signals.
> 
> But faulting in the whole region is actually fundamentally wrong in
> low-memory situations - the beginning of the region might be swapped
> out by the time we get to the end. That's unlikely to be a problem in
> real life, but it's an example of how it's simply not conceptually
> sensible.
> 
> So I do wonder why we don't just say "fault_in_writable will fault in
> _at_most_ X bytes", and simply limit the actual fault-in size to
> something reasonable.
> 
> That solves _all_ the problems. It solves the lack of preemption and
> fatal signals (by virtue of just limiting the amount of work we do).
> It solves the low memory situation. And it solves the "excessive dirty
> cachelines" case too.

I think that would be useful, though it doesn't solve the potential
livelock with sub-page faults. We still need the outer loop to
handle the copy_to_user() for the whole user buffer and the sub-page
probing of the beginning of such buffer (or whenever copy_to_user()
failed). IOW, you still fault in the whole buffer eventually.

Anyway, I think the sub-page probing and limiting the fault-in are
complementary improvements.

-- 
Catalin

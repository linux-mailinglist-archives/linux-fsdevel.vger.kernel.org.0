Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193FB49EC3C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 21:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343881AbiA0UHf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 15:07:35 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45708 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1343910AbiA0UHa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 15:07:30 -0500
Received: from callcc.thunk.org (static-74-43-95-34.fnd.frontiernet.net [74.43.95.34])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 20RK7At4026508
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 15:07:12 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4013F420385; Thu, 27 Jan 2022 15:07:10 -0500 (EST)
Date:   Thu, 27 Jan 2022 15:07:10 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hayley Leblanc <hleblanc@utexas.edu>,
        linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        Vijay Chidambaram <vijayc@utexas.edu>
Subject: Re: Persistent memory file system development in Rust
Message-ID: <YfL7bmytVoKjbANV@mit.edu>
References: <CAFadYX5iw4pCJ2L4s5rtvJCs8mL+tqk=5+tLVjSLOWdDeo7+MQ@mail.gmail.com>
 <YfHMp+zhEjrMHizL@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfHMp+zhEjrMHizL@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 26, 2022 at 10:35:19PM +0000, Matthew Wilcox wrote:
> 
> In particular, the demands of academia (generate novel insights, write
> as many papers as possible, get your PhD) are at odds with the demands
> of a production filesystem (move slowly, don't break anything, DON'T
> LOSE USER DATA).  You wouldn't be the first person to try to do both,
> but I think you might be the first person to be successful.

I need to really underline Matthew Wilcox's point.  As an example,
consider Park and Shin's iJournaling paper which was published at the
2017 Usenix ATC.  Their ideas didn't land in the Linux kernel until
2021, and we're still shaking out some miscellaneous bugs in that
implementation.  Hopefully it will be ready for prime time use by the
end of this year.

Furthermore, ext4 fast commit is a *simplified* version of the ideas
in the iJournal paper, and deliberately omitted a needless
complication that was added at the insistence a member of a program
commiittee to which the paper was previously submitted.

What makes for a successful academic publication is not necessarily
the same as what is successful for a upstreamable file system feature.
And I assert this as someone who has served on Usenix ATC and FAST
program committees, having mentored a graduate student who
successfully submitted a file system paper[1] to Usenix, and having
supervised the engineer who implemented the ideas from the iJournaling
paper from scratch.  So I've seen this issue from both sides.

[1] https://www.usenix.org/system/files/conference/fast17/fast17-aghayev.pdf

> > 1. What is the state of PM file system development in the kernel? I
> > know that there was some effort to merge NOVA [2] and nvfs [3] in the
> > last few years, but neither seems to have panned out.
> 
> Correct.  I'm not aware of anything else currently under development.
> I'd file both those filesystems under "Things people tried and learned
> things from", although maybe there'll be a renewed push to get one
> or the other merged.

One of the things that might be interesting for someone who wants to
upstream an academic file system is to run xfstests on it, and see
what happens.  One of the original reasons why I spent so much time
documenting gce-xfstests[2] and kvm-xfstests in the xfstests-bld
repository[3].  Back when I was younger and more naive, I was hoping
that academics could use this to easily take their academic file
systems to become production quality, so I tried to make it be as
turn-key as possible, and well documented for people who might not be
kernel development experts.

[2] https://thunk.org/gce-xfstests
[3] https://github.com/tytso/xfstests-bld

However, what I think you will find is even though a new file system
is good enough to run benchmarks, and even be self-hosting, will see a
massive number of test failures, not to mention generate kernel
crashes.  And I very much doubt that funding agencies would pay for a
graduate student to work out all of the kernel crashes and test
failures --- and even if they did, it's not clear that it's fair to
the graduate student, who might be wanting get their Ph.D. and then
get that sweet, sweet, high-paying job at Amazon or Microsoft or Google.  :-)

It does occur to me, though, that an interesting ATC experience paper
might be to take gce-xfstests or kvm-xfstests, and running the
xfstests' auto group on a number of academic file systems such as
NOVA, nvfs, Bentofs, and BetrFS[4]..., maybe documenting how much
effort it would take to address a representative number of failures,
and then document the findings.  I suspect that people in both the
academic and industry communities (at least those who don't work on
production file systems) would find it to be quite.... eye-opening.
(If someone is interested in doing this, let me know; I'd be happy to
help in this effort.)

[4] https://www.betrfs.org/   (*NOT* btrfs, in case any readers
    			       aren't familiar with BetrFS)

> > 3. We're interested in using a framework called Bento [4] as the basis
> > for our file system development. Is this project on Linux devs' radar?
> > What are the rough chances that this work (or something similar) could
> > end up in the kernel at some point?

One cautionary note about Bento; while it saves the kernel<->userspace
"hop" involved with FUSE, it still uses the in-kernel FUSE interface.
So among other things, that means a file system using Bento doesn't
have direct access to (a) the VFS Dentry cache, which could impact
metadata performance, and (b) the page cache, which will impact
data-plane performance.

Given that performance is often very important for persistent memory
file systems (otherwise why pay $$$$ for persistent memory hardware?)
you may want to take a close look at the overhead and serialization
overheads of using Bento.

The other thing to note about Bento is that it reused the jbd2 and
buffer cache layer.  That might be appropriate for a block-based file
system, but it's not going to be something you can use for a
persistent-memory based file system.  So it's not as general a
framework as it first appears (so good enough to make a point about an
idea for an academic publication, but not necessarily good enough for
"real world" file systems).  Also, if I had been on the program
committeee that reviewed this paper, I would have ding'ed them on
their choice of benchmarks (tar, untar, grep, "git clone", RLY?).

As Willy stated, this is just my opinion, which is worth what you paid
for it.  And best of luck as you pursue your research!

Cheers,

						- Ted

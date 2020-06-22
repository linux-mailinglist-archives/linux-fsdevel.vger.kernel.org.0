Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4F9202E07
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 03:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgFVBCp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Jun 2020 21:02:45 -0400
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:36133 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726581AbgFVBCo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Jun 2020 21:02:44 -0400
Received: from dread.disaster.area (pa49-180-124-177.pa.nsw.optusnet.com.au [49.180.124.177])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id 42A7310DA4D;
        Mon, 22 Jun 2020 11:02:35 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jnAr4-0001bL-7m; Mon, 22 Jun 2020 11:02:34 +1000
Date:   Mon, 22 Jun 2020 11:02:34 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Bypass filesystems for reading cached pages
Message-ID: <20200622010234.GD2040@dread.disaster.area>
References: <20200619155036.GZ8681@bombadil.infradead.org>
 <CAOQ4uxjy6JTAQqvK9pc+xNDfzGQ3ACefTrySXtKb_OcAYQrdzw@mail.gmail.com>
 <20200620191521.GG8681@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200620191521.GG8681@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=k3aV/LVJup6ZGWgigO6cSA==:117 a=k3aV/LVJup6ZGWgigO6cSA==:17
        a=kj9zAlcOel0A:10 a=nTHF0DUjJn0A:10 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8
        a=pGLkceISAAAA:8 a=uZvujYp8AAAA:8 a=7-415B0cAAAA:8 a=XmBkdv6aKiYQRZ68EV0A:9
        a=CjuIK1q_8ugA:10 a=MH3prGP_eOIA:10 a=1CNFftbPRP8L7MoqJWF3:22
        a=AjGcO6oz07-iQ99wixmX:22 a=SLzB8X_8jTLwj6mN0q5r:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 20, 2020 at 12:15:21PM -0700, Matthew Wilcox wrote:
> On Sat, Jun 20, 2020 at 09:19:37AM +0300, Amir Goldstein wrote:
> > On Fri, Jun 19, 2020 at 6:52 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > This patch lifts the IOCB_CACHED idea expressed by Andreas to the VFS.
> > > The advantage of this patch is that we can avoid taking any filesystem
> > > lock, as long as the pages being accessed are in the cache (and we don't
> > > need to readahead any pages into the cache).  We also avoid an indirect
> > > function call in these cases.
> > 
> > XFS is taking i_rwsem lock in read_iter() for a surprising reason:
> > https://lore.kernel.org/linux-xfs/CAOQ4uxjpqDQP2AKA8Hrt4jDC65cTo4QdYDOKFE-C3cLxBBa6pQ@mail.gmail.com/
> > In that post I claim that ocfs2 and cifs also do some work in read_iter().
> > I didn't go back to check what, but it sounds like cache coherence among
> > nodes.
> 
> That's out of date.  Here's POSIX-2017:
> 
> https://pubs.opengroup.org/onlinepubs/9699919799/functions/read.html
> 
>   "I/O is intended to be atomic to ordinary files and pipes and
>   FIFOs. Atomic means that all the bytes from a single operation that
>   started out together end up together, without interleaving from other
>   I/O operations. It is a known attribute of terminals that this is not
>   honored, and terminals are explicitly (and implicitly permanently)
>   excepted, making the behavior unspecified. The behavior for other
>   device types is also left unspecified, but the wording is intended to
>   imply that future standards might choose to specify atomicity (or not)."
> 
> That _doesn't_ say "a read cannot observe a write in progress".  It says
> "Two writes cannot interleave".  Indeed, further down in that section, it says:

Nope, it says "... without interleaving from other I/O operations".

That means read() needs to be atomic w.r.t truncate, hole punching,
extent zeroing, etc, not just other write() syscalls.

Really, though, I'm not going to get drawn into a language lawyering
argument here. We've discussed this before, and it's pretty clear
the language supports both arguments in one way or another.

And that means we are not going to change behaviour that XFS has
provided for 27 years now. Last time this came up, I said:

"XFS was designed with the intent that buffered writes are
atomic w.r.t. to all other file accesses."

Christoph said:

"Downgrading these long standing guarantees is simply not an option"

Darrick:

"I don't like the idea of adding a O_BROKENLOCKINGPONIES flag"

Nothing has changed since this was last discussed. 

Well, except for the fact that since then I've seen the source code
to some 20+ year old enterprise applications that have been ported
to Linux and that has made me even more certain that we need to
maintain XFS's existing behaviour....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

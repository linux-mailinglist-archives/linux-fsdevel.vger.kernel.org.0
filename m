Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C634133472
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 22:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgAGU7i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 15:59:38 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:41790 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728143AbgAGU7g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 15:59:36 -0500
Received: from dread.disaster.area (pa49-180-68-255.pa.nsw.optusnet.com.au [49.180.68.255])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 1AB3A7E9696;
        Wed,  8 Jan 2020 07:59:29 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iovwl-0005j6-Bq; Wed, 08 Jan 2020 07:59:27 +1100
Date:   Wed, 8 Jan 2020 07:59:27 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Chris Down <chris@chrisdown.name>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH v5 2/2] tmpfs: Support 64-bit inums per-sb
Message-ID: <20200107205927.GP23195@dread.disaster.area>
References: <cover.1578225806.git.chris@chrisdown.name>
 <ae9306ab10ce3d794c13b1836f5473e89562b98c.1578225806.git.chris@chrisdown.name>
 <20200107001039.GM23195@dread.disaster.area>
 <20200107001643.GA485121@chrisdown.name>
 <20200107003944.GN23195@dread.disaster.area>
 <CAOQ4uxjvH=UagqjHP_71_p9_dW9wKqiaWujzY1xKe7yZVFPoTA@mail.gmail.com>
 <alpine.LSU.2.11.2001070002040.1496@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2001070002040.1496@eggly.anvils>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=sbdTpStuSq8iNQE8viVliQ==:117 a=sbdTpStuSq8iNQE8viVliQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=Jdjhy38mL1oA:10
        a=7-415B0cAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=NfcANyMyxpC2L4-oeLMA:9
        a=m9ZyxzaG-Li82a_w:21 a=3IqF15cTKkrrdw7V:21 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22 a=AjGcO6oz07-iQ99wixmX:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 07, 2020 at 12:36:25AM -0800, Hugh Dickins wrote:
> On Tue, 7 Jan 2020, Amir Goldstein wrote:
> > On Tue, Jan 7, 2020 at 2:40 AM Dave Chinner <david@fromorbit.com> wrote:
> > > On Tue, Jan 07, 2020 at 12:16:43AM +0000, Chris Down wrote:
> > > > Dave Chinner writes:
> > > > > It took 15 years for us to be able to essentially deprecate
> > > > > inode32 (inode64 is the default behaviour), and we were very happy
> > > > > to get that albatross off our necks.  In reality, almost everything
> > > > > out there in the world handles 64 bit inodes correctly
> > > > > including 32 bit machines and 32bit binaries on 64 bit machines.
> > > > > And, IMNSHO, there no excuse these days for 32 bit binaries that
> > > > > don't using the *64() syscall variants directly and hence support
> > > > > 64 bit inodes correctlyi out of the box on all platforms.
> 
> Interesting take on it.  I'd all along imagined we would have to resort
> to a mount option for safety, but Dave is right that I was too focused on
> avoiding tmpfs regressions, without properly realizing that people were
> very unlikely to have written such tools for tmpfs in particular, but
> written them for all filesystems, and already encountered and fixed
> such EOVERFLOWs for other filesystems.
> 
> Hmm, though how readily does XFS actually reach the high inos on
> ordinary users' systems?

Quite frequently these days - the threshold for exceeding 32 bits
in the inode number is dependent on the inode size.

Old v4 filesystems use 256 byte inodes by default, so they overflow
32bits when the filesystem size is >1TB.

Current v5 filesystems use 512 byte inodes, so they overflow 32 bits
on filesytsems >2TB.

> > > > I'm very glad to hear that. I strongly support moving to 64-bit inums in all
> > > > cases if there is precedent that it's not a compatibility issue, but from
> > > > the comments on my original[0] patch (especially that they strayed from the
> > > > original patches' change to use ino_t directly into slab reuse), I'd been
> > > > given the impression that it was known to be one.
> > > >
> > > > From my perspective I have no evidence that inode32 is needed other than the
> > > > comment from Jeff above get_next_ino. If that turns out not to be a problem,
> > > > I am more than happy to just wholesale migrate 64-bit inodes per-sb in
> > > > tmpfs.
> > >
> > > Well, that's my comment above about 32 bit apps using non-LFS
> > > compliant interfaces in this day and age. It's essentially a legacy
> > > interface these days, and anyone trying to access a modern linux
> > > filesystem (btrfs, XFS, ext4, etc) ion 64 bit systems need to handle
> > > 64 bit inodes because they all can create >32bit inode numbers
> > > in their default configurations.
> 
> I thought ext4 still deals in 32-bit inos, so ext4-world would not
> necessarily have caught up?

Hmmm - I might have got my wires crossed there - there *was* a
project some time ago to increase the ext4 inode number size for
large filesystems. Ah, yeah, there we go:

https://lore.kernel.org/linux-ext4/20171101212455.47964-1-artem.blagodarenko@gmail.com/

I thought it had been rolled in with all the other "make stuff
larger" features that ext4 has...

> Though, arguing the other way, IIUC 64-bit
> ino support comes bundled with file sizes over 2GB (on all architectures?),
> and it's hard to imagine who gets by with a 2GB file size limit nowadays.

Right, you need to define LFS support for >2GB file support and
you get 64 bit inode support with that for free. It's only legacy
binaries that haven't been rebuilt in the past 15 years that are an
issue here, but there are so many other things that can go trivially
wrong with such binaries I think that inode numbers are the least of
the worries here...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

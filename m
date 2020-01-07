Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3A6A13321B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 22:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbgAGVHY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 16:07:24 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:39024 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729513AbgAGVHX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:07:23 -0500
Received: from dread.disaster.area (pa49-180-68-255.pa.nsw.optusnet.com.au [49.180.68.255])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 9EC533A3117;
        Wed,  8 Jan 2020 08:07:17 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iow4J-0005jX-QL; Wed, 08 Jan 2020 08:07:15 +1100
Date:   Wed, 8 Jan 2020 08:07:15 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Hugh Dickins <hughd@google.com>, Chris Down <chris@chrisdown.name>,
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
Message-ID: <20200107210715.GQ23195@dread.disaster.area>
References: <cover.1578225806.git.chris@chrisdown.name>
 <ae9306ab10ce3d794c13b1836f5473e89562b98c.1578225806.git.chris@chrisdown.name>
 <20200107001039.GM23195@dread.disaster.area>
 <20200107001643.GA485121@chrisdown.name>
 <20200107003944.GN23195@dread.disaster.area>
 <CAOQ4uxjvH=UagqjHP_71_p9_dW9wKqiaWujzY1xKe7yZVFPoTA@mail.gmail.com>
 <alpine.LSU.2.11.2001070002040.1496@eggly.anvils>
 <CAOQ4uxiMQ3Oz4M0wKo5FA_uamkMpM1zg7ydD8FXv+sR9AH_eFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiMQ3Oz4M0wKo5FA_uamkMpM1zg7ydD8FXv+sR9AH_eFA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=sbdTpStuSq8iNQE8viVliQ==:117 a=sbdTpStuSq8iNQE8viVliQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=Jdjhy38mL1oA:10
        a=1XWaLZrsAAAA:8 a=7-415B0cAAAA:8 a=qLVrV9dGIdnuQ3zi2hkA:9
        a=jPg9kqVogik6UUPB:21 a=Tmguthn7wsSX_SwC:21 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 07, 2020 at 12:12:00PM +0200, Amir Goldstein wrote:
> On Tue, Jan 7, 2020 at 10:36 AM Hugh Dickins <hughd@google.com> wrote:
> >
> > On Tue, 7 Jan 2020, Amir Goldstein wrote:
> > > On Tue, Jan 7, 2020 at 2:40 AM Dave Chinner <david@fromorbit.com> wrote:
> > > > On Tue, Jan 07, 2020 at 12:16:43AM +0000, Chris Down wrote:
> > > > > Dave Chinner writes:
> > > > > > It took 15 years for us to be able to essentially deprecate
> > > > > > inode32 (inode64 is the default behaviour), and we were very happy
> > > > > > to get that albatross off our necks.  In reality, almost everything
> > > > > > out there in the world handles 64 bit inodes correctly
> > > > > > including 32 bit machines and 32bit binaries on 64 bit machines.
> > > > > > And, IMNSHO, there no excuse these days for 32 bit binaries that
> > > > > > don't using the *64() syscall variants directly and hence support
> > > > > > 64 bit inodes correctlyi out of the box on all platforms.
> >
> > Interesting take on it.  I'd all along imagined we would have to resort
> > to a mount option for safety, but Dave is right that I was too focused on
> > avoiding tmpfs regressions, without properly realizing that people were
> > very unlikely to have written such tools for tmpfs in particular, but
> > written them for all filesystems, and already encountered and fixed
> > such EOVERFLOWs for other filesystems.
> >
> > Hmm, though how readily does XFS actually reach the high inos on
> > ordinary users' systems?
> >
> 
> Define 'ordinary'
> I my calculations are correct, with default mkfs.xfs any inode allocated
> from logical offset > 2TB on a volume has high ino bits set.
> Besides, a deployment with more than 4G inodes shouldn't be hard to find.

You don't need to allocate 4 billion inodes to get >32bit inodes in
XFS - the inode number is an encoding of the physical location of
the inode in the filesystem. Hence we just have to allocate the
inode at a disk address higher than 2TB into the device and we
overflow 32bits.

e.g. make a sparse fs image file of 10TB, mount it, create 50
subdirs, then start creating zero length files spread across the 50
separate subdirectories. You should see >32bit inode numbers almost
immediately. (i.e. as soon as we allocate inodes in AG 2 or higher)

IOWs, there are *lots* of 64bit inode numbers out there on XFS
filesystems....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

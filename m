Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40737F0F05
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2019 07:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbfKFGkF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Nov 2019 01:40:05 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:51522 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728724AbfKFGkF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Nov 2019 01:40:05 -0500
Received: from dread.disaster.area (pa49-180-67-183.pa.nsw.optusnet.com.au [49.180.67.183])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 04F453A1D93;
        Wed,  6 Nov 2019 17:39:54 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iSEyu-0001iI-Op; Wed, 06 Nov 2019 17:39:52 +1100
Date:   Wed, 6 Nov 2019 17:39:52 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     dsterba@suse.cz, Geert Uytterhoeven <geert@linux-m68k.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, Jan Kara <jack@suse.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [RFC] errno.h: Provide EFSCORRUPTED for everybody
Message-ID: <20191106063952.GE4614@dread.disaster.area>
References: <20191031010736.113783-1-Valdis.Kletnieks@vt.edu>
 <CAMuHMdXzyVBa4TZEc5eRaBzu50thgJ2TrHJLZqwhbQ=JASgWOA@mail.gmail.com>
 <20191101213823.GW4614@dread.disaster.area>
 <20191105151550.GK3001@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105151550.GK3001@twin.jikos.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0
        a=3wLbm4YUAFX2xaPZIabsgw==:117 a=3wLbm4YUAFX2xaPZIabsgw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=MeAgGD-zjQ4A:10
        a=eJfxgxciAAAA:8 a=7-415B0cAAAA:8 a=nWWV64Vs4Ia0ohqM8ygA:9
        a=G5VXLrwXQuX2I6J2:21 a=BA2X2tOPKDw4xi1b:21 a=CjuIK1q_8ugA:10
        a=xM9caqqi1sUkTy8OJ5Uh:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 05, 2019 at 04:15:50PM +0100, David Sterba wrote:
> On Sat, Nov 02, 2019 at 08:38:23AM +1100, Dave Chinner wrote:
> > On Fri, Nov 01, 2019 at 09:57:31PM +0100, Geert Uytterhoeven wrote:
> > > Hi Valdis,
> > > 
> > > On Thu, Oct 31, 2019 at 2:11 AM Valdis Kletnieks
> > > <valdis.kletnieks@vt.edu> wrote:
> > > > Three questions: (a) ACK/NAK on this patch, (b) should it be all in one
> > > > patch, or one to add to errno.h and 6 patches for 6 filesystems?), and
> > > > (c) if one patch, who gets to shepherd it through?
> > > >
> > > > There's currently 6 filesystems that have the same #define. Move it
> > > > into errno.h so it's defined in just one place.
> > > >
> > > > Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
> > > 
> > > Thanks for your patch!
> > > 
> > > > --- a/include/uapi/asm-generic/errno.h
> > > > +++ b/include/uapi/asm-generic/errno.h
> > > > @@ -98,6 +98,7 @@
> > > >  #define        EINPROGRESS     115     /* Operation now in progress */
> > > >  #define        ESTALE          116     /* Stale file handle */
> > > >  #define        EUCLEAN         117     /* Structure needs cleaning */
> > > > +#define        EFSCORRUPTED    EUCLEAN
> > > 
> > > I have two questions:
> > > a) Why not use EUCLEAN everywhere instead?
> > >     Having two different names for the same errno complicates grepping.
> > 
> > Because:
> > 	a) EUCLEAN is horrible for code documentation. EFSCORRUPTED
> > 	describes exactly the error being returned and/or checked for.
> > 
> > 	b) we've used EFSCORRUPTED in XFS since 1993. i.e. it was an
> > 	official, published error value on Irix, and we've kept it
> > 	in the linux code for the past ~20 years because of a)
> > 
> > 	c) Userspace programs that include filesystem specific
> > 	headers have already been exposed to and use EFSCORRUPTED,
> > 	so we can't remove/change it without breaking userspace.
> > 
> > 	d) EUCLEAN has a convenient userspace string description
> > 	that is appropriate for filesystem corruption: "Structure
> > 	needs cleaning" is precisely what needs to happen. Repair of
> > 	the filesystem (i.e. recovery to a clean state) is what is
> > 	required to fix the error....
> 
> The description is very confusing to users that are also not filesystem
> developers.

That's a pretty good description of most error messages for modern
software packages. Anything that is a non-trivial error requires web
searching to understand and diagnose these days.

Google knows exactly what you are looking for if you search for
"mount structure needs cleaning" or other similar error messages.
That means users also know what it means and what they need to
do to address it.  i.e. it's been around long enough that there's a
deep history in internet search engines and question forums like
stackexchange.

> "Structure needs cleaning" says what needs to be done but
> not what happened. Unlike other error codes like "not enough memory",
> "IO error" etc. We don't have EBUYMEM / "Buy more memory" instead of
> ENOMEM.

Message grammar is largely irrelevant. And not unique to EUCLEAN. e.g.
EAGAIN = "Try again".

> Fuzzing tests and crafted images produce most of the EUCLEAN errors and
> in this context "structure needs cleaning" makes even less sense.

It's pretty silly to argue that a developer crafting and/or fuzzing
corrupted filesystem images is not going to understand what the
error message returned when they successfully corrupt a filesystem
actually means....

> > > b) Perhaps both errors should use different values?
> > 
> > That horse bolted to userspace years ago - this is just
> > formalising the practice that has spread across multiple linux
> > filesystems from XFS over the past ~10 years..
> 
> EFSCORRUPTED is a appropriate name but to share the number with
> EUCLEAN was a terrible decision and now every filesystem has to
> suffer and explain to users what the code really means and point
> to the the sad story when asked "So why don't you have a separate
> code?".

Damned if you do, damned if you don't.

Back in 2005-2006, XFS developers tried to make EFSCORRUPTED a
proper system wide errno (like we had on Irix). The NIH was strong
in the linux community back then, and we were largely told to go
away as the superior Linux filesystems would never need to report
corruption to userspace so we don't need a special errno just
because some shitty Irix filesystem port needs it.

And so we didn't get a new errno and went with the second choice:
precedence set by older unix systems....

commit 9e1fd551aba7291564d5d6c28948405142d5e2ca
Author: Nathan Scott <nathans@sgi.com>
Date:   Tue Jun 20 03:49:47 2006 +0000

    Map EFSCORRUPTED to an actual error code, not just a made up one
    (990).  Turns out some ye-olde unices used EUCLEAN as
    Filesystem-needs-cleaning, so now we use that too.
    Merge of xfs-linux-melb:xfs-kern:26286a by kenmcd.

diff --git a/fs/xfs/linux-2.6/xfs_linux.h b/fs/xfs/linux-2.6/xfs_linux.h
index 3910afa7..b4083f8c 100644
--- a/fs/xfs/linux-2.6/xfs_linux.h
+++ b/fs/xfs/linux-2.6/xfs_linux.h
@@ -197,25 +197,9 @@ BUFFER_FNS(PrivateStart, unwritten);
 /* bytes to clicks */
 #define btoc(x)         (((__psunsigned_t)(x)+(NBPC-1))>>BPCSHIFT)
 
-#ifndef ENOATTR
 #define ENOATTR                ENODATA         /* Attribute not found */
-#endif
-
-/* Note: EWRONGFS never visible outside the kernel */
-#define        EWRONGFS        EINVAL          /* Mount with wrong filesystem type */
-
-/*
- * XXX EFSCORRUPTED needs a real value in errno.h. asm-i386/errno.h won't
- *     return codes out of its known range in errno.
- * XXX Also note: needs to be < 1000 and fairly unique on Linux (mustn't
- *     conflict with any code we use already or any code a driver may use)
- * XXX Some options (currently we do #2):
- *     1/ New error code ["Filesystem is corrupted", _after_ glibc updated]
- *     2/ 990 ["Unknown error 990"]
- *     3/ EUCLEAN ["Structure needs cleaning"]
- *     4/ Convert EFSCORRUPTED to EIO [just prior to return into userspace]
- */
-#define EFSCORRUPTED    990            /* Filesystem is corrupted */
+#define EWRONGFS       EINVAL          /* Mount with wrong filesystem type */
+#define EFSCORRUPTED   EUCLEAN         /* Filesystem is corrupted */
 
 #define SYNCHRONIZE()  barrier()
 #define __return_address __builtin_return_address(0)

Perhaps you should learn the history of why certain decisions were
made before letting go with both barrels, hmmm?

> I wonder what userspace package really depends on the value, that
> would eg. change code flow. Uncommon error values usually lead to
> a message and exit.
> 
> Debian code search shows only jython, e2fsprogs, xfsprogs,
> python2.7, pypy, linux, partclone using EFSCORRUPTED. So 2 of them
> are filesystem packages that can handle that, python/jython only
> defines the value for IRIX platform. The rest is linux kernel, not
> relevant.

You didn't search for EUCLEAN, did you?

> So please give me one example where userspace will break.

ABI changes cannot be justified this way and you should damn well
know it. Especially as EUCLEAN/EFSCORRUPTED is documented in quite a
few man pages out there:

$ git grep -l EFSCORRUPTED man/
man/man2/ioctl_xfs_ag_geometry.2
man/man2/ioctl_xfs_bulkstat.2
man/man2/ioctl_xfs_fsbulkstat.2
man/man2/ioctl_xfs_fscounts.2
man/man2/ioctl_xfs_fsgetxattr.2
man/man2/ioctl_xfs_fsinumbers.2
man/man2/ioctl_xfs_fsop_geometry.2
man/man2/ioctl_xfs_getbmapx.2
man/man2/ioctl_xfs_getresblks.2
man/man2/ioctl_xfs_goingdown.2
man/man2/ioctl_xfs_inumbers.2
man/man2/ioctl_xfs_scrub_metadata.2

And EUCLEAN is in a few, too. e.g:

$ man ioctl_getfsmap |grep -A 1 EUCLEAN
       EUCLEAN
              The filesystem metadata is corrupt and needs repair.

So, yeah, the EFSCORRUPTED = EUCLEAN horse bolted long ago, and no
amount of retconning will put the genie back in the bottle.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

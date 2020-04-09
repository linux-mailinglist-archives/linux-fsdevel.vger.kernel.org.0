Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E06721A2CDF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 02:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgDIAao (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Apr 2020 20:30:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56744 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgDIAao (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Apr 2020 20:30:44 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0390IMNt174842;
        Thu, 9 Apr 2020 00:30:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=jQG/1w0xTNT1IdsGIvukSAI4YR5qMLNQwW/1R5Bsumw=;
 b=tc/WovdJua7UyG4KKjek2PAL475AfRJSTmrgq5ez85YsEtiwKLB6x2EwRRCE3z61mw3m
 hHTTkLXlbxcP9cbgkWXDzbgZ+xL4QDCjG7WzB8LQ490bzv+Rq5DXUnr9drih2uy5Rc0V
 KAQ5lMpG0kMY0qQvwxSQ0m1NHfhqfX0FTobmSaagRjPwN78YOjFjWPPLYeQlKWaLticX
 /lTW3VTzSIy5l4oNe742VeQtFI//wDmTnMT9elmxBrgihkqbwybxYttA0D49g30eXQwT
 TZRR95UDKj1pSTCNOntqoVz/0L3oQkWRJVaSbAjqc0Do37AtAh9QtSmkkl5UwP0Zsq8g Og== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 3091m3ekbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Apr 2020 00:30:30 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0390Ha3L086905;
        Thu, 9 Apr 2020 00:30:29 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 3091m5u4sy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Apr 2020 00:30:29 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0390UNfv008886;
        Thu, 9 Apr 2020 00:30:23 GMT
Received: from localhost (/10.159.145.57)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 08 Apr 2020 17:30:23 -0700
Date:   Wed, 8 Apr 2020 17:30:21 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V6 6/8] fs/xfs: Combine xfs_diflags_to_linux() and
 xfs_diflags_to_iflags()
Message-ID: <20200409003021.GJ6742@magnolia>
References: <20200407182958.568475-1-ira.weiny@intel.com>
 <20200407182958.568475-7-ira.weiny@intel.com>
 <20200408020827.GI24067@dread.disaster.area>
 <20200408170923.GC569068@iweiny-DESK2.sc.intel.com>
 <20200408210236.GK24067@dread.disaster.area>
 <20200408220734.GA664132@iweiny-DESK2.sc.intel.com>
 <20200408232106.GO24067@dread.disaster.area>
 <20200409001206.GD664132@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409001206.GD664132@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9585 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004090000
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9585 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004090000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 08, 2020 at 05:12:06PM -0700, Ira Weiny wrote:
> On Thu, Apr 09, 2020 at 09:21:06AM +1000, Dave Chinner wrote:
> > On Wed, Apr 08, 2020 at 03:07:35PM -0700, Ira Weiny wrote:
> > > On Thu, Apr 09, 2020 at 07:02:36AM +1000, Dave Chinner wrote:
> > > > On Wed, Apr 08, 2020 at 10:09:23AM -0700, Ira Weiny wrote:
> > > 
> > > [snip]
> > > 
> > > > > 
> > > > > This sounds good but I think we need a slight modification to make the function equivalent in functionality.
> > > > > 
> > > > > void
> > > > > xfs_diflags_to_iflags(
> > > > >         struct xfs_inode        *ip,
> > > > >         bool init)
> > > > > {
> > > > >         struct inode            *inode = VFS_I(ip);
> > > > >         unsigned int            xflags = xfs_ip2xflags(ip);
> > > > >         unsigned int            flags = 0;
> > > > > 
> > > > >         inode->i_flags &= ~(S_IMMUTABLE | S_APPEND | S_SYNC | S_NOATIME |
> > > > >                             S_DAX);
> > > > 
> > > > We don't want to clear the dax flag here, ever, if it is already
> > > > set. That is an externally visible change and opens us up (again) to
> > > > races where IS_DAX() changes half way through a fault path. IOWs, avoiding
> > > > clearing the DAX flag was something I did explicitly in the above
> > > > code fragment.
> > > 
> > > <sigh> yes... you are correct.
> > > 
> > > But I don't like depending on the caller to clear the S_DAX flag if
> > > xfs_inode_enable_dax() is false.  IMO this function should clear the flag in
> > > that case for consistency...
> > 
> > No. We simply cannot do that here except in the init case when the
> > inode is not yet visible to userspace. In which case, we know -for
> > certain- that the S_DAX is not set, and hence we do not need to
> > clear it. Initial conditions matter!
> > 
> > If you want to make sure of this, add this:
> > 
> > 	ASSERT(!(IS_DAX(inode) && init));
> > 
> > And now we'll catch inodes that incorrectly have S_DAX set at init
> > time.
> 
> Ok, that will work.  Also documents that expected initial condition.
> 
> > 
> > > > memory S_DAX flag, we can actually clear the on-disk flag
> > > > safely, so that next time the inode cycles into memory it won't
> > > > be using DAX. IOWs, admins can stop the applications, clear the
> > > > DAX flag and drop caches. This should result in the inode being
> > > > recycled and when the app is restarted it will run without DAX.
> > > > No ned for deleting files, copying large data sets, etc just to
> > > > turn off an inode flag.
> > > 
> > > We already discussed evicting the inode and it was determined to
> > > be too confusing.[*]
> > 
> > That discussion did not even consider how admins are supposed to
> > clear the inode flag once it is set on disk.
> 
> I think this is a bit unfair.  I think we were all considering it...  and I
> still think this patch set is a step in the right direction.
> 
> > It was entirely
> > focussed around "we can't change in memory S_DAX state"
> 
> Not true.  There were many ideas on how to change the FS_XFLAG_DAX with some
> sort of delayed S_DAX state to avoid changing S_DAX on an in memory inode.
> 
> I made the comment:
> 
> 	"... I want to clarify.  ...  we could have the flag change with an
> 	appropriate error which could let the user know the change has been
> 	delayed."
> 
> 	-- https://lore.kernel.org/lkml/20200402205518.GF3952565@iweiny-DESK2.sc.intel.com/
> 
> Jan made multiple comments:
> 
> 	"I generally like the proposal but I think the fact that toggling
> 	FS_XFLAG_DAX will not have immediate effect on S_DAX will cause quite
> 	some confusion and ultimately bug reports."
> 
> 	-- https://lore.kernel.org/lkml/20200401102511.GC19466@quack2.suse.cz/
> 
> 
> 	"Just switch FS_XFLAG_DAX flag, S_DAX flag will magically switch when
> 	inode gets evicted and the inode gets reloaded from the disk again. Did
> 	I misunderstand anything?
> 
> 	And my thinking was that this is surprising behavior for the user and
> 	so it will likely generate lots of bug reports along the lines of "DAX
> 	inode flag does not work!"."
> 
> 	-- https://lore.kernel.org/lkml/20200403170338.GD29920@quack2.suse.cz/
> 
> Darrick also had similar ideas/comments.
> 
> Christoph did say:
> 
> 	"A reasonably smart application can try to evict itself."
> 
> 	-- https://lore.kernel.org/lkml/20200403072731.GA24176@lst.de/
> 
> Which I was unclear about???
> 
> Christoph does this mean you would be ok with changing the FS_XFLAG_DAX on disk
> and letting S_DAX change later?
> 
> > and how the
> > tri-state mount option to "override" the on-disk flag could be done.
> > 
> > Nobody noticed that being unable to rmeove the on-disk flag means
> > the admin's only option to turn off dax for an application is to
> > turn it off for everything, filesystem wide, which requires:
> 
> No. This is not entirely true.  While I don't like the idea of having to copy
> data (and I agree with your points) it is possible to do.

But now that I think about it, that's really going to be a PITA, and
probably more of a pain than if the two DAX flags are only loosely
coupled.

> > 
> > 	1. stopping the app.
> > 	2. stopping every other app using the filesystem
> > 	3. unmounting the filesystem
> > 	4. changing to dax=never mount option
> 
> I don't understand why we need to unmount and mount with dax=never?

I've realized that if you can /never/ clear FS_XFLAG_DAX from a file,
then the only way to force it off is dax=never (so the kernel ignores
it) or move the fs to a non-pmem storage (so the kernel doesn't even
try).

> > 	5. mounting the filesystem
> > 	6. restarting all apps.
> > 
> > It's a hard stop for everything using the filesystem, and it changes
> > the runtime environment for all applications, not just the one that
> > needs DAX turned off.  Not to mention that if it's the root
> > filesystem that is using DAX, then it's a full system reboot needed
> > to change the mount options.
> > 
> > IMO, this is a non-starter from a production point of view - testing
> > and qualification of all applications rather than just the affected
> > app is required to make this sort of change.  It simply does not
> > follow the "minimal change to fix the problem" rules for managing
> > issues in production environments.
> > 
> > So, pLease explain to me how this process:
> > 
> > 	1. stop the app
> > 	2. remove inode flags via xfs_io
> > 	3. run drop_caches
> > 	4. start the app
> > 
> > is worse than requiring admins to unmount the filesystem to turn off
> > DAX for an application.
> 
> Jan?  Christoph?

But you're right, this thing keeps swirling around and around and around
because we can't ever get to agreement on this.  Maybe I'll just become
XFS BOFH MAINTAINER and make a decision like this:

 1 Applications must call statx to discover the current S_DAX state.

 2 There exists an advisory file inode flag FS_XFLAG_DAX that is set based on
   the parent directory FS_XFLAG_DAX inode flag.  This advisory flag can be
   changed after file creation, but it does not immediately affect the S_DAX
   state.

   If FS_XFLAG_DAX is set and the fs is on pmem then it will enable S_DAX at
   inode load time; if FS_XFLAG_DAX is not set, it will not enable S_DAX.
   Unless overridden...

 3 There exists a dax= mount option.

   "-o dax=never" means "never set S_DAX, ignore FS_XFLAG_DAX"
   "-o dax=always" means "always set S_DAX (at least on pmem), ignore FS_XFLAG_DAX"
        "-o dax" by itself means "dax=always"
   "-o dax=iflag" means "follow FS_XFLAG_DAX" and is the default

 4 There exists an advisory directory inode flag FS_XFLAG_DAX that can be
   changed at any time.  The flag state is copied into any files or
   subdirectories when they are created within that directory.  If programs
   require file access runs in S_DAX mode, they must create those files
   inside a directory with FS_XFLAG_DAX set, or mount the fs with an
   appropriate dax mount option.

 5 Programs that require a specific file access mode (DAX or not DAX) must
   do one of the following:

   (a) create files in directories with the FS_XFLAG_DAX flag set as needed;

   (b) have the administrator set an override via mount option;

   (c) if they need to change a file's FS_XFLAG_DAX flag so that it does not
       match the S_DAX state (as reported by statx), they must cause the
       kernel to evict the inode from memory.  This can be done by:

       i>   closing the file;
       ii>  re-opening the file and using statx to see if the fs has
            changed the S_DAX flag;
       iii> if not, either unmount and remount the filesystem, or
            closing the file and using drop_caches.

 6 I no longer think it's too wild to require that users who want to
   squeeze every last bit of performance out of the particular rough and
   tumble bits of their storage also be exposed to the difficulties of
   what happens when the operating system can't totally virtualize those
   hardware capabilities.  Your high performance sports car is not a
   Toyota minivan, as it were.

I think (like Dave said) that if you set XFS_IDONTCACHE on the inode
when you change the DAX flag, the VFS will kill the inode the instant
the last user close()s the file.  Then 5.c.ii will actually work.

--D

> > 
> > > Furthermore, if we did want an interface like that why not allow
> > > the on-disk flag to be set as well as cleared?
> > 
> > Well, why not - it's why I implemented the flag in the first place!
> > The only problem we have here is how to safely change the in-memory
> > DAX state, and that largely has nothing to do with setting/clearing
> > the on-disk flag....
> 
> With the above change to xfs_diflags_to_iflags() I think we are ok here.
> 
> Ira
> 

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 237A615A14E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 07:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgBLGcH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 01:32:07 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:56104 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbgBLGcH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 01:32:07 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01C6OPW3107252;
        Wed, 12 Feb 2020 06:31:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=5WMJ1Q3DeCSL31QcnIpgj7xdaKkX+6JEsQwh3FsUT48=;
 b=SPifG9WX2btDg3L1I1un9XtSmCAAsI5tN+dZgQtijSxfPXOiV36zuowVFpLQXnnMdHWO
 kjFhYTW8Pb0yhaCyqWEUOdt3ke/d1S7kK90rPw4vt9TFm20Zwz7S5GQcQxAORfrchH2J
 UezsK55mO9aHfCnkZVZJPXns43gyBWvsurGr/pq/40qNL9dPtf/qttUg3JG48skrDMlt
 zrobvySP3l9sPgzzkU7pWe3JNGCcVwXPJPD8anzGBCnZYOUFA4ezEidrO5SpQWdoyyFk
 XHL4yaAZPW/mrLVL5B6IWqUrwdcz41Ifp2wGpOprPpu3LGTd/ba43Zv8/3v2ZoeaC+gK dw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2y2k8887ag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Feb 2020 06:31:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01C6N2hA134555;
        Wed, 12 Feb 2020 06:31:51 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2y26fjmrcs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Feb 2020 06:31:50 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01C6ViND022460;
        Wed, 12 Feb 2020 06:31:45 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Feb 2020 22:31:44 -0800
Date:   Tue, 11 Feb 2020 22:31:42 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 07/12] fs: Add locking for a dynamic DAX state
Message-ID: <20200212063142.GO6870@magnolia>
References: <20200208193445.27421-1-ira.weiny@intel.com>
 <20200208193445.27421-8-ira.weiny@intel.com>
 <20200211080035.GI10776@dread.disaster.area>
 <20200211201430.GE12866@iweiny-DESK2.sc.intel.com>
 <20200211214917.GO10776@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211214917.GO10776@dread.disaster.area>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9528 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002120049
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9528 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002120049
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 12, 2020 at 08:49:17AM +1100, Dave Chinner wrote:
> On Tue, Feb 11, 2020 at 12:14:31PM -0800, Ira Weiny wrote:
> > On Tue, Feb 11, 2020 at 07:00:35PM +1100, Dave Chinner wrote:
> > > On Sat, Feb 08, 2020 at 11:34:40AM -0800, ira.weiny@intel.com wrote:
> > > > From: Ira Weiny <ira.weiny@intel.com>
> > > > 
> > > > DAX requires special address space operations but many other functions
> > > > check the IS_DAX() state.
> > > > 
> > > > While DAX is a property of the inode we perfer a lock at the super block
> > > > level because of the overhead of a rwsem within the inode.
> > > > 
> > > > Define a vfs per superblock percpu rs semaphore to lock the DAX state
> > > 
> > > ????
> > 
> > oops...  I must have forgotten to update the commit message when I did the
> > global RW sem.  I implemented the per-SB, percpu rwsem first but it was
> > suggested that the percpu nature of the lock combined with the anticipated
> > infrequent use of the write side made using a global easier.
> > 
> > But before I proceed on V4 I'd like to get consensus on which of the 2 locking
> > models to go with.
> > 
> > 	1) percpu per superblock lock
> > 	2) per inode rwsem
> > 
> > Depending on my mood I can convince myself of both being performant but the
> > percpu is very attractive because I don't anticipate many changes of state
> > during run time.  OTOH concurrent threads accessing the same file at run time
> > may also be low so there is likely to be little read contention across CPU's on
> > the per-inode lock?
> > 
> > Opinions?
> > 
> > > 
> > > > while performing various VFS layer operations.  Write lock calls are
> > > > provided here but are used in subsequent patches by the file systems
> > > > themselves.
> > > > 
> > > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > > 
> > > > ---
> > > > Changes from V2
> > > > 
> > > > 	Rebase on linux-next-08-02-2020
> > > > 
> > > > 	Fix locking order
> > > > 	Change all references from mode to state where appropriate
> > > > 	add CONFIG_FS_DAX requirement for state change
> > > > 	Use a static branch to enable locking only when a dax capable
> > > > 		device has been seen.
> > > > 
> > > > 	Move the lock to a global vfs lock
> > > > 
> > > > 		this does a few things
> > > > 			1) preps us better for ext4 support
> > > > 			2) removes funky callbacks from inode ops
> > > > 			3) remove complexity from XFS and probably from
> > > > 			   ext4 later
> > > > 
> > > > 		We can do this because
> > > > 			1) the locking order is required to be at the
> > > > 			   highest level anyway, so why complicate xfs
> > > > 			2) We had to move the sem to the super_block
> > > > 			   because it is too heavy for the inode.
> > > > 			3) After internal discussions with Dan we
> > > > 			   decided that this would be easier, just as
> > > > 			   performant, and with slightly less overhead
> > > > 			   than in the VFS SB.
> > > > 
> > > > 		We also change the functions names to up/down;
> > > > 		read/write as appropriate.  Previous names were over
> > > > 		simplified.
> > > 
> > > This, IMO, is a bit of a train wreck.
> > > 
> > > This patch has nothing to do with "DAX state", it's about
> > > serialising access to the aops vector.
> > 
> > It is a bit more than just the aops vector.  It also has to protect against
> > checks of IS_DAX() which occur through many of the file operations.
> 
> I think you are looking at this incorrectly. The IS_DAX() construct
> is just determining what path to the aops method we take. regardless
> of whether IS_DAX() is true or not, we need to execute an aop
> method, and so aops vector protection is required regardless of how
> IS_DAX() evaluates.
> 
> But we do require IS_DAX() to evaluate consistently through an
> entire aops protected region, as there may be multiple aops method
> calls in a aops context (e.g. write page faults). Hence we have to
> ensure that IS_DAX() changes atomically w.r.t. to the aops vector
> switches. This is simply:
> 
> 	sb_aops_lock()
> 	inode->i_flags |= S_DAX
> 	sb_aops_switch(new_aops)
> 	sb_aops_unlock().
> 
> This guarantees that inside sb_aops_start/end(), IS_DAX() checks
> are stable because we change the state atomically with the aops
> vector.
> 
> We are *not* providing serialisation of inode->i_flags access or
> updates here; all we need to do is ensure that the S_DAX flag is
> consistent and stable across an aops access region.  If we are not
> in an aops call chain or will not call an aops method, we just don't
> care if the IS_DAX() call is racy as whatever we call is still
> static and if it's DAAX sensitive it can call IS_DAX() itself when
> needed.
> 
> Again, this isn't about DAX at all, it's about being able to switch
> aops vectors in a safe and reliable manner. The IS_DAX() constraints
> are really a minor addition on top of the "stable aops vector"
> regions we are laying down here.
> 
> 
> > > Big problems I see here:
> > > 
> > > 1. static key to turn it on globally.
> > >   - just a gross hack around doing it properly with a per-sb
> > >     mechanism and enbaling it only on filesystems that are on DAX
> > >     capable block devices.
> > 
> > Fair enough.  This was a reaction to Darricks desire to get this out of the way
> > when DAX was not in the system.  The static branch seemed like a good thing for
> > users who don't have DAX capable hardware while running kernels and FS's which
> > have DAX enabled.
> > 
> > http://lkml.iu.edu/hypermail/linux/kernel/2001.1/05691.html
> 
> I think that's largely premature optimisation, and it backs us into
> the "all or nothing" corner which is a bad place to be for what is
> per-filesystem functionality.

Oh, wow, uh... this was a total misunderstanding.  Having a per-inode
primitive to grant ourselves the ability to change fops/aops safely was
fine, I just wanted to have it compile out of existence if CONFIG_DAX=n
(or some other cleverish way if this mount will never support DAX (e.g.
scsi disk)).  I wasn't asking for it to move to the superblock or become
a Big Kernel Primitive.

--D

> 
> > >   - you're already passing in an inode to all these functions. It's
> > >     trivial to do:
> > > 
> > > 	if (!inode->i_sb->s_flags & S_DYNAMIC_AOPS)
> > > 		return
> > > 	/* do sb->s_aops_lock manipulation */
> > 
> > Yea that would be ok IMO.
> > 
> > Darrick would just having this be CONFIG_FS_DAX as per this patch be ok with
> > you.  I guess the static key may have been a bit of overkill?
> > 
> > > 
> > > 2. global lock
> > >   - OMG!
> > 
> > I know.  The thinking on this is that the locking is percpu which is near
> > 0 overhead in the read case and we are rarely going to take exclusive access.
> 
> The problem is that users can effectively run:
> 
> $ xfs_io -c "chattr -R -D -x" /path/to/dax_fs
> 
> And then it walks over millions of individual inodes turning off
> the DAX flag on each of them. And if each of those inodes takes a
> global per-cpu rwsem that blocks all read/write IO and page faults
> on everything even for a short time, then this is will have a major
> impact on the entire system and users will be very unhappy.
> 
> > >   - global lock will cause entire system IO/page fault stalls
> > >     when someone does recursive/bulk DAX flag modification
> > >     operations. Per-cpu rwsem Contention on  large systems will be
> > >     utterly awful.
> > 
> > Yea that is probably bad...  I certainly did not test the responsiveness of
> > this.  FWIW if the system only has 1 FS the per-SB lock is not going to be any
> > different from the global which was part of our thinking.
> 
> Don't forget that things like /proc, /sys, etc are all filesystems.
> Hence the global lock will affect accesses to -everything- in the
> system, not just the DAX enabled filesystem. Global locks are -bad-.
> 
> > >   - ext4's use case almost never hits the exclusive lock side of the
> > >     percpu-rwsem - only when changing the journal mode flag on the
> > >     inode. And it only affects writeback in progress, so it's not
> > >     going to have massive concurrency on it like a VFS level global
> > >     lock has. -> Bad model to follow.
> > 
> > I admit I did not research the ext4's journal mode locking that much.
> > 
> > >   - per-sb lock is trivial - see #1 - which limits scope to single
> > >     filesystem
> > 
> > I agree and...  well the commit message shows I actually implemented it that
> > way at first...  :-/
> > 
> > >   - per-inode rwsem would make this problem go away entirely.
> > 
> > But would that be ok for concurrent read performance which is going to be used
> > 99.99% of the time?  Maybe Darricks comments made me panic a little bit too
> > much overhead WRT locking and its potential impact on users not using DAX?
> 
> I know that a rwsem in shared mode can easily handle 2M lock
> cycles/s across a 32p machine without contention (concurrent AIO-DIO
> read/writes to a single file) so the baseline performance of a rwsem
> is likely good enough to start from.
> 
> It's simple, and we can run tests easily enough to find out where it
> starts to become a performance limitation. This whole "global percpu
> rwsem thing stinks like premature optimisation. Do the simple,
> straight forward thing first, then get numbers and analysis the
> limitations to determine what the second generation of the
> functionality needs to fix.
> 
> IMO, we don't have to solve every scalability problem with the
> initial implementation. Let's just make it work first, then worry
> about extreme scalability when we have some idea of where those
> scalability problems are.
> 
> > > 3. If we can use a global per-cpu rwsem, why can't we just use a
> > >    per-inode rwsem?
> > 
> > Per-cpu lock was attractive because of its near 0 overhead to take the read
> > lock which happens a lot during normal operations.
> > 
> > >   - locking context rules are the same
> > >   - rwsem scales pretty damn well for shared ops
> > 
> > Does it?  I'm not sure.
> 
> If you haven't tested it, then we are definitely in the realm of
> premature optimisation...
> 
> > 
> > >   - no "global" contention problems
> > >   - small enough that we can put another rwsem in the inode.
> > 
> > Everything else I agree with...  :-D
> > 
> > > 
> > > 4. "inode_dax_state_up_read"
> > >   - Eye bleeds.
> > >   - this is about the aops structure serialisation, not dax.
> > >   - The name makes no sense in the places that it has been added.
> > 
> > Again it is about more than just the aops.  IS_DAX() needs to be protected in
> > all the file operations calls as well or we can get races with the logic in
> > those calls and a state switch.
> > 
> > > 
> > > 5. We already have code that does almost exactly what we need: the
> > >    superblock freezing infrastructure.
> > 
> > I think freeze does a lot more than we need.
> > 
> > >   - freezing implements a "hold operations on this superblock until
> > >     further notice" model we can easily follow.
> > >   - sb_start_write/sb_end_write provides a simple API model and a
> > >     clean, clear and concise naming convention we can use, too.
> > 
> > Ok as a model...  If going with the per-SB lock.
> 
> Ok, you completely missed my point. You're still looking at this as
> a set of "locks" and serialisation.
> 
> Freezing is *not a lock* - it provides a series of "drain points"
> where we can transparently block new operations, then wait for all
> existing operations to complete so we can make a state change, and
> then once that is done we unblock all the waiters....
> 
> IOWs, the freeze model provides an ordered barrier mechanism, and
> that's precisely what we need for aops protection...
> 
> Yes, it may be implemented with locks internally, but that's
> implementation detail of the barrier mechanism, not an indication
> what functionality it is actually providing.
> 
> > After working through my
> > response I'm leaning toward a per-inode lock again.  This was the way I did
> > this to begin with.
> > 
> > I want feedback before reworking for V4, please.
> 
> IMO, always do the simple thing first.
> 
> Only do a more complex thing if the simple thing doesn't work or
> doesn't perform sufficiently well for an initial implemenation.
> Otherwise we end up with crazy solutions from premature optimisation
> that simply aren't viable.
> 
> > > Really, I'm struggling to understand how we got to "global locking
> > > that stops the world" from "need to change per-inode state
> > > atomically". Can someone please explain to me why this patch isn't
> > > just a simple set of largely self-explanitory functions like this:
> > > 
> > > XX_start_aop()
> > > XX_end_aop()
> > > 
> > > XX_lock_aops()
> > > XX_switch_aops(aops)
> > > XX_unlock_aops()
> > > 
> > > where "XX" is "sb" or "inode" depending on what locking granularity
> > > is used...
> > 
> > Because failing to protect the logic around IS_DAX() results in failures in the
> > read/write and direct IO paths.
> > 
> > So we need to lock the file operations as well.
> 
> Again, there is no "locking" here. We just need to annotate regions
> where the aops vector must remain stable. If a fop calls an aop that
> the aops vector does not change while it is the middle of executing
> the fop. Hence such fops calls will need to be inside
> XX_start_aop()/XX_end_aop() markers.
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com

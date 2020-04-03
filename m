Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0926219DDEE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 20:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbgDCS3W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 14:29:22 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44836 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbgDCS3W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 14:29:22 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033IRcjR090531;
        Fri, 3 Apr 2020 18:29:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=6q5a+uM2h8GBpnd8aFmiiHcoQVWCiKL86M3lyVkse0g=;
 b=WgJzVzb+eAzaxmjp962YgoFzGTo7hxB0HRM/FQeMInHx4gzoocjTYTM042h00unA4hu4
 1NRv0Cre9pcxjwZcZEV0Ga3MygwpUaMsIOgUDLTvSTEMdwtNXOq9BHF6lG0HjJx1fD00
 zk1j27Gib71ASTBZxSu2aFGcQuS6weucX/WuG/1BAvIvrRgZJekYG9tXXxMXXi4WAWdH
 gewtTgOH9ebW4/wYvkII/2/2aWHzSEvZxkkhWDrqdt9K+gEkQEgonVolFQHNlNeJEEEc
 ScYFzw9CQ7qcVW7Tc8tKj+jw6TXG2uDm7gXUsXhkPLO55K+pL4xMAWY9OpjDVVpkLl2j qA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 303cevjkwm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 18:29:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033ISOqr169206;
        Fri, 3 Apr 2020 18:29:10 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 302g4xy0hm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 18:29:09 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 033IT7WN008832;
        Fri, 3 Apr 2020 18:29:08 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 Apr 2020 11:29:06 -0700
Date:   Fri, 3 Apr 2020 11:29:04 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>,
        Dave Chinner <david@fromorbit.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH V5 00/12] Enable per-file/per-directory DAX operations V5
Message-ID: <20200403182904.GP80283@magnolia>
References: <CAPcyv4h9Xg61jk=Uq17xC6AGj9yOSAJnCaTzHcfBZwOVdRF9dw@mail.gmail.com>
 <20200316095224.GF12783@quack2.suse.cz>
 <20200316095509.GA13788@lst.de>
 <20200401040021.GC56958@magnolia>
 <20200401102511.GC19466@quack2.suse.cz>
 <20200402085327.GA19109@lst.de>
 <20200402205518.GF3952565@iweiny-DESK2.sc.intel.com>
 <20200403072731.GA24176@lst.de>
 <20200403154828.GJ3952565@iweiny-DESK2.sc.intel.com>
 <20200403170338.GD29920@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403170338.GD29920@quack2.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9580 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030151
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9580 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030151
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 03, 2020 at 07:03:38PM +0200, Jan Kara wrote:
> On Fri 03-04-20 08:48:29, Ira Weiny wrote:
> > On Fri, Apr 03, 2020 at 09:27:31AM +0200, Christoph Hellwig wrote:
> > > On Thu, Apr 02, 2020 at 01:55:19PM -0700, Ira Weiny wrote:
> > > > > I'd just return an error for that case, don't play silly games like
> > > > > evicting the inode.
> > > > 
> > > > I think I agree with Christoph here.  But I want to clarify.  I was heading in
> > > > a direction of failing the ioctl completely.  But we could have the flag change
> > > > with an appropriate error which could let the user know the change has been
> > > > delayed.
> > > > 
> > > > But I don't immediately see what error code is appropriate for such an
> > > > indication.  Candidates I can envision:
> > > > 
> > > > EAGAIN
> > > > ERESTART
> > > > EUSERS
> > > > EINPROGRESS
> > > > 
> > > > None are perfect but I'm leaning toward EINPROGRESS.
> > > 
> > > I really, really dislike that idea.  The whole point of not forcing
> > > evictions is to make it clear - no this inode is "busy" you can't
> > > do that.  A reasonably smart application can try to evict itself.
> > 
> > I don't understand.  What Darrick proposed would never need any
> > evictions.  If the file has blocks allocated the FS_XFLAG_DAX flag can
> > not be changed.  So I don't see what good eviction would do at all.
> 
> I guess there's some confusion here (may well be than on my side). Darrick
> propose that we can switch FS_XFLAG_DAX only when file has no blocks
> allocated - fine by me. But that still does not mean than we can switch
> S_DAX immediately, does it? Because that would still mean we need to switch
> aops on living inode and that's ... difficult and Christoph didn't want to
> clutter the code with it.

IIRC, the reason Ira was trying to introduce this file operations lock
is because there isn't any other safe way to change the operations
dynamically, because some of those operations don't start taking any
locks at all until after we've accessed the file operations pointer.

Now that I think about it some more, that's also means we can't change
S_DAX even on files without blocks allocated.  Look at fallocate, it
doesn't even take i_rwsem until we've called into (say)
xfs_file_fallocate.

Ok, so with that in mind, I think we simply have to say that
FS_XFLAG_DAX is 100% advisory, and S_DAX will magically switch some time
in the future or after the next umount/mount cycle.

FSSETXATTR can't evict an inode it has just set FS_XFLAG_DAX on, because
it applies that change to the fd passed into ioctl(), which means that the
caller has a reference to the fd -> file -> inode, which means the inode
is unevictable until after the call completes.

IOWs, 

> So I've understood Darrick's proposal as: Just switch FS_XFLAG_DAX flag,
> S_DAX flag will magically switch when inode gets evicted and the inode gets
> reloaded from the disk again. Did I misunderstand anything?

That was /my/ understanding. :)

> And my thinking was that this is surprising behavior for the user and so it
> will likely generate lots of bug reports along the lines of "DAX inode flag
> does not work!". So I was pondering how to make the behavior less
> confusing... The ioctl I've suggested was just a poor attempt at that.

At best, userspace uses FSSETXATTR to change FS_XFLAG_DAX, and then
calls some as-yet-undefined ioctl to try to evict the inode from memory.
I'm not sure how you'd actually do that, though, considering that you'd
have to close the fd and as soon as that happens the inode can disappear
permanently.

Ok, that's not sane.  Forget I ever wrote that.

> > > But returning an error and doing a lazy change anyway is straight from
> > > the playbook for arcane and confusing API designs.
> > 
> > Jan countered with a proposal that the FS_XFLAG_DAX does change with
> > blocks allocated.  But that S_DAX would change on eviction.  Adding that
> > some eviction ioctl could be added.
> 
> No, I didn't mean that we can change FS_XFLAG_DAX with blocks allocated. I
> was still speaking about the case without blocks allocated.
> 
> > You then proposed just returning an error for that case.  (This lead me to
> > believe that you were ok with an eviction based change of S_DAX.)
> > 
> > So I agreed that changing S_DAX could be delayed until an explicit eviction.
> > But, to aid the 'smart application', a different error code could be used to
> > indicate that the FS_XFLAG_DAX had been changed but that until that explicit
> > eviction occurs S_DAX would remain.

There's no point in returning a magic error code from FSSETXATTR, as I
realized above.  To restate: FSSETXATTR can't evict the inode, so it
would always have to return the magic error code.  The best we can do is
tell userspace that they can set the advisory FS_XFLAG_DAX flag and then
check STATX_ATTR_DAX immediately afterwards.  If some day in the future
we get smarter and can change it immediately, the statx output will
reflect that.

> > So I don't fully follow what you mean by 'lazy change'?
> > 
> > Do you still really, really dislike an explicit eviction method for changing
> > the S_DAX flag?
> > 
> > If FS_XFLAG_DAX can never be changed on a file with blocks allocated and the
> > user wants to change the mode of operations on their 'data'; they would have to
> > create a new file with the proper setting and move the data there.  For example
> > copy the file into a directory marked FS_XFLAG_DAX==true?
> > 
> > I'm ok with either interface as I think both could be clear if documented.
> 
> I agree that what Darrick suggested is technically easily doable and can be
> documented. But it is not natural behavior (i.e., different than all inode
> flags we have) and we know how careful people are when reading
> documentation...

To reflect all that I've rambled in this thread, I withdraw the previous
paragraph and submit this one for consideration:

 - There exists an advisory file inode flag FS_XFLAG_DAX.

   If FS_XFLAG_DAX is set and the fs is on pmem then it will always
   enable S_DAX at inode load time; if FS_XFLAG_DAX is not set, it will
   never enable S_DAX.  The advice can be overridden by mount option.

   Changing this flag does not necessarily change the S_DAX state
   immediately but programs can query the S_DAX state via statx to
   detect when the new advice has gone into effect.

Consider this from the perspective of minimizing changes to userspace
programs between now and the future.  If your program really wants
S_DAX, you can write:

	fd = open(...);

	ioctl(fd, FSGETXATTR, &fsx);

	if (fsx.xflags & FS_XFLAG_DAX)
		return 0;

	fsx.xflags |= FS_XFLAG_DAX;
	ioctl(fd, FSSETXATTR, &fsx);

	do {
		statx(fd, STATX_GIVE_ME_EVERYTHING, &statx);
		if (statx.attrs & STATX_ATTR_DAX)
			return 0;

		/* do stupid magic to evict things */
	} while (we haven't gotten bored and wandered away);

This code snippet will work with the current limitations of the kernel,
and it'll continue working even on Linux v5000 where we finally figure
out how to change S_DAX on the fly.

--D

> 
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

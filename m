Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2766F37FA7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 17:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234832AbhEMPUg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 May 2021 11:20:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:38970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234810AbhEMPUd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 May 2021 11:20:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87C9C61106;
        Thu, 13 May 2021 15:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620919163;
        bh=BUZ30lLjjIMg6FA/ECXLblTKPPXuRiAZOzq081unShI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ASsYgx5ZYR7/vyvthS/NOsgw7IMrO74Fcvarf1E7UjuqcI5K9Y/bLi+BUrMB/qKIq
         DIl5C6e/odjdokZuG844AjXkiBuV9CM0HC26BuQZ1AQiDtHDGwcHt+cFV2FPQcMgBL
         K4cSyAjAXFnICQoxh2GFklzTmtxprua84sdLH0L8=
Date:   Thu, 13 May 2021 17:19:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ian Kent <raven@themaw.net>
Cc:     Tejun Heo <tj@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Eric Sandeen <sandeen@sandeen.net>,
        Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/5] kernfs: proposed locking and concurrency
 improvement
Message-ID: <YJ1DeXnKTxuy6uc9@kroah.com>
References: <162077975380.14498.11347675368470436331.stgit@web.messagingengine.com>
 <YJtz6mmgPIwEQNgD@kroah.com>
 <152abd1fea6ae3887febdb16263ebecfcf0d4341.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <152abd1fea6ae3887febdb16263ebecfcf0d4341.camel@themaw.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 13, 2021 at 09:50:19PM +0800, Ian Kent wrote:
> On Wed, 2021-05-12 at 08:21 +0200, Greg Kroah-Hartman wrote:
> > On Wed, May 12, 2021 at 08:38:35AM +0800, Ian Kent wrote:
> > > There have been a few instances of contention on the kernfs_mutex
> > > during
> > > path walks, a case on very large IBM systems seen by myself, a
> > > report by
> > > Brice Goglin and followed up by Fox Chen, and I've since seen a
> > > couple
> > > of other reports by CoreOS users.
> > > 
> > > The common thread is a large number of kernfs path walks leading to
> > > slowness of path walks due to kernfs_mutex contention.
> > > 
> > > The problem being that changes to the VFS over some time have
> > > increased
> > > it's concurrency capabilities to an extent that kernfs's use of a
> > > mutex
> > > is no longer appropriate. There's also an issue of walks for non-
> > > existent
> > > paths causing contention if there are quite a few of them which is
> > > a less
> > > common problem.
> > > 
> > > This patch series is relatively straight forward.
> > > 
> > > All it does is add the ability to take advantage of VFS negative
> > > dentry
> > > caching to avoid needless dentry alloc/free cycles for lookups of
> > > paths
> > > that don't exit and change the kernfs_mutex to a read/write
> > > semaphore.
> > > 
> > > The patch that tried to stay in VFS rcu-walk mode during path walks
> > > has
> > > been dropped for two reasons. First, it doesn't actually give very
> > > much
> > > improvement and, second, if there's a place where mistakes could go
> > > unnoticed it would be in that path. This makes the patch series
> > > simpler
> > > to review and reduces the likelihood of problems going unnoticed
> > > and
> > > popping up later.
> > > 
> > > The patch to use a revision to identify if a directory has changed
> > > has
> > > also been dropped. If the directory has changed the dentry revision
> > > needs to be updated to avoid subsequent rb tree searches and after
> > > changing to use a read/write semaphore the update also requires a
> > > lock.
> > > But the d_lock is the only lock available at this point which might
> > > itself be contended.
> > > 
> > > Changes since v3:
> > > - remove unneeded indirection when referencing the super block.
> > > - check if inode attribute update is actually needed.
> > > 
> > > Changes since v2:
> > > - actually fix the inode attribute update locking.
> > > - drop the patch that tried to stay in rcu-walk mode.
> > > - drop the use a revision to identify if a directory has changed
> > > patch.
> > > 
> > > Changes since v1:
> > > - fix locking in .permission() and .getattr() by re-factoring the
> > > attribute
> > >   handling code.
> > > ---
> > > 
> > > Ian Kent (5):
> > >       kernfs: move revalidate to be near lookup
> > >       kernfs: use VFS negative dentry caching
> > >       kernfs: switch kernfs to use an rwsem
> > >       kernfs: use i_lock to protect concurrent inode updates
> > >       kernfs: add kernfs_need_inode_refresh()
> > > 
> > > 
> > >  fs/kernfs/dir.c             | 170 ++++++++++++++++++++------------
> > > ----
> > >  fs/kernfs/file.c            |   4 +-
> > >  fs/kernfs/inode.c           |  45 ++++++++--
> > >  fs/kernfs/kernfs-internal.h |   5 +-
> > >  fs/kernfs/mount.c           |  12 +--
> > >  fs/kernfs/symlink.c         |   4 +-
> > >  include/linux/kernfs.h      |   2 +-
> > >  7 files changed, 147 insertions(+), 95 deletions(-)
> > > 
> > > --
> > > Ian
> > > 
> > 
> > Any benchmark numbers that you ran that are better/worse with this
> > patch
> > series?  That woul dbe good to know, otherwise you aren't changing
> > functionality here, so why would we take these changes?  :)
> 
> Hi Greg,
> 
> I'm sorry, I don't have a benchmark.
> 
> My continued work on this has been driven by the report from
> Brice Goglin and Fox Chen, and also because I've seen a couple
> of other reports of kernfs_mutex contention that is resolved
> by the series.
> 
> Unfortunately the two reports I've seen fairly recently are on
> kernels that are about as far away from the upstream kernel
> as you can get so probably aren't useful in making my case.
> 
> The report I've worked on most recently is on CoreOS/Kunbernetes
> (based on RHEL-8.3) where the machine load goes to around 870
> after loading what they call an OpenShift performance profile.
> 
> I looked at some sysreq dumps and they have a seemingly endless
> number of processes waiting on the kernfs_mutex.
> 
> I tried to look at the Kubernetes source but it's written in
> go so there would need to be a lot of time spent to work out
> what's going on, I'm trying to find someone to help with that.
> 
> All I can say from looking at the Kubernetes source is it has
> quite a few sysfs paths in it so I assume it uses sysfs fairly
> heavily.
> 
> The other problem I saw was also on CoreOS/Kunernetes.
> A vmcore analysis showed kernfs_mutex contention but with a
> different set of processes and not as significant as the former
> problem.
> 
> So, even though this isn't against the current upstream, there
> isn't much difference in the kernfs/sysfs source between those
> two kernels and given the results of Brice and Fox I fear I'll
> be seeing more of this as time goes by.
> 
> I'm fairly confident that the user space applications aren't
> optimal (although you may have stronger words for it than that)
> I was hoping you would agree that it's sensible for the kernel
> to protect itself to the extent that it can provided the change
> is straight forward enough.
> 
> I have tried to make the patches as simple as possible without
> loosing much of the improvement to minimize any potential ongoing
> maintenance burden.
> 
> So, I'm sorry I can't offer you more incentive to consider the
> series, but I remain hopeful you will.

At the very least, if you could test the series on those "older" systems
and say "booting went from X seconds to Y seconds!".

Otherwise, while changes are nice, without a real-world test that this
actually made any difference at all, why would we take these changes?

thanks,

greg k-h

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F54746A68A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Dec 2021 21:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245430AbhLFUJK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Dec 2021 15:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbhLFUJJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Dec 2021 15:09:09 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D74C061746;
        Mon,  6 Dec 2021 12:05:41 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 533FD6C93; Mon,  6 Dec 2021 15:05:40 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 533FD6C93
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1638821140;
        bh=8zBCh7jqozPC64s+vsiNFZuX20K//Ux2ms5saghZ8Fo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S65JMG2zhsmVY+NTIGBHCp3LT3KURVXtPqPbwa1FHjtA/FVqWi6ADUeit3dlOHBar
         P6VMO7oHUN0qTZLh4uqZTPHn2dKbAy+HvMFdQmLyiukno+5oqLJ3uz0Q5WLqnL2Qrd
         j/+IP/xEwjDSuQrdlUT4WcpH6of425sku4fziBk0=
Date:   Mon, 6 Dec 2021 15:05:40 -0500
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "jlayton@redhat.com" <jlayton@redhat.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "dai.ngo@oracle.com" <dai.ngo@oracle.com>
Subject: Re: [PATCH RFC v6 1/2] fs/lock: add new callback, lm_expire_lock, to
 lock_manager_operations
Message-ID: <20211206200540.GD20244@fieldses.org>
References: <20211206175942.47326-1-dai.ngo@oracle.com>
 <20211206175942.47326-2-dai.ngo@oracle.com>
 <133AE467-0990-469D-A8A9-497C1C1BD09A@oracle.com>
 <254f1d07c02a5b39d8b7743af4ceb9b5f69e4e07.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <254f1d07c02a5b39d8b7743af4ceb9b5f69e4e07.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 06, 2021 at 07:52:29PM +0000, Trond Myklebust wrote:
> On Mon, 2021-12-06 at 18:39 +0000, Chuck Lever III wrote:
> > 
> > 
> > > On Dec 6, 2021, at 12:59 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
> > > 
> > > Add new callback, lm_expire_lock, to lock_manager_operations to
> > > allow
> > > the lock manager to take appropriate action to resolve the lock
> > > conflict
> > > if possible. The callback takes 2 arguments, file_lock of the
> > > blocker
> > > and a testonly flag:
> > > 
> > > testonly = 1  check and return true if lock conflict can be
> > > resolved
> > >              else return false.
> > > testonly = 0  resolve the conflict if possible, return true if
> > > conflict
> > >              was resolved esle return false.
> > > 
> > > Lock manager, such as NFSv4 courteous server, uses this callback to
> > > resolve conflict by destroying lock owner, or the NFSv4 courtesy
> > > client
> > > (client that has expired but allowed to maintains its states) that
> > > owns
> > > the lock.
> > > 
> > > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > 
> > Al, Jeff, as co-maintainers of record for fs/locks.c, can you give
> > an Ack or Reviewed-by? I'd like to take this patch through the nfsd
> > tree for v5.17. Thanks for your time!
> > 
> > 
> > > ---
> > > fs/locks.c         | 28 +++++++++++++++++++++++++---
> > > include/linux/fs.h |  1 +
> > > 2 files changed, 26 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/fs/locks.c b/fs/locks.c
> > > index 3d6fb4ae847b..0fef0a6322c7 100644
> > > --- a/fs/locks.c
> > > +++ b/fs/locks.c
> > > @@ -954,6 +954,7 @@ posix_test_lock(struct file *filp, struct
> > > file_lock *fl)
> > >         struct file_lock *cfl;
> > >         struct file_lock_context *ctx;
> > >         struct inode *inode = locks_inode(filp);
> > > +       bool ret;
> > > 
> > >         ctx = smp_load_acquire(&inode->i_flctx);
> > >         if (!ctx || list_empty_careful(&ctx->flc_posix)) {
> > > @@ -962,11 +963,20 @@ posix_test_lock(struct file *filp, struct
> > > file_lock *fl)
> > >         }
> > > 
> > >         spin_lock(&ctx->flc_lock);
> > > +retry:
> > >         list_for_each_entry(cfl, &ctx->flc_posix, fl_list) {
> > > -               if (posix_locks_conflict(fl, cfl)) {
> > > -                       locks_copy_conflock(fl, cfl);
> > > -                       goto out;
> > > +               if (!posix_locks_conflict(fl, cfl))
> > > +                       continue;
> > > +               if (cfl->fl_lmops && cfl->fl_lmops->lm_expire_lock
> > > &&
> > > +                               cfl->fl_lmops->lm_expire_lock(cfl,
> > > 1)) {
> > > +                       spin_unlock(&ctx->flc_lock);
> > > +                       ret = cfl->fl_lmops->lm_expire_lock(cfl,
> > > 0);
> > > +                       spin_lock(&ctx->flc_lock);
> > > +                       if (ret)
> > > +                               goto retry;
> > >                 }
> > > +               locks_copy_conflock(fl, cfl);
> 
> How do you know 'cfl' still points to a valid object after you've
> dropped the spin lock that was protecting the list?

Ugh, good point, I should have noticed that when I suggested this
approach....

Maybe the first call could instead return return some reference-counted
object that a second call could wait on.

Better, maybe it could add itself to a list of such things and then we
could do this in one pass.

--b.

> 
> > > +               goto out;
> > >         }
> > >         fl->fl_type = F_UNLCK;
> > > out:
> > > @@ -1140,6 +1150,7 @@ static int posix_lock_inode(struct inode
> > > *inode, struct file_lock *request,
> > >         int error;
> > >         bool added = false;
> > >         LIST_HEAD(dispose);
> > > +       bool ret;
> > > 
> > >         ctx = locks_get_lock_context(inode, request->fl_type);
> > >         if (!ctx)
> > > @@ -1166,9 +1177,20 @@ static int posix_lock_inode(struct inode
> > > *inode, struct file_lock *request,
> > >          * blocker's list of waiters and the global blocked_hash.
> > >          */
> > >         if (request->fl_type != F_UNLCK) {
> > > +retry:
> > >                 list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
> > >                         if (!posix_locks_conflict(request, fl))
> > >                                 continue;
> > > +                       if (fl->fl_lmops && fl->fl_lmops-
> > > >lm_expire_lock &&
> > > +                                       fl->fl_lmops-
> > > >lm_expire_lock(fl, 1)) {
> > > +                               spin_unlock(&ctx->flc_lock);
> > > +                               percpu_up_read(&file_rwsem);
> > > +                               ret = fl->fl_lmops-
> > > >lm_expire_lock(fl, 0);
> > > +                               percpu_down_read(&file_rwsem);
> > > +                               spin_lock(&ctx->flc_lock);
> > > +                               if (ret)
> > > +                                       goto retry;
> > > +                       }
> 
> ditto.
> 
> > >                         if (conflock)
> > >                                 locks_copy_conflock(conflock, fl);
> > >                         error = -EAGAIN;
> > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > index e7a633353fd2..1a76b6451398 100644
> > > --- a/include/linux/fs.h
> > > +++ b/include/linux/fs.h
> > > @@ -1071,6 +1071,7 @@ struct lock_manager_operations {
> > >         int (*lm_change)(struct file_lock *, int, struct list_head
> > > *);
> > >         void (*lm_setup)(struct file_lock *, void **);
> > >         bool (*lm_breaker_owns_lease)(struct file_lock *);
> > > +       bool (*lm_expire_lock)(struct file_lock *fl, bool
> > > testonly);
> > > };
> > > 
> > > struct lock_manager {
> > > -- 
> > > 2.9.5
> > > 
> > 
> > --
> > Chuck Lever
> > 
> > 
> > 
> 
> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
> 
> 

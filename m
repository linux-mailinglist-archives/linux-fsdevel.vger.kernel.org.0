Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A2A51598D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Apr 2022 03:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381991AbiD3BVw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 21:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381989AbiD3BVr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 21:21:47 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C460BD3DB1;
        Fri, 29 Apr 2022 18:18:26 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 3D8CC707A; Fri, 29 Apr 2022 21:18:26 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 3D8CC707A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1651281506;
        bh=WvIZySk1Jmkj9VnGx+Kv1+9vjlrfFuubfmrOZNOe6bg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=apq9r0DooDuV9cBg7AVDl+vzUoDsflcIYiNkDgb5iZKiQTaNVT4gSYiOPe+jsEtPL
         gtaGeLZ5vtSk7wzZGvuVLMC4S3uyHSoNxtOu4RJ2qjjoM39N9CynQ+kgS6OGMB4OW5
         hKLN+1QMGB5b6C1ZvRvQoSXJYFy1W/jEi7JN+yxw=
Date:   Fri, 29 Apr 2022 21:18:26 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v23 5/7] fs/lock: add 2 callbacks to
 lock_manager_operations to resolve conflict
Message-ID: <20220430011826.GA14842@fieldses.org>
References: <1651129595-6904-1-git-send-email-dai.ngo@oracle.com>
 <1651129595-6904-6-git-send-email-dai.ngo@oracle.com>
 <20220429151618.GF7107@fieldses.org>
 <862e6f3c-fb59-33e0-a6ea-7a67c93cfb20@oracle.com>
 <20220429195819.GI7107@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429195819.GI7107@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 29, 2022 at 03:58:19PM -0400, J. Bruce Fields wrote:
> On Fri, Apr 29, 2022 at 10:24:11AM -0700, dai.ngo@oracle.com wrote:
> > 
> > On 4/29/22 8:16 AM, J. Bruce Fields wrote:
> > >On Thu, Apr 28, 2022 at 12:06:33AM -0700, Dai Ngo wrote:
> > >>Add 2 new callbacks, lm_lock_expirable and lm_expire_lock, to
> > >>lock_manager_operations to allow the lock manager to take appropriate
> > >>action to resolve the lock conflict if possible.
> > >>
> > >>A new field, lm_mod_owner, is also added to lock_manager_operations.
> > >>The lm_mod_owner is used by the fs/lock code to make sure the lock
> > >>manager module such as nfsd, is not freed while lock conflict is being
> > >>resolved.
> > >>
> > >>lm_lock_expirable checks and returns true to indicate that the lock
> > >>conflict can be resolved else return false. This callback must be
> > >>called with the flc_lock held so it can not block.
> > >>
> > >>lm_expire_lock is called to resolve the lock conflict if the returned
> > >>value from lm_lock_expirable is true. This callback is called without
> > >>the flc_lock held since it's allowed to block. Upon returning from
> > >>this callback, the lock conflict should be resolved and the caller is
> > >>expected to restart the conflict check from the beginnning of the list.
> > >>
> > >>Lock manager, such as NFSv4 courteous server, uses this callback to
> > >>resolve conflict by destroying lock owner, or the NFSv4 courtesy client
> > >>(client that has expired but allowed to maintains its states) that owns
> > >>the lock.
> > >>
> > >>Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > >>---
> > >>  Documentation/filesystems/locking.rst |  4 ++++
> > >>  fs/locks.c                            | 45 +++++++++++++++++++++++++++++++----
> > >>  include/linux/fs.h                    |  3 +++
> > >>  3 files changed, 48 insertions(+), 4 deletions(-)
> > >>
> > >>diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
> > >>index c26d854275a0..0997a258361a 100644
> > >>--- a/Documentation/filesystems/locking.rst
> > >>+++ b/Documentation/filesystems/locking.rst
> > >>@@ -428,6 +428,8 @@ prototypes::
> > >>  	void (*lm_break)(struct file_lock *); /* break_lease callback */
> > >>  	int (*lm_change)(struct file_lock **, int);
> > >>  	bool (*lm_breaker_owns_lease)(struct file_lock *);
> > >>+        bool (*lm_lock_expirable)(struct file_lock *);
> > >>+        void (*lm_expire_lock)(void);
> > >>  locking rules:
> > >>@@ -439,6 +441,8 @@ lm_grant:		no		no			no
> > >>  lm_break:		yes		no			no
> > >>  lm_change		yes		no			no
> > >>  lm_breaker_owns_lease:	yes     	no			no
> > >>+lm_lock_expirable	yes		no			no
> > >>+lm_expire_lock		no		no			yes
> > >>  ======================	=============	=================	=========
> > >>  buffer_head
> > >>diff --git a/fs/locks.c b/fs/locks.c
> > >>index c369841ef7d1..d48c3f455657 100644
> > >>--- a/fs/locks.c
> > >>+++ b/fs/locks.c
> > >>@@ -896,6 +896,37 @@ static bool flock_locks_conflict(struct file_lock *caller_fl,
> > >>  	return locks_conflict(caller_fl, sys_fl);
> > >>  }
> > >>+static bool
> > >>+resolve_lock_conflict_locked(struct file_lock_context *ctx,
> > >>+			struct file_lock *cfl, bool rwsem)
> > >>+{
> > >>+	void *owner;
> > >>+	bool ret;
> > >>+	void (*func)(void);
> > >>+
> > >>+	if (cfl->fl_lmops && cfl->fl_lmops->lm_lock_expirable &&
> > >>+				cfl->fl_lmops->lm_expire_lock) {
> > >>+		ret = (*cfl->fl_lmops->lm_lock_expirable)(cfl);
> > >>+		if (!ret)
> > >>+			return false;
> > >>+		owner = cfl->fl_lmops->lm_mod_owner;
> > >>+		if (!owner)
> > >>+			return false;
> > >>+		func = cfl->fl_lmops->lm_expire_lock;
> > >>+		__module_get(owner);
> > >>+		if (rwsem)
> > >>+			percpu_up_read(&file_rwsem);
> > >>+		spin_unlock(&ctx->flc_lock);
> > >Dropping and reacquiring locks inside a function like this makes me
> > >nervous.  It means it's not obvious in the caller that the lock isn't
> > >held throughout.
> > >
> > >I know it's more verbose, but let's just open-code this logic in the
> > >callers.
> > 
> > fix in v24.
> > 
> > >
> > >(And, thanks for catching the test_lock case, I'd forgotten it.)
> > >
> > >Also: do we *really* need to drop the file_rwsem?  Were you seeing it
> > >that cause problems?  The only possible conflict is with someone trying
> > >to read /proc/locks, and I'm surprised that it'd be a problem to let
> > >them wait here.
> > 
> > Yes, apparently file_rwsem is used when the laundromat expires the
> > COURTESY client client and causes deadlock.
> 
> It's taken, but only for read.  I'm rather surprised that would cause a
> deadlock.  Do you have any kind of trace showing what happened?
> 
> Oh well, it's not a big deal to just open code this and set the "retry:"
> before both lock acquisitions, that's probably best in fact.  I'm just
> curious.

I remember running across this:

	https://lore.kernel.org/linux-nfs/20210927201433.GA1704@fieldses.org/

though that didn't involve the laundromat.  Were you seeing an actual
deadlock with these new patches?  Or a lockdep warning like that one?

--b.

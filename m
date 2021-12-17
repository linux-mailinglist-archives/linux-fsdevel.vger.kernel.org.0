Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A5247969A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Dec 2021 22:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhLQVyo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Dec 2021 16:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhLQVyn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Dec 2021 16:54:43 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10389C061574;
        Fri, 17 Dec 2021 13:54:43 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 65320BD9; Fri, 17 Dec 2021 16:54:42 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 65320BD9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1639778082;
        bh=+vqRj04tcPMWqwtTySNI4PVnEfj+pr4PeuySErHuCjE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hMgI5WkOxg9FDWNKCWcjdUPj7ig9w87djiJL0b4tGG5oArGUW8bnBYNtLz8qdkS2W
         4iz2YJw8gt/W87/wo2bXAyNP8JHYa0nqunUElkgO8GYW/wogQkqtQs3IOzvs6wDtDo
         nU7bNH3TDmOFKEAGNsFGDFx7vz/QjpkjG1QwJ4/8=
Date:   Fri, 17 Dec 2021 16:54:42 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v8 1/2] fs/lock: add new callback, lm_expire_lock, to
 lock_manager_operations
Message-ID: <20211217215442.GM28098@fieldses.org>
References: <20211213172423.49021-1-dai.ngo@oracle.com>
 <20211213172423.49021-2-dai.ngo@oracle.com>
 <0C2E5E30-86A3-489E-9366-DC4FF109DD93@oracle.com>
 <20211217203517.GJ28098@fieldses.org>
 <5fa49a09-50c9-efb4-fa72-35c0e8d889b1@oracle.com>
 <20211217205849.GK28098@fieldses.org>
 <35eb11dd-84ff-0d53-7183-2001084bab1a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35eb11dd-84ff-0d53-7183-2001084bab1a@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 17, 2021 at 01:23:36PM -0800, dai.ngo@oracle.com wrote:
> On 12/17/21 12:58 PM, Bruce Fields wrote:
> >On Fri, Dec 17, 2021 at 12:50:55PM -0800, dai.ngo@oracle.com wrote:
> >>On 12/17/21 12:35 PM, Bruce Fields wrote:
> >>>On Tue, Dec 14, 2021 at 11:41:41PM +0000, Chuck Lever III wrote:
> >>>>>On Dec 13, 2021, at 12:24 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
> >>>>>
> >>>>>Add new callback, lm_expire_lock, to lock_manager_operations to allow
> >>>>>the lock manager to take appropriate action to resolve the lock conflict
> >>>>>if possible. The callback takes 2 arguments, file_lock of the blocker
> >>>>>and a testonly flag:
> >>>>>
> >>>>>testonly = 1  check and return lock manager's private data if lock conflict
> >>>>>              can be resolved else return NULL.
> >>>>>testonly = 0  resolve the conflict if possible, return true if conflict
> >>>>>              was resolved esle return false.
> >>>>>
> >>>>>Lock manager, such as NFSv4 courteous server, uses this callback to
> >>>>>resolve conflict by destroying lock owner, or the NFSv4 courtesy client
> >>>>>(client that has expired but allowed to maintains its states) that owns
> >>>>>the lock.
> >>>>>
> >>>>>Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> >>>>>---
> >>>>>fs/locks.c         | 40 +++++++++++++++++++++++++++++++++++++---
> >>>>>include/linux/fs.h |  1 +
> >>>>>2 files changed, 38 insertions(+), 3 deletions(-)
> >>>>>
> >>>>>diff --git a/fs/locks.c b/fs/locks.c
> >>>>>index 3d6fb4ae847b..5f3ea40ce2aa 100644
> >>>>>--- a/fs/locks.c
> >>>>>+++ b/fs/locks.c
> >>>>>@@ -952,8 +952,11 @@ void
> >>>>>posix_test_lock(struct file *filp, struct file_lock *fl)
> >>>>>{
> >>>>>	struct file_lock *cfl;
> >>>>>+	struct file_lock *checked_cfl = NULL;
> >>>>>	struct file_lock_context *ctx;
> >>>>>	struct inode *inode = locks_inode(filp);
> >>>>>+	void *res_data;
> >>>>>+	void *(*func)(void *priv, bool testonly);
> >>>>>
> >>>>>	ctx = smp_load_acquire(&inode->i_flctx);
> >>>>>	if (!ctx || list_empty_careful(&ctx->flc_posix)) {
> >>>>>@@ -962,11 +965,24 @@ posix_test_lock(struct file *filp, struct file_lock *fl)
> >>>>>	}
> >>>>>
> >>>>>	spin_lock(&ctx->flc_lock);
> >>>>>+retry:
> >>>>>	list_for_each_entry(cfl, &ctx->flc_posix, fl_list) {
> >>>>>-		if (posix_locks_conflict(fl, cfl)) {
> >>>>>-			locks_copy_conflock(fl, cfl);
> >>>>>-			goto out;
> >>>>>+		if (!posix_locks_conflict(fl, cfl))
> >>>>>+			continue;
> >>>>>+		if (checked_cfl != cfl && cfl->fl_lmops &&
> >>>>>+				cfl->fl_lmops->lm_expire_lock) {
> >>>>>+			res_data = cfl->fl_lmops->lm_expire_lock(cfl, true);
> >>>>>+			if (res_data) {
> >>>>>+				func = cfl->fl_lmops->lm_expire_lock;
> >>>>>+				spin_unlock(&ctx->flc_lock);
> >>>>>+				func(res_data, false);
> >>>>>+				spin_lock(&ctx->flc_lock);
> >>>>>+				checked_cfl = cfl;
> >>>>>+				goto retry;
> >>>>>+			}
> >>>>>		}
> >>>>Dai and I discussed this offline. Depending on a pointer to represent
> >>>>exactly the same struct file_lock across a dropped spinlock is racy.
> >>>Yes.  There's also no need for that (checked_cfl != cfl) check, though.
> >>>By the time func() returns, that lock should be gone from the list
> >>>anyway.
> >>func() eventually calls expire_client. But we do not know if expire_client
> >>succeeds.
> >expire_client always succeeds,
> 
> Even when expire_client always succeeds, what do we do when we go
> back up to the loop to get a new 'cfl' from the list and that happens
> to be the same one we just expire?

The *only* way that should happen is if the courtesy client has been
upgraded back to a regular client.  In that case, the conflict is a real
conflict, there's no point continuing to try to expire the client, we
just let posix_lock_file() return -EAGAIN.

> this should not happen but we can
> not ignore that condition in the code.
> 
> This patch can be used for other lock managers and not just nfsd (even
> though nfsd is the only consumer for now), can we force other lock managers
> to guarantee lm_expire_lock(not_test_case) *always* resolve the conflict
> successfully?

Only nfsd has a notion of courtesy locks, so it's a little hard to
speculate how other lock managers might work.

But all we're able to ask is that when they not return until they've
either expired the lock, or decided that it's not an expirable lock any
more.  I don't think that's a very harsh requirement.

> We have to have this loop since there might be more than one conflict
> lock.

Right.  We don't need the checked_cfl variable, though.

> 
> -Dai
> 
> >  maybe you're thinking of
> >mark_client_expired_locked or something?
> 
> >
> >If there's a chance something might fail here, the only reason should be
> >that the client is no longer a courtesy client because it's come back to
> >life.  But in that case the correct behavior would be to just honor the
> >lock conflict and return -EAGAIN.
> 
> That's what the current code does.
> 
> -Dai
> 
> >
> >--b.
> >
> >>One simple way to know if the conflict client was successfully
> >>expired is to check the list again. If the client was successfully expired
> >>then its locks were removed from the list. Otherwise we get the same 'cfl'
> >>from the list again on the next get.
> >>
> >>-Dai
> >>
> >>>It's a little inefficient to have to restart the list every time--but
> >>>that theoretical n^2 behavior won't matter much compared to the time
> >>>spent waiting for clients to expire.  And this approach has the benefit
> >>>of being simple.
> >>>
> >>>--b.
> >>>
> >>>>Dai plans to investigate other mechanisms to perform this check
> >>>>reliably.
> >>>>
> >>>>
> >>>>>+		locks_copy_conflock(fl, cfl);
> >>>>>+		goto out;
> >>>>>	}
> >>>>>	fl->fl_type = F_UNLCK;
> >>>>>out:
> >>>>>@@ -1136,10 +1152,13 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
> >>>>>	struct file_lock *new_fl2 = NULL;
> >>>>>	struct file_lock *left = NULL;
> >>>>>	struct file_lock *right = NULL;
> >>>>>+	struct file_lock *checked_fl = NULL;
> >>>>>	struct file_lock_context *ctx;
> >>>>>	int error;
> >>>>>	bool added = false;
> >>>>>	LIST_HEAD(dispose);
> >>>>>+	void *res_data;
> >>>>>+	void *(*func)(void *priv, bool testonly);
> >>>>>
> >>>>>	ctx = locks_get_lock_context(inode, request->fl_type);
> >>>>>	if (!ctx)
> >>>>>@@ -1166,9 +1185,24 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
> >>>>>	 * blocker's list of waiters and the global blocked_hash.
> >>>>>	 */
> >>>>>	if (request->fl_type != F_UNLCK) {
> >>>>>+retry:
> >>>>>		list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
> >>>>>			if (!posix_locks_conflict(request, fl))
> >>>>>				continue;
> >>>>>+			if (checked_fl != fl && fl->fl_lmops &&
> >>>>>+					fl->fl_lmops->lm_expire_lock) {
> >>>>>+				res_data = fl->fl_lmops->lm_expire_lock(fl, true);
> >>>>>+				if (res_data) {
> >>>>>+					func = fl->fl_lmops->lm_expire_lock;
> >>>>>+					spin_unlock(&ctx->flc_lock);
> >>>>>+					percpu_up_read(&file_rwsem);
> >>>>>+					func(res_data, false);
> >>>>>+					percpu_down_read(&file_rwsem);
> >>>>>+					spin_lock(&ctx->flc_lock);
> >>>>>+					checked_fl = fl;
> >>>>>+					goto retry;
> >>>>>+				}
> >>>>>+			}
> >>>>>			if (conflock)
> >>>>>				locks_copy_conflock(conflock, fl);
> >>>>>			error = -EAGAIN;
> >>>>>diff --git a/include/linux/fs.h b/include/linux/fs.h
> >>>>>index e7a633353fd2..8cb910c3a394 100644
> >>>>>--- a/include/linux/fs.h
> >>>>>+++ b/include/linux/fs.h
> >>>>>@@ -1071,6 +1071,7 @@ struct lock_manager_operations {
> >>>>>	int (*lm_change)(struct file_lock *, int, struct list_head *);
> >>>>>	void (*lm_setup)(struct file_lock *, void **);
> >>>>>	bool (*lm_breaker_owns_lease)(struct file_lock *);
> >>>>>+	void *(*lm_expire_lock)(void *priv, bool testonly);
> >>>>>};
> >>>>>
> >>>>>struct lock_manager {
> >>>>>-- 
> >>>>>2.9.5
> >>>>>
> >>>>--
> >>>>Chuck Lever
> >>>>
> >>>>

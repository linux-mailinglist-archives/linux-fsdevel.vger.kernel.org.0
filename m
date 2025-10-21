Return-Path: <linux-fsdevel+bounces-64918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0239EBF687B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 14:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAF833B0D32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 12:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E8F3321CC;
	Tue, 21 Oct 2025 12:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgB+dSRp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E55541C63;
	Tue, 21 Oct 2025 12:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761050903; cv=none; b=shrv1lfTSBD2fIoIbXm7ov0EqJXpZgm+XP25fhvKZlJs9EQyJQyDh4az29ixHEVCZ9V508pgOo/War93WXDwNKGue9ZE3CvRefR4G2iJxVhft9EuRnf7qGQFmzHA+5Rc6P5S7UJVBCSLMhSvfIVwRR4wuFOWXJhhVrnTzrMumCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761050903; c=relaxed/simple;
	bh=AZgESGJJ+HnCdsMFs+HjpT8kUMF2xqIjx68qM2/k8II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smotAz5z7FoDrABJUt3fwpzMNgLda3ExG58t2CcLo6xGl9LBnhQL1yPnMWSYXFD8nmCANA8Yb024ss85Jsz6FTfvW2jLeu/ydVFXsOuEKCBSPAngAu7w3c6q1T4za5pAIB3YkygT9AexRsLjUcycUfidWvh4x35ws/PCAwIZdnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgB+dSRp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 442B0C4CEFD;
	Tue, 21 Oct 2025 12:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761050902;
	bh=AZgESGJJ+HnCdsMFs+HjpT8kUMF2xqIjx68qM2/k8II=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MgB+dSRp/e1iU3n3CDdEx71519C+hbnP+ILPKHV9GmV2OqXocVatdPWw5xZluW1Hq
	 yXxVuluiRMKXeynfNsBZ7p4EX/8YJzzi6MtlBk5YQP0BM95iBuNjWFH/XpYAql7WYW
	 EMDuyJ4aCxFfZUoMLvAOdf004LAh6Enk79U5Nix77IBnV97H1LVxFnlwWqczsx334Y
	 osdgy8XUDv33pY8QFVBY0FBc7VQmZn9ZfXIbqDrLQkCJFTnugpZF6m8P0cpUkak0MR
	 Z3qxxdI2jZCVWDPA00mk47hcI0vLHrdT2BDwhYtsyH53zx+xLaiCYtq8GJsxdHb5ax
	 7+JU0Eju8cu8g==
Date: Tue, 21 Oct 2025 14:48:18 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: rework I_NEW handling to operate without fences
Message-ID: <20251021-beinhalten-passierbar-62c358c24613@brauner>
References: <20251010221737.1403539-1-mjguzik@gmail.com>
 <CAGudoHETiJ8G8WeyFYJ6EZ4oxcmqxV3yztZDOxL8PUBGobW_xQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHETiJ8G8WeyFYJ6EZ4oxcmqxV3yztZDOxL8PUBGobW_xQ@mail.gmail.com>

On Wed, Oct 15, 2025 at 01:50:25PM +0200, Mateusz Guzik wrote:
> can i get some flames on this?

Ok, that looks fine to me. I don't particularly enjoy that boolean but I
think it simplifies d_instantiate_new() enough to make up for it.

> 
> On Sat, Oct 11, 2025 at 12:17 AM Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > In the inode hash code grab the state while ->i_lock is held. If found
> > to be set, synchronize the sleep once more with the lock held.
> >
> > In the real world the flag is not set most of the time.
> >
> > Apart from being simpler to reason about, it comes with a minor speed up
> > as now clearing the flag does not require the smp_mb() fence.
> >
> > While here rename wait_on_inode() to wait_on_new_inode() to line it up
> > with __wait_on_freeing_inode().
> >
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > ---
> >
> > This temporarily duplicated sleep code from inode_wait_for_lru_isolating().
> > This is going to get dedupped later.
> >
> > There is high repetition of:
> >         if (unlikely(isnew)) {
> >                 wait_on_new_inode(old);
> >                 if (unlikely(inode_unhashed(old))) {
> >                         iput(old);
> >                         goto again;
> >                 }
> >
> > I expect this is going to go away after I post a patch to sanitize the
> > current APIs for the hash.
> >
> >
> >  fs/afs/dir.c       |   4 +-
> >  fs/dcache.c        |  10 ----
> >  fs/gfs2/glock.c    |   2 +-
> >  fs/inode.c         | 146 +++++++++++++++++++++++++++------------------
> >  include/linux/fs.h |  12 +---
> >  5 files changed, 93 insertions(+), 81 deletions(-)
> >
> > diff --git a/fs/afs/dir.c b/fs/afs/dir.c
> > index 89d36e3e5c79..f4e9e12373ac 100644
> > --- a/fs/afs/dir.c
> > +++ b/fs/afs/dir.c
> > @@ -779,7 +779,7 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry)
> >         struct afs_vnode *dvnode = AFS_FS_I(dir), *vnode;
> >         struct inode *inode = NULL, *ti;
> >         afs_dataversion_t data_version = READ_ONCE(dvnode->status.data_version);
> > -       bool supports_ibulk;
> > +       bool supports_ibulk, isnew;
> >         long ret;
> >         int i;
> >
> > @@ -850,7 +850,7 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry)
> >                          * callback counters.
> >                          */
> >                         ti = ilookup5_nowait(dir->i_sb, vp->fid.vnode,
> > -                                            afs_ilookup5_test_by_fid, &vp->fid);
> > +                                            afs_ilookup5_test_by_fid, &vp->fid, &isnew);
> >                         if (!IS_ERR_OR_NULL(ti)) {
> >                                 vnode = AFS_FS_I(ti);
> >                                 vp->dv_before = vnode->status.data_version;
> > diff --git a/fs/dcache.c b/fs/dcache.c
> > index 78ffa7b7e824..25131f105a60 100644
> > --- a/fs/dcache.c
> > +++ b/fs/dcache.c
> > @@ -1981,17 +1981,7 @@ void d_instantiate_new(struct dentry *entry, struct inode *inode)
> >         spin_lock(&inode->i_lock);
> >         __d_instantiate(entry, inode);
> >         WARN_ON(!(inode_state_read(inode) & I_NEW));
> > -       /*
> > -        * Pairs with smp_rmb in wait_on_inode().
> > -        */
> > -       smp_wmb();
> >         inode_state_clear(inode, I_NEW | I_CREATING);
> > -       /*
> > -        * Pairs with the barrier in prepare_to_wait_event() to make sure
> > -        * ___wait_var_event() either sees the bit cleared or
> > -        * waitqueue_active() check in wake_up_var() sees the waiter.
> > -        */
> > -       smp_mb();
> >         inode_wake_up_bit(inode, __I_NEW);
> >         spin_unlock(&inode->i_lock);
> >  }
> > diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
> > index b677c0e6b9ab..c9712235e7a0 100644
> > --- a/fs/gfs2/glock.c
> > +++ b/fs/gfs2/glock.c
> > @@ -957,7 +957,7 @@ static struct gfs2_inode *gfs2_grab_existing_inode(struct gfs2_glock *gl)
> >                 ip = NULL;
> >         spin_unlock(&gl->gl_lockref.lock);
> >         if (ip) {
> > -               wait_on_inode(&ip->i_inode);
> > +               wait_on_new_inode(&ip->i_inode);
> >                 if (is_bad_inode(&ip->i_inode)) {
> >                         iput(&ip->i_inode);
> >                         ip = NULL;
> > diff --git a/fs/inode.c b/fs/inode.c
> > index 3153d725859c..1396f79b2551 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -558,6 +558,32 @@ struct wait_queue_head *inode_bit_waitqueue(struct wait_bit_queue_entry *wqe,
> >  }
> >  EXPORT_SYMBOL(inode_bit_waitqueue);
> >
> > +void wait_on_new_inode(struct inode *inode)
> > +{
> > +       struct wait_bit_queue_entry wqe;
> > +       struct wait_queue_head *wq_head;
> > +
> > +       spin_lock(&inode->i_lock);
> > +       if (!(inode_state_read(inode) & I_NEW)) {
> > +               spin_unlock(&inode->i_lock);
> > +               return;
> > +       }
> > +
> > +       wq_head = inode_bit_waitqueue(&wqe, inode, __I_NEW);
> > +       for (;;) {
> > +               prepare_to_wait_event(wq_head, &wqe.wq_entry, TASK_UNINTERRUPTIBLE);
> > +               if (!(inode_state_read(inode) & I_NEW))
> > +                       break;
> > +               spin_unlock(&inode->i_lock);
> > +               schedule();
> > +               spin_lock(&inode->i_lock);
> > +       }
> > +       finish_wait(wq_head, &wqe.wq_entry);
> > +       WARN_ON(inode_state_read(inode) & I_NEW);
> > +       spin_unlock(&inode->i_lock);
> > +}
> > +EXPORT_SYMBOL(wait_on_new_inode);
> > +
> >  /*
> >   * Add inode to LRU if needed (inode is unused and clean).
> >   *
> > @@ -1008,7 +1034,8 @@ static void __wait_on_freeing_inode(struct inode *inode, bool is_inode_hash_lock
> >  static struct inode *find_inode(struct super_block *sb,
> >                                 struct hlist_head *head,
> >                                 int (*test)(struct inode *, void *),
> > -                               void *data, bool is_inode_hash_locked)
> > +                               void *data, bool is_inode_hash_locked,
> > +                               bool *isnew)
> >  {
> >         struct inode *inode = NULL;
> >
> > @@ -1035,6 +1062,7 @@ static struct inode *find_inode(struct super_block *sb,
> >                         return ERR_PTR(-ESTALE);
> >                 }
> >                 __iget(inode);
> > +               *isnew = !!(inode_state_read(inode) & I_NEW);
> >                 spin_unlock(&inode->i_lock);
> >                 rcu_read_unlock();
> >                 return inode;
> > @@ -1049,7 +1077,7 @@ static struct inode *find_inode(struct super_block *sb,
> >   */
> >  static struct inode *find_inode_fast(struct super_block *sb,
> >                                 struct hlist_head *head, unsigned long ino,
> > -                               bool is_inode_hash_locked)
> > +                               bool is_inode_hash_locked, bool *isnew)
> >  {
> >         struct inode *inode = NULL;
> >
> > @@ -1076,6 +1104,7 @@ static struct inode *find_inode_fast(struct super_block *sb,
> >                         return ERR_PTR(-ESTALE);
> >                 }
> >                 __iget(inode);
> > +               *isnew = !!(inode_state_read(inode) & I_NEW);
> >                 spin_unlock(&inode->i_lock);
> >                 rcu_read_unlock();
> >                 return inode;
> > @@ -1181,17 +1210,7 @@ void unlock_new_inode(struct inode *inode)
> >         lockdep_annotate_inode_mutex_key(inode);
> >         spin_lock(&inode->i_lock);
> >         WARN_ON(!(inode_state_read(inode) & I_NEW));
> > -       /*
> > -        * Pairs with smp_rmb in wait_on_inode().
> > -        */
> > -       smp_wmb();
> >         inode_state_clear(inode, I_NEW | I_CREATING);
> > -       /*
> > -        * Pairs with the barrier in prepare_to_wait_event() to make sure
> > -        * ___wait_var_event() either sees the bit cleared or
> > -        * waitqueue_active() check in wake_up_var() sees the waiter.
> > -        */
> > -       smp_mb();

You're getting rid of smp_mb() because you're rechecking the flag under
i_lock after you called prepare_to_wait_event() in wait_on_new_inode()?

> >         inode_wake_up_bit(inode, __I_NEW);
> >         spin_unlock(&inode->i_lock);
> >  }
> > @@ -1202,17 +1221,7 @@ void discard_new_inode(struct inode *inode)
> >         lockdep_annotate_inode_mutex_key(inode);
> >         spin_lock(&inode->i_lock);
> >         WARN_ON(!(inode_state_read(inode) & I_NEW));
> > -       /*
> > -        * Pairs with smp_rmb in wait_on_inode().
> > -        */
> > -       smp_wmb();
> >         inode_state_clear(inode, I_NEW);
> > -       /*
> > -        * Pairs with the barrier in prepare_to_wait_event() to make sure
> > -        * ___wait_var_event() either sees the bit cleared or
> > -        * waitqueue_active() check in wake_up_var() sees the waiter.
> > -        */
> > -       smp_mb();
> >         inode_wake_up_bit(inode, __I_NEW);
> >         spin_unlock(&inode->i_lock);
> >         iput(inode);
> > @@ -1286,12 +1295,13 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
> >  {
> >         struct hlist_head *head = inode_hashtable + hash(inode->i_sb, hashval);
> >         struct inode *old;
> > +       bool isnew;
> >
> >         might_sleep();
> >
> >  again:
> >         spin_lock(&inode_hash_lock);
> > -       old = find_inode(inode->i_sb, head, test, data, true);
> > +       old = find_inode(inode->i_sb, head, test, data, true, &isnew);
> >         if (unlikely(old)) {
> >                 /*
> >                  * Uhhuh, somebody else created the same inode under us.
> > @@ -1300,10 +1310,12 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
> >                 spin_unlock(&inode_hash_lock);
> >                 if (IS_ERR(old))
> >                         return NULL;
> > -               wait_on_inode(old);
> > -               if (unlikely(inode_unhashed(old))) {
> > -                       iput(old);
> > -                       goto again;
> > +               if (unlikely(isnew)) {
> > +                       wait_on_new_inode(old);
> > +                       if (unlikely(inode_unhashed(old))) {
> > +                               iput(old);
> > +                               goto again;
> > +                       }
> >                 }
> >                 return old;
> >         }
> > @@ -1391,18 +1403,21 @@ struct inode *iget5_locked_rcu(struct super_block *sb, unsigned long hashval,
> >  {
> >         struct hlist_head *head = inode_hashtable + hash(sb, hashval);
> >         struct inode *inode, *new;
> > +       bool isnew;
> >
> >         might_sleep();
> >
> >  again:
> > -       inode = find_inode(sb, head, test, data, false);
> > +       inode = find_inode(sb, head, test, data, false, &isnew);
> >         if (inode) {
> >                 if (IS_ERR(inode))
> >                         return NULL;
> > -               wait_on_inode(inode);
> > -               if (unlikely(inode_unhashed(inode))) {
> > -                       iput(inode);
> > -                       goto again;
> > +               if (unlikely(isnew)) {
> > +                       wait_on_new_inode(inode);
> > +                       if (unlikely(inode_unhashed(inode))) {
> > +                               iput(inode);
> > +                               goto again;
> > +                       }
> >                 }
> >                 return inode;
> >         }
> > @@ -1434,18 +1449,21 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
> >  {
> >         struct hlist_head *head = inode_hashtable + hash(sb, ino);
> >         struct inode *inode;
> > +       bool isnew;
> >
> >         might_sleep();
> >
> >  again:
> > -       inode = find_inode_fast(sb, head, ino, false);
> > +       inode = find_inode_fast(sb, head, ino, false, &isnew);
> >         if (inode) {
> >                 if (IS_ERR(inode))
> >                         return NULL;
> > -               wait_on_inode(inode);
> > -               if (unlikely(inode_unhashed(inode))) {
> > -                       iput(inode);
> > -                       goto again;
> > +               if (unlikely(isnew)) {
> > +                       wait_on_new_inode(inode);
> > +                       if (unlikely(inode_unhashed(inode))) {
> > +                               iput(inode);
> > +                               goto again;
> > +                       }
> >                 }
> >                 return inode;
> >         }
> > @@ -1456,7 +1474,7 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
> >
> >                 spin_lock(&inode_hash_lock);
> >                 /* We released the lock, so.. */
> > -               old = find_inode_fast(sb, head, ino, true);
> > +               old = find_inode_fast(sb, head, ino, true, &isnew);
> >                 if (!old) {
> >                         inode->i_ino = ino;
> >                         spin_lock(&inode->i_lock);
> > @@ -1482,10 +1500,12 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
> >                 if (IS_ERR(old))
> >                         return NULL;
> >                 inode = old;
> > -               wait_on_inode(inode);
> > -               if (unlikely(inode_unhashed(inode))) {
> > -                       iput(inode);
> > -                       goto again;
> > +               if (unlikely(isnew)) {
> > +                       wait_on_new_inode(inode);
> > +                       if (unlikely(inode_unhashed(inode))) {
> > +                               iput(inode);
> > +                               goto again;
> > +                       }
> >                 }
> >         }
> >         return inode;
> > @@ -1586,13 +1606,13 @@ EXPORT_SYMBOL(igrab);
> >   * Note2: @test is called with the inode_hash_lock held, so can't sleep.
> >   */
> >  struct inode *ilookup5_nowait(struct super_block *sb, unsigned long hashval,
> > -               int (*test)(struct inode *, void *), void *data)
> > +               int (*test)(struct inode *, void *), void *data, bool *isnew)
> >  {
> >         struct hlist_head *head = inode_hashtable + hash(sb, hashval);
> >         struct inode *inode;
> >
> >         spin_lock(&inode_hash_lock);
> > -       inode = find_inode(sb, head, test, data, true);
> > +       inode = find_inode(sb, head, test, data, true, isnew);
> >         spin_unlock(&inode_hash_lock);
> >
> >         return IS_ERR(inode) ? NULL : inode;
> > @@ -1620,16 +1640,19 @@ struct inode *ilookup5(struct super_block *sb, unsigned long hashval,
> >                 int (*test)(struct inode *, void *), void *data)
> >  {
> >         struct inode *inode;
> > +       bool isnew;
> >
> >         might_sleep();
> >
> >  again:
> > -       inode = ilookup5_nowait(sb, hashval, test, data);
> > +       inode = ilookup5_nowait(sb, hashval, test, data, &isnew);
> >         if (inode) {
> > -               wait_on_inode(inode);
> > -               if (unlikely(inode_unhashed(inode))) {
> > -                       iput(inode);
> > -                       goto again;
> > +               if (unlikely(isnew)) {
> > +                       wait_on_new_inode(inode);
> > +                       if (unlikely(inode_unhashed(inode))) {
> > +                               iput(inode);
> > +                               goto again;
> > +                       }
> >                 }
> >         }
> >         return inode;
> > @@ -1648,19 +1671,22 @@ struct inode *ilookup(struct super_block *sb, unsigned long ino)
> >  {
> >         struct hlist_head *head = inode_hashtable + hash(sb, ino);
> >         struct inode *inode;
> > +       bool isnew;
> >
> >         might_sleep();
> >
> >  again:
> > -       inode = find_inode_fast(sb, head, ino, false);
> > +       inode = find_inode_fast(sb, head, ino, false, &isnew);
> >
> >         if (inode) {
> >                 if (IS_ERR(inode))
> >                         return NULL;
> > -               wait_on_inode(inode);
> > -               if (unlikely(inode_unhashed(inode))) {
> > -                       iput(inode);
> > -                       goto again;
> > +               if (unlikely(isnew)) {
> > +                       wait_on_new_inode(inode);
> > +                       if (unlikely(inode_unhashed(inode))) {
> > +                               iput(inode);
> > +                               goto again;
> > +                       }
> >                 }
> >         }
> >         return inode;
> > @@ -1800,6 +1826,7 @@ int insert_inode_locked(struct inode *inode)
> >         struct super_block *sb = inode->i_sb;
> >         ino_t ino = inode->i_ino;
> >         struct hlist_head *head = inode_hashtable + hash(sb, ino);
> > +       bool isnew;
> >
> >         might_sleep();
> >
> > @@ -1832,12 +1859,15 @@ int insert_inode_locked(struct inode *inode)
> >                         return -EBUSY;
> >                 }
> >                 __iget(old);
> > +               isnew = !!(inode_state_read(old) & I_NEW);
> >                 spin_unlock(&old->i_lock);
> >                 spin_unlock(&inode_hash_lock);
> > -               wait_on_inode(old);
> > -               if (unlikely(!inode_unhashed(old))) {
> > -                       iput(old);
> > -                       return -EBUSY;
> > +               if (isnew) {
> > +                       wait_on_new_inode(old);
> > +                       if (unlikely(!inode_unhashed(old))) {
> > +                               iput(old);
> > +                               return -EBUSY;
> > +                       }
> >                 }
> >                 iput(old);
> >         }
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 21c73df3ce75..a813abdcf218 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -1030,15 +1030,7 @@ static inline void inode_fake_hash(struct inode *inode)
> >         hlist_add_fake(&inode->i_hash);
> >  }
> >
> > -static inline void wait_on_inode(struct inode *inode)
> > -{
> > -       wait_var_event(inode_state_wait_address(inode, __I_NEW),
> > -                      !(inode_state_read_once(inode) & I_NEW));
> > -       /*
> > -        * Pairs with routines clearing I_NEW.
> > -        */
> > -       smp_rmb();
> > -}
> > +void wait_on_new_inode(struct inode *inode);
> >
> >  /*
> >   * inode->i_rwsem nesting subclasses for the lock validator:
> > @@ -3417,7 +3409,7 @@ extern void d_mark_dontcache(struct inode *inode);
> >
> >  extern struct inode *ilookup5_nowait(struct super_block *sb,
> >                 unsigned long hashval, int (*test)(struct inode *, void *),
> > -               void *data);
> > +               void *data, bool *isnew);
> >  extern struct inode *ilookup5(struct super_block *sb, unsigned long hashval,
> >                 int (*test)(struct inode *, void *), void *data);
> >  extern struct inode *ilookup(struct super_block *sb, unsigned long ino);
> > --
> > 2.34.1
> >


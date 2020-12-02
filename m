Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC1B2CC8CF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 22:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbgLBVUU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 16:20:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:46128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726671AbgLBVUS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 16:20:18 -0500
Date:   Wed, 2 Dec 2020 13:19:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1606943977;
        bh=JtT7doOINp9+ZMFIZ+dlt/slcFNWsBOJ/UyCWvCAeNU=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=LiWCFJICn/o03uyWj62CQRc0wyNqI1pqdTsnGpqpp4BpW58/0UyaisuDN/InuBDtW
         PtCkRHfbSALTq7Z1K4xAqxeAw/Z38JgYTFtETsQeX8WIJWeV55OXOZCp6NUJk10OeB
         hSgETUCfGmBNOZM7yHDeUAk3Xf2ba44rPR3VGvMtQOteREkOckl4/ayFKhOS1nL0Zz
         bJR7arzg/DywZ1xEaZ4Ei36vHrY6GQiRQXPaVZdeuPjXVIQ6yu/sZw0CAz5twyIH7d
         gIrCwE75hOC+fEhyjA7aI2+xLaRkV910UT+wcg4mn0PBH4sReIsL9sxGhhGHlcKD61
         DxIQ/WULyS8LA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH] fs/namespace.c: WARN if mnt_count has become negative
Message-ID: <X8gE55iaLsNDuae2@gmail.com>
References: <20201101044021.1604670-1-ebiggers@kernel.org>
 <X7gQN3T+4rPSXg0B@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X7gQN3T+4rPSXg0B@sol.localdomain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 20, 2020 at 10:51:35AM -0800, Eric Biggers wrote:
> On Sat, Oct 31, 2020 at 09:40:21PM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Missing calls to mntget() (or equivalently, too many calls to mntput())
> > are hard to detect because mntput() delays freeing mounts using
> > task_work_add(), then again using call_rcu().  As a result, mnt_count
> > can often be decremented to -1 without getting a KASAN use-after-free
> > report.  Such cases are still bugs though, and they point to real
> > use-after-frees being possible.
> > 
> > For an example of this, see the bug fixed by commit 1b0b9cc8d379
> > ("vfs: fsmount: add missing mntget()"), discussed at
> > https://lkml.kernel.org/linux-fsdevel/20190605135401.GB30925@lakrids.cambridge.arm.com/T/#u.
> > This bug *should* have been trivial to find.  But actually, it wasn't
> > found until syzkaller happened to use fchdir() to manipulate the
> > reference count just right for the bug to be noticeable.
> > 
> > Address this by making mntput_no_expire() issue a WARN if mnt_count has
> > become negative.
> > 
> > Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > ---
> >  fs/namespace.c | 9 ++++++---
> >  fs/pnode.h     | 2 +-
> >  2 files changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index cebaa3e817940..93006abe7946a 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -156,10 +156,10 @@ static inline void mnt_add_count(struct mount *mnt, int n)
> >  /*
> >   * vfsmount lock must be held for write
> >   */
> > -unsigned int mnt_get_count(struct mount *mnt)
> > +int mnt_get_count(struct mount *mnt)
> >  {
> >  #ifdef CONFIG_SMP
> > -	unsigned int count = 0;
> > +	int count = 0;
> >  	int cpu;
> >  
> >  	for_each_possible_cpu(cpu) {
> > @@ -1139,6 +1139,7 @@ static DECLARE_DELAYED_WORK(delayed_mntput_work, delayed_mntput);
> >  static void mntput_no_expire(struct mount *mnt)
> >  {
> >  	LIST_HEAD(list);
> > +	int count;
> >  
> >  	rcu_read_lock();
> >  	if (likely(READ_ONCE(mnt->mnt_ns))) {
> > @@ -1162,7 +1163,9 @@ static void mntput_no_expire(struct mount *mnt)
> >  	 */
> >  	smp_mb();
> >  	mnt_add_count(mnt, -1);
> > -	if (mnt_get_count(mnt)) {
> > +	count = mnt_get_count(mnt);
> > +	if (count != 0) {
> > +		WARN_ON(count < 0);
> >  		rcu_read_unlock();
> >  		unlock_mount_hash();
> >  		return;
> > diff --git a/fs/pnode.h b/fs/pnode.h
> > index 49a058c73e4c7..26f74e092bd98 100644
> > --- a/fs/pnode.h
> > +++ b/fs/pnode.h
> > @@ -44,7 +44,7 @@ int propagate_mount_busy(struct mount *, int);
> >  void propagate_mount_unlock(struct mount *);
> >  void mnt_release_group_id(struct mount *);
> >  int get_dominating_id(struct mount *mnt, const struct path *root);
> > -unsigned int mnt_get_count(struct mount *mnt);
> > +int mnt_get_count(struct mount *mnt);
> >  void mnt_set_mountpoint(struct mount *, struct mountpoint *,
> >  			struct mount *);
> >  void mnt_change_mountpoint(struct mount *parent, struct mountpoint *mp,
> > 

Ping.

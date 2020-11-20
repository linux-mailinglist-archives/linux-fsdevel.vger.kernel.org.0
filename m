Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 292B82BB460
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 20:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732018AbgKTSwe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 13:52:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:34096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731956AbgKTSvh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 13:51:37 -0500
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D52482245F;
        Fri, 20 Nov 2020 18:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605898297;
        bh=Zi5R/IrNJ++v065Rk+eCxJwy7T6kpjNexLrMDu6ov6s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lhqTtJZ55a7wpKg1uBZZP7aYzrYJeXXJBAxFEq8CkvBo4DjlwYRACyXTNNfoUSiyg
         4JfDf8Nyw7KMbrU31fbnMVyA5uRaufbyukUJmwODeG2i2VuvdDUvZF020KXF2enUYK
         D1DQW/zVkNFBIU/VoQ8+iVr3J4EQvhr4SBIYk1E8=
Date:   Fri, 20 Nov 2020 10:51:35 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH] fs/namespace.c: WARN if mnt_count has become negative
Message-ID: <X7gQN3T+4rPSXg0B@sol.localdomain>
References: <20201101044021.1604670-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201101044021.1604670-1-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 31, 2020 at 09:40:21PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Missing calls to mntget() (or equivalently, too many calls to mntput())
> are hard to detect because mntput() delays freeing mounts using
> task_work_add(), then again using call_rcu().  As a result, mnt_count
> can often be decremented to -1 without getting a KASAN use-after-free
> report.  Such cases are still bugs though, and they point to real
> use-after-frees being possible.
> 
> For an example of this, see the bug fixed by commit 1b0b9cc8d379
> ("vfs: fsmount: add missing mntget()"), discussed at
> https://lkml.kernel.org/linux-fsdevel/20190605135401.GB30925@lakrids.cambridge.arm.com/T/#u.
> This bug *should* have been trivial to find.  But actually, it wasn't
> found until syzkaller happened to use fchdir() to manipulate the
> reference count just right for the bug to be noticeable.
> 
> Address this by making mntput_no_expire() issue a WARN if mnt_count has
> become negative.
> 
> Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/namespace.c | 9 ++++++---
>  fs/pnode.h     | 2 +-
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index cebaa3e817940..93006abe7946a 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -156,10 +156,10 @@ static inline void mnt_add_count(struct mount *mnt, int n)
>  /*
>   * vfsmount lock must be held for write
>   */
> -unsigned int mnt_get_count(struct mount *mnt)
> +int mnt_get_count(struct mount *mnt)
>  {
>  #ifdef CONFIG_SMP
> -	unsigned int count = 0;
> +	int count = 0;
>  	int cpu;
>  
>  	for_each_possible_cpu(cpu) {
> @@ -1139,6 +1139,7 @@ static DECLARE_DELAYED_WORK(delayed_mntput_work, delayed_mntput);
>  static void mntput_no_expire(struct mount *mnt)
>  {
>  	LIST_HEAD(list);
> +	int count;
>  
>  	rcu_read_lock();
>  	if (likely(READ_ONCE(mnt->mnt_ns))) {
> @@ -1162,7 +1163,9 @@ static void mntput_no_expire(struct mount *mnt)
>  	 */
>  	smp_mb();
>  	mnt_add_count(mnt, -1);
> -	if (mnt_get_count(mnt)) {
> +	count = mnt_get_count(mnt);
> +	if (count != 0) {
> +		WARN_ON(count < 0);
>  		rcu_read_unlock();
>  		unlock_mount_hash();
>  		return;
> diff --git a/fs/pnode.h b/fs/pnode.h
> index 49a058c73e4c7..26f74e092bd98 100644
> --- a/fs/pnode.h
> +++ b/fs/pnode.h
> @@ -44,7 +44,7 @@ int propagate_mount_busy(struct mount *, int);
>  void propagate_mount_unlock(struct mount *);
>  void mnt_release_group_id(struct mount *);
>  int get_dominating_id(struct mount *mnt, const struct path *root);
> -unsigned int mnt_get_count(struct mount *mnt);
> +int mnt_get_count(struct mount *mnt);
>  void mnt_set_mountpoint(struct mount *, struct mountpoint *,
>  			struct mount *);
>  void mnt_change_mountpoint(struct mount *parent, struct mountpoint *mp,
> 

Ping?

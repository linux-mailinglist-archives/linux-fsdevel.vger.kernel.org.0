Return-Path: <linux-fsdevel+bounces-46066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB76A82273
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 12:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF2993B65E4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 10:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE25D25D903;
	Wed,  9 Apr 2025 10:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzRNLHje"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA9125D521;
	Wed,  9 Apr 2025 10:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744195033; cv=none; b=rZRTSf7W2CwnDIgpfyYyUONScuM7vj/r9HWQSqRTK21fekIVTn23j/uYvCjh4xFavgGpphzB/YQJ/DeGefsuIZ3Nmy7HWpZ4CRgpJtbxSvDK61B7wwOUR773/QjmkCNwpDq3sX62JZaFc5FWvFQqtE+LtEaP2jQe9pJbinBNCfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744195033; c=relaxed/simple;
	bh=005eyM7oZ+oe+QrJDkNhnNOsvuIm71Nab7MxyM0PF4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAGwihH9y2bmsUV2mmpFiYBmxnkWUExQGHqcuQRnEIz0bvB5ufnhyF+esqEiVQHdE43jyW0m2lfrRTD6Qjkn90EwGg4y8gJRKfJpzktWhVHwy+Net5p0XzWOGP8h8qG8b6/iH7zvNKtaikmdsQ1gaxMQIb5MTNw6m2rkPprUwlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzRNLHje; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8272DC4CEE3;
	Wed,  9 Apr 2025 10:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744195032;
	bh=005eyM7oZ+oe+QrJDkNhnNOsvuIm71Nab7MxyM0PF4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RzRNLHjeyy896Zds4i45UgaCrjYtSwJii3lUF5PLKGIXgsgSsMIZbg5L0rP+Mr0UB
	 zK1MGHDulYLdqd+z/QO0dE/7rOuo0rKatovosQjvnKP5d3qwmvozny4TpqRLzUt7no
	 dEaMncSGotGj1BTeikOlK5p1kk5eatbry3QGwk39VomYZUyCy1562KRPx8VwbJVWCX
	 VYGV6oGxZounew1Nm8hH0xjrbi2fJj5XX2Wx4AgtS8GjEMpjHPZJm/coSIxayAX/Zb
	 yvLegkGtytHNq8fFBeycwiS4j81ij+r9QI9DXl3KU+mzwkYxNUUM7fRWj8M6fgs1oa
	 rQNzbI0XqRPGA==
Date: Wed, 9 Apr 2025 12:37:06 +0200
From: Christian Brauner <brauner@kernel.org>
To: Eric Chanudet <echanude@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ian Kent <ikent@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Alexander Larsson <alexl@redhat.com>, Lucas Karpinski <lkarpins@redhat.com>
Subject: Re: [PATCH v4] fs/namespace: defer RCU sync for MNT_DETACH umount
Message-ID: <20250409-egalisieren-halbbitter-23bc252d3a38@brauner>
References: <20250408210350.749901-12-echanude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250408210350.749901-12-echanude@redhat.com>

On Tue, Apr 08, 2025 at 04:58:34PM -0400, Eric Chanudet wrote:
> Defer releasing the detached file-system when calling namespace_unlock()
> during a lazy umount to return faster.
> 
> When requesting MNT_DETACH, the caller does not expect the file-system
> to be shut down upon returning from the syscall. Calling
> synchronize_rcu_expedited() has a significant cost on RT kernel that
> defaults to rcupdate.rcu_normal_after_boot=1. Queue the detached struct
> mount in a separate list and put it on a workqueue to run post RCU
> grace-period.
> 
> w/o patch, 6.15-rc1 PREEMPT_RT:
> perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount mnt
>     0.02455 +- 0.00107 seconds time elapsed  ( +-  4.36% )
> perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount -l mnt
>     0.02555 +- 0.00114 seconds time elapsed  ( +-  4.46% )
> 
> w/ patch, 6.15-rc1 PREEMPT_RT:
> perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount mnt
>     0.026311 +- 0.000869 seconds time elapsed  ( +-  3.30% )
> perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount -l mnt
>     0.003194 +- 0.000160 seconds time elapsed  ( +-  5.01% )
> 
> Signed-off-by: Alexander Larsson <alexl@redhat.com>
> Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>
> Signed-off-by: Eric Chanudet <echanude@redhat.com>
> ---
> 
> Attempt to re-spin this series based on the feedback received in v3 that
> pointed out the need to wait the grace-period in namespace_unlock()
> before calling the deferred mntput().

I still hate this with a passion because it adds another special-sauce
path into the unlock path. I've folded the following diff into it so it
at least doesn't start passing that pointless boolean and doesn't
introduce __namespace_unlock(). Just use a global variable and pick the
value off of it just as we do with the lists. Testing this now:

diff --git a/fs/namespace.c b/fs/namespace.c
index e5b0b920dd97..25599428706c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -82,8 +82,9 @@ static struct hlist_head *mount_hashtable __ro_after_init;
 static struct hlist_head *mountpoint_hashtable __ro_after_init;
 static struct kmem_cache *mnt_cache __ro_after_init;
 static DECLARE_RWSEM(namespace_sem);
-static HLIST_HEAD(unmounted);  /* protected by namespace_sem */
-static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
+static bool unmounted_lazily;          /* protected by namespace_sem */
+static HLIST_HEAD(unmounted);          /* protected by namespace_sem */
+static LIST_HEAD(ex_mountpoints);      /* protected by namespace_sem */
 static DEFINE_SEQLOCK(mnt_ns_tree_lock);

 #ifdef CONFIG_FSNOTIFY
@@ -1807,17 +1808,18 @@ static void free_mounts(struct hlist_head *mount_list)

 static void defer_free_mounts(struct work_struct *work)
 {
-       struct deferred_free_mounts *d = container_of(
-               to_rcu_work(work), struct deferred_free_mounts, rwork);
+       struct deferred_free_mounts *d;

+       d = container_of(to_rcu_work(work), struct deferred_free_mounts, rwork);
        free_mounts(&d->release_list);
        kfree(d);
 }

-static void __namespace_unlock(bool lazy)
+static void namespace_unlock(void)
 {
        HLIST_HEAD(head);
        LIST_HEAD(list);
+       bool defer = unmounted_lazily;

        hlist_move_list(&unmounted, &head);
        list_splice_init(&ex_mountpoints, &list);
@@ -1840,29 +1842,21 @@ static void __namespace_unlock(bool lazy)
        if (likely(hlist_empty(&head)))
                return;

-       if (lazy) {
-               struct deferred_free_mounts *d =
-                       kmalloc(sizeof(*d), GFP_KERNEL);
+       if (defer) {
+               struct deferred_free_mounts *d;

-               if (unlikely(!d))
-                       goto out;
-
-               hlist_move_list(&head, &d->release_list);
-               INIT_RCU_WORK(&d->rwork, defer_free_mounts);
-               queue_rcu_work(system_wq, &d->rwork);
-               return;
+               d = kmalloc(sizeof(struct deferred_free_mounts), GFP_KERNEL);
+               if (d) {
+                       hlist_move_list(&head, &d->release_list);
+                       INIT_RCU_WORK(&d->rwork, defer_free_mounts);
+                       queue_rcu_work(system_wq, &d->rwork);
+                       return;
+               }
        }
-
-out:
        synchronize_rcu_expedited();
        free_mounts(&head);
 }

-static inline void namespace_unlock(void)
-{
-       __namespace_unlock(false);
-}
-
 static inline void namespace_lock(void)
 {
        down_write(&namespace_sem);
@@ -2094,7 +2088,7 @@ static int do_umount(struct mount *mnt, int flags)
        }
 out:
        unlock_mount_hash();
-       __namespace_unlock(flags & MNT_DETACH);
+       namespace_unlock();
        return retval;
 }


> 
> v4:
> - Use queue_rcu_work() to defer free_mounts() for lazy umounts
> - Drop lazy_unlock global and refactor using a helper
> v3: https://lore.kernel.org/all/20240626201129.272750-2-lkarpins@redhat.com/
> - Removed unneeded code for lazy umount case.
> - Don't block within interrupt context.
> v2: https://lore.kernel.org/all/20240426195429.28547-1-lkarpins@redhat.com/
> - Only defer releasing umount'ed filesystems for lazy umounts
> v1: https://lore.kernel.org/all/20230119205521.497401-1-echanude@redhat.com/
> 
>  fs/namespace.c | 52 +++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 45 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 14935a0500a2..e5b0b920dd97 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -45,6 +45,11 @@ static unsigned int m_hash_shift __ro_after_init;
>  static unsigned int mp_hash_mask __ro_after_init;
>  static unsigned int mp_hash_shift __ro_after_init;
>  
> +struct deferred_free_mounts {
> +	struct rcu_work rwork;
> +	struct hlist_head release_list;
> +};
> +
>  static __initdata unsigned long mhash_entries;
>  static int __init set_mhash_entries(char *str)
>  {
> @@ -1789,11 +1794,29 @@ static bool need_notify_mnt_list(void)
>  }
>  #endif
>  
> -static void namespace_unlock(void)
> +static void free_mounts(struct hlist_head *mount_list)
>  {
> -	struct hlist_head head;
>  	struct hlist_node *p;
>  	struct mount *m;
> +
> +	hlist_for_each_entry_safe(m, p, mount_list, mnt_umount) {
> +		hlist_del(&m->mnt_umount);
> +		mntput(&m->mnt);
> +	}
> +}
> +
> +static void defer_free_mounts(struct work_struct *work)
> +{
> +	struct deferred_free_mounts *d = container_of(
> +		to_rcu_work(work), struct deferred_free_mounts, rwork);
> +
> +	free_mounts(&d->release_list);
> +	kfree(d);
> +}
> +
> +static void __namespace_unlock(bool lazy)
> +{
> +	HLIST_HEAD(head);
>  	LIST_HEAD(list);
>  
>  	hlist_move_list(&unmounted, &head);
> @@ -1817,12 +1840,27 @@ static void namespace_unlock(void)
>  	if (likely(hlist_empty(&head)))
>  		return;
>  
> -	synchronize_rcu_expedited();
> +	if (lazy) {
> +		struct deferred_free_mounts *d =
> +			kmalloc(sizeof(*d), GFP_KERNEL);
>  
> -	hlist_for_each_entry_safe(m, p, &head, mnt_umount) {
> -		hlist_del(&m->mnt_umount);
> -		mntput(&m->mnt);
> +		if (unlikely(!d))
> +			goto out;
> +
> +		hlist_move_list(&head, &d->release_list);
> +		INIT_RCU_WORK(&d->rwork, defer_free_mounts);
> +		queue_rcu_work(system_wq, &d->rwork);
> +		return;
>  	}
> +
> +out:
> +	synchronize_rcu_expedited();
> +	free_mounts(&head);
> +}
> +
> +static inline void namespace_unlock(void)
> +{
> +	__namespace_unlock(false);
>  }
>  
>  static inline void namespace_lock(void)
> @@ -2056,7 +2094,7 @@ static int do_umount(struct mount *mnt, int flags)
>  	}
>  out:
>  	unlock_mount_hash();
> -	namespace_unlock();
> +	__namespace_unlock(flags & MNT_DETACH);
>  	return retval;
>  }
>  
> -- 
> 2.49.0
> 


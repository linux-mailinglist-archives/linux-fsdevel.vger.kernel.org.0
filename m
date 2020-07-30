Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07AE2334BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 16:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbgG3OtQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 10:49:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53538 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgG3OtQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 10:49:16 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k19ri-00024s-Ov; Thu, 30 Jul 2020 14:49:02 +0000
Date:   Thu, 30 Jul 2020 16:49:02 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        areber@redhat.com, serge@hallyn.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/23] mnt: Use generic ns_common::count
Message-ID: <20200730144902.7xbcdyaseqgtvy6r@wittgenstein>
References: <159611007271.535980.15362304262237658692.stgit@localhost.localdomain>
 <159611039253.535980.5974330310695200570.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <159611039253.535980.5974330310695200570.stgit@localhost.localdomain>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 30, 2020 at 02:59:52PM +0300, Kirill Tkhai wrote:
> Convert mount namespace to use generic counter.
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---

Looks good!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

>  fs/mount.h     |    3 +--
>  fs/namespace.c |    4 ++--
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/mount.h b/fs/mount.h
> index c3e0bb6e5782..f296862032ec 100644
> --- a/fs/mount.h
> +++ b/fs/mount.h
> @@ -7,7 +7,6 @@
>  #include <linux/watch_queue.h>
>  
>  struct mnt_namespace {
> -	atomic_t		count;
>  	struct ns_common	ns;
>  	struct mount *	root;
>  	/*
> @@ -130,7 +129,7 @@ static inline void detach_mounts(struct dentry *dentry)
>  
>  static inline void get_mnt_ns(struct mnt_namespace *ns)
>  {
> -	atomic_inc(&ns->count);
> +	refcount_inc(&ns->ns.count);
>  }
>  
>  extern seqlock_t mount_lock;
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 31c387794fbd..8c39810e6ec3 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -3296,7 +3296,7 @@ static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *user_ns, bool a
>  	new_ns->ns.ops = &mntns_operations;
>  	if (!anon)
>  		new_ns->seq = atomic64_add_return(1, &mnt_ns_seq);
> -	atomic_set(&new_ns->count, 1);
> +	refcount_set(&new_ns->ns.count, 1);
>  	INIT_LIST_HEAD(&new_ns->list);
>  	init_waitqueue_head(&new_ns->poll);
>  	spin_lock_init(&new_ns->ns_lock);
> @@ -3870,7 +3870,7 @@ void __init mnt_init(void)
>  
>  void put_mnt_ns(struct mnt_namespace *ns)
>  {
> -	if (!atomic_dec_and_test(&ns->count))
> +	if (!refcount_dec_and_test(&ns->ns.count))
>  		return;
>  	drop_collected_mounts(&ns->root->mnt);
>  	free_mnt_ns(ns);
> 
> 

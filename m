Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE6143102F4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 03:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhBECrb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 21:47:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:47554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229705AbhBECr3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 21:47:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 38AF464FA7;
        Fri,  5 Feb 2021 02:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612493208;
        bh=u7fCLAhX1pOwBx9BOcb331n4nXXbCELnac9pfuMdw40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aKqP2NtJwTWkkRvAXb7ogJw+spwaPwbSFR6MdVHrrbndME/wehMGYfotFjvjy44rN
         EdnmJvO8unOg33HhXcSolWitHCL+LnXtd/2PDVjdeMUpItQyGKMMp0VBQYQTHSrIqb
         zLsSTv7Xlht5g1dcjBN4b59L57IfHiVHyB5JQe0ULO5D4icYj+qHxFrhvo2iTR1ZBl
         CdLEX8Od2/oABQQtdkcHad7hv4GhSaGt6UWHQMeWAigWU0tyrEnoqV/nnqY7ti2V5F
         g3tD5v2wmksqiD/Bg3SxiISs6hagCAqXIDn8hDPKaoMHfNQ6L4fFxY+1g3oDePZK4W
         JCnl0mclkQrbg==
Date:   Fri, 5 Feb 2021 04:46:40 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     sprabhu@redhat.com, christian@brauner.io, selinux@vger.kernel.org,
        keyrings@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org
Subject: Re: [PATCH 1/2] Add namespace tags that can be used for matching
 without pinning a ns
Message-ID: <YByxkDi0Ruhb0AA8@kernel.org>
References: <161246085160.1990927.13137391845549674518.stgit@warthog.procyon.org.uk>
 <161246085966.1990927.2555272056564793056.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161246085966.1990927.2555272056564793056.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 04, 2021 at 05:47:39PM +0000, David Howells wrote:
> Add a ns tag struct that consists of just a refcount.  It's address can be
> used to compare namespaces without the need to pin a namespace.  Just the
> tag needs pinning.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  fs/namespace.c            |   18 ++++++++----------
>  include/linux/ns_common.h |   23 +++++++++++++++++++++++
>  include/linux/proc_ns.h   |   38 +++++++++++++++++++++++++++++++++++---
>  init/version.c            |    9 ++++++++-
>  ipc/msgutil.c             |    7 ++++++-
>  ipc/namespace.c           |    8 +++-----
>  kernel/cgroup/cgroup.c    |    5 +++++
>  kernel/cgroup/namespace.c |    6 +++---
>  kernel/pid.c              |    5 +++++
>  kernel/pid_namespace.c    |   18 +++++++++---------
>  kernel/time/namespace.c   |   13 +++++--------
>  kernel/user.c             |    5 +++++
>  kernel/user_namespace.c   |    7 +++----
>  kernel/utsname.c          |   24 +++++++++++++-----------
>  net/core/net_namespace.c  |   38 +++++++++++++++-----------------------
>  15 files changed, 146 insertions(+), 78 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 9d33909d0f9e..f8da9be8c6f7 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -3238,10 +3238,9 @@ static void dec_mnt_namespaces(struct ucounts *ucounts)
>  
>  static void free_mnt_ns(struct mnt_namespace *ns)
>  {
> -	if (!is_anon_ns(ns))
> -		ns_free_inum(&ns->ns);
>  	dec_mnt_namespaces(ns->ucounts);
>  	put_user_ns(ns->user_ns);
> +	destroy_ns_common(&ns->ns);
>  	kfree(ns);
>  }
>  
> @@ -3269,18 +3268,17 @@ static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *user_ns, bool a
>  		dec_mnt_namespaces(ucounts);
>  		return ERR_PTR(-ENOMEM);
>  	}
> -	if (!anon) {
> -		ret = ns_alloc_inum(&new_ns->ns);
> -		if (ret) {
> -			kfree(new_ns);
> -			dec_mnt_namespaces(ucounts);
> -			return ERR_PTR(ret);
> -		}
> +
> +	ret = init_ns_common(&new_ns->ns, anon);
> +	if (ret) {
> +		destroy_ns_common(&new_ns->ns);
> +		kfree(new_ns);
> +		dec_mnt_namespaces(ucounts);
> +		return ERR_PTR(ret);
>  	}
>  	new_ns->ns.ops = &mntns_operations;
>  	if (!anon)
>  		new_ns->seq = atomic64_add_return(1, &mnt_ns_seq);
> -	refcount_set(&new_ns->ns.count, 1);
>  	INIT_LIST_HEAD(&new_ns->list);
>  	init_waitqueue_head(&new_ns->poll);
>  	spin_lock_init(&new_ns->ns_lock);
> diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
> index 0f1d024bd958..45174ad8a435 100644
> --- a/include/linux/ns_common.h
> +++ b/include/linux/ns_common.h
> @@ -3,14 +3,37 @@
>  #define _LINUX_NS_COMMON_H
>  
>  #include <linux/refcount.h>
> +#include <linux/slab.h>
>  
>  struct proc_ns_operations;
>  
> +/*
> + * Comparable tag for namespaces so that namespaces don't have to be pinned by
> + * something that wishes to detect if a namespace matches a criterion.
> + */
> +struct ns_tag {
> +	refcount_t	usage;

Is that indentation necessary? I'd put just a space.

> +};
> +
>  struct ns_common {
>  	atomic_long_t stashed;
>  	const struct proc_ns_operations *ops;
> +	struct ns_tag *tag;
>  	unsigned int inum;
>  	refcount_t count;
>  };
>  
> +static inline struct ns_tag *get_ns_tag(struct ns_tag *tag)
> +{
> +	if (tag)
> +		refcount_inc(&tag->usage);
> +	return tag;
> +}
> +
> +static inline void put_ns_tag(struct ns_tag *tag)
> +{
> +	if (tag && refcount_dec_and_test(&tag->usage))
> +		kfree(tag);
> +}
> +
>  #endif
> diff --git a/include/linux/proc_ns.h b/include/linux/proc_ns.h
> index 75807ecef880..9fb7eb403923 100644
> --- a/include/linux/proc_ns.h
> +++ b/include/linux/proc_ns.h
> @@ -64,13 +64,45 @@ static inline void proc_free_inum(unsigned int inum) {}
>  
>  #endif /* CONFIG_PROC_FS */
>  
> -static inline int ns_alloc_inum(struct ns_common *ns)
> +/**
> + * init_ns_common - Initialise the common part of a namespace

Nit: init_ns_common()

> + * @ns: The namespace to initialise
> + * @anon: The namespace will be anonymous
> + *
> + * Set up the common part of a namespace, assigning an inode number and
> + * creating a tag.  Returns 0 on success and a negative error code on failure.
> + * On failure, the caller must call destroy_ns_common().

I've used lately (e.g. arch/x86/kernel/cpu/sgx/ioctl.c) along the lines:

* Return:
* - 0:          Initialization was successful.
* - -ENOMEM:    Out of memory.

Looking at the implementation, I guess this is a complete representation of
what it can return?

The driving point here is that this nicely lines up when rendered with
"make htmldocs".

> + */
> +static inline int init_ns_common(struct ns_common *ns, bool anon)
>  {
> +	struct ns_tag *tag;
> +
> +	tag = kzalloc(sizeof(*tag), GFP_KERNEL);
> +	if (!tag)
> +		return -ENOMEM;
> +
> +	refcount_set(&tag->usage, 1);
> +	ns->tag = tag;
> +	ns->inum = 0;
>  	atomic_long_set(&ns->stashed, 0);
> -	return proc_alloc_inum(&ns->inum);
> +	refcount_set(&ns->count, 1);
> +
> +	return anon ? 0 : proc_alloc_inum(&ns->inum);
>  }
>  
> -#define ns_free_inum(ns) proc_free_inum((ns)->inum)
> +/**
> + * destroy_ns_common - Clean up the common part of a namespace

Nit: destroy_ns_common()

/Jarkko

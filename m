Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E632334B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 16:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgG3OrJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 10:47:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53496 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgG3OrI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 10:47:08 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k19pS-0001p0-Ro; Thu, 30 Jul 2020 14:46:42 +0000
Date:   Thu, 30 Jul 2020 16:46:41 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        areber@redhat.com, serge@hallyn.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/23] user: Use generic ns_common::count
Message-ID: <20200730144641.rep2ht5lmnryfhzj@wittgenstein>
References: <159611007271.535980.15362304262237658692.stgit@localhost.localdomain>
 <159611038719.535980.13960315152927389105.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <159611038719.535980.13960315152927389105.stgit@localhost.localdomain>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 30, 2020 at 02:59:47PM +0300, Kirill Tkhai wrote:
> Convert user namespace to use generic counter.
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---

Looks good!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

>  include/linux/user_namespace.h |    5 ++---
>  kernel/user.c                  |    2 +-
>  kernel/user_namespace.c        |    4 ++--
>  3 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
> index 6ef1c7109fc4..64cf8ebdc4ec 100644
> --- a/include/linux/user_namespace.h
> +++ b/include/linux/user_namespace.h
> @@ -57,7 +57,6 @@ struct user_namespace {
>  	struct uid_gid_map	uid_map;
>  	struct uid_gid_map	gid_map;
>  	struct uid_gid_map	projid_map;
> -	atomic_t		count;
>  	struct user_namespace	*parent;
>  	int			level;
>  	kuid_t			owner;
> @@ -109,7 +108,7 @@ void dec_ucount(struct ucounts *ucounts, enum ucount_type type);
>  static inline struct user_namespace *get_user_ns(struct user_namespace *ns)
>  {
>  	if (ns)
> -		atomic_inc(&ns->count);
> +		refcount_inc(&ns->ns.count);
>  	return ns;
>  }
>  
> @@ -119,7 +118,7 @@ extern void __put_user_ns(struct user_namespace *ns);
>  
>  static inline void put_user_ns(struct user_namespace *ns)
>  {
> -	if (ns && atomic_dec_and_test(&ns->count))
> +	if (ns && refcount_dec_and_test(&ns->ns.count))
>  		__put_user_ns(ns);
>  }
>  
> diff --git a/kernel/user.c b/kernel/user.c
> index b1635d94a1f2..a2478cddf536 100644
> --- a/kernel/user.c
> +++ b/kernel/user.c
> @@ -55,7 +55,7 @@ struct user_namespace init_user_ns = {
>  			},
>  		},
>  	},
> -	.count = ATOMIC_INIT(3),
> +	.ns.count = REFCOUNT_INIT(3),

Note-to-self: I really wish we'd had a comment in cases where the
refcount isn't set to 1 but to something like 3. Otherwise one always
needs to dig up the reasons why. :)

>  	.owner = GLOBAL_ROOT_UID,
>  	.group = GLOBAL_ROOT_GID,
>  	.ns.inum = PROC_USER_INIT_INO,
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index 87804e0371fe..7c2bbe8f3e45 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -111,7 +111,7 @@ int create_user_ns(struct cred *new)
>  		goto fail_free;
>  	ns->ns.ops = &userns_operations;
>  
> -	atomic_set(&ns->count, 1);
> +	refcount_set(&ns->ns.count, 1);
>  	/* Leave the new->user_ns reference with the new user namespace. */
>  	ns->parent = parent_ns;
>  	ns->level = parent_ns->level + 1;
> @@ -197,7 +197,7 @@ static void free_user_ns(struct work_struct *work)
>  		kmem_cache_free(user_ns_cachep, ns);
>  		dec_user_namespaces(ucounts);
>  		ns = parent;
> -	} while (atomic_dec_and_test(&parent->count));
> +	} while (refcount_dec_and_test(&parent->ns.count));
>  }
>  
>  void __put_user_ns(struct user_namespace *ns)
> 
> 

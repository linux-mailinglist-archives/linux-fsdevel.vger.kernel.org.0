Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4037D2334C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 16:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbgG3Ouv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 10:50:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53601 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgG3Ouv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 10:50:51 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k19tF-0002C4-Vu; Thu, 30 Jul 2020 14:50:38 +0000
Date:   Thu, 30 Jul 2020 16:50:37 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        areber@redhat.com, serge@hallyn.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 07/23] cgroup: Use generic ns_common::count
Message-ID: <20200730145037.ldayhoktgg73cu6y@wittgenstein>
References: <159611007271.535980.15362304262237658692.stgit@localhost.localdomain>
 <159611039786.535980.12848941118631845247.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <159611039786.535980.12848941118631845247.stgit@localhost.localdomain>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 30, 2020 at 02:59:57PM +0300, Kirill Tkhai wrote:
> Convert cgroup namespace to use generic counter.
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---

Looks good!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

>  include/linux/cgroup.h    |    5 ++---
>  kernel/cgroup/cgroup.c    |    2 +-
>  kernel/cgroup/namespace.c |    2 +-
>  3 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index 618838c48313..451c2d26a5db 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -854,7 +854,6 @@ static inline void cgroup_sk_free(struct sock_cgroup_data *skcd) {}
>  #endif	/* CONFIG_CGROUP_DATA */
>  
>  struct cgroup_namespace {
> -	refcount_t		count;
>  	struct ns_common	ns;
>  	struct user_namespace	*user_ns;
>  	struct ucounts		*ucounts;
> @@ -889,12 +888,12 @@ copy_cgroup_ns(unsigned long flags, struct user_namespace *user_ns,
>  static inline void get_cgroup_ns(struct cgroup_namespace *ns)
>  {
>  	if (ns)
> -		refcount_inc(&ns->count);
> +		refcount_inc(&ns->ns.count);
>  }
>  
>  static inline void put_cgroup_ns(struct cgroup_namespace *ns)
>  {
> -	if (ns && refcount_dec_and_test(&ns->count))
> +	if (ns && refcount_dec_and_test(&ns->ns.count))
>  		free_cgroup_ns(ns);
>  }
>  
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index dd247747ec14..22e466926853 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -199,7 +199,7 @@ static u16 have_canfork_callback __read_mostly;
>  
>  /* cgroup namespace for init task */
>  struct cgroup_namespace init_cgroup_ns = {
> -	.count		= REFCOUNT_INIT(2),
> +	.ns.count	= REFCOUNT_INIT(2),
>  	.user_ns	= &init_user_ns,
>  	.ns.ops		= &cgroupns_operations,
>  	.ns.inum	= PROC_CGROUP_INIT_INO,
> diff --git a/kernel/cgroup/namespace.c b/kernel/cgroup/namespace.c
> index 812a61afd538..f5e8828c109c 100644
> --- a/kernel/cgroup/namespace.c
> +++ b/kernel/cgroup/namespace.c
> @@ -32,7 +32,7 @@ static struct cgroup_namespace *alloc_cgroup_ns(void)
>  		kfree(new_ns);
>  		return ERR_PTR(ret);
>  	}
> -	refcount_set(&new_ns->count, 1);
> +	refcount_set(&new_ns->ns.count, 1);
>  	new_ns->ns.ops = &cgroupns_operations;
>  	return new_ns;
>  }
> 
> 

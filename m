Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39494233474
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 16:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbgG3Oas (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 10:30:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52919 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgG3Oar (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 10:30:47 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k19Zs-0000ZK-2Y; Thu, 30 Jul 2020 14:30:36 +0000
Date:   Thu, 30 Jul 2020 16:30:35 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        areber@redhat.com, serge@hallyn.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/23] uts: Use generic ns_common::count
Message-ID: <20200730143035.c4c2n3g25wm5u7bk@wittgenstein>
References: <159611007271.535980.15362304262237658692.stgit@localhost.localdomain>
 <159611037120.535980.13731766189011538488.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <159611037120.535980.13731766189011538488.stgit@localhost.localdomain>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 30, 2020 at 02:59:31PM +0300, Kirill Tkhai wrote:
> Convert uts namespace to use generic counter instead of kref.
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---

(sidenote: given that kref is implemented on top of refcount_t I wonder
 whether we shouldn't just slowly convert all places where kref is used
 to refcount_t and remove the kref api.)

Looks good!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

>  include/linux/utsname.h |    9 ++++-----
>  init/version.c          |    2 +-
>  kernel/utsname.c        |    7 ++-----
>  3 files changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/utsname.h b/include/linux/utsname.h
> index 44429d9142ca..2b1737c9b244 100644
> --- a/include/linux/utsname.h
> +++ b/include/linux/utsname.h
> @@ -4,7 +4,6 @@
>  
>  
>  #include <linux/sched.h>
> -#include <linux/kref.h>
>  #include <linux/nsproxy.h>
>  #include <linux/ns_common.h>
>  #include <linux/err.h>
> @@ -22,7 +21,6 @@ struct user_namespace;
>  extern struct user_namespace init_user_ns;
>  
>  struct uts_namespace {
> -	struct kref kref;
>  	struct new_utsname name;
>  	struct user_namespace *user_ns;
>  	struct ucounts *ucounts;
> @@ -33,16 +31,17 @@ extern struct uts_namespace init_uts_ns;
>  #ifdef CONFIG_UTS_NS
>  static inline void get_uts_ns(struct uts_namespace *ns)
>  {
> -	kref_get(&ns->kref);
> +	refcount_inc(&ns->ns.count);
>  }
>  
>  extern struct uts_namespace *copy_utsname(unsigned long flags,
>  	struct user_namespace *user_ns, struct uts_namespace *old_ns);
> -extern void free_uts_ns(struct kref *kref);
> +extern void free_uts_ns(struct uts_namespace *ns);
>  
>  static inline void put_uts_ns(struct uts_namespace *ns)
>  {
> -	kref_put(&ns->kref, free_uts_ns);
> +	if (refcount_dec_and_test(&ns->ns.count))
> +		free_uts_ns(ns);
>  }
>  
>  void uts_ns_init(void);
> diff --git a/init/version.c b/init/version.c
> index cba341161b58..80d2b7566b39 100644
> --- a/init/version.c
> +++ b/init/version.c
> @@ -25,7 +25,7 @@ int version_string(LINUX_VERSION_CODE);
>  #endif
>  
>  struct uts_namespace init_uts_ns = {
> -	.kref = KREF_INIT(2),
> +	.ns.count = REFCOUNT_INIT(2),
>  	.name = {
>  		.sysname	= UTS_SYSNAME,
>  		.nodename	= UTS_NODENAME,
> diff --git a/kernel/utsname.c b/kernel/utsname.c
> index e488d0e2ab45..b1ac3ca870f2 100644
> --- a/kernel/utsname.c
> +++ b/kernel/utsname.c
> @@ -33,7 +33,7 @@ static struct uts_namespace *create_uts_ns(void)
>  
>  	uts_ns = kmem_cache_alloc(uts_ns_cache, GFP_KERNEL);
>  	if (uts_ns)
> -		kref_init(&uts_ns->kref);
> +		refcount_set(&uts_ns->ns.count, 1);
>  	return uts_ns;
>  }
>  
> @@ -103,11 +103,8 @@ struct uts_namespace *copy_utsname(unsigned long flags,
>  	return new_ns;
>  }
>  
> -void free_uts_ns(struct kref *kref)
> +void free_uts_ns(struct uts_namespace *ns)
>  {
> -	struct uts_namespace *ns;
> -
> -	ns = container_of(kref, struct uts_namespace, kref);
>  	dec_uts_namespaces(ns->ucounts);
>  	put_user_ns(ns->user_ns);
>  	ns_free_inum(&ns->ns);
> 
> 

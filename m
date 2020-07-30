Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCB12334CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 16:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgG3Owb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 10:52:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53696 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgG3Owa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 10:52:30 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k19uq-0002LB-Tx; Thu, 30 Jul 2020 14:52:17 +0000
Date:   Thu, 30 Jul 2020 16:52:16 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        areber@redhat.com, serge@hallyn.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 08/23] time: Use generic ns_common::count
Message-ID: <20200730145216.ob5cld7rfgqpynx4@wittgenstein>
References: <159611007271.535980.15362304262237658692.stgit@localhost.localdomain>
 <159611040338.535980.6847379168016198580.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <159611040338.535980.6847379168016198580.stgit@localhost.localdomain>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 30, 2020 at 03:00:03PM +0300, Kirill Tkhai wrote:
> Convert time namespace to use generic counter.
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---

Looks good!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

>  include/linux/time_namespace.h |    9 ++++-----
>  kernel/time/namespace.c        |    9 +++------
>  2 files changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
> index 5b6031385db0..a51ffc089219 100644
> --- a/include/linux/time_namespace.h
> +++ b/include/linux/time_namespace.h
> @@ -4,7 +4,6 @@
>  
>  
>  #include <linux/sched.h>
> -#include <linux/kref.h>
>  #include <linux/nsproxy.h>
>  #include <linux/ns_common.h>
>  #include <linux/err.h>
> @@ -18,7 +17,6 @@ struct timens_offsets {
>  };
>  
>  struct time_namespace {
> -	struct kref		kref;
>  	struct user_namespace	*user_ns;
>  	struct ucounts		*ucounts;
>  	struct ns_common	ns;
> @@ -37,20 +35,21 @@ extern void timens_commit(struct task_struct *tsk, struct time_namespace *ns);
>  
>  static inline struct time_namespace *get_time_ns(struct time_namespace *ns)
>  {
> -	kref_get(&ns->kref);
> +	refcount_inc(&ns->ns.count);
>  	return ns;
>  }
>  
>  struct time_namespace *copy_time_ns(unsigned long flags,
>  				    struct user_namespace *user_ns,
>  				    struct time_namespace *old_ns);
> -void free_time_ns(struct kref *kref);
> +void free_time_ns(struct time_namespace *ns);
>  int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk);
>  struct vdso_data *arch_get_vdso_data(void *vvar_page);
>  
>  static inline void put_time_ns(struct time_namespace *ns)
>  {
> -	kref_put(&ns->kref, free_time_ns);
> +	if (refcount_dec_and_test(&ns->ns.count))
> +		free_time_ns(ns);
>  }
>  
>  void proc_timens_show_offsets(struct task_struct *p, struct seq_file *m);
> diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
> index afc65e6be33e..c4c829eb3511 100644
> --- a/kernel/time/namespace.c
> +++ b/kernel/time/namespace.c
> @@ -92,7 +92,7 @@ static struct time_namespace *clone_time_ns(struct user_namespace *user_ns,
>  	if (!ns)
>  		goto fail_dec;
>  
> -	kref_init(&ns->kref);
> +	refcount_set(&ns->ns.count, 1);
>  
>  	ns->vvar_page = alloc_page(GFP_KERNEL | __GFP_ZERO);
>  	if (!ns->vvar_page)
> @@ -226,11 +226,8 @@ static void timens_set_vvar_page(struct task_struct *task,
>  	mutex_unlock(&offset_lock);
>  }
>  
> -void free_time_ns(struct kref *kref)
> +void free_time_ns(struct time_namespace *ns)
>  {
> -	struct time_namespace *ns;
> -
> -	ns = container_of(kref, struct time_namespace, kref);
>  	dec_time_namespaces(ns->ucounts);
>  	put_user_ns(ns->user_ns);
>  	ns_free_inum(&ns->ns);
> @@ -464,7 +461,7 @@ const struct proc_ns_operations timens_for_children_operations = {
>  };
>  
>  struct time_namespace init_time_ns = {
> -	.kref		= KREF_INIT(3),
> +	.ns.count	= REFCOUNT_INIT(3),
>  	.user_ns	= &init_user_ns,
>  	.ns.inum	= PROC_TIME_INIT_INO,
>  	.ns.ops		= &timens_operations,
> 
> 

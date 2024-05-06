Return-Path: <linux-fsdevel+bounces-18850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 183968BD457
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 20:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B11E1C21F0D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 18:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD50F158A12;
	Mon,  6 May 2024 18:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IybRH3Bk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2F9158858
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 May 2024 18:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715018649; cv=none; b=OvjfKB3Fno/XU9tyjfgT0++U6WiKVVrbyIYEka86dg2dY6HWicSl+Q0/UxKvDEoLgawN82c31xDA3SSXTTEAr4J4byrvUSPIEAGyStq0aF22erIdMCco0nQm+9WY3bUjzXyjgdLFKwESuJrm8MCJ2qfZcZ8nirzM/WyinD8nJ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715018649; c=relaxed/simple;
	bh=cc0dgGUZ/hvp7voZKbxcv7WPIlbtst12WAtyfGKBIzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iRbqhn27kF3+cfCuYTrl4n9nNnfvVNmgiPzate7vTE06aQY4enX9CUG9cM6wB98ITxCwwSsoUZ7eiCjNTj76Ma8/Esoj/Lgs+ALF7XNCpGZPhCS3LIu/c2QWH1GEJ6EJVsKVa5OEzKcXUprlPtCWHzZbqD89Ih3lu60WCdFWtz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IybRH3Bk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715018646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j1t65TpAxApNWvGUATTUAN4i+2enA4mnbGpByW0FY6g=;
	b=IybRH3Bkv13w0PywuwTN4w/dQRsp07/clBBZ9lPkhc0qRe04DofOuj8muj2fyhHIKfBg6i
	TicXyyERwdag49SdUIWIO7YgAWUX0LiC3rz4rbzGL3c62cXlT+b0B0O30H45glIWxocQnp
	XWOgmiXSGQcHLkXATpRLbIe259ZXAWE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-BbtS0UsSPoOQu8bUEI9Fjw-1; Mon, 06 May 2024 14:03:59 -0400
X-MC-Unique: BbtS0UsSPoOQu8bUEI9Fjw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CEED1800CA2;
	Mon,  6 May 2024 18:03:58 +0000 (UTC)
Received: from [10.22.17.85] (unknown [10.22.17.85])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 24C2A40D1E3;
	Mon,  6 May 2024 18:03:56 +0000 (UTC)
Message-ID: <e402d623-1875-47a2-9db3-8299a54502ef@redhat.com>
Date: Mon, 6 May 2024 14:03:55 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/proc: Print user_cpus_ptr for task status
To: Xuewen Yan <xuewen.yan94@gmail.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, akpm@linux-foundation.org,
 oleg@redhat.com, dylanbhatch@google.com, rick.p.edgecombe@intel.com,
 ke.wang@unisoc.com, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20240429084633.9800-1-xuewen.yan@unisoc.com>
 <20240429121000.GA40213@noisy.programming.kicks-ass.net>
 <CAB8ipk831xtAW2+sm-evm-oOsFspL=xSp6hFYYq1uKmWA+porQ@mail.gmail.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <CAB8ipk831xtAW2+sm-evm-oOsFspL=xSp6hFYYq1uKmWA+porQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On 5/6/24 04:04, Xuewen Yan wrote:
> Hi Peter
>
> On Mon, Apr 29, 2024 at 8:10 PM Peter Zijlstra <peterz@infradead.org> wrote:
>> On Mon, Apr 29, 2024 at 04:46:33PM +0800, Xuewen Yan wrote:
>>> The commit 851a723e45d1c("sched: Always clear user_cpus_ptr in do_set_cpus_allowed()")
>>> would clear the user_cpus_ptr when call the do_set_cpus_allowed.
>>>
>>> In order to determine whether the user_cpus_ptr is taking effect,
>>> it is better to print the task's user_cpus_ptr.
>> This is an ABI change and would mandate we forever more have this
>> distinction. I don't think your changes justifies things sufficiently
>> for this.
> I added this mainly because online/offline cpu will produce different
> results for the !top-cpuset task.
>
> For example:
>
> If the task was running, then offline task's cpus, would lead to clear
> its user-mask.
>
> unisoc:/ # while true; do sleep 600; done&
> [1] 6786
> unisoc:/ # echo 6786 > /dev/cpuset/top-app/tasks
> unisoc:/ # cat /dev/cpuset/top-app/cpus
> 0-7
> unisoc:/ # cat /proc/6786/status | grep Cpus
> Cpus_allowed:   ff
> Cpus_allowed_list:      0-7
> Cpus_user_allowed:        (null)
> Cpus_user_allowed_list:   (null)
>
> unisoc:/ # taskset -p c0 6786
> pid 6786's current affinity mask: ff
> pid 6786's new affinity mask: c0
> unisoc:/ # cat /proc/6786/status | grep Cpus
> Cpus_allowed:   c0
> Cpus_allowed_list:      6-7
> Cpus_user_allowed:      c0
> Cpus_user_allowed_list: 6-7
>
> After offline the cpu6 and cpu7, the user-mask would be cleared:
>
> unisoc:/ # echo 0 > /sys/devices/system/cpu/cpu7/online
> unisoc:/ # cat /proc/6786/status | grep Cpus
> Cpus_allowed:   40
> Cpus_allowed_list:      6
> Cpus_user_allowed:      c0
> Cpus_user_allowed_list: 6-7
> ums9621_1h10:/ # echo 0 > /sys/devices/system/cpu/cpu6/online
> ums9621_1h10:/ # cat /proc/6786/status | grep Cpus
> Cpus_allowed:   3f
> Cpus_allowed_list:      0-5
> Cpus_user_allowed:        (null)
> Cpus_user_allowed_list:   (null)
>
> When online the cpu6/7, the user-mask can not bring back:
>
> unisoc:/ # echo 1 > /sys/devices/system/cpu/cpu6/online
> unisoc:/ # cat /proc/6786/status | grep Cpus
> Cpus_allowed:   7f
> Cpus_allowed_list:      0-6
> Cpus_user_allowed:        (null)
> Cpus_user_allowed_list:   (null)
> unisoc:/ # echo 1 > /sys/devices/system/cpu/cpu7/online
> unisoc:/ # cat /proc/6786/status | grep Cpus
> Cpus_allowed:   ff
> Cpus_allowed_list:      0-7
> Cpus_user_allowed:        (null)
> Cpus_user_allowed_list:   (null)
>
> However, if we offline the cpu when the task is sleeping, at this
> time, because would not call the fallback_cpu(), its user-mask will
> not be cleared.
>
> unisoc:/ # while true; do sleep 600; done&
> [1] 5990
> unisoc:/ # echo 5990 > /dev/cpuset/top-app/tasks
> unisoc:/ # cat /proc/5990/status | grep Cpus
> Cpus_allowed:   ff
> Cpus_allowed_list:      0-7
> Cpus_user_allowed:        (null)
> Cpus_user_allowed_list:   (null)
>
> unisoc:/ # taskset -p c0 5990
> pid 5990's current affinity mask: ff
> pid 5990's new affinity mask: c0
> unisoc:/ # cat /proc/5990/status | grep Cpus
> Cpus_allowed:   c0
> Cpus_allowed_list:      6-7
> Cpus_user_allowed:      c0
> Cpus_user_allowed_list: 6-7
>
> unisoc:/ # echo 0 > /sys/devices/system/cpu/cpu6/online
> unisoc:/ # cat /proc/5990/status | grep Cpus
> Cpus_allowed:   80
> Cpus_allowed_list:      7
> Cpus_user_allowed:      c0
> Cpus_user_allowed_list: 6-7
> unisoc:/ # echo 0 > /sys/devices/system/cpu/cpu7/online
> unisoc:/ # cat /proc/5990/status | grep Cpus
> Cpus_allowed:   3f
> Cpus_allowed_list:      0-5
> Cpus_user_allowed:      c0
> Cpus_user_allowed_list: 6-7
>
>
> After 10 minutes, it was waked up, it can also keep its user-mask:
> ums9621_1h10:/ # cat /proc/5990/status | grep Cpus
> Cpus_allowed:   3f
> Cpus_allowed_list:      0-5
> Cpus_user_allowed:      c0
> Cpus_user_allowed_list: 6-7
>
> In order to solve the above problem, I modified the following patch.
> At this time, for !top-cpuset, regardless of whether the task is in
> the running state when offline cpu, its cpu-mask can be maintained.
> However, this patch may not be perfect yet, so I send the "Print
> user_cpus_ptr for task status" patch first to debug more conveniently.
>
> --->
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 68cfa656b9b1..00879b6de8d4 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1870,7 +1870,7 @@ extern void dl_bw_free(int cpu, u64 dl_bw);
>   #ifdef CONFIG_SMP
>
>   /* do_set_cpus_allowed() - consider using set_cpus_allowed_ptr() instead */
> -extern void do_set_cpus_allowed(struct task_struct *p, const struct
> cpumask *new_mask);
> +extern void do_set_cpus_allowed(struct task_struct *p, const struct
> cpumask *new_mask, bool keep_user);
>
>   /**
>    * set_cpus_allowed_ptr - set CPU affinity mask of a task
> @@ -1886,7 +1886,7 @@ extern int dl_task_check_affinity(struct
> task_struct *p, const struct cpumask *m
>   extern void force_compatible_cpus_allowed_ptr(struct task_struct *p);
>   extern void relax_compatible_cpus_allowed_ptr(struct task_struct *p);
>   #else
> -static inline void do_set_cpus_allowed(struct task_struct *p, const
> struct cpumask *new_mask)
> +static inline void do_set_cpus_allowed(struct task_struct *p, const
> struct cpumask *new_mask, bool keep_user)
>   {
>   }
>   static inline int set_cpus_allowed_ptr(struct task_struct *p, const
> struct cpumask *new_mask)
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 7ee9994aee40..0c448f8a3829 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -4005,9 +4005,14 @@ bool cpuset_cpus_allowed_fallback(struct
> task_struct *tsk)
>
>          rcu_read_lock();
>          cs_mask = task_cs(tsk)->cpus_allowed;
> -       if (is_in_v2_mode() && cpumask_subset(cs_mask, possible_mask)) {
> -               do_set_cpus_allowed(tsk, cs_mask);
> -               changed = true;
> +       if (cpumask_subset(cs_mask, possible_mask)) {
> +               if (is_in_v2_mode()) {
> +                       do_set_cpus_allowed(tsk, cs_mask, false);
> +                       changed = true;
> +               } else if (task_cs(tsk) != &top_cpuset) {
> +                       do_set_cpus_allowed(tsk, cs_mask, true);
> +                       changed = true;
> +               }
>          }
>          rcu_read_unlock();
>
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 7a7aa5f93c0c..7ede27630088 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -527,7 +527,7 @@ static void __kthread_bind_mask(struct task_struct
> *p, const struct cpumask *mas
>
>          /* It's safe because the task is inactive. */
>          raw_spin_lock_irqsave(&p->pi_lock, flags);
> -       do_set_cpus_allowed(p, mask);
> +       do_set_cpus_allowed(p, mask, false);
>          p->flags |= PF_NO_SETAFFINITY;
>          raw_spin_unlock_irqrestore(&p->pi_lock, flags);
>   }
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 33cfd522fc7c..623f89e65e6c 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2855,18 +2855,21 @@ __do_set_cpus_allowed(struct task_struct *p,
> struct affinity_context *ctx)
>    * Used for kthread_bind() and select_fallback_rq(), in both cases the user
>    * affinity (if any) should be destroyed too.
>    */
> -void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
> +void do_set_cpus_allowed(struct task_struct *p, const struct cpumask
> *new_mask, bool keep_user)
>   {
>          struct affinity_context ac = {
>                  .new_mask  = new_mask,
>                  .user_mask = NULL,
> -               .flags     = SCA_USER,  /* clear the user requested mask */
> +               .flags     = 0, /* clear the user requested mask */
>          };
>          union cpumask_rcuhead {
>                  cpumask_t cpumask;
>                  struct rcu_head rcu;
>          };
>
> +       if (!keep_user)
> +               ac.flags = SCA_USER;
> +
>          __do_set_cpus_allowed(p, &ac);
>
>          /*
> @@ -2874,7 +2877,8 @@ void do_set_cpus_allowed(struct task_struct *p,
> const struct cpumask *new_mask)
>           * to use kfree() here (when PREEMPT_RT=y), therefore punt to using
>           * kfree_rcu().
>           */
> -       kfree_rcu((union cpumask_rcuhead *)ac.user_mask, rcu);
> +       if (!keep_user)
> +               kfree_rcu((union cpumask_rcuhead *)ac.user_mask, rcu);
>   }
>
>   static cpumask_t *alloc_user_cpus_ptr(int node)
> @@ -3664,7 +3668,7 @@ int select_fallback_rq(int cpu, struct task_struct *p)
>                           *
>                           * More yuck to audit.
>                           */
> -                       do_set_cpus_allowed(p, task_cpu_possible_mask(p));
> +                       do_set_cpus_allowed(p,
> task_cpu_possible_mask(p), false);
>                          state = fail;
>                          break;
>                  case fail:
>
These changes essentially reverts commit 851a723e45d1c("sched: Always 
clear user_cpus_ptr in do_set_cpus_allowed()") except the additional 
caller in the cpuset code.

How about the following less invasive change?

  diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7019a40457a6..646837eab70c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2796,21 +2796,24 @@ __do_set_cpus_allowed(struct task_struct *p, 
struct affinity_context *ctx)
  }

  /*
- * Used for kthread_bind() and select_fallback_rq(), in both cases the user
- * affinity (if any) should be destroyed too.
+ * Used for kthread_bind() and select_fallback_rq(). Destroy user affinity
+ * if no intersection with the new mask.
   */
  void do_set_cpus_allowed(struct task_struct *p, const struct cpumask 
*new_mask)
  {
         struct affinity_context ac = {
                 .new_mask  = new_mask,
                 .user_mask = NULL,
-               .flags     = SCA_USER,  /* clear the user requested mask */
+               .flags     = 0,
         };
         union cpumask_rcuhead {
                 cpumask_t cpumask;
                 struct rcu_head rcu;
         };

+       if (current->user_cpus_ptr && 
!cpumask_intersects(current->user_cpus_ptr, new_mask))
+               ac.flags = SCA_USER;    /* clear the user requested mask */
+
         __do_set_cpus_allowed(p, &ac);

         /*

No compilation test done. Note that there is a null check inside 
kfree_rcu() with no need for additional check.

Regards,
Longman




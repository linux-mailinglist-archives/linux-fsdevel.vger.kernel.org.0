Return-Path: <linux-fsdevel+bounces-18875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AA98BDBF0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 08:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0B06283B02
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 06:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2029E78C93;
	Tue,  7 May 2024 06:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+HG+Xau"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE57678C85;
	Tue,  7 May 2024 06:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715065069; cv=none; b=kSuPpwA+eL7n6T3QfkZcSOXor0XG6qMQDfUXSMnC2aTpU08p3gnVthompjMIh3ueE19DWlYdl7g3CXu0BOtmzAkVWqLZCcnEgGihxr2VocHFi3znLmQM8PRP7C5a7hG1/qzNT2ZW1iiLVIV5NZcUQvlYsr3zcBqLwcJ21aSDvfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715065069; c=relaxed/simple;
	bh=DHLux9snFVHvMMrDQgQAnqo29z93IsToHOHIIziVqiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G7QU/SApyAqi6PJccsWjFeIbepfhJCLlIMKorHuXD96o5mz1RyywwAd6/tuNoYqopPuuVq8v9lSJavZKMVjlnCtKsGbiVeszoOrUt/ws26YmZ+aKoWarqvK8MTcbJXRc5hWehDxheI4g0JgbY9HXUqmhOmJwP+u4giVZwtasu8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+HG+Xau; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-23dd94111cfso1374961fac.2;
        Mon, 06 May 2024 23:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715065067; x=1715669867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ev8YLcpQenkpEG+X5aFgFe5AO5nkBlHJBIXncatkO2U=;
        b=l+HG+Xauh67HlAUxceLlROW2VHXC5W1s1Ed6LSNe5leHG2YZiNH89q2hx/Crz1hptX
         jzsOJzQAiHF82MBAxuFrknBP2Sg/K24kWjgjhOtciGMY15XMQZrh8GfJ/XTQYlPo7by6
         WE0+0Xf8gqJQYs58K4HQ+2I7YBCJX1N85TzDUU4XD9QHgKr93Qh9kfzF1JAhjTVnQExv
         tK/DlEg+35jAJQUnR184X5IvBBVVNpwdG5g9gxCTiJrcDWd648gSqcU081OTwNcEPC15
         8n5+enH/SUt7dbsuNCC9WGWXSMqNLqj8VcW4Rq8ccyX7XlK7hfILKS1rbmVWSMwDa8dE
         suZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715065067; x=1715669867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ev8YLcpQenkpEG+X5aFgFe5AO5nkBlHJBIXncatkO2U=;
        b=KqamgNsxSSS4ZibqyAtzMaeM09S6YM+bAQSl/DeyDV6aqCJM3F978AyvdQGY9jyEer
         2rr1PAGGEdTqIqtAorUzY2gdy5rYMkUkGgAMGnY29ZTWpLvRF5H0b/2Jf4j32LmL/tXG
         CvcEKh0ScI2T1Hb7HB1upCQhW4M0BHGw57cGbH6TNlBwMh83WysiKk6JJImNaHK/0kP3
         9z8mVWo1blDh4w7x7fnwxZJpl/84AgDjvdenwwE9+Tz1akp+gyFTd6oOux+0vh5ert1s
         GUWuIqJxZyigdQDr8+1Qzx3NcFwXbmFHSjDUy8rPUfV4/AO9TaUhmEtgDiJoNgz6/5Pr
         tZwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJZpQ07S3NI445UWrt8fMEa+l7TDcZQIu72RnmbV92+3SGaCoAciWZFA+XHVf3PRrjtk4THCVkpQ2zf3mP/RicGXGy6ds2IJsyeUcjm1Ptuu4jW48pU4Fo2FJ64mNIgyLHQ1GjonCHAP0J1A==
X-Gm-Message-State: AOJu0YzQ5SpGCuYxV05yY8xYA2xTz6U4uMMxTWhuLl9VlRM9niucrvMG
	9f0TPQKu7clzUwKtDgj58VoS2w7suIf/J8ReP5VjVZsts89cITC+V7Vx1QkaO/ZLtlzaf0K9c1l
	PfIFRTg75sfaPheMq6b1xAH2tLVI=
X-Google-Smtp-Source: AGHT+IG1iMYeEAkpys2HicXwxXBn+fTC42dUSDeVBs17zQY6ihYL1BG/GbMRKLumONvd+E8BVFpeipCZT3pmpRjuH9M=
X-Received: by 2002:a05:6871:e410:b0:23b:8a59:f5b4 with SMTP id
 py16-20020a056871e41000b0023b8a59f5b4mr15000811oac.2.1715065066882; Mon, 06
 May 2024 23:57:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429084633.9800-1-xuewen.yan@unisoc.com> <20240429121000.GA40213@noisy.programming.kicks-ass.net>
 <CAB8ipk831xtAW2+sm-evm-oOsFspL=xSp6hFYYq1uKmWA+porQ@mail.gmail.com> <e402d623-1875-47a2-9db3-8299a54502ef@redhat.com>
In-Reply-To: <e402d623-1875-47a2-9db3-8299a54502ef@redhat.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Tue, 7 May 2024 14:57:35 +0800
Message-ID: <CAB8ipk-yz+6X2E7BsJmNqVgZDjE8NkJFNdqFU+WLieKVhFaCuA@mail.gmail.com>
Subject: Re: [PATCH] sched/proc: Print user_cpus_ptr for task status
To: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Xuewen Yan <xuewen.yan@unisoc.com>, 
	akpm@linux-foundation.org, oleg@redhat.com, dylanbhatch@google.com, 
	rick.p.edgecombe@intel.com, ke.wang@unisoc.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Waiman

On Tue, May 7, 2024 at 2:04=E2=80=AFAM Waiman Long <longman@redhat.com> wro=
te:
>
> On 5/6/24 04:04, Xuewen Yan wrote:
> > Hi Peter
> >
> > On Mon, Apr 29, 2024 at 8:10=E2=80=AFPM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> >> On Mon, Apr 29, 2024 at 04:46:33PM +0800, Xuewen Yan wrote:
> >>> The commit 851a723e45d1c("sched: Always clear user_cpus_ptr in do_set=
_cpus_allowed()")
> >>> would clear the user_cpus_ptr when call the do_set_cpus_allowed.
> >>>
> >>> In order to determine whether the user_cpus_ptr is taking effect,
> >>> it is better to print the task's user_cpus_ptr.
> >> This is an ABI change and would mandate we forever more have this
> >> distinction. I don't think your changes justifies things sufficiently
> >> for this.
> > I added this mainly because online/offline cpu will produce different
> > results for the !top-cpuset task.
> >
> > For example:
> >
> > If the task was running, then offline task's cpus, would lead to clear
> > its user-mask.
> >
> > unisoc:/ # while true; do sleep 600; done&
> > [1] 6786
> > unisoc:/ # echo 6786 > /dev/cpuset/top-app/tasks
> > unisoc:/ # cat /dev/cpuset/top-app/cpus
> > 0-7
> > unisoc:/ # cat /proc/6786/status | grep Cpus
> > Cpus_allowed:   ff
> > Cpus_allowed_list:      0-7
> > Cpus_user_allowed:        (null)
> > Cpus_user_allowed_list:   (null)
> >
> > unisoc:/ # taskset -p c0 6786
> > pid 6786's current affinity mask: ff
> > pid 6786's new affinity mask: c0
> > unisoc:/ # cat /proc/6786/status | grep Cpus
> > Cpus_allowed:   c0
> > Cpus_allowed_list:      6-7
> > Cpus_user_allowed:      c0
> > Cpus_user_allowed_list: 6-7
> >
> > After offline the cpu6 and cpu7, the user-mask would be cleared:
> >
> > unisoc:/ # echo 0 > /sys/devices/system/cpu/cpu7/online
> > unisoc:/ # cat /proc/6786/status | grep Cpus
> > Cpus_allowed:   40
> > Cpus_allowed_list:      6
> > Cpus_user_allowed:      c0
> > Cpus_user_allowed_list: 6-7
> > ums9621_1h10:/ # echo 0 > /sys/devices/system/cpu/cpu6/online
> > ums9621_1h10:/ # cat /proc/6786/status | grep Cpus
> > Cpus_allowed:   3f
> > Cpus_allowed_list:      0-5
> > Cpus_user_allowed:        (null)
> > Cpus_user_allowed_list:   (null)
> >
> > When online the cpu6/7, the user-mask can not bring back:
> >
> > unisoc:/ # echo 1 > /sys/devices/system/cpu/cpu6/online
> > unisoc:/ # cat /proc/6786/status | grep Cpus
> > Cpus_allowed:   7f
> > Cpus_allowed_list:      0-6
> > Cpus_user_allowed:        (null)
> > Cpus_user_allowed_list:   (null)
> > unisoc:/ # echo 1 > /sys/devices/system/cpu/cpu7/online
> > unisoc:/ # cat /proc/6786/status | grep Cpus
> > Cpus_allowed:   ff
> > Cpus_allowed_list:      0-7
> > Cpus_user_allowed:        (null)
> > Cpus_user_allowed_list:   (null)
> >
> > However, if we offline the cpu when the task is sleeping, at this
> > time, because would not call the fallback_cpu(), its user-mask will
> > not be cleared.
> >
> > unisoc:/ # while true; do sleep 600; done&
> > [1] 5990
> > unisoc:/ # echo 5990 > /dev/cpuset/top-app/tasks
> > unisoc:/ # cat /proc/5990/status | grep Cpus
> > Cpus_allowed:   ff
> > Cpus_allowed_list:      0-7
> > Cpus_user_allowed:        (null)
> > Cpus_user_allowed_list:   (null)
> >
> > unisoc:/ # taskset -p c0 5990
> > pid 5990's current affinity mask: ff
> > pid 5990's new affinity mask: c0
> > unisoc:/ # cat /proc/5990/status | grep Cpus
> > Cpus_allowed:   c0
> > Cpus_allowed_list:      6-7
> > Cpus_user_allowed:      c0
> > Cpus_user_allowed_list: 6-7
> >
> > unisoc:/ # echo 0 > /sys/devices/system/cpu/cpu6/online
> > unisoc:/ # cat /proc/5990/status | grep Cpus
> > Cpus_allowed:   80
> > Cpus_allowed_list:      7
> > Cpus_user_allowed:      c0
> > Cpus_user_allowed_list: 6-7
> > unisoc:/ # echo 0 > /sys/devices/system/cpu/cpu7/online
> > unisoc:/ # cat /proc/5990/status | grep Cpus
> > Cpus_allowed:   3f
> > Cpus_allowed_list:      0-5
> > Cpus_user_allowed:      c0
> > Cpus_user_allowed_list: 6-7
> >
> >
> > After 10 minutes, it was waked up, it can also keep its user-mask:
> > ums9621_1h10:/ # cat /proc/5990/status | grep Cpus
> > Cpus_allowed:   3f
> > Cpus_allowed_list:      0-5
> > Cpus_user_allowed:      c0
> > Cpus_user_allowed_list: 6-7
> >
> > In order to solve the above problem, I modified the following patch.
> > At this time, for !top-cpuset, regardless of whether the task is in
> > the running state when offline cpu, its cpu-mask can be maintained.
> > However, this patch may not be perfect yet, so I send the "Print
> > user_cpus_ptr for task status" patch first to debug more conveniently.
> >
> > --->
> >
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 68cfa656b9b1..00879b6de8d4 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1870,7 +1870,7 @@ extern void dl_bw_free(int cpu, u64 dl_bw);
> >   #ifdef CONFIG_SMP
> >
> >   /* do_set_cpus_allowed() - consider using set_cpus_allowed_ptr() inst=
ead */
> > -extern void do_set_cpus_allowed(struct task_struct *p, const struct
> > cpumask *new_mask);
> > +extern void do_set_cpus_allowed(struct task_struct *p, const struct
> > cpumask *new_mask, bool keep_user);
> >
> >   /**
> >    * set_cpus_allowed_ptr - set CPU affinity mask of a task
> > @@ -1886,7 +1886,7 @@ extern int dl_task_check_affinity(struct
> > task_struct *p, const struct cpumask *m
> >   extern void force_compatible_cpus_allowed_ptr(struct task_struct *p);
> >   extern void relax_compatible_cpus_allowed_ptr(struct task_struct *p);
> >   #else
> > -static inline void do_set_cpus_allowed(struct task_struct *p, const
> > struct cpumask *new_mask)
> > +static inline void do_set_cpus_allowed(struct task_struct *p, const
> > struct cpumask *new_mask, bool keep_user)
> >   {
> >   }
> >   static inline int set_cpus_allowed_ptr(struct task_struct *p, const
> > struct cpumask *new_mask)
> > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > index 7ee9994aee40..0c448f8a3829 100644
> > --- a/kernel/cgroup/cpuset.c
> > +++ b/kernel/cgroup/cpuset.c
> > @@ -4005,9 +4005,14 @@ bool cpuset_cpus_allowed_fallback(struct
> > task_struct *tsk)
> >
> >          rcu_read_lock();
> >          cs_mask =3D task_cs(tsk)->cpus_allowed;
> > -       if (is_in_v2_mode() && cpumask_subset(cs_mask, possible_mask)) =
{
> > -               do_set_cpus_allowed(tsk, cs_mask);
> > -               changed =3D true;
> > +       if (cpumask_subset(cs_mask, possible_mask)) {
> > +               if (is_in_v2_mode()) {
> > +                       do_set_cpus_allowed(tsk, cs_mask, false);
> > +                       changed =3D true;
> > +               } else if (task_cs(tsk) !=3D &top_cpuset) {
> > +                       do_set_cpus_allowed(tsk, cs_mask, true);
> > +                       changed =3D true;
> > +               }
> >          }
> >          rcu_read_unlock();
> >
> > diff --git a/kernel/kthread.c b/kernel/kthread.c
> > index 7a7aa5f93c0c..7ede27630088 100644
> > --- a/kernel/kthread.c
> > +++ b/kernel/kthread.c
> > @@ -527,7 +527,7 @@ static void __kthread_bind_mask(struct task_struct
> > *p, const struct cpumask *mas
> >
> >          /* It's safe because the task is inactive. */
> >          raw_spin_lock_irqsave(&p->pi_lock, flags);
> > -       do_set_cpus_allowed(p, mask);
> > +       do_set_cpus_allowed(p, mask, false);
> >          p->flags |=3D PF_NO_SETAFFINITY;
> >          raw_spin_unlock_irqrestore(&p->pi_lock, flags);
> >   }
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 33cfd522fc7c..623f89e65e6c 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -2855,18 +2855,21 @@ __do_set_cpus_allowed(struct task_struct *p,
> > struct affinity_context *ctx)
> >    * Used for kthread_bind() and select_fallback_rq(), in both cases th=
e user
> >    * affinity (if any) should be destroyed too.
> >    */
> > -void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *=
new_mask)
> > +void do_set_cpus_allowed(struct task_struct *p, const struct cpumask
> > *new_mask, bool keep_user)
> >   {
> >          struct affinity_context ac =3D {
> >                  .new_mask  =3D new_mask,
> >                  .user_mask =3D NULL,
> > -               .flags     =3D SCA_USER,  /* clear the user requested m=
ask */
> > +               .flags     =3D 0, /* clear the user requested mask */
> >          };
> >          union cpumask_rcuhead {
> >                  cpumask_t cpumask;
> >                  struct rcu_head rcu;
> >          };
> >
> > +       if (!keep_user)
> > +               ac.flags =3D SCA_USER;
> > +
> >          __do_set_cpus_allowed(p, &ac);
> >
> >          /*
> > @@ -2874,7 +2877,8 @@ void do_set_cpus_allowed(struct task_struct *p,
> > const struct cpumask *new_mask)
> >           * to use kfree() here (when PREEMPT_RT=3Dy), therefore punt t=
o using
> >           * kfree_rcu().
> >           */
> > -       kfree_rcu((union cpumask_rcuhead *)ac.user_mask, rcu);
> > +       if (!keep_user)
> > +               kfree_rcu((union cpumask_rcuhead *)ac.user_mask, rcu);
> >   }
> >
> >   static cpumask_t *alloc_user_cpus_ptr(int node)
> > @@ -3664,7 +3668,7 @@ int select_fallback_rq(int cpu, struct task_struc=
t *p)
> >                           *
> >                           * More yuck to audit.
> >                           */
> > -                       do_set_cpus_allowed(p, task_cpu_possible_mask(p=
));
> > +                       do_set_cpus_allowed(p,
> > task_cpu_possible_mask(p), false);
> >                          state =3D fail;
> >                          break;
> >                  case fail:
> >
> These changes essentially reverts commit 851a723e45d1c("sched: Always
> clear user_cpus_ptr in do_set_cpus_allowed()") except the additional
> caller in the cpuset code.
>
> How about the following less invasive change?
>
>   diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 7019a40457a6..646837eab70c 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2796,21 +2796,24 @@ __do_set_cpus_allowed(struct task_struct *p,
> struct affinity_context *ctx)
>   }
>
>   /*
> - * Used for kthread_bind() and select_fallback_rq(), in both cases the u=
ser
> - * affinity (if any) should be destroyed too.
> + * Used for kthread_bind() and select_fallback_rq(). Destroy user affini=
ty
> + * if no intersection with the new mask.
>    */
>   void do_set_cpus_allowed(struct task_struct *p, const struct cpumask
> *new_mask)
>   {
>          struct affinity_context ac =3D {
>                  .new_mask  =3D new_mask,
>                  .user_mask =3D NULL,
> -               .flags     =3D SCA_USER,  /* clear the user requested mas=
k */
> +               .flags     =3D 0,
>          };
>          union cpumask_rcuhead {
>                  cpumask_t cpumask;
>                  struct rcu_head rcu;
>          };
>
> +       if (current->user_cpus_ptr &&
> !cpumask_intersects(current->user_cpus_ptr, new_mask))

Thanks for your suggestion, and I try it and as for me, it works well,
but I change the "current" to p.
I think =E2=80=9Ccurrent=E2=80=9D is inappropriate because what is changed =
here is the
mask of p.
It is possible that =E2=80=9Cp=E2=80=9D and =E2=80=9Ccurrent=E2=80=9D are n=
ot equal.

I would send the next patch later and add your Suggested-by. Thanks
again for your advice!

BR
---
xuewen

> +               ac.flags =3D SCA_USER;    /* clear the user requested mas=
k */
> +
>          __do_set_cpus_allowed(p, &ac);
>
>          /*
>
> No compilation test done. Note that there is a null check inside
> kfree_rcu() with no need for additional check.
>
> Regards,
> Longman
>
>


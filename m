Return-Path: <linux-fsdevel+bounces-18816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF938BC90F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 10:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8351A282A5B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 08:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314C7140E3C;
	Mon,  6 May 2024 08:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWHMPO6l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7635337A;
	Mon,  6 May 2024 08:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714982676; cv=none; b=j9p2XwUKLDiD6i/B6B66B8HK7PShaAO6vm1dUVpI5jxJU4FttbC8I9Cn1glrJVNJi3yi8gY5j04AyTeNDzkwBCcbXWH+eGh36JwMx9txRw1NrHucz925ToJ/KyK+OT907+jKDkA4ccu7GbyjQmi4ifzcR5fXP8qAlf6dXzt0EGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714982676; c=relaxed/simple;
	bh=yVAjfk32ITAfLOtacaMtTMgWw/OdP4FEjupxGn3qUag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mnW4jAkrr+qLJIIPc2jpb/YwMOEzp8CTj4WzRtM7Nas76qj1qZCQ/NZwLMEnrT+Ux4l4hNp7NQdgRi884gQerxviX04+rJjXgso3d0HV0NWJ/HUeJnCkL/E3V0FMQiGW8eAQXmYX3lBq3JtnrBpguO9tAWi51i1cE9fF2fvB4z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWHMPO6l; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-23f3d248fadso561727fac.1;
        Mon, 06 May 2024 01:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714982674; x=1715587474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfpokmAU3HbXjaC+p8clIWigf7vKt+qLxhyKnJh/jj0=;
        b=ZWHMPO6lEoSBTZee42iAlgJ31rQ8obO9n8tDGx6Nua2EG554Ga92jg5vf+UXvtHPxX
         eMZxqPGIdv4l6r9DCZrdw9rBN407v79OInxs+0oNU77v13wF7zj2YNrRAagjkLPCfPDK
         hPrxUneHeCHwLw8IyE+mzWT65+jupV81PvO/DY21I3YJHQ/Sqt24zRb3Z3B0zNpGbBbM
         x8yZM++bx2s+yeB67cPdMeVc3WYDIkuObmcGZXVq0XutQlsmUrkCkwxU83fKPTIbaWcy
         SIK8UQ8+XaCdgHqlDJEbo/OyinFfcZPVVadyyU91VLpXpkFKi3O40o4IMnkuFjSdUCz4
         IyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714982674; x=1715587474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EfpokmAU3HbXjaC+p8clIWigf7vKt+qLxhyKnJh/jj0=;
        b=uhwU/agfM4FoWE31d1+UOXOA2O12X+Mht2xzFkoHak6oKOUk3Z8OB57FpInv7DSxDQ
         npIE/RdI4iV957VT/sOU3vR9Pp6TsYcYwqRBmbYGfbRWR8QQo5PiCM6pYHSfyrYLYIaX
         0Bf4Nb3Y19tVqe4xhg1tsgm/MAUbSdoO8bj42RoZGRAogxCiBUERbKAhQj5EDWQ9v5UZ
         we8I0Y1SG1sqCOp1YmUBfM78zyh5isZtUfM9WymQHgOL9kWsdGz8/CeVkBouNI1t6uXZ
         ZdpIR1VN2tYyDVFbKcJl2kgI50LMs3H8h0WFEGJqJ40VDUxlCbZgoEDVf8M7+UiDkbuF
         2w2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXcXcGT3b5C64Kvqw7lTA28ShCb8DmLCROoJ6imI7Qy2zPoDpFgLMFlGL6PXKNZRCkFTTRzv1sKLQAKk0JwD/GIrh+oEXOzn1ODB9cpekHy7QlCj5/r0K+y4Po8MZoiVthBr/9AmW1uMkwQQQ==
X-Gm-Message-State: AOJu0YzDfgWGl30YThTst7lnkODH1Q2lfBwF4khGMoAxLLo6geXNlxbk
	aUI4226ahPWI2zQD/kGNkAaujgjZ2K9Dv7253JnHa9UAjX67gf3vJSM4MXfuFx28O0DUOpHc+hC
	NZSeRY0xNuJvL4cDq+7nXI4A9OAg=
X-Google-Smtp-Source: AGHT+IEEEcNiPNnGdlErFNYLqEzQ10T8R/Y+2bdwudTyhQnJHzzzxce1OKO1R/9hkTgPsqrctQfbJM1kC3ZtDT7Aseo=
X-Received: by 2002:a05:6870:d18d:b0:23d:be08:9de0 with SMTP id
 a13-20020a056870d18d00b0023dbe089de0mr10897717oac.44.1714982673902; Mon, 06
 May 2024 01:04:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429084633.9800-1-xuewen.yan@unisoc.com> <20240429121000.GA40213@noisy.programming.kicks-ass.net>
In-Reply-To: <20240429121000.GA40213@noisy.programming.kicks-ass.net>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Mon, 6 May 2024 16:04:22 +0800
Message-ID: <CAB8ipk831xtAW2+sm-evm-oOsFspL=xSp6hFYYq1uKmWA+porQ@mail.gmail.com>
Subject: Re: [PATCH] sched/proc: Print user_cpus_ptr for task status
To: Peter Zijlstra <peterz@infradead.org>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, akpm@linux-foundation.org, oleg@redhat.com, 
	longman@redhat.com, dylanbhatch@google.com, rick.p.edgecombe@intel.com, 
	ke.wang@unisoc.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter

On Mon, Apr 29, 2024 at 8:10=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Apr 29, 2024 at 04:46:33PM +0800, Xuewen Yan wrote:
> > The commit 851a723e45d1c("sched: Always clear user_cpus_ptr in do_set_c=
pus_allowed()")
> > would clear the user_cpus_ptr when call the do_set_cpus_allowed.
> >
> > In order to determine whether the user_cpus_ptr is taking effect,
> > it is better to print the task's user_cpus_ptr.
>
> This is an ABI change and would mandate we forever more have this
> distinction. I don't think your changes justifies things sufficiently
> for this.

I added this mainly because online/offline cpu will produce different
results for the !top-cpuset task.

For example:

If the task was running, then offline task's cpus, would lead to clear
its user-mask.

unisoc:/ # while true; do sleep 600; done&
[1] 6786
unisoc:/ # echo 6786 > /dev/cpuset/top-app/tasks
unisoc:/ # cat /dev/cpuset/top-app/cpus
0-7
unisoc:/ # cat /proc/6786/status | grep Cpus
Cpus_allowed:   ff
Cpus_allowed_list:      0-7
Cpus_user_allowed:        (null)
Cpus_user_allowed_list:   (null)

unisoc:/ # taskset -p c0 6786
pid 6786's current affinity mask: ff
pid 6786's new affinity mask: c0
unisoc:/ # cat /proc/6786/status | grep Cpus
Cpus_allowed:   c0
Cpus_allowed_list:      6-7
Cpus_user_allowed:      c0
Cpus_user_allowed_list: 6-7

After offline the cpu6 and cpu7, the user-mask would be cleared:

unisoc:/ # echo 0 > /sys/devices/system/cpu/cpu7/online
unisoc:/ # cat /proc/6786/status | grep Cpus
Cpus_allowed:   40
Cpus_allowed_list:      6
Cpus_user_allowed:      c0
Cpus_user_allowed_list: 6-7
ums9621_1h10:/ # echo 0 > /sys/devices/system/cpu/cpu6/online
ums9621_1h10:/ # cat /proc/6786/status | grep Cpus
Cpus_allowed:   3f
Cpus_allowed_list:      0-5
Cpus_user_allowed:        (null)
Cpus_user_allowed_list:   (null)

When online the cpu6/7, the user-mask can not bring back:

unisoc:/ # echo 1 > /sys/devices/system/cpu/cpu6/online
unisoc:/ # cat /proc/6786/status | grep Cpus
Cpus_allowed:   7f
Cpus_allowed_list:      0-6
Cpus_user_allowed:        (null)
Cpus_user_allowed_list:   (null)
unisoc:/ # echo 1 > /sys/devices/system/cpu/cpu7/online
unisoc:/ # cat /proc/6786/status | grep Cpus
Cpus_allowed:   ff
Cpus_allowed_list:      0-7
Cpus_user_allowed:        (null)
Cpus_user_allowed_list:   (null)

However, if we offline the cpu when the task is sleeping, at this
time, because would not call the fallback_cpu(), its user-mask will
not be cleared.

unisoc:/ # while true; do sleep 600; done&
[1] 5990
unisoc:/ # echo 5990 > /dev/cpuset/top-app/tasks
unisoc:/ # cat /proc/5990/status | grep Cpus
Cpus_allowed:   ff
Cpus_allowed_list:      0-7
Cpus_user_allowed:        (null)
Cpus_user_allowed_list:   (null)

unisoc:/ # taskset -p c0 5990
pid 5990's current affinity mask: ff
pid 5990's new affinity mask: c0
unisoc:/ # cat /proc/5990/status | grep Cpus
Cpus_allowed:   c0
Cpus_allowed_list:      6-7
Cpus_user_allowed:      c0
Cpus_user_allowed_list: 6-7

unisoc:/ # echo 0 > /sys/devices/system/cpu/cpu6/online
unisoc:/ # cat /proc/5990/status | grep Cpus
Cpus_allowed:   80
Cpus_allowed_list:      7
Cpus_user_allowed:      c0
Cpus_user_allowed_list: 6-7
unisoc:/ # echo 0 > /sys/devices/system/cpu/cpu7/online
unisoc:/ # cat /proc/5990/status | grep Cpus
Cpus_allowed:   3f
Cpus_allowed_list:      0-5
Cpus_user_allowed:      c0
Cpus_user_allowed_list: 6-7


After 10 minutes, it was waked up, it can also keep its user-mask:
ums9621_1h10:/ # cat /proc/5990/status | grep Cpus
Cpus_allowed:   3f
Cpus_allowed_list:      0-5
Cpus_user_allowed:      c0
Cpus_user_allowed_list: 6-7

In order to solve the above problem, I modified the following patch.
At this time, for !top-cpuset, regardless of whether the task is in
the running state when offline cpu, its cpu-mask can be maintained.
However, this patch may not be perfect yet, so I send the "Print
user_cpus_ptr for task status" patch first to debug more conveniently.

--->

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 68cfa656b9b1..00879b6de8d4 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1870,7 +1870,7 @@ extern void dl_bw_free(int cpu, u64 dl_bw);
 #ifdef CONFIG_SMP

 /* do_set_cpus_allowed() - consider using set_cpus_allowed_ptr() instead *=
/
-extern void do_set_cpus_allowed(struct task_struct *p, const struct
cpumask *new_mask);
+extern void do_set_cpus_allowed(struct task_struct *p, const struct
cpumask *new_mask, bool keep_user);

 /**
  * set_cpus_allowed_ptr - set CPU affinity mask of a task
@@ -1886,7 +1886,7 @@ extern int dl_task_check_affinity(struct
task_struct *p, const struct cpumask *m
 extern void force_compatible_cpus_allowed_ptr(struct task_struct *p);
 extern void relax_compatible_cpus_allowed_ptr(struct task_struct *p);
 #else
-static inline void do_set_cpus_allowed(struct task_struct *p, const
struct cpumask *new_mask)
+static inline void do_set_cpus_allowed(struct task_struct *p, const
struct cpumask *new_mask, bool keep_user)
 {
 }
 static inline int set_cpus_allowed_ptr(struct task_struct *p, const
struct cpumask *new_mask)
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 7ee9994aee40..0c448f8a3829 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -4005,9 +4005,14 @@ bool cpuset_cpus_allowed_fallback(struct
task_struct *tsk)

        rcu_read_lock();
        cs_mask =3D task_cs(tsk)->cpus_allowed;
-       if (is_in_v2_mode() && cpumask_subset(cs_mask, possible_mask)) {
-               do_set_cpus_allowed(tsk, cs_mask);
-               changed =3D true;
+       if (cpumask_subset(cs_mask, possible_mask)) {
+               if (is_in_v2_mode()) {
+                       do_set_cpus_allowed(tsk, cs_mask, false);
+                       changed =3D true;
+               } else if (task_cs(tsk) !=3D &top_cpuset) {
+                       do_set_cpus_allowed(tsk, cs_mask, true);
+                       changed =3D true;
+               }
        }
        rcu_read_unlock();

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 7a7aa5f93c0c..7ede27630088 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -527,7 +527,7 @@ static void __kthread_bind_mask(struct task_struct
*p, const struct cpumask *mas

        /* It's safe because the task is inactive. */
        raw_spin_lock_irqsave(&p->pi_lock, flags);
-       do_set_cpus_allowed(p, mask);
+       do_set_cpus_allowed(p, mask, false);
        p->flags |=3D PF_NO_SETAFFINITY;
        raw_spin_unlock_irqrestore(&p->pi_lock, flags);
 }
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 33cfd522fc7c..623f89e65e6c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2855,18 +2855,21 @@ __do_set_cpus_allowed(struct task_struct *p,
struct affinity_context *ctx)
  * Used for kthread_bind() and select_fallback_rq(), in both cases the use=
r
  * affinity (if any) should be destroyed too.
  */
-void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_=
mask)
+void do_set_cpus_allowed(struct task_struct *p, const struct cpumask
*new_mask, bool keep_user)
 {
        struct affinity_context ac =3D {
                .new_mask  =3D new_mask,
                .user_mask =3D NULL,
-               .flags     =3D SCA_USER,  /* clear the user requested mask =
*/
+               .flags     =3D 0, /* clear the user requested mask */
        };
        union cpumask_rcuhead {
                cpumask_t cpumask;
                struct rcu_head rcu;
        };

+       if (!keep_user)
+               ac.flags =3D SCA_USER;
+
        __do_set_cpus_allowed(p, &ac);

        /*
@@ -2874,7 +2877,8 @@ void do_set_cpus_allowed(struct task_struct *p,
const struct cpumask *new_mask)
         * to use kfree() here (when PREEMPT_RT=3Dy), therefore punt to usi=
ng
         * kfree_rcu().
         */
-       kfree_rcu((union cpumask_rcuhead *)ac.user_mask, rcu);
+       if (!keep_user)
+               kfree_rcu((union cpumask_rcuhead *)ac.user_mask, rcu);
 }

 static cpumask_t *alloc_user_cpus_ptr(int node)
@@ -3664,7 +3668,7 @@ int select_fallback_rq(int cpu, struct task_struct *p=
)
                         *
                         * More yuck to audit.
                         */
-                       do_set_cpus_allowed(p, task_cpu_possible_mask(p));
+                       do_set_cpus_allowed(p,
task_cpu_possible_mask(p), false);
                        state =3D fail;
                        break;
                case fail:


---
xuewen


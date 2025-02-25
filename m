Return-Path: <linux-fsdevel+bounces-42595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1378CA448F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 18:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9482C3BFBDE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 17:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496F31A8F6E;
	Tue, 25 Feb 2025 17:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="VuSovidw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623E31993BD
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2025 17:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740505015; cv=none; b=OzG369Kkke2gJQe10A1fBQPm/UMJCZzjgMuMjz2tCbGqMpwUycRSGXo6pxCdnJeo8Qbkymm0JAtEIrAmMqm+DT5BGzffesyzYqFArDn5Zkba5kHW4PNJ17wkKSIMQLiooWHUlHjUZQtkGXAH5DJPhNqVVWBVUhKlEbd8kwJR2MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740505015; c=relaxed/simple;
	bh=D77701LRLaOOKnyAHEl7TtKq/YsD0uP2H8B6chFtW3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LihLG1rTMSevAkxoAdetXnH/AAU0LE3PTiqHaKHDlFB2VCxCKa+A9N+hx5zKMLuVUZ7plEZqsIwjnM/JHzZCeHnPTxAYiR2XLTQ4QaETiMdbyun52YxUlTT08VlTprbwJrSqgYv4BnuMlTLjYXw3/L2LKzhF0Y5u/mdNS6m/HMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=VuSovidw; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54838cd334cso4917688e87.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2025 09:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1740505011; x=1741109811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Msex6yCsWlgaVfBs19G7jgsagoME7+ZXdQHDX2hOeFM=;
        b=VuSovidwGQBn8Hh0EX1ljUBkObN1w4PdOXfGcseglmSFsHGK+41i+u5Ffv2NLM0a2c
         4TCsJpkwQZ/9+l1ef1QkneI6OnROg6ThXb395nOdMbC0kyvlG4as54GkJFW8BEqm3Sto
         RfP7SfjDe/jzWCiQMtMZOYSnRaX12HslVoTq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740505011; x=1741109811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Msex6yCsWlgaVfBs19G7jgsagoME7+ZXdQHDX2hOeFM=;
        b=uoo1CwY7sC6gbnz7Nxe4G6g1r66flrHcL5BJ1LD8rok4d36TqAZuNC+ZW1srJ9DCKn
         bMLAL1BtyUokCfgiKuvFH5xKf7/lYg+XjWSnDsfG0nxcJ+ehO1muDxYZfLm79q2MrqU7
         1gOr7drQ3kcQLYUZDWfhVPSmzdDJ+NRHjMrVVEDhIzfKWwLiIcWnSY2NEvsNSGKkGJS3
         o5+0M7Ur/+vcbaPKA977j5nfqGDjsedEzou27G5UqSQk0w1ey4TOYrEZ3aoOYvAoDnnJ
         Ez6Z6B0JUfCOijRZVbwP7lreXgwNooWEEOGWJwcJNUY26S55MQAm9UnoG9rH6oDOqmoo
         nkPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZOWfMe9PrnmM2XcWh/zhYEKEEfpJisruCpleAGhnSNNI79WVEDa5Ox5LTQbzGzvrs3GvmFCQt6eu6xtbw@vger.kernel.org
X-Gm-Message-State: AOJu0YynlJ9VcjsBackFhIXz9uNfsGhIh0/GnfEoS/zc51UtyJp/0Cig
	ZZdgnB1lggJf9jPwc4sdtMCvbmb4sljBGIjFLPYGboMQdDynROwnVrzPn8K3R4Fql8d7P9u+ToW
	kYI5ungOrrDi2nmlpt7m6VAS+mAk1s18OGWfZDQ==
X-Gm-Gg: ASbGnct2rOcf3tuqKkzySv/ucXxIEEIBNWgmjPnS46BtTBQczfjNGYoIavcPIOQ/B2p
	1Tyn58GOjCUVCT3V7Rsjni7t6uxCMwJulsQJ7MgDC/TF+nBqR1SohOGRxWV4Yiy9aFHYibNkBAk
	28MDuGWJFN
X-Google-Smtp-Source: AGHT+IEIT7QJ3ck7w7rERWt6WrEciKE9hk04HlX37PjngzwmwdHve4peqnsrJx+9xAXaYXn7MPTLGeipdO4WecKw2o4=
X-Received: by 2002:a05:6512:3984:b0:545:2efc:745d with SMTP id
 2adb3069b0e04-5493c5b6683mr145249e87.46.1740505011137; Tue, 25 Feb 2025
 09:36:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221170249.890014-1-mkoutny@suse.com> <20250221170249.890014-2-mkoutny@suse.com>
In-Reply-To: <20250221170249.890014-2-mkoutny@suse.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Tue, 25 Feb 2025 18:36:37 +0100
X-Gm-Features: AQ5f1JrN8pkHqnXfS84QMJIHeoOE-NkguSHJdWcXncitet9kEMSWYpxUBbAy90Q
Message-ID: <CAJqdLrry4HaHpsWGH_YUUr_mWetCCogOxnw1SMRW-XcWE_FXcg@mail.gmail.com>
Subject: Re: [PATCH 1/2] Revert "pid: allow pid_max to be set per pid namespace"
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Eric W . Biederman" <ebiederm@xmission.com>, Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Fr., 21. Feb. 2025 um 18:02 Uhr schrieb Michal Koutn=C3=BD <mkoutny@suse=
.com>:
>
> This reverts commit 7863dcc72d0f4b13a641065670426435448b3d80.

If we revert this one, then we should also revert a corresponding kselftest=
:
https://github.com/torvalds/linux/commit/615ab43b838bb982dc234feff75ee9ad35=
447c5d

>
> It is already difficult for users to troubleshoot which of multiple pid
> limits restricts their workload. I'm afraid making pid_max
> per-(hierarchical-)NS will contribute to confusion.
> Also, the implementation copies the limit upon creation from
> parent, this pattern showed cumbersome with some attributes in legacy
> cgroup controllers -- it's subject to race condition between parent's
> limit modification and children creation and once copied it must be
> changed in the descendant.
>
> This is very similar to what pids.max of a cgroup (already) does that
> can be used as an alternative.
>
> Link: https://lore.kernel.org/r/bnxhqrq7tip6jl2hu6jsvxxogdfii7ugmafbhgsog=
ovrchxfyp@kagotkztqurt/
> Signed-off-by: Michal Koutn=C3=BD <mkoutny@suse.com>
> ---
>  include/linux/pid.h               |   3 +
>  include/linux/pid_namespace.h     |  10 +--
>  kernel/pid.c                      | 125 ++----------------------------
>  kernel/pid_namespace.c            |  43 +++-------
>  kernel/sysctl.c                   |   9 +++
>  kernel/trace/pid_list.c           |   2 +-
>  kernel/trace/trace.h              |   2 +
>  kernel/trace/trace_sched_switch.c |   2 +-
>  8 files changed, 35 insertions(+), 161 deletions(-)
>
> diff --git a/include/linux/pid.h b/include/linux/pid.h
> index 98837a1ff0f33..fe575fcdb4afa 100644
> --- a/include/linux/pid.h
> +++ b/include/linux/pid.h
> @@ -108,6 +108,9 @@ extern void exchange_tids(struct task_struct *task, s=
truct task_struct *old);
>  extern void transfer_pid(struct task_struct *old, struct task_struct *ne=
w,
>                          enum pid_type);
>
> +extern int pid_max;
> +extern int pid_max_min, pid_max_max;
> +
>  /*
>   * look up a PID in the hash table. Must be called with the tasklist_loc=
k
>   * or rcu_read_lock() held.
> diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.=
h
> index 7c67a58111998..f9f9931e02d6a 100644
> --- a/include/linux/pid_namespace.h
> +++ b/include/linux/pid_namespace.h
> @@ -30,7 +30,6 @@ struct pid_namespace {
>         struct task_struct *child_reaper;
>         struct kmem_cache *pid_cachep;
>         unsigned int level;
> -       int pid_max;
>         struct pid_namespace *parent;
>  #ifdef CONFIG_BSD_PROCESS_ACCT
>         struct fs_pin *bacct;
> @@ -39,14 +38,9 @@ struct pid_namespace {
>         struct ucounts *ucounts;
>         int reboot;     /* group exit code if this pidns was rebooted */
>         struct ns_common ns;
> -       struct work_struct      work;
> -#ifdef CONFIG_SYSCTL
> -       struct ctl_table_set    set;
> -       struct ctl_table_header *sysctls;
> -#if defined(CONFIG_MEMFD_CREATE)
> +#if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
>         int memfd_noexec_scope;
>  #endif
> -#endif
>  } __randomize_layout;
>
>  extern struct pid_namespace init_pid_ns;
> @@ -123,8 +117,6 @@ static inline int reboot_pid_ns(struct pid_namespace =
*pid_ns, int cmd)
>  extern struct pid_namespace *task_active_pid_ns(struct task_struct *tsk)=
;
>  void pidhash_init(void);
>  void pid_idr_init(void);
> -int register_pidns_sysctls(struct pid_namespace *pidns);
> -void unregister_pidns_sysctls(struct pid_namespace *pidns);
>
>  static inline bool task_is_in_init_pid_ns(struct task_struct *tsk)
>  {
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 924084713be8b..aa2a7d4da4555 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -61,8 +61,10 @@ struct pid init_struct_pid =3D {
>         }, }
>  };
>
> -static int pid_max_min =3D RESERVED_PIDS + 1;
> -static int pid_max_max =3D PID_MAX_LIMIT;
> +int pid_max =3D PID_MAX_DEFAULT;
> +
> +int pid_max_min =3D RESERVED_PIDS + 1;
> +int pid_max_max =3D PID_MAX_LIMIT;
>
>  /*
>   * PID-map pages start out as NULL, they get allocated upon
> @@ -81,7 +83,6 @@ struct pid_namespace init_pid_ns =3D {
>  #ifdef CONFIG_PID_NS
>         .ns.ops =3D &pidns_operations,
>  #endif
> -       .pid_max =3D PID_MAX_DEFAULT,
>  #if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
>         .memfd_noexec_scope =3D MEMFD_NOEXEC_SCOPE_EXEC,
>  #endif
> @@ -190,7 +191,6 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t=
 *set_tid,
>
>         for (i =3D ns->level; i >=3D 0; i--) {
>                 int tid =3D 0;
> -               int pid_max =3D READ_ONCE(tmp->pid_max);
>
>                 if (set_tid_size) {
>                         tid =3D set_tid[ns->level - i];
> @@ -644,118 +644,17 @@ SYSCALL_DEFINE2(pidfd_open, pid_t, pid, unsigned i=
nt, flags)
>         return fd;
>  }
>
> -#ifdef CONFIG_SYSCTL
> -static struct ctl_table_set *pid_table_root_lookup(struct ctl_table_root=
 *root)
> -{
> -       return &task_active_pid_ns(current)->set;
> -}
> -
> -static int set_is_seen(struct ctl_table_set *set)
> -{
> -       return &task_active_pid_ns(current)->set =3D=3D set;
> -}
> -
> -static int pid_table_root_permissions(struct ctl_table_header *head,
> -                                     const struct ctl_table *table)
> -{
> -       struct pid_namespace *pidns =3D
> -               container_of(head->set, struct pid_namespace, set);
> -       int mode =3D table->mode;
> -
> -       if (ns_capable(pidns->user_ns, CAP_SYS_ADMIN) ||
> -           uid_eq(current_euid(), make_kuid(pidns->user_ns, 0)))
> -               mode =3D (mode & S_IRWXU) >> 6;
> -       else if (in_egroup_p(make_kgid(pidns->user_ns, 0)))
> -               mode =3D (mode & S_IRWXG) >> 3;
> -       else
> -               mode =3D mode & S_IROTH;
> -       return (mode << 6) | (mode << 3) | mode;
> -}
> -
> -static void pid_table_root_set_ownership(struct ctl_table_header *head,
> -                                        kuid_t *uid, kgid_t *gid)
> -{
> -       struct pid_namespace *pidns =3D
> -               container_of(head->set, struct pid_namespace, set);
> -       kuid_t ns_root_uid;
> -       kgid_t ns_root_gid;
> -
> -       ns_root_uid =3D make_kuid(pidns->user_ns, 0);
> -       if (uid_valid(ns_root_uid))
> -               *uid =3D ns_root_uid;
> -
> -       ns_root_gid =3D make_kgid(pidns->user_ns, 0);
> -       if (gid_valid(ns_root_gid))
> -               *gid =3D ns_root_gid;
> -}
> -
> -static struct ctl_table_root pid_table_root =3D {
> -       .lookup         =3D pid_table_root_lookup,
> -       .permissions    =3D pid_table_root_permissions,
> -       .set_ownership  =3D pid_table_root_set_ownership,
> -};
> -
> -static const struct ctl_table pid_table[] =3D {
> -       {
> -               .procname       =3D "pid_max",
> -               .data           =3D &init_pid_ns.pid_max,
> -               .maxlen         =3D sizeof(int),
> -               .mode           =3D 0644,
> -               .proc_handler   =3D proc_dointvec_minmax,
> -               .extra1         =3D &pid_max_min,
> -               .extra2         =3D &pid_max_max,
> -       },
> -};
> -#endif
> -
> -int register_pidns_sysctls(struct pid_namespace *pidns)
> -{
> -#ifdef CONFIG_SYSCTL
> -       struct ctl_table *tbl;
> -
> -       setup_sysctl_set(&pidns->set, &pid_table_root, set_is_seen);
> -
> -       tbl =3D kmemdup(pid_table, sizeof(pid_table), GFP_KERNEL);
> -       if (!tbl)
> -               return -ENOMEM;
> -       tbl->data =3D &pidns->pid_max;
> -       pidns->pid_max =3D min(pid_max_max, max_t(int, pidns->pid_max,
> -                            PIDS_PER_CPU_DEFAULT * num_possible_cpus()))=
;
> -
> -       pidns->sysctls =3D __register_sysctl_table(&pidns->set, "kernel",=
 tbl,
> -                                                ARRAY_SIZE(pid_table));
> -       if (!pidns->sysctls) {
> -               kfree(tbl);
> -               retire_sysctl_set(&pidns->set);
> -               return -ENOMEM;
> -       }
> -#endif
> -       return 0;
> -}
> -
> -void unregister_pidns_sysctls(struct pid_namespace *pidns)
> -{
> -#ifdef CONFIG_SYSCTL
> -       const struct ctl_table *tbl;
> -
> -       tbl =3D pidns->sysctls->ctl_table_arg;
> -       unregister_sysctl_table(pidns->sysctls);
> -       retire_sysctl_set(&pidns->set);
> -       kfree(tbl);
> -#endif
> -}
> -
>  void __init pid_idr_init(void)
>  {
>         /* Verify no one has done anything silly: */
>         BUILD_BUG_ON(PID_MAX_LIMIT >=3D PIDNS_ADDING);
>
>         /* bump default and minimum pid_max based on number of cpus */
> -       init_pid_ns.pid_max =3D min(pid_max_max, max_t(int, init_pid_ns.p=
id_max,
> -                                 PIDS_PER_CPU_DEFAULT * num_possible_cpu=
s()));
> +       pid_max =3D min(pid_max_max, max_t(int, pid_max,
> +                               PIDS_PER_CPU_DEFAULT * num_possible_cpus(=
)));
>         pid_max_min =3D max_t(int, pid_max_min,
>                                 PIDS_PER_CPU_MIN * num_possible_cpus());
> -       pr_info("pid_max: default: %u minimum: %u\n", init_pid_ns.pid_max=
, pid_max_min);
> +       pr_info("pid_max: default: %u minimum: %u\n", pid_max, pid_max_mi=
n);
>
>         idr_init(&init_pid_ns.idr);
>
> @@ -766,16 +665,6 @@ void __init pid_idr_init(void)
>                         NULL);
>  }
>
> -static __init int pid_namespace_sysctl_init(void)
> -{
> -#ifdef CONFIG_SYSCTL
> -       /* "kernel" directory will have already been initialized. */
> -       BUG_ON(register_pidns_sysctls(&init_pid_ns));
> -#endif
> -       return 0;
> -}
> -subsys_initcall(pid_namespace_sysctl_init);
> -
>  static struct file *__pidfd_fget(struct task_struct *task, int fd)
>  {
>         struct file *file;
> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> index 8f6cfec87555a..0f23285be4f92 100644
> --- a/kernel/pid_namespace.c
> +++ b/kernel/pid_namespace.c
> @@ -70,8 +70,6 @@ static void dec_pid_namespaces(struct ucounts *ucounts)
>         dec_ucount(ucounts, UCOUNT_PID_NAMESPACES);
>  }
>
> -static void destroy_pid_namespace_work(struct work_struct *work);
> -
>  static struct pid_namespace *create_pid_namespace(struct user_namespace =
*user_ns,
>         struct pid_namespace *parent_pid_ns)
>  {
> @@ -107,27 +105,17 @@ static struct pid_namespace *create_pid_namespace(s=
truct user_namespace *user_ns
>                 goto out_free_idr;
>         ns->ns.ops =3D &pidns_operations;
>
> -       ns->pid_max =3D parent_pid_ns->pid_max;
> -       err =3D register_pidns_sysctls(ns);
> -       if (err)
> -               goto out_free_inum;
> -
>         refcount_set(&ns->ns.count, 1);
>         ns->level =3D level;
>         ns->parent =3D get_pid_ns(parent_pid_ns);
>         ns->user_ns =3D get_user_ns(user_ns);
>         ns->ucounts =3D ucounts;
>         ns->pid_allocated =3D PIDNS_ADDING;
> -       INIT_WORK(&ns->work, destroy_pid_namespace_work);
> -
>  #if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
>         ns->memfd_noexec_scope =3D pidns_memfd_noexec_scope(parent_pid_ns=
);
>  #endif
> -
>         return ns;
>
> -out_free_inum:
> -       ns_free_inum(&ns->ns);
>  out_free_idr:
>         idr_destroy(&ns->idr);
>         kmem_cache_free(pid_ns_cachep, ns);
> @@ -149,28 +137,12 @@ static void delayed_free_pidns(struct rcu_head *p)
>
>  static void destroy_pid_namespace(struct pid_namespace *ns)
>  {
> -       unregister_pidns_sysctls(ns);
> -
>         ns_free_inum(&ns->ns);
>
>         idr_destroy(&ns->idr);
>         call_rcu(&ns->rcu, delayed_free_pidns);
>  }
>
> -static void destroy_pid_namespace_work(struct work_struct *work)
> -{
> -       struct pid_namespace *ns =3D
> -               container_of(work, struct pid_namespace, work);
> -
> -       do {
> -               struct pid_namespace *parent;
> -
> -               parent =3D ns->parent;
> -               destroy_pid_namespace(ns);
> -               ns =3D parent;
> -       } while (ns !=3D &init_pid_ns && refcount_dec_and_test(&ns->ns.co=
unt));
> -}
> -
>  struct pid_namespace *copy_pid_ns(unsigned long flags,
>         struct user_namespace *user_ns, struct pid_namespace *old_ns)
>  {
> @@ -183,8 +155,15 @@ struct pid_namespace *copy_pid_ns(unsigned long flag=
s,
>
>  void put_pid_ns(struct pid_namespace *ns)
>  {
> -       if (ns && ns !=3D &init_pid_ns && refcount_dec_and_test(&ns->ns.c=
ount))
> -               schedule_work(&ns->work);
> +       struct pid_namespace *parent;
> +
> +       while (ns !=3D &init_pid_ns) {
> +               parent =3D ns->parent;
> +               if (!refcount_dec_and_test(&ns->ns.count))
> +                       break;
> +               destroy_pid_namespace(ns);
> +               ns =3D parent;
> +       }
>  }
>  EXPORT_SYMBOL_GPL(put_pid_ns);
>
> @@ -295,7 +274,6 @@ static int pid_ns_ctl_handler(const struct ctl_table =
*table, int write,
>         next =3D idr_get_cursor(&pid_ns->idr) - 1;
>
>         tmp.data =3D &next;
> -       tmp.extra2 =3D &pid_ns->pid_max;
>         ret =3D proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
>         if (!ret && write)
>                 idr_set_cursor(&pid_ns->idr, next + 1);
> @@ -303,6 +281,7 @@ static int pid_ns_ctl_handler(const struct ctl_table =
*table, int write,
>         return ret;
>  }
>
> +extern int pid_max;
>  static const struct ctl_table pid_ns_ctl_table[] =3D {
>         {
>                 .procname =3D "ns_last_pid",
> @@ -310,7 +289,7 @@ static const struct ctl_table pid_ns_ctl_table[] =3D =
{
>                 .mode =3D 0666, /* permissions are checked in the handler=
 */
>                 .proc_handler =3D pid_ns_ctl_handler,
>                 .extra1 =3D SYSCTL_ZERO,
> -               .extra2 =3D &init_pid_ns.pid_max,
> +               .extra2 =3D &pid_max,
>         },
>  };
>  #endif /* CONFIG_CHECKPOINT_RESTORE */
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index cb57da499ebb1..bb739608680f2 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1803,6 +1803,15 @@ static const struct ctl_table kern_table[] =3D {
>                 .proc_handler   =3D proc_dointvec,
>         },
>  #endif
> +       {
> +               .procname       =3D "pid_max",
> +               .data           =3D &pid_max,
> +               .maxlen         =3D sizeof(int),
> +               .mode           =3D 0644,
> +               .proc_handler   =3D proc_dointvec_minmax,
> +               .extra1         =3D &pid_max_min,
> +               .extra2         =3D &pid_max_max,
> +       },
>         {
>                 .procname       =3D "panic_on_oops",
>                 .data           =3D &panic_on_oops,
> diff --git a/kernel/trace/pid_list.c b/kernel/trace/pid_list.c
> index c62b9b3cfb3d8..4966e6bbdf6f3 100644
> --- a/kernel/trace/pid_list.c
> +++ b/kernel/trace/pid_list.c
> @@ -414,7 +414,7 @@ struct trace_pid_list *trace_pid_list_alloc(void)
>         int i;
>
>         /* According to linux/thread.h, pids can be no bigger that 30 bit=
s */
> -       WARN_ON_ONCE(init_pid_ns.pid_max > (1 << 30));
> +       WARN_ON_ONCE(pid_max > (1 << 30));
>
>         pid_list =3D kzalloc(sizeof(*pid_list), GFP_KERNEL);
>         if (!pid_list)
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 9c21ba45b7af6..46c65402ad7e5 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -732,6 +732,8 @@ extern unsigned long tracing_thresh;
>
>  /* PID filtering */
>
> +extern int pid_max;
> +
>  bool trace_find_filtered_pid(struct trace_pid_list *filtered_pids,
>                              pid_t search_pid);
>  bool trace_ignore_this_task(struct trace_pid_list *filtered_pids,
> diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched=
_switch.c
> index cb49f7279dc80..573b5d8e8a28e 100644
> --- a/kernel/trace/trace_sched_switch.c
> +++ b/kernel/trace/trace_sched_switch.c
> @@ -442,7 +442,7 @@ int trace_alloc_tgid_map(void)
>         if (tgid_map)
>                 return 0;
>
> -       tgid_map_max =3D init_pid_ns.pid_max;
> +       tgid_map_max =3D pid_max;
>         map =3D kvcalloc(tgid_map_max + 1, sizeof(*tgid_map),
>                        GFP_KERNEL);
>         if (!map)
> --
> 2.48.1
>


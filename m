Return-Path: <linux-fsdevel+bounces-6358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3CD816BD2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 12:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF9DCB217B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 11:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEE018E00;
	Mon, 18 Dec 2023 11:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4Chd/co"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11165182C2;
	Mon, 18 Dec 2023 11:04:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74418C433C7;
	Mon, 18 Dec 2023 11:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702897490;
	bh=X7AmpNy7nTx85EVWdcqkSZ3s+USJadxyg/pD9mVPUtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E4Chd/co1bkcX+6Ux9mSS5u04qiUN/xoB4/VehY7U+0raPSN2/tLYM3utCFXSEgUj
	 f+QRR+7PbxpcIbcoRVtbfhwaebVDMqmV223WCWOZX7Y/ytdxdqXNCLB+j9qp6kgpwE
	 V1051YmrdFbmAoSQIHyQtO0YQdZvchUcPKVktV7I+ExjCPI3tYEt2oKQtoFPOPnmw7
	 VL3XE20JLdl/M3FnRxrEI21y+lZ7VJwudVZtV8gXsKwLElwGyPUR+oxRUH6wrKPLtV
	 vQf7A33ZSnwD4sxIOlhzP16izYBUxnFureNgEjznMfsyIw1rO5vjKwvpzJoOiOOysN
	 EbqVN6r0jZyuA==
Date: Mon, 18 Dec 2023 12:04:43 +0100
From: Christian Brauner <brauner@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, tglx@linutronix.de, x86@kernel.org,
	tj@kernel.org, peterz@infradead.org, mathieu.desnoyers@efficios.com,
	paulmck@kernel.org, keescook@chromium.org,
	dave.hansen@linux.intel.com, mingo@redhat.com, will@kernel.org,
	longman@redhat.com, boqun.feng@gmail.com,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>
Subject: Re: [PATCH 22/50] pid: Split out pid_types.h
Message-ID: <20231218-weswegen-geleugnet-f8c0d66ca848@brauner>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216032957.3553313-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231216032957.3553313-1-kent.overstreet@linux.dev>

On Fri, Dec 15, 2023 at 10:29:28PM -0500, Kent Overstreet wrote:
> Trimming down sched.h dependencies: we dont't want to include more than
> the base types.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Will Drewry <wad@chromium.org>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---

Hm, ideally the struct upid and struct pid definitions could also be
moved and then included in pid.h?

>  drivers/target/target_core_xcopy.c |  1 +
>  include/linux/pid.h                | 15 ++-------------
>  include/linux/pid_types.h          | 16 ++++++++++++++++
>  include/linux/sched.h              |  2 +-
>  include/linux/seccomp.h            |  2 ++
>  5 files changed, 22 insertions(+), 14 deletions(-)
>  create mode 100644 include/linux/pid_types.h
> 
> diff --git a/drivers/target/target_core_xcopy.c b/drivers/target/target_core_xcopy.c
> index 91ed015b588c..4128631c9dfd 100644
> --- a/drivers/target/target_core_xcopy.c
> +++ b/drivers/target/target_core_xcopy.c
> @@ -15,6 +15,7 @@
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <linux/list.h>
> +#include <linux/rculist.h>
>  #include <linux/configfs.h>
>  #include <linux/ratelimit.h>
>  #include <scsi/scsi_proto.h>
> diff --git a/include/linux/pid.h b/include/linux/pid.h
> index 653a527574c4..f254c3a45b9b 100644
> --- a/include/linux/pid.h
> +++ b/include/linux/pid.h
> @@ -2,18 +2,10 @@
>  #ifndef _LINUX_PID_H
>  #define _LINUX_PID_H
>  
> +#include <linux/pid_types.h>
>  #include <linux/rculist.h>
> -#include <linux/wait.h>
>  #include <linux/refcount.h>
> -
> -enum pid_type
> -{
> -	PIDTYPE_PID,
> -	PIDTYPE_TGID,
> -	PIDTYPE_PGID,
> -	PIDTYPE_SID,
> -	PIDTYPE_MAX,
> -};
> +#include <linux/wait.h>
>  
>  /*
>   * What is struct pid?
> @@ -110,9 +102,6 @@ extern void exchange_tids(struct task_struct *task, struct task_struct *old);
>  extern void transfer_pid(struct task_struct *old, struct task_struct *new,
>  			 enum pid_type);
>  
> -struct pid_namespace;
> -extern struct pid_namespace init_pid_ns;
> -
>  extern int pid_max;
>  extern int pid_max_min, pid_max_max;
>  
> diff --git a/include/linux/pid_types.h b/include/linux/pid_types.h
> new file mode 100644
> index 000000000000..c2aee1d91dcf
> --- /dev/null
> +++ b/include/linux/pid_types.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_PID_TYPES_H
> +#define _LINUX_PID_TYPES_H
> +
> +enum pid_type {
> +	PIDTYPE_PID,
> +	PIDTYPE_TGID,
> +	PIDTYPE_PGID,
> +	PIDTYPE_SID,
> +	PIDTYPE_MAX,
> +};
> +
> +struct pid_namespace;
> +extern struct pid_namespace init_pid_ns;
> +
> +#endif /* _LINUX_PID_TYPES_H */
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 436f7ce1450a..37cc9d257073 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -11,7 +11,7 @@
>  
>  #include <asm/current.h>
>  
> -#include <linux/pid.h>
> +#include <linux/pid_types.h>
>  #include <linux/sem.h>
>  #include <linux/shm.h>
>  #include <linux/kmsan_types.h>
> diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
> index 175079552f68..1ec0d8dc4b69 100644
> --- a/include/linux/seccomp.h
> +++ b/include/linux/seccomp.h
> @@ -126,6 +126,8 @@ static inline long seccomp_get_metadata(struct task_struct *task,
>  
>  #ifdef CONFIG_SECCOMP_CACHE_DEBUG
>  struct seq_file;
> +struct pid_namespace;
> +struct pid;
>  
>  int proc_pid_seccomp_cache(struct seq_file *m, struct pid_namespace *ns,
>  			   struct pid *pid, struct task_struct *task);
> -- 
> 2.43.0
> 


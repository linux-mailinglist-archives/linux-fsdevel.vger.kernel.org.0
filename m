Return-Path: <linux-fsdevel+bounces-13342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0630186ED10
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 00:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84B2F1F23964
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 23:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECAC5F49C;
	Fri,  1 Mar 2024 23:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZfslYog3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8F45DF13
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Mar 2024 23:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709337338; cv=none; b=niyMtaHdfjf3F9ewWxZ1z+AlwxtLj+G09Pn2w76rYzYPhiyKL6JhMyAxQB29xYc+PfajEefvKSIn5l1s3JVXCxH6RIWCPLBCA0FwujFH4s5byXrIazgAuZZL/3cm96F+LKojlqDfnBjgbS/zZA65QGAhHivuCJGEFJgmM3w76Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709337338; c=relaxed/simple;
	bh=4YGOE3S/+xlxJA6cepBgu5j+OzdBlb3dX5SQEc+qpek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXLJG6GLqUa1u1QnQHqbBED7JI84FgvtZGRLyfetugjsgAi1ZVHUu2Q16FvPOmTasVkFXJwrtekPnLg71y4UqjEC+UiKmljy+NKEQ1B3oqyBLEP/3pJCArau6vpuRoqI0c1Xg8kGtdqycMMFjeOPmZjQgW5vSlqp2DeGwQuxrt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZfslYog3; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso1951384a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Mar 2024 15:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709337335; x=1709942135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cJRi2nMvQ05iq4LzD2IglU9vOCyw2FiJe+YL2tOcuSs=;
        b=ZfslYog3jmE3dPViF7iY7uqBPyCEvf2YZcMJctFSVEGARB8jFkXxYEs9rX6pxZ3LDR
         XoUhr913lvbcOT1B2qfWHaUk0li3+BW1sQw1gQp5TmdOsSCUw80SAMXceYkQL7LN0Net
         YHmJNWl0HnwjEJvxs3KfMq/xVtAptqc1fLgyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709337335; x=1709942135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJRi2nMvQ05iq4LzD2IglU9vOCyw2FiJe+YL2tOcuSs=;
        b=XTv9cntgejq0pgfWILsO0vtEy5RGA7WkNr7eHZXsaewEaBxadQ304c7w9k1WgBJFTO
         tKtIFIkRlmi0BiNHtrlEgrBMtxQiXIuo6Hp9093unK/xoeANLRV70f4oKJ9nX5N7IBPv
         QiWrtPnz3Ld9mbIKHrsOZNpBC65/UHI3mqKptYlzywIEQ+NNY1Ks2zOjSpy0aYKfpfNk
         RSSk9abmUleFWsdilNb+vXwMumX3j8Jn8wdoG6Q8BNzvGD0A/DlvoDea8hDfxQn3InNQ
         ZjIupkuzmHddIP3mJy2PTVSr4fKwHsA3rzQevetTTbFHG+8/kAa+HklOel63y6o5fycd
         ajFg==
X-Gm-Message-State: AOJu0Yx+nU7Gq1/0meu14iQYXiSjhj9TTIyxqG70IsvjcDE0eqREjybm
	0zkIWDcjDctpYIf07i8iTYsielLM+O/8fN/UKkRtpt4n5kfD3CnnkDR/sDqy6g==
X-Google-Smtp-Source: AGHT+IFMn0iF/LiN2cgV3wkKV0EqqrvvmHS0VgJ728h/jd15ihsuhX1FcVHE5yRVhuwVXArK6vmibQ==
X-Received: by 2002:a17:902:c40f:b0:1dc:ad86:8f41 with SMTP id k15-20020a170902c40f00b001dcad868f41mr3048391plk.28.1709337335608;
        Fri, 01 Mar 2024 15:55:35 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l15-20020a170902f68f00b001dc96b19616sm4042292plg.66.2024.03.01.15.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 15:55:35 -0800 (PST)
Date: Fri, 1 Mar 2024 15:55:34 -0800
From: Kees Cook <keescook@chromium.org>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: linux-fsdevel@vger.kernel.org, kernel@collabora.com,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
	Guenter Roeck <groeck@chromium.org>,
	Doug Anderson <dianders@chromium.org>, Jann Horn <jannh@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Mike Frysinger <vapier@chromium.org>
Subject: Re: [PATCH v2] proc: allow restricting /proc/pid/mem writes
Message-ID: <202403011451.C236A38@keescook>
References: <20240301213442.198443-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301213442.198443-1-adrian.ratiu@collabora.com>

On Fri, Mar 01, 2024 at 11:34:42PM +0200, Adrian Ratiu wrote:
> Prior to v2.6.39 write access to /proc/<pid>/mem was restricted,
> after which it got allowed in commit 198214a7ee50 ("proc: enable
> writing to /proc/pid/mem"). Famous last words from that patch:
> "no longer a security hazard". :)
> 
> Afterwards exploits appeared started causing drama like [1]. The

nit: I think "appeared" can be dropped here.

> /proc/*/mem exploits can be rather sophisticated like [2] which
> installed an arbitrary payload from noexec storage into a running
> process then exec'd it, which itself could include an ELF loader
> to run arbitrary code off noexec storage.
> 
> As part of hardening against these types of attacks, distrbutions
> can restrict /proc/*/mem to only allow writes when they makes sense,
> like in case of debuggers which have ptrace permissions, as they
> are able to access memory anyway via PTRACE_POKEDATA and friends.
> 
> Dropping the mode bits disables write access for non-root users.
> Trying to `chmod` the paths back fails as the kernel rejects it.
> 
> For users with CAP_DAC_OVERRIDE (usually just root) we have to
> disable the mem_write callback to avoid bypassing the mode bits.
> 
> Writes can be used to bypass permissions on memory maps, even if a
> memory region is mapped r-x (as is a program's executable pages),
> the process can open its own /proc/self/mem file and write to the
> pages directly.
> 
> Even if seccomp filters block mmap/mprotect calls with W|X perms,
> they often cannot block open calls as daemons want to read/write
> their own runtime state and seccomp filters cannot check file paths.
> Write calls also can't be blocked in general via seccomp.
> 
> Since the mem file is part of the dynamic /proc/<pid>/ space, we
> can't run chmod once at boot to restrict it (and trying to react
> to every process and run chmod doesn't scale, and the kernel no
> longer allows chmod on any of these paths).
> 
> SELinux could be used with a rule to cover all /proc/*/mem files,
> but even then having multiple ways to deny an attack is useful in
> case on layer fails.

Everything above here is good to keep in the commit log, but it's all
the "background". Please also write here what has been done to address
the background above it. e.g.:

"Introduce a CONFIG and a __ro_after_init runtime toggle to make
it so only processes that are already tracing the task to write to
/proc/<pid>/mem." etc

> 
> [1] https://lwn.net/Articles/476947/
> [2] https://issues.chromium.org/issues/40089045

These can be:

Link: https://lwn.net/Articles/476947/ [1]
Link: https://issues.chromium.org/issues/40089045 [2]

> Based on an initial patch by Mike Frysinger <vapier@chromium.org>.
> 
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Co-developed-by: Mike Frysinger <vapier@chromium.org>
> Signed-off-by: Mike Frysinger <vapier@chromium.org>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
> Changes in v2:
>  * Added boot time parameter with default kconfig option
>  * Moved check earlier in mem_open() instead of mem_write()
>  * Simplified implementation branching
>  * Removed dependency on CONFIG_MEMCG

Can you mention in the commit log what behaviors have been tested with
this patch? For example, I assume gdb still works with
restrict_proc_mem_write=y ?

When this is enabled, what _does_ break that people might expect to
work?

> ---
>  .../admin-guide/kernel-parameters.txt         |  4 ++
>  fs/proc/base.c                                | 47 ++++++++++++++++++-
>  security/Kconfig                              | 22 +++++++++
>  3 files changed, 71 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 460b97a1d0da..0647e2f54248 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5618,6 +5618,10 @@
>  	reset_devices	[KNL] Force drivers to reset the underlying device
>  			during initialization.
>  
> +	restrict_proc_mem_write= [KNL]

Please add here:

			Format: <bool>

> +			Enable or disable write access to /proc/*/mem files.
> +			Default is SECURITY_PROC_MEM_RESTRICT_WRITE_DEFAULT_ON.
> +
>  	resume=		[SWSUSP]
>  			Specify the partition device for software suspend
>  			Format:
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 98a031ac2648..92f668191312 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -152,6 +152,30 @@ struct pid_entry {
>  		NULL, &proc_pid_attr_operations,	\
>  		{ .lsmid = LSMID })
>  
> +#ifdef CONFIG_SECURITY_PROC_MEM_RESTRICT_WRITE

Please drop this CONFIG entirely -- it should be always available for
all builds of the kernel. Only CONFIG_SECURITY_PROC_MEM_RESTRICT_WRITE_DEFAULT_ON
needs to remain.

> +DEFINE_STATIC_KEY_MAYBE_RO(CONFIG_SECURITY_PROC_MEM_RESTRICT_WRITE_DEFAULT_ON,
> +			   restrict_proc_mem_write);
> +static int __init early_restrict_proc_mem_write(char *buf)
> +{
> +	int ret;
> +	bool bool_result;
> +
> +	ret = kstrtobool(buf, &bool_result);
> +	if (ret)
> +		return ret;
> +
> +	if (bool_result)
> +		static_branch_enable(&restrict_proc_mem_write);
> +	else
> +		static_branch_disable(&restrict_proc_mem_write);
> +	return 0;
> +}
> +early_param("restrict_proc_mem_write", early_restrict_proc_mem_write);
> +# define PROC_PID_MEM_MODE S_IRUSR
> +#else
> +# define PROC_PID_MEM_MODE (S_IRUSR|S_IWUSR)
> +#endif

PROC_PID_MEM_MODE will need to be a __ro_after_init variable, set by
early_restrict_proc_mem_write, otherwise the mode won't change based on
the runtime setting. e.g.:

#ifdef CONFIG_SECURITY_PROC_MEM_RESTRICT_WRITE_DEFAULT_ON
mode_t proc_pid_mem_mode __ro_after_init = S_IRUSR;
#else
mode_t proc_pid_mem_mode __ro_after_init = (S_IRUSR|S_IWUSR);
#endif

DEFINE_STATIC_KEY_MAYBE_RO(CONFIG_SECURITY_PROC_MEM_RESTRICT_WRITE_DEFAULT_ON,
			   restrict_proc_mem_write);
...
	if (bool_result) {
		static_branch_enable(&restrict_proc_mem_write);
		proc_pid_mem_mode = S_IRUSR;
	} else {
		static_branch_disable(&restrict_proc_mem_write);
		proc_pid_mem_mode = (S_IRUSR|S_IWUSR);
	}
...
	REG("mem",        proc_pid_mem_mode, proc_mem_operations),


> +
>  /*
>   * Count the number of hardlinks for the pid_entry table, excluding the .
>   * and .. links.
> @@ -829,6 +853,25 @@ static int mem_open(struct inode *inode, struct file *file)
>  {
>  	int ret = __mem_open(inode, file, PTRACE_MODE_ATTACH);
>  
> +#ifdef CONFIG_SECURITY_PROC_MEM_RESTRICT_WRITE

Drop this ifdef (as mentioned above).

> +	struct mm_struct *mm = file->private_data;
> +	struct task_struct *task = get_proc_task(inode);
> +
> +	if (mm && task) {
> +		/* Only allow writes by processes already ptracing the target task */
> +		if (file->f_mode & FMODE_WRITE &&
> +		    static_branch_maybe(CONFIG_SECURITY_PROC_MEM_RESTRICT_WRITE_DEFAULT_ON,
> +					&restrict_proc_mem_write)) {

Do we need to also do an mm_access() on the task to verify that the task
we're about to check has its mm still matching file->private_data? The
PID can change out from under us (but the mm cannot).

> +			rcu_read_lock();
> +			if (!ptracer_capable(current, mm->user_ns) ||
> +			    current != ptrace_parent(task))

If you're just allowing "already ptracing", why include the
ptracer_capable() check?

> +				ret = -EACCES;
> +			rcu_read_unlock();
> +		}
> +		put_task_struct(task);
> +	}
> +#endif
> +
>  	/* OK to pass negative loff_t, we can catch out-of-range */
>  	file->f_mode |= FMODE_UNSIGNED_OFFSET;
>  
> @@ -3281,7 +3324,7 @@ static const struct pid_entry tgid_base_stuff[] = {
>  #ifdef CONFIG_NUMA
>  	REG("numa_maps",  S_IRUGO, proc_pid_numa_maps_operations),
>  #endif
> -	REG("mem",        S_IRUSR|S_IWUSR, proc_mem_operations),
> +	REG("mem",        PROC_PID_MEM_MODE, proc_mem_operations),
>  	LNK("cwd",        proc_cwd_link),
>  	LNK("root",       proc_root_link),
>  	LNK("exe",        proc_exe_link),
> @@ -3631,7 +3674,7 @@ static const struct pid_entry tid_base_stuff[] = {
>  #ifdef CONFIG_NUMA
>  	REG("numa_maps", S_IRUGO, proc_pid_numa_maps_operations),
>  #endif
> -	REG("mem",       S_IRUSR|S_IWUSR, proc_mem_operations),
> +	REG("mem",       PROC_PID_MEM_MODE, proc_mem_operations),
>  	LNK("cwd",       proc_cwd_link),
>  	LNK("root",      proc_root_link),
>  	LNK("exe",       proc_exe_link),
> diff --git a/security/Kconfig b/security/Kconfig
> index 412e76f1575d..ffee9e847ed9 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -19,6 +19,28 @@ config SECURITY_DMESG_RESTRICT
>  
>  	  If you are unsure how to answer this question, answer N.
>  
> +config SECURITY_PROC_MEM_RESTRICT_WRITE
> +	bool "Restrict /proc/*/mem write access"
> +	default n
> +	help
> +	  This restricts writes to /proc/<pid>/mem, except when the current
> +	  process ptraces the /proc/<pid>/mem task, because a ptracer already
> +	  has write access to the tracee memory.
> +
> +	  Write access to this file allows bypassing memory map permissions,
> +	  such as modifying read-only code.
> +
> +	  If you are unsure how to answer this question, answer N.
> +
> +config SECURITY_PROC_MEM_RESTRICT_WRITE_DEFAULT_ON
> +	bool "Default state of /proc/*/mem write restriction"
> +	depends on SECURITY_PROC_MEM_RESTRICT_WRITE
> +	default y
> +	help
> +	  /proc/*/mem write access is controlled by kernel boot param
> +	  "restrict_proc_mem_write" and this config chooses the default
> +	  boot state.

As mentioned, I'd say merge the help texts here, but drop
SECURITY_PROC_MEM_RESTRICT_WRITE.

> +
>  config SECURITY
>  	bool "Enable different security models"
>  	depends on SYSFS
> -- 
> 2.30.2
> 

Thanks for this! I look forward to turning it on. :)

-Kees

-- 
Kees Cook


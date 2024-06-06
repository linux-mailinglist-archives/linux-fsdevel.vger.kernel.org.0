Return-Path: <linux-fsdevel+bounces-21127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D41438FF402
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 19:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60E4728F034
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 17:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63420199231;
	Thu,  6 Jun 2024 17:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ra5MycXp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21A819750B;
	Thu,  6 Jun 2024 17:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717695942; cv=none; b=jwJUQ35WdLZuX8o91pfrYo8wasa+rvUKcm+3aPC3Pk+r0O3NCr10jfYJ3eQV/L8bbNMncQr1GZPa1As7u1oB9ombOlOacwYQqBmCt/vTvw/kXXrerlkLLWeVShmKobzxLcLjUdlPA7UnvRx7MjTz9DDncdVQy0L1LiakuKJbqNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717695942; c=relaxed/simple;
	bh=VHp5cNwisficT3UFJaptVr+x7WcGyhbY7LEC8jqZGqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTg67s5ATAHq6xYam5jPv1MpF3ObN3uYyeJlwS14d67mNUSmf5EQxnkXCGqrHoYDpn4jL6x/XwEofnM4LjU7x8DM2ebgKMqfov9MyBgfKvDIVlfw3eEEeKhtlwr6YLJva4FmRI7rjt1+wQgOEtd0r8QZ6qCRWxlXWnd1kNWWiVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ra5MycXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4005BC2BD10;
	Thu,  6 Jun 2024 17:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717695942;
	bh=VHp5cNwisficT3UFJaptVr+x7WcGyhbY7LEC8jqZGqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ra5MycXpxbLxc2Ty0FCZekvRNBJxHXadnEf6LNXLfv8hRxpZP3jAsaXygVsN1G4jJ
	 0DkkijS5Qr9d5Z7mDj/DQZL4aYfgBXAXRSJNdN/pPCD7BRMoBJb37FLh21/3OgsHO6
	 kyFL36ND4E7u/5I11pkgAkX5u6AlzlqSaEt+9zgjf1YlWutLjhGIUxtYmFswdUALT+
	 /s5G314AcvywHr2sCtJaixL3aLn6rN+0Wo83rh4b8MH87p5MW/gmHQ3kChRyuQMk9V
	 2cIhbQ4QZvov2bJhx1ablZvUk8nDn/9Wu4uckePcNp5uEQJmUhAYALf711Le98Bk0x
	 tLrZUM/r+9PdA==
Date: Thu, 6 Jun 2024 10:45:41 -0700
From: Kees Cook <kees@kernel.org>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-doc@vger.kernel.org, kernel@collabora.com, gbiv@google.com,
	ryanbeltran@google.com, inglorion@google.com, ajordanr@google.com,
	jorgelo@chromium.org, Guenter Roeck <groeck@chromium.org>,
	Doug Anderson <dianders@chromium.org>, Jann Horn <jannh@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Christian Brauner <brauner@kernel.org>, Jeff Xu <jeffxu@google.com>,
	Mike Frysinger <vapier@chromium.org>
Subject: Re: [PATCH v5 2/2] proc: restrict /proc/pid/mem
Message-ID: <202406060917.8DEE8E3@keescook>
References: <20240605164931.3753-1-adrian.ratiu@collabora.com>
 <20240605164931.3753-2-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605164931.3753-2-adrian.ratiu@collabora.com>

On Wed, Jun 05, 2024 at 07:49:31PM +0300, Adrian Ratiu wrote:
> +	proc_mem.restrict_foll_force= [KNL]
> +			Format: {all | ptracer}
> +			Restricts the use of the FOLL_FORCE flag for /proc/*/mem access.
> +			If restricted, the FOLL_FORCE flag will not be added to vm accesses.
> +			Can be one of:
> +			- 'all' restricts all access unconditionally.
> +			- 'ptracer' allows access only for ptracer processes.
> +			If not specified, FOLL_FORCE is always used.

It dawns on me that we likely need an "off" setting for these in case it
was CONFIG-enabled...

> +static int __init early_proc_mem_restrict_##name(char *buf)			\
> +{										\
> +	if (!buf)								\
> +		return -EINVAL;							\
> +										\
> +	if (strcmp(buf, "all") == 0)						\
> +		static_key_slow_inc(&proc_mem_restrict_##name##_all.key);	\
> +	else if (strcmp(buf, "ptracer") == 0)					\
> +		static_key_slow_inc(&proc_mem_restrict_##name##_ptracer.key);	\
> +	return 0;								\
> +}										\
> +early_param("proc_mem.restrict_" #name, early_proc_mem_restrict_##name)

Why slow_inc here instead of the normal static_key_enable/disable?

And we should report misparsing too, so perhaps:

static int __init early_proc_mem_restrict_##name(char *buf)			\
{										\
	if (!buf)								\
		return -EINVAL;							\
										\
	if (strcmp(buf, "all") == 0) {						\
		static_key_enable(&proc_mem_restrict_##name##_all.key);		\
		static_key_disable(&proc_mem_restrict_##name##_ptracer.key);	\
	} else if (strcmp(buf, "ptracer") == 0) {				\
		static_key_disable(&proc_mem_restrict_##name##_all.key);	\
		static_key_enable(&proc_mem_restrict_##name##_ptracer.key);	\
	} else if (strcmp(buf, "off") == 0) {					\
		static_key_disable(&proc_mem_restrict_##name##_all.key);	\
		static_key_disable(&proc_mem_restrict_##name##_ptracer.key);	\
	} else									\
		pr_warn("%s: ignoring unknown option '%s'\n",			\
			"proc_mem.restrict_" #name, buf);			\
	return 0;								\
}										\
early_param("proc_mem.restrict_" #name, early_proc_mem_restrict_##name)

> +static int __mem_open_access_permitted(struct file *file, struct task_struct *task)
> +{
> +	bool is_ptracer;
> +
> +	rcu_read_lock();
> +	is_ptracer = current == ptrace_parent(task);
> +	rcu_read_unlock();
> +
> +	if (file->f_mode & FMODE_WRITE) {
> +		/* Deny if writes are unconditionally disabled via param */
> +		if (static_branch_maybe(CONFIG_PROC_MEM_RESTRICT_OPEN_WRITE_DEFAULT,
> +					&proc_mem_restrict_open_write_all))
> +			return -EACCES;
> +
> +		/* Deny if writes are allowed only for ptracers via param */
> +		if (static_branch_maybe(CONFIG_PROC_MEM_RESTRICT_OPEN_WRITE_PTRACE_DEFAULT,
> +					&proc_mem_restrict_open_write_ptracer) &&
> +		    !is_ptracer)
> +			return -EACCES;
> +	}
> +
> +	if (file->f_mode & FMODE_READ) {
> +		/* Deny if reads are unconditionally disabled via param */
> +		if (static_branch_maybe(CONFIG_PROC_MEM_RESTRICT_OPEN_READ_DEFAULT,
> +					&proc_mem_restrict_open_read_all))
> +			return -EACCES;
> +
> +		/* Deny if reads are allowed only for ptracers via param */
> +		if (static_branch_maybe(CONFIG_PROC_MEM_RESTRICT_OPEN_READ_PTRACE_DEFAULT,
> +					&proc_mem_restrict_open_read_ptracer) &&
> +		    !is_ptracer)
> +			return -EACCES;
> +	}
> +
> +	return 0; /* R/W are not restricted */
> +}

Given how deeply some of these behaviors may be in userspace, it might
be more friendly to report the new restrictions with a pr_notice() so
problems can be more easily tracked down. For example:

static void report_mem_rw_rejection(const char *action, struct task_struct *task)
{
	pr_warn_ratelimited("Denied %s of /proc/%d/mem (%s) by pid %d (%s)\n",
			    action, task_pid_nr(task), task->comm,
			    task_pid_nr(current), current->comm);
}

...

	if (file->f_mode & FMODE_WRITE) {
		/* Deny if writes are unconditionally disabled via param */
		if (static_branch_maybe(CONFIG_PROC_MEM_RESTRICT_OPEN_WRITE_DEFAULT,
					&proc_mem_restrict_open_write_all)) {
			report_mem_rw_reject("all open-for-write");
			return -EACCES;
		}

		/* Deny if writes are allowed only for ptracers via param */
		if (static_branch_maybe(CONFIG_PROC_MEM_RESTRICT_OPEN_WRITE_PTRACE_DEFAULT,
					&proc_mem_restrict_open_write_ptracer) &&
		    !is_ptracer)
			report_mem_rw_reject("non-ptracer open-for-write");
			return -EACCES;
	}

etc

> +static bool __mem_rw_current_is_ptracer(struct file *file)
> +{
> +	struct inode *inode = file_inode(file);
> +	struct task_struct *task = get_proc_task(inode);
> +	struct mm_struct *mm = NULL;
> +	int is_ptracer = false, has_mm_access = false;
> +
> +	if (task) {
> +		rcu_read_lock();
> +		is_ptracer = current == ptrace_parent(task);
> +		rcu_read_unlock();
> +
> +		mm = mm_access(task, PTRACE_MODE_READ_FSCREDS);
> +		if (mm && file->private_data == mm) {
> +			has_mm_access = true;
> +			mmput(mm);
> +		}
> +
> +		put_task_struct(task);
> +	}
> +
> +	return is_ptracer && has_mm_access;
> +}

Thanks; this looks right to me now!

> +menu "Procfs mem restriction options"
> +
> +config PROC_MEM_RESTRICT_FOLL_FORCE_DEFAULT
> +	bool "Restrict all FOLL_FORCE flag usage"
> +	default n
> +	help
> +	  Restrict all FOLL_FORCE usage during /proc/*/mem RW.
> +	  Debuggers like GDB require using FOLL_FORCE for basic
> +	  functionality.
> +
> +config PROC_MEM_RESTRICT_FOLL_FORCE_PTRACE_DEFAULT
> +	bool "Restrict FOLL_FORCE usage except for ptracers"
> +	default n
> +	help
> +	  Restrict FOLL_FORCE usage during /proc/*/mem RW, except
> +	  for ptracer processes. Debuggers like GDB require using
> +	  FOLL_FORCE for basic functionality.

Can we adjust the Kconfigs to match the bootparam arguments? i.e.
instead of two for each mode, how about one with 3 settings ("all",
"ptrace", or "off")

choice
	prompt "Restrict /proc/pid/mem FOLL_FORCE usage"
	default PROC_MEM_RESTRICT_FOLL_FORCE_OFF
	help
	  Reading and writing of /proc/pid/mem bypasses memory permission
	  checks due to the internal use of the FOLL_FORCE flag. This can be
	  used by attackers to manipulate process memory contents that
	  would have been otherwise protected. However, debuggers, like GDB,
	  use this to set breakpoints, etc. To force debuggers to fall back
	  to PEEK/POKE, see PROC_MEM_RESTRICT_OPEN_WRITE_ALL.

	config PROC_MEM_RESTRICT_FOLL_FORCE_OFF
	bool "Do not restrict FOLL_FORCE usage with /proc/pid/mem (regular)"
	help
	  Regular behavior: continue to use the FOLL_FORCE flag for
	  /proc/pid/mem access.

	config PROC_MEM_RESTRICT_FOLL_FORCE_PTRACE
	bool "Only allow ptracers to use FOLL_FORCE with /proc/pid/mem (safer)"
	help
	  Only use the FOLL_FORCE flag for /proc/pid/mem access when the
	  current task is the active ptracer of the target task. (Safer,
	  least disruptive to most usage patterns.)

	config PROC_MEM_RESTRICT_FOLL_FORCE_ALL
	bool "Do not use FOLL_FORCE with /proc/pid/mem (safest)"
	help
	  Remove the FOLL_FORCE flag for all /proc/pid/mem accesses.
	  (Safest, but may be disruptive to some usage patterns.)
endchoice

Then the static_keys can be defined like this mess (I couldn't find a
cleaner way to do it):

#define DEFINE_STATIC_KEY_PROC_MEM_ALL(name) \
	DEFINE_STATIC_KEY_TRUE_RO(proc_mem_restrict_##name##_all);	\
	DEFINE_STATIC_KEY_FALSE_RO(proc_mem_restrict_##name##_ptracer);
#define DEFINE_STATIC_KEY_PROC_MEM_PTRACE(name) \
	DEFINE_STATIC_KEY_FALSE_RO(proc_mem_restrict_##name##_all);	\
	DEFINE_STATIC_KEY_TRUE_RO(proc_mem_restrict_##name##_ptracer);
#define DEFINE_STATIC_KEY_PROC_MEM_OFF(name) \
	DEFINE_STATIC_KEY_FALSE_RO(proc_mem_restrict_##name##_all);	\
	DEFINE_STATIC_KEY_FALSE_RO(proc_mem_restrict_##name##_ptracer);

#define DEFINE_STATIC_KEY_PROC_MEM_0(level, name)
#define DEFINE_STATIC_KEY_PROC_MEM_1(level, name)		\
	DEFINE_STATIC_KEY_PROC_MEM_##level(name)

#define _DEFINE_STATIC_KEY_PROC_MEM_PICK(enabled, level, name)   \
DEFINE_STATIC_KEY_PROC_MEM_##enabled(level, name)

#define DEFINE_STATIC_KEY_PROC_MEM_PICK(enabled, level, name)   \
_DEFINE_STATIC_KEY_PROC_MEM_PICK(enabled, level, name)

#define DEFINE_STATIC_KEY_PROC_MEM(CFG, name)			\
DEFINE_STATIC_KEY_PROC_MEM_PICK(IS_ENABLED(CONFIG_PROC_MEM_RESTRICT_##CFG##_ALL), ALL, name)
DEFINE_STATIC_KEY_PROC_MEM_PICK(IS_ENABLED(CONFIG_PROC_MEM_RESTRICT_##CFG##_PTRACE), PTRACE, name)
DEFINE_STATIC_KEY_PROC_MEM_PICK(IS_ENABLED(CONFIG_PROC_MEM_RESTRICT_##CFG##_OFF), OFF, name)

#define DEFINE_EARLY_PROC_MEM_RESTRICT(CFG, name)				\
DEFINE_STATIC_KEY_PROC_MEM(CFG, name)						\
static int __init early_proc_mem_restrict_##name(char *buf)			\
{										\
	if (!buf)								\
		return -EINVAL;							\
										\
	if (strcmp(buf, "all") == 0) {						\
		static_key_enable(&proc_mem_restrict_##name##_all.key);		\
		static_key_disable(&proc_mem_restrict_##name##_ptracer.key);	\
	} else if (strcmp(buf, "ptracer") == 0) {				\
		static_key_disable(&proc_mem_restrict_##name##_all.key);	\
		static_key_enable(&proc_mem_restrict_##name##_ptracer.key);	\
	} else if (strcmp(buf, "off") == 0) {					\
		static_key_disable(&proc_mem_restrict_##name##_all.key);	\
		static_key_disable(&proc_mem_restrict_##name##_ptracer.key);	\
	} else									\
		pr_warn("%s: ignoring unknown option '%s'\n",			\
			"proc_mem.restrict_" #name, buf);			\
	return 0;								\
}										\
early_param("proc_mem.restrict_" #name, early_proc_mem_restrict_##name)

DEFINE_EARLY_PROC_MEM_RESTRICT(OPEN_READ, open_read);
DEFINE_EARLY_PROC_MEM_RESTRICT(OPEN_WRITE, open_write);
DEFINE_EARLY_PROC_MEM_RESTRICT(WRITE, write);
DEFINE_EARLY_PROC_MEM_RESTRICT(FOLL_FORCE, foll_force);



-- 
Kees Cook


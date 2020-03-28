Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDE72196932
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Mar 2020 21:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbgC1U2c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Mar 2020 16:28:32 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40672 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbgC1U2c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Mar 2020 16:28:32 -0400
Received: by mail-pg1-f196.google.com with SMTP id t24so6549975pgj.7
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2020 13:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MUiWV4pjfeHPi8U1e/rHhzPVFQ2nBZ/K1op0DmSl2ak=;
        b=O356OkPU3ESu244KOG9mhvpPy+52uafWy+esv/NqtJeU4HkZdS2FgU1+D6ku18Ey9U
         WwE1swFtAGXf6jIcipRl3rxt7eSXUxtW5jNPJbCl+RWJmyxlvMgSIRn/BFX3k8XEF5Jz
         fm+WSAuOQB8rXjlO7nq1GRvVm1DR6X/f6Bd1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MUiWV4pjfeHPi8U1e/rHhzPVFQ2nBZ/K1op0DmSl2ak=;
        b=gG685OfmSHDQ/mV/yaz9ERCDIlVflH8G8/9H0fInAKKfHbWyC+QHDgGqH53lAjoBwb
         mwF7DT2th9HiPVjy6eIGf4otuZc5qw5ea3WlbJQ9DdsEERPhyFPAlL7OEhyn2/0zq+sN
         Eh0IiM62cdhrJlBcMLkkfwr5oqaBH25X6/oTDJ3cbqkXlrS2R/G/01hT1K2u74C2GRpn
         vIyY2VkR3KPN3Qap4KJMfUNlEJAdbW/vIvVN/mOHDrqQ/dHxaN3hkk747Ie9yKpr7Xuq
         skPf1mku1Z0Zxqx1vZ/HyiCt7xEhC8/inHIc0kGnAmjHGq8r8b644EktLpl7EUZfAHp0
         xFVg==
X-Gm-Message-State: ANhLgQ3k7ot8V7udcPU6N1jLFgrJtV6V1xImueagcOgUCvdUdNcvxgC6
        rD231i26wwUI6B2Tj8Zfd1Q0vA==
X-Google-Smtp-Source: ADFU+vvfFxyZ2kTL+AiPQZIPrYo32pSmRxmE/hu6jvevOYpyed0FsDRABSVDRXjfu6Xe5G8kaOa63g==
X-Received: by 2002:aa7:959a:: with SMTP id z26mr5695770pfj.211.1585427310147;
        Sat, 28 Mar 2020 13:28:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r63sm6926642pfr.42.2020.03.28.13.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 13:28:29 -0700 (PDT)
Date:   Sat, 28 Mar 2020 13:28:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v10 8/9] proc: use human-readable values for hidehid
Message-ID: <202003281321.A69D9DE45@keescook>
References: <20200327172331.418878-1-gladkov.alexey@gmail.com>
 <20200327172331.418878-9-gladkov.alexey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327172331.418878-9-gladkov.alexey@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 27, 2020 at 06:23:30PM +0100, Alexey Gladkov wrote:
> The hidepid parameter values are becoming more and more and it becomes
> difficult to remember what each new magic number means.
> 
> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Reviewed-by: Alexey Dobriyan <adobriyan@gmail.com>
> Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
> ---
>  Documentation/filesystems/proc.txt | 52 +++++++++++++++---------------
>  fs/proc/inode.c                    | 13 +++++++-
>  fs/proc/root.c                     | 36 +++++++++++++++++++--
>  3 files changed, 71 insertions(+), 30 deletions(-)
> 
> diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
> index bd0e0ab85048..af47672cb2cb 100644
> --- a/Documentation/filesystems/proc.txt
> +++ b/Documentation/filesystems/proc.txt
> @@ -2025,28 +2025,28 @@ The following mount options are supported:
>  	gid=		Set the group authorized to learn processes information.
>  	subset=		Show only the specified subset of procfs.
>  
> -hidepid=0 means classic mode - everybody may access all /proc/<pid>/ directories
> -(default).
> -
> -hidepid=1 means users may not access any /proc/<pid>/ directories but their
> -own.  Sensitive files like cmdline, sched*, status are now protected against
> -other users.  This makes it impossible to learn whether any user runs
> -specific program (given the program doesn't reveal itself by its behaviour).
> -As an additional bonus, as /proc/<pid>/cmdline is unaccessible for other users,
> -poorly written programs passing sensitive information via program arguments are
> -now protected against local eavesdroppers.
> -
> -hidepid=2 means hidepid=1 plus all /proc/<pid>/ will be fully invisible to other
> -users.  It doesn't mean that it hides a fact whether a process with a specific
> -pid value exists (it can be learned by other means, e.g. by "kill -0 $PID"),
> -but it hides process' uid and gid, which may be learned by stat()'ing
> -/proc/<pid>/ otherwise.  It greatly complicates an intruder's task of gathering
> -information about running processes, whether some daemon runs with elevated
> -privileges, whether other user runs some sensitive program, whether other users
> -run any program at all, etc.
> -
> -hidepid=4 means that procfs should only contain /proc/<pid>/ directories
> -that the caller can ptrace.
> +hidepid=off or hidepid=0 means classic mode - everybody may access all
> +/proc/<pid>/ directories (default).
> +
> +hidepid=noaccess or hidepid=1 means users may not access any /proc/<pid>/
> +directories but their own.  Sensitive files like cmdline, sched*, status are now
> +protected against other users.  This makes it impossible to learn whether any
> +user runs specific program (given the program doesn't reveal itself by its
> +behaviour).  As an additional bonus, as /proc/<pid>/cmdline is unaccessible for
> +other users, poorly written programs passing sensitive information via program
> +arguments are now protected against local eavesdroppers.
> +
> +hidepid=invisible or hidepid=2 means hidepid=noaccess plus all /proc/<pid>/ will
> +be fully invisible to other users.  It doesn't mean that it hides a fact whether
> +a process with a specific pid value exists (it can be learned by other means,
> +e.g. by "kill -0 $PID"), but it hides process' uid and gid, which may be learned
> +by stat()'ing /proc/<pid>/ otherwise.  It greatly complicates an intruder's task
> +of gathering information about running processes, whether some daemon runs with
> +elevated privileges, whether other user runs some sensitive program, whether
> +other users run any program at all, etc.
> +
> +hidepid=ptraceable or hidepid=4 means that procfs should only contain
> +/proc/<pid>/ directories that the caller can ptrace.
>  
>  gid= defines a group authorized to learn processes information otherwise
>  prohibited by hidepid=.  If you use some daemon like identd which needs to learn
> @@ -2093,8 +2093,8 @@ creates a new procfs instance. Mount options affect own procfs instance.
>  It means that it became possible to have several procfs instances
>  displaying tasks with different filtering options in one pid namespace.
>  
> -# mount -o hidepid=2 -t proc proc /proc
> -# mount -o hidepid=1 -t proc proc /tmp/proc
> +# mount -o hidepid=invisible -t proc proc /proc
> +# mount -o hidepid=noaccess -t proc proc /tmp/proc
>  # grep ^proc /proc/mounts
> -proc /proc proc rw,relatime,hidepid=2 0 0
> -proc /tmp/proc proc rw,relatime,hidepid=1 0 0
> +proc /proc proc rw,relatime,hidepid=invisible 0 0
> +proc /tmp/proc proc rw,relatime,hidepid=noaccess 0 0
> diff --git a/fs/proc/inode.c b/fs/proc/inode.c
> index e6577ce6027b..f01fb4bed75c 100644
> --- a/fs/proc/inode.c
> +++ b/fs/proc/inode.c
> @@ -165,6 +165,17 @@ void proc_invalidate_siblings_dcache(struct hlist_head *inodes, spinlock_t *lock
>  		deactivate_super(old_sb);
>  }
>  
> +static inline const char *hidepid2str(int v)
> +{
> +	switch (v) {
> +		case HIDEPID_OFF: return "off";
> +		case HIDEPID_NO_ACCESS: return "noaccess";
> +		case HIDEPID_INVISIBLE: return "invisible";
> +		case HIDEPID_NOT_PTRACEABLE: return "ptraceable";
> +	}
> +	BUG();

Please don't use BUG()[1]. Add a default case with a warn and return
"unknown":

	switch (v) {
	case HIDEPID_OFF: return "off";
	case HIDEPID_NO_ACCESS: return "noaccess";
	case HIDEPID_INVISIBLE: return "invisible";
	case HIDEPID_NOT_PTRACEABLE: return "ptraceable";
	default:
		WARN_ON_ONCE("bad hide_pid value: %d\n", v);
		return "unknown";
	}

[1] https://lore.kernel.org/lkml/202003141524.59C619B51A@keescook/

> +}
> +
>  static int proc_show_options(struct seq_file *seq, struct dentry *root)
>  {
>  	struct proc_fs_info *fs_info = proc_sb_info(root->d_sb);
> @@ -172,7 +183,7 @@ static int proc_show_options(struct seq_file *seq, struct dentry *root)
>  	if (!gid_eq(fs_info->pid_gid, GLOBAL_ROOT_GID))
>  		seq_printf(seq, ",gid=%u", from_kgid_munged(&init_user_ns, fs_info->pid_gid));
>  	if (fs_info->hide_pid != HIDEPID_OFF)
> -		seq_printf(seq, ",hidepid=%u", fs_info->hide_pid);
> +		seq_printf(seq, ",hidepid=%s", hidepid2str(fs_info->hide_pid));
>  	if (fs_info->pidonly != PROC_PIDONLY_OFF)
>  		seq_printf(seq, ",subset=pid");
>  
> diff --git a/fs/proc/root.c b/fs/proc/root.c
> index dbcd96f07c7a..ba782d6e6197 100644
> --- a/fs/proc/root.c
> +++ b/fs/proc/root.c
> @@ -45,7 +45,7 @@ enum proc_param {
>  
>  static const struct fs_parameter_spec proc_fs_parameters[] = {
>  	fsparam_u32("gid",	Opt_gid),
> -	fsparam_u32("hidepid",	Opt_hidepid),
> +	fsparam_string("hidepid",	Opt_hidepid),
>  	fsparam_string("subset",	Opt_subset),
>  	{}
>  };
> @@ -58,6 +58,35 @@ static inline int valid_hidepid(unsigned int value)
>  		value == HIDEPID_NOT_PTRACEABLE);
>  }
>  
> +static int proc_parse_hidepid_param(struct fs_context *fc, struct fs_parameter *param)
> +{
> +	struct proc_fs_context *ctx = fc->fs_private;
> +	struct fs_parameter_spec hidepid_u32_spec = fsparam_u32("hidepid", Opt_hidepid);
> +	struct fs_parse_result result;
> +	int base = (unsigned long)hidepid_u32_spec.data;
> +
> +	if (param->type != fs_value_is_string)
> +		return invalf(fc, "proc: unexpected type of hidepid value\n");
> +
> +	if (!kstrtouint(param->string, base, &result.uint_32)) {
> +		ctx->hidepid = result.uint_32;

This need to bounds-check the value with a call to valid_hidepid(), yes?

> +		return 0;
> +	}
> +
> +	if (!strcmp(param->string, "off"))
> +		ctx->hidepid = HIDEPID_OFF;
> +	else if (!strcmp(param->string, "noaccess"))
> +		ctx->hidepid = HIDEPID_NO_ACCESS;
> +	else if (!strcmp(param->string, "invisible"))
> +		ctx->hidepid = HIDEPID_INVISIBLE;
> +	else if (!strcmp(param->string, "ptraceable"))
> +		ctx->hidepid = HIDEPID_NOT_PTRACEABLE;
> +	else
> +		return invalf(fc, "proc: unknown value of hidepid - %s\n", param->string);
> +
> +	return 0;
> +}
> +
>  static int proc_parse_subset_param(struct fs_context *fc, char *value)
>  {
>  	struct proc_fs_context *ctx = fc->fs_private;
> @@ -97,9 +126,10 @@ static int proc_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  		break;
>  
>  	case Opt_hidepid:
> -		if (!valid_hidepid(result.uint_32))
> +		if (proc_parse_hidepid_param(fc, param))
> +			return -EINVAL;
> +		if (!valid_hidepid(ctx->hidepid))
>  			return invalf(fc, "proc: unknown value of hidepid.\n");
> -		ctx->hidepid = result.uint_32;
>  		break;
>  
>  	case Opt_subset:
> -- 
> 2.25.2
> 

-- 
Kees Cook

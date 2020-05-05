Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEED1C6310
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 23:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgEEV3Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 17:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728737AbgEEV3Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 17:29:24 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EA4C061A10
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2020 14:29:24 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t16so1389178plo.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2020 14:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EDrA3WErwpCtQ8L6EdPv2ftaqzs7+MpluPQN8EKLOXs=;
        b=dUcO2+PGPwbl6Ze2UdJ8klnItltyK7nqTVBYryuc6tW+XPSzyVopg/F99rQTqgy3lV
         tUXf3RnHHPnngiCHWrlqHPJ74v3Yu/aD65Srfq9hsddZ94wIRcuFXYY7sk4WhrIQG0Eg
         pAfgJwrHKdTpoCAYTwUKAiNFZVqSO7+VPNmnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EDrA3WErwpCtQ8L6EdPv2ftaqzs7+MpluPQN8EKLOXs=;
        b=A8aN1Hmj1J+NxlSaF/i4ySN+o3r+aP/lg1YReg/be29DyKEF4p3sMDPd2n7zMS0oVk
         S45ApgsBYmVGlIDfJ1+HpE4J9PEjGU/pC/o2aC9AsrFGkeS8z2DaV4ZTgFYW3Dm/jVOd
         luBkvmQ4Pn20qrkjSQcOGQ5WO7wq/85U0fXEzNslIRSxGVU+Oysp+7OeyWPPONH3mmQZ
         D4CZ1v9GxlR2Or9B44taxI3w0zMpMhHUggn+tMurwTpkWD3R3qulxC1MjU87UXIxNs6L
         hOrcCaBFAiwtWHsjJnPO+XNt13qDCIxyITrFwwSjepwPTiXx479+vNbLE5RowUhcLJkV
         WyiA==
X-Gm-Message-State: AGi0PuZxIxf873DAKcTcqboAL2+XsLI47KUtKsS+Xg2M6uVj50QH/eFH
        IC83ZK7xQsTHS6WxekCwvvDzjg==
X-Google-Smtp-Source: APiQypK96XZM83NICKIvnksDTYIz98ombvr9D8WWyrfcfaG9hfcmWIAUt3n99BdnL+XV2a4Z4fBE3w==
X-Received: by 2002:a17:90a:32ea:: with SMTP id l97mr5537277pjb.50.1588714163501;
        Tue, 05 May 2020 14:29:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c10sm3099846pfm.50.2020.05.05.14.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 14:29:22 -0700 (PDT)
Date:   Tue, 5 May 2020 14:29:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6/7] exec: Move most of setup_new_exec into flush_old_exec
Message-ID: <202005051354.C7E2278688@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87ftcei2si.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftcei2si.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 05, 2020 at 02:45:33PM -0500, Eric W. Biederman wrote:
> 
> The current idiom for the callers is:
> 
> flush_old_exec(bprm);
> set_personality(...);
> setup_new_exec(bprm);
> 
> In 2010 Linus split flush_old_exec into flush_old_exec and
> setup_new_exec.  With the intention that setup_new_exec be what is
> called after the processes new personality is set.
> 
> Move the code that doesn't depend upon the personality from
> setup_new_exec into flush_old_exec.  This is to facilitate future
> changes by having as much code together in one function as possible.

Er, I *think* this is okay, but I have some questions below which
maybe you already investigated (and should perhaps get called out in
the changelog).

> 
> Ref: 221af7f87b97 ("Split 'flush_old_exec' into two functions")
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  fs/exec.c | 85 ++++++++++++++++++++++++++++---------------------------
>  1 file changed, 44 insertions(+), 41 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 8c3abafb9bb1..0eff20558735 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1359,39 +1359,7 @@ int flush_old_exec(struct linux_binprm * bprm)
>  	 * undergoing exec(2).
>  	 */
>  	do_close_on_exec(me->files);
> -	return 0;
> -
> -out_unlock:
> -	mutex_unlock(&me->signal->exec_update_mutex);
> -out:
> -	return retval;
> -}
> -EXPORT_SYMBOL(flush_old_exec);
> -
> -void would_dump(struct linux_binprm *bprm, struct file *file)
> -{
> -	struct inode *inode = file_inode(file);
> -	if (inode_permission(inode, MAY_READ) < 0) {
> -		struct user_namespace *old, *user_ns;
> -		bprm->interp_flags |= BINPRM_FLAGS_ENFORCE_NONDUMP;
> -
> -		/* Ensure mm->user_ns contains the executable */
> -		user_ns = old = bprm->mm->user_ns;
> -		while ((user_ns != &init_user_ns) &&
> -		       !privileged_wrt_inode_uidgid(user_ns, inode))
> -			user_ns = user_ns->parent;
>  
> -		if (old != user_ns) {
> -			bprm->mm->user_ns = get_user_ns(user_ns);
> -			put_user_ns(old);
> -		}
> -	}
> -}
> -EXPORT_SYMBOL(would_dump);
> -
> -void setup_new_exec(struct linux_binprm * bprm)
> -{
> -	struct task_struct *me = current;
>  	/*
>  	 * Once here, prepare_binrpm() will not be called any more, so
>  	 * the final state of setuid/setgid/fscaps can be merged into the
> @@ -1414,8 +1382,6 @@ void setup_new_exec(struct linux_binprm * bprm)
>  			bprm->rlim_stack.rlim_cur = _STK_LIM;
>  	}
>  
> -	arch_pick_mmap_layout(me->mm, &bprm->rlim_stack);
> -
>  	me->sas_ss_sp = me->sas_ss_size = 0;
>  
>  	/*
> @@ -1430,16 +1396,9 @@ void setup_new_exec(struct linux_binprm * bprm)
>  	else
>  		set_dumpable(current->mm, SUID_DUMP_USER);
>  
> -	arch_setup_new_exec();
>  	perf_event_exec();

What is perf expecting to be able to examine at this point? Does it want
a view of things after arch_setup_new_exec()? (i.e. "final" TIF flags,
mmap layout, etc.) From what I can, the answer is "no, it's just
resetting counters", so I think this is fine. Maybe double-check with
Steve?

>  	__set_task_comm(me, kbasename(bprm->filename), true);
>  
> -	/* Set the new mm task size. We have to do that late because it may
> -	 * depend on TIF_32BIT which is only updated in flush_thread() on
> -	 * some architectures like powerpc
> -	 */
> -	me->mm->task_size = TASK_SIZE;
> -
>  	/* An exec changes our domain. We are no longer part of the thread
>  	   group */
>  	WRITE_ONCE(me->self_exec_id, me->self_exec_id + 1);
> @@ -1467,6 +1426,50 @@ void setup_new_exec(struct linux_binprm * bprm)
>  	 * credentials; any time after this it may be unlocked.
>  	 */
>  	security_bprm_committed_creds(bprm);

Similarly for the LSM hook: is it expecting a post-arch-setup view? I
don't see anything looking at task_size, TIF flags, or anything else;
they seem to be just cleaning up from the old process being replaced, so
against, I think this is okay.

Not visible in this patch, the following things how happen earlier,
which I feel should maybe get called out in the changelog, with,
perhaps, better justification than what I've got here:

bprm->secureexec set/check (looks safe, since it depends on
prepare_binprm()'s security_bprm_set_creds().

rlim_stack.rlim_cur setting (safe, just needs to happen before
arch_pick_mmap_layout())

dumpable() check (looks safe, BINPRM_FLAGS_ENFORCE_NONDUMP depends on
much earlier would_dump(), and uid/gid depend on earlier calls to
prepare_binprm()'s bprm_fill_uid())

__set_task_comm (looks safe, just dealing with the task name...)

self_exec_id bump (looks safe, but I think -- it's still after uid
setting)

flush_signal_handlers() (looks safe -- nothing appears to depend on mm
nor personality)

> +	return 0;
> +
> +out_unlock:
> +	mutex_unlock(&me->signal->exec_update_mutex);
> +out:
> +	return retval;
> +}
> +EXPORT_SYMBOL(flush_old_exec);
> +
> +void would_dump(struct linux_binprm *bprm, struct file *file)
> +{
> +	struct inode *inode = file_inode(file);
> +	if (inode_permission(inode, MAY_READ) < 0) {
> +		struct user_namespace *old, *user_ns;
> +		bprm->interp_flags |= BINPRM_FLAGS_ENFORCE_NONDUMP;
> +
> +		/* Ensure mm->user_ns contains the executable */
> +		user_ns = old = bprm->mm->user_ns;
> +		while ((user_ns != &init_user_ns) &&
> +		       !privileged_wrt_inode_uidgid(user_ns, inode))
> +			user_ns = user_ns->parent;
> +
> +		if (old != user_ns) {
> +			bprm->mm->user_ns = get_user_ns(user_ns);
> +			put_user_ns(old);
> +		}
> +	}
> +}
> +EXPORT_SYMBOL(would_dump);

The diff helpfully decided this moved would_dump(). ;) Is it worth
maybe just moviing it explicitly above flush_old_exec() to avoid this
churn? I dunno.

> +
> +void setup_new_exec(struct linux_binprm * bprm)
> +{
> +	/* Setup things that can depend upon the personality */

Should this comment be above the function instead?

> +	struct task_struct *me = current;
> +
> +	arch_pick_mmap_layout(me->mm, &bprm->rlim_stack);
> +
> +	arch_setup_new_exec();
> +
> +	/* Set the new mm task size. We have to do that late because it may
> +	 * depend on TIF_32BIT which is only updated in flush_thread() on
> +	 * some architectures like powerpc
> +	 */
> +	me->mm->task_size = TASK_SIZE;
>  	mutex_unlock(&me->signal->exec_update_mutex);
>  	mutex_unlock(&me->signal->cred_guard_mutex);
>  }
> -- 
> 2.20.1
> 

So, as I say, I *think* this is okay, but I always get suspicious about
reordering things in execve(). ;)

So, with a bit larger changelog discussing what's moving "earlier",
I think this looks good:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

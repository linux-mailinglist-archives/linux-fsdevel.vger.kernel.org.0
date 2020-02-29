Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26791174497
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Feb 2020 03:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgB2C7y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 21:59:54 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:43794 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgB2C7y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 21:59:54 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j7sM1-0000Wh-Pt; Sat, 29 Feb 2020 02:59:49 +0000
Date:   Sat, 29 Feb 2020 03:59:48 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: Re: [PATCH 4/3] pid: Improve the comment about waiting in
 zap_pid_ns_processes
Message-ID: <20200229025948.mfla2guxzvo7mdwg@wittgenstein>
References: <20200212203833.GQ23230@ZenIV.linux.org.uk>
 <20200212204124.GR23230@ZenIV.linux.org.uk>
 <CAHk-=wi5FOGV_3tALK3n6E2fK3Oa_yCYkYQtCSaXLSEm2DUCKg@mail.gmail.com>
 <87lfp7h422.fsf@x220.int.ebiederm.org>
 <CAHk-=wgmn9Qds0VznyphouSZW6e42GWDT5H1dpZg8pyGDGN+=w@mail.gmail.com>
 <87pnejf6fz.fsf@x220.int.ebiederm.org>
 <871rqpaswu.fsf_-_@x220.int.ebiederm.org>
 <871rqk2brn.fsf_-_@x220.int.ebiederm.org>
 <878skmsbyy.fsf_-_@x220.int.ebiederm.org>
 <878skmpcib.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878skmpcib.fsf_-_@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 28, 2020 at 04:34:20PM -0600, Eric W. Biederman wrote:
> 
> Oleg wrote a very informative comment, but with the removal of
> proc_cleanup_work it is no longer accurate.
> 
> Rewrite the comment so that it only talks about the details
> that are still relevant, and hopefully is a little clearer.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  kernel/pid_namespace.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> index 318fcc6ba301..01f8ba32cc0c 100644
> --- a/kernel/pid_namespace.c
> +++ b/kernel/pid_namespace.c
> @@ -224,20 +224,27 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
>  	} while (rc != -ECHILD);
>  
>  	/*
> -	 * kernel_wait4() above can't reap the EXIT_DEAD children but we do not
> -	 * really care, we could reparent them to the global init. We could
> -	 * exit and reap ->child_reaper even if it is not the last thread in
> -	 * this pid_ns, free_pid(pid_allocated == 0) calls proc_cleanup_work(),
> -	 * pid_ns can not go away until proc_kill_sb() drops the reference.
> +	 * kernel_wait4() misses EXIT_DEAD children, and EXIT_ZOMBIE
> +	 * process whose parents processes are outside of the pid
> +	 * namespace.  Such processes are created with setns()+fork().
>  	 *
> -	 * But this ns can also have other tasks injected by setns()+fork().
> -	 * Again, ignoring the user visible semantics we do not really need
> -	 * to wait until they are all reaped, but they can be reparented to
> -	 * us and thus we need to ensure that pid->child_reaper stays valid
> -	 * until they all go away. See free_pid()->wake_up_process().
> +	 * If those EXIT_ZOMBIE processes are not reaped by their
> +	 * parents before their parents exit, they will be reparented
> +	 * to pid_ns->child_reaper.  Thus pidns->child_reaper needs to
> +	 * stay valid until they all go away.
>  	 *
> -	 * We rely on ignored SIGCHLD, an injected zombie must be autoreaped
> -	 * if reparented.
> +	 * The code relies on the the pid_ns->child_reaper ignoring

s/the the/the/

Hm, can we maybe reformulate this to:

"The code relies on having made pid_ns->child_reaper ignore SIGCHLD above
causing EXIT_ZOMBIE processes to be autoreaped if reparented."

Which imho makes it clearer that it was us ensuring that SIGCHLD is
ignored. Someone not too familiar with the exit codepaths might be
looking at zap_pid_ns_processes() not knowing that it is only called
when namespace init is exiting.

Otherwise

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

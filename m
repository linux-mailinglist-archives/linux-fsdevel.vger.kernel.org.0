Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A06B2210BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 17:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgGOPUg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 11:20:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50941 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgGOPUg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:20:36 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jvjCe-0006C6-KN; Wed, 15 Jul 2020 15:20:12 +0000
Date:   Wed, 15 Jul 2020 17:20:11 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Dirk Petersen <dipeit@gmail.com>,
        Christine Flood <chf@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 5/6] prctl: Allow checkpoint/restore capable processes
 to change exe link
Message-ID: <20200715152011.whdeysy3ztqrnocn@wittgenstein>
References: <20200715144954.1387760-1-areber@redhat.com>
 <20200715144954.1387760-6-areber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200715144954.1387760-6-areber@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 15, 2020 at 04:49:53PM +0200, Adrian Reber wrote:
> From: Nicolas Viennot <Nicolas.Viennot@twosigma.com>
> 
> Allow CAP_CHECKPOINT_RESTORE capable users to change /proc/self/exe.
> 
> This commit also changes the permission error code from -EINVAL to
> -EPERM for consistency with the rest of the prctl() syscall when
> checking capabilities.

I agree that EINVAL seems weird here but this is a potentially user
visible change. Might be nice to have the EINVAL->EPERM change be an
additional patch on top after this one so we can revert it in case it
breaks someone (unlikely though). I can split this out myself though so
no need to resend for that alone.

What I would also prefer is to have some history in the commit message
tbh. The reason is that when we started discussing that specific change
I had to hunt down the history of changing /proc/self/exe and had to
dig up and read through ancient threads on lore to come up with the
explanation why this is placed under a capability. The commit message
should then also mention that there are other ways to change the
/proc/self/exe link that don't require capabilities and that
/proc/self/exe itself is not something userspace should rely on for
security. Mainly so that in a few months/years we can read through that
commit message and go "Weird, but ok.". :)

But maybe I can just rewrite this myself so you don't have to go through
the trouble. This is really not pedantry it's just that it's a lot of
work digging up the reasons for a piece of code existing when it's
really not obvious. :)

Christian

> 
> Signed-off-by: Nicolas Viennot <Nicolas.Viennot@twosigma.com>
> Signed-off-by: Adrian Reber <areber@redhat.com>
> ---
>  kernel/sys.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 00a96746e28a..dd59b9142b1d 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2007,12 +2007,14 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
>  
>  	if (prctl_map.exe_fd != (u32)-1) {
>  		/*
> -		 * Make sure the caller has the rights to
> -		 * change /proc/pid/exe link: only local sys admin should
> -		 * be allowed to.
> +		 * Check if the current user is checkpoint/restore capable.
> +		 * At the time of this writing, it checks for CAP_SYS_ADMIN
> +		 * or CAP_CHECKPOINT_RESTORE.
> +		 * Note that a user with access to ptrace can masquerade an
> +		 * arbitrary program as any executable, even setuid ones.
>  		 */
> -		if (!ns_capable(current_user_ns(), CAP_SYS_ADMIN))
> -			return -EINVAL;
> +		if (!checkpoint_restore_ns_capable(current_user_ns()))
> +			return -EPERM;
>  
>  		error = prctl_set_mm_exe_file(mm, prctl_map.exe_fd);
>  		if (error)
> -- 
> 2.26.2
> 

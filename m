Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56D4260ACB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 08:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgIHGUI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 02:20:08 -0400
Received: from verein.lst.de ([213.95.11.211]:51486 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726787AbgIHGUH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 02:20:07 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 15E9468AFE; Tue,  8 Sep 2020 08:20:03 +0200 (CEST)
Date:   Tue, 8 Sep 2020 08:20:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Russell King <rmk@arm.linux.org.uk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org,
        Russell King <linux@armlinux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/9] ARM: oabi-compat: rework epoll_wait/epoll_pwait
 emulation
Message-ID: <20200908062002.GD13930@lst.de>
References: <20200907153701.2981205-1-arnd@arndb.de> <20200907153701.2981205-6-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907153701.2981205-6-arnd@arndb.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 07, 2020 at 05:36:46PM +0200, Arnd Bergmann wrote:
> The epoll_wait() system call wrapper is one of the remaining users of
> the set_fs() infrasturcture for Arm. Changing it to not require set_fs()
> is rather complex unfortunately.
> 
> The approach I'm taking here is to allow architectures to override
> the code that copies the output to user space, and let the oabi-compat
> implementation check whether it is getting called from an EABI or OABI
> system call based on the thread_info->syscall value.
> 
> The in_oabi_syscall() check here mirrors the in_compat_syscall() and
> in_x32_syscall() helpers for 32-bit compat implementations on other
> architectures.
> 
> Overall, the amount of code goes down, at least with the newly added
> sys_oabi_epoll_pwait() helper getting removed again. The downside
> is added complexity in the source code for the native implementation.
> There should be no difference in runtime performance except for Arm
> kernels with CONFIG_OABI_COMPAT enabled that now have to go through
> an external function call to check which of the two variants to use.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/include/asm/syscall.h    | 11 +++++
>  arch/arm/kernel/sys_oabi-compat.c | 72 +++++++------------------------
>  arch/arm/tools/syscall.tbl        |  4 +-
>  fs/eventpoll.c                    |  5 +--
>  include/linux/eventpoll.h         | 16 +++++++
>  5 files changed, 46 insertions(+), 62 deletions(-)
> 
> diff --git a/arch/arm/include/asm/syscall.h b/arch/arm/include/asm/syscall.h
> index ff6cc365eaf7..0d8afceeefd9 100644
> --- a/arch/arm/include/asm/syscall.h
> +++ b/arch/arm/include/asm/syscall.h
> @@ -28,6 +28,17 @@ static inline int syscall_get_nr(struct task_struct *task,
>  	return task_thread_info(task)->syscall;
>  }
>  
> +static inline bool __in_oabi_syscall(struct task_struct *task)
> +{
> +	return IS_ENABLED(CONFIG_OABI_COMPAT) &&
> +		(task_thread_info(task)->syscall & __NR_OABI_SYSCALL_BASE);
> +}
> +
> +static inline bool in_oabi_syscall(void)
> +{
> +	return __in_oabi_syscall(current);
> +}
> +
>  static inline void syscall_rollback(struct task_struct *task,
>  				    struct pt_regs *regs)
>  {
> diff --git a/arch/arm/kernel/sys_oabi-compat.c b/arch/arm/kernel/sys_oabi-compat.c
> index 2ce3e8c6ca91..abf1153c5315 100644
> --- a/arch/arm/kernel/sys_oabi-compat.c
> +++ b/arch/arm/kernel/sys_oabi-compat.c
> @@ -83,6 +83,8 @@
>  #include <linux/uaccess.h>
>  #include <linux/slab.h>
>  
> +#include <asm/syscall.h>
> +
>  struct oldabi_stat64 {
>  	unsigned long long st_dev;
>  	unsigned int	__pad1;
> @@ -264,68 +266,24 @@ asmlinkage long sys_oabi_epoll_ctl(int epfd, int op, int fd,
>  	return do_epoll_ctl(epfd, op, fd, &kernel, false);
>  }
>  
> -static long do_oabi_epoll_wait(int epfd, struct oabi_epoll_event __user *events,
> -			       int maxevents, int timeout)
> +struct epoll_event __user *
> +epoll_put_uevent(__poll_t revents, __u64 data, struct epoll_event __user *uevent)
>  {
> +	if (in_oabi_syscall()) {
> +		struct oabi_epoll_event *oevent = (void __user *)uevent;
>  
> +		if (__put_user(revents, &oevent->events) ||
> +		    __put_user(data, &oevent->data))
> +			return NULL;
>  
> +		return (void __user *)uevent+1;
> +	}

I wonder if we'd be better off doing the in_oabi_syscall() branch in
the common code.  E.g. rename in_oabi_syscall to in_legacy_syscall and
stub it out for all other architectures.  Then just do

	if (in_oabi_syscall()
		legacy_syscall_foo_bit();
	else
		normal_syscall_foo_bit();

in common code, where so far only arm provides
legacy_syscall_foo_bit().

Tons of long lines again in this patch..

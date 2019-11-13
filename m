Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1272FBBBE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 23:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfKMWjH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 17:39:07 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:47564 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfKMWjG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 17:39:06 -0500
Received: from 79.184.253.153.ipv4.supernova.orange.pl (79.184.253.153) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 695e88c4f6f8395e; Wed, 13 Nov 2019 23:39:02 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038@lists.linaro.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 12/23] y2038: syscalls: change remaining timeval to __kernel_old_timeval
Date:   Wed, 13 Nov 2019 23:39:01 +0100
Message-ID: <43741269.9cZ5YESnMi@kreacher>
In-Reply-To: <20191108211323.1806194-3-arnd@arndb.de>
References: <20191108210236.1296047-1-arnd@arndb.de> <20191108211323.1806194-3-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Friday, November 8, 2019 10:12:11 PM CET Arnd Bergmann wrote:
> All of the remaining syscalls that pass a timeval (gettimeofday, utime,
> futimesat) can trivially be changed to pass a __kernel_old_timeval
> instead, which has a compatible layout, but avoids ambiguity with
> the timeval type in user space.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

For the change in power/power.h

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  arch/powerpc/include/asm/asm-prototypes.h |  3 ++-
>  arch/powerpc/kernel/syscalls.c            |  4 ++--
>  fs/select.c                               | 10 +++++-----
>  fs/utimes.c                               |  8 ++++----
>  include/linux/syscalls.h                  | 10 +++++-----
>  kernel/power/power.h                      |  2 +-
>  kernel/time/time.c                        |  2 +-
>  7 files changed, 20 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
> index 8561498e653c..2c25dc079cb9 100644
> --- a/arch/powerpc/include/asm/asm-prototypes.h
> +++ b/arch/powerpc/include/asm/asm-prototypes.h
> @@ -92,7 +92,8 @@ long sys_swapcontext(struct ucontext __user *old_ctx,
>  long sys_debug_setcontext(struct ucontext __user *ctx,
>  			  int ndbg, struct sig_dbg_op __user *dbg);
>  int
> -ppc_select(int n, fd_set __user *inp, fd_set __user *outp, fd_set __user *exp, struct timeval __user *tvp);
> +ppc_select(int n, fd_set __user *inp, fd_set __user *outp, fd_set __user *exp,
> +	   struct __kernel_old_timeval __user *tvp);
>  unsigned long __init early_init(unsigned long dt_ptr);
>  void __init machine_init(u64 dt_ptr);
>  #endif
> diff --git a/arch/powerpc/kernel/syscalls.c b/arch/powerpc/kernel/syscalls.c
> index 3bfb3888e897..078608ec2e92 100644
> --- a/arch/powerpc/kernel/syscalls.c
> +++ b/arch/powerpc/kernel/syscalls.c
> @@ -79,7 +79,7 @@ SYSCALL_DEFINE6(mmap, unsigned long, addr, size_t, len,
>   * sys_select() with the appropriate args. -- Cort
>   */
>  int
> -ppc_select(int n, fd_set __user *inp, fd_set __user *outp, fd_set __user *exp, struct timeval __user *tvp)
> +ppc_select(int n, fd_set __user *inp, fd_set __user *outp, fd_set __user *exp, struct __kernel_old_timeval __user *tvp)
>  {
>  	if ( (unsigned long)n >= 4096 )
>  	{
> @@ -89,7 +89,7 @@ ppc_select(int n, fd_set __user *inp, fd_set __user *outp, fd_set __user *exp, s
>  		    || __get_user(inp, ((fd_set __user * __user *)(buffer+1)))
>  		    || __get_user(outp, ((fd_set  __user * __user *)(buffer+2)))
>  		    || __get_user(exp, ((fd_set  __user * __user *)(buffer+3)))
> -		    || __get_user(tvp, ((struct timeval  __user * __user *)(buffer+4))))
> +		    || __get_user(tvp, ((struct __kernel_old_timeval  __user * __user *)(buffer+4))))
>  			return -EFAULT;
>  	}
>  	return sys_select(n, inp, outp, exp, tvp);
> diff --git a/fs/select.c b/fs/select.c
> index 53a0c149f528..11d0285d46b7 100644
> --- a/fs/select.c
> +++ b/fs/select.c
> @@ -321,7 +321,7 @@ static int poll_select_finish(struct timespec64 *end_time,
>  	switch (pt_type) {
>  	case PT_TIMEVAL:
>  		{
> -			struct timeval rtv;
> +			struct __kernel_old_timeval rtv;
>  
>  			if (sizeof(rtv) > sizeof(rtv.tv_sec) + sizeof(rtv.tv_usec))
>  				memset(&rtv, 0, sizeof(rtv));
> @@ -698,10 +698,10 @@ int core_sys_select(int n, fd_set __user *inp, fd_set __user *outp,
>  }
>  
>  static int kern_select(int n, fd_set __user *inp, fd_set __user *outp,
> -		       fd_set __user *exp, struct timeval __user *tvp)
> +		       fd_set __user *exp, struct __kernel_old_timeval __user *tvp)
>  {
>  	struct timespec64 end_time, *to = NULL;
> -	struct timeval tv;
> +	struct __kernel_old_timeval tv;
>  	int ret;
>  
>  	if (tvp) {
> @@ -720,7 +720,7 @@ static int kern_select(int n, fd_set __user *inp, fd_set __user *outp,
>  }
>  
>  SYSCALL_DEFINE5(select, int, n, fd_set __user *, inp, fd_set __user *, outp,
> -		fd_set __user *, exp, struct timeval __user *, tvp)
> +		fd_set __user *, exp, struct __kernel_old_timeval __user *, tvp)
>  {
>  	return kern_select(n, inp, outp, exp, tvp);
>  }
> @@ -810,7 +810,7 @@ SYSCALL_DEFINE6(pselect6_time32, int, n, fd_set __user *, inp, fd_set __user *,
>  struct sel_arg_struct {
>  	unsigned long n;
>  	fd_set __user *inp, *outp, *exp;
> -	struct timeval __user *tvp;
> +	struct __kernel_old_timeval __user *tvp;
>  };
>  
>  SYSCALL_DEFINE1(old_select, struct sel_arg_struct __user *, arg)
> diff --git a/fs/utimes.c b/fs/utimes.c
> index 1ba3f7883870..c952b6b3d8a0 100644
> --- a/fs/utimes.c
> +++ b/fs/utimes.c
> @@ -161,9 +161,9 @@ SYSCALL_DEFINE4(utimensat, int, dfd, const char __user *, filename,
>   * utimensat() instead.
>   */
>  static long do_futimesat(int dfd, const char __user *filename,
> -			 struct timeval __user *utimes)
> +			 struct __kernel_old_timeval __user *utimes)
>  {
> -	struct timeval times[2];
> +	struct __kernel_old_timeval times[2];
>  	struct timespec64 tstimes[2];
>  
>  	if (utimes) {
> @@ -190,13 +190,13 @@ static long do_futimesat(int dfd, const char __user *filename,
>  
>  
>  SYSCALL_DEFINE3(futimesat, int, dfd, const char __user *, filename,
> -		struct timeval __user *, utimes)
> +		struct __kernel_old_timeval __user *, utimes)
>  {
>  	return do_futimesat(dfd, filename, utimes);
>  }
>  
>  SYSCALL_DEFINE2(utimes, char __user *, filename,
> -		struct timeval __user *, utimes)
> +		struct __kernel_old_timeval __user *, utimes)
>  {
>  	return do_futimesat(AT_FDCWD, filename, utimes);
>  }
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 2f27bc9d5ef0..e665920fa359 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -51,7 +51,7 @@ struct statx;
>  struct __sysctl_args;
>  struct sysinfo;
>  struct timespec;
> -struct timeval;
> +struct __kernel_old_timeval;
>  struct __kernel_timex;
>  struct timezone;
>  struct tms;
> @@ -732,7 +732,7 @@ asmlinkage long sys_prctl(int option, unsigned long arg2, unsigned long arg3,
>  asmlinkage long sys_getcpu(unsigned __user *cpu, unsigned __user *node, struct getcpu_cache __user *cache);
>  
>  /* kernel/time.c */
> -asmlinkage long sys_gettimeofday(struct timeval __user *tv,
> +asmlinkage long sys_gettimeofday(struct __kernel_old_timeval __user *tv,
>  				struct timezone __user *tz);
>  asmlinkage long sys_settimeofday(struct timeval __user *tv,
>  				struct timezone __user *tz);
> @@ -1082,9 +1082,9 @@ asmlinkage long sys_time32(old_time32_t __user *tloc);
>  asmlinkage long sys_utime(char __user *filename,
>  				struct utimbuf __user *times);
>  asmlinkage long sys_utimes(char __user *filename,
> -				struct timeval __user *utimes);
> +				struct __kernel_old_timeval __user *utimes);
>  asmlinkage long sys_futimesat(int dfd, const char __user *filename,
> -			      struct timeval __user *utimes);
> +			      struct __kernel_old_timeval __user *utimes);
>  #endif
>  asmlinkage long sys_futimesat_time32(unsigned int dfd,
>  				     const char __user *filename,
> @@ -1098,7 +1098,7 @@ asmlinkage long sys_getdents(unsigned int fd,
>  				struct linux_dirent __user *dirent,
>  				unsigned int count);
>  asmlinkage long sys_select(int n, fd_set __user *inp, fd_set __user *outp,
> -			fd_set __user *exp, struct timeval __user *tvp);
> +			fd_set __user *exp, struct __kernel_old_timeval __user *tvp);
>  asmlinkage long sys_poll(struct pollfd __user *ufds, unsigned int nfds,
>  				int timeout);
>  asmlinkage long sys_epoll_wait(int epfd, struct epoll_event __user *events,
> diff --git a/kernel/power/power.h b/kernel/power/power.h
> index 44bee462ff57..7cdc64dc2373 100644
> --- a/kernel/power/power.h
> +++ b/kernel/power/power.h
> @@ -179,7 +179,7 @@ extern void swsusp_close(fmode_t);
>  extern int swsusp_unmark(void);
>  #endif
>  
> -struct timeval;
> +struct __kernel_old_timeval;
>  /* kernel/power/swsusp.c */
>  extern void swsusp_show_speed(ktime_t, ktime_t, unsigned int, char *);
>  
> diff --git a/kernel/time/time.c b/kernel/time/time.c
> index 7eba7c9a7e3e..bc114f0be8f1 100644
> --- a/kernel/time/time.c
> +++ b/kernel/time/time.c
> @@ -137,7 +137,7 @@ SYSCALL_DEFINE1(stime32, old_time32_t __user *, tptr)
>  #endif /* __ARCH_WANT_SYS_TIME32 */
>  #endif
>  
> -SYSCALL_DEFINE2(gettimeofday, struct timeval __user *, tv,
> +SYSCALL_DEFINE2(gettimeofday, struct __kernel_old_timeval __user *, tv,
>  		struct timezone __user *, tz)
>  {
>  	if (likely(tv != NULL)) {
> 





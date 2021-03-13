Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABD0B339F52
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Mar 2021 18:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbhCMRC4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Mar 2021 12:02:56 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:49918 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbhCMRCw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Mar 2021 12:02:52 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 82DB872C8B9;
        Sat, 13 Mar 2021 20:02:50 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 72C7B7CC89C; Sat, 13 Mar 2021 20:02:50 +0300 (MSK)
Date:   Sat, 13 Mar 2021 20:02:50 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     Willem de Bruijn <willemb@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-api@vger.kernel.org
Subject: Re: epoll_wait.2: epoll_pwait2(2) prototype
Message-ID: <20210313170250.GA15968@altlinux.org>
References: <eb42faba-2235-4536-df49-795ef2719552@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb42faba-2235-4536-df49-795ef2719552@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Alex,

On Sat, Mar 13, 2021 at 05:48:08PM +0100, Alejandro Colomar (man-pages) wrote:
> Hi Willem,
> 
> I checked that the prototype of the kernel epoll_pwait2() syscall is 
> different from the one we recently merged; it has one more parameter 
> 'size_t sigsetsize':
> 
> $ grep_syscall epoll_pwait2
> fs/eventpoll.c:2272:
> SYSCALL_DEFINE6(epoll_pwait2, int, epfd, struct epoll_event __user *, 
> events,
> 		int, maxevents, const struct __kernel_timespec __user *, timeout,
> 		const sigset_t __user *, sigmask, size_t, sigsetsize)
> fs/eventpoll.c:2326:
> COMPAT_SYSCALL_DEFINE6(epoll_pwait2, int, epfd,
> 		       struct epoll_event __user *, events,
> 		       int, maxevents,
> 		       const struct __kernel_timespec __user *, timeout,
> 		       const compat_sigset_t __user *, sigmask,
> 		       compat_size_t, sigsetsize)
> include/linux/compat.h:540:
> asmlinkage long compat_sys_epoll_pwait2(int epfd,
> 			struct epoll_event __user *events,
> 			int maxevents,
> 			const struct __kernel_timespec __user *timeout,
> 			const compat_sigset_t __user *sigmask,
> 			compat_size_t sigsetsize);
> include/linux/syscalls.h:389:
> asmlinkage long sys_epoll_pwait2(int epfd, struct epoll_event __user 
> *events,
> 				 int maxevents,
> 				 const struct __kernel_timespec __user *timeout,
> 				 const sigset_t __user *sigmask,
> 				 size_t sigsetsize);
> 
> I'm could fix the prototype, but maybe there are more changes needed for 
> the manual page.
> 
> Would you mind fixing it?

Looks like the 6th argument of epoll_pwait and epoll_pwait2 syscalls
is already described in "C library/kernel differences" subsection of
epoll_pwait2(2).


-- 
ldv

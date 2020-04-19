Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854251AFB4E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 16:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgDSORg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 10:17:36 -0400
Received: from raptor.unsafe.ru ([5.9.43.93]:55922 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbgDSORg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 10:17:36 -0400
Received: from comp-core-i7-2640m-0182e6 (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by raptor.unsafe.ru (Postfix) with ESMTPSA id 2AD14209FA;
        Sun, 19 Apr 2020 14:17:32 +0000 (UTC)
Date:   Sun, 19 Apr 2020 16:17:27 +0200
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH RESEND v11 2/8] proc: allow to mount many instances of
 proc in one pid namespace
Message-ID: <20200419141727.zjstym5kbp5efoz6@comp-core-i7-2640m-0182e6>
References: <20200409123752.1070597-1-gladkov.alexey@gmail.com>
 <20200409123752.1070597-3-gladkov.alexey@gmail.com>
 <87tv1iaqnq.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tv1iaqnq.fsf@x220.int.ebiederm.org>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.1 (raptor.unsafe.ru [5.9.43.93]); Sun, 19 Apr 2020 14:17:32 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 17, 2020 at 01:55:05PM -0500, Eric W. Biederman wrote:
> Alexey Gladkov <gladkov.alexey@gmail.com> writes:
> 
> > This patch allows to have multiple procfs instances inside the
> > same pid namespace. The aim here is lightweight sandboxes, and to allow
> > that we have to modernize procfs internals.
> >
> > 1) The main aim of this work is to have on embedded systems one
> > supervisor for apps. Right now we have some lightweight sandbox support,
> > however if we create pid namespacess we have to manages all the
> > processes inside too, where our goal is to be able to run a bunch of
> > apps each one inside its own mount namespace without being able to
> > notice each other. We only want to use mount namespaces, and we want
> > procfs to behave more like a real mount point.
> >
> > 2) Linux Security Modules have multiple ptrace paths inside some
> > subsystems, however inside procfs, the implementation does not guarantee
> > that the ptrace() check which triggers the security_ptrace_check() hook
> > will always run. We have the 'hidepid' mount option that can be used to
> > force the ptrace_may_access() check inside has_pid_permissions() to run.
> > The problem is that 'hidepid' is per pid namespace and not attached to
> > the mount point, any remount or modification of 'hidepid' will propagate
> > to all other procfs mounts.
> >
> > This also does not allow to support Yama LSM easily in desktop and user
> > sessions. Yama ptrace scope which restricts ptrace and some other
> > syscalls to be allowed only on inferiors, can be updated to have a
> > per-task context, where the context will be inherited during fork(),
> > clone() and preserved across execve(). If we support multiple private
> > procfs instances, then we may force the ptrace_may_access() on
> > /proc/<pids>/ to always run inside that new procfs instances. This will
> > allow to specifiy on user sessions if we should populate procfs with
> > pids that the user can ptrace or not.
> >
> > By using Yama ptrace scope, some restricted users will only be able to see
> > inferiors inside /proc, they won't even be able to see their other
> > processes. Some software like Chromium, Firefox's crash handler, Wine
> > and others are already using Yama to restrict which processes can be
> > ptracable. With this change this will give the possibility to restrict
> > /proc/<pids>/ but more importantly this will give desktop users a
> > generic and usuable way to specifiy which users should see all processes
> > and which users can not.
> >
> > Side notes:
> > * This covers the lack of seccomp where it is not able to parse
> > arguments, it is easy to install a seccomp filter on direct syscalls
> > that operate on pids, however /proc/<pid>/ is a Linux ABI using
> > filesystem syscalls. With this change LSMs should be able to analyze
> > open/read/write/close...
> >
> > In the new patchset version I removed the 'newinstance' option
> > as suggested by Eric W. Biederman.
> 
> Some very small requests.
> 
> 1) Can you please not place fs_info in fs_context, and instead allocate
>    fs_info in fill_super?  Unless I have misread introduced a resource
>    leak if proc is not mounted or if proc is simply reconfigured.

Hm ... it seems you're right.

> 2) Can you please move hide_pid and pid_gid into fs_info in this patch?
>    As was shown by my recent bug fix 

OK. I’ll do it in the next version.

> 3) Can you please rebase on on v5.7-rc1 or v5.7-rc2 and repost these
>    patches please?  I thought I could do it safely but between my bug
>    fixes, and Alexey Dobriyan's parallel changes to proc these patches
>    do not apply cleanly.
> 
>    Plus there is a resource leak in this patch.

On my way.

> >  struct proc_fs_context {
> > -	struct pid_namespace	*pid_ns;
> > +	struct proc_fs_info	*fs_info;
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Please don't do this. As best as I can tell that introduces a memory
> leak of proc is not mounted.  Please allocate fs_info in 

OK.

-- 
Rgrds, legion


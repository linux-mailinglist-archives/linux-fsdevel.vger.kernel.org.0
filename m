Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F30421B49C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jul 2020 14:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgGJMBy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jul 2020 08:01:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45479 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbgGJMBy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jul 2020 08:01:54 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jtriy-0000Fg-3q; Fri, 10 Jul 2020 12:01:52 +0000
Date:   Fri, 10 Jul 2020 14:01:51 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Qian Cai <cai@lca.pw>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfgang Bumiller <w.bumiller@proxmox.com>,
        Serge Hallyn <serge@hallyn.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] nsfs: add NS_GET_INIT_PID ioctl
Message-ID: <20200710120151.yeoonuttjc4wivaf@wittgenstein>
References: <20200618084543.326605-1-christian.brauner@ubuntu.com>
 <20200710115836.GA1027@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200710115836.GA1027@lca.pw>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 10, 2020 at 07:58:36AM -0400, Qian Cai wrote:
> On Thu, Jun 18, 2020 at 10:45:43AM +0200, Christian Brauner wrote:
> > Add an ioctl() to return the PID of the init process/child reaper of a pid
> > namespace as seen in the caller's pid namespace.
> > 
> > LXCFS is a tiny fuse filesystem used to virtualize various aspects of
> > procfs. It is used actively by a large number of users including ChromeOS
> > and cloud providers. LXCFS is run on the host. The files and directories it
> > creates can be bind-mounted by e.g. a container at startup and mounted over
> > the various procfs files the container wishes to have virtualized. When
> > e.g. a read request for uptime is received, LXCFS will receive the pid of
> > the reader. In order to virtualize the corresponding read, LXCFS needs to
> > know the pid of the init process of the reader's pid namespace. In order to
> > do this, LXCFS first needs to fork() two helper processes. The first helper
> > process setns() to the readers pid namespace. The second helper process is
> > needed to create a process that is a proper member of the pid namespace.
> > The second helper process then creates a ucred message with ucred.pid set
> > to 1 and sends it back to LXCFS. The kernel will translate the ucred.pid
> > field to the corresponding pid number in LXCFS's pid namespace. This way
> > LXCFS can learn the init pid number of the reader's pid namespace and can
> > go on to virtualize. Since these two forks() are costly LXCFS maintains an
> > init pid cache that caches a given pid for a fixed amount of time. The
> > cache is pruned during new read requests. However, even with the cache the
> > hit of the two forks() is singificant when a very large number of
> > containers are running. With this simple patch we add an ns ioctl that
> > let's a caller retrieve the init pid nr of a pid namespace through its
> > pid namespace fd. This _significantly_ improves our performance with a very
> > simple change. A caller should do something like:
> > - pid_t init_pid = ioctl(pid_ns_fd, NS_GET_INIT_PID);
> > - verify init_pid is still valid (not necessarily both but recommended):
> >   - opening a pidfd to get a stable reference
> >   - opening /proc/<init_pid>/ns/pid and verifying that <pid_ns_fd>
> >     and the pid namespace fd of <init_pid> refer to the same pid namespace
> > 
> > Note, it is possible for the init process of the pid namespace (identified
> > via the child_reaper member in the relevant pid namespace) to die and get
> > reaped right after the ioctl returned. If that happens there are two cases
> > to consider:
> > - if the init process was single threaded, all other processes in the pid
> >   namespace will be zapped and any new process creation in there will fail;
> >   A caller can detect this case since either the init pid is still around
> >   but it is a zombie, or it already has exited and not been recycled, or it
> >   has exited, been reaped, and also been recycled. The last case is the
> >   most interesting one but a caller would then be able to detect that the
> >   recycled process lives in a different pid namespace.
> > - if the init process was multi-threaded, then the kernel will try to make
> >   one of the threads in the same thread-group - if any are still alive -
> >   the new child_reaper. In this case the caller can detect that the thread
> >   which exited and used to be the child_reaper is no longer alive. If it's
> >   tid has been recycled in the same pid namespace a caller can detect this
> >   by parsing through /proc/<tid>/stat, looking at the Nspid: field and if
> >   there's a entry with pid nr 1 in the respective pid namespace it can be
> >   sure that it hasn't been recycled.
> > Both options can be combined with pidfd_open() to make sure that a stable
> > reference is maintained.
> > 
> > Cc: Wolfgang Bumiller <w.bumiller@proxmox.com>
> > Cc: Serge Hallyn <serge@hallyn.com>
> > Cc: Michael Kerrisk <mtk.manpages@gmail.com>
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: linux-fsdevel@vger.kernel.org
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> 
> fs/nsfs.c: In function ‘ns_ioctl’:
> fs/nsfs.c:195:14: warning: unused variable ‘pid_struct’ [-Wunused-variable]
>   struct pid *pid_struct;
>               ^~~~~~~~~~
> fs/nsfs.c:194:22: warning: unused variable ‘child_reaper’ [-Wunused-variable]
>   struct task_struct *child_reaper;
>                       ^~~~~~~~~~~~

Thanks. Fyi, this has been reported by Stephen already.
Christian

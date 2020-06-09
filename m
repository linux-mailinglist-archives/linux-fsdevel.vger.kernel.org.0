Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60A41F354B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 09:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgFIHoy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 03:44:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60738 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbgFIHox (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 03:44:53 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jiYvo-0005vo-1f; Tue, 09 Jun 2020 07:44:24 +0000
Date:   Tue, 9 Jun 2020 09:44:22 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Adrian Reber <areber@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
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
Subject: Re: [PATCH v2 1/3] capabilities: Introduce CAP_CHECKPOINT_RESTORE
Message-ID: <20200609074422.burwzfgwgqqysrzh@wittgenstein>
References: <20200603162328.854164-1-areber@redhat.com>
 <20200603162328.854164-2-areber@redhat.com>
 <20200609034221.GA150921@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200609034221.GA150921@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 08, 2020 at 08:42:21PM -0700, Andrei Vagin wrote:
> On Wed, Jun 03, 2020 at 06:23:26PM +0200, Adrian Reber wrote:
> > This patch introduces CAP_CHECKPOINT_RESTORE, a new capability facilitating
> > checkpoint/restore for non-root users.
> > 
> > Over the last years, The CRIU (Checkpoint/Restore In Userspace) team has been
> > asked numerous times if it is possible to checkpoint/restore a process as
> > non-root. The answer usually was: 'almost'.
> > 
> > The main blocker to restore a process as non-root was to control the PID of the
> > restored process. This feature available via the clone3 system call, or via
> > /proc/sys/kernel/ns_last_pid is unfortunately guarded by CAP_SYS_ADMIN.
> > 
> > In the past two years, requests for non-root checkpoint/restore have increased
> > due to the following use cases:
> > * Checkpoint/Restore in an HPC environment in combination with a resource
> >   manager distributing jobs where users are always running as non-root.
> >   There is a desire to provide a way to checkpoint and restore long running
> >   jobs.
> > * Container migration as non-root
> > * We have been in contact with JVM developers who are integrating
> >   CRIU into a Java VM to decrease the startup time. These checkpoint/restore
> >   applications are not meant to be running with CAP_SYS_ADMIN.
> > 
> ...
> > 
> > The introduced capability allows to:
> > * Control PIDs when the current user is CAP_CHECKPOINT_RESTORE capable
> >   for the corresponding PID namespace via ns_last_pid/clone3.
> > * Open files in /proc/pid/map_files when the current user is
> >   CAP_CHECKPOINT_RESTORE capable in the root namespace, useful for recovering
> >   files that are unreachable via the file system such as deleted files, or memfd
> >   files.
> 
> PTRACE_O_SUSPEND_SECCOMP is needed for C/R and it is protected by
> CAP_SYS_ADMIN too.

This is currently capable(CAP_SYS_ADMIN) (init_ns capable) why is it
safe to allow unprivileged users to suspend security policies? That
sounds like a bad idea.

	if (unlikely(data & PTRACE_O_SUSPEND_SECCOMP)) {
		if (!IS_ENABLED(CONFIG_CHECKPOINT_RESTORE) ||
		    !IS_ENABLED(CONFIG_SECCOMP))
			return -EINVAL;

		if (!capable(CAP_SYS_ADMIN))
			return -EPERM;

		if (seccomp_mode(&current->seccomp) != SECCOMP_MODE_DISABLED ||
		    current->ptrace & PT_SUSPEND_SECCOMP)
			return -EPERM;
	}

Christian

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27661EEEA9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 02:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgFEAIr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jun 2020 20:08:47 -0400
Received: from raptor.unsafe.ru ([5.9.43.93]:59580 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725986AbgFEAIr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jun 2020 20:08:47 -0400
Received: from comp-core-i7-2640m-0182e6 (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by raptor.unsafe.ru (Postfix) with ESMTPSA id 55607209AF;
        Fri,  5 Jun 2020 00:08:42 +0000 (UTC)
Date:   Fri, 5 Jun 2020 02:08:38 +0200
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: Re: [PATCH 0/2] proc: use subset option to hide some top-level
 procfs entries
Message-ID: <20200605000838.huaeqvgpvqkyg3wh@comp-core-i7-2640m-0182e6>
References: <20200604200413.587896-1-gladkov.alexey@gmail.com>
 <87ftbah8q2.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftbah8q2.fsf@x220.int.ebiederm.org>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.1 (raptor.unsafe.ru [5.9.43.93]); Fri, 05 Jun 2020 00:08:43 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 04, 2020 at 03:33:25PM -0500, Eric W. Biederman wrote:
> Alexey Gladkov <gladkov.alexey@gmail.com> writes:
> 
> > Greetings!
> >
> > Preface
> > -------
> > This patch set can be applied over:
> >
> > git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git d35bec8a5788
> 
> I am not going to seriously look at this for merging until after the
> merge window closes. 

OK. I'll wait.

> Have you thought about the possibility of relaxing the permission checks
> to mount proc such that we don't need to verify there is an existing
> mount of proc?  With just the subset pids I think this is feasible.  It
> might not be worth it at this point, but it is definitely worth asking
> the question.  As one of the benefits early propopents of the idea of a
> subset of proc touted was that they would not be as restricted as they
> are with today's proc.

I'm not sure I follow.

What do you mean by the possibility of relaxing the permission checks to
mount proc?

Do you suggest to allow a user to mount procfs with hidepid=2,subset=pid
options? If so then this is an interesting idea.

> I ask because this has a bearing on the other options you are playing
> with.

I can not agree with this because I do not touch on other options.
The hidepid and subset=pid has no relation to the visibility of regular
files. On the other hand, in procfs there is absolutely no way to restrict
access other than selinux.

> Do we want to find a way to have the benefit of relaxed permission
> checks while still including a few more files.

In fact, I see no problem allowing the user to mount procfs with the
hidepid=2,subset=pid options.

We can make subset=self, which would allow not only pids subset but also
other symlinks that lead to self (/proc/net, /proc/mounts) and if we ever
add virtualization to meminfo, cpuinfo etc.

> > Overview
> > --------
> > Directories and files can be created and deleted by dynamically loaded modules.
> > Not all of these files are virtualized and safe inside the container.
> >
> > However, subset=pid is not enough because many containers wants to have
> > /proc/meminfo, /proc/cpuinfo, etc. We need a way to limit the visibility of
> > files per procfs mountpoint.
> 
> Is it desirable to have meminfo and cpuinfo as they are today or do
> people want them to reflect the ``container'' context.   So that
> applications like the JVM don't allocation too many cpus or don't try
> and consume too much memory, or run on nodes that cgroups current make
> unavailable.

Of course, it would be better if these files took into account the
limitations of cgroups or some kind of ``containerized'' context.

> Are there any users or planned users of this functionality yet?

I know that java uses meminfo for sure.

The purpose of this patch is to isolate the container from unwanted files
in procfs.

> I am concerned that you might be adding functionality that no one will
> ever use that will just add code to the kernel that no one cares about,
> that will then accumulate bugs.  Having had to work through a few of
> those cases to make each mount of proc have it's own super block I am
> not a great fan of adding another one.
>
> If the runc, lxc and other container runtime folks can productively use
> such and option to do useful things and they are sensible things to do I
> don't have any fundamental objection.  But I do want to be certain this
> is a feature that is going to be used.

Ok, just an example how docker or runc (actually almost all golang-based
container systems) is trying to block access to something in procfs:

$ docker run -it --rm busybox
# mount |grep /proc
proc on /proc type proc (rw,nosuid,nodev,noexec,relatime)
proc on /proc/bus type proc (ro,relatime)
proc on /proc/fs type proc (ro,relatime)
proc on /proc/irq type proc (ro,relatime)
proc on /proc/sys type proc (ro,relatime)
proc on /proc/sysrq-trigger type proc (ro,relatime)
tmpfs on /proc/asound type tmpfs (ro,seclabel,relatime)
tmpfs on /proc/acpi type tmpfs (ro,seclabel,relatime)
tmpfs on /proc/kcore type tmpfs (rw,seclabel,nosuid,size=65536k,mode=755)
tmpfs on /proc/keys type tmpfs (rw,seclabel,nosuid,size=65536k,mode=755)
tmpfs on /proc/latency_stats type tmpfs (rw,seclabel,nosuid,size=65536k,mode=755)
tmpfs on /proc/timer_list type tmpfs (rw,seclabel,nosuid,size=65536k,mode=755)
tmpfs on /proc/sched_debug type tmpfs (rw,seclabel,nosuid,size=65536k,mode=755)
tmpfs on /proc/scsi type tmpfs (ro,seclabel,relatime)

For now I'm just trying ti create a better way to restrict access in
the procfs than this since procfs is used in containers.

-- 
Rgrds, legion


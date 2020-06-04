Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E081EED54
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jun 2020 23:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgFDVcd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jun 2020 17:32:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52050 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgFDVcc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jun 2020 17:32:32 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jgxTJ-00081i-4f; Thu, 04 Jun 2020 21:32:21 +0000
Date:   Thu, 4 Jun 2020 23:32:20 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Alexey Gladkov <gladkov.alexey@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexey Gladkov <legion@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@ubuntu.com>
Subject: Re: [PATCH 0/2] proc: use subset option to hide some top-level
 procfs entries
Message-ID: <20200604213220.grcaldlxz54jyd3o@wittgenstein>
References: <20200604200413.587896-1-gladkov.alexey@gmail.com>
 <87ftbah8q2.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ftbah8q2.fsf@x220.int.ebiederm.org>
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
> 
> Have you thought about the possibility of relaxing the permission checks
> to mount proc such that we don't need to verify there is an existing
> mount of proc?  With just the subset pids I think this is feasible.  It
> might not be worth it at this point, but it is definitely worth asking
> the question.  As one of the benefits early propopents of the idea of a
> subset of proc touted was that they would not be as restricted as they
> are with today's proc.
> 
> I ask because this has a bearing on the other options you are playing
> with.
> 
> Do we want to find a way to have the benefit of relaxed permission
> checks while still including a few more files.
> 
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
> 
> Are there any users or planned users of this functionality yet?
> 
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

I'm not sure Alexey is introducing virtualized meminfo and cpuinfo (but
I haven't had time to look at this patchset).
In any case, we are currently virtualizing:
/proc/cpuinfo
/proc/diskstats
/proc/loadavg
/proc/meminfo
/proc/stat
/proc/swaps
/proc/uptime
for each container with a tiny in-userspace filesystem LXCFS
( https://github.com/lxc/lxcfs )
and have been doing that for years.
Having meminfo and cpuinfo virtualized in procfs was something we have
been wanting for a long time and there have been patches by other people
(from Siteground, I believe) to achieve this a few years back but were
disregarded.

I think meminfo and cpuinfo would already be great. And if we're
virtualizing cpuinfo we also need to virtualize the cpu bits exposed in
/proc/stat. It would also be great to virtualize /proc/uptime. Right now
we're achieving this essentially by substracting the time the init
process of the pid namespace has started since system boot time, minus
the time when the system started to get the actual reaper age (It's a
bit more involved but that's the gist.).

This is all on the topic list for this year's virtual container's
microconference at Plumber's and I would suggest we try to discuss the
various requirements for something like this there. (I'm about to send
the CFP out.)

Christian

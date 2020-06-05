Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6566C1EEEBF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 02:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgFEA2N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jun 2020 20:28:13 -0400
Received: from raptor.unsafe.ru ([5.9.43.93]:36434 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbgFEA2N (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jun 2020 20:28:13 -0400
Received: from comp-core-i7-2640m-0182e6 (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by raptor.unsafe.ru (Postfix) with ESMTPSA id 1EDA7209AF;
        Fri,  5 Jun 2020 00:28:10 +0000 (UTC)
Date:   Fri, 5 Jun 2020 02:28:06 +0200
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@ubuntu.com>
Subject: Re: [PATCH 0/2] proc: use subset option to hide some top-level
 procfs entries
Message-ID: <20200605002806.sjxfle7w7v5rdlge@comp-core-i7-2640m-0182e6>
References: <20200604200413.587896-1-gladkov.alexey@gmail.com>
 <87ftbah8q2.fsf@x220.int.ebiederm.org>
 <20200604213220.grcaldlxz54jyd3o@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604213220.grcaldlxz54jyd3o@wittgenstein>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.1 (raptor.unsafe.ru [5.9.43.93]); Fri, 05 Jun 2020 00:28:11 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 04, 2020 at 11:32:20PM +0200, Christian Brauner wrote:
> > Is it desirable to have meminfo and cpuinfo as they are today or do
> > people want them to reflect the ``container'' context.   So that
> > applications like the JVM don't allocation too many cpus or don't try
> > and consume too much memory, or run on nodes that cgroups current make
> > unavailable.
> > 
> > Are there any users or planned users of this functionality yet?
> > 
> > I am concerned that you might be adding functionality that no one will
> > ever use that will just add code to the kernel that no one cares about,
> > that will then accumulate bugs.  Having had to work through a few of
> > those cases to make each mount of proc have it's own super block I am
> > not a great fan of adding another one.
> > 
> > If the runc, lxc and other container runtime folks can productively use
> > such and option to do useful things and they are sensible things to do I
> > don't have any fundamental objection.  But I do want to be certain this
> > is a feature that is going to be used.
> 
> I'm not sure Alexey is introducing virtualized meminfo and cpuinfo (but
> I haven't had time to look at this patchset).

No. Not yet :) I just suggest a way to restrict access to files in the
procfs inside a container about which you know nothing.

> In any case, we are currently virtualizing:
> /proc/cpuinfo
> /proc/diskstats
> /proc/loadavg
> /proc/meminfo
> /proc/stat
> /proc/swaps
> /proc/uptime
> for each container with a tiny in-userspace filesystem LXCFS
> ( https://github.com/lxc/lxcfs )
> and have been doing that for years.

I know about it. The reason for the appearance of such a solution is also
clear.

> Having meminfo and cpuinfo virtualized in procfs was something we have
> been wanting for a long time and there have been patches by other people
> (from Siteground, I believe) to achieve this a few years back but were
> disregarded.
> 
> I think meminfo and cpuinfo would already be great. And if we're
> virtualizing cpuinfo we also need to virtualize the cpu bits exposed in
> /proc/stat. It would also be great to virtualize /proc/uptime. Right now
> we're achieving this essentially by substracting the time the init
> process of the pid namespace has started since system boot time, minus
> the time when the system started to get the actual reaper age (It's a
> bit more involved but that's the gist.).
> 
> This is all on the topic list for this year's virtual container's
> microconference at Plumber's and I would suggest we try to discuss the
> various requirements for something like this there. (I'm about to send
> the CFP out.)
> 
> Christian
> 

-- 
Rgrds, legion


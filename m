Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD33456502
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 22:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbhKRV1O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 16:27:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:44048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230274AbhKRV1M (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 16:27:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 15E6260EBD;
        Thu, 18 Nov 2021 21:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637270652;
        bh=TYswleEFlex6fJqliFbnTWm7RMblNeV+4kiIIa4Ympw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d+H5yVhKNS5UvAtPm6UEXFf0CtRPNFIhCvJCkHXzsLUjOcWE2soaOuvgzMxEH2WQW
         pMk1GMLxEeyjacExyqZVV4aI3tcUz5kd+V1WgslDD73ozUgvb2i14c3F2imBT/5JZ4
         wqv8FdDgm0V78yydZIsEB+EfT4veEFqmjtzbUkHycQpl1WMejLhTsto+N7D0I5Z4fm
         ghWnwTHCwyPkHtVNt8QmzMg9kL7l6W0EZ61hDvBye4LS16OpKh547fGxMHdoLnnIJO
         Gc5aV6flPNosvPiQFFWvh1zeIWk0bGJd3IyCKDqlZs56NUFuGXh6IZB6SYPr5kjC94
         LjC3Ih3U/7FFg==
Date:   Thu, 18 Nov 2021 23:24:02 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        rostedt@goodmis.org, mingo@redhat.com, hagen@jauu.net,
        James.Bottomley@hansenpartnership.com, akpm@linux-foundation.org,
        vvs@virtuozzo.com, shakeelb@google.com,
        christian.brauner@ubuntu.com, mkoutny@suse.com,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Andrei Vagin <avagin@gmail.com>, criu@openvz.org
Subject: Re: [RFC PATCH 0/4] namespacefs: Proof-of-Concept
Message-ID: <YZbEcvH+BWwSqeeC@kernel.org>
References: <20211118181210.281359-1-y.karadz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118181210.281359-1-y.karadz@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

(added more CRIU folks)

On Thu, Nov 18, 2021 at 08:12:06PM +0200, Yordan Karadzhov (VMware) wrote:
> We introduce a simple read-only virtual filesystem that provides
> direct mechanism for examining the existing hierarchy of namespaces
> on the system. For the purposes of this PoC, we tried to keep the
> implementation of the pseudo filesystem as simple as possible. Only
> two namespace types (PID and UTS) are coupled to it for the moment.
> Nevertheless, we do not expect having significant problems when
> adding all other namespace types.
> 
> When fully functional, 'namespacefs' will allow the user to see all
> namespaces that are active on the system and to easily retrieve the
> specific data, managed by each namespace. For example the PIDs of
> all tasks enclosed in the individual PID namespaces. Any existing
> namespace on the system will be represented by its corresponding
> directory in namespacesfs. When a namespace is created a directory
> will be added. When a namespace is destroyed, its corresponding
> directory will be removed. The hierarchy of the directories will
> follow the hierarchy of the namespaces.
> 
> One may argue that most of the information, being exposed by this
> new filesystem is already provided by 'procfs' in /proc/*/ns/. In
> fact, 'namespacefs' aims to be complementary to 'procfs', showing not
> only the individual connections between a process and its namespaces,
> but also the global hierarchy of these connections. As a usage example,
> before playing with 'namespacefs', I had no idea that the Chrome web
> browser creates a number of nested PID namespaces. I can only guess
> that each tab or each site is isolated in a nested namespace.
> 
> Being able to see the structure of the namespaces can be very useful
> in the context of the containerized workloads. This will provide
> universal methods for detecting, examining and monitoring all sorts
> of containers running on the system, without relaying on any specific
> user-space software. Fore example, with the help of 'namespacefs',
> the simple Python script below can discover all containers, created
> by 'Docker' and Podman' (by all user) that are currently running on
> the system.
> 
> 
> import sys
> import os
> import pwd
> 
> path = '/sys/fs/namespaces'
> 
> def pid_ns_tasks(inum):
>     tasks_file = '{0}/pid/{1}/tasks'.format(path ,inum)
>     with open(tasks_file) as f:
>         return [int(pid) for pid in f]
> 
> def uts_ns_inum(pid):
>     uts_ns_file = '/proc/{0}/ns/uts'.format(pid)
>     uts_ns = os.readlink(uts_ns_file)
>     return  uts_ns.split('[')[1].split(']')[0]
> 
> def container_info(pid_inum):
>     pids = pid_ns_tasks(inum)
>     name = ''
>     uid = -1
> 
>     if len(pids):
>         uts_inum = uts_ns_inum(pids[0])
>         uname_file = '{0}/uts/{1}/uname'.format(path, uts_inum)
>         if os.path.exists(uname_file):
>             stat_info = os.stat(uname_file)
>             uid = stat_info.st_uid
>             with open(uname_file) as f:
>                 name = f.read().split()[1]
> 
>     return name, pids, uid
> 
> if __name__ == "__main__":
>     pid_ns_list = os.listdir('{0}/pid'.format(path))
>     for inum in pid_ns_list:
>         name, pids, uid = container_info(inum)
>         if (name):
>             user = pwd.getpwuid(uid).pw_name
>             print("{0} -> pids: {1} user: {2}".format(name, pids, user))
> 
> 
> 
> The idea for 'namespacefs' is inspired by the discussion of the
> 'Container tracing' topic [1] during the 'Tracing micro-conference' [2]
> at LPC 2021.
> 
> 1. https://www.youtube.com/watch?v=09bVK3f0MPg&t=5455s
> 2. https://www.linuxplumbersconf.org/event/11/page/104-accepted-microconferences
> 
> 
> Yordan Karadzhov (VMware) (4):
>   namespacefs: Introduce 'namespacefs'
>   namespacefs: Add methods to create/remove PID namespace directories
>   namespacefs: Couple namespacefs to the PID namespace
>   namespacefs: Couple namespacefs to the UTS namespace
> 
>  fs/Kconfig                  |   1 +
>  fs/Makefile                 |   1 +
>  fs/namespacefs/Kconfig      |   6 +
>  fs/namespacefs/Makefile     |   4 +
>  fs/namespacefs/inode.c      | 410 ++++++++++++++++++++++++++++++++++++
>  include/linux/namespacefs.h |  73 +++++++
>  include/linux/ns_common.h   |   4 +
>  include/uapi/linux/magic.h  |   2 +
>  kernel/pid_namespace.c      |   9 +
>  kernel/utsname.c            |   9 +
>  10 files changed, 519 insertions(+)
>  create mode 100644 fs/namespacefs/Kconfig
>  create mode 100644 fs/namespacefs/Makefile
>  create mode 100644 fs/namespacefs/inode.c
>  create mode 100644 include/linux/namespacefs.h
> 
> -- 
> 2.33.1
> 

-- 
Sincerely yours,
Mike.

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3EF2332AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 15:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgG3NJP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 09:09:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50392 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728328AbgG3NJP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 09:09:15 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k18Im-0001Sn-VA; Thu, 30 Jul 2020 13:08:53 +0000
Date:   Thu, 30 Jul 2020 15:08:52 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        areber@redhat.com, serge@hallyn.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/23] proc: Introduce /proc/namespaces/ directory to
 expose namespaces lineary
Message-ID: <20200730130852.kyzam5rihehviaia@wittgenstein>
References: <159611007271.535980.15362304262237658692.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <159611007271.535980.15362304262237658692.stgit@localhost.localdomain>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 30, 2020 at 02:59:20PM +0300, Kirill Tkhai wrote:
> Currently, there is no a way to list or iterate all or subset of namespaces
> in the system. Some namespaces are exposed in /proc/[pid]/ns/ directories,
> but some also may be as open files, which are not attached to a process.
> When a namespace open fd is sent over unix socket and then closed, it is
> impossible to know whether the namespace exists or not.
> 
> Also, even if namespace is exposed as attached to a process or as open file,
> iteration over /proc/*/ns/* or /proc/*/fd/* namespaces is not fast, because
> this multiplies at tasks and fds number.
> 
> This patchset introduces a new /proc/namespaces/ directory, which exposes
> subset of permitted namespaces in linear view:
> 
> # ls /proc/namespaces/ -l
> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'cgroup:[4026531835]' -> 'cgroup:[4026531835]'
> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'ipc:[4026531839]' -> 'ipc:[4026531839]'
> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'mnt:[4026531840]' -> 'mnt:[4026531840]'
> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'mnt:[4026531861]' -> 'mnt:[4026531861]'
> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'mnt:[4026532133]' -> 'mnt:[4026532133]'
> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'mnt:[4026532134]' -> 'mnt:[4026532134]'
> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'mnt:[4026532135]' -> 'mnt:[4026532135]'
> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'mnt:[4026532136]' -> 'mnt:[4026532136]'
> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'net:[4026531993]' -> 'net:[4026531993]'
> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'pid:[4026531836]' -> 'pid:[4026531836]'
> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'time:[4026531834]' -> 'time:[4026531834]'
> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'user:[4026531837]' -> 'user:[4026531837]'
> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'uts:[4026531838]' -> 'uts:[4026531838]'
> 
> Namespace ns is exposed, in case of its user_ns is permitted from /proc's pid_ns.
> I.e., /proc is related to pid_ns, so in /proc/namespace we show only a ns, which is
> 
> 	in_userns(pid_ns->user_ns, ns->user_ns).
> 
> In case of ns is a user_ns:
> 
> 	in_userns(pid_ns->user_ns, ns).
> 
> The patchset follows this steps:
> 
> 1)A generic counter in ns_common is introduced instead of separate
>   counters for every ns type (net::count, uts_namespace::kref,
>   user_namespace::count, etc). Patches [1-8];
> 2)Patch [9] introduces IDR to link and iterate alive namespaces;
> 3)Patch [10] is refactoring;
> 4)Patch [11] actually adds /proc/namespace directory and fs methods;
> 5)Patches [12-23] make every namespace to use the added methods
>   and to appear in /proc/namespace directory.
> 
> This may be usefull to write effective debug utils (say, fast build
> of networks topology) and checkpoint/restore software.

Kirill,

Thanks for working on this!
We have a need for this functionality too for namespace introspection.
I actually had a prototype of this as well but mine was based on debugfs
but /proc/namespaces seems like a good place.

Christian

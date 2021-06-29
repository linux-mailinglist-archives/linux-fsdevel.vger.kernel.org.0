Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E923B735A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 15:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbhF2Nmm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 09:42:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232535AbhF2Nmj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 09:42:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2006161DC2;
        Tue, 29 Jun 2021 13:40:09 +0000 (UTC)
Date:   Tue, 29 Jun 2021 15:40:07 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     yang.yang29@zte.com.cn
Cc:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        menglong8.dong@gmail.com
Subject: Re: [PATCH] sysctl: fix permission check while owner isn't
 GLOBAL_ROOT_UID
Message-ID: <20210629134007.6edxcohqmlffsoip@wittgenstein>
References: <20210628121729.xsbm63b5lxpsvhbu@wittgenstein>
 <202106282114107052565@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202106282114107052565@zte.com.cn>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 28, 2021 at 09:14:10PM +0800, yang.yang29@zte.com.cn wrote:
> > I'm confused about what the actual problem is tbh:
> > 
> > root@h3:~# stat -c "%A %a %n" /proc/sys/net/ipv4/ip_forward
> > -rw-r--r-- 644 /proc/sys/net/ipv4/ip_forward
> > 
> > root@h3:~# echo 0 > /proc/sys/net/ipv4/ip_forward
> > 
> > root@h3:~# cat /proc/sys/net/ipv4/ip_forward
> > 0
> > 
> > root@h3:~# cat /proc/self/uid_map  
> >          0     100000 1000000000
> 
> Sorry to describe too simple. More specific:
> 1.Run dockerd with user namespace enbled
> echo dockremap:296608:65536 >  /etc/subuid;echo dockremap:296608:65536 >  /etc/subgid
> dockerd ... --userns-remap=default
> 2.Create a container
> docker run -it ... sh
> 
> Then root account in the container is 296608 account in the host:
> / # cat /proc/self/uid_map
>          0     296608      65536
> 
> In the container, /proc/sys/net/ipv4/ip_forward's owner is root, but root can't modify it:
> / # whoami
> root
> / # ls -l /proc/sys/net/ipv4/ip_forward
> -rw-r--r--    1 root     root             0 Jun 28 12:46 /proc/sys/net/ipv4/ip_forward
> / # cat /proc/sys/net/ipv4/ip_forward
> 1
> / # echo 0 > /proc/sys/net/ipv4/ip_forward
> sh: can't create /proc/sys/net/ipv4/ip_forward: Permission denied
> 
> And /proc/sys/net/ipv4/ip_forward has considerd about net namespace, 
> see net_ctl_set_ownership() in net\sysctl_net.c.
> So root in container should be able to modify /proc/sys/net/ipv4/ip_forward.
> This doesn't impact /proc/sys/net/ipv4/ip_forward in the host or other container with other net namespace.

Sorry to resort to "It works on my machine" but I just pasted you the
exact same setup and showed you that this works as expected.

So the reason here is likely that you're lacking capabilities
specifically CAP_NET_ADMIN. If I reproduce with your setup I can't even
create a dummy network device:

/ #  ip link add bla type dummy
ip: RTNETLINK answers: Operation not permitted

whereas on any unprivileged container that reatins CAP_NET_ADMIN that
just works fine.

So I would think that if you retain CAP_NET_ADMIN things will work out
just fine. Take a look at net_ctl_permissions.

There's really no reason to drop CAP_NET_ADMIN in a network namespace
that is owned by a non-initial user namespace anyway.

Christian

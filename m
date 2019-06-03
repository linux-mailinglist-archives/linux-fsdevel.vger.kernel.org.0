Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25E42332F6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2019 17:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbfFCPAR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jun 2019 11:00:17 -0400
Received: from mail.virtlab.unibo.it ([130.136.161.50]:48671 "EHLO
        mail.virtlab.unibo.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbfFCPAR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:00:17 -0400
Received: from cs.unibo.it (host5.studiodavoli.it [109.234.61.227])
        by mail.virtlab.unibo.it (Postfix) with ESMTPSA id 98D3C22603;
        Mon,  3 Jun 2019 17:00:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.unibo.it;
        s=virtlab; t=1559574013;
        bh=DLnGNJnyJiNIykJV53YV0lVX0PRr2Fd6kDb05wo5wS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t9TRXE1ZG2HmO1JDHZWIbU3N53MsWj6yw5DLIv3bv8lY/Gn9lUzXMZv2o80o29Gx0
         lIuBTK/cPwE8c/kanOCxHBwFDWOrRbCOu89aCbpzhZ8uRZ9UDA4N1te50FN2ddtltg
         bMph7PP9tu8nzFne0ohyU69o8q/hDpfLCQXN1f5I=
Date:   Mon, 3 Jun 2019 17:00:10 +0200
From:   Renzo Davoli <renzo@cs.unibo.it>
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Davide Libenzi <davidel@xmailserver.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 1/1] eventfd new tag EFD_VPOLL: generate epoll events
Message-ID: <20190603150010.GE4312@cs.unibo.it>
References: <20190526142521.GA21842@cs.unibo.it>
 <20190527073332.GA13782@kroah.com>
 <20190527133621.GC26073@cs.unibo.it>
 <480f1bda66b67f740f5da89189bbfca3@suse.de>
 <20190531104502.GE3661@cs.unibo.it>
 <cd20672aaf13f939b4f798d0839d2438@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd20672aaf13f939b4f798d0839d2438@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Roman,

	 I sorry for the delay in my answer, but I needed to set up a minimal
tutorial to show what I am working on and why I need a feature like the
one I am proposing.

Please, have a look of the README.md page here:
https://github.com/virtualsquare/vuos
(everything can be downloaded and tested)

On Fri, May 31, 2019 at 01:48:39PM +0200, Roman Penyaev wrote:
> Since each such a stack has a set of read/write/etc functions you always
> can extend you stack with another call which returns you event mask,
> specifying what exactly you have to do, e.g.:
> 
>     nfds = epoll_wait(epollfd, events, MAX_EVENTS, -1);
>     for (n = 0; n < nfds; ++n) {
>          struct sock *sock;
> 
>          sock = events[n].data.ptr;
>          events = sock->get_events(sock, &events[n]);
> 
>          if (events & EPOLLIN)
>              sock->read(sock);
>          if (events & EPOLLOUT)
>              sock->write(sock);
>     }
> 
> 
> With such a virtual table you can mix all userspace stacks and even
> with normal sockets, for which 'get_events' function can be declared as
> 
> static poll_t kernel_sock_get_events(struct sock *sock, struct epoll_event
> *ev)
> {
>     return ev->events;
> }
> 
> Do I miss something?

I am not trying to port some tools to use user-space implemented stacks or device
drivers/emulators, I am seeking to a general purpose approach.

I think that the example in the section of the README "mount a user-level 
networking stack" explains the situation.

The submodule vunetvdestack uses a namespace to define a networking stack connected
to a VDE network (see https://github.com/rd235/vdeplug4).

The API is clean (as it can be seen at the end of the file vunet_modules/vunetvdestack.c).
All the methods but "socket" are directly mapped to their system call counterparts:

struct vunet_operations vunet_ops = {
  .socket = vdestack_socket,
  .bind = bind,
  .connect = connect,
  .listen = listen,
  .accept4 = accept4,
....
	.epoll_ctl = epoll_ctl,
...
}

(the elegance of the API can be seen also in vunet_modules/vunetreal.c: a 38 lines module
 implementing a gateway to the real networking of the hosting machine)

Unfortunately I cannot use the same clean interface to support user-library implemented
stacks like lwip/lwipv6/picotcp because I cannot generate EPOLL events...

Bizantine workarounds based on data structures exchanged in the data.ptr field of epoll_event
that must be decoded by the hypervisor to retrieve the missing information about the event
can be implemented... but it would be a pity ;-)

The same problem arises in umdev modules: virtual devices should generate the same
EPOLL events of their real couterparts.

I feel that the ability to generate/synthesize EPOLL events could be useful for many projects.
(In my first message I included some URLs of people seeking for this feature, retrieved by
 some queries on a web search engine)

Implementations may vary as well as the kernel API to support such a feature.
As I told, my proposal has a minimal impact on the code, it does not require the definition
of new syscalls, it simply enhances the features of eventfd.

> 
> Eventually you come up with such a lock to protect your tcp or whatever
> state machine.  Or you have a real example where read and write paths
> can work completely independently?

Actually umvu hypervisor uses concurrent tracing of concurrent processes.
We have named this technique "guardian angels": each process/thread running in the
partial virtual machine has a correspondent thread in the hypervisor.
So if a process uses two threads to manage a network connection (say a TCP stream),
the two guardian angels replicate their requests towards the networking module.

So I am looking for a general solution, not to a pattern to port some projects.
(and I cannot use two different approaches for event driven and multi-threaded
 implementations as I have to support both).

If you reached this point...  Thank you for your patience.
I am more than pleased to receive further comments or proposals.

	renzo

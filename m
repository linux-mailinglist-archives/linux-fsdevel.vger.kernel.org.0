Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4C230D7D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 13:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfEaLsm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 07:48:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:55768 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726403AbfEaLsm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 07:48:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F1702AD4E;
        Fri, 31 May 2019 11:48:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 31 May 2019 13:48:39 +0200
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Renzo Davoli <renzo@cs.unibo.it>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Davide Libenzi <davidel@xmailserver.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 1/1] eventfd new tag EFD_VPOLL: generate epoll events
In-Reply-To: <20190531104502.GE3661@cs.unibo.it>
References: <20190526142521.GA21842@cs.unibo.it>
 <20190527073332.GA13782@kroah.com> <20190527133621.GC26073@cs.unibo.it>
 <480f1bda66b67f740f5da89189bbfca3@suse.de>
 <20190531104502.GE3661@cs.unibo.it>
Message-ID: <cd20672aaf13f939b4f798d0839d2438@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-05-31 12:45, Renzo Davoli wrote:
> HI Roman,
> 
> On Fri, May 31, 2019 at 11:34:08AM +0200, Roman Penyaev wrote:
>> On 2019-05-27 15:36, Renzo Davoli wrote:
>> > Unfortunately this approach cannot be applied to
>> > poll/select/ppoll/pselect/epoll.
>> 
>> If you have to override other systemcalls, what is the problem to 
>> override
>> poll family?  It will add, let's say, 50 extra code lines complexity 
>> to your
>> userspace code.  All you need is to be woken up by *any* event and 
>> check
>> one mask variable, in order to understand what you need to do: read or
>> write,
>> basically exactly what you do in your eventfd modification, but only 
>> in
>> userspace.
> 
> This approach would not scale. If I want to use both a (user-space)
> network stack
> and a (emulated) device (or more stacks and devices) which
> (overridden) poll would I use?
> 
> The poll of the first stack is not able to to deal with the third 
> device.

Since each such a stack has a set of read/write/etc functions you always
can extend you stack with another call which returns you event mask,
specifying what exactly you have to do, e.g.:

     nfds = epoll_wait(epollfd, events, MAX_EVENTS, -1);
     for (n = 0; n < nfds; ++n) {
          struct sock *sock;

          sock = events[n].data.ptr;
          events = sock->get_events(sock, &events[n]);

          if (events & EPOLLIN)
              sock->read(sock);
          if (events & EPOLLOUT)
              sock->write(sock);
     }


With such a virtual table you can mix all userspace stacks and even
with normal sockets, for which 'get_events' function can be declared as

static poll_t kernel_sock_get_events(struct sock *sock, struct 
epoll_event *ev)
{
     return ev->events;
}

Do I miss something?


>> > > Why can it not be less than 64?
>> > This is the imeplementation of 'write'. The 64 bits include the
>> > 'command'
>> > EFD_VPOLL_ADDEVENTS, EFD_VPOLL_DELEVENTS or EFD_VPOLL_MODEVENTS (in the
>> > most
>> > significant 32 bits) and the set of events (in the lowest 32 bits).
>> 
>> Do you really need add/del/mod semantics?  Userspace still has to keep 
>> mask
>> somewhere, so you can have one simple command, which does:
>>    ctx->count = events;
>> in kernel, so no masks and this games with bits are needed.  That will
>> simplify API.
> 
> It is true, at the price to have more complex code in user space.
> Other system calls could have beeen implemented as "set the value",
> instead there are
> ADD/DEL modification flags.
> I mean for example sigprocmask (SIG_BLOCK, SIG_UNBLOCK, SIG_SETMASK),
> or even epoll_ctl.
> While poll requires the program to keep the struct pollfd array stored
> somewhere,
> epoll is more powerful and flexible as different file descriptors can 
> be added
> and deleted by different modules/components.
> 
> If I have two threads implementing the send and receive path of a
> socket in a user-space

Eventually you come up with such a lock to protect your tcp or whatever
state machine.  Or you have a real example where read and write paths
can work completely independently?

--
Roman

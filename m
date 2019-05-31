Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02BA230CCC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 12:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfEaKpI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 06:45:08 -0400
Received: from mail.virtlab.unibo.it ([130.136.161.50]:43110 "EHLO
        mail.virtlab.unibo.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbfEaKpI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 06:45:08 -0400
Received: from cs.unibo.it (host5.studiodavoli.it [109.234.61.227])
        by mail.virtlab.unibo.it (Postfix) with ESMTPSA id 3F13F1FF56;
        Fri, 31 May 2019 12:45:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.unibo.it;
        s=virtlab; t=1559299504;
        bh=s4G4mm0cVlJxxyR750Hz6JmulktaIEHy2Bt1ua5aYVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CAKhQHBm8yDt+YFRTa0N3chhhC+ygsozaglGaLMMQgRfeA720bE0+p55Z9myJ2qdE
         v+O+Y9/zx3J/zBtByHSNb0jZQuYIsE8gLVNkbIyEySIS8cDYkU65hsPiIQBQJMKZlp
         tzfdFhaLGei9bCsCSP9xfq4yE5rsajcjm1xnT5RA=
Date:   Fri, 31 May 2019 12:45:02 +0200
From:   Renzo Davoli <renzo@cs.unibo.it>
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Davide Libenzi <davidel@xmailserver.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 1/1] eventfd new tag EFD_VPOLL: generate epoll events
Message-ID: <20190531104502.GE3661@cs.unibo.it>
References: <20190526142521.GA21842@cs.unibo.it>
 <20190527073332.GA13782@kroah.com>
 <20190527133621.GC26073@cs.unibo.it>
 <480f1bda66b67f740f5da89189bbfca3@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <480f1bda66b67f740f5da89189bbfca3@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

HI Roman,

On Fri, May 31, 2019 at 11:34:08AM +0200, Roman Penyaev wrote:
> On 2019-05-27 15:36, Renzo Davoli wrote:
> > Unfortunately this approach cannot be applied to
> > poll/select/ppoll/pselect/epoll.
> 
> If you have to override other systemcalls, what is the problem to override
> poll family?  It will add, let's say, 50 extra code lines complexity to your
> userspace code.  All you need is to be woken up by *any* event and check
> one mask variable, in order to understand what you need to do: read or
> write,
> basically exactly what you do in your eventfd modification, but only in
> userspace.

This approach would not scale. If I want to use both a (user-space) network stack
and a (emulated) device (or more stacks and devices) which (overridden) poll would I use?

The poll of the first stack is not able to to deal with the third device.

> 
> 
> > > Why can it not be less than 64?
> > This is the imeplementation of 'write'. The 64 bits include the
> > 'command'
> > EFD_VPOLL_ADDEVENTS, EFD_VPOLL_DELEVENTS or EFD_VPOLL_MODEVENTS (in the
> > most
> > significant 32 bits) and the set of events (in the lowest 32 bits).
> 
> Do you really need add/del/mod semantics?  Userspace still has to keep mask
> somewhere, so you can have one simple command, which does:
>    ctx->count = events;
> in kernel, so no masks and this games with bits are needed.  That will
> simplify API.

It is true, at the price to have more complex code in user space.
Other system calls could have beeen implemented as "set the value", instead there are
ADD/DEL modification flags.
I mean for example sigprocmask (SIG_BLOCK, SIG_UNBLOCK, SIG_SETMASK), or even epoll_ctl.
While poll requires the program to keep the struct pollfd array stored somewhere,
epoll is more powerful and flexible as different file descriptors can be added
and deleted by different modules/components.

If I have two threads implementing the send and receive path of a socket in a user-space
network stack implementation the epoll pending bitmap is shared so I have to create
critical sections like the following one any time I need to set or reset a bit.
	pthread_mutex_lock(mylock)
	events |= EPOLLIN
	write(efd, &events, sizeof(events));
	pthread_mutex_unlock(mylock)
Using add/del semantics locking is not required as the send path thread deals with EPOLLOUT while
its siblings receive thread uses EPOLLIN or EPOLLPRI

I would prefer the add/del/mod semantics, but if this is generally perceived as a unnecessary 
complexity in the kernel code I can update my patch.  

Thank you Roman,
			
			renzo

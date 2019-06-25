Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF98B54D3A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2019 13:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730291AbfFYLHF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 07:07:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:49856 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730028AbfFYLHE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 07:07:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 63EC2ACA7;
        Tue, 25 Jun 2019 11:07:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 25 Jun 2019 13:07:02 +0200
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Eric Wong <e@80x24.org>
Cc:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Azat Khuzhin <azat@libevent.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/14] epoll: support pollable epoll from userspace
In-Reply-To: <20190625002456.unhdqihvs5lqcjn6@dcvr>
References: <20190624144151.22688-1-rpenyaev@suse.de>
 <20190625002456.unhdqihvs5lqcjn6@dcvr>
Message-ID: <1e50e45cfc832320999f21a81790a060@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-06-25 02:24, Eric Wong wrote:
> Roman Penyaev <rpenyaev@suse.de> wrote:
>> Hi all,
> 
> +cc Jason Baron
> 
>> ** Limitations
> 
> <snip>
> 
>> 4. No support for EPOLLEXCLUSIVE
>>      If device does not pass pollflags to wake_up() there is no way to
>>      call poll() from the context under spinlock, thus special work is
>>      scheduled to offload polling.  In this specific case we can't
>>      support exclusive wakeups, because we do not know actual result
>>      of scheduled work and have to wake up every waiter.
> 
> Lacking EPOLLEXCLUSIVE support is probably a showstopper for
> common applications using per-task epoll combined with
> non-blocking accept4() (e.g. nginx).

For the 'accept' case it seems SO_REUSEPORT can be used:

    https://lwn.net/Articles/542629/

Although I've never tried it in O_NONBLOCK + epoll scenario.

But I've just again dived into this add-wait-exclusive logic and it
seems possible to support EPOLLEXCLUSIVE by iterating over all "epis"
for a particular fd, which has been woken up.

For now I want to leave it as is just not to overcomplicate the code.

> Fwiw, I'm still a weirdo who prefers a dedicated thread doing
> blocking accept4 for distribution between tasks (so epoll never
> sees a listen socket).  But, depending on what runtime/language
> I'm using, I can't always dedicate a blocking thread, so I
> recently started using EPOLLEXCLUSIVE from Perl5 where I
> couldn't rely on threads being available.
> 
> 
> If I could dedicate time to improving epoll; I'd probably
> add writev() support for batching epoll_ctl modifications
> to reduce syscall traffic, or pick-up the kevent()-like interface
> started long ago:
> https://lore.kernel.org/lkml/1393206162-18151-1-git-send-email-n1ght.4nd.d4y@gmail.com/
> (but I'm not sure I want to increase the size of the syscall table).

There is also fresh fs/io_uring.c thingy, which supports polling and
batching (among other IO things).  But polling there acts only as a
single-shot, so it might make sense to support there event subscription
instead of resurrecting kevent and co.

--
Roman







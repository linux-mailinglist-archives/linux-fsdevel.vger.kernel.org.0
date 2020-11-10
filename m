Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A33A2ACFA7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 07:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730911AbgKJG1l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 01:27:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:52358 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgKJG1l (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 01:27:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 301B4ABCC;
        Tue, 10 Nov 2020 06:27:39 +0000 (UTC)
Date:   Mon, 9 Nov 2020 22:05:03 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Soheil Hassas Yeganeh <soheil.kdev@gmail.com>
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, edumazet@google.com, willemb@google.com,
        khazhy@google.com, guantaol@google.com,
        Soheil Hassas Yeganeh <soheil@google.com>
Subject: Re: [PATCH 1/8] epoll: check for events when removing a timed out
 thread from the wait queue
Message-ID: <20201110060503.jao4wd4whtyvkcnn@linux-p48b.lan>
References: <20201106231635.3528496-1-soheil.kdev@gmail.com>
 <20201106231635.3528496-2-soheil.kdev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201106231635.3528496-2-soheil.kdev@gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 06 Nov 2020, Soheil Hassas Yeganeh wrote:

>From: Soheil Hassas Yeganeh <soheil@google.com>
>
>After abc610e01c66 ("fs/epoll: avoid barrier after an epoll_wait(2)
>timeout"), we break out of the ep_poll loop upon timeout, without checking
>whether there is any new events available.  Prior to that patch-series we
>always called ep_events_available() after exiting the loop.
>
>This can cause races and missed wakeups.  For example, consider the
>following scenario reported by Guantao Liu:
>
>Suppose we have an eventfd added using EPOLLET to an epollfd.
>
>Thread 1: Sleeps for just below 5ms and then writes to an eventfd.
>Thread 2: Calls epoll_wait with a timeout of 5 ms. If it sees an
>          event of the eventfd, it will write back on that fd.
>Thread 3: Calls epoll_wait with a negative timeout.
>
>Prior to abc610e01c66, it is guaranteed that Thread 3 will wake up either
>by Thread 1 or Thread 2.  After abc610e01c66, Thread 3 can be blocked
>indefinitely if Thread 2 sees a timeout right before the write to the
>eventfd by Thread 1.  Thread 2 will be woken up from
>schedule_hrtimeout_range and, with evail 0, it will not call
>ep_send_events().
>
>To fix this issue:
>1) Simplify the timed_out case as suggested by Linus.
>2) while holding the lock, recheck whether the thread was woken up
>   after its time out has reached.
>
>Note that (2) is different from Linus' original suggestion: It do not
>set "eavail = ep_events_available(ep)" to avoid unnecessary contention
>(when there are too many timed-out threads and a small number of events),
>as well as races mentioned in the discussion thread.
>
>This is the first patch in the series so that the backport to stable
>releases is straightforward.
>
>Link: https://lkml.kernel.org/r/CAHk-=wizk=OxUyQPbO8MS41w2Pag1kniUV5WdD5qWL-gq1kjDA@mail.gmail.com
>Fixes: abc610e01c66 ("fs/epoll: avoid barrier after an epoll_wait(2) timeout")
>Tested-by: Guantao Liu <guantaol@google.com>
>Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
>Signed-off-by: Soheil Hassas Yeganeh <soheil@google.com>
>Reported-by: Guantao Liu <guantaol@google.com>
>Reviewed-by: Eric Dumazet <edumazet@google.com>
>Reviewed-by: Willem de Bruijn <willemb@google.com>
>Reviewed-by: Khazhismel Kumykov <khazhy@google.com>

Thanks for providing the fix and a testcase.

Reviewed-by: Davidlohr Bueso <dbueso@suse.de>

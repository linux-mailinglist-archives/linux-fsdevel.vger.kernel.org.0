Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33AEB3102B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 16:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfEaO2i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 10:28:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:59752 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726418AbfEaO2i (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 10:28:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EE5E1AF99;
        Fri, 31 May 2019 14:28:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 31 May 2019 16:28:36 +0200
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     azat@libevent.org, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/13] epoll: introduce helpers for adding/removing
 events to uring
In-Reply-To: <20190531125322.GY2606@hirez.programming.kicks-ass.net>
References: <20190516085810.31077-1-rpenyaev@suse.de>
 <20190516085810.31077-7-rpenyaev@suse.de>
 <20190531095607.GC17637@hirez.programming.kicks-ass.net>
 <274e29d102133f3be1f309c66cb0af36@suse.de>
 <20190531125322.GY2606@hirez.programming.kicks-ass.net>
Message-ID: <ef6cb59e319f185619e531c0a39bd32a@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-05-31 14:53, Peter Zijlstra wrote:
> On Fri, May 31, 2019 at 01:15:21PM +0200, Roman Penyaev wrote:
>> On 2019-05-31 11:56, Peter Zijlstra wrote:
>> > On Thu, May 16, 2019 at 10:58:03AM +0200, Roman Penyaev wrote:
> 
>> > > +		i = __atomic_fetch_add(&ep->user_header->tail, 1,
>> > > +				       __ATOMIC_ACQUIRE);
>> >
>> > afaict __atomic_fetch_add() does not exist.
>> 
>> That is gcc extension.  I did not find any API just to increment
>> the variable atomically without using/casting to atomic.  What
>> is a proper way to achieve that?
> 
> That's C11 atomics, and those shall not be used in the kernel. For one
> they're not available in the minimally required GCC version (4.6).
> 
> The proper and only way is to use atomic_t, but also you cannot share
> atomic_t with userspace.

Yes, that what I tried to avoid choosing c11 extension.

> 
> The normal way of doing something like this is to have a kernel private
> atomic_t and copy the value out to userspace using smp_store_release().

Since this path is lockless unfortunately that won't work.  So seems
the only way is to do one more cmpxchg (sigh) or give up and take a
look (sad sigh).

--
Roman

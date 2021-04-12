Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74AD635D3D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 01:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344038AbhDLXS5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Apr 2021 19:18:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42240 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243394AbhDLXS4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Apr 2021 19:18:56 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618269515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CiWcf1nZomYLBbBIwqNf2tsBQROh3k5oQlX0lyDq8eA=;
        b=eLjoHM4z41hA93TnjSLtAD67LfTb1omZnt0U13r5rVqueTG6PqcMBM9Wc4iLgV+psancAF
        z6VM0opvYk/UUCRPW5kCE9/+NCVcwRrAQzqCF71wD5PD8Q7xQ4NJ61ccWPLRuoYHvJAt+/
        A8OpjLCgJ41EhaCpMewN2dg586N6PXVq6sN0cv7Fat0ERWBxyFzEh/VLT5+uywTZY8/CIc
        bvP+SAV5ltpSJans/hgrSKZ0mWnsdIk39IbnjmVnwU7QQ6pH/Lb5V877MFf0awi7IF4GKU
        ABrMnMa/epL26U4AzXpGhOC0PTOm3qEpf7pE6V11as+W4Z4MOP1Tk3tc7DbHMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618269515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CiWcf1nZomYLBbBIwqNf2tsBQROh3k5oQlX0lyDq8eA=;
        b=EWA8R/Lkt7ovItCODSeoICjMQggqMsZcsu8SmH2trT2MrU7cnBXKiSwclEsYO0PSdr2blq
        J2n0oSCwKTAklAAQ==
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com, bigeasy@linutronix.de,
        hch@infradead.org, npiggin@kernel.dk
Subject: Re: bl_list and lockdep
In-Reply-To: <20210412221536.GQ1990290@dread.disaster.area>
References: <20210406123343.1739669-1-david@fromorbit.com> <20210406123343.1739669-4-david@fromorbit.com> <20210406132834.GP2531743@casper.infradead.org> <20210406212253.GC1990290@dread.disaster.area> <874kgb1qcq.ffs@nanos.tec.linutronix.de> <20210412221536.GQ1990290@dread.disaster.area>
Date:   Tue, 13 Apr 2021 01:18:35 +0200
Message-ID: <87fszvytv8.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dave,

On Tue, Apr 13 2021 at 08:15, Dave Chinner wrote:
> On Mon, Apr 12, 2021 at 05:20:53PM +0200, Thomas Gleixner wrote:
>> On Wed, Apr 07 2021 at 07:22, Dave Chinner wrote:
>> > And, FWIW, I'm also aware of the problems that RT kernels have with
>> > the use of bit spinlocks and being unable to turn them into sleeping
>> > mutexes by preprocessor magic. I don't care about that either,
>> > because dentry cache...
>> 
>> In the dentry cache it's a non-issue.
>
> Incorrect.

I'm impressed about your detailed knowledge of something you do not care
about in the first place.

>> RT does not have a problem with bit spinlocks per se, it depends on how
>> they are used and what nests inside. Most of them are just kept as bit
>> spinlocks because the lock held, and therefore preempt disabled times
>> are small and no other on RT conflicting operations happen inside.
>> 
>> In the case at hand this is going to be a problem because inode->i_lock
>> nests inside the bit spinlock and we can't make inode->i_lock a raw
>> spinlock because it protects way heavier weight code pathes as well.
>
> Yes, that's exactly the "problem" I'm refering to. And I don't care,
> precisely because, well, dentry cache....
>
> THat is, the dcache calls wake_up_all() from under the
> hlist_bl_lock() in __d_lookup_done(). That ends up in
> __wake_up_common_lock() which takes a spin lock embedded inside a
> wait_queue_head.  That's not a raw spinlock, either, so we already
> have this "spinlock inside bit lock" situation with the dcache usage
> of hlist_bl.

Sure, but you are missing that RT solves that by substituting the
wait_queue with a swait_queue, which does not suffer from that. But that
can't be done for the inode::i_lock case for various reasons.

> FYI, this dentry cache behaviour was added to the dentry cache in
> 2016 by commit d9171b934526 ("parallel lookups machinery, part 4
> (and last)"), so it's not like it's a new thing, either.

Really? I wasn't aware of that. Thanks for the education.

> If you want to make hlist_bl RT safe, then re-implement it behind
> the scenes for RT enabled kernels. All it takes is more memory
> usage for the hash table + locks, but that's something that non-RT
> people should not be burdened with caring about....

I'm well aware that anything outside of @fromorbit universe is not
interesting to you, but I neverless want to take the opportunity to
express my appreciation for your truly caring and collaborative attitude
versus interests of others who unfortunately do no share that universe.

Thanks,

        tglx

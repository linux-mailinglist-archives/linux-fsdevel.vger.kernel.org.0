Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D74A635C9A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Apr 2021 17:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242790AbhDLPVN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Apr 2021 11:21:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39890 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241439AbhDLPVM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Apr 2021 11:21:12 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618240853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=28Rr5+Qrcl4XZ0tZdNBk5TXZkCeBMrqsuTo/v1rfjAY=;
        b=Zvgw+mqfQ++qlV1vkbxie1Nh65pR9tSYvjG2Z9ZY+1ghvYnCGpwjACgSm94H5oWbyHoR/l
        wEBUmaKxSQT/8QZRTisxl4CbB2h9c4EL4TP+UT0JnfYiBLsT56a/hFGzaburdz/F38wh68
        yQ287l0Dbdtyw8ZMJ1aZofCsUffnHRxNmuYvmyoHUs5uo6A5iM/Pa8U2iLnsJ0VxUCvlFH
        rwjgKeeT72UgZk5kIq5futfVqhTHsGebqVwcLHDEcjaA/gdujhFHHXo6p1IqTWGTPHJ1wV
        HudgEw+GWMHeRAWxN8uItYCgEsh2Ca50LbFC2bPru53erIlOrX4vqAC500ryXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618240853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=28Rr5+Qrcl4XZ0tZdNBk5TXZkCeBMrqsuTo/v1rfjAY=;
        b=d/0WU7g/UW69zxuFDoQi1zeazHTJOyd2wTsJS2aPl4v1CU8MtD7yvbD0o9pyzF+S7JGq1l
        2bxckYqmPR6AmPBQ==
To:     Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com, bigeasy@linutronix.de,
        hch@infradead.org, npiggin@kernel.dk
Subject: Re: bl_list and lockdep
In-Reply-To: <20210406212253.GC1990290@dread.disaster.area>
References: <20210406123343.1739669-1-david@fromorbit.com> <20210406123343.1739669-4-david@fromorbit.com> <20210406132834.GP2531743@casper.infradead.org> <20210406212253.GC1990290@dread.disaster.area>
Date:   Mon, 12 Apr 2021 17:20:53 +0200
Message-ID: <874kgb1qcq.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dave,

On Wed, Apr 07 2021 at 07:22, Dave Chinner wrote:
> On Tue, Apr 06, 2021 at 02:28:34PM +0100, Matthew Wilcox wrote:
>> On Tue, Apr 06, 2021 at 10:33:43PM +1000, Dave Chinner wrote:
>> > +++ b/fs/inode.c
>> > @@ -57,8 +57,7 @@
>> >  
>> >  static unsigned int i_hash_mask __read_mostly;
>> >  static unsigned int i_hash_shift __read_mostly;
>> > -static struct hlist_head *inode_hashtable __read_mostly;
>> > -static __cacheline_aligned_in_smp DEFINE_SPINLOCK(inode_hash_lock);
>> > +static struct hlist_bl_head *inode_hashtable __read_mostly;
>> 
>> I'm a little concerned that we're losing a lockdep map here.  
>> 
>> Nobody seems to have done this for list_bl yet, and I'd be reluctant
>> to gate your patch on "Hey, Dave, solve this problem nobody else has
>> done yet".
>
> I really don't care about lockdep. Adding lockdep support to
> hlist_bl is somebody else's problem - I'm just using infrastructure
> that already exists. Also, the dentry cache usage of hlist_bl is
> vastly more complex and so if lockdep coverage was really necessary,
> it would have already been done....
>
> And, FWIW, I'm also aware of the problems that RT kernels have with
> the use of bit spinlocks and being unable to turn them into sleeping
> mutexes by preprocessor magic. I don't care about that either,
> because dentry cache...

In the dentry cache it's a non-issue.

RT does not have a problem with bit spinlocks per se, it depends on how
they are used and what nests inside. Most of them are just kept as bit
spinlocks because the lock held, and therefore preempt disabled times
are small and no other on RT conflicting operations happen inside.

In the case at hand this is going to be a problem because inode->i_lock
nests inside the bit spinlock and we can't make inode->i_lock a raw
spinlock because it protects way heavier weight code pathes as well.

Thanks,

        tglx



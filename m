Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21CF58D001
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Aug 2022 00:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238347AbiHHWGw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Aug 2022 18:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236734AbiHHWGv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Aug 2022 18:06:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844EAE0E4;
        Mon,  8 Aug 2022 15:06:50 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659996407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Oxa9FbXBAyCLs+gSoIQzd4uxUIi4HukgoLd8f+Vl64Q=;
        b=rFmv7fkeTUwcmkTbHko7ixkpeOYt1erZ660zy4PC44GyR4JySIJLmHjzeXVeqSSTa8g75O
        obwToQcbLgiIDo2X/BrFmzvm4oC/7JL3Ts+oxIG8phrh16XsQyqPsNTi2SA0dCUtlb9tfj
        0pWXtOBXfugDOcIM0sKnP5j3ESYxsomYzQLnVVgWkj8vU4Dl9n1bD6aey0ogKhhluu+qlh
        ab2FyryH1c91vxtthnMSbJJTpjD0MwZbsAb8VWMXD74+CYE8+dAaatfM6RQoJurAfNRGM7
        OoecMIXCMXOOACXzhzP0Scp7aOVAIvdP1ovnFvvH2dJai2kCnuqx9AXAGXujAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659996407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Oxa9FbXBAyCLs+gSoIQzd4uxUIi4HukgoLd8f+Vl64Q=;
        b=wSEKCQpUR0KvXJND61i+Wr6gKtGbTQt/PS+6LmfCaQGN7sjxpqK/boil2Xu1Gnk5dJnWfa
        DvGLq1fu1EY0bmAA==
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [git pull] vfs.git pile 3 - dcache
In-Reply-To: <CAHk-=wh6VSqsnANHkQpw=yD-Hkt90Y1LX=ad9+r+SusfriUOfA@mail.gmail.com>
References: <YurA3aSb4GRr4wlW@ZenIV>
 <CAHk-=wizUgMbZKnOjvyeZT5E+WZM0sV+zS5Qxt84wp=BsRk3eQ@mail.gmail.com>
 <YuruqoGHJONpdZcK@home.goodmis.org>
 <CAHk-=whJvgykcTnR+BMJNwd+me5wvg+CxjSBeiPYTR1B2g5NpQ@mail.gmail.com>
 <20220803185936.228dc690@gandalf.local.home>
 <YusDmF39ykDmfSkF@casper.infradead.org>
 <CAHk-=wh6VSqsnANHkQpw=yD-Hkt90Y1LX=ad9+r+SusfriUOfA@mail.gmail.com>
Date:   Tue, 09 Aug 2022 00:06:47 +0200
Message-ID: <8735e6qtjc.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 03 2022 at 16:42, Linus Torvalds wrote:
> On Wed, Aug 3, 2022 at 4:24 PM Matthew Wilcox <willy@infradead.org> wrote:
>> On Wed, Aug 03, 2022 at 06:59:36PM -0400, Steven Rostedt wrote:
>> >
>> >       preempt_disable_inlock() ?
>>
>> preempt_disable_locked()?
>
> Heh. Shed painting in full glory.
>
> Let's try just "preempt_enable_under_spinlock()" and see.
>
> It's a bit long, but it's still shorter than the existing usage pattern.
>
> And we don't have "inlock" anywhere else, and while "locked" is a real
> pattern we have, it tends to be about other things (ie "I hold the
> lock that you need, so don't take it").
>
> And this is _explicitly_ only about spinning locks, because sleeping
> locks don't do the preemption disable even without RT.
>
> So let's make it verbose and clear and unambiguous. It's not like I
> expect to see a _lot_ of those. Knock wood.
>
> We had a handful of those things before (in mm/vmstat, and now added
> another case to the dentry code. So it has become a pattern, but I
> really really hope it's not exactly a common pattern.
>
> And so because it's not common, typing a bit more is a good idea - and
> making it really clear is probably also a good idea.

Sebastian and me looked over it.

The use cases in mm/vmstat are not really all under spinlocks. That code
gets called also just from plain local_irq or even just preempt disabled
regions (depending on the stats item), which makes the proposed name
less accurate than you describe.

A worse case is the u64_stat code which is an ifdef maze (only partially
due to RT). Those stats updates can also be called from various contexts
where no spinlock is involved. That code is extra convoluted due to
irqsave variants and "optimizations" for 32bit UP. Removing the latter
would make a cleanup with write_seqcount_...() wrappers pretty simple.

Aside of that we have RT conditional preempt related code in
page_alloc() and kmap_atomic(). Both care only about the task staying
pinned on a CPU. In page_alloc() using preempt_disable() on !RT is more
lightweight than migrate_disable(). So something like
task_[un]pin_temporary() might work and be descriptive enough.

For kmap_atomic() it was decided back then when we introduced
kmap_local() that we don't do a wholesale conversion and leave it to the
maintainers/developers to look at it on a case by case basis as that has
quite some cleanup potential at the call sites. 18 month later we still
have 435 of the back then 527 call sites. Sadly enough there are 21 new
instances vs. 71 removed and about 20 related cleanup patches ignored.

So either we come up with something generic or we just resort to
different wrappers for those use cases. I'll have another look with
Sebastian tomorrow.

Thoughts?

Thanks,

        tglx




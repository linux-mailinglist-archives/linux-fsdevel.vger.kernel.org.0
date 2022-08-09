Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC51F58DB81
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Aug 2022 18:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244829AbiHIQAY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Aug 2022 12:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239710AbiHIQAV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Aug 2022 12:00:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B61755BC;
        Tue,  9 Aug 2022 09:00:19 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660060818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L9r9MOVAj8MKHCAq79NOtPieAWBsbGLFctDFVM6g7z8=;
        b=qPYW1pEzUi28p5FWVEQxaCUjpB5OMAG9S7oCWfHAn0rKb7xPJC3Srsi3UjjEb4RLCCpVb2
        c99oKZeMLpPKXtyMhXXlNbOxRNAZmdgyxcJXBz7UMO0+z5pudhPq4YHnXL7+SymIki4LbH
        W37tTNoVJckI7sM/JQJUDpxGNAE8cd6PXdlqEOS8Hdgq5DebzLr9f7mYrugQKdLKiCtqP0
        pJSVc5yhN6IePpokC248ezgZbnvkv18bPl6gizv6eai+WyZ6jAQVn0CVHgTZMDqqebkWAk
        Bz7h6e1OgJg+HDnMwtMZK68/7D9cYbA/xPk64NWmmbtHGFSn/Tok0WKyJFBqvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660060818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L9r9MOVAj8MKHCAq79NOtPieAWBsbGLFctDFVM6g7z8=;
        b=4QI8OVCtbDr3y/VvM/MSvW/1X99yGUSW28OL1MXOlnphaxU5zBIyLX0OPKWx12zuYLZBQ2
        OiR0FpLsPB9/GoCA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [git pull] vfs.git pile 3 - dcache
In-Reply-To: <CAHk-=wi1z8h=hcAhZ0hx9UNxWXzWFFrd-z3ZgwM5mxhNQjPHDw@mail.gmail.com>
References: <YurA3aSb4GRr4wlW@ZenIV>
 <CAHk-=wizUgMbZKnOjvyeZT5E+WZM0sV+zS5Qxt84wp=BsRk3eQ@mail.gmail.com>
 <YuruqoGHJONpdZcK@home.goodmis.org>
 <CAHk-=whJvgykcTnR+BMJNwd+me5wvg+CxjSBeiPYTR1B2g5NpQ@mail.gmail.com>
 <20220803185936.228dc690@gandalf.local.home>
 <YusDmF39ykDmfSkF@casper.infradead.org>
 <CAHk-=wh6VSqsnANHkQpw=yD-Hkt90Y1LX=ad9+r+SusfriUOfA@mail.gmail.com>
 <8735e6qtjc.ffs@tglx>
 <CAHk-=wi1z8h=hcAhZ0hx9UNxWXzWFFrd-z3ZgwM5mxhNQjPHDw@mail.gmail.com>
Date:   Tue, 09 Aug 2022 18:00:17 +0200
Message-ID: <87v8r1quem.ffs@tglx>
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

Linus,

On Mon, Aug 08 2022 at 15:43, Linus Torvalds wrote:
> On Mon, Aug 8, 2022 at 3:06 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> The use cases in mm/vmstat are not really all under spinlocks. That code
>> gets called also just from plain local_irq or even just preempt disabled
>> regions (depending on the stats item), which makes the proposed name
>> less accurate than you describe.
>
> Augh.
>
> How about "preempt_disable_nested()" with a big comment about how some
> operations normally disable preemption (interrupts off, spinlocks,
> anything else?) but not on PREEMPT_RT?

Let me do that.

>> A worse case is the u64_stat code which is an ifdef maze (only partially
>> due to RT). Those stats updates can also be called from various contexts
>> where no spinlock is involved. That code is extra convoluted due to
>> irqsave variants and "optimizations" for 32bit UP. Removing the latter
>> would make a cleanup with write_seqcount_...() wrappers pretty simple.
>
> I think we most definitely can start removing optimisations for 32-bit
> UP by now.
>
> Let's not do them without any reason, but any time you hit a code that
> makes you go "this makes it harder to do better", feel free to go all
> Alexander the Great on the 32-bit UP code and just cut through the
> problem by removing it.

With that mopped up:

 1 file changed, 42 insertions(+), 84 deletions(-)

plus a followup cleanup of the then not longer required
_irqsave/restore() variants:

 8 files changed, 33 insertions(+), 62 deletions(-)

is not a Great conquest, but makes the code definitely readable.

The fetch/retry_irq() variants are then obsolete as well, but that's just
a rename in 70 files and the removal of the two helpers.

>> Aside of that we have RT conditional preempt related code in
>> page_alloc() and kmap_atomic(). Both care only about the task staying
>> pinned on a CPU. In page_alloc() using preempt_disable() on !RT is more
>> lightweight than migrate_disable(). So something like
>> task_[un]pin_temporary() might work and be descriptive enough.
>
> Yeah, that was the other odd pattern. I'm not sure "temporary" is all
> that relevant, but yes, if we end up having more of those, some kind
> of "thread_{un]pin_cpu()" would probably be worth it.
>
> But the kmap code may be so special that nothing else has _that_
> particular issue.

We just want to get rid of kmap_atomic() completely. I'll go and find
minions.

Thanks,

        tglx

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E659422B6FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jul 2020 21:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgGWTxY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jul 2020 15:53:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60814 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgGWTxY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jul 2020 15:53:24 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595534000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X0c32+NIatB9JM6CXey+0z41GiQlbz97j0f7TqXtlAY=;
        b=uFXjXbf4Yp8aNwTNbxJjHuHwYks2TWbYKgxnG7Jr1JWxhF+duZctOadDtngKL2Pntdlcr5
        AvKP6qpAvouuuiV9yCUIMDIlbTkuWxZoD7TQabGmbTA0mjtTK30eJeHRVEjwqxpk03fPUS
        tTHuvjt5xvqU5prBd0+EqsNeg67IAnB6WbSAufCh1h3bnSTSGxuR6+oxKhzw+WygKCqZiO
        DzSskQq90BXIC5ugNwOtkIPpZNUuGtTQ2f/N1n2GVcGCN+TQeOR0jfxYFV4o6wzageqeaB
        yb7Im752qEUzAhYy4YEc/rgs/zaCt1/1hFkXqJTndrZAWzomDhEhunfLRUOtbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595534000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X0c32+NIatB9JM6CXey+0z41GiQlbz97j0f7TqXtlAY=;
        b=IP9QMcXa1ApuQm3+KZmrUmtJj6z7QxJxyk9fPf+kLhbrZgzz7HlWKdlTZhcyEP2iMZoUqw
        PGdJS5nkBsmndqAQ==
To:     ira.weiny@intel.com, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC V2 17/17] x86/entry: Preserve PKRS MSR across exceptions
In-Reply-To: <20200717072056.73134-18-ira.weiny@intel.com>
References: <20200717072056.73134-1-ira.weiny@intel.com> <20200717072056.73134-18-ira.weiny@intel.com>
Date:   Thu, 23 Jul 2020 21:53:20 +0200
Message-ID: <87r1t2vwi7.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ira,

ira.weiny@intel.com writes:

> ...
> 	// ref == 0
> 	dev_access_enable()  // ref += 1 ==> disable protection
> 		irq()
> 			// enable protection
> 			// ref = 0
> 			_handler()
> 				dev_access_enable()   // ref += 1 ==> disable protection
> 				dev_access_disable()  // ref -= 1 ==> enable protection
> 			// WARN_ON(ref != 0)
> 			// disable protection
> 	do_pmem_thing()  // all good here
> 	dev_access_disable() // ref -= 1 ==> 0 ==> enable protection

...

> First I'm not sure if adding this state to idtentry_state and having
> that state copied is the right way to go.

Adding the state to idtentry_state is fine at least for most interrupts
and exceptions. Emphasis on most.

#PF does not work because #PF can schedule.

> It seems like we should start passing this by reference instead of
> value.  But for now this works as an RFC.  Comments?

Works as in compiles, right?

static void noinstr idt_save_pkrs(idtentry_state_t state)
{
        state.foo = 1;
}

How is that supposed to change the caller state? C programming basics.

> Second, I'm not 100% happy with having to save the reference count in
> the exception handler.  It seems like a very ugly layering violation but
> I don't see a way around it at the moment.

That state is strict per task, right? So why do you want to store it
anywhere else that in task/thread storage. That solves your problem of
#PF scheduling nicely.

> Third, this patch has gone through a couple of revisions as I've had
> crashes which just don't make sense to me.  One particular issue I've
> had is taking a MCE during memcpy_mcsafe causing my WARN_ON() to fire.
> The code path was a pmem copy and the ref count should have been
> elevated due to dev_access_enable() but why was
> idtentry_enter()->idt_save_pkrs() not called I don't know.

Because #MC does not go through idtentry_enter(). Neither do #NMI, #DB, #BP.

> Finally, it looks like the entry/exit code is being refactored into
> common code.  So likely this is best handled somewhat there.  Because
> this can be predicated on CONFIG_ARCH_HAS_SUPERVISOR_PKEYS and handled
> in a generic fashion.  But that is a ways off I think.

The invocation of save/restore might be placed in generic code at least
for the common exception and interrupt entries.

> +static void noinstr idt_save_pkrs(idtentry_state_t state)

*state. See above.

> +#else
> +/* Define as macros to prevent conflict of inline and noinstr */
> +#define idt_save_pkrs(state)
> +#define idt_restore_pkrs(state)

Empty inlines do not need noinstr because they are optimized out. If you
want inlines in a noinstr section then use __always_inline

>  /**
>   * idtentry_enter - Handle state tracking on ordinary idtentries
>   * @regs:	Pointer to pt_regs of interrupted context
> @@ -604,6 +671,8 @@ idtentry_state_t noinstr idtentry_enter(struct pt_regs *regs)
>  		return ret;
>  	}
>  
> +	idt_save_pkrs(ret);

No. This really has no business to be called before the state is
established. It's not something horribly urgent and write_pkrs() is NOT
noinstr and invokes wrmsrl() which is subject to tracing.

> +
> +	idt_restore_pkrs(state);

This one is placed correctly.

Thanks,

        tglx

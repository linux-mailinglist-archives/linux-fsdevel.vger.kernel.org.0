Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02FCA40B04D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 16:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbhINOMv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 10:12:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33752 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbhINOMn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:12:43 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631628681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gagDSUKwMCHaMEiqubvQ+CuzRTxSq9sAGecdpVTXNXo=;
        b=wAC23Vdi+/3pgXFQ+EH2vjnxHmtInT5MgK0Qv1/cnB40ERcGms2zFiQPteZutf2tvX7JaR
        vHH2RCHDvH6cNn0QcgBA6VlaN1wTaIlbPsxL0avm616HDUX2FLIkajg7u5buXHWEJeTdbn
        k3xeIAvT4sBhWivZf0qpES/oJQKjAvaVNT5gXPHXx+Yo8cW94vr13ZU8sdgmgkGAHRehT2
        mSFCQaQoNzjadKvJEpBWgLguv84/g2KE6UuWFrWABvJcq+adOvkZU8l1XcSJEFdm2OBIUE
        ZVDiMe2YZLcIRcpTlvQs9ODHinZ2+h07XNyXahZhzdv8d77b6oHDPWe9nStBrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631628681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gagDSUKwMCHaMEiqubvQ+CuzRTxSq9sAGecdpVTXNXo=;
        b=6p9G3UdzwjHnsfv6oqF70n2N0Khx7/ccUId7dYB0XZr9smPMx0lfMHYd6ReQs3SOXIOhRc
        QaJnnEx/OFgN4TDQ==
To:     Alexei Lozovsky <me@ilammy.net>,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/7] proc/stat: Maintain monotonicity of "intr" and
 "softirq"
In-Reply-To: <44F84890-521F-4BCA-9F48-B49D2C8A9E32@ilammy.net>
References: <06F4B1B0-E4DE-4380-A8E1-A5ACAD285163@ilammy.net>
 <20210911034808.24252-1-me@ilammy.net>
 <YT3In8SWc2eYZ/09@localhost.localdomain>
 <44F84890-521F-4BCA-9F48-B49D2C8A9E32@ilammy.net>
Date:   Tue, 14 Sep 2021 16:11:21 +0200
Message-ID: <87y27zb62e.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 12 2021 at 21:37, Alexei Lozovsky wrote:
> On Sun, Sep 12, 2021, at 18:30, Alexey Dobriyan wrote:
>> How about making everything "unsigned long" or even "u64" like NIC
>> drivers do?
>
> I see some possible hurdles ahead:
>
> - Not all architectures have atomic operations for 64-bit values

This is not about atomics.

>   All those "unsigned int" counters are incremented with __this_cpu_inc()
>   which tries to use atomics if possible. Though, I'm not quite sure

It does not use atomics. It's a CPU local increment.

>   how this works for read side which does not seem to use atomic reads
>   at all. I guess, just by the virtue of properly aligned 32-bit reads
>   being atomic everywhere? If that's so, I think widening counters to
>   64 bits will come with an asterisk.

The stats are accumulated racy, i.e. the interrupt might be handled and
one of the per cpu counters or irq_desc->tot_count might be incremented
concurrently.

On 32bit systems a 32bit load (as long as the compiler does not emit
load tearing) is always consistent even when there is a concurrent
increment going on. It either gets the old or the new value.

A 64bit read on a 32bit system is always two loads which means that a
concurrent increment will make it possible to observe a half updated
value. And no, you can't play reread tricks here without adding barriers
on weakly ordered architectures.

> - We'll need to update all counters to be 64-bit.
>
>   Like, *everyone*. Every field that gets summed up needs to be 64-bit
>   (or else wrap-arounds will be incorrect). Basically every counter in
>   every irq_cpustat_t will need to become twice as wide. If that's
>   a fine price to pay for accurate, full-width counters...

The storage size should not be a problem.

> So right now I don't see why it shouldn't be doable in theory.

So much for the theory :)

Thanks,

        tglx

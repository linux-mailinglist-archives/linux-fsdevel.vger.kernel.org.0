Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB1623A9FB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 17:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgHCP5O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 11:57:14 -0400
Received: from linux.microsoft.com ([13.77.154.182]:42848 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgHCP5O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 11:57:14 -0400
Received: from [192.168.254.32] (unknown [47.187.206.220])
        by linux.microsoft.com (Postfix) with ESMTPSA id CC1CC20B4908;
        Mon,  3 Aug 2020 08:57:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CC1CC20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596470233;
        bh=B84BScSs7K0//hJ9cYUzqCUYQtbCiiAWgLTuQ5Ph+RQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GJf0dTtzCa8o8nzBmlcmO+m4jvGBEduNpvn6rNHY16DZPJb8hqSD/6aHy2OPigkFd
         evDzXsdzFZk3yChasnyS7SjYhR4fSIf5geRNzZvB4V4J1D4UB/gYfSQTzo2+RbNkDd
         w7n1jOQ1OCcqAgvwmAvXOwhZDHKSoOh+5vCEa2n0=
Subject: Re: [PATCH v1 0/4] [RFC] Implement Trampoline File Descriptor
To:     David Laight <David.Laight@ACULAB.COM>,
        'Pavel Machek' <pavel@ucw.cz>
Cc:     'Andy Lutomirski' <luto@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, X86 ML <x86@kernel.org>
References: <20200728131050.24443-1-madvenka@linux.microsoft.com>
 <CALCETrVy5OMuUx04-wWk9FJbSxkrT2vMfN_kANinudrDwC4Cig@mail.gmail.com>
 <b9879beef3e740c0aeb1af73485069a8@AcuMS.aculab.com>
 <20200802115600.GB1162@bug>
 <c02fbae7a0754a58884b370657575845@AcuMS.aculab.com>
From:   "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Message-ID: <06e4cfc7-f1d5-5311-2e1c-603cf408c9f7@linux.microsoft.com>
Date:   Mon, 3 Aug 2020 10:57:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c02fbae7a0754a58884b370657575845@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/3/20 3:08 AM, David Laight wrote:
> From: Pavel Machek <pavel@ucw.cz>
>> Sent: 02 August 2020 12:56
>> Hi!
>>
>>>> This is quite clever, but now I???m wondering just how much kernel help
>>>> is really needed. In your series, the trampoline is an non-executable
>>>> page.  I can think of at least two alternative approaches, and I'd
>>>> like to know the pros and cons.
>>>>
>>>> 1. Entirely userspace: a return trampoline would be something like:
>>>>
>>>> 1:
>>>> pushq %rax
>>>> pushq %rbc
>>>> pushq %rcx
>>>> ...
>>>> pushq %r15
>>>> movq %rsp, %rdi # pointer to saved regs
>>>> leaq 1b(%rip), %rsi # pointer to the trampoline itself
>>>> callq trampoline_handler # see below
>>> For nested calls (where the trampoline needs to pass the
>>> original stack frame to the nested function) I think you
>>> just need a page full of:
>>> 	mov	$0, scratch_reg; jmp trampoline_handler
>> I believe you could do with mov %pc, scratch_reg; jmp ...
>>
>> That has advantage of being able to share single physical
>> page across multiple virtual pages...
> A lot of architecture don't let you copy %pc that way so you would
> have to use 'call' - but that trashes the return address cache.
> It also needs the trampoline handler to know the addresses
> of the trampolines.

Do you which ones don't allow you to copy %pc?

Some of the architctures do not have PC-relative data references.
If they do not allow you to copy the PC into a general purpose
register, then there is no way to implement the statically defined
trampoline that has been discussed so far. In these cases, the
trampoline has to be generate at runtime.

Thanks.

Madhavan


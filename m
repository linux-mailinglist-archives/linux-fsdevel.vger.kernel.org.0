Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77BEB23AA08
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 17:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgHCP7G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 11:59:06 -0400
Received: from linux.microsoft.com ([13.77.154.182]:43092 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgHCP7G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 11:59:06 -0400
Received: from [192.168.254.32] (unknown [47.187.206.220])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0B58220B4908;
        Mon,  3 Aug 2020 08:59:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0B58220B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596470345;
        bh=61JblHzq4qhtQkPzj2G3tGZ75oReI0NIx105fosLKrI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CmZKNOH/KALtRXbeh0M5SY5+FforFJaVBEotq9VkjW4009Y9gJ4Y8SiPFK60B63Ek
         PKT5VksgRHxxB2UeKRaW8GTHJZ0qNSXo3Bv3a1oHMYNew4GGXbm8WZ2IzEPQtDPc28
         jbSZxdwUc01p8o/CYVhWcBeeqUmlISxGx9Y/uaWA=
Subject: Re: [PATCH v1 0/4] [RFC] Implement Trampoline File Descriptor
To:     David Laight <David.Laight@ACULAB.COM>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, X86 ML <x86@kernel.org>
References: <20200728131050.24443-1-madvenka@linux.microsoft.com>
 <CALCETrVy5OMuUx04-wWk9FJbSxkrT2vMfN_kANinudrDwC4Cig@mail.gmail.com>
 <3b916198-3a98-bd19-9a1c-f2d8d44febe8@linux.microsoft.com>
 <a5fb2778a86f45b58ef5dd35228d950b@AcuMS.aculab.com>
From:   "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Message-ID: <8f938da2-a10d-ca15-56f0-70315c678771@linux.microsoft.com>
Date:   Mon, 3 Aug 2020 10:59:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a5fb2778a86f45b58ef5dd35228d950b@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/3/20 3:23 AM, David Laight wrote:
> From: Madhavan T. Venkataraman
>> Sent: 02 August 2020 19:55
>> To: Andy Lutomirski <luto@kernel.org>
>> Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>; Linux API <linux-api@vger.kernel.org>;
>> linux-arm-kernel <linux-arm-kernel@lists.infradead.org>; Linux FS Devel <linux-
>> fsdevel@vger.kernel.org>; linux-integrity <linux-integrity@vger.kernel.org>; LKML <linux-
>> kernel@vger.kernel.org>; LSM List <linux-security-module@vger.kernel.org>; Oleg Nesterov
>> <oleg@redhat.com>; X86 ML <x86@kernel.org>
>> Subject: Re: [PATCH v1 0/4] [RFC] Implement Trampoline File Descriptor
>>
>> More responses inline..
>>
>> On 7/28/20 12:31 PM, Andy Lutomirski wrote:
>>>> On Jul 28, 2020, at 6:11 AM, madvenka@linux.microsoft.com wrote:
>>>>
>>>> ﻿From: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
>>>>
>>> 2. Use existing kernel functionality.  Raise a signal, modify the
>>> state, and return from the signal.  This is very flexible and may not
>>> be all that much slower than trampfd.
>> Let me understand this. You are saying that the trampoline code
>> would raise a signal and, in the signal handler, set up the context
>> so that when the signal handler returns, we end up in the target
>> function with the context correctly set up. And, this trampoline code
>> can be generated statically at build time so that there are no
>> security issues using it.
>>
>> Have I understood your suggestion correctly?
> I was thinking that you'd just let the 'not executable' page fault
> signal happen (SIGSEGV?) when the code jumps to on-stack trampoline
> is executed.
>
> The user signal handler can then decode the faulting instruction
> and, if it matches the expected on-stack trampoline, modify the
> saved registers before returning from the signal.
>
> No kernel changes and all you need to add to the program is
> an architecture-dependant signal handler.

Understood.

Madhavan

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C61276139
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 21:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgIWTlJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 15:41:09 -0400
Received: from linux.microsoft.com ([13.77.154.182]:50450 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgIWTlH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 15:41:07 -0400
Received: from [192.168.254.38] (unknown [47.187.206.220])
        by linux.microsoft.com (Postfix) with ESMTPSA id 24DE220B7179;
        Wed, 23 Sep 2020 12:41:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 24DE220B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1600890066;
        bh=SHLv6M19mTEA3Q+HMwGO2d17v134ff6kOkHWg2oExmk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kGXISa+fmD0BCDpEQnnCH9Pq25TnzBLU7eNC7j4udIn/khcedGMZt32Iq7JAPGchg
         luAP/WHcUq9x1xW1/50YFmrTM0/nW5osVqFkqlgScNmlE+wnu2v0ZixY9PaCUGo0Y4
         MRQIBAlfv+g5G8+XBslF45bPRw9XRky7bkjKl3Bc=
Subject: Re: [PATCH v2 0/4] [RFC] Implement Trampoline File Descriptor
To:     Solar Designer <solar@openwall.com>, Pavel Machek <pavel@ucw.cz>
Cc:     kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, oleg@redhat.com,
        x86@kernel.org, luto@kernel.org, David.Laight@ACULAB.COM,
        fweimer@redhat.com, mark.rutland@arm.com, mic@digikod.net,
        Rich Felker <dalias@libc.org>
References: <20200922215326.4603-1-madvenka@linux.microsoft.com>
 <20200923081426.GA30279@amd> <20200923091456.GA6177@openwall.com>
From:   "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Message-ID: <1c3acf03-94af-1d5e-00c6-d874ee0ef330@linux.microsoft.com>
Date:   Wed, 23 Sep 2020 14:41:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200923091456.GA6177@openwall.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/23/20 4:14 AM, Solar Designer wrote:
>>> The W^X implementation today is not complete. There exist many user level
>>> tricks that can be used to load and execute dynamic code. E.g.,
>>>
>>> - Load the code into a file and map the file with R-X.
>>>
>>> - Load the code in an RW- page. Change the permissions to R--. Then,
>>>   change the permissions to R-X.
>>>
>>> - Load the code in an RW- page. Remap the page with R-X to get a separate
>>>   mapping to the same underlying physical page.
>>>
>>> IMO, these are all security holes as an attacker can exploit them to inject
>>> his own code.
>> IMO, you are smoking crack^H^H very seriously misunderstanding what
>> W^X is supposed to protect from.
>>
>> W^X is not supposed to protect you from attackers that can already do
>> system calls. So loading code into a file then mapping the file as R-X
>> is in no way security hole in W^X.
>>
>> If you want to provide protection from attackers that _can_ do system
>> calls, fine, but please don't talk about W^X and please specify what
>> types of attacks you want to prevent and why that's good thing.
> On one hand, Pavel is absolutely right.  It is ridiculous to say that
> "these are all security holes as an attacker can exploit them to inject
> his own code."
> 

Why? Isn't it possible that an attacker can exploit some vulnerability such
as buffer overflow and overwrite the buffer that contains the dynamic code?


> On the other hand, "what W^X is supposed to protect from" depends on how
> the term W^X is defined (historically, by PaX and OpenBSD).  It may be
> that W^X is partially not a feature to defeat attacks per se, but also a
> policy enforcement feature preventing use of dangerous techniques (JIT).
> 
> Such policy might or might not make sense.  It might make sense for ease
> of reasoning, e.g. "I've flipped this setting, and now I'm certain the
> system doesn't have JIT within a process (can still have it through
> dynamically creating and invoking an entire new program), so there are
> no opportunities for an attacker to inject code nor generate previously
> non-existing ROP gadgets into an executable mapping within a process."
> 
> I do find it questionable whether such policy and such reasoning make
> sense beyond academia.
> 
> Then, there might be even more ways in which W^X is not perfect enough
> to enable such reasoning.  What about using ptrace(2) to inject code?
> Should enabling W^X also disable ability to debug programs by non-root?
> We already have Yama ptrace_scope, which can achieve that at the highest
> setting, although that's rather inconvenient and is probably unexpected
> by most to be a requirement for having (ridiculously?) full W^X allowing
> for the academic reasoning.
> 

I am not suggesting that W^X be fixed. That is up to the maintainers of that
code. I am saying that if the security subsystem is enhanced in the future with
policies and settings that prevent the user tricks I mentioned, then it becomes
impossible to execute dynamic code except by making security exceptions on a case
by case basis.

As an alternative to making security exceptions, one could convert dynamic code
to static code which can then be authenticated.

> Personally, I am for policies that make more practical sense.  For
> example, years ago I advocated here on kernel-hardening that we should
> have a mode where ELF flags enabling/disabling executable stack are
> ignored, and non-executable stack is always enforced.  This should also
> be extended to default (at program startup) permissions on more than
> just stack (but also on .bss, typical libcs' heap allocations, etc.)
> However, I am not convinced there's enough value in extending the policy
> to restricting explicit uses of mprotect(2).
> 
> Yes, PaX did that, and its emutramp.txt said "runtime code generation is
> by its nature incompatible with PaX's PAGEEXEC/SEGMEXEC and MPROTECT
> features, therefore the real solution is not in emulation but by
> designing a kernel API for runtime code generation and modifying
> userland to make use of it."  However, not being convinced in the
> MPROTECT feature having enough practical value, I am also not convinced
> "a kernel API for runtime code generation and modifying userland to make
> use of it" is the way to go.
> 

In a separate email, I will try to answer this and provide justification
for why it is better to do it in the kernel.

> Having static instead of dynamically-generated trampolines in userland
> code where possible (and making other userland/ABI changes to make that
> possible in more/all cases) is an obvious improvement, and IMO should be
> a priority over the above.
>

> While I share my opinion here, I don't mean that to block Madhavan's
> work.  I'd rather defer to people more knowledgeable in current userland
> and ABI issues/limitations and plans on dealing with those, especially
> to Florian Weimer.  I haven't seen Florian say anything specific for or
> against Madhavan's proposal, and I'd like to.  (Have I missed that?)
> It'd be wrong to introduce a kernel API that userland doesn't need, and
> it'd be right to introduce one that userland actually intends to use.
> 
> I've also added Rich Felker to CC here, for musl libc and its possible
> intent to use the proposed API.  (My guess is there's no such need, and
> thus no intent, but Rich might want to confirm that or correct me.)
> 
> Alexander

Madhavan

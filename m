Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8709C242EA5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 20:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgHLSrj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 14:47:39 -0400
Received: from linux.microsoft.com ([13.77.154.182]:46110 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgHLSri (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 14:47:38 -0400
Received: from [192.168.254.32] (unknown [47.187.206.220])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9B3FF20B4908;
        Wed, 12 Aug 2020 11:47:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9B3FF20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597258056;
        bh=ZEYJ2skMtGmgwMikDvI3uIWWgJOx/B8qnK+vU4Qzxfs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lglW0NETwS/sXrB4/K4MPBOK8R2Ar9WMk5JjHbAx93S7Ot8eDgoXiDoFR1CsUeIlR
         +1mTZkcYO4PWflsNOqdNmk00M1NDxBnFedUApWhrRyj3nVl41/nw29KYBqi596QwW5
         8Qp8XRV6IFf4T7w3Pq6k8K/kwHXpfh+WyRhdHYoE=
Subject: Re: [PATCH v1 0/4] [RFC] Implement Trampoline File Descriptor
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, oleg@redhat.com,
        x86@kernel.org
References: <aefc85852ea518982e74b233e11e16d2e707bc32>
 <20200728131050.24443-1-madvenka@linux.microsoft.com>
 <20200731180955.GC67415@C02TD0UTHF1T.local>
 <6236adf7-4bed-534e-0956-fddab4fd96b6@linux.microsoft.com>
 <20200804143018.GB7440@C02TD0UTHF1T.local>
 <b3368692-afe6-89b5-d634-12f4f0a601f8@linux.microsoft.com>
 <20200812100650.GB28154@C02TD0UTHF1T.local>
From:   "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Message-ID: <b05f16a9-d5c2-cdce-0905-f9881a9d9922@linux.microsoft.com>
Date:   Wed, 12 Aug 2020 13:47:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200812100650.GB28154@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/12/20 5:06 AM, Mark Rutland wrote:
> [..]
>>
>> The general principle of the mitigation is W^X. I would argue that
>> the above options are violations of the W^X principle. If they are
>> allowed today, they must be fixed. And they will be. So, we cannot
>> rely on them.
> 
> Hold on.
> 
> Contemporary W^X means that a given virtual alias cannot be writeable
> and executeable simultaneously, permitting (a) and (b). If you read the
> references on the Wikipedia page for W^X you'll see the OpenBSD 3.3
> release notes and related presentation make this clear, and further they
> expect (b) to occur with JITS flipping W/X with mprotect().
> 
> Please don't conflate your assumed stronger semantics with the general
> principle. It not matching you expectations does not necessarily mean
> that it is wrong.
> 
> If you want a stronger W^X semantics, please refer to this specifically
> with a distinct name.

OK. Fair enough. We can give a different name to the stronger requirement.
Just for the sake of this discussion and for the want of a better name,
let us call it WX2.


> 
>> a) This requires a remap operation. Two mappings point to the same
>>      physical page. One mapping has W and the other one has X. This
>>      is a violation of W^X.
>>
>> b) This is again a violation. The kernel should refuse to give execute
>>      permission to a page that was writeable in the past and refuse to
>>      give write permission to a page that was executable in the past.
>>
>> c) This is just a variation of (a).
> 
> As above, this is not true.
> 
> If you have a rationale for why this is desirable or necessary, please
> justify that before using this as justification for additional features.
> 

I already supplied the justification. Any user level method can potentially
be hijacked by an attacker for his purpose.

WX does not prevent all of the methods. We need WX2.


>> In general, the problem with user-level methods to map and execute
>> dynamic code is that the kernel cannot tell if a genuine application is
>> using them or an attacker is using them or piggy-backing on them.
> 
> Yes, and as I pointed out the same is true for trampfd unless you can
> somehow authenticate the calls are legitimate (in both callsite and the
> set of arguments), and I don't see any reasonable way of doing that.
> 

I am afraid I am not in agreement with this. If WX2 is not implemented,
an attacker can hack both code and data. If WX2 is implemented, an attacker
can only attack data. The attack surface is reduced.

Also, trampfd calls coming from code from a signed file can be authenticated.
trampfd calls coming from an attacker's generated code cannot be authenticated.


> If you relax your threat model to an attacker not being able to make
> arbitrary syscalls, then your suggestion that userspace can perorm
> chceks between syscalls may be sufficient, but as I pointed out that's
> equally true for a sealed memfd or similar.
> 

Actually, I did not suggest that userspace can perform checks. I said that
the kernel can perform checks.

User space cannot reliably perform checks between calls. A clever hacker
can cover his tracks.

In any case, the kernel has no knowledge of these checks. So, when execute
permissions are requested for a page, a properly implemented WX2 can refuse.


>> Off the top of my head, I have tried to identify some examples
>> where we can have more trust on dynamic code and have the kernel
>> permit its execution.
>>
>> 1. If the kernel can do the job, then that is one safe way. Here, the kernel
>>     is the code. There is no code generation involved. This is what I
>>     have presented in the patch series as the first cut.
> 
> This is sleight-of-hand; it doesn't matter where the logic is performed
> if the power is identical. Practically speaking this is equivalent to
> some dynamic code generation.
> 
> I think that it's misleading to say that because the kernel emulates
> something it is safe when the provenance of the syscall arguments cannot
> be verified.


I submit that there are two aspects - code and data. In one case, both
code and data can be hacked. So, an attacker can modify both code
and data. In the other case, the attacker can only modify data.
The power is not identical. The attack surface is not the same.

Most of the times, security measures are mitigations. They are not a 100%.
This approach of not allowing the user to do certain things that can be
exploited and having the kernel doing them increases our confidence.
From that perspective, the two approaches are different and it is worth
pursuing a kernel based mitigation.


> 
> [...]
> 
>> Anyway, these are just examples. The principle is - if we can identify
>> dynamic code that has a certain measure of trust, can the kernel
>> permit their execution?
> 
> My point generally is that the kernel cannot identify this, and if
> usrspace code is trusted to dynamically generate trampfd arguments it
> can equally be trusted to dyncamilly generate code.

I am afraid not. See my previous response. Ability to hack only data
gives an attacker fewer options as compared to the ability to hack
both code and data.

> 
> [...]
> 
>> As I have mentioned above, I intend to have the kernel generate code
>> only if the code generation is simple enough. For more complicated cases,
>> I plan to use a user-level code generator that is for exclusive kernel use.
>> I have yet to work out the details on how this would work. Need time.
> 
> This reads to me like trampfd is only dealing with a few special cases
> and we know that we need a more general solution.
> 
> I hope I am mistaken, but I get the strong impression that you're trying
> to justify your existing solution rather than trying to understand the
> problem space.
> 

I do understand the problem space. I wanted to address dynamic code in 3
different ways in separate phases starting from the easiest and working
my way up to the more difficult ones.

1. Remove dynamic code where possible

   If the kernel can replace user level dynamic code, then do it.
   This is what I did in version 1.

2. Replace dynamic code with static code

   Where you cannot do (1), replace dynamic code with static code with
   the kernel's help. I wanted to do this later. But I have decided to
   do this in version 2. This combined with signature verification of
   files adds a measure or trust in the code.

3. Deal with JIT, DBT, etc

   In (1) and (2), we deal with machine code. In (3), there is some source
   from which dynamic code needs to be generated using a code generator.
   E.g., JIT code from Java byte code. Here, the solution I had in mind
   had two parts:

       - Make the source more trustworthy by requiring it to be part
         of a signed file
       - Design a code generator trusted and used exclusively by the kernel

In this patchset, I wanted to lay a foundation for all 3 and attempt to
solve (1) first. Once this was in place, I wanted to do (2) and then (3).

In retrospect, I should have probably started with the big picture first
instead of starting with just item (1). But I always had the big picture
in mind. That said, I did not necessarily have all the details fleshed
out for all the phases. (3) is complex.

My focus was to define the API in a generic enough fashion so that all
3 phases can be implemented. But I realize that it is a hard sell at this
point to convince people that the API is adequate for phase 3. So,
I have decided to do (1) and (2). (3) has to be done separately with
more thought and details put into it.

Also, it may be the case that there are some examples of dynamic code
out there than can never be addressed. My goal is to try to address a
majority of the dynamic code out there.


> To be clear, my strong opinion is that we should not be trying to do
> this sort of emulation or code generation within the kernel. I do think
> it's worthwhile to look at mechanisms to make it harder to subvert
> dynamic userspace code generation, but I think the code generation
> itself needs to live in userspace (e.g. for ABI reasons I previously
> mentioned).
> 

I completely agree that the kernel should not deal with the complexities
of code generation and ABI details. My version 1 did not have any code
generation. But since a performance issue was raised, I explored the idea
of kernel code generation. To be honest, I was not really that
comfortable with the idea.

That is why I have decided to implement the second piece I had in
my plan now. This piece does not have the code generation complexities
or ABI issues. This piece can be used to solve libffi, GCC, etc.
I will still write the code in such a way that I can use the first
approach in the future if I really need it. But it will not involve any
code generation from the kernel. It will only be used for cases that
don't mind the extra trip to the kernel.

Madhavan

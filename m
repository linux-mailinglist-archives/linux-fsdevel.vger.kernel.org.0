Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C5924A658
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Aug 2020 20:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgHSSyU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Aug 2020 14:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgHSSyT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:54:19 -0400
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [IPv6:2001:1600:3:17::8fab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A164C061342
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2020 11:54:17 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4BWxlD0kK1zlhQGJ;
        Wed, 19 Aug 2020 20:54:00 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4BWxlB6m3Xzlh8TC;
        Wed, 19 Aug 2020 20:53:58 +0200 (CEST)
Subject: Re: [PATCH v1 0/4] [RFC] Implement Trampoline File Descriptor
To:     Mark Rutland <mark.rutland@arm.com>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
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
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <41c4de64-68d0-6fcb-e5c3-63ebd459262e@digikod.net>
Date:   Wed, 19 Aug 2020 20:53:42 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <20200812100650.GB28154@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 12/08/2020 12:06, Mark Rutland wrote:
> On Thu, Aug 06, 2020 at 12:26:02PM -0500, Madhavan T. Venkataraman wrote:
>> Thanks for the lively discussion. I have tried to answer some of the
>> comments below.
>>
>> On 8/4/20 9:30 AM, Mark Rutland wrote:
>>>
>>>> So, the context is - if security settings in a system disallow a page to have
>>>> both write and execute permissions, how do you allow the execution of
>>>> genuine trampolines that are runtime generated and placed in a data
>>>> page or a stack page?
>>> There are options today, e.g.
>>>
>>> a) If the restriction is only per-alias, you can have distinct aliases
>>>    where one is writable and another is executable, and you can make it
>>>    hard to find the relationship between the two.
>>>
>>> b) If the restriction is only temporal, you can write instructions into
>>>    an RW- buffer, transition the buffer to R--, verify the buffer
>>>    contents, then transition it to --X.
>>>
>>> c) You can have two processes A and B where A generates instrucitons into
>>>    a buffer that (only) B can execute (where B may be restricted from
>>>    making syscalls like write, mprotect, etc).
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

W^X (with "permanent" mprotect restrictions [1]) goes back to 2000 with
PaX [2] (which predates partial OpenBSD implementation from 2003).

[1] https://pax.grsecurity.net/docs/mprotect.txt
[2] https://undeadly.org/cgi?action=article;sid=20030417082752

> 
> Please don't conflate your assumed stronger semantics with the general
> principle. It not matching you expectations does not necessarily mean
> that it is wrong.
> 
> If you want a stronger W^X semantics, please refer to this specifically
> with a distinct name.
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
>> In general, the problem with user-level methods to map and execute
>> dynamic code is that the kernel cannot tell if a genuine application is
>> using them or an attacker is using them or piggy-backing on them.
> 
> Yes, and as I pointed out the same is true for trampfd unless you can
> somehow authenticate the calls are legitimate (in both callsite and the
> set of arguments), and I don't see any reasonable way of doing that.
> 
> If you relax your threat model to an attacker not being able to make
> arbitrary syscalls, then your suggestion that userspace can perorm
> chceks between syscalls may be sufficient, but as I pointed out that's
> equally true for a sealed memfd or similar.
> 
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
> To be clear, my strong opinion is that we should not be trying to do
> this sort of emulation or code generation within the kernel. I do think
> it's worthwhile to look at mechanisms to make it harder to subvert
> dynamic userspace code generation, but I think the code generation
> itself needs to live in userspace (e.g. for ABI reasons I previously
> mentioned).
> 
> Mark.
> 

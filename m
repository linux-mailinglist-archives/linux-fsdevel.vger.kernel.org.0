Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E8C277713
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 18:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbgIXQpC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 12:45:02 -0400
Received: from smtp-42ac.mail.infomaniak.ch ([84.16.66.172]:47395 "EHLO
        smtp-42ac.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726645AbgIXQpC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 12:45:02 -0400
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4By19B01Y1zlhTqt;
        Thu, 24 Sep 2020 18:44:30 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4By1972FNszlh8Yx;
        Thu, 24 Sep 2020 18:44:27 +0200 (CEST)
Subject: Re: [PATCH v2 0/4] [RFC] Implement Trampoline File Descriptor
To:     Pavel Machek <pavel@ucw.cz>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Cc:     kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, oleg@redhat.com,
        x86@kernel.org, luto@kernel.org, David.Laight@ACULAB.COM,
        fweimer@redhat.com, mark.rutland@arm.com
References: <210d7cd762d5307c2aa1676705b392bd445f1baa>
 <20200922215326.4603-1-madvenka@linux.microsoft.com>
 <20200923084232.GB30279@amd>
 <34257bc9-173d-8ef9-0c97-fb6bd0f69ecb@linux.microsoft.com>
 <20200923205156.GA12034@duo.ucw.cz>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <c5ddf0c2-962a-f93a-e666-1c6f64482d97@digikod.net>
Date:   Thu, 24 Sep 2020 18:44:26 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <20200923205156.GA12034@duo.ucw.cz>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 23/09/2020 22:51, Pavel Machek wrote:
> Hi!
> 
>>>> Scenario 2
>>>> ----------
>>>>
>>>> We know what code we need in advance. User trampolines are a good example of
>>>> this. It is possible to define such code statically with some help from the
>>>> kernel.
>>>>
>>>> This RFC addresses (2). (1) needs a general purpose trusted code generator
>>>> and is out of scope for this RFC.
>>>
>>> This is slightly less crazy talk than introduction talking about holes
>>> in W^X. But it is very, very far from normal Unix system, where you
>>> have selection of interpretters to run your malware on (sh, python,
>>> awk, emacs, ...) and often you can even compile malware from sources. 
>>>
>>> And as you noted, we don't have "a general purpose trusted code
>>> generator" for our systems.
>>>
>>> I believe you should simply delete confusing "introduction" and
>>> provide details of super-secure system where your patches would be
>>> useful, instead.
>>
>> This RFC talks about converting dynamic code (which cannot be authenticated)
>> to static code that can be authenticated using signature verification. That
>> is the scope of this RFC.
>>
>> If I have not been clear before, by dynamic code, I mean machine code that is
>> dynamic in nature. Scripts are beyond the scope of this RFC.
>>
>> Also, malware compiled from sources is not dynamic code. That is orthogonal
>> to this RFC. If such malware has a valid signature that the kernel permits its
>> execution, we have a systemic problem.
>>
>> I am not saying that script authentication or compiled malware are not problems.
>> I am just saying that this RFC is not trying to solve all of the security problems.
>> It is trying to define one way to convert dynamic code to static code to address
>> one class of problems.
> 
> Well, you don't have to solve all problems at once.
> 
> But solutions have to exist, and AFAIK in this case they don't. You
> are armoring doors, but ignoring open windows.

FYI, script execution is being addressed (for the kernel part) by this
patch series:
https://lore.kernel.org/lkml/20200924153228.387737-1-mic@digikod.net/

> 
> Or very probably you are thinking about something different than
> normal desktop distros (Debian 10). Because on my systems, I have
> python, gdb and gcc...

It doesn't make sense for a tailored security system to leave all these
tools available to an attacker.

> 
> It would be nice to specify what other pieces need to be present for
> this to make sense -- because it makes no sense on Debian 10.

Not all kernel features make sense for a generic/undefined usage,
especially specific security mechanisms (e.g. SELinux, Smack, Tomoyo,
SafeSetID, LoadPin, IMA, IPE, secure/trusted boot, lockdown, etc.), but
they can still be definitely useful.

> 
> Best regards,
> 									Pavel
> 

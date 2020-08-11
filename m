Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE79241DAA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 17:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbgHKPys (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 11:54:48 -0400
Received: from linux.microsoft.com ([13.77.154.182]:46966 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728902AbgHKPyn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:54:43 -0400
Received: from [192.168.254.32] (unknown [47.187.206.220])
        by linux.microsoft.com (Postfix) with ESMTPSA id 526A020B4908;
        Tue, 11 Aug 2020 08:54:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 526A020B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597161281;
        bh=4AnwX8pKWPwuyBMQsqp5N2j48UHwDWqRiS19V2RyUzA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XjJgHPUVELV8QE2+Nsp1p5tMtuU8P+D3ZycY0KrJ6EOneE/ByWA3lLQxw3g/B9Mw2
         vWi2ncOTpaIkbJhV4RsoLHIkICD1ZGWQ7AXMucKMWRJHnO31eOS5fl2cDtURk5xkzx
         AtMEKomaUXd1s2zq9SUxj3UK2cWtqfSH2YCiPVhU=
Subject: Re: [PATCH v1 0/4] [RFC] Implement Trampoline File Descriptor
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
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
 <20200808221748.GA1020@bug>
 <6cca8eac-f767-b891-dc92-eaa7504a0e8b@linux.microsoft.com>
 <20200811130837.hi6wllv6g67j5wds@duo.ucw.cz>
From:   "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Message-ID: <1eec55aa-1bd6-b273-a88e-09d3c726111c@linux.microsoft.com>
Date:   Tue, 11 Aug 2020 10:54:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200811130837.hi6wllv6g67j5wds@duo.ucw.cz>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/11/20 8:08 AM, Pavel Machek wrote:
> Hi!
> 
>>>> Thanks for the lively discussion. I have tried to answer some of the
>>>> comments below.
>>>
>>>>> There are options today, e.g.
>>>>>
>>>>> a) If the restriction is only per-alias, you can have distinct aliases
>>>>>    where one is writable and another is executable, and you can make it
>>>>>    hard to find the relationship between the two.
>>>>>
>>>>> b) If the restriction is only temporal, you can write instructions into
>>>>>    an RW- buffer, transition the buffer to R--, verify the buffer
>>>>>    contents, then transition it to --X.
>>>>>
>>>>> c) You can have two processes A and B where A generates instrucitons into
>>>>>    a buffer that (only) B can execute (where B may be restricted from
>>>>>    making syscalls like write, mprotect, etc).
>>>>
>>>> The general principle of the mitigation is W^X. I would argue that
>>>> the above options are violations of the W^X principle. If they are
>>>> allowed today, they must be fixed. And they will be. So, we cannot
>>>> rely on them.
>>>
>>> Would you mind describing your threat model?
>>>
>>> Because I believe you are using model different from everyone else.
>>>
>>> In particular, I don't believe b) is a problem or should be fixed.
>>
>> It is a problem because a kernel that implements W^X properly
>> will not allow it. It has no idea what has been done in userland.
>> It has no idea that the user has checked and verified the buffer
>> contents after transitioning the page to R--.
> 
> No, it is not a problem. W^X is designed to protect from attackers
> doing buffer overflows, not attackers doing arbitrary syscalls.
> 

Hey Pavel,

You are correct. The W^X implementation today still has some holes.
IIUC, the principle of W^X is - user should not be able to (W) write code
into a page and use some trick to get it to (X) execute. So, what I
was trying to say was that the W^X principle is not implemented
completely today.

Mark Rutland mentioned some other tricks as well which are being used
today.

For instance, Microsoft has submitted this proposal:

 https://microsoft.github.io/ipe/

IPE is an LSM. In this proposal, only mappings that are backed by a
signature verified file can have execute permissions. This means that
all anonymous page based tricks will fail. And, file mapping based
tricks will fail as well when temporary files are used to load code
and mmap(). That is the intent.

Thanks!

Madhavan

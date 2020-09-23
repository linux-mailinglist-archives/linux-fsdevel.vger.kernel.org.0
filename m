Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5804A276090
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 20:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgIWS42 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 14:56:28 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44306 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgIWS42 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 14:56:28 -0400
Received: from [192.168.254.38] (unknown [47.187.206.220])
        by linux.microsoft.com (Postfix) with ESMTPSA id 557EE20B7179;
        Wed, 23 Sep 2020 11:56:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 557EE20B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1600887387;
        bh=uwZVH+hKIIVKFv+K1bPzJWqdSDUVXBp6JUcQYxnsRrI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qUdFn++LAT4vA2tvu8K1c5Cl/qAqAfZdDZ89KrYyASfOsM4Xmiai4vXaT11vsEf1N
         1jZlly6d5QA/+idswdCiva/H0kjaoiZ50IagxTZcPRY8FXTmEHeXrmRQm/DhxP8qz5
         3adFTFMbP+ClvkbfYhD+L8lgHluLwPew8dbPIpzw=
Subject: Re: [PATCH v2 0/4] [RFC] Implement Trampoline File Descriptor
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, oleg@redhat.com,
        x86@kernel.org, luto@kernel.org, David.Laight@ACULAB.COM,
        fweimer@redhat.com, mark.rutland@arm.com, mic@digikod.net
References: <210d7cd762d5307c2aa1676705b392bd445f1baa>
 <20200922215326.4603-1-madvenka@linux.microsoft.com>
 <20200923084232.GB30279@amd>
From:   "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Message-ID: <34257bc9-173d-8ef9-0c97-fb6bd0f69ecb@linux.microsoft.com>
Date:   Wed, 23 Sep 2020 13:56:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200923084232.GB30279@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/23/20 3:42 AM, Pavel Machek wrote:
> Hi!
> 
>> Solution proposed in this RFC
>> =============================
>>
>> >From this RFC's perspective, there are two scenarios for dynamic code:
>>
>> Scenario 1
>> ----------
>>
>> We know what code we need only at runtime. For instance, JIT code generated
>> for frequently executed Java methods. Only at runtime do we know what
>> methods need to be JIT compiled. Such code cannot be statically defined. It
>> has to be generated at runtime.
>>
>> Scenario 2
>> ----------
>>
>> We know what code we need in advance. User trampolines are a good example of
>> this. It is possible to define such code statically with some help from the
>> kernel.
>>
>> This RFC addresses (2). (1) needs a general purpose trusted code generator
>> and is out of scope for this RFC.
> 
> This is slightly less crazy talk than introduction talking about holes
> in W^X. But it is very, very far from normal Unix system, where you
> have selection of interpretters to run your malware on (sh, python,
> awk, emacs, ...) and often you can even compile malware from sources. 
> 
> And as you noted, we don't have "a general purpose trusted code
> generator" for our systems.
> 
> I believe you should simply delete confusing "introduction" and
> provide details of super-secure system where your patches would be
> useful, instead.
> 
> Best regards,
> 									Pavel
> 

This RFC talks about converting dynamic code (which cannot be authenticated)
to static code that can be authenticated using signature verification. That
is the scope of this RFC.

If I have not been clear before, by dynamic code, I mean machine code that is
dynamic in nature. Scripts are beyond the scope of this RFC.

Also, malware compiled from sources is not dynamic code. That is orthogonal
to this RFC. If such malware has a valid signature that the kernel permits its
execution, we have a systemic problem.

I am not saying that script authentication or compiled malware are not problems.
I am just saying that this RFC is not trying to solve all of the security problems.
It is trying to define one way to convert dynamic code to static code to address
one class of problems.

Madhavan

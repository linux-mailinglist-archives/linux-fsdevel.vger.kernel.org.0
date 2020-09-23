Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F7B2764B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 01:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgIWXvq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 19:51:46 -0400
Received: from linux.microsoft.com ([13.77.154.182]:53490 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgIWXvp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 19:51:45 -0400
Received: from [192.168.254.38] (unknown [47.187.206.220])
        by linux.microsoft.com (Postfix) with ESMTPSA id C6A2220B7179;
        Wed, 23 Sep 2020 16:51:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C6A2220B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1600905104;
        bh=GqgBG7sD6S7qtNstlI1PIKQbA+siGqVV5q8dqxKHvGg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RV5cXfK+8CDkots7pritItEd6mNvifrnS8eLmaxWpuRVt+XnVh2Tz1Us3fIONgAX4
         fq5WeRAMXAUcIUU48OhIz2OVF7gsx9JiFKd8W+rta/V3LhcEf/ZVP030TgL2NDuwTs
         IeJj3m3tJ2yNhp553s/EKSx3XL0QR1MUcpO5F7WI=
Subject: Re: [PATCH v2 0/4] [RFC] Implement Trampoline File Descriptor
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Florian Weimer <fw@deneb.enyo.de>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, oleg@redhat.com,
        x86@kernel.org, libffi-discuss@sourceware.org, luto@kernel.org,
        David.Laight@ACULAB.COM, mark.rutland@arm.com, mic@digikod.net,
        pavel@ucw.cz
References: <20200916150826.5990-1-madvenka@linux.microsoft.com>
 <87v9gdz01h.fsf@mid.deneb.enyo.de>
 <96ea02df-4154-5888-1669-f3beeed60b33@linux.microsoft.com>
 <20200923014616.GA1216401@rani.riverdale.lan>
 <20200923091125.GB1240819@rani.riverdale.lan>
 <a742b9cd-4ffb-60e0-63b8-894800009700@linux.microsoft.com>
 <20200923195147.GA1358246@rani.riverdale.lan>
From:   "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Message-ID: <6409d394-9dd2-ae84-88fc-03218515d57d@linux.microsoft.com>
Date:   Wed, 23 Sep 2020 18:51:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200923195147.GA1358246@rani.riverdale.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/23/20 2:51 PM, Arvind Sankar wrote:
> On Wed, Sep 23, 2020 at 02:17:30PM -0500, Madhavan T. Venkataraman wrote:
>>
>>
>> On 9/23/20 4:11 AM, Arvind Sankar wrote:
>>> For libffi, I think the proposed standard trampoline won't actually
>>> work, because not all ABIs have two scratch registers available to use
>>> as code_reg and data_reg. Eg i386 fastcall only has one, and register
>>> has zero scratch registers. I believe 32-bit ARM only has one scratch
>>> register as well.
>>
>> The trampoline is invoked as a function call in the libffi case. Any
>> caller saved register can be used as code_reg, can it not? And the
>> scratch register is needed only to jump to the code. After that, it
>> can be reused for any other purpose.
>>
>> However, for ARM, you are quite correct. There is only one scratch
>> register. This means that I have to provide two types of trampolines:
>>
>> 	- If an architecture has enough scratch registers, use the currently
>> 	  defined trampoline.
>>
>> 	- If the architecture has only one scratch register, but has PC-relative
>> 	  data references, then embed the code address at the bottom of the
>> 	  trampoline and access it using PC-relative addressing.
>>
>> Thanks for pointing this out.
>>
>> Madhavan
> 
> libffi is trying to provide closures with non-standard ABIs as well: the
> actual user function is standard ABI, but the closure can be called with
> a different ABI. If the closure was created with FFI_REGISTER abi, there
> are no registers available for the trampoline to use: EAX, EDX and ECX
> contain the first three arguments of the function, and every other
> register is callee-save.
> 
> I provided a sample of the kind of trampoline that would be needed in
> this case -- it's position-independent and doesn't clobber any registers
> at all, and you get 255 trampolines per page. If I take another 16-byte
> slot out of the page for the end trampoline that does the actual work,
> I'm sure I could even come up with one that can just call a normal C
> function, only the return might need special handling depending on the
> return type.
> 
> And again, do you actually have any example of an architecture that
> cannot run position-independent code? PC-relative addressing is an
> implementation detail: the fact that it's available for x86_64 but not
> for i386 just makes position-independent code more cumbersome on i386,
> but it doesn't make it impossible. For the tiny trampolines here, it
> makes almost no difference.
> 

Hi Arvind,

I am preparing a response for all of your comments. I will send it out
tomorrow. Sorry for the delay.

Madhavan

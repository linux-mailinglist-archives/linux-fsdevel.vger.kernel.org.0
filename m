Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847E5231014
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 18:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbgG1QtM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 12:49:12 -0400
Received: from linux.microsoft.com ([13.77.154.182]:38868 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731474AbgG1QtM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 12:49:12 -0400
Received: from [192.168.254.32] (unknown [47.187.206.220])
        by linux.microsoft.com (Postfix) with ESMTPSA id 00A5820B4908;
        Tue, 28 Jul 2020 09:49:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 00A5820B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1595954951;
        bh=Wp9lMVW/v/maF95Uhld2YeppHP7BkSsiQSbIpc2iGG8=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=WcBQe+flSDX55q/ewMf9Af18CEdGVpPWvr4lx2WIFz5MF35ysP3AWSLhovuuIPJcA
         R3zbmGw3qgHmAG6CF4LvqSk2K2IKdZOIS5Qx4ZwAsGDJLulERBJPTE+dh47a06ZwIC
         G6ZCs/L/b81Zc5VW94CZcASUxH6PlX38Z+nqyTKc=
Subject: Re: [PATCH v1 0/4] [RFC] Implement Trampoline File Descriptor
To:     Casey Schaufler <casey@schaufler-ca.com>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, oleg@redhat.com,
        x86@kernel.org
References: <aefc85852ea518982e74b233e11e16d2e707bc32>
 <20200728131050.24443-1-madvenka@linux.microsoft.com>
 <3fd22f92-7f45-1b0f-e4fe-857f3bceedd0@schaufler-ca.com>
From:   "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Message-ID: <80dd0421-062b-bfaa-395a-e52b169acea4@linux.microsoft.com>
Date:   Tue, 28 Jul 2020 11:49:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3fd22f92-7f45-1b0f-e4fe-857f3bceedd0@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks.

On 7/28/20 11:05 AM, Casey Schaufler wrote:
>> In this solution, the kernel recognizes certain sequences of instructions
>> as "well-known" trampolines. When such a trampoline is executed, a page
>> fault happens because the trampoline page does not have execute permission.
>> The kernel recognizes the trampoline and emulates it. Basically, the
>> kernel does the work of the trampoline on behalf of the application.
> What prevents a malicious process from using the "well-known" trampoline
> to its own purposes? I expect it is obvious, but I'm not seeing it. Old
> eyes, I suppose.

You are quite right. As I note below, the attack surface is the
buffer that contains the trampoline code. Since the kernel does
check the instruction sequence, the sequence cannot be
changed by a hacker. But the hacker can presumably change
the register values and redirect the PC to his desired location.

The assumption with trampoline emulation is that the
system will have security settings that will prevent pages from
having both write and execute permissions. So, a hacker
cannot load his own code in a page and redirect the PC to
it and execute his own code. But he can probably set the
PC to point to arbitrary locations. For instance, jump to
the middle of a C library function.
>
>> Here, the attack surface is the buffer that contains the trampoline.
>> The attack surface is narrower than before. A hacker may still be able to
>> modify what gets loaded in the registers or modify the target PC to point
>> to arbitrary locations.
...
>> Work that is pending
>> --------------------
>>
>> - I am working on implementing an SELinux setting called "exectramp"
>>   similar to "execmem" to allow the use of trampfd on a per application
>>   basis.
> You could make a separate LSM to do these checks instead of limiting
> it to SELinux. Your use case, your call, of course.

OK. I will research this.

Madhavan

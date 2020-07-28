Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80839230F5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 18:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731487AbgG1Qcf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 12:32:35 -0400
Received: from linux.microsoft.com ([13.77.154.182]:36752 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731286AbgG1Qce (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 12:32:34 -0400
Received: from [192.168.254.32] (unknown [47.187.206.220])
        by linux.microsoft.com (Postfix) with ESMTPSA id 46AA720B4908;
        Tue, 28 Jul 2020 09:32:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 46AA720B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1595953953;
        bh=Rb0cIoD+PBZ6iPo4SV0GEZ6L0o4DvfLkYqFF52aPh2A=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=NGYC9tEdPV6xnCVOdwIeqZvN2dKm0x9MAjUMmotn+8mMWAF3jwAU9jFcfsdT1zLtI
         b7kaqYuzPMht/pDkpeohuuGK2OeqJMq4r2wVIMvJUufeWS2YydUzzEWfndiFPJ2qGr
         mIHtInG/DXexeidbSrB3P9fJodqZv03UsuUKNwbM=
Subject: Re: [PATCH v1 0/4] [RFC] Implement Trampoline File Descriptor
To:     David Laight <David.Laight@ACULAB.COM>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>
References: <aefc85852ea518982e74b233e11e16d2e707bc32>
 <20200728131050.24443-1-madvenka@linux.microsoft.com>
 <c23de6ec47614f489943e1a89a21dfa3@AcuMS.aculab.com>
From:   "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Message-ID: <f5cfd11b-04fe-9db7-9d67-7ee898636edb@linux.microsoft.com>
Date:   Tue, 28 Jul 2020 11:32:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c23de6ec47614f489943e1a89a21dfa3@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks. See inline..

On 7/28/20 10:13 AM, David Laight wrote:
> From:  madvenka@linux.microsoft.com
>> Sent: 28 July 2020 14:11
> ...
>> The kernel creates the trampoline mapping without any permissions. When
>> the trampoline is executed by user code, a page fault happens and the
>> kernel gets control. The kernel recognizes that this is a trampoline
>> invocation. It sets up the user registers based on the specified
>> register context, and/or pushes values on the user stack based on the
>> specified stack context, and sets the user PC to the requested target
>> PC. When the kernel returns, execution continues at the target PC.
>> So, the kernel does the work of the trampoline on behalf of the
>> application.
> Isn't the performance of this going to be horrid?

It takes about the same amount of time as getpid(). So, it is
one quick trip into the kernel. I expect that applications will
typically not care about this extra overhead as long as
they are able to run.

But I agree that if there is an application that cannot tolerate
this extra overhead, then it is an issue. See below for further
discussion.

In the libffi changes I have included in the cover letter, I have
done it in such a way that trampfd is chosen when current
security settings don't allow other methods such as
loading trampoline code into a file and mapping it. In this
case, the application can at least run with trampfd.

>
> If you don't care that much about performance the fixup can
> all be done in userspace within the fault signal handler.

I do care about performance.

This is a framework to address trampolines. In this initial
work, I want to establish one basic way for things to work.
In the future, trampfd can be enhanced for performance.
For instance, it is easy for an architecture to generate
the exact instructions required to load specified registers,
push specified values on the stack and jump to a target
PC. The kernel can map a page with the generated code
with execute permissions. In this case, the performance
issue goes away.
> Since whatever you do needs the application changed why
> not change the implementation of nested functions to not
> need on-stack executable trampolines.

I kinda agree with your suggestion.

But it is up to the GCC folks to change its implementation.
I am trying to provide a way for their existing implementation
to work in a more secure way.
> I can think of other alternatives that don't need much more
> than an array of 'push constant; jump trampoline' instructions
> be created (all jump to the same place).
>
> You might want something to create an executable page of such
> instructions.

Agreed. And that can be done within this framework as
I have mentioned above.

But it is not just this trampoline type that I have implemented
in this patchset. In the future, other types can be implemented
and other contexts can be defined. Basically, the approach is
for the user to supply a recipe to the kernel and leave it up to
the kernel to do it in the best way possible. I am hoping that
other forms of dynamic code can be addressed in the future
using the same framework.

*Purely as a hypothetical example*, a user can supply
instructions in a language such as BPF that the kernel
understands and have the kernel arrange for that to
be executed in user context.

Madhavan

> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)


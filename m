Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8669423AA19
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 18:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbgHCQDY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 12:03:24 -0400
Received: from linux.microsoft.com ([13.77.154.182]:43648 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgHCQDX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 12:03:23 -0400
Received: from [192.168.254.32] (unknown [47.187.206.220])
        by linux.microsoft.com (Postfix) with ESMTPSA id 09D5E20B4908;
        Mon,  3 Aug 2020 09:03:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 09D5E20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596470602;
        bh=ZiO52alLmnpxT7j4anLU5ZigsjFuPb9HBovKSoPQQ3w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QHf+d+adyjmFUMw8F6KIhtFl2KmvTj4vBrSymSBr/2bDq/bWh9j06EOVn5++PivQ+
         voHvs0Lb2zIfoJuBfpScJ2evOehCf7CU8vfsuxDIGF7QhHjz3poDRcCPaEONbsDGN9
         dqsnbvmNS9ytmBh/6/eiWhI5Hsbb5iwXGxjz1OIg=
Subject: Re: [PATCH v1 0/4] [RFC] Implement Trampoline File Descriptor
To:     David Laight <David.Laight@ACULAB.COM>,
        'Mark Rutland' <mark.rutland@arm.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, X86 ML <x86@kernel.org>
References: <20200728131050.24443-1-madvenka@linux.microsoft.com>
 <CALCETrVy5OMuUx04-wWk9FJbSxkrT2vMfN_kANinudrDwC4Cig@mail.gmail.com>
 <6540b4b7-3f70-adbf-c922-43886599713a@linux.microsoft.com>
 <CALCETrWnNR5v3ZCLfBVQGYK8M0jAvQMaAc9uuO05kfZuh-4d6w@mail.gmail.com>
 <46a1adef-65f0-bd5e-0b17-54856fb7e7ee@linux.microsoft.com>
 <20200731183146.GD67415@C02TD0UTHF1T.local>
 <a3068e3126a942c7a3e7ac115499deb1@AcuMS.aculab.com>
From:   "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Message-ID: <7fdc102e-75ea-6d91-d2a3-7fe8c91802ce@linux.microsoft.com>
Date:   Mon, 3 Aug 2020 11:03:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a3068e3126a942c7a3e7ac115499deb1@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/3/20 3:27 AM, David Laight wrote:
> From: Mark Rutland
>> Sent: 31 July 2020 19:32
> ...
>>> It requires PC-relative data references. I have not worked on all architectures.
>>> So, I need to study this. But do all ISAs support PC-relative data references?
>> Not all do, but pretty much any recent ISA will as it's a practical
>> necessity for fast position-independent code.
> i386 has neither PC-relative addressing nor moves from %pc.
> The cpu architecture knows that the sequence:
> 	call	1f  
> 1:	pop	%reg  
> is used to get the %pc value so is treated specially so that
> it doesn't 'trash' the return stack.
>
> So PIC code isn't too bad, but you have to use the correct
> sequence.

Is that true only for 32-bit systems only? I thought RIP-relative addressing was
introduced in 64-bit mode. Please confirm.

Madhavan

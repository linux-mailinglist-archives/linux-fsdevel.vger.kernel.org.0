Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032C82334AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 16:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbgG3OmZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 10:42:25 -0400
Received: from linux.microsoft.com ([13.77.154.182]:52692 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgG3OmZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 10:42:25 -0400
Received: from [192.168.254.32] (unknown [47.187.206.220])
        by linux.microsoft.com (Postfix) with ESMTPSA id 447E220B4908;
        Thu, 30 Jul 2020 07:42:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 447E220B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596120143;
        bh=JKjym+PetFsYNW9wkVDAjo/yZX3EUJAVDZIUKswMGaQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fr+aQ6wg1KgTGw6nIBKQ+VD8DP0JAdoWoTqnBCw0HXWZsTUfyvrUFPowTbotbg6+R
         PVwyphPu3guW5xqko6YXK0fQawCA7Fnc48ucO0Im672RcBmUhK33lx+YLAS4Ec/fWH
         sWTg9Z+ywbm24khHImc0gMC6bx02ZKnhzr1M/S3I=
Subject: Re: [PATCH v1 0/4] [RFC] Implement Trampoline File Descriptor
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, X86 ML <x86@kernel.org>
References: <20200728131050.24443-1-madvenka@linux.microsoft.com>
 <CALCETrVy5OMuUx04-wWk9FJbSxkrT2vMfN_kANinudrDwC4Cig@mail.gmail.com>
From:   "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Message-ID: <2352c2b5-053d-fd33-80b0-4f2175dbb607@linux.microsoft.com>
Date:   Thu, 30 Jul 2020 09:42:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CALCETrVy5OMuUx04-wWk9FJbSxkrT2vMfN_kANinudrDwC4Cig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For some reason my email program is not delivering to all the
recipients because of some formatting issues. I am resending.
I apologize. I will try to get this fixed.

Sorry for the delay. I just needed to think about it a little.
I will respond to your first suggestion in this email. I will
respond to the others in separate emails if that is alright
with you.

On 7/28/20 12:31 PM, Andy Lutomirski wrote:
>> On Jul 28, 2020, at 6:11 AM, madvenka@linux.microsoft.com wrote:
>>
>> ﻿From: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
>>
>> The kernel creates the trampoline mapping without any permissions. When
>> the trampoline is executed by user code, a page fault happens and the
>> kernel gets control. The kernel recognizes that this is a trampoline
>> invocation. It sets up the user registers based on the specified
>> register context, and/or pushes values on the user stack based on the
>> specified stack context, and sets the user PC to the requested target
>> PC. When the kernel returns, execution continues at the target PC.
>> So, the kernel does the work of the trampoline on behalf of the
>> application.
> This is quite clever, but now I’m wondering just how much kernel help
> is really needed. In your series, the trampoline is an non-executable
> page.  I can think of at least two alternative approaches, and I'd
> like to know the pros and cons.
>
> 1. Entirely userspace: a return trampoline would be something like:
>
> 1:
> pushq %rax
> pushq %rbc
> pushq %rcx
> ...
> pushq %r15
> movq %rsp, %rdi # pointer to saved regs
> leaq 1b(%rip), %rsi # pointer to the trampoline itself
> callq trampoline_handler # see below
>
> You would fill a page with a bunch of these, possibly compacted to get
> more per page, and then you would remap as many copies as needed.  The
> 'callq trampoline_handler' part would need to be a bit clever to make
> it continue to work despite this remapping.  This will be *much*
> faster than trampfd. How much of your use case would it cover?  For
> the inverse, it's not too hard to write a bit of asm to set all
> registers and jump somewhere.

Let me state my understanding of what you are suggesting. Correct me if
I get anything wrong. If you don't mind, I will also take the liberty
of generalizing and paraphrasing your suggestion.

The goal is to create two page mappings that are adjacent to each other:

- a code page that contains template code for a trampoline. Since the
  template code would tend to be small in size, pack as many of them
  as possible within a page to conserve memory. In other words, create
  an array of the template code fragments. Each element in the array
  would be used for one trampoline instance.

- a data page that contains an array of data elements. Corresponding
  to each code element in the code page, there would be a data element
  in the data page that would contain data that is specific to a
  trampoline instance.

- Code will access data using PC-relative addressing.

The management of the code pages and allocation for each trampoline
instance would all be done in user space.

Is this the general idea?

Creating a code page
----------------------------

We can do this in one of the following ways:
- Allocate a writable page at run time, write the template code into
  the page and have execute permissions on the page.

- Allocate a writable page at run time, write the template code into
  the page and remap the page with just execute permissions.

- Allocate a writable page at run time, write the template code into
  the page, write the page into a temporary file and map the file with
  execute permissions.

- Include the template code in a code page at build time itself and
  just remap the code page each time you need a code page.

Pros and Cons
-------------------

As long as the OS provides the functionality to do this and the security
subsystem in the OS allows the actions, this is totally feasible. If not,
we need something like trampfd.

As Floren mentioned, libffi does implement something like this for MACH.

In fact, in my libffi changes, I use trampfd only after all the other methods
have failed because of security settings.

But the above approach only solves the problem for this simple type of
trampoline. It does not provide a framework for addressing more complex types
or even other forms of dynamic code.

Also, each application would need to implement this solution for itself
as opposed to relying on one implementation provided by the kernel.

Trampfd-based solution
-------------------------------

I outlined an enhancement to trampfd in a response to David Laight. In this
enhancement, the kernel is the one that would set up the code page.

The kernel would call an arch-specific support function to generate the
code required to load registers, push values on the stack and jump to a PC
for a trampoline instance based on its current context. The trampoline
instance data could be baked into the code.

My initial idea was to only have one trampoline instance per page. But I
think I can implement multiple instances per page. I just have to manage
the trampfd file private data and VMA private data accordingly to map an
element in a code page to its trampoline object.

The two approaches are similar except for the detail about who sets up
and manages the trampoline pages. In both approaches, the performance problem
is addressed. But trampfd can be used even when security settings are
restrictive.

Is my solution acceptable?

A couple of things
------------------------

- In the current trampfd implementation, no physical pages are actually
  allocated. It is just a virtual mapping. From a memory footprint
  perspective, this is good. May be, we can let the user specify if
  he wants a fast trampoline that consumes memory or a slow one that doesn't?

- In the future, we may define additional types that need the kernel to do
  the job. Examples:

    - The kernel may have a trampoline type for which it is not willing
       or able to generate code

    - The kernel could emulate dynamic code for the user

     - The kernel could interpret dynamic code for the user

     - The kernel could allow the user to access some kernel functionality
        using the framework

  In such cases, there isn't any physical code page that gets mapped into
  the user address space. We need the kernel to handle the address fault
  and provide the functionality.

One question for the reviewers
----------------------------------------

Do you think that the file descriptor based approach is fine? Or, does this
need a regular system call based implementation? There are some advantages
with a regular system call:

- We don't consume file descriptors. E.g., in libffi, we have to
  keep the file descriptor open for a closure until the closure
  is freed.

- Trampoline operations can be performed based on the trampoline
  address instead of an fd.

- Sharing of objects across processes can be implemented through
  a regular ID based method rather than sending the file descriptor
  over a unix domain socket.

- Shared objects can be persistent.

- An fd based API does structure parsing in read()/write() calls
  to obtain arguments. With a regular system call, that is not
  necessary.

Please let me know your thoughts.

Madhavan

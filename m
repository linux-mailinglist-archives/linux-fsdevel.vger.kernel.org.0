Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D900B2349F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jul 2020 19:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732817AbgGaRNx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jul 2020 13:13:53 -0400
Received: from linux.microsoft.com ([13.77.154.182]:36806 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729944AbgGaRNx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jul 2020 13:13:53 -0400
Received: from [192.168.254.32] (unknown [47.187.206.220])
        by linux.microsoft.com (Postfix) with ESMTPSA id B694B20B4908;
        Fri, 31 Jul 2020 10:13:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B694B20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596215631;
        bh=7mfvaw+Ea5pD5ZecrXPlWesPKVeHIuOLmX3If73XE58=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KQXSBNnOk5ZEM78ImGbK1OjsoecWdijyO5/XXfP/pO3eiJZuhcfcDP8/IicRA9R1S
         5/RRZQEq+q0jtQ5CeEKck2PLQYdKkAF2cB1BzORhM0bhX5V5TnBrxs99Ez+9ZZ0Egj
         0ZraFdOCCdmjvVJYVimboYjR2Ib1ajJQ3so6T1xQ=
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
 <6540b4b7-3f70-adbf-c922-43886599713a@linux.microsoft.com>
 <CALCETrWnNR5v3ZCLfBVQGYK8M0jAvQMaAc9uuO05kfZuh-4d6w@mail.gmail.com>
From:   "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Message-ID: <46a1adef-65f0-bd5e-0b17-54856fb7e7ee@linux.microsoft.com>
Date:   Fri, 31 Jul 2020 12:13:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CALCETrWnNR5v3ZCLfBVQGYK8M0jAvQMaAc9uuO05kfZuh-4d6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/30/20 3:54 PM, Andy Lutomirski wrote:
> On Thu, Jul 30, 2020 at 7:24 AM Madhavan T. Venkataraman
> <madvenka@linux.microsoft.com> wrote:
>> ...
>> Creating a code page
>> --------------------
>>
>> We can do this in one of the following ways:
>>
>> - Allocate a writable page at run time, write the template code into
>>   the page and have execute permissions on the page.
>>
>> - Allocate a writable page at run time, write the template code into
>>   the page and remap the page with just execute permissions.
>>
>> - Allocate a writable page at run time, write the template code into
>>   the page, write the page into a temporary file and map the file with
>>   execute permissions.
>>
>> - Include the template code in a code page at build time itself and
>>   just remap the code page each time you need a code page.
> This latter part shouldn't need any special permissions as far as I know.

Agreed.
>
>> Pros and Cons
>> -------------
>>
>> As long as the OS provides the functionality to do this and the security
>> subsystem in the OS allows the actions, this is totally feasible. If not,
>> we need something like trampfd.
>>
>> As Floren mentioned, libffi does implement something like this for MACH.
>>
>> In fact, in my libffi changes, I use trampfd only after all the other methods
>> have failed because of security settings.
>>
>> But the above approach only solves the problem for this simple type of
>> trampoline. It does not provide a framework for addressing more complex types
>> or even other forms of dynamic code.
>>
>> Also, each application would need to implement this solution for itself
>> as opposed to relying on one implementation provided by the kernel.
> I would argue this is a benefit.  If the whole implementation is in
> userspace, there is no ABI compatibility issue.  The user program
> contains the trampoline code and the code that uses it.

The current trampfd implementation also does not have an ABI issue.
ABI details are to be handled in user land. In the case of libffi, they
are. Trampfd only addresses the trampoline required to jump to the
ABI handler.

>
>> Trampfd-based solution
>> ----------------------
>>
>> I outlined an enhancement to trampfd in a response to David Laight. In this
>> enhancement, the kernel is the one that would set up the code page.
>>
>> The kernel would call an arch-specific support function to generate the
>> code required to load registers, push values on the stack and jump to a PC
>> for a trampoline instance based on its current context. The trampoline
>> instance data could be baked into the code.
>>
>> My initial idea was to only have one trampoline instance per page. But I
>> think I can implement multiple instances per page. I just have to manage
>> the trampfd file private data and VMA private data accordingly to map an
>> element in a code page to its trampoline object.
>>
>> The two approaches are similar except for the detail about who sets up
>> and manages the trampoline pages. In both approaches, the performance problem
>> is addressed. But trampfd can be used even when security settings are
>> restrictive.
>>
>> Is my solution acceptable?
> Perhaps.  In general, before adding a new ABI to the kernel, it's nice
> to understand how it's better than doing the same thing in userspace.
> Saying that it's easier for user code to work with if it's in the
> kernel isn't necessarily an adequate justification.

Fair enough.

Dealing with multiple architectures
-----------------------------------------------

One good reason to use trampfd is multiple architecture support. The
trampoline table in a code page approach is neat. I don't deny that at
all. But my question is - can it be used in all cases?

It requires PC-relative data references. I have not worked on all architectures.
So, I need to study this. But do all ISAs support PC-relative data references?

Even in an ISA that supports it, there would be a maximum supported offset
from the current PC that can be reached for a data reference. That maximum
needs to be at least the size of a base page in the architecture. This is because
the code page and the data page need to be separate for security reasons.
Do all ISAs support a sufficiently large offset?

When the kernel generates the code for a trampoline, it can hard code data values
in the generated code itself so it does not need PC-relative data referencing.

And, for ISAs that do support the large offset, we do have to implement and
maintain the code page stuff for different ISAs for each application and library
if we did not use trampfd.

If you look at the libffi reference patch that I have linked in the cover letter,
I have added functions in common code that wrap trampfd calls. From architecture
specific code, there is just one function call to one of those wrapper functions
to set the register context for the trampoline. This is a very small C code change
in each architecture. So, support can be extended to all architectures without
exception easily.

Runtime generated trampolines
-------------------------------------------

libffi trampolines are simple. But there may be many cases out there where the
trampoline code cannot be statically defined at build time. It may have to be
generated at runtime. For this, we will need trampfd.

Security
-----------

With the user level trampoline table approach, the data part of the trampoline table
can be hacked by an attacker if an application has a vulnerability. Specifically, the
target PC can be altered to some arbitrary location. Trampfd implements an
"Allowed PCS" context. In the libffi changes, I have created a read-only array of
all ABI handlers used in closures for each architecture. This read-only array
can be used to restrict the PC values for libffi trampolines to prevent hacking.

To generalize, we can implement security rules/features if the trampoline
object is in the kernel.

Standardization
---------------------

Trampfd is a framework that can be used to implement multiple things. May be,
a few of those things can also be implemented in user land itself. But I think having
just one mechanism to execute dynamic code objects is preferable to having
multiple mechanisms not standardized across all applications.

As an example, let us say that I am able to implement support for JIT code. Let us
say that an interpreter uses libffi to execute a generated function. The interpreter
would use trampfd for the JIT code object and get an address. Then, it would pass
that to libffi which would then use trampfd for the trampoline. So, trampfd based
code objects can be chained.

> Why would remapping two pages of actual application text ever fail?

Remapping a page may not be available on all OSes. However, that is not a problem
for the code page approach. One can always memory map the code page from the
binary file directly. So, yes, this would not fail.

Madhavan

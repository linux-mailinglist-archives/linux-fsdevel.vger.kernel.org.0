Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8978279409
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Sep 2020 00:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbgIYWWI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Sep 2020 18:22:08 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37628 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbgIYWWI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Sep 2020 18:22:08 -0400
Received: from [192.168.254.38] (unknown [47.187.206.220])
        by linux.microsoft.com (Postfix) with ESMTPSA id 270E320B7179;
        Fri, 25 Sep 2020 15:22:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 270E320B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1601072527;
        bh=CtfK2RmYieDmRDw24zWHirWtpfw9TSkDGo/OHGd2khY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=L1Tnh9cUKbIv8sb36wOJHo5gTvwoZfP3A7tFZQedg3xDu7eQlGlMr8fkDfnnoKeAt
         +19mQmaCJMQDjOd/BSO0TL73Zw7FX6wix/euEgK1YDGoBwIEy1ADOVImdfJvBFF15T
         nw6sFmaXF1NgNsNvpCmh5eag6ZnN4mvdF/MmIwQE=
Subject: Re: [PATCH v2 0/4] [RFC] Implement Trampoline File Descriptor
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
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
 <2ed2becd-49b5-7e76-9836-6a43707f539f@linux.microsoft.com>
 <87o8luvqw9.fsf@mid.deneb.enyo.de>
From:   "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Message-ID: <3fe7ba84-b719-b44d-da87-6eda60543118@linux.microsoft.com>
Date:   Fri, 25 Sep 2020 17:22:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87o8luvqw9.fsf@mid.deneb.enyo.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/24/20 3:52 PM, Florian Weimer wrote:
> * Madhavan T. Venkataraman:
> 
>> Otherwise, using an ABI quirk or a calling convention side effect to
>> load the PC into a GPR is, IMO, non-standard or non-compliant or
>> non-approved or whatever you want to call it. I would be
>> conservative and not use it. Who knows what incompatibility there
>> will be with some future software or hardware features?
> 
> AArch64 PAC makes a backwards-incompatible change that touches this
> area, but we'll see if they can actually get away with it.
> 
> In general, these things are baked into the ABI, even if they are not
> spelled out explicitly in the psABI supplement.
> 
>> For instance, in the i386 example, we do a call without a matching return.
>> Also, we use a pop to undo the call. Can anyone tell me if this kind of use
>> is an ABI approved one?
> 
> Yes, for i386, this is completely valid from an ABI point of view.
> It's equally possible to use a regular function call and just read the
> return address that has been pushed to the stack.  Then there's no
> stack mismatch at all.  Return stack predictors (including the one
> used by SHSTK) also recognize the CALL 0 construct, so that's fine as
> well.  The i386 psABI does not use function descriptors, and either
> approach (out-of-line thunk or CALL 0) is in common use to materialize
> the program counter in a register and construct the GOT pointer.
> 
>> If the kernel supplies this, then all applications and libraries can use
>> it for all architectures with one single, simple API. Without this, each
>> application/library has to roll its own solution for every architecture-ABI
>> combo it wants to support.
> 
> Is there any other user for these type-generic trampolines?
> Everything else I've seen generates machine code specific to the
> function being called.  libffi is quite the outlier in my experience
> because the trampoline calls a generic data-driven
> marshaller/unmarshaller.  The other trampoline generators put this
> marshalling code directly into the generated trampoline.
> 
> I'm still not convinced that this can't be done directly in libffi,
> without kernel help.  Hiding the architecture-specific code in the
> kernel doesn't reduce overall system complexity.
> 

See below. I have accepted the community's recommendation to implement it
in user land. However, this is not just for libffi. It is for all dynamic
code. libffi is just the first use case I am addressing with this.

>> As an example, in libffi:
>>
>> 	ffi_closure_alloc() would call alloc_tramp()
>>
>> 	ffi_prep_closure_loc() would call init_tramp()
>>
>> 	ffi_closure_free() would call free_tramp()
>>
>> That is it! It works on all the architectures supported in the kernel for
>> trampfd.
> 
> ffi_prep_closure_loc would still need to check whether the trampoline
> has been allocated by alloc_tramp because some applications supply
> their own (executable and writable) mapping.  ffi_closure_alloc would
> need to support different sizes (not matching the trampoline).  It's
> also unclear to me to what extent software out there writes to the
> trampoline data directly, bypassing the libffi API (the structs are
> not opaque, after all).  And all the existing libffi memory management
> code (including the embedded dlmalloc copy) would be needed to support
> kernels without trampfd for years to come.
> 

In the libffi patch I have included, I have handled this. The closure
structure contains a tramp field:

  char tramp[FFI_TRAMPOLINE_SIZE];

If trampfd is not used, this array will contain the actual
trampoline code. If trampfd is used, then we don't need the array for
storing any trampoline code. That space can be used for storing trampfd
related information.

So, there is no change to the closure structure.

Also, the code can tell if the closure has been allocated from dlmalloc()
called from ffi_closure_alloc() or has been allocated by the caller
directly without calling ffi_closure_alloc(). I have written this function:

int ffi_closure_alloc_called(void *closure)
{
  msegmentptr seg = segment_holding (gm, closure);
  return (seg != NULL);
}

Using this function, I can tell how the closure has been allocated. I use
trampfd only for closures that have been allocated using ffi_closure_alloc().
So, I believe I have handled all the cases. If I have missed anything,
let me know. I will address it.

> I very much agree that we have a gap in libffi when it comes to
> JIT-less operation.  But I'm not convinced that kernel support is
> needed to close it, or that it is even the right design.
> 

I have taken into account most of the comments received so far and I have
come up with a proposal:

I would like to do this in two separate RFCs:

library RFC
-----------

I accept the recommendation of the reviewers about implementing it in
user land in a library.

Just for the sake of context, I would like to reiterate the problem being
solved and what the library will contain. Bear with me.

My goal is to help convert existing dynamic code to static code as far as
possible. The binary generated from the static code can be signed. The
kernel can use signature verification to authenticate the code. This way,
we don't need to disable W^X or make exceptions for the code (exemem etc) or
use any user level methods to somehow map and execute the code.

The dynamic code can be very simple like the libffi trampoline. Or, it can
be a lot more complex. E.g., a trampoline that uses data marshaling as Florian
mentioned. In all cases, when the code is converted to static code, the static
code needs to know where its data will be located at runtime. If static code is
a function, then one can just pass parameters. But if it is arbitrary code,
then one needs a way to inform the static code where it can find its data.

The code can use PC-relative referencing where available. For the sake of this
discussion, let us assume that we can use some trick or the other to load the
current PC into a GPR on all architectures. Then, we can use PC-relative
referencing. Let us assume that these tricks will not cause ABI compliance
issues in the future.

The maintainer of the dynamic code who wishes to convert it to static code
should not have to deal with all of these details. The static code should
be able to assume that its data is pointed to by a designated register. Or,
it should be able to assume that the data pointer has been pushed on the
stack. Then, it is easier for maintainers to adopt this and move their code
to a more secure model.

This can be achieved by providing a small, minimal trampoline that loads the
data pointer in a register or pushes it on the stack and jumps to the static
code.

The reviewers felt that the minimal trampoline can be provided in user land.
So, I will provide a user library. The user library will:

	- define the minimal trampoline statically for different architectures
	  using some flavor of PC-relative data referencing
	
	- provide a table of trampolines in a page
	
	- create and manage code and data pages
	
	- present a simple API to dynamic code maintainers

This overall approach has pretty much been agreed upon by the community so
far. I will send out an RFC for the library once I have the code ready.

Which library?
--------------

I need a recommendation from the community on this. Should I just place the
code in glibc? Or, should I create a libtramp for this? I prefer glibc as
it will make for easier adoption. But I will defer to the community on this.
What do you recommend?

trampfd RFC version 3
---------------------

Once the library RFC is accepted, I would, however, like to submit
version 3 of trampfd.

The library would support a choice of trampoline:

	- fast user trampoline described above

	- slow kernel trampoline described below that supports security
	  checks each time the trampoline is invoked

The minimal trampoline mentioned above would also be implemented in the
kernel. The mechanism is outlined in version 1. When the application executes
the trampoline, it would trap into the kernel and the kernel would do the
work (load the data pointer in a user register or push it on the user stack and set
the user PC to the target code and return). The kernel will perform security checks when
the trampoline is invoked. For instance, to reduce or eliminate the possibility
of the trampoline being used in an ROP/BOP chain. The checks are work in
progress. But I think I can nail them.

Note that there is no code generation involved in this proposal. The kernel
is the trampoline.

Would you guys be willing to consider this approach?

Madhavan

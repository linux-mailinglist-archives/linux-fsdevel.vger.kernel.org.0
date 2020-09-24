Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEFB8277ABE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 22:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgIXUwv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 16:52:51 -0400
Received: from albireo.enyo.de ([37.24.231.21]:36894 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgIXUwv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 16:52:51 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kLYEI-0006aW-SF; Thu, 24 Sep 2020 20:52:38 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1kLYEI-0006Fs-ML; Thu, 24 Sep 2020 22:52:38 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, oleg@redhat.com,
        x86@kernel.org, libffi-discuss@sourceware.org, luto@kernel.org,
        David.Laight@ACULAB.COM, mark.rutland@arm.com, mic@digikod.net,
        pavel@ucw.cz
Subject: Re: [PATCH v2 0/4] [RFC] Implement Trampoline File Descriptor
References: <20200916150826.5990-1-madvenka@linux.microsoft.com>
        <87v9gdz01h.fsf@mid.deneb.enyo.de>
        <96ea02df-4154-5888-1669-f3beeed60b33@linux.microsoft.com>
        <20200923014616.GA1216401@rani.riverdale.lan>
        <20200923091125.GB1240819@rani.riverdale.lan>
        <a742b9cd-4ffb-60e0-63b8-894800009700@linux.microsoft.com>
        <20200923195147.GA1358246@rani.riverdale.lan>
        <2ed2becd-49b5-7e76-9836-6a43707f539f@linux.microsoft.com>
Date:   Thu, 24 Sep 2020 22:52:38 +0200
In-Reply-To: <2ed2becd-49b5-7e76-9836-6a43707f539f@linux.microsoft.com>
        (Madhavan T. Venkataraman's message of "Thu, 24 Sep 2020 15:23:52
        -0500")
Message-ID: <87o8luvqw9.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Madhavan T. Venkataraman:

> Otherwise, using an ABI quirk or a calling convention side effect to
> load the PC into a GPR is, IMO, non-standard or non-compliant or
> non-approved or whatever you want to call it. I would be
> conservative and not use it. Who knows what incompatibility there
> will be with some future software or hardware features?

AArch64 PAC makes a backwards-incompatible change that touches this
area, but we'll see if they can actually get away with it.

In general, these things are baked into the ABI, even if they are not
spelled out explicitly in the psABI supplement.

> For instance, in the i386 example, we do a call without a matching return.
> Also, we use a pop to undo the call. Can anyone tell me if this kind of use
> is an ABI approved one?

Yes, for i386, this is completely valid from an ABI point of view.
It's equally possible to use a regular function call and just read the
return address that has been pushed to the stack.  Then there's no
stack mismatch at all.  Return stack predictors (including the one
used by SHSTK) also recognize the CALL 0 construct, so that's fine as
well.  The i386 psABI does not use function descriptors, and either
approach (out-of-line thunk or CALL 0) is in common use to materialize
the program counter in a register and construct the GOT pointer.

> If the kernel supplies this, then all applications and libraries can use
> it for all architectures with one single, simple API. Without this, each
> application/library has to roll its own solution for every architecture-ABI
> combo it wants to support.

Is there any other user for these type-generic trampolines?
Everything else I've seen generates machine code specific to the
function being called.  libffi is quite the outlier in my experience
because the trampoline calls a generic data-driven
marshaller/unmarshaller.  The other trampoline generators put this
marshalling code directly into the generated trampoline.

I'm still not convinced that this can't be done directly in libffi,
without kernel help.  Hiding the architecture-specific code in the
kernel doesn't reduce overall system complexity.

> As an example, in libffi:
>
> 	ffi_closure_alloc() would call alloc_tramp()
>
> 	ffi_prep_closure_loc() would call init_tramp()
>
> 	ffi_closure_free() would call free_tramp()
>
> That is it! It works on all the architectures supported in the kernel for
> trampfd.

ffi_prep_closure_loc would still need to check whether the trampoline
has been allocated by alloc_tramp because some applications supply
their own (executable and writable) mapping.  ffi_closure_alloc would
need to support different sizes (not matching the trampoline).  It's
also unclear to me to what extent software out there writes to the
trampoline data directly, bypassing the libffi API (the structs are
not opaque, after all).  And all the existing libffi memory management
code (including the embedded dlmalloc copy) would be needed to support
kernels without trampfd for years to come.

I very much agree that we have a gap in libffi when it comes to
JIT-less operation.  But I'm not convinced that kernel support is
needed to close it, or that it is even the right design.

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D6D26D068
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 03:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgIQBKO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 21:10:14 -0400
Received: from albireo.enyo.de ([37.24.231.21]:38836 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbgIQBKK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 21:10:10 -0400
X-Greylist: delayed 347 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2020 21:10:08 EDT
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kIiLL-0001Q0-41; Thu, 17 Sep 2020 01:04:11 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1kIiLK-0001qn-R0; Thu, 17 Sep 2020 03:04:10 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     madvenka@linux.microsoft.com
Cc:     kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, oleg@redhat.com,
        x86@kernel.org, libffi-discuss@sourceware.org
Subject: Re: [PATCH v2 0/4] [RFC] Implement Trampoline File Descriptor
References: <20200916150826.5990-1-madvenka@linux.microsoft.com>
Date:   Thu, 17 Sep 2020 03:04:10 +0200
In-Reply-To: <20200916150826.5990-1-madvenka@linux.microsoft.com> (madvenka's
        message of "Wed, 16 Sep 2020 10:08:22 -0500")
Message-ID: <87v9gdz01h.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* madvenka:

> Examples of trampolines
> =======================
>
> libffi (A Portable Foreign Function Interface Library):
>
> libffi allows a user to define functions with an arbitrary list of
> arguments and return value through a feature called "Closures".
> Closures use trampolines to jump to ABI handlers that handle calling
> conventions and call a target function. libffi is used by a lot
> of different applications. To name a few:
>
> 	- Python
> 	- Java
> 	- Javascript
> 	- Ruby FFI
> 	- Lisp
> 	- Objective C

libffi does not actually need this.  It currently collocates
trampolines and the data they need on the same page, but that's
actually unecessary.  It's possible to avoid doing this just by
changing libffi, without any kernel changes.

I think this has already been done for the iOS port.

> The code for trampoline X in the trampoline table is:
> 
> 	load	&code_table[X], code_reg
> 	load	(code_reg), code_reg
> 	load	&data_table[X], data_reg
> 	load	(data_reg), data_reg
> 	jump	code_reg
> 
> The addresses &code_table[X] and &data_table[X] are baked into the
> trampoline code. So, PC-relative data references are not needed. The user
> can modify code_table[X] and data_table[X] dynamically.

You can put this code into the libffi shared object and map it from
there, just like the rest of the libffi code.  To get more
trampolines, you can map the page containing the trampolines multiple
times, each instance preceded by a separate data page with the control
information.

I think the previous patch submission has also resulted in several
comments along those lines, so I'm not sure why you are reposting
this.

> libffi
> ======
>
> I have implemented my solution for libffi and provided the changes for
> X86 and ARM, 32-bit and 64-bit. Here is the reference patch:
>
> http://linux.microsoft.com/~madvenka/libffi/libffi.v2.txt

The URL does not appear to work, I get a 403 error.

> If the trampfd patchset gets accepted, I will send the libffi changes
> to the maintainers for a review. BTW, I have also successfully executed
> the libffi self tests.

I have not seen your libffi changes, but I expect that the complexity
is about the same as a userspace-only solution.


Cc:ing libffi upstream for awareness.  The start of the thread is
here:

<https://lore.kernel.org/linux-api/20200916150826.5990-1-madvenka@linux.microsoft.com/>

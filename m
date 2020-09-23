Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA62D27546F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 11:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgIWJXh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 05:23:37 -0400
Received: from mother.openwall.net ([195.42.179.200]:58315 "HELO
        mother.openwall.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726799AbgIWJXh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 05:23:37 -0400
Received: (qmail 23821 invoked from network); 23 Sep 2020 09:16:12 -0000
Received: from localhost (HELO pvt.openwall.com) (127.0.0.1)
  by localhost with SMTP; 23 Sep 2020 09:16:12 -0000
Received: by pvt.openwall.com (Postfix, from userid 503)
        id 1F9FBAB844; Wed, 23 Sep 2020 11:14:57 +0200 (CEST)
Date:   Wed, 23 Sep 2020 11:14:57 +0200
From:   Solar Designer <solar@openwall.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     madvenka@linux.microsoft.com, kernel-hardening@lists.openwall.com,
        linux-api@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, oleg@redhat.com,
        x86@kernel.org, luto@kernel.org, David.Laight@ACULAB.COM,
        fweimer@redhat.com, mark.rutland@arm.com, mic@digikod.net,
        Rich Felker <dalias@libc.org>
Subject: Re: [PATCH v2 0/4] [RFC] Implement Trampoline File Descriptor
Message-ID: <20200923091456.GA6177@openwall.com>
References: <20200922215326.4603-1-madvenka@linux.microsoft.com> <20200923081426.GA30279@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923081426.GA30279@amd>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 23, 2020 at 10:14:26AM +0200, Pavel Machek wrote:
> > Introduction
> > ============
> > 
> > Dynamic code is used in many different user applications. Dynamic code is
> > often generated at runtime. Dynamic code can also just be a pre-defined
> > sequence of machine instructions in a data buffer. Examples of dynamic
> > code are trampolines, JIT code, DBT code, etc.
> > 
> > Dynamic code is placed either in a data page or in a stack page. In order
> > to execute dynamic code, the page it resides in needs to be mapped with
> > execute permissions. Writable pages with execute permissions provide an
> > attack surface for hackers. Attackers can use this to inject malicious
> > code, modify existing code or do other harm.
> > 
> > To mitigate this, LSMs such as SELinux implement W^X. That is, they may not
> > allow pages to have both write and execute permissions. This prevents
> > dynamic code from executing and blocks applications that use it. To allow
> > genuine applications to run, exceptions have to be made for them (by setting
> > execmem, etc) which opens the door to security issues.
> > 
> > The W^X implementation today is not complete. There exist many user level
> > tricks that can be used to load and execute dynamic code. E.g.,
> > 
> > - Load the code into a file and map the file with R-X.
> > 
> > - Load the code in an RW- page. Change the permissions to R--. Then,
> >   change the permissions to R-X.
> > 
> > - Load the code in an RW- page. Remap the page with R-X to get a separate
> >   mapping to the same underlying physical page.
> > 
> > IMO, these are all security holes as an attacker can exploit them to inject
> > his own code.
> 
> IMO, you are smoking crack^H^H very seriously misunderstanding what
> W^X is supposed to protect from.
> 
> W^X is not supposed to protect you from attackers that can already do
> system calls. So loading code into a file then mapping the file as R-X
> is in no way security hole in W^X.
> 
> If you want to provide protection from attackers that _can_ do system
> calls, fine, but please don't talk about W^X and please specify what
> types of attacks you want to prevent and why that's good thing.

On one hand, Pavel is absolutely right.  It is ridiculous to say that
"these are all security holes as an attacker can exploit them to inject
his own code."

On the other hand, "what W^X is supposed to protect from" depends on how
the term W^X is defined (historically, by PaX and OpenBSD).  It may be
that W^X is partially not a feature to defeat attacks per se, but also a
policy enforcement feature preventing use of dangerous techniques (JIT).

Such policy might or might not make sense.  It might make sense for ease
of reasoning, e.g. "I've flipped this setting, and now I'm certain the
system doesn't have JIT within a process (can still have it through
dynamically creating and invoking an entire new program), so there are
no opportunities for an attacker to inject code nor generate previously
non-existing ROP gadgets into an executable mapping within a process."

I do find it questionable whether such policy and such reasoning make
sense beyond academia.

Then, there might be even more ways in which W^X is not perfect enough
to enable such reasoning.  What about using ptrace(2) to inject code?
Should enabling W^X also disable ability to debug programs by non-root?
We already have Yama ptrace_scope, which can achieve that at the highest
setting, although that's rather inconvenient and is probably unexpected
by most to be a requirement for having (ridiculously?) full W^X allowing
for the academic reasoning.

Personally, I am for policies that make more practical sense.  For
example, years ago I advocated here on kernel-hardening that we should
have a mode where ELF flags enabling/disabling executable stack are
ignored, and non-executable stack is always enforced.  This should also
be extended to default (at program startup) permissions on more than
just stack (but also on .bss, typical libcs' heap allocations, etc.)
However, I am not convinced there's enough value in extending the policy
to restricting explicit uses of mprotect(2).

Yes, PaX did that, and its emutramp.txt said "runtime code generation is
by its nature incompatible with PaX's PAGEEXEC/SEGMEXEC and MPROTECT
features, therefore the real solution is not in emulation but by
designing a kernel API for runtime code generation and modifying
userland to make use of it."  However, not being convinced in the
MPROTECT feature having enough practical value, I am also not convinced
"a kernel API for runtime code generation and modifying userland to make
use of it" is the way to go.

Having static instead of dynamically-generated trampolines in userland
code where possible (and making other userland/ABI changes to make that
possible in more/all cases) is an obvious improvement, and IMO should be
a priority over the above.

While I share my opinion here, I don't mean that to block Madhavan's
work.  I'd rather defer to people more knowledgeable in current userland
and ABI issues/limitations and plans on dealing with those, especially
to Florian Weimer.  I haven't seen Florian say anything specific for or
against Madhavan's proposal, and I'd like to.  (Have I missed that?)
It'd be wrong to introduce a kernel API that userland doesn't need, and
it'd be right to introduce one that userland actually intends to use.

I've also added Rich Felker to CC here, for musl libc and its possible
intent to use the proposed API.  (My guess is there's no such need, and
thus no intent, but Rich might want to confirm that or correct me.)

Alexander

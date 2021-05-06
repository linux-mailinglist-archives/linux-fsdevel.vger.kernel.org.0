Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E12375979
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 May 2021 19:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236424AbhEFRfL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 May 2021 13:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236288AbhEFRfB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 May 2021 13:35:01 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DF9C061574
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 May 2021 10:34:02 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id lj11-20020a17090b344bb029015bc3073608so3883478pjb.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 May 2021 10:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q86nNhjQAX/9YA17XxCEC8XTgKMZ0iQVDMWn6ZwwmV4=;
        b=WLAqQoqw48jOzw8f9p6prW1rJg+FyYJR569JKscj76Ppy52fovesCTQzh4jjLM6cFG
         oA2zCTxbtBPlmwTl2CsL7ant2pq37h+3CfJGFY8HReNZg9qxKHwYWxMH7Uv9yQexDxUv
         n2rE5uY4GJi+O+1caz3ajBWbJLxgfRdZXvX84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q86nNhjQAX/9YA17XxCEC8XTgKMZ0iQVDMWn6ZwwmV4=;
        b=ZDZ2A71zEaSbnaYM9yjkmxxinl/YY8STn92qb2EXp9YTuo0RC+MQRCP1LId/gpTW+W
         HrKEpBq+FZgLSqUHOXjxXliw2jfkJSaX1ZsLI4egH/8ceOPaGLmMvSqFu8ZiqUOjOZm1
         iU1po97RgkYhRj+VJQrM4VSSnDsFAEo8Z++jrpDCrw/oI8v0/SJwRTtJuq4TR/RxjxM8
         AvTjk9f5P8FeHxijBYNLiDDHKCxEQYrFXKhrgtTFJ58FQEqacuJGCiKI0335oKqGyy9a
         WfF7AzOyBoKILK0sqFEE2dmH6ZEvM0edLD64rmTC4IYOBTQwhxO+qn0HFUeerGlovbRe
         ZAeQ==
X-Gm-Message-State: AOAM530woHGrWw+Kw2Vq/DSVqxqUEP+j6ntlvJkTzmQOj0KSM9OUY8er
        YeHvGdT2bckAZ9b9FtCGjNY5Dg==
X-Google-Smtp-Source: ABdhPJxGZgYr7hOPC3bWDKZ6efqMzDck/orngaQkbfLWsHj/YvSX/6GL/dLtiJuMO2v8NNa6bgKivA==
X-Received: by 2002:a17:90a:f283:: with SMTP id fs3mr19998936pjb.122.1620322441400;
        Thu, 06 May 2021 10:34:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t12sm2414795pjw.51.2021.05.06.10.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 10:34:00 -0700 (PDT)
Date:   Thu, 6 May 2021 10:33:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v18 0/9] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <202105060916.ECDEC21@keescook>
References: <20210303162209.8609-1-rppt@kernel.org>
 <20210505120806.abfd4ee657ccabf2f221a0eb@linux-foundation.org>
 <de27bfae0f4fdcbb0bb4ad17ec5aeffcd774c44b.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de27bfae0f4fdcbb0bb4ad17ec5aeffcd774c44b.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 06, 2021 at 08:26:41AM -0700, James Bottomley wrote:
> On Wed, 2021-05-05 at 12:08 -0700, Andrew Morton wrote:
> > On Wed,  3 Mar 2021 18:22:00 +0200 Mike Rapoport <rppt@kernel.org>
> > wrote:
> > 
> > > This is an implementation of "secret" mappings backed by a file
> > > descriptor.

tl;dr: I like this series, I think there are number of clarifications
needed, though. See below.

> > > 
> > > The file descriptor backing secret memory mappings is created using
> > > a dedicated memfd_secret system call The desired protection mode
> > > for the memory is configured using flags parameter of the system
> > > call. The mmap() of the file descriptor created with memfd_secret()
> > > will create a "secret" memory mapping. The pages in that mapping
> > > will be marked as not present in the direct map and will be present
> > > only in the page table of the owning mm.
> > > 
> > > Although normally Linux userspace mappings are protected from other
> > > users, such secret mappings are useful for environments where a
> > > hostile tenant is trying to trick the kernel into giving them
> > > access to other tenants mappings.
> > 
> > I continue to struggle with this and I don't recall seeing much
> > enthusiasm from others.  Perhaps we're all missing the value point
> > and some additional selling is needed.
> > 
> > Am I correct in understanding that the overall direction here is to
> > protect keys (and perhaps other things) from kernel bugs?  That if
> > the kernel was bug-free then there would be no need for this
> > feature?  If so, that's a bit sad.  But realistic I guess.
> 
> Secret memory really serves several purposes. The "increase the level
> of difficulty of secret exfiltration" you describe.  And, as you say,
> if the kernel were bug free this wouldn't be necessary.
> 
> But also:
> 
>    1. Memory safety for user space code.  Once the secret memory is
>       allocated, the user can't accidentally pass it into the kernel to be
>       transmitted somewhere.

In my first read through, I didn't see how cross-userspace operations
were blocked, but it looks like it's the various gup paths where
{vma,page}_is_secretmem() is called. (Thank you for the self-test! That
helped me follow along.) I think this access pattern should be more
clearly spelled out in the cover later (i.e. "This will block things
like process_vm_readv()").

I like the results (inaccessible outside the process), though I suspect
this will absolutely melt gdb or other ptracers that try to see into
the memory. Don't get me wrong, I'm a big fan of such concepts[0], but
I see nothing in the cover letter about it (e.g. the effects on "ptrace"
or "gdb" are not mentioned.)

There is also a risk here of this becoming a forensics nightmare:
userspace malware will just download their entire executable region
into a memfd_secret region. Can we, perhaps, disallow mmap/mprotect
with PROT_EXEC when vma_is_secretmem()? The OpenSSL example, for
example, certainly doesn't need PROT_EXEC.

What's happening with O_CLOEXEC in this code? I don't see that mentioned
in the cover letter either. Why is it disallowed? That seems a strange
limitation for something trying to avoid leaking secrets into other
processes.

And just so I'm sure I understand: if a vma_is_secretmem() check is
missed in future mm code evolutions, it seems there is nothing to block
the kernel from accessing the contents directly through copy_from_user()
via the userspace virtual address, yes?

>    2. It also serves as a basis for context protection of virtual
>       machines, but other groups are working on this aspect, and it is
>       broadly similar to the secret exfiltration from the kernel problem.
> 
> > 
> > Is this intended to protect keys/etc after the attacker has gained
> > the ability to run arbitrary kernel-mode code?  If so, that seems
> > optimistic, doesn't it?
> 
> Not exactly: there are many types of kernel attack, but mostly the
> attacker either manages to effect a privilege escalation to root or
> gets the ability to run a ROP gadget.  The object of this code is to be
> completely secure against root trying to extract the secret (some what
> similar to the lockdown idea), thus defeating privilege escalation and
> to provide "sufficient" protection against ROP gadgets.
> 
> The ROP gadget thing needs more explanation: the usual defeatist
> approach is to say that once the attacker gains the stack, they can do
> anything because they can find enough ROP gadgets to be turing
> complete.  However, in the real world, given the kernel stack size
> limit and address space layout randomization making finding gadgets
> really hard, usually the attacker gets one or at most two gadgets to
> string together.  Not having any in-kernel primitive for accessing
> secret memory means the one gadget ROP attack can't work.  Since the
> only way to access secret memory is to reconstruct the missing mapping
> entry, the attacker has to recover the physical page and insert a PTE
> pointing to it in the kernel and then retrieve the contents.  That
> takes at least three gadgets which is a level of difficulty beyond most
> standard attacks.

As for protecting against exploited kernel flaws I also see benefits
here. While the kernel is already blocked from directly reading contents
from userspace virtual addresses (i.e. SMAP), this feature does help by
blocking the kernel from directly reading contents via the direct map
alias. (i.e. this feature is a specialized version of XPFO[1], which
tried to do this for ALL user memory.) So in that regard, yes, this has
value in the sense that to perform exfiltration, an attacker would need
a significant level of control over kernel execution or over page table
contents.

Sufficient control over PTE allocation and positioning is possible
without kernel execution control[3], and "only" having an arbitrary
write primitive can lead to direct PTE control. Because of this, it
would be nice to have page tables strongly protected[2] in the kernel.
They remain a viable "data only" attack given a sufficiently "capable"
write flaw.

I would argue that page table entries are a more important asset to
protect than userspace secrets, but given the difficulties with XPFO
and the not-yet-available PKS I can understand starting here. It does,
absolutely, narrow the ways exploits must be written to exfiltrate secret
contents. (We are starting to now constrict[4] many attack methods
into attacking the page table itself, which is good in the sense that
protecting page tables will be a big win, and bad in the sense that
focusing attack research on page tables means we're going to see some
very powerful attacks.)

> > I think that a very complete description of the threats which this
> > feature addresses would be helpful.  
> 
> It's designed to protect against three different threats:
> 
>    1. Detection of user secret memory mismanagement

I would say "cross-process secret userspace memory exposures" (via a
number of common interfaces by blocking it at the GUP level).

>    2. significant protection against privilege escalation

I don't see how this series protects against privilege escalation. (It
protects against exfiltration.) Maybe you mean include this in the first
bullet point (i.e. "cross-process secret userspace memory exposures,
even in the face of privileged processes")?

>    3. enhanced protection (in conjunction with all the other in-kernel
>       attack prevention systems) against ROP attacks.

Same here, I don't see it preventing ROP, but I see it making "simple"
ROP insufficient to perform exfiltration.

-Kees

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/security/yama/yama_lsm.c?h=v5.12#n410
[1] https://lore.kernel.org/linux-mm/cover.1554248001.git.khalid.aziz@oracle.com/
[2] https://lore.kernel.org/lkml/20210505003032.489164-1-rick.p.edgecombe@intel.com/
[3] https://googleprojectzero.blogspot.com/2015/03/exploiting-dram-rowhammer-bug-to-gain.html
[4] https://git.kernel.org/linus/cf68fffb66d60d96209446bfc4a15291dc5a5d41

-- 
Kees Cook

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB8931C265
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 20:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhBOTVl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 14:21:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:49872 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229991AbhBOTVf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 14:21:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613416848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=35iSk0+5UfxNhbQoMoqK8Z0u+AvwuK5VeLDZ0BFtGgc=;
        b=LxudusPDnEIzx32bpsNd8eGk9aEHEp8nORbgbhfo9m/WaYQJNvskWIV49SwUk+3e+wUm6W
        bvkuJfdiurilR7t9l+AqCl48/0xWlWnh1jxDaWj32SfJk9fDbkh0PhlICshQRWBYaiM9H0
        Cssa+KhpPwQxypJN/O8+L/ThpHbYF+4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C9B2BAC32;
        Mon, 15 Feb 2021 19:20:47 +0000 (UTC)
Date:   Mon, 15 Feb 2021 20:20:45 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: Re: [PATCH v17 07/10] mm: introduce memfd_secret system call to
 create "secret" memory areas
Message-ID: <YCrJjYmr7A2nO6lA@dhcp22.suse.cz>
References: <20210214091954.GM242749@kernel.org>
 <052DACE9-986B-424C-AF8E-D6A4277DE635@redhat.com>
 <244f86cba227fa49ca30cd595c4e5538fe2f7c2b.camel@linux.ibm.com>
 <YCo7TqUnBdgJGkwN@dhcp22.suse.cz>
 <be1d821d3f0aec24ad13ca7126b4359822212eb0.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be1d821d3f0aec24ad13ca7126b4359822212eb0.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 15-02-21 10:14:43, James Bottomley wrote:
> On Mon, 2021-02-15 at 10:13 +0100, Michal Hocko wrote:
> > On Sun 14-02-21 11:21:02, James Bottomley wrote:
> > > On Sun, 2021-02-14 at 10:58 +0100, David Hildenbrand wrote:
> > > [...]
> > > > > And here we come to the question "what are the differences that
> > > > > justify a new system call?" and the answer to this is very
> > > > > subjective. And as such we can continue bikeshedding forever.
> > > > 
> > > > I think this fits into the existing memfd_create() syscall just
> > > > fine, and I heard no compelling argument why it shouldn‘t. That‘s
> > > > all I can say.
> > > 
> > > OK, so let's review history.  In the first two incarnations of the
> > > patch, it was an extension of memfd_create().  The specific
> > > objection by Kirill Shutemov was that it doesn't share any code in
> > > common with memfd and so should be a separate system call:
> > > 
> > > https://lore.kernel.org/linux-api/20200713105812.dnwtdhsuyj3xbh4f@box/
> > 
> > Thanks for the pointer. But this argument hasn't been challenged at
> > all. It hasn't been brought up that the overlap would be considerable
> > higher by the hugetlb/sealing support. And so far nobody has claimed
> > those combinations as unviable.
> 
> Kirill is actually interested in the sealing path for his KVM code so
> we took a look.  There might be a two line overlap in memfd_create for
> the seal case, but there's no real overlap in memfd_add_seals which is
> the bulk of the code.  So the best way would seem to lift the inode ...
> -> seals helpers to be non-static so they can be reused and roll our
> own add_seals.

These are implementation details which are not really relevant to the
API IMHO. 

> I can't see a use case at all for hugetlb support, so it seems to be a
> bit of an angels on pin head discussion.  However, if one were to come
> along handling it in the same way seems reasonable.

Those angels have made their way to mmap, System V shm, memfd_create and
other MM interfaces which have never envisioned when introduced. Hugetlb
pages to back guest memory is quite a common usecase so why do you think
those guests wouldn't like to see their memory be "secret"?

As I've said in my last response (YCZEGuLK94szKZDf@dhcp22.suse.cz), I am
not going to argue all these again. I have made my point and you are
free to take it or leave it.

> > > The other objection raised offlist is that if we do use
> > > memfd_create, then we have to add all the secret memory flags as an
> > > additional ioctl, whereas they can be specified on open if we do a
> > > separate system call.  The container people violently objected to
> > > the ioctl because it can't be properly analysed by seccomp and much
> > > preferred the syscall version.
> > > 
> > > Since we're dumping the uncached variant, the ioctl problem
> > > disappears but so does the possibility of ever adding it back if we
> > > take on the container peoples' objection.  This argues for a
> > > separate syscall because we can add additional features and extend
> > > the API with flags without causing anti-ioctl riots.
> > 
> > I am sorry but I do not understand this argument.
> 
> You don't understand why container guarding technology doesn't like
> ioctls?

No, I did not see where the ioctl argument came from.

[...]

> >  What kind of flags are we talking about and why would that be a
> > problem with memfd_create interface? Could you be more specific
> > please?
> 
> You mean what were the ioctl flags in the patch series linked above? 
> They were SECRETMEM_EXCLUSIVE and SECRETMEM_UNCACHED in patch 3/5. 

OK I see. How many potential modes are we talking about? A few or
potentially many?

> They were eventually dropped after v10, because of problems with
> architectural semantics, with the idea that it could be added back
> again if a compelling need arose:
> 
> https://lore.kernel.org/linux-api/20201123095432.5860-1-rppt@kernel.org/
> 
> In theory the extra flags could be multiplexed into the memfd_create
> flags like hugetlbfs is but with 32 flags and a lot already taken it
> gets messy for expansion.  When we run out of flags the first question
> people will ask is "why didn't you do separate system calls?".

OK, I do not necessarily see a lack of flag space a problem. I can be
wrong here but I do not see how that would be solved by a separate
syscall when it sounds rather forseeable that many modes supported by
memfd_create will eventually find their way to a secret memory as well.
If for no other reason, secret memory is nothing really special. It is
just a memory which is not mapped to the kernel via 1:1 mapping. That's
it. And that can be applied to any memory provided to the userspace.

But I am repeating myself again here so I better stop.
-- 
Michal Hocko
SUSE Labs

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE07318957
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Feb 2021 12:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhBKLYK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Feb 2021 06:24:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:40392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231294AbhBKLVJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Feb 2021 06:21:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14FAC64DCF;
        Thu, 11 Feb 2021 11:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613042428;
        bh=rXRK0H6A/K2Wb0tbxmc7ZILxeVB76yptr2cmsMFQE74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t3VWHvs0bXUxcCXOc97N7vSXyLqVUcEV92kaL6OdVxecAKxAQ7ns6LLG+vegpOVde
         U9dBh6sezDjn5D92Ll5noX1Vr+yCYEIk5R0rIUlhKrjSS7aOZ0i+PaR/+DQIweUHh6
         8FzOzWyaxJsUOVv2GFc6tXB0iA4Kh3UCZBlISlSmmeVmiew2dh6clqSD3WkV3s59X7
         15MQmJD2s7JLI/6iNb4Cojk2vx4RU0Y7gohP8KiCudLNjAvDZFFfG0p33iCbt4dNcP
         wEYFcHPp1StbE/lV4MGjTaz8WVMajl7z6z/1pA+KZbglGlxEBvUgFNkTEZP1OvrqS8
         dLaGA+Ls37rug==
Date:   Thu, 11 Feb 2021 13:20:08 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        James Bottomley <jejb@linux.ibm.com>,
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
Message-ID: <20210211112008.GH242749@kernel.org>
References: <20210208084920.2884-1-rppt@kernel.org>
 <20210208084920.2884-8-rppt@kernel.org>
 <YCEXMgXItY7xMbIS@dhcp22.suse.cz>
 <20210208212605.GX242749@kernel.org>
 <YCJMDBss8Qhha7g9@dhcp22.suse.cz>
 <20210209090938.GP299309@linux.ibm.com>
 <YCKLVzBR62+NtvyF@dhcp22.suse.cz>
 <20210211071319.GF242749@kernel.org>
 <YCTtSrCEvuBug2ap@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCTtSrCEvuBug2ap@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 11, 2021 at 09:39:38AM +0100, Michal Hocko wrote:
> On Thu 11-02-21 09:13:19, Mike Rapoport wrote:
> > On Tue, Feb 09, 2021 at 02:17:11PM +0100, Michal Hocko wrote:
> > > On Tue 09-02-21 11:09:38, Mike Rapoport wrote:
> [...]
> > > > Citing my older email:
> > > > 
> > > >     I've hesitated whether to continue to use new flags to memfd_create() or to
> > > >     add a new system call and I've decided to use a new system call after I've
> > > >     started to look into man pages update. There would have been two completely
> > > >     independent descriptions and I think it would have been very confusing.
> > > 
> > > Could you elaborate? Unmapping from the kernel address space can work
> > > both for sealed or hugetlb memfds, no? Those features are completely
> > > orthogonal AFAICS. With a dedicated syscall you will need to introduce
> > > this functionality on top if that is required. Have you considered that?
> > > I mean hugetlb pages are used to back guest memory very often. Is this
> > > something that will be a secret memory usecase?
> > > 
> > > Please be really specific when giving arguments to back a new syscall
> > > decision.
> > 
> > Isn't "syscalls have completely independent description" specific enough?
> 
> No, it's not as you can see from questions I've had above. More on that
> below.
> 
> > We are talking about API here, not the implementation details whether
> > secretmem supports large pages or not.
> > 
> > The purpose of memfd_create() is to create a file-like access to memory.
> > The purpose of memfd_secret() is to create a way to access memory hidden
> > from the kernel.
> > 
> > I don't think overloading memfd_create() with the secretmem flags because
> > they happen to return a file descriptor will be better for users, but
> > rather will be more confusing.
> 
> This is quite a subjective conclusion. I could very well argue that it
> would be much better to have a single syscall to get a fd backed memory
> with spedific requirements (sealing, unmapping from the kernel address
> space). 

> Neither of us would be clearly right or wrong.

100% agree :)

> A more important point is a future extensibility and usability, though.
> So let's just think of few usecases I have outlined above. Is it
> unrealistic to expect that secret memory should be sealable? What about
> hugetlb? Because if the answer is no then a new API is a clear win as the
> combination of flags would never work and then we would just suffer from
> the syscall multiplexing without much gain. On the other hand if
> combination of the functionality is to be expected then you will have to
> jam it into memfd_create and copy the interface likely causing more
> confusion. See what I mean?

I see your point, but I think that overloading memfd_create definitely gets
us into syscall multiplexing from day one and support for seals and huge
pages in the secretmem will not make it less of a multiplexer.

Sealing is anyway controlled via fcntl() and I don't think
MFD_ALLOW_SEALING makes much sense for the secretmem because it is there to
prevent rogue file sealing in tmpfs/hugetlbfs.

As for the huge pages, I'm not sure at all that supporting huge pages in
secretmem will involve hugetlbfs. And even if yes, adding SECRETMEM_HUGE
flag seems to me less confusing than saying "from kernel x.y you can use
MFD_CREATE | MFD_SECRET | MFD_HUGE" etc for all possible combinations.
 
> I by no means do not insist one way or the other but from what I have
> seen so far I have a feeling that the interface hasn't been thought
> through enough.

It has been, but we have different thoughts about it ;-)

-- 
Sincerely yours,
Mike.

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1207031867F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Feb 2021 09:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhBKItW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Feb 2021 03:49:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:40612 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229678AbhBKIsw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Feb 2021 03:48:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613032781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yBq3iw3Hxf5kl5qFk9wqJn0npOtP/MF9I3GQgQJS4pk=;
        b=u961p/CVGwFkVGfzw2vxHz/DcUNkZOUsf1lthOsGgL6mzdvVuiB6SuvgEKE7XlfMey/5G0
        1xCda7eopAWyYPkO03tmFVZjkKh/uPhEA4bdAQF0mz9hK2L7xX/997Rt4ZchBs+DBDQuoF
        YHCF391jUf7tv4cSybYQ6okEIBckLRU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BFF9DAE36;
        Thu, 11 Feb 2021 08:39:40 +0000 (UTC)
Date:   Thu, 11 Feb 2021 09:39:38 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Rapoport <rppt@kernel.org>
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
Message-ID: <YCTtSrCEvuBug2ap@dhcp22.suse.cz>
References: <20210208084920.2884-1-rppt@kernel.org>
 <20210208084920.2884-8-rppt@kernel.org>
 <YCEXMgXItY7xMbIS@dhcp22.suse.cz>
 <20210208212605.GX242749@kernel.org>
 <YCJMDBss8Qhha7g9@dhcp22.suse.cz>
 <20210209090938.GP299309@linux.ibm.com>
 <YCKLVzBR62+NtvyF@dhcp22.suse.cz>
 <20210211071319.GF242749@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211071319.GF242749@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 11-02-21 09:13:19, Mike Rapoport wrote:
> On Tue, Feb 09, 2021 at 02:17:11PM +0100, Michal Hocko wrote:
> > On Tue 09-02-21 11:09:38, Mike Rapoport wrote:
[...]
> > > Citing my older email:
> > > 
> > >     I've hesitated whether to continue to use new flags to memfd_create() or to
> > >     add a new system call and I've decided to use a new system call after I've
> > >     started to look into man pages update. There would have been two completely
> > >     independent descriptions and I think it would have been very confusing.
> > 
> > Could you elaborate? Unmapping from the kernel address space can work
> > both for sealed or hugetlb memfds, no? Those features are completely
> > orthogonal AFAICS. With a dedicated syscall you will need to introduce
> > this functionality on top if that is required. Have you considered that?
> > I mean hugetlb pages are used to back guest memory very often. Is this
> > something that will be a secret memory usecase?
> > 
> > Please be really specific when giving arguments to back a new syscall
> > decision.
> 
> Isn't "syscalls have completely independent description" specific enough?

No, it's not as you can see from questions I've had above. More on that
below.

> We are talking about API here, not the implementation details whether
> secretmem supports large pages or not.
> 
> The purpose of memfd_create() is to create a file-like access to memory.
> The purpose of memfd_secret() is to create a way to access memory hidden
> from the kernel.
> 
> I don't think overloading memfd_create() with the secretmem flags because
> they happen to return a file descriptor will be better for users, but
> rather will be more confusing.

This is quite a subjective conclusion. I could very well argue that it
would be much better to have a single syscall to get a fd backed memory
with spedific requirements (sealing, unmapping from the kernel address
space). Neither of us would be clearly right or wrong. A more important
point is a future extensibility and usability, though. So let's just
think of few usecases I have outlined above. Is it unrealistic to expect
that secret memory should be sealable? What about hugetlb? Because if
the answer is no then a new API is a clear win as the combination of
flags would never work and then we would just suffer from the syscall 
multiplexing without much gain. On the other hand if combination of the
functionality is to be expected then you will have to jam it into
memfd_create and copy the interface likely causing more confusion. See
what I mean?

I by no means do not insist one way or the other but from what I have
seen so far I have a feeling that the interface hasn't been thought
through enough. Sure you have landed with fd based approach and that
seems fair. But how to get that fd seems to still have some gaps IMHO.
-- 
Michal Hocko
SUSE Labs

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0B5319638
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 00:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhBKXAd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Feb 2021 18:00:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:46170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229960AbhBKXAa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Feb 2021 18:00:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9786060201;
        Thu, 11 Feb 2021 22:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613084387;
        bh=nwfYRIB3XPlsF/osjlzU/dWbZib+rLZZQ1WRBOk4t7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JdTTKx4aSQ8hkEPYzAOR1T3elAMsY1CYPCHGk93b9t2QtZeB+UpZbCQ03b67p01io
         0CPfT25fR779DcxgF9uIUTbjBbmoENZYCKOgteFMgvosv7pjW8MGdn6LH4gBSFgHUj
         C+GlOtsFxDaZddY+gooLTQRqYN+gXU6P63ZLyimnf5sV79XHXrhf3OPikJO5K+WqVz
         aFti4o9fRlC17Dt/5lLws2NpSmnDTkBYt8SfmbE5H+3Z3VRlSLutY3g5cUNrQHCicG
         r70nCETUN3ChfKxxOHlvQhMKLRsiVdYThDq3/QJpacz+OX3DjQCWEhTrnn+5V3ktfc
         vVYfnIhIRPWBw==
Date:   Fri, 12 Feb 2021 00:59:29 +0200
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
Message-ID: <20210211225929.GK242749@kernel.org>
References: <20210208084920.2884-8-rppt@kernel.org>
 <YCEXMgXItY7xMbIS@dhcp22.suse.cz>
 <20210208212605.GX242749@kernel.org>
 <YCJMDBss8Qhha7g9@dhcp22.suse.cz>
 <20210209090938.GP299309@linux.ibm.com>
 <YCKLVzBR62+NtvyF@dhcp22.suse.cz>
 <20210211071319.GF242749@kernel.org>
 <YCTtSrCEvuBug2ap@dhcp22.suse.cz>
 <20210211112008.GH242749@kernel.org>
 <YCUjck0I8qgjB24i@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCUjck0I8qgjB24i@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 11, 2021 at 01:30:42PM +0100, Michal Hocko wrote:
> On Thu 11-02-21 13:20:08, Mike Rapoport wrote:
> [...]
> > Sealing is anyway controlled via fcntl() and I don't think
> > MFD_ALLOW_SEALING makes much sense for the secretmem because it is there to
> > prevent rogue file sealing in tmpfs/hugetlbfs.
> 
> This doesn't really match my understanding. The primary usecase for the
> sealing is to safely and predictably coordinate over shared memory. I
> absolutely do not see why this would be incompatible with an additional
> requirement to unmap the memory from the kernel to prevent additional
> interference from the kernel side. Quite contrary it looks like a very
> nice extension to this model.

I didn't mean that secretmem should not support sealing. I meant that
MFD_ALLOW_SEALING flag does not make sense. Unlike tmpfs, the secretmem fd
does not need protection from somebody unexpectedly sealing it.

> > As for the huge pages, I'm not sure at all that supporting huge pages in
> > secretmem will involve hugetlbfs.
> 
> Have a look how hugetlb proliferates through our MM APIs. I strongly
> suspect this is strong signal that this won't be any different.
> 
> > And even if yes, adding SECRETMEM_HUGE
> > flag seems to me less confusing than saying "from kernel x.y you can use
> > MFD_CREATE | MFD_SECRET | MFD_HUGE" etc for all possible combinations.
> 
> I really fail to see your point. This is a standard model we have. It is
> quite natural that flags are added. Moreover adding a new syscall will
> not make it any less of a problem.

Nowadays adding a new syscall is not as costly as it used to be. And I
think it'll provide better extensibility when new features would be added
to secretmem. 

For instance, for creating a secretmem fd backed with sealing we'd have

	memfd_secretm(SECRETMEM_HUGE);

rather than

	memfd_create(MFD_ALLOW_SEALING | MFD_HUGETLB | MFD_SECRET);


Besides, if we overload memfd_secret we add complexity to flags validation
of allowable flag combinations even with the simplest initial
implementation.
And what it will become when more features are added to secretmem?
 
> > > I by no means do not insist one way or the other but from what I have
> > > seen so far I have a feeling that the interface hasn't been thought
> > > through enough.
> > 
> > It has been, but we have different thoughts about it ;-)
> 
> Then you must be carrying a lot of implicit knowledge which I want you
> to document.

I don't have any implicit knowledge, we just have a different perspective.

-- 
Sincerely yours,
Mike.

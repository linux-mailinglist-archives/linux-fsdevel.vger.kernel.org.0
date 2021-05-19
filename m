Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81DD33885B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 May 2021 05:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353115AbhESDwP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 23:52:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:34562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238952AbhESDwO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 23:52:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A22160698;
        Wed, 19 May 2021 03:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621396255;
        bh=OHqMi61ZqX4ySIrfnisk/+K7U7qM/mCXhP8jYMj1P84=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YYAE07pQhQM8o7Wp7sXA/L3u7rt0s5M+ViFahOF7b94Od8vLSvNm59LWBWGahD5Td
         //07qQooCrEAvIEElW9/DslmDL8J4D2K38vvD2y4ZIFnrbiE6mYEZP+qyMTJRbPQm4
         ng7WKl+CsCMDiF9ZTD5yz79TwuhQ2Bmem6NORzx5sZia3oO9BeRuVTw7r2+9JG4Bn1
         Y5+OK1WrxaIkzC5MuMQxoLI7XHdiQBfR4r9qxVwgO96jZTvNivIbQyXbGEcZ1Bo5sU
         2a/tc6+FwBn7EtnfaddaIUUJMDcK0N4p6TdNf2HQST//b3D2Bl+XNTSL1haulJxm4I
         yH1MAff7bIYkg==
Date:   Wed, 19 May 2021 06:50:37 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Hagen Paul Pfeifer <hagen@jauu.net>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
Subject: Re: [PATCH v20 4/7] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <YKSLDYqwmANLcQJt@kernel.org>
References: <20210518072034.31572-1-rppt@kernel.org>
 <20210518072034.31572-5-rppt@kernel.org>
 <20210518174422.399ad118a051fe4c5b11d7ba@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518174422.399ad118a051fe4c5b11d7ba@linux-foundation.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 18, 2021 at 05:44:22PM -0700, Andrew Morton wrote:
> On Tue, 18 May 2021 10:20:31 +0300 Mike Rapoport <rppt@kernel.org> wrote:
> 
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Introduce "memfd_secret" system call with the ability to create memory
> > areas visible only in the context of the owning process and not mapped not
> > only to other processes but in the kernel page tables as well.
> > 
> > ...
> >
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -901,4 +901,9 @@ config KMAP_LOCAL
> >  # struct io_mapping based helper.  Selected by drivers that need them
> >  config IO_MAPPING
> >  	bool
> > +
> > +config SECRETMEM
> > +	def_bool ARCH_HAS_SET_DIRECT_MAP && !EMBEDDED
> > +	select STRICT_DEVMEM
> > +
> >  endmenu
> 
> WARNING: unmet direct dependencies detected for STRICT_DEVMEM
>   Depends on [n]: MMU [=y] && DEVMEM [=n] && (ARCH_HAS_DEVMEM_IS_ALLOWED [=y] || GENERIC_LIB_DEVMEM_IS_ALLOWED [=n])
>   Selected by [y]:
>   - SECRETMEM [=y]
> 
> so I went back to the v19 version, with

Ouch, sorry, I forgot to remove that hunk, v19 is the correct version.
 
> --- a/mm/Kconfig~mm-introduce-memfd_secret-system-call-to-create-secret-memory-areas-fix
> +++ a/mm/Kconfig
> @@ -907,6 +907,5 @@ config IO_MAPPING
>  
>  config SECRETMEM
>  	def_bool ARCH_HAS_SET_DIRECT_MAP && !EMBEDDED
> -	select STRICT_DEVMEM
>  
>  endmenu
> _
> 

-- 
Sincerely yours,
Mike.

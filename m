Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74F13014D2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Jan 2021 12:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbhAWLBp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Jan 2021 06:01:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:59428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbhAWLBo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Jan 2021 06:01:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C54F233FC;
        Sat, 23 Jan 2021 11:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611399663;
        bh=HKE6o3YvB1B4tteaWRG6KFCwQvpwQVukHCQUNVVJeeY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HKYTq7yJigGOEK8nATV4Dx0NmxniF8qJvpM8DaATKPfSpcwbXynIkCA3n3qe4gShc
         P58WaSyJhlAC3agVkClm43lT0PT5xZ4J7SJtjlWxMDPo7Z7TJ5vikccGijHyX6Qk3T
         csEAYzaE2dNiGaDYQSUa2ZRjDbWeimlY9AxOUezkEDzB+tFxoT4KWyZ3/mHJ42y/5p
         pqq7kjj0H57u727QxLS0KIbNm35ZWU+0trHV9uXECzkWMwPCcm0Vf+ufzHv9e+UsoG
         s6KF8VZU223mQTNtDCDxNRjB/Glv/5nT7EoghwQyPT8tKfrFHn5E34OlgLb+jD+RQt
         FTlyibQtHA2wA==
Date:   Sat, 23 Jan 2021 13:00:41 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        luto@kernel.org, Arnd Bergmann <arnd@arndb.de>, bp@alien8.de,
        catalin.marinas@arm.com, cl@linux.com, dan.j.williams@intel.com,
        dave.hansen@linux.intel.com, david@redhat.com,
        elena.reshetova@intel.com, hpa@zytor.com, mingo@redhat.com,
        jejb@linux.ibm.com, kirill@shutemov.name, willy@infradead.org,
        mark.rutland@arm.com, rppt@linux.ibm.com, mtk.manpages@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>, peterz@infradead.org,
        rick.p.edgecombe@intel.com, guro@fb.com, shakeelb@google.com,
        shuah@kernel.org, tglx@linutronix.de, tycho@tycho.ws,
        will@kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, lkp@intel.com
Subject: Re: [PATCH v15 03/11] riscv/Kconfig: make direct map manipulation
 options depend on MMU
Message-ID: <20210123110041.GE6332@kernel.org>
References: <20210120180612.1058-4-rppt@kernel.org>
 <mhng-5cbc9b30-ac9a-4748-bf12-8f0de4c89f79@palmerdabbelt-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-5cbc9b30-ac9a-4748-bf12-8f0de4c89f79@palmerdabbelt-glaptop>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 22, 2021 at 08:12:30PM -0800, Palmer Dabbelt wrote:
> On Wed, 20 Jan 2021 10:06:04 PST (-0800), rppt@kernel.org wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > ARCH_HAS_SET_DIRECT_MAP and ARCH_HAS_SET_MEMORY configuration options have
> > no meaning when CONFIG_MMU is disabled and there is no point to enable them
> > for the nommu case.
> > 
> > Add an explicit dependency on MMU for these options.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > ---
> >  arch/riscv/Kconfig | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index d82303dcc6b6..d35ce19ab1fa 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -25,8 +25,8 @@ config RISCV
> >  	select ARCH_HAS_KCOV
> >  	select ARCH_HAS_MMIOWB
> >  	select ARCH_HAS_PTE_SPECIAL
> > -	select ARCH_HAS_SET_DIRECT_MAP
> > -	select ARCH_HAS_SET_MEMORY
> > +	select ARCH_HAS_SET_DIRECT_MAP if MMU
> > +	select ARCH_HAS_SET_MEMORY if MMU
> >  	select ARCH_HAS_STRICT_KERNEL_RWX if MMU
> >  	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
> >  	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
> 
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
> 
> LMK if you want this to go in via the RISC-V tree, otherwise I'm going to
> assume it's going in along with the rest of these.  FWIW I see these in other
> architectures without the MMU guard.

Except arm, they all always have MMU=y and arm selects only
ARCH_HAS_SET_MEMORY and has empty stubs for those when MMU=n.

Indeed I might have been over zealous adding ARCH_HAS_SET_MEMORY dependency
on MMU, as riscv also has these stubs, but I thought that making this
explicit is a nice thing.
 
> Thanks!

-- 
Sincerely yours,
Mike.

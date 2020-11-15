Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696F62B3305
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Nov 2020 09:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgKOIqh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Nov 2020 03:46:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:59768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbgKOIpz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Nov 2020 03:45:55 -0500
Received: from kernel.org (unknown [77.125.7.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC352223FB;
        Sun, 15 Nov 2020 08:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605429954;
        bh=I2e6oiG56Ipc+LYVEf48Tzpdu9e5X2SPeAjMkXGJ+FY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mvUrkC8DbWSBeGtX5LmBQbQw3erYKhs5cOaKJid6GDJMPM7nXXubIxoNcBB3oGNe7
         rCwIs49LamtntTc1amgIjfXRya2sb8UfoqlV6jooN7E3J+NN/S80wRZL4M8ZXWanKD
         tXrCqT3L+M5TGE/FDZPfoLrZTF0AQQmH6gi3Hxpk=
Date:   Sun, 15 Nov 2020 10:45:39 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>
Subject: Re: [PATCH v8 4/9] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <20201115084539.GU4758@kernel.org>
References: <20201110151444.20662-1-rppt@kernel.org>
 <20201110151444.20662-5-rppt@kernel.org>
 <20201113140656.GG17076@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113140656.GG17076@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 13, 2020 at 02:06:56PM +0000, Matthew Wilcox wrote:
> On Tue, Nov 10, 2020 at 05:14:39PM +0200, Mike Rapoport wrote:
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index c89c5444924b..d8d170fa5210 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -884,4 +884,7 @@ config ARCH_HAS_HUGEPD
> >  config MAPPING_DIRTY_HELPERS
> >          bool
> >  
> > +config SECRETMEM
> > +	def_bool ARCH_HAS_SET_DIRECT_MAP && !EMBEDDED
> 
> So I now have to build this in, whether I want it or not?

Why wouldn't anybody want this nice feature? ;-)

Now, seriously, I hesitated a lot about having a prompt here, but in the
end I've decided to go without it.

The added footprint is not so big, with x86 defconfig it's less than 8K
and with distro (I've checked with Fedora) config the difference is less
than 1k because they anyway have CMA=y.

As this is "security" feature, disros most probably would have this
enabled anyway, and I believe users that will see something like "Allow
hiding memory from the kernel" will hit Y there.

-- 
Sincerely yours,
Mike.

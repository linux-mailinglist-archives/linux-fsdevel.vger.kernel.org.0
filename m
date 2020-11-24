Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB9E2C2D4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 17:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389861AbgKXQtr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 11:49:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:52232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbgKXQtr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 11:49:47 -0500
Received: from kernel.org (unknown [77.125.7.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0D65206D8;
        Tue, 24 Nov 2020 16:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606236586;
        bh=ofUYlPrJWYYZntZI6e1UjFnjHWpt+ejZuqW8X4FikI4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZCuQvSCf55hd5LYTHCkX7HoUl/qLUj9Aw9Qt2bN77Vq37ymtgqf1vlqa/54yGLfET
         9NqEFDk66Auv1EyiIzF9GLhnJC21iAtMI/wvzWombNFNDkOObvxkdIL/h8j9OReeJM
         eznOp2166MiDXEFDWf7MpCnskhIQaw8NFBBtv2Qk=
Date:   Tue, 24 Nov 2020 18:49:30 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
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
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>, Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>
Subject: Re: [PATCH v11 4/9] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <20201124164930.GK8537@kernel.org>
References: <20201124092556.12009-1-rppt@kernel.org>
 <20201124092556.12009-5-rppt@kernel.org>
 <20201124105947.GA5527@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124105947.GA5527@gaia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 24, 2020 at 10:59:48AM +0000, Catalin Marinas wrote:
> Hi Mike,
> 
> On Tue, Nov 24, 2020 at 11:25:51AM +0200, Mike Rapoport wrote:
> > +static vm_fault_t secretmem_fault(struct vm_fault *vmf)
> > +{
> > +	struct address_space *mapping = vmf->vma->vm_file->f_mapping;

...

> > +
> > +		err = set_direct_map_invalid_noflush(page, 1);
> > +		if (err)
> > +			goto err_del_page_cache;
> 
> On arm64, set_direct_map_default_noflush() returns 0 if !rodata_full but
> no pgtable changes happen since the linear map can be a mix of small and
> huge pages. The arm64 implementation doesn't break large mappings. I
> presume we don't want to tell the user that the designated memory is
> "secret" but the kernel silently ignored it.
> 
> We could change the arm64 set_direct_map* to return an error, however, I
> think it would be pretty unexpected for the user to get a fault when
> trying to access it. It may be better to return a -ENOSYS or something
> on the actual syscall if the fault-in wouldn't be allowed later.
> 
> Alternatively, we could make the linear map always use pages on arm64,
> irrespective of other config or cmdline options (maybe not justified
> unless we have clear memsecret users). Yet another idea is to get
> set_direct_map* to break pmd/pud mappings into pte but that's not always
> possible without a stop_machine() and potentially disabling the MMU.

My preference would be to check at secretmem initialization if
set_direct_map_*() actually do anything and then return an error from
the syscall if they are essentially nop.

I'll update the patches with something like this in v12.

> -- 
> Catalin

-- 
Sincerely yours,
Mike.

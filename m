Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE9A27CE6B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Sep 2020 15:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbgI2NGZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Sep 2020 09:06:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:48202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728253AbgI2NGY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:06:24 -0400
Received: from kernel.org (unknown [87.71.73.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DAC8207F7;
        Tue, 29 Sep 2020 13:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601384783;
        bh=dKs40EB0zUNqF3k8hOXDHChpW1qE+Tc5ZCaCj+fNcAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kkoEdNeBwGUh5IVOWlI3TdmyaJCGl1uUtrsv4V7euPJfzeGsgVr9508rpCKlka84A
         TsDcDOdrDS9A4AaYCoyZ7lmCOsiredZMHpJsZ/ljNuc5atPQsZJCW42/ujWY54vc/A
         xHI6TcUVFoTK32LTlL0E1IvYKnm9SRUNQXn1aIps=
Date:   Tue, 29 Sep 2020 16:06:02 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tycho@tycho.ws" <tycho@tycho.ws>,
        "david@redhat.com" <david@redhat.com>,
        "cl@linux.com" <cl@linux.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "idan.yaniv@ibm.com" <idan.yaniv@ibm.com>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "willy@infradead.org" <willy@infradead.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mtk.manpages@gmail.com" <mtk.manpages@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: Re: [PATCH v6 3/6] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <20200929130602.GF2142832@kernel.org>
References: <20200924132904.1391-1-rppt@kernel.org>
 <20200924132904.1391-4-rppt@kernel.org>
 <d466e1f13ff615332fe1f513f6c1d763db28bd9a.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d466e1f13ff615332fe1f513f6c1d763db28bd9a.camel@intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 29, 2020 at 04:58:44AM +0000, Edgecombe, Rick P wrote:
> On Thu, 2020-09-24 at 16:29 +0300, Mike Rapoport wrote:
> > Introduce "memfd_secret" system call with the ability to create
> > memory
> > areas visible only in the context of the owning process and not
> > mapped not
> > only to other processes but in the kernel page tables as well.
> > 
> > The user will create a file descriptor using the memfd_secret()
> > system call
> > where flags supplied as a parameter to this system call will define
> > the
> > desired protection mode for the memory associated with that file
> > descriptor.
> > 
> >  Currently there are two protection modes:
> > 
> > * exclusive - the memory area is unmapped from the kernel direct map
> > and it
> >               is present only in the page tables of the owning mm.
> 
> Seems like there were some concerns raised around direct map
> efficiency, but in case you are going to rework this...how does this
> memory work for the existing kernel functionality that does things like
> this?
> 
> get_user_pages(, &page);
> ptr = kmap(page);
> foo = *ptr;
> 
> Not sure if I'm missing something, but I think apps could cause the
> kernel to access a not-present page and oops.

The idea is that this memory should not be accessible by the kernel, so
the sequence you describe should indeed fail.

Probably oops would be to noisy and in this case the report needs to be
less verbose.

-- 
Sincerely yours,
Mike.

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1AE8249C03
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Aug 2020 13:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgHSLnC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Aug 2020 07:43:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:42350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727120AbgHSLm5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Aug 2020 07:42:57 -0400
Received: from kernel.org (unknown [87.70.91.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB23E206FA;
        Wed, 19 Aug 2020 11:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597837376;
        bh=oRLqxLOhAk2wnqABtg3LIfVpl96FyLYFzASr1U/ua+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2Z9IophMNzk8pDJ8BdCg/mK2k2gQuqV8UM0qQAmx+Sn6zj919AK6cSjrUfOGKNQT4
         FgdC+v6CR36y9JK0bGfz3O20UZlSub/rKj1DDNqRtiGiQklQFxbD8gym7lAVbdhBXm
         bYUybp6KP1/X0bvM8WCYlmLMym+12jW5T0ZamYZo=
Date:   Wed, 19 Aug 2020 14:42:44 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-riscv@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v4 0/6] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <20200819114244.GT752365@kernel.org>
References: <20200818141554.13945-1-rppt@kernel.org>
 <e82ca20e-a88e-d7ff-e99b-4189aac54f3a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e82ca20e-a88e-d7ff-e99b-4189aac54f3a@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 19, 2020 at 12:47:54PM +0200, David Hildenbrand wrote:
> On 18.08.20 16:15, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Hi,
> > 
> > This is an implementation of "secret" mappings backed by a file descriptor. 
> > 
> > v4 changes:
> > * rebase on v5.9-rc1
> > * Do not redefine PMD_PAGE_ORDER in fs/dax.c, thanks Kirill
> > * Make secret mappings exclusive by default and only require flags to
> >   memfd_secret() system call for uncached mappings, thanks again Kirill :)
> > 
> > v3 changes:
> > * Squash kernel-parameters.txt update into the commit that added the
> >   command line option.
> > * Make uncached mode explicitly selectable by architectures. For now enable
> >   it only on x86.
> > 
> > v2 changes:
> > * Follow Michael's suggestion and name the new system call 'memfd_secret'
> > * Add kernel-parameters documentation about the boot option
> > * Fix i386-tinyconfig regression reported by the kbuild bot.
> >   CONFIG_SECRETMEM now depends on !EMBEDDED to disable it on small systems
> >   from one side and still make it available unconditionally on
> >   architectures that support SET_DIRECT_MAP.
> > 
> > 
> > The file descriptor backing secret memory mappings is created using a
> > dedicated memfd_secret system call The desired protection mode for the
> > memory is configured using flags parameter of the system call. The mmap()
> > of the file descriptor created with memfd_secret() will create a "secret"
> > memory mapping. The pages in that mapping will be marked as not present in
> > the direct map and will have desired protection bits set in the user page
> > table. For instance, current implementation allows uncached mappings.
> > 
> > Although normally Linux userspace mappings are protected from other users, 
> > such secret mappings are useful for environments where a hostile tenant is
> > trying to trick the kernel into giving them access to other tenants
> > mappings.
> > 
> > Additionally, the secret mappings may be used as a mean to protect guest
> > memory in a virtual machine host.
> > 
> 
> Just a general question. I assume such pages (where the direct mapping
> was changed) cannot get migrated - I can spot a simple alloc_page(). So
> essentially a process can just allocate a whole bunch of memory that is
> unmovable, correct? Is there any limit? Is it properly accounted towards
> the process (memctl) ?

The memory as accounted in the same way like with mlock(), so normal
user won't be able to allocate more than RLIMIT_MEMLOCK.

> -- 
> Thanks,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.

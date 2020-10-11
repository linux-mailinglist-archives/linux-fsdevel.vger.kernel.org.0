Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACE728A6B2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Oct 2020 11:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbgJKJnN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Oct 2020 05:43:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbgJKJnM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Oct 2020 05:43:12 -0400
Received: from kernel.org (unknown [87.71.73.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CC9D207FB;
        Sun, 11 Oct 2020 09:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602409392;
        bh=JEb/p0JIeDwreayr/694lmHvSiZFhmLJTNKc6RgoUB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GyVAztyffWGroLTBwFkigZ5sS434B8V3s8XU67kyKeRb2YvnrpxN1017L7nppODmP
         HOneZWpbWwQWUpDOo1rOsiJ1syiGbCKA8zOTjnkbk43GyDZ5DFJ6mzTbvMJFiwGbka
         Re+K4LSoEoUz5cn+1C6SOXqPmDeAvZpRR5Sz0gkM=
Date:   Sun, 11 Oct 2020 12:42:55 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "david@redhat.com" <david@redhat.com>,
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
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "willy@infradead.org" <willy@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mtk.manpages@gmail.com" <mtk.manpages@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "tycho@tycho.ws" <tycho@tycho.ws>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>
Subject: Re: [PATCH v6 3/6] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <20201011094255.GB4251@kernel.org>
References: <20200924132904.1391-1-rppt@kernel.org>
 <20200924132904.1391-4-rppt@kernel.org>
 <d466e1f13ff615332fe1f513f6c1d763db28bd9a.camel@intel.com>
 <20200929130602.GF2142832@kernel.org>
 <839fbb26254dc9932dcff3c48a3a4ab038c016ea.camel@intel.com>
 <20200930103507.GK2142832@kernel.org>
 <b5d8e90c5366a42e7ad0a337fba5f2b1bcfe52c2.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5d8e90c5366a42e7ad0a337fba5f2b1bcfe52c2.camel@intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 30, 2020 at 08:11:28PM +0000, Edgecombe, Rick P wrote:
> On Wed, 2020-09-30 at 13:35 +0300, Mike Rapoport wrote:
> > 
> > Our thinking was that copy_*user() would work in the context of the
> > process that "owns" the secretmem and gup() would not allow access in
> > general, unless requested with certail (yet another) FOLL_ flag.
> 
> Hmm, yes. I think one easier thing about this design over the series
> Kirill sent out is that the actual page will never transition to and
> from unmapped while it's mapped in userspace. If it could transition,
> you'd have to worry about a race window between
> get_user_pages(FOLL_foo) and the kmap() where the page might get
> unmapped.
> 
> Without the ability to transition pages though, using this for KVM
> guests memory remains a not completely worked through problem since it
> has the get_user_pages()/kmap() pattern quite a bit. Did you have an
> idea for that? (I thought I saw that use case mentioned somewhere).
 
I've mentioned the KVM usecase because it was dicussed at the hallway
track at KVM Forum last year and also after looking at Kirill's patches
I though that "KVM protected" memory could be implemented on top of
secretmem. Can't say I have enough expertise in KVM to have a completely
worked through solution for that.

-- 
Sincerely yours,
Mike.

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94DB82B6937
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 16:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgKQP6n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Nov 2020 10:58:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:35552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgKQP6m (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Nov 2020 10:58:42 -0500
Received: from kernel.org (unknown [77.125.7.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3B60238E6;
        Tue, 17 Nov 2020 15:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605628721;
        bh=9is+MjALfTGepw57FVx0JouySPxlzfHt3CDVLQ4Unmk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p8sWlliyDkUNYoXZjFWSoiuQvdgEZNX+2SxP4AeRu3E6J1nQ7q1oTfz+6Ip2yE0wn
         cmwAFaK1S/AmhU4S6q0bHx0jhCupiexg9VCuzKWD3rTOMD16YOJ0wT4exivwNxppfK
         VG9oFzcdjadQK9Y3xyHqBPePYLUqwIL58wy/neZo=
Date:   Tue, 17 Nov 2020 17:58:29 +0200
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
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
Subject: Re: [PATCH v8 2/9] mmap: make mlock_future_check() global
Message-ID: <20201117155829.GJ370813@kernel.org>
References: <20201112190827.GP4758@kernel.org>
 <7A16CA44-782D-4ABA-8D93-76BDD0A90F94@redhat.com>
 <20201115082625.GT4758@kernel.org>
 <d47fdd2e-a8fa-6792-ca8f-e529be76340c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d47fdd2e-a8fa-6792-ca8f-e529be76340c@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 17, 2020 at 04:09:39PM +0100, David Hildenbrand wrote:
> On 15.11.20 09:26, Mike Rapoport wrote:
> > On Thu, Nov 12, 2020 at 09:15:18PM +0100, David Hildenbrand wrote:

...

> > My thinking was that since secretmem does what mlock() does wrt
> > swapability, it should at least obey the same limit, i.e.
> > RLIMIT_MEMLOCK.
> 
> Right, but at least currently, it behaves like any other CMA allocation
> (IIRC they are all unmovable and, therefore, not swappable). In the future,
> if pages would be movable (but not swappable), I guess it might makes more
> sense. I assume we never ever want to swap secretmem.
> 
> "man getrlimit" states for RLIMIT_MEMLOCK:
> 
> "This is the maximum number of bytes of memory that may be
>  locked into RAM.  [...] This limit affects
>  mlock(2), mlockall(2), and the mmap(2) MAP_LOCKED operation.
>  Since Linux 2.6.9, it also affects the shmctl(2) SHM_LOCK op‐
>  eration [...]"
> 
> So that place has to be updated as well I guess? Otherwise this might come
> as a surprise for users.

Sure.

> > 
> > > E.g., we also don‘t
> > > account for gigantic pages - which might be allocated from CMA and are
> > > not swappable.
> > Do you mean gigantic pages in hugetlbfs?
> 
> Yes
> 
> > It seems to me that hugetlbfs accounting is a completely different
> > story.
> 
> I'd say it is right now comparable to secretmem - which is why I though
> similar accounting would make sense.

IMHO, using RLIMIT_MEMLOCK and memcg is a more straightforward way than
a custom cgroup.

And if we'll see a need for additional mechanism, we can always add it.
 
> -- 
> Thanks,
> 
> David / dhildenb
> 
> 

-- 
Sincerely yours,
Mike.

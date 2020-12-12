Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 139312D8708
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Dec 2020 15:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439150AbgLLOAn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Dec 2020 09:00:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:53562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439135AbgLLOAj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Dec 2020 09:00:39 -0500
Date:   Sat, 12 Dec 2020 15:59:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607781598;
        bh=W+S3uDjo9SUaklycr1VwLEkb3P+e5VKfy1opxSFjfP4=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=flXIgTj5QPdmF322uyfveGkWCvdiCUBTDqJEmaQAdBMU+9OnpTfe38HJDNJgc0lH8
         G3M3nYjTvl4Jk0YTIcL5XhPPhChBAc7qxqYwpPq+/oyL9pin060A7R+FLePp8EI92r
         GwnqdckCsl6axBY1CL4fx8yH/moiz2Z+oLa3jsxNsEo1pT2EOLhqIregvSKc55N4Zj
         WuUAHrJAd8PgEDWlSYMQSNKmu4qJ1V3ZA+z2Yx8VyWB6hblUmlV0BHoIXeUaszFyMu
         HjV36aGN0+weJj3fLUwesb3uBHEoXTzG37NgAFnxayD4MEFDMvTjDeUmf4Kr35XObN
         Un6GIU6DTV1SA==
From:   Mike Rapoport <rppt@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
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
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
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
        x86@kernel.org
Subject: Re: [PATCH v14 10/10] secretmem: test: add basic selftest for
 memfd_secret(2)
Message-ID: <20201212135940.GD8946@kernel.org>
References: <20201203062949.5484-1-rppt@kernel.org>
 <20201203062949.5484-11-rppt@kernel.org>
 <248f928b-1383-48ea-8584-ec10146e60c9@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <248f928b-1383-48ea-8584-ec10146e60c9@nvidia.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi John,

On Fri, Dec 11, 2020 at 10:16:23PM -0800, John Hubbard wrote:
> On 12/2/20 10:29 PM, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> ...
> > +#include "../kselftest.h"
> > +
> > +#define fail(fmt, ...) ksft_test_result_fail(fmt, ##__VA_ARGS__)
> > +#define pass(fmt, ...) ksft_test_result_pass(fmt, ##__VA_ARGS__)
> > +#define skip(fmt, ...) ksft_test_result_skip(fmt, ##__VA_ARGS__)
> > +
> > +#ifdef __NR_memfd_secret
> > +
> > +#include <linux/secretmem.h>
> 
> Hi Mike,
> 
> Say, when I tried this out from today's linux-next, I had to delete the
> above line. In other words, the following was required in order to build:
> 
> diff --git a/tools/testing/selftests/vm/memfd_secret.c b/tools/testing/selftests/vm/memfd_secret.c
> index 79578dfd13e6..c878c2b841fc 100644
> --- a/tools/testing/selftests/vm/memfd_secret.c
> +++ b/tools/testing/selftests/vm/memfd_secret.c
> @@ -29,8 +29,6 @@
> 
>  #ifdef __NR_memfd_secret
> 
> -#include <linux/secretmem.h>
> -
>  #define PATTERN        0x55
> 
>  static const int prot = PROT_READ | PROT_WRITE;
> 
> 
> ...and that makes sense to me, because:
> 
> a) secretmem.h is not in the uapi, which this selftests/vm build system
>    expects (it runs "make headers_install" for us, which is *not* going
>    to pick up items in the kernel include dirs), and
> 
> b) There is nothing in secretmem.h that this test uses, anyway! Just these:
> 
> bool vma_is_secretmem(struct vm_area_struct *vma);
> bool page_is_secretmem(struct page *page);
> bool secretmem_active(void);
> 
> 
> ...or am I just Doing It Wrong? :)

You are perfectly right, I had a stale header in uapi from the prevoius
versions, the include in the test remained from then.

@Andrew, can you please add the hunk above as a fixup?

> thanks,
> -- 
> John Hubbard
> NVIDIA

-- 
Sincerely yours,
Mike.

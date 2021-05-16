Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B867381D35
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 May 2021 09:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbhEPHOy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 May 2021 03:14:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:60868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229807AbhEPHOw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 May 2021 03:14:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE3C96115C;
        Sun, 16 May 2021 07:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621149218;
        bh=IoT9uozjOozDjgXpC4P6jXJSumTP/QNdfBTNGYn48Go=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UJGadq3iWVyp6JiaaARzML2nDhD/6cxgoukhLb//Cm1oiKYNlw2vGT6JTI7JDXvj2
         sv01qcX7qz1P0swA1iAeer1zfo0u8w0FM+2xjAKXq5nty+4U8NND5Zd35VzjSdgPvo
         tDXqQy0wo5sGVwSrA1ulFuVwtCplNbJ71DrU3dWxVebC/bnfBzEDBPZgIZbVXfd0Sk
         QuBjs82K5fBUBM1+e1y5/3sAud3EurnH6Q3/XujCr4AuuRXHMRs0y7nWOwkAisAJxZ
         RIgDFv5dORgRpVXtvZRRsIItfRvWQyJQI2ZhrWK1iaupqJoRD9qzvTr0ixi2Std5XI
         RjQV7hOfflMCg==
Date:   Sun, 16 May 2021 10:13:19 +0300
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
        "H. Peter Anvin" <hpa@zytor.com>,
        Hagen Paul Pfeifer <hagen@jauu.net>,
        Ingo Molnar <mingo@redhat.com>,
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
Subject: Re: [PATCH v19 3/8] set_memory: allow set_direct_map_*_noflush() for
 multiple pages
Message-ID: <YKDGD0k990bBCEGG@kernel.org>
References: <20210513184734.29317-1-rppt@kernel.org>
 <20210513184734.29317-4-rppt@kernel.org>
 <858e5561-bc7d-4ce1-5cb8-3c333199d52a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <858e5561-bc7d-4ce1-5cb8-3c333199d52a@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 14, 2021 at 10:43:29AM +0200, David Hildenbrand wrote:
> On 13.05.21 20:47, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > The underlying implementations of set_direct_map_invalid_noflush() and
> > set_direct_map_default_noflush() allow updating multiple contiguous pages
> > at once.
> > 
> > Add numpages parameter to set_direct_map_*_noflush() to expose this
> > ability with these APIs.
> 
> AFAIKs, your patch #5 right now only calls it with 1 page, do we need this
> change at all? Feels like a leftover from older versions to me where we
> could have had more than a single page.

Right, will drop it. 

-- 
Sincerely yours,
Mike.

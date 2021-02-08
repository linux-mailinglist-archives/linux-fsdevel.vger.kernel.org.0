Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D20D314173
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Feb 2021 22:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbhBHVPQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 16:15:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:33264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236304AbhBHVOa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 16:14:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A15364E8F;
        Mon,  8 Feb 2021 21:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612818828;
        bh=Hsw7u4NisXSHdMbN0miFLrU3qob/BtZRKy5D0WtD4mQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DqkWj9UrgaNlN7tor4WlT/PbjHoDhVkTAWVyRtiehKqBsBIlg2zRzOAntGDW+86wx
         t9LmuXLRYqrHRZcBc7unC6XAhPNWrMcUUEvHAvwnkCUgMKqMFZnL9bm2GNE5aC4pUI
         g9uqZwzHwFkcQ+XmsVzR8yYGxPKdKhbTnQ7myE7Mj0cV6qw47j0NdId0MJHEqRslub
         /el3Boy5sSLWlkjK0Pm94QQLob4G/uLz4vRWnNapLgu2mZBiTSGLPUWdmMesgwLpz4
         8w43a6xpBzhX2L15Qekz5VMG+RTL22BH8Ov5Tcl9FLLVyaJGQwK59/7ht8rPcFYKmt
         XQ6gGB3oh8qzg==
Date:   Mon, 8 Feb 2021 23:13:26 +0200
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
        Michal Hocko <mhocko@suse.com>,
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
Subject: Re: [PATCH v17 00/10] mm: introduce memfd_secret system call to
 create "secret" memory areas
Message-ID: <20210208211326.GV242749@kernel.org>
References: <20210208084920.2884-1-rppt@kernel.org>
 <4996348d-5710-d77d-bb14-d84e370b4a5c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4996348d-5710-d77d-bb14-d84e370b4a5c@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 08, 2021 at 10:27:18AM +0100, David Hildenbrand wrote:
> On 08.02.21 09:49, Mike Rapoport wrote:
> 
> Some questions (and request to document the answers) as we now allow to have
> unmovable allocations all over the place and I don't see a single comment
> regarding that in the cover letter:
> 
> 1. How will the issue of plenty of unmovable allocations for user space be
> tackled in the future?
> 
> 2. How has this issue been documented? E.g., interaction with ZONE_MOVABLE
> and CMA, alloc_conig_range()/alloc_contig_pages?.

Secretmem sets the mappings gfp mask to GFP_HIGHUSER, so it does not
allocate movable pages at the first place.
 
> 3. How are the plans to support migration in the future and which interface
> changes will be required? (Michal mentioned some good points to make this
> configurable via the interface, we should plan ahead and document)

The only interface change required is an addition of bit value for syscall
flags, I really think it can be documented with the addition of migration
or any other feature for that sake. 

-- 
Sincerely yours,
Mike.

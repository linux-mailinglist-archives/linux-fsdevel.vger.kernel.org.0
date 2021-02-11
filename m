Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68846318993
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Feb 2021 12:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhBKLd7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Feb 2021 06:33:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:42090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231628AbhBKLap (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Feb 2021 06:30:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C89C601FF;
        Thu, 11 Feb 2021 11:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613043004;
        bh=JtJHuqvnhxNyM0cSP3Qe3tSMfjdJGVz3S+tERJXfo4M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PEXygoi6R9pVpb0NPj47+Ko3f1Ah21CxDjueYWnlQAO/uRVErOda0UIyi9V6v9rYs
         6NXsauRjapfptBwBvo70ls3AAnv08VDhhWUxi7yLuKhQOTQa31mGOOLAdVpQ8B16uZ
         SzyBJMAmkReTwWmxT4Tjvg8ZAL2HyRIawjk70IsH5WPDvqJ9dQdETycAuzkDATgNju
         gOL/aozy2VFMdzBaSlauwv+UBb82EKAQG3vL++P2TTqj9pWtgKqRk4VcEXI1wyFYG+
         5DJMf90zHF2E2ie9ZUU2VlL1vbBwnzXXk30WzSnRm7nZHI33uXE/tbEgH+TreMHc5x
         BblQZ8rwiMN2Q==
Date:   Thu, 11 Feb 2021 13:29:46 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: Re: [PATCH v17 07/10] mm: introduce memfd_secret system call to
 create "secret" memory areas
Message-ID: <20210211112946.GJ242749@kernel.org>
References: <YCEXMgXItY7xMbIS@dhcp22.suse.cz>
 <20210208212605.GX242749@kernel.org>
 <YCJMDBss8Qhha7g9@dhcp22.suse.cz>
 <20210209090938.GP299309@linux.ibm.com>
 <YCKLVzBR62+NtvyF@dhcp22.suse.cz>
 <20210211071319.GF242749@kernel.org>
 <YCTtSrCEvuBug2ap@dhcp22.suse.cz>
 <0d66baec-1898-987b-7eaf-68a015c027ff@redhat.com>
 <YCT6+9YW474IaKrm@dhcp22.suse.cz>
 <e7f1b5eb-a4c8-2772-6333-0a72c22b0c51@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7f1b5eb-a4c8-2772-6333-0a72c22b0c51@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 11, 2021 at 11:02:07AM +0100, David Hildenbrand wrote:
> 
> Another thought regarding "doesn't have _any_ backing storage"
> 
> What are the right semantics when it comes to memory accounting/commit?
> 
> As secretmem does not have
> a) any backing storage
> b) cannot go to swap
> 
> The MAP_NORESERVE vs. !MAP_NORESERVE handling gets a little unclear. Why
> "reserve swap space" if the allocations cannot ever go to swap? Sure, we
> want to "reserve physical memory", but in contrast to other users that can
> go to swap.
> 
> Of course, this is only relevant for MAP_PRIVATE secretmem mappings. Other
> MAP_SHARED assumes there is no need for reserving swap space as it can just
> go to the backing storage. (yeah, tmpfs/shmem is weird in that regard as
> well, but again, it's a bit different)

In that sense seceremem is as weird as tmpfs and it only allows MAP_SHARED.

-- 
Sincerely yours,
Mike.

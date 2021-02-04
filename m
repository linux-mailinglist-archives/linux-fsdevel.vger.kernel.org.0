Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D32B30F013
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 11:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235281AbhBDJ7z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 04:59:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:45044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232838AbhBDJ7x (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 04:59:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A884364F46;
        Thu,  4 Feb 2021 09:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612432752;
        bh=Zelq6D4XZGDuPo70kYTJJgaDbDwK093nuyMe02isfTI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fZFn4SNNNsHZIThixqTd5WKR7HGKRGMdU+ddKY4VdNoOwSQ9sODqK3VgxpKL2A56s
         4I3o8KBCJHtLjeKmCDkWXpGpYpGakfGQfRhSVgtlpOrfdQ5QAi0R3o4gjlXj7MIvFC
         Ql/7xPdKgGPYgPgsAFnGZRVBP1GrMxNjIdlhLDg3vtnKQVC0uVe1NaVVXvOSxEagFl
         5y6xdti/3JckXFJOMvgjQwfxD24nH4jVxSXiirTWWQrL2Wdx2stjQ2AChARA3yWjIv
         HiCcrNO6+HU6R5Uv0EPl7S1u0uczvREvOdVTv98bo0LM7TPjMzx3LQFogyEOGejvpC
         DeRySER1corJA==
Date:   Thu, 4 Feb 2021 11:58:55 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
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
        x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: Re: [PATCH v16 07/11] secretmem: use PMD-size pages to amortize
 direct map fragmentation
Message-ID: <20210204095855.GQ242749@kernel.org>
References: <20210128092259.GB242749@kernel.org>
 <YBK1kqL7JA7NePBQ@dhcp22.suse.cz>
 <73738cda43236b5ac2714e228af362b67a712f5d.camel@linux.ibm.com>
 <YBPF8ETGBHUzxaZR@dhcp22.suse.cz>
 <6de6b9f9c2d28eecc494e7db6ffbedc262317e11.camel@linux.ibm.com>
 <YBkcyQsky2scjEcP@dhcp22.suse.cz>
 <20210202124857.GN242749@kernel.org>
 <YBlTMqjB06aqyGbT@dhcp22.suse.cz>
 <20210202191040.GP242749@kernel.org>
 <YBpo9mC5feVQ0mpG@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBpo9mC5feVQ0mpG@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 03, 2021 at 10:12:22AM +0100, Michal Hocko wrote:
> On Tue 02-02-21 21:10:40, Mike Rapoport wrote:
> >   
> > Let me reiterate to make sure I don't misread your suggestion.
> > 
> > If we make secretmem an opt-in feature with, e.g. kernel parameter, the
> > pooling of large pages is unnecessary. In this case there is no limited
> > resource we need to protect because secretmem will allocate page by page.
> 
> Yes.
> 
> > Since there is no limited resource, we don't need special permissions
> > to access secretmem so we can move forward with a system call that creates
> > a mmapable file descriptor and save the hassle of a chardev.
> 
> Yes, I assume you implicitly assume mlock rlimit here.

Yes.

> Also memcg accounting should be in place. 

Right, without pools memcg accounting is no different from other
unevictable files.

> Wrt to the specific syscall, please document why existing interfaces are
> not a good fit as well. It would be also great to describe interaction
> with mlock itself (I assume the two to be incompatible - mlock will fail
> on and mlockall will ignore it).

The interaction with mlock() belongs more to the man page, but I don't mind
adding this to changelog as well.

-- 
Sincerely yours,
Mike.

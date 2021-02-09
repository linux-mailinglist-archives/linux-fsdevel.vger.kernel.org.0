Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F66F314ACD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 09:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbhBIIue (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 03:50:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:56736 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230201AbhBIIr6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 03:47:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612860431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7uXNoYTwJcul85Ggr79faNz9sm4xUBP5tyQrp7MGBDU=;
        b=igFK6y52//YbOeER2qu6o8xC111AEEf/9O0tsPnCXBARwevxGar35/sufXf6VC6tmzQnyW
        /X0B3+BhzxxFnhgpH7/ijVkSsmiVTBYgLKz7SupOE55ZHrLDJUiANJxkyr5fgautM81txk
        U8MaQSKu/ApzxONYDBE500FYqjbKj30=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7514CAB71;
        Tue,  9 Feb 2021 08:47:11 +0000 (UTC)
Date:   Tue, 9 Feb 2021 09:47:08 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Rapoport <rppt@kernel.org>
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
        x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: Re: [PATCH v17 07/10] mm: introduce memfd_secret system call to
 create "secret" memory areas
Message-ID: <YCJMDBss8Qhha7g9@dhcp22.suse.cz>
References: <20210208084920.2884-1-rppt@kernel.org>
 <20210208084920.2884-8-rppt@kernel.org>
 <YCEXMgXItY7xMbIS@dhcp22.suse.cz>
 <20210208212605.GX242749@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208212605.GX242749@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 08-02-21 23:26:05, Mike Rapoport wrote:
> On Mon, Feb 08, 2021 at 11:49:22AM +0100, Michal Hocko wrote:
> > On Mon 08-02-21 10:49:17, Mike Rapoport wrote:
[...]
> > > The file descriptor based memory has several advantages over the
> > > "traditional" mm interfaces, such as mlock(), mprotect(), madvise(). It
> > > paves the way for VMMs to remove the secret memory range from the process;
> > 
> > I do not understand how it helps to remove the memory from the process
> > as the interface explicitly allows to add a memory that is removed from
> > all other processes via direct map.
> 
> The current implementation does not help to remove the memory from the
> process, but using fd-backed memory seems a better interface to remove
> guest memory from host mappings than mmap. As Andy nicely put it:
> 
> "Getting fd-backed memory into a guest will take some possibly major work in
> the kernel, but getting vma-backed memory into a guest without mapping it
> in the host user address space seems much, much worse."

OK, so IIUC this means that the model is to hand over memory from host
to guest. I thought the guest would be under control of its address
space and therefore it operates on the VMAs. This would benefit from
an additional and more specific clarification.

> > > As secret memory implementation is not an extension of tmpfs or hugetlbfs,
> > > usage of a dedicated system call rather than hooking new functionality into
> > > memfd_create(2) emphasises that memfd_secret(2) has different semantics and
> > > allows better upwards compatibility.
> > 
> > What is this supposed to mean? What are differences?
> 
> Well, the phrasing could be better indeed. That supposed to mean that
> they differ in the semantics behind the file descriptor: memfd_create
> implements sealing for shmem and hugetlbfs while memfd_secret implements
> memory hidden from the kernel.

Right but why memfd_create model is not sufficient for the usecase?
Please note that I am arguing against. To be honest I do not really care
much. Using an existing scheme is usually preferable from my POV but
there might be real reasons why shmem as a backing "storage" is not
appropriate.
  
> > > The secretmem mappings are locked in memory so they cannot exceed
> > > RLIMIT_MEMLOCK. Since these mappings are already locked an attempt to
> > > mlock() secretmem range would fail and mlockall() will ignore secretmem
> > > mappings.
> > 
> > What about munlock?
> 
> Isn't this implied? ;-)

My bad here. I thought that munlock fails on vmas which are not mlocked
and I was curious about the behavior when mlockall() is followed by
munlock. But I do not see this being the case. So this should be ok.

-- 
Michal Hocko
SUSE Labs

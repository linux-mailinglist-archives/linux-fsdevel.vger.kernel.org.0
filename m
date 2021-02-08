Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2817B312FFA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Feb 2021 12:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbhBHLAV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 06:00:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:56190 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232773AbhBHK5w (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 05:57:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612781826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZIZtK7KGQOpq2x4SzJLMBFITOVmfiRO9HVwMLT9AWfk=;
        b=WpbjzGZc+3/YkHH1uGy0eGbUYo8oCacDxNQEQtRXANwZxHwtylTb3HKk6I403Q7833wHJ8
        aLnM/cCkpwLJswRwURhqmjTvVUu01dIEr0vSyMIJGgoFeM+JOYdLAc7kCdZvfbthq/oS41
        xyqZWWQ3VtQBnKDUYpZPwfTqaSytqRw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E729BAC6E;
        Mon,  8 Feb 2021 10:57:05 +0000 (UTC)
Date:   Mon, 8 Feb 2021 11:57:05 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
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
Subject: Re: [PATCH v17 08/10] PM: hibernate: disable when there are active
 secretmem users
Message-ID: <YCEZAWOv63KYglJZ@dhcp22.suse.cz>
References: <20210208084920.2884-1-rppt@kernel.org>
 <20210208084920.2884-9-rppt@kernel.org>
 <YCEP/bmqm0DsvCYN@dhcp22.suse.cz>
 <38c0cad4-ac55-28e4-81c6-4e0414f0620a@redhat.com>
 <YCEXwUYepeQvEWTf@dhcp22.suse.cz>
 <a488a0bb-def5-0249-99e2-4643787cef69@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a488a0bb-def5-0249-99e2-4643787cef69@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 08-02-21 11:53:58, David Hildenbrand wrote:
> On 08.02.21 11:51, Michal Hocko wrote:
> > On Mon 08-02-21 11:32:11, David Hildenbrand wrote:
> > > On 08.02.21 11:18, Michal Hocko wrote:
> > > > On Mon 08-02-21 10:49:18, Mike Rapoport wrote:
> > > > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > > > 
> > > > > It is unsafe to allow saving of secretmem areas to the hibernation
> > > > > snapshot as they would be visible after the resume and this essentially
> > > > > will defeat the purpose of secret memory mappings.
> > > > > 
> > > > > Prevent hibernation whenever there are active secret memory users.
> > > > 
> > > > Does this feature need any special handling? As it is effectivelly
> > > > unevictable memory then it should behave the same as other mlock, ramfs
> > > > which should already disable hibernation as those cannot be swapped out,
> > > > no?
> > > > 
> > > 
> > > Why should unevictable memory not go to swap when hibernating? We're merely
> > > dumping all of our system RAM (including any unmovable allocations) to swap
> > > storage and the system is essentially completely halted.
> > > 
> > My understanding is that mlock is never really made visible via swap
> > storage.
> 
> "Using swap storage for hibernation" and "swapping at runtime" are two
> different things. I might be wrong, though.

Well, mlock is certainly used to keep sensitive information, not only to
protect from major/minor faults.
-- 
Michal Hocko
SUSE Labs

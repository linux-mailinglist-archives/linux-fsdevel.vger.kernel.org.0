Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D09F30D989
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 13:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234432AbhBCMKV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 07:10:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:36988 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234141AbhBCMKT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:10:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612354172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gKqIUoUlL8R76kxwkZS//+2tVOQRZKxuwAdDoVgDGVc=;
        b=mxvYYdsWkKnOLbAAY2Xq93W86QtxGZG9WZBc2Cc9sS5vqXt3wUWDhs4DwbnmfVD6tvAGG0
        lS5OJmRviEMD44E4iBuZm462q2JlcFLn8YYCSpZ5+zJQC2fMRyJYklkp59wywSxIFouSEb
        IneXY25y0nuwemPLYik6lohSpv88DtM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DB6EEAD26;
        Wed,  3 Feb 2021 12:09:31 +0000 (UTC)
Date:   Wed, 3 Feb 2021 13:09:30 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
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
Message-ID: <YBqSejZ3XbUKFudR@dhcp22.suse.cz>
References: <20210202124857.GN242749@kernel.org>
 <6653288a-dd02-f9de-ef6a-e8d567d71d53@redhat.com>
 <YBlUXdwV93xMIff6@dhcp22.suse.cz>
 <211f0214-1868-a5be-9428-7acfc3b73993@redhat.com>
 <YBlgCl8MQuuII22w@dhcp22.suse.cz>
 <d4fe580a-ef0e-e13f-9ee4-16fb8b6d65dd@redhat.com>
 <YBlicIupOyPF9f3D@dhcp22.suse.cz>
 <95625b83-f7e2-b27a-2b99-d231338047fb@redhat.com>
 <20210202181546.GO242749@kernel.org>
 <f26a17366194880d58e67d10cb5d7d7fdf2f3c19.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f26a17366194880d58e67d10cb5d7d7fdf2f3c19.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 02-02-21 10:55:40, James Bottomley wrote:
> On Tue, 2021-02-02 at 20:15 +0200, Mike Rapoport wrote:
> > On Tue, Feb 02, 2021 at 03:34:29PM +0100, David Hildenbrand wrote:
> > > On 02.02.21 15:32, Michal Hocko wrote:
> > > > On Tue 02-02-21 15:26:20, David Hildenbrand wrote:
> > > > > On 02.02.21 15:22, Michal Hocko wrote:
> > > > > > On Tue 02-02-21 15:12:21, David Hildenbrand wrote:
> > > > > > [...]
> > > > > > > I think secretmem behaves much more like longterm GUP right
> > > > > > > now
> > > > > > > ("unmigratable", "lifetime controlled by user space",
> > > > > > > "cannot go on
> > > > > > > CMA/ZONE_MOVABLE"). I'd either want to reasonably well
> > > > > > > control/limit it or
> > > > > > > make it behave more like mlocked pages.
> > > > > > 
> > > > > > I thought I have already asked but I must have forgotten. Is
> > > > > > there any
> > > > > > actual reason why the memory is not movable? Timing attacks?
> > > > > 
> > > > > I think the reason is simple: no direct map, no copying of
> > > > > memory.
> > > > 
> > > > This is an implementation detail though and not something
> > > > terribly hard
> > > > to add on top later on. I was more worried there would be really
> > > > fundamental reason why this is not possible. E.g. security
> > > > implications.
> > > 
> > > I don't remember all the details. Let's see what Mike thinks
> > > regarding
> > > migration (e.g., security concerns).
> > 
> > Thanks for considering me a security expert :-)
> > 
> > Yet, I cannot estimate how dangerous is the temporal exposure of
> > this data to the kernel via the direct map in the simple
> > map/copy/unmap
> > sequence.
> 
> Well the safest security statement is that we never expose the data to
> the kernel because it's a very clean security statement and easy to
> enforce. It's also the easiest threat model to analyse.   Once we do
> start exposing the secret to the kernel it alters the threat profile
> and the analysis and obviously potentially provides the ROP gadget to
> an attacker to do the same. Instinct tells me that the loss of
> security doesn't really make up for the ability to swap or migrate but
> if there were a case for doing the latter, it would have to be a
> security policy of the user (i.e. a user should be able to decide their
> data is too sensitive to expose to the kernel).

The security/threat model should be documented in the changelog as
well. I am not a security expert but I would tend to agree that not
allowing even temporal mapping for data copying (in the kernel) is the
most robust approach. Whether that is generally necessary for users I do
not know.

From the API POV I think it makes sense to have two
modes. NEVER_MAP_IN_KERNEL which would imply no migrateability, no
copy_{from,to}_user, no gup or any other way for the kernel to access
content of the memory. Maybe even zero the content on the last unmap to
never allow any data leak. ALLOW_TEMPORARY would unmap the page from
the direct mapping but it would still allow temporary mappings for
data copying inside the kernel (thus allow CoW, copy*user, migration).
Which one should be default and which an opt-in I do not know. A less
restrictive mode to be default and the more restrictive an opt-in via
flags makes a lot of sense to me though.

-- 
Michal Hocko
SUSE Labs

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56EEF31B646
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 10:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhBOJOk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 04:14:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:33862 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230088AbhBOJOi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 04:14:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613380431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=miCNDkPWZZBRVJ8Jtr1LFzD24yWA9N0KNTV3BkO+MBs=;
        b=TETHPiEq8kl7uQEKm1Aff4L3NsQE0DM02/lfPkpKudaCI6/5lNvCven/uHuRT24qzIXWlb
        R5BxAqdLhSywOBM2nG5lWN1rFZRScNEvDlYO6zf3OlgEc7VuRTl3HqG4uIymDgc/8zHABu
        C6iAKZCoFVJI6hxssRHEbP17I8dvFo0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9278BAD19;
        Mon, 15 Feb 2021 09:13:51 +0000 (UTC)
Date:   Mon, 15 Feb 2021 10:13:50 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
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
Message-ID: <YCo7TqUnBdgJGkwN@dhcp22.suse.cz>
References: <20210214091954.GM242749@kernel.org>
 <052DACE9-986B-424C-AF8E-D6A4277DE635@redhat.com>
 <244f86cba227fa49ca30cd595c4e5538fe2f7c2b.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <244f86cba227fa49ca30cd595c4e5538fe2f7c2b.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 14-02-21 11:21:02, James Bottomley wrote:
> On Sun, 2021-02-14 at 10:58 +0100, David Hildenbrand wrote:
> [...]
> > > And here we come to the question "what are the differences that
> > > justify a new system call?" and the answer to this is very
> > > subjective. And as such we can continue bikeshedding forever.
> > 
> > I think this fits into the existing memfd_create() syscall just fine,
> > and I heard no compelling argument why it shouldn‘t. That‘s all I can
> > say.
> 
> OK, so let's review history.  In the first two incarnations of the
> patch, it was an extension of memfd_create().  The specific objection
> by Kirill Shutemov was that it doesn't share any code in common with
> memfd and so should be a separate system call:
> 
> https://lore.kernel.org/linux-api/20200713105812.dnwtdhsuyj3xbh4f@box/

Thanks for the pointer. But this argument hasn't been challenged at all.
It hasn't been brought up that the overlap would be considerable higher
by the hugetlb/sealing support. And so far nobody has claimed those
combinations as unviable.

> The other objection raised offlist is that if we do use memfd_create,
> then we have to add all the secret memory flags as an additional ioctl,
> whereas they can be specified on open if we do a separate system call. 
> The container people violently objected to the ioctl because it can't
> be properly analysed by seccomp and much preferred the syscall version.
> 
> Since we're dumping the uncached variant, the ioctl problem disappears
> but so does the possibility of ever adding it back if we take on the
> container peoples' objection.  This argues for a separate syscall
> because we can add additional features and extend the API with flags
> without causing anti-ioctl riots.

I am sorry but I do not understand this argument. What kind of flags are
we talking about and why would that be a problem with memfd_create
interface? Could you be more specific please?
-- 
Michal Hocko
SUSE Labs

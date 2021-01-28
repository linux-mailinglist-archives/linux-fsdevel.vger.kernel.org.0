Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A7D307AA7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 17:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbhA1QYs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 11:24:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:53964 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231634AbhA1QYq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 11:24:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611851039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WWmcYeElb62qutT0Kcoo6xDCdrj66eelF83EHgFDfB4=;
        b=ZJlUD8pQK2nIX/Cnj1UyvowYIjPxyyZKq5kI8NYKzxJt5tEqE9314CXd37wDkUTpPEa6Vf
        YEZQtVEmaZg8j88rldXEzhTt3tU4zmyFht8LR4yeM3dwIAsKI4509bn1BlnRgtEZNO+G8l
        DXrH4A5dU/j38+v0Vo5e/8cwta9YIu0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A6C7DAC41;
        Thu, 28 Jan 2021 16:23:59 +0000 (UTC)
Date:   Thu, 28 Jan 2021 17:23:58 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Christoph Lameter <cl@linux.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
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
Subject: Re: [PATCH v16 07/11] secretmem: use PMD-size pages to amortize
 direct map fragmentation
Message-ID: <YBLlHpJj0sjzrxFv@dhcp22.suse.cz>
References: <20210121122723.3446-1-rppt@kernel.org>
 <20210121122723.3446-8-rppt@kernel.org>
 <20210126114657.GL827@dhcp22.suse.cz>
 <303f348d-e494-e386-d1f5-14505b5da254@redhat.com>
 <20210126120823.GM827@dhcp22.suse.cz>
 <20210128092259.GB242749@kernel.org>
 <YBK1kqL7JA7NePBQ@dhcp22.suse.cz>
 <alpine.DEB.2.22.394.2101281326360.10563@www.lameter.com>
 <YBLA7sEKn01HXd/U@dhcp22.suse.cz>
 <alpine.DEB.2.22.394.2101281549390.11861@www.lameter.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2101281549390.11861@www.lameter.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 28-01-21 15:56:36, Cristopher Lameter wrote:
> On Thu, 28 Jan 2021, Michal Hocko wrote:
> 
> > > > If you kill the allocating process then yes, it would work, but your
> > > > process might be the very last to be selected.
> > >
> > > OOMs are different if you have a "constrained allocation". In that case it
> > > is the fault of the process who wanted memory with certain conditions.
> > > That memory is not available. General memory is available though. In that
> > > case the allocating process is killed.
> >
> > I do not see this implementation would do anything like that. Neither
> > anything like that implemented in the oom killer. Constrained
> > allocations (cpusets/memcg/mempolicy) only do restrict their selection
> > to processes which belong to the same domain. So I am not really sure
> > what you are referring to. The is only a global knob to _always_ kill
> > the allocating process on OOM.
> 
> Constrained allocations refer to allocations where the NUMA nodes are
> restricted or something else does not allow the use of arbitrary memory.
> The OOM killer changes its behavior.

Yes as described in the above paragraph.

> In the past we fell back to killing the calling process.

Yeah, but this is no longer the case since 6f48d0ebd907a (more than 10
years ago.

Anyway this is not really important because if you want to kill the
allocating task because there is no chance the fault can succed then
there is a SIGBUS as already mentioned.
-- 
Michal Hocko
SUSE Labs

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC41F307A26
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 16:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbhA1P5b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 10:57:31 -0500
Received: from gentwo.org ([3.19.106.255]:44642 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229885AbhA1P53 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 10:57:29 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id 70A813F4C1; Thu, 28 Jan 2021 15:56:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 6DA583F461;
        Thu, 28 Jan 2021 15:56:36 +0000 (UTC)
Date:   Thu, 28 Jan 2021 15:56:36 +0000 (UTC)
From:   Christoph Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Michal Hocko <mhocko@suse.com>
cc:     Mike Rapoport <rppt@kernel.org>,
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
In-Reply-To: <YBLA7sEKn01HXd/U@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.22.394.2101281549390.11861@www.lameter.com>
References: <20210121122723.3446-1-rppt@kernel.org> <20210121122723.3446-8-rppt@kernel.org> <20210126114657.GL827@dhcp22.suse.cz> <303f348d-e494-e386-d1f5-14505b5da254@redhat.com> <20210126120823.GM827@dhcp22.suse.cz> <20210128092259.GB242749@kernel.org>
 <YBK1kqL7JA7NePBQ@dhcp22.suse.cz> <alpine.DEB.2.22.394.2101281326360.10563@www.lameter.com> <YBLA7sEKn01HXd/U@dhcp22.suse.cz>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 28 Jan 2021, Michal Hocko wrote:

> > > If you kill the allocating process then yes, it would work, but your
> > > process might be the very last to be selected.
> >
> > OOMs are different if you have a "constrained allocation". In that case it
> > is the fault of the process who wanted memory with certain conditions.
> > That memory is not available. General memory is available though. In that
> > case the allocating process is killed.
>
> I do not see this implementation would do anything like that. Neither
> anything like that implemented in the oom killer. Constrained
> allocations (cpusets/memcg/mempolicy) only do restrict their selection
> to processes which belong to the same domain. So I am not really sure
> what you are referring to. The is only a global knob to _always_ kill
> the allocating process on OOM.

Constrained allocations refer to allocations where the NUMA nodes are
restricted or something else does not allow the use of arbitrary memory.
The OOM killer changes its behavior. In the past we fell back to killing
the calling process.

See constrained_alloc() in mm/oom_kill.c

static const char * const oom_constraint_text[] = {
        [CONSTRAINT_NONE] = "CONSTRAINT_NONE",
        [CONSTRAINT_CPUSET] = "CONSTRAINT_CPUSET",
        [CONSTRAINT_MEMORY_POLICY] = "CONSTRAINT_MEMORY_POLICY",
        [CONSTRAINT_MEMCG] = "CONSTRAINT_MEMCG",
};

/*
 * Determine the type of allocation constraint.
 */
static enum oom_constraint constrained_alloc(struct oom_control *oc)
{


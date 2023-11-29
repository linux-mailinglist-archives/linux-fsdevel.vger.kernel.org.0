Return-Path: <linux-fsdevel+bounces-4184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCD17FD6E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 13:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF8EC28130C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 12:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC4F1DDDF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 12:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6417E1;
	Wed, 29 Nov 2023 03:55:47 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE3832F4;
	Wed, 29 Nov 2023 03:56:34 -0800 (PST)
Received: from raptor (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 931583F5A1;
	Wed, 29 Nov 2023 03:55:42 -0800 (PST)
Date: Wed, 29 Nov 2023 11:55:39 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: David Hildenbrand <david@redhat.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
	rppt@kernel.org, hughd@google.com, pcc@google.com,
	steven.price@arm.com, anshuman.khandual@arm.com,
	vincenzo.frascino@arm.com, eugenis@google.com, kcc@google.com,
	hyesoo.yu@samsung.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 19/27] mm: mprotect: Introduce
 PAGE_FAULT_ON_ACCESS for mprotect(PROT_MTE)
Message-ID: <ZWcmuzUcpVeUnlk2@raptor>
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
 <20231119165721.9849-20-alexandru.elisei@arm.com>
 <1c79ad05-cb52-4820-b2aa-bbe07ff82b19@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c79ad05-cb52-4820-b2aa-bbe07ff82b19@redhat.com>

Hi,

On Tue, Nov 28, 2023 at 06:55:18PM +0100, David Hildenbrand wrote:
> On 19.11.23 17:57, Alexandru Elisei wrote:
> > To enable tagging on a memory range, userspace can use mprotect() with the
> > PROT_MTE access flag. Pages already mapped in the VMA don't have the
> > associated tag storage block reserved, so mark the PTEs as
> > PAGE_FAULT_ON_ACCESS to trigger a fault next time they are accessed, and
> > reserve the tag storage on the fault path.
> 
> That sounds alot like fake PROT_NONE. Would there be a way to unify hat

Yes, arm64 basically defines PAGE_FAULT_ON_ACCESS as PAGE_NONE |
PTE_TAG_STORAGE_NONE.

> handling and simply reuse pte_protnone()? For example, could we special case
> on VMA flags?
> 
> Like, don't do NUMA hinting in these special VMAs. Then, have something
> like:
> 
> if (pte_protnone(vmf->orig_pte))
> 	return handle_pte_protnone(vmf);
> 
> In there, special case on the VMA flags.

Your suggestion from the follow-up reply that an arch should know if it needs to
do something was spot on, arm64 can use the software bit in the translation
table entry for that.

So what you are proposing is this:

* Rename do_numa_page->handle_pte_protnone
* At some point in the do_numa_page (now renamed to handle_pte_protnone) flow,
  decide if pte_protnone() has been set for an arch specific reason or because
  of automatic NUMA balancing.
* if pte_protnone() has been set by an architecture, then let the architecture
  handle the fault.

If I understood you correctly, that's a good idea, and should be easy to
implement.

> 
> I *suspect* that handle_page_missing_tag_storage() stole (sorry :P) some

Indeed, most of the code is taken as-is from do_numa_page().

> code from the prot_none handling path. At least the recovery path and
> writability handling looks like it better be located shared in
> handle_pte_protnone() as well.

Yes, I agree.

Thanks,
Alex

> 
> That might take some magic out of this patch.
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 


Return-Path: <linux-fsdevel+bounces-9641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E855F843F51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 13:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 937FF2858C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 12:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25DA78B64;
	Wed, 31 Jan 2024 12:22:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CD678686;
	Wed, 31 Jan 2024 12:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706703744; cv=none; b=Bj4uyxqxKRMEpWS94DtLAhP6lAN5PdUO3mkU1zypPfem0p4aKFbZmnTuvttAKIQT/5p7QrnDaio2bNM7y3ISbnN8pvqne4Un+pFRFlxyyiS9hE/ziIuDHdvSPe+wKASo8KI6QL1+U6CWOMZP+RPovyaEevRHdQHCbSrKG7NGHWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706703744; c=relaxed/simple;
	bh=JjRzeMvW2Ua9zjpVLjV5iutNqduF5tpcfH8Ei36DH8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6hFUTjjONujxHEaxSv7vPXb1flm5NRJ9JHJgTHk++2iHqu5elkOm40HFpRBR7fCKpJW0A1RsSTm0cvd7d8GjtGs9b71lJHk33cAzMnvuED3KfiCM6MOw7yWvSxEWYA92dQfUmt3uchNuuK+1C9tjvi/qzyo/mQVwMyOqKd/NtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53ACFDA7;
	Wed, 31 Jan 2024 04:23:05 -0800 (PST)
Received: from raptor (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D3293F738;
	Wed, 31 Jan 2024 04:22:16 -0800 (PST)
Date: Wed, 31 Jan 2024 12:22:05 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
	rppt@kernel.org, hughd@google.com, pcc@google.com,
	steven.price@arm.com, vincenzo.frascino@arm.com, david@redhat.com,
	eugenis@google.com, kcc@google.com, hyesoo.yu@samsung.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 11/35] mm: Allow an arch to hook into folio
 allocation when VMA is known
Message-ID: <Zbo7bVq822iphFtc@raptor>
References: <20240125164256.4147-1-alexandru.elisei@arm.com>
 <20240125164256.4147-12-alexandru.elisei@arm.com>
 <1e03aec4-705a-41b6-b258-0b8944d9dc0c@arm.com>
 <Zbje4T5tZ5k707Wg@raptor>
 <7612b843-cd31-4917-87c0-c26802c5bef2@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7612b843-cd31-4917-87c0-c26802c5bef2@arm.com>

Hi,

On Wed, Jan 31, 2024 at 12:23:51PM +0530, Anshuman Khandual wrote:
> 
> 
> On 1/30/24 17:04, Alexandru Elisei wrote:
> > Hi,
> > 
> > On Tue, Jan 30, 2024 at 03:25:20PM +0530, Anshuman Khandual wrote:
> >>
> >> On 1/25/24 22:12, Alexandru Elisei wrote:
> >>> arm64 uses VM_HIGH_ARCH_0 and VM_HIGH_ARCH_1 for enabling MTE for a VMA.
> >>> When VM_HIGH_ARCH_0, which arm64 renames to VM_MTE, is set for a VMA, and
> >>> the gfp flag __GFP_ZERO is present, the __GFP_ZEROTAGS gfp flag also gets
> >>> set in vma_alloc_zeroed_movable_folio().
> >>>
> >>> Expand this to be more generic by adding an arch hook that modifes the gfp
> >>> flags for an allocation when the VMA is known.
> >>>
> >>> Note that __GFP_ZEROTAGS is ignored by the page allocator unless __GFP_ZERO
> >>> is also set; from that point of view, the current behaviour is unchanged,
> >>> even though the arm64 flag is set in more places.  When arm64 will have
> >>> support to reuse the tag storage for data allocation, the uses of the
> >>> __GFP_ZEROTAGS flag will be expanded to instruct the page allocator to try
> >>> to reserve the corresponding tag storage for the pages being allocated.
> >> Right but how will pushing __GFP_ZEROTAGS addition into gfp_t flags further
> >> down via a new arch call back i.e arch_calc_vma_gfp() while still maintaining
> >> (vma->vm_flags & VM_MTE) conditionality improve the current scenario. Because
> > I'm afraid I don't follow you.
> 
> I was just asking whether the overall scope of __GFP_ZEROTAGS flag is being
> increased to cover more core MM paths through this patch. I think you have
> already answered that below.
> 
> > 
> >> the page allocator could have still analyzed alloc flags for __GFP_ZEROTAGS
> >> for any additional stuff.
> >>
> >> OR this just adds some new core MM paths to get __GFP_ZEROTAGS which was not
> >> the case earlier via this call back.
> > Before this patch: vma_alloc_zeroed_movable_folio() sets __GFP_ZEROTAGS.
> > After this patch: vma_alloc_folio() sets __GFP_ZEROTAGS.
> 
> Understood.
> 
> > 
> > This patch is about adding __GFP_ZEROTAGS for more callers.
> 
> Right, I guess that is the real motivation for this patch. But just wondering
> does this cover all possible anon fault paths for converting given vma_flag's
> VM_MTE flag into page alloc flag __GFP_ZEROTAGS ? Aren't there any other file
> besides (mm/shmem.c) which needs to be changed to include arch_calc_vma_gfp() ?

My thoughts exactly. I went through most of the fault handling code, and
from the code I read, all the allocation were executed with
vma_alloc_folio() or by shmem.

That's not to say there's no scope for improvment, there definitely is, but
since having __GFP_ZEROTAGS isn't necessary for correctness (but it's very
useful for performance, since it can avoid a page fault and a page
migration) and this series is an RFC I settled on changing only the above,
since KVM support for dynamic tag storage also benefits from this change.

The series is very big already, I wanted to settle on an approach that is
acceptable for upstreaming before thinking too much about performance.

Thanks,
Alex


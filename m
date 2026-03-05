Return-Path: <linux-fsdevel+bounces-79497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKWEIAubqWnFAwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 16:02:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A0621417C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 16:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E8BA3027B6F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 14:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDC53B583E;
	Thu,  5 Mar 2026 14:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5aWxIL9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3CA2EBB86;
	Thu,  5 Mar 2026 14:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772722643; cv=none; b=HgbuxveQVxQJ4z9z+M4jrCJjWSpFAPCvcFDz3uissA1Ywx376arCAOv9okTBwf3aneC71u4jxXtbKryp1ZZsImfE1UmTweFrdTaSKL98A6eSZ1IFwOHxqI7gB+iPnnJ87ql8+WEVz1+Gd5mveDhlFgACQjeX8mOhvDYWnjJJ7WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772722643; c=relaxed/simple;
	bh=IEc4WYX37mgMOxzZzlTDIloDSaDnVqxnv/57atbWyWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eL+MxmJFqywmK22vZ12Yhtvj1Jr74E2emIuplaOUKda/ZeHAKsWMReaswvcO+edlQVSzUWqqhPt861JXWaCQPMFPPKd8InrqDRV7eRFKPBmdV4JmSbAae+uwzX9rgF4W3/8FrWtSYrZg5Ejg/1OuvkUt2jc74zuwmIkD8YrAFfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5aWxIL9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D36C116C6;
	Thu,  5 Mar 2026 14:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772722643;
	bh=IEc4WYX37mgMOxzZzlTDIloDSaDnVqxnv/57atbWyWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E5aWxIL9Xu+PK4R9e7q1xeRi0FX0o9xCenpXCKB0U4U+owli7skTbsyyslJA/lkPm
	 R1YydSBWrVKOZGhRUvXAWj/YIErLLyuPQ5CvZcOdjAIV/VqRMJ3IfAFzGQA2D8Yjvj
	 9s3IMZSw4W0eZH9QmIOn4I93x/3BEGL7B06H5A/d0q5RyJFzI1KcN8x7Id7K6/6qmr
	 9xDu1wb90DW+DVRqFOzY8R1yR5SiCywbr+jN2MWhNOIh4pbj09o2XUuATQM+Lvktd6
	 65asY8zz6HYED2m/Ji7XhXjpm+WkbdwPmj1O5hMbwnNl5R+ySaNmpys6O+iFYPQnlj
	 GFXci6SveISgw==
Date: Thu, 5 Mar 2026 14:57:15 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Usama Arif <usamaarif642@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v1] docs: filesystems: clarify KernelPageSize vs.
 MMUPageSize in smaps
Message-ID: <ce2f4343-8bc4-4edd-a922-dd71a09a34e3@lucifer.local>
References: <20260304155636.77433-1-david@kernel.org>
 <b24be8c2-32d3-4e3e-9fbf-8a0068c360d6@lucifer.local>
 <c5330f9e-db41-496b-b580-73ebec9cd811@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5330f9e-db41-496b-b580-73ebec9cd811@kernel.org>
X-Rspamd-Queue-Id: E2A0621417C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79497-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,linux-foundation.org,oracle.com,nvidia.com,linux.alibaba.com,redhat.com,arm.com,kernel.org,linux.dev,lwn.net,linuxfoundation.org,gmail.com,linux.intel.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 02:32:49PM +0100, David Hildenbrand (Arm) wrote:
>
> >
> > Ah wait you dedicate a whole paragraph after this to tha :)
>
> Correct :)
>
> >
> >> +mapping that is currently resident in RAM (RSS); the process's proportional
> >> +share of this mapping (PSS); and the number of clean and dirty shared and
> >> +private pages in the mapping.
> >> +
> >> +Historically, the "KernelPageSize" always corresponds to the "MMUPageSize",
> >> +except when a larger kernel page size is emulated on a system with a smaller
> >
> > NIT: is -> was, as historically implies past tense.
> >
> > But it's maybe better to say:
> >
> > +Historically, the "KernelPageSize" has always corresponded to the "MMUPageSize",
> >
> > And:
> >
> > +except when a larger kernel page size is being emulated on a system with a smaller
> >
>
> Given that the PPC64 thingy still exists in the tree, I'll probably do:
>
> "KernelPageSize" always corresponds to "MMUPageSize", except when a
> larger kernel page size is emulated on a system with a smaller page size
> used by the MMU, which is the case for some PPC64 setups with hugetlb.
>
> >> +page size used by the MMU, which was the case for PPC64 in the past.
> >> +Further, "KernelPageSize" and "MMUPageSize" always correspond to the
> >
> > NIT: Further -> Furthermore
> >
>
> Helpful.
>
> >> +smallest possible granularity (fallback) that could be encountered in a
> >
> > could be -> can be
> >
> > Since we are really talking about the current situation, even if this, is
> > effect, a legacy thing.
> >
> >> +VMA throughout its lifetime.  These values are not affected by any current
> >> +transparent grouping of pages by Linux (Transparent Huge Pages) or any
> >
> > 'transparent grouping of pages' reads a bit weirdly.
> >
> > Maybe simplify to:
> >
> > +These values are not affected by Transparent Huge Pages being in effect, or any...
>
> Works for me.
>
> >
> >> +current usage of larger MMU page sizes (either through architectural
> >
> > NIT: current usage -> usage
>
> Ack.
>
> >
> >> +huge-page mappings or other transparent groupings done by the MMU).
> >
> > Again I think 'transparent groupings' is a bit unclear. Perhaps instead:
> >
> > +huge-page mappings or other explicit or implicit coalescing of virtual ranges
> > +performed by the MMU).
>
> I'd assume the educated reader does not know what "explicit/implicit
> coalescing" even means, but works for me. :)
>
> >
> > ?
> >
> >> +"AnonHugePages", "ShmemPmdMapped" and "FilePmdMapped" provide insight into
> >> +the usage of some architectural huge-page mappings.
> >
> > Is 'some' necessary here? Seems to make it a bit vague.
>
> I had PUDs in mind. I can just call it
>
> "PMD-level architectural ..."
>
> >
> >>
> >>  The "proportional set size" (PSS) of a process is the count of pages it has
> >>  in memory, where each page is divided by the number of processes sharing it.
> >> @@ -528,10 +541,14 @@ pressure if the memory is clean. Please note that the printed value might
> >>  be lower than the real value due to optimizations used in the current
> >>  implementation. If this is not desirable please file a bug report.
> >>
> >> -"AnonHugePages" shows the amount of memory backed by transparent hugepage.
> >> +"AnonHugePages", "ShmemPmdMapped" and "FilePmdMapped" show the amount of
> >> +memory backed by transparent hugepages that are currently mapped through
> >> +architectural huge-page mappings (PMD). "AnonHugePages" corresponds to memory
> >
> > 'mapped through architectural huge-page mappings (PMD)' reads a bit strangely to
> > me,
> >
> > Perhaps 'mapped by transparent huge pages at a PMD page table level' instead?
> >
>
> I'll simplify to
>
> "mapped by architectural huge-page mappings at the PMD level"
>
>
> >> +that does not belong to a file, "ShmemPmdMapped" to shared memory (shmem/tmpfs)
> >> +and "FilePmdMapped" to file-backed memory (excluding shmem/tmpfs).
> >>
> >> -"ShmemPmdMapped" shows the amount of shared (shmem/tmpfs) memory backed by
> >> -huge pages.
> >> +There are no dedicated entries for transparent huge pages (or similar concepts)
> >> +that are not mapped through architectural huge-page mappings (PMD).
> >
> > similarly, perhaps better as 'are not mapped by transparent huge pages at a PMD
> > page table level'?
>
> I'll similarly call it "mapped by architectural huge-page mappings at
> the PMD level"
>
> Thanks a bunch!
>
> --
> Cheers,
>
> David

Thanks on all!


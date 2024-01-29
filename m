Return-Path: <linux-fsdevel+bounces-9365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 870C4840480
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 13:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAA371C22D1B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 12:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA6C604BB;
	Mon, 29 Jan 2024 11:59:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70D9604AD;
	Mon, 29 Jan 2024 11:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706529573; cv=none; b=oHP/DNRjXMoOLXKo3f26ZEnXd/YVA86ZoGYdiOePzoxahbxCHy7ggcxLajTT2PV3f3QdXxYmxWaOWRpma8EV6KAzwI1XKFofqZ72nxXeC2S1xJnXUtmu4Zi9R52d5lWlUM6GK+fxrGaKElhviUKKbP6WM4PYL/ANVVbfiv1L2VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706529573; c=relaxed/simple;
	bh=g8VjbZmPPMmeZJ0+muiwD3pbzn3IrrJd/y/zYOa4JkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YmhODcLWy+OOvp7lKPZiUi3t8HxOVjoJS60FHg8hplMudV6eAL82GdfmAjEu8p2F/TifNr+yb+gsBcMGGGE5GGuCW7PLp9pM5N23CwlpCw8DXiqmYkVSd4JA84wIQn0yG0ZzZ5OXnHdcKXm3EIDPjCzQ56HB0vkFUKQMn1iceFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF0DB1FB;
	Mon, 29 Jan 2024 04:00:13 -0800 (PST)
Received: from raptor (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F6793F5A1;
	Mon, 29 Jan 2024 03:59:24 -0800 (PST)
Date: Mon, 29 Jan 2024 11:59:21 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Peter Collingbourne <pcc@google.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
	rppt@kernel.org, hughd@google.com, steven.price@arm.com,
	anshuman.khandual@arm.com, vincenzo.frascino@arm.com,
	david@redhat.com, eugenis@google.com, kcc@google.com,
	hyesoo.yu@samsung.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 11/35] mm: Allow an arch to hook into folio
 allocation when VMA is known
Message-ID: <ZbeTGX1QSQlhcmh2@raptor>
References: <20240125164256.4147-1-alexandru.elisei@arm.com>
 <20240125164256.4147-12-alexandru.elisei@arm.com>
 <CAMn1gO6hx7yaFHEYVbkpPocAxQmQc3JBgppcNSJw9SUfyvjwbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMn1gO6hx7yaFHEYVbkpPocAxQmQc3JBgppcNSJw9SUfyvjwbQ@mail.gmail.com>

Hi Peter,

On Fri, Jan 26, 2024 at 12:00:36PM -0800, Peter Collingbourne wrote:
> On Thu, Jan 25, 2024 at 8:43 AM Alexandru Elisei
> <alexandru.elisei@arm.com> wrote:
> >
> > arm64 uses VM_HIGH_ARCH_0 and VM_HIGH_ARCH_1 for enabling MTE for a VMA.
> > When VM_HIGH_ARCH_0, which arm64 renames to VM_MTE, is set for a VMA, and
> > the gfp flag __GFP_ZERO is present, the __GFP_ZEROTAGS gfp flag also gets
> > set in vma_alloc_zeroed_movable_folio().
> >
> > Expand this to be more generic by adding an arch hook that modifes the gfp
> > flags for an allocation when the VMA is known.
> >
> > Note that __GFP_ZEROTAGS is ignored by the page allocator unless __GFP_ZERO
> > is also set; from that point of view, the current behaviour is unchanged,
> > even though the arm64 flag is set in more places.  When arm64 will have
> > support to reuse the tag storage for data allocation, the uses of the
> > __GFP_ZEROTAGS flag will be expanded to instruct the page allocator to try
> > to reserve the corresponding tag storage for the pages being allocated.
> >
> > The flags returned by arch_calc_vma_gfp() are or'ed with the flags set by
> > the caller; this has been done to keep an architecture from modifying the
> > flags already set by the core memory management code; this is similar to
> > how do_mmap() -> calc_vm_flag_bits() -> arch_calc_vm_flag_bits() has been
> > implemented. This can be revisited in the future if there's a need to do
> > so.
> >
> > Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> 
> This patch also needs to update the non-CONFIG_NUMA definition of
> vma_alloc_folio in include/linux/gfp.h to call arch_calc_vma_gfp. See:
> https://r.android.com/2849146

Of course, you're already reported this to me, I cherry-pick the version of
the patch that doesn't have the fix for this series.

Will fix.

Thanks,
Alex

> 
> Peter


Return-Path: <linux-fsdevel+bounces-3927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A32AE7F9F45
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 13:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C94F1C20D9F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 12:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDFF1CFBC;
	Mon, 27 Nov 2023 12:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7AF2BEA;
	Mon, 27 Nov 2023 04:10:07 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA2DA2F4;
	Mon, 27 Nov 2023 04:10:54 -0800 (PST)
Received: from raptor (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39E373F73F;
	Mon, 27 Nov 2023 04:10:02 -0800 (PST)
Date: Mon, 27 Nov 2023 12:09:59 +0000
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
Subject: Re: [PATCH RFC v2 05/27] mm: page_alloc: Add an arch hook to allow
 prep_new_page() to fail
Message-ID: <ZWSHF2hVOPTBIQLY@raptor>
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
 <20231119165721.9849-6-alexandru.elisei@arm.com>
 <dadc9d17-f311-47f1-a264-28b42bed0ab0@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dadc9d17-f311-47f1-a264-28b42bed0ab0@redhat.com>

Hi,

Thank you so much for your comments, there are genuinely useful.

On Fri, Nov 24, 2023 at 08:35:47PM +0100, David Hildenbrand wrote:
> On 19.11.23 17:56, Alexandru Elisei wrote:
> > Introduce arch_prep_new_page(), which will be used by arm64 to reserve tag
> > storage for an allocated page. Reserving tag storage can fail, for example,
> > if the tag storage page has a short pin on it, so allow prep_new_page() ->
> > arch_prep_new_page() to similarly fail.
> 
> But what are the side-effects of this? How does the calling code recover?
> 
> E.g., what if we need to populate a page into user space, but that
> particular page we allocated fails to be prepared? So we inject a signal
> into that poor process?

When the page fails to be prepared, it is put back to the tail of the
freelist with __free_one_page(.., FPI_TO_TAIL). If all the allocation paths
are exhausted and no page has been found for which tag storage has been
reserved, then that's treated like an OOM situation.

I have been thinking about this, and I think I can simplify the code by
making tag reservation a best effort approach. The page can be allocated
even if reserving tag storage fails, but the page is marked as invalid in
set_pte_at() (PAGE_NONE + an extra bit to tell arm64 that it needs tag
storage) and next time it is accessed, arm64 will reserve tag storage in
the fault handling code (the mechanism for that is implemented in patch #19
of the series, "mm: mprotect: Introduce PAGE_FAULT_ON_ACCESS for
mprotect(PROT_MTE)").

With this new approach, prep_new_page() stays the way it is, and no further
changes are required for the page allocator, as there are already arch
callbacks that can be used for that, for example tag_clear_highpage() and
arch_alloc_page(). The downside is extra page faults, which might impact
performance.

What do you think?

Thanks,
Alex

> 
> -- 
> Cheers,
> 
> David / dhildenb
> 


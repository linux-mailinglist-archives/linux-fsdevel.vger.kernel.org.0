Return-Path: <linux-fsdevel+bounces-3929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEAF7FA041
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 14:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FAB228168A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 13:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989FF2C85F;
	Mon, 27 Nov 2023 13:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31C2F10F;
	Mon, 27 Nov 2023 05:03:13 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82C4A2F4;
	Mon, 27 Nov 2023 05:04:00 -0800 (PST)
Received: from raptor (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B14753F73F;
	Mon, 27 Nov 2023 05:03:07 -0800 (PST)
Date: Mon, 27 Nov 2023 13:03:04 +0000
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
Subject: Re: [PATCH RFC v2 06/27] mm: page_alloc: Allow an arch to hook early
 into free_pages_prepare()
Message-ID: <ZWSTiCghf8nMFy4G@raptor>
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
 <20231119165721.9849-7-alexandru.elisei@arm.com>
 <45466b05-d620-41e5-8a2b-05c420b8fa7b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45466b05-d620-41e5-8a2b-05c420b8fa7b@redhat.com>

Hi,

On Fri, Nov 24, 2023 at 08:36:52PM +0100, David Hildenbrand wrote:
> On 19.11.23 17:57, Alexandru Elisei wrote:
> > Add arch_free_pages_prepare() hook that is called before that page flags
> > are cleared. This will be used by arm64 when explicit management of tag
> > storage pages is enabled.
> 
> Can you elaborate a bit what exactly will be done by that code with that
> information?

Of course.

The MTE code that is in the kernel today uses the PG_arch_2 page flag, which it
renames to PG_mte_tagged, to track if a page has been mapped with tagging
enabled. That flag is cleared by free_pages_prepare() when it does:

	page->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;

When tag storage management is enabled, tag storage is reserved for a page if
and only if the page is mapped as tagged. When a page is freed, the code looks
at the PG_mte_tagged flag to determine if the page was mapped as tagged, and
therefore has tag storage reserved, to determine if the corresponding tag
storage should also be freed.

I have considered using arch_free_page(), but free_pages_prepare() calls the
function after the flags are cleared.

Does that answer your question?

Alex

> 
> -- 
> Cheers,
> 
> David / dhildenb
> 


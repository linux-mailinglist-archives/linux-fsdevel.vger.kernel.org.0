Return-Path: <linux-fsdevel+bounces-4066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0037FC36D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 19:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5B74B20DF9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 18:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BE13D0BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 18:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7074710EB;
	Tue, 28 Nov 2023 09:18:07 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9871BC15;
	Tue, 28 Nov 2023 09:18:54 -0800 (PST)
Received: from raptor (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C82A3F6C4;
	Tue, 28 Nov 2023 09:18:02 -0800 (PST)
Date: Tue, 28 Nov 2023 17:17:59 +0000
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
Message-ID: <ZWYgx28LB28x5Pkb@raptor>
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
 <20231119165721.9849-7-alexandru.elisei@arm.com>
 <45466b05-d620-41e5-8a2b-05c420b8fa7b@redhat.com>
 <ZWSTiCghf8nMFy4G@raptor>
 <2e2d3f51-34e3-4982-b982-ab7b555cba21@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e2d3f51-34e3-4982-b982-ab7b555cba21@redhat.com>

Hi,

On Tue, Nov 28, 2023 at 05:58:55PM +0100, David Hildenbrand wrote:
> On 27.11.23 14:03, Alexandru Elisei wrote:
> > Hi,
> > 
> > On Fri, Nov 24, 2023 at 08:36:52PM +0100, David Hildenbrand wrote:
> > > On 19.11.23 17:57, Alexandru Elisei wrote:
> > > > Add arch_free_pages_prepare() hook that is called before that page flags
> > > > are cleared. This will be used by arm64 when explicit management of tag
> > > > storage pages is enabled.
> > > 
> > > Can you elaborate a bit what exactly will be done by that code with that
> > > information?
> > 
> > Of course.
> > 
> > The MTE code that is in the kernel today uses the PG_arch_2 page flag, which it
> > renames to PG_mte_tagged, to track if a page has been mapped with tagging
> > enabled. That flag is cleared by free_pages_prepare() when it does:
> > 
> > 	page->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
> > 
> > When tag storage management is enabled, tag storage is reserved for a page if
> > and only if the page is mapped as tagged. When a page is freed, the code looks
> > at the PG_mte_tagged flag to determine if the page was mapped as tagged, and
> > therefore has tag storage reserved, to determine if the corresponding tag
> > storage should also be freed.
> > 
> > I have considered using arch_free_page(), but free_pages_prepare() calls the
> > function after the flags are cleared.
> > 
> > Does that answer your question?
> 
> Yes, please add some of that to the patch description!

Will do!

Thanks,
Alex

> 
> -- 
> Cheers,
> 
> David / dhildenb
> 


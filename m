Return-Path: <linux-fsdevel+bounces-4388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A59B7FF2A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 15:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8C35B211BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314255100B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8537BD48;
	Thu, 30 Nov 2023 05:32:24 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA30DC15;
	Thu, 30 Nov 2023 05:33:10 -0800 (PST)
Received: from raptor (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 415D63F5A1;
	Thu, 30 Nov 2023 05:32:19 -0800 (PST)
Date: Thu, 30 Nov 2023 13:32:16 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: David Hildenbrand <david@redhat.com>
Cc: Hyesoo Yu <hyesoo.yu@samsung.com>, catalin.marinas@arm.com,
	will@kernel.org, oliver.upton@linux.dev, maz@kernel.org,
	james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	arnd@arndb.de, akpm@linux-foundation.org, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
	rppt@kernel.org, hughd@google.com, pcc@google.com,
	steven.price@arm.com, anshuman.khandual@arm.com,
	vincenzo.frascino@arm.com, eugenis@google.com, kcc@google.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 19/27] mm: mprotect: Introduce
 PAGE_FAULT_ON_ACCESS for mprotect(PROT_MTE)
Message-ID: <ZWiO4PWfK2gKDLGr@raptor>
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
 <CGME20231119165921epcas2p3dce0532847d59a9c3973b4e41102e27d@epcas2p3.samsung.com>
 <20231119165721.9849-20-alexandru.elisei@arm.com>
 <20231129092725.GD2988384@tiffany>
 <ZWh6vl8DfXQbKo9O@raptor>
 <4e7a4054-092c-4e34-ae00-0105d7c9343c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e7a4054-092c-4e34-ae00-0105d7c9343c@redhat.com>

Hi,

On Thu, Nov 30, 2023 at 01:49:34PM +0100, David Hildenbrand wrote:
> > > > +
> > > > +out_retry:
> > > > +	put_page(page);
> > > > +	if (vmf->flags & FAULT_FLAG_VMA_LOCK)
> > > > +		vma_end_read(vma);
> > > > +	if (fault_flag_allow_retry_first(vmf->flags)) {
> > > > +		err = VM_FAULT_RETRY;
> > > > +	} else {
> > > > +		/* Replay the fault. */
> > > > +		err = 0;
> > > 
> > > Hello!
> > > 
> > > Unfortunately, if the page continues to be pinned, it seems like fault will continue to occur.
> > > I guess it makes system stability issue. (but I'm not familiar with that, so please let me know if I'm mistaken!)
> > > 
> > > How about migrating the page when migration problem repeats.
> > 
> > Yes, I had the same though in the previous iteration of the series, the
> > page was migrated out of the VMA if tag storage couldn't be reserved.
> > 
> > Only short term pins are allowed on MIGRATE_CMA pages, so I expect that the
> > pin will be released before the fault is replayed. Because of this, and
> > because it makes the code simpler, I chose not to migrate the page if tag
> > storage couldn't be reserved.
> 
> There are still some cases that are theoretically problematic: vmsplice()
> can pin pages forever and doesn't use FOLL_LONGTERM yet.
> 
> All these things also affect other users that rely on movability (e.g., CMA,
> memory hotunplug).

I wasn't aware of that, thank you for the information. Then to ensure that the
process doesn't hang by replying the loop indefinitely, I'll migrate the page if
tag storage cannot be reserved. Looking over the code again, I think I can reuse
the same function that migrates tag storage pages out of the MTE VMA (added in
patch #21), so no major changes needed.

Thanks,
Alex

> 
> -- 
> Cheers,
> 
> David / dhildenb
> 
> 


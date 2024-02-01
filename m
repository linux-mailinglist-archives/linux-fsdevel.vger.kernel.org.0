Return-Path: <linux-fsdevel+bounces-9909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31146845E96
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 18:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 649F91C2817D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 17:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BEC65E21;
	Thu,  1 Feb 2024 17:33:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5A765E26;
	Thu,  1 Feb 2024 17:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706808780; cv=none; b=iIpGPtAbQoFBJDoMWg3UyHWXjMmtL6LOjykHuGTSEOzFGx8wkjxf0sET8Yk1+xmLikWfscVCLQKlRjtC54dKHFYN3r+5HTJoxra0P4rij8jh7uTx42yh0DWF2J6dn+yc9ckXcOgHKRL3P2jCg9UqBDr0yuyVpYF7nL8m8bJjmWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706808780; c=relaxed/simple;
	bh=mtOf7q5mpI68Bu70Fl1ab1V8V2R2720fCfpdC9af4Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=slSmd8pju0C+Oe/PJ0SX0jmno6Zd7Wyz2/quHdEhQH/2CDUE6XiRrg6k+Li5PI/rbKxYfTRmV92k5fwEnU9obEOIXq3p9LHQdo5s0SHSnI4TbyYTDr65dX8MxljDXdVA5YpIBc1MWzqMSDkDV6Yp2V0vV1At947wxRQFPZqwBPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDF6DDA7;
	Thu,  1 Feb 2024 09:33:38 -0800 (PST)
Received: from raptor (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A62F3F738;
	Thu,  1 Feb 2024 09:32:51 -0800 (PST)
Date: Thu, 1 Feb 2024 17:32:40 +0000
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
Subject: Re: [PATCH RFC v3 12/35] mm: Call arch_swap_prepare_to_restore()
 before arch_swap_restore()
Message-ID: <ZbvVuIUe3W8OZnZ5@raptor>
References: <20240125164256.4147-1-alexandru.elisei@arm.com>
 <20240125164256.4147-13-alexandru.elisei@arm.com>
 <08a4971e-c31d-46f7-afbc-7404bd9a293f@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08a4971e-c31d-46f7-afbc-7404bd9a293f@arm.com>

Hi,

On Thu, Feb 01, 2024 at 09:00:23AM +0530, Anshuman Khandual wrote:
> 
> 
> On 1/25/24 22:12, Alexandru Elisei wrote:
> > arm64 uses arch_swap_restore() to restore saved tags before the page is
> > swapped in and it's called in atomic context (with the ptl lock held).
> > 
> > Introduce arch_swap_prepare_to_restore() that will allow an architecture to
> > perform extra work during swap in and outside of a critical section.
> > This will be used by arm64 to allocate a buffer in memory where to
> > temporarily save tags if tag storage is not available for the page being
> > swapped in.
> 
> Just wondering if tag storage will always be unavailable for tagged pages
> being swapped in ? OR there are cases where allocation might not even be

In some (probably most) situations, tag storage will be available for the
page that will be swapped in. That's because either the page will have been
taken from the swap cache (which means it hasn't been freed, so it still
has tag storage reserved) or it has been allocated with vma_alloc_folio()
(when it's swapped back in in a VMA with VM_MTE set).

I've explained a scenario where tags will be restored for a page without
tag storage in patch #28 ("mte: swap: Handle tag restoring when missing tag
storage") [1]. Basically, it's because tagged pages can be mapped as tagged
in one VMA and untagged in another VMA; and swap tags are restored the
first time a page is swapped back in, even if it's swapped in a VMA with
MTE disabled.

[1] https://lore.kernel.org/linux-arm-kernel/20240125164256.4147-29-alexandru.elisei@arm.com/

> required ? This prepare phase needs to be outside the critical section -
> only because there might be memory allocations ?

Yes, exactly. See patch above :)

Thanks,
Alex


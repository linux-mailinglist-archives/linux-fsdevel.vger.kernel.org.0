Return-Path: <linux-fsdevel+bounces-9527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E8A842433
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 12:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6333628D2D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 11:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F117679F5;
	Tue, 30 Jan 2024 11:56:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D0B67749;
	Tue, 30 Jan 2024 11:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706615806; cv=none; b=GE0DEj0vdoQUZ/NRlrYl0ZfQzmj9J9C9ExTdhSwD0IcTiAitSQ4nlEtDlpM+XlLJdpfEf0cI471ziWfksfIVr0oU8euZWVLpl3+gFjW3LjbwvL5KgJzB/gXX+FCMocPQWFigBDLCfuv8OenEgDR5sn2NudUI79KYaAeFlXzipRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706615806; c=relaxed/simple;
	bh=J434d3JUEnJGRx6DbeepNFaekQshHeqk6I1rEBF7TJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4C41s9efah6td+QuQNn9GLXTVspsC+PXvcAdNljlU+eWFXNc/Xal+/d/xoOFRukS/t76sGzCghINk6noZj/4qYJ5PFK4ogXfYYqdjDt2umDhiM9/W9pJ0X4dk27HNdO48yucxP8lpVCrf5Rq6iQBcxq1BWeTaOjvf1JvCa4wwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37B73DA7;
	Tue, 30 Jan 2024 03:57:27 -0800 (PST)
Received: from raptor (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B37A3F762;
	Tue, 30 Jan 2024 03:56:37 -0800 (PST)
Date: Tue, 30 Jan 2024 11:56:31 +0000
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
Subject: Re: [PATCH RFC v3 01/35] mm: page_alloc: Add gfp_flags parameter to
 arch_alloc_page()
Message-ID: <Zbjj4fin09_TCQp8@raptor>
References: <20240125164256.4147-1-alexandru.elisei@arm.com>
 <20240125164256.4147-2-alexandru.elisei@arm.com>
 <de0c74b3-0c7d-4f21-8454-659e8b616ea7@arm.com>
 <ZbePA2dGE6Vs-58t@raptor>
 <3fbfb5fc-83a4-49da-ba75-9b671ffe0569@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fbfb5fc-83a4-49da-ba75-9b671ffe0569@arm.com>

Hi,

On Tue, Jan 30, 2024 at 09:56:10AM +0530, Anshuman Khandual wrote:
> 
> 
> On 1/29/24 17:11, Alexandru Elisei wrote:
> > Hi,
> > 
> > On Mon, Jan 29, 2024 at 11:18:59AM +0530, Anshuman Khandual wrote:
> >> On 1/25/24 22:12, Alexandru Elisei wrote:
> >>> Extend the usefulness of arch_alloc_page() by adding the gfp_flags
> >>> parameter.
> >> Although the change here is harmless in itself, it will definitely benefit
> >> from some additional context explaining the rationale, taking into account
> >> why-how arch_alloc_page() got added particularly for s390 platform and how
> >> it's going to be used in the present proposal.
> > arm64 will use it to reserve tag storage if the caller requested a tagged
> > page. Right now that means that __GFP_ZEROTAGS is set in the gfp mask, but
> > I'll rename it to __GFP_TAGGED in patch #18 ("arm64: mte: Rename
> > __GFP_ZEROTAGS to __GFP_TAGGED") [1].
> > 
> > [1] https://lore.kernel.org/lkml/20240125164256.4147-19-alexandru.elisei@arm.com/
> 
> Makes sense, but please do update the commit message explaining how
> new gfp mask argument will be used to detect tagged page allocation
> requests, further requiring tag storage allocation.

Will do, thanks!

Alex


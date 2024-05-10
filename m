Return-Path: <linux-fsdevel+bounces-19286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA6A8C2A1F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 20:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 116A31F22907
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 18:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A28F4437A;
	Fri, 10 May 2024 18:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QlT4L3vG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD7E1BDC8;
	Fri, 10 May 2024 18:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715367247; cv=none; b=gI9Ih8kW1ddOVECqaQAZ14IN9hRXpFntzSdOK4XJKBa6da98xuDUTMThcIFxv3ZYC+oPIEiHHb6VfLXb+P0xAwmyxFtszFnb6mV2kAshcZjWlqgoAzWUWK40Nd78qt13xQmaqQUb3WefWVGi8x6vhRwImBctq4e4q2Mqve4wXmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715367247; c=relaxed/simple;
	bh=4vpAjobi1YxeVzKhUzPgFAloD1MAKmnN9hswaFis0sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOMp9U2ZpZ1xi5HmJuDPai+50uu2Pf06gHFLGet5fQE/9DM466+gWwLPRUu1r1chS7uzk/mgtUH31D4DuFchFKPbp3GQu5ZWH0EHADRujugzzuqY/UmQjP9NKKleziy+vGK9puW/9KITQMUUa7icsB8CxM8vWQQ8z3gPXjn0lGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QlT4L3vG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IendhRezRdHkCFfFsZTgYGRwbs6ppEzGZGzENXeNAlY=; b=QlT4L3vGo5BrUtvEY1sfaC06j7
	To1YWpICqsmeQ609slk/5cgfCAReOS553T/uzYN3F0aMh6cgEm3exzjNMR7B2WFOrXcSYGX+3yB7o
	r0WqXAinAy3ItWy6mo7YlGNIezhpxG16dFJ3gZh1Y0DEPGv2CyFhyW2mKWCO2k/pfWFGOHIGo10YD
	ymHGxYCFNEOg2CrRU6zPUNhic1J7oovXxEmJ0nJOo/2W6+ONVa6P+NvbHTkNm6jl82No+JfNjaY/p
	n9ufYyaf9xxVbyolbD8JeMkS0eQ/X8hSmDt9QNe/jq4wzIRfUp8dRZbZ9IcusIR/OSvaQPfabAKy0
	dQg5K0Hw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5VNP-00000006BoA-0F3k;
	Fri, 10 May 2024 18:53:51 +0000
Date: Fri, 10 May 2024 11:53:51 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Christoph Lameter <christoph@lameter.com>,
	Christoph Hellwig <hch@lst.de>, Dave Chinner <david@fromorbit.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"hughd@google.com" <hughd@google.com>,
	"ioworker0@gmail.com" <ioworker0@gmail.com>,
	"wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
	"ying.huang@intel.com" <ying.huang@intel.com>,
	"21cnbao@gmail.com" <21cnbao@gmail.com>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"shy828301@gmail.com" <shy828301@gmail.com>,
	"ziy@nvidia.com" <ziy@nvidia.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 0/8] add mTHP support for anonymous shmem
Message-ID: <Zj5tP7k1muaCDtO_@bombadil.infradead.org>
References: <cover.1714978902.git.baolin.wang@linux.alibaba.com>
 <CGME20240508113934eucas1p13a3972f3f9955365f40155e084a7c7d5@eucas1p1.samsung.com>
 <fqtaxc5pgu3zmvbdad4w6xty5iozye7v5z2b5ckqcjv273nz7b@hhdrjwf6rai3>
 <f44dc19a-e117-4418-9114-b723c5dc1178@redhat.com>
 <ZjvRPLaXQewA8K4s@bombadil.infradead.org>
 <23ea6dbd-1d4e-4aeb-900b-646db880cfb6@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23ea6dbd-1d4e-4aeb-900b-646db880cfb6@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Thu, May 09, 2024 at 07:48:46PM +0200, David Hildenbrand wrote:
> On 08.05.24 21:23, Luis Chamberlain wrote:
> >  From my perspective the more shared code the better, and the more shared
> > paths the better. There is a chance to help test swap with large folios
> > instead of splitting the folios for swap, and that would could be done
> > first with tmpfs. I have not evaluated the difference in testing or how
> > we could get the most of shared code if we take a mTHP approach or the
> > iomap approach for tmpfs, that should be considered.
> 
> I don't have a clear picture yet of what might be best for ordinary shmem
> (IOW, not MAP_SHARED|MAP_PRIVATE), and I'm afraid there is no easy answer.

OK so it sounds like the different options needs to be thought out and
reviewed.

> As long as we don't end up wasting memory, it's not obviously bad.

Sure.

> But some
> things might be tricky (see my example about large folios stranding in shmem
> and never being able to be really reclaimed+reused for better purposes)

Where is that stated BTW? Could that be resolved?

> I'll note that mTHP really is just (supposed to be) a user interface to
> enable the various folio sizes (well, and to expose better per-size stats),
> not more.

Sure but given filesystems using large folios don't have silly APIs for
using which large folios to enable, it just seems odd for tmpfs to take
a different approach.

> From that point of view, it's just a filter. Enable all, and you get the
> same behavior as you likely would in the pagecache mode.

Which begs the quesiton, *why* have an API to just constrain to certain
large folios, which diverges from what filesystems are doing with large
folios?

> > Are there other things to consider? Does this require some dialog at
> > LSFMM?
> 
> As raised in my reply to Daniel, I'll be at LSF/MM and happy to discuss. I'm
> also not a SHMEM expert, so I'm hoping at some point we'd get feedback from
> Hugh.

Hugh, will you be at LSFMM?

  Luis


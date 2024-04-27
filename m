Return-Path: <linux-fsdevel+bounces-17957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4808B43FA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 05:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B54781F227FD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 03:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B753BBF8;
	Sat, 27 Apr 2024 03:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S+XZK6UA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46473BBE2
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Apr 2024 03:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714189526; cv=none; b=SofDRlDzr0ZgszZ4wYD0iiAKD3q9h+aXc+QYmOwbj7HxxVVE/x1c9yHQhLnVZqHrlq1tNEU0c8t8uucvri3FbGEYWN4OFkBe0xIxKb2NxjAqU5QBjetbP3QwNgVcPnPOiMshq5QzKR6U/RU1wYQS3BelsyIFonzGmDVmEb1+1RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714189526; c=relaxed/simple;
	bh=cN8umsG8wooMZHLaCmkWoga4TF4eBun7KgmgwcOCPWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8aoyBSex34cN3MY+6rABfubZnWPq0ZcKdfrd/O68GSqNOzZDZDUadu6JTIV/VMB5NsuDRNUmKxu6y8rAB6spb6XMTQWGoQL799PMGs3Ojc6mRKObZC9EF/ceO9aC+Ohe5k+g3PyNXnJLFJXXB1tQJlSlOQ4OeTTO3lMg9POaMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S+XZK6UA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Xytt09ehZkVciiGTF51V/MgHViGTA0VrPIBz8JEclm8=; b=S+XZK6UAd2DenRn1uXK/SBBYE+
	J9aqmLhm0sg8M1NB+httPNKe0bQCwWzRve0VvWJUq4prBMtdPZoRSuc8s8c4qpmS+RFQ4c94CFEVc
	apuZKnDExQumM0PF6XBBtVP93P3BtjPEff2AD89XlvKxboBujcgQ+TtpQKxSR8+TeKr1Aaar3JfBQ
	XfAdDaRAE5HuPj58FFnvo/CdiQLB86wov9bOUW/c/5cyyrz3/XlvOQQVutjS9dMYHTHvbsh1QFZFW
	e0GXkQVJClbUCKlMDFSXorlLPc06jpugY0MIHh8CZ55buHeRVxwrd3xcy0oljC8Jae8uNwcqaP0DJ
	lvm2Be1w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0Z02-00000006cHM-1SC7;
	Sat, 27 Apr 2024 03:45:18 +0000
Date: Sat, 27 Apr 2024 04:45:18 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, zhangyi <yi.zhang@huawei.com>
Subject: Re: [PATCH] mm: use memalloc_nofs_save() in page_cache_ra_order()
Message-ID: <Zix0zk2faI6HeG9D@casper.infradead.org>
References: <20240426112938.124740-1-wangkefeng.wang@huawei.com>
 <20240426114905.216e3d41b97f9a59be26999e@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426114905.216e3d41b97f9a59be26999e@linux-foundation.org>

On Fri, Apr 26, 2024 at 11:49:05AM -0700, Andrew Morton wrote:
> On Fri, 26 Apr 2024 19:29:38 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> >   io_schedule+0x24/0xa0
> >   __folio_lock+0x130/0x300
> >   migrate_pages_batch+0x378/0x918
> >   migrate_pages+0x350/0x700
> >   compact_zone+0x63c/0xb38
> >   compact_zone_order+0xc0/0x118
> >   try_to_compact_pages+0xb0/0x280
> >   __alloc_pages_direct_compact+0x98/0x248
> >   __alloc_pages+0x510/0x1110
> >   alloc_pages+0x9c/0x130
> >   folio_alloc+0x20/0x78
> >   filemap_alloc_folio+0x8c/0x1b0
> >   page_cache_ra_order+0x174/0x308
> >   ondemand_readahead+0x1c8/0x2b8
> 
> I'm thinking
> 
> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
> Cc: stable

I think it goes back earlier than that.
https://lore.kernel.org/linux-mm/20200128060304.GA6615@bombadil.infradead.org/
details how it can happen with the old readpages code.  It's just easier
to hit now.


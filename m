Return-Path: <linux-fsdevel+bounces-57296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF0BB204E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 12:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 747C83ADD35
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 10:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7DC21CC63;
	Mon, 11 Aug 2025 10:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="UlUAzQzL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CNCTDk+m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B8813A86C;
	Mon, 11 Aug 2025 10:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754906878; cv=none; b=IVjfcF2D45gdDkIbkPbL8n/z0tE+rC5H9y3jRvkj+EXheYlrdYvTGwgG2isakc/dio/Var01Y58HxHmuS6u6z9lQRxoQRA4XA4mb19uiWqxb3ob9VN7fgKbf2kcZNE7zuXgSs1n9IU/VkjmO9SXtYUJrq9dNIWfrSODpC64csS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754906878; c=relaxed/simple;
	bh=rd9xQztgMcfSzy1cQFOsfKJVqnKSd/C1pT4QiTbzM5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n66K8HWT+qWD1nVPHrLpumPkz5V+eKHS4Y4IX7HdpX/adgMNs7a0MwNa5zVGINc7ouyP4PrLdu0jBMy341xebnQatZqlAZjZBtj7jZXIOuWC+QAmpfujaIQ3ScDpS8FfFn6CsM23U2l5FoXEL1HjAYj9a1ED6DYPN+X5U/0q8og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=UlUAzQzL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CNCTDk+m; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.stl.internal (Postfix) with ESMTP id 4A95B1300168;
	Mon, 11 Aug 2025 06:07:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 11 Aug 2025 06:07:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1754906874; x=
	1754914074; bh=YMVHbKt84ajobxpDslMW7shZLCihMMdqMX7Bu7K6MQc=; b=U
	lUAzQzLiTBAPDTVtOK64KS4Yag1rkY3R7Ig8f8E9UtChnbtz5HASBIVq2pl9rPIN
	swtt2+1lpWIHjNFtkqlMFLD8L9YSYFzC/Wy0LR1UQeZwJX7Kkjh7ltz00WVyflKp
	IK3L8Qc2HALu/gu45rStzT2u1TnbnKBZ8SBD9j/JqHTaUS5UG5M+rhqQZfPc3DWM
	vkRh7dQGN1NQTF4klOJsYPQFoTbufs8fd194I7lGGFPHxdtCNHVaJbwuD4DPpAgm
	FsWTzXmHUXcDpP0JfenrDpDiG9Duiu2z3alsiC4DS/9RwXlQaI9ivq/vr+ha1Suo
	TS3nkp1Lh0NTjQTdedI0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754906874; x=1754914074; bh=YMVHbKt84ajobxpDslMW7shZLCihMMdqMX7
	Bu7K6MQc=; b=CNCTDk+m/R8DW2A5rWRfgIuozvJ/fJg4fquLl5cey7hAs4g/0kL
	F8QlBLVfJRYav7mTNnNf4lHYIi60o9ACQP/q64y2XHedY9VDvILXG+5NNIV3kqWp
	eRPVx/BPAHasEXVsnoFK32WoE68mnIMCTdKk7hxLVRVS7LyS3JUPQMHS3PZckhBq
	TTkROi/cC8fPiaUe4TPK8eyXWzKQ2V0bVndfYFAnd93eBvybb+1fg2YP1WVb14k2
	Liy/M8Fv2d0/rmEmXzzuhsgHaavl/7QljjBY1dZka99D0XejlMZYvgYOuZZPdsmi
	UaVW2NQ93fwai3J65RtLZCDpUENyuEnUXBw==
X-ME-Sender: <xms:98CZaG9aKnMFKfDBk16aqYN5V9ARSsbYFCtJkucvVn8zvHCPCASnBQ>
    <xme:98CZaJrDhNJ5UQOyAV5SaCp6pswEZWT2w1WUvQk-vuDLTSKRYqno6rdYQt6fE_61y
    LaEtQbIpzxMJNEKwzY>
X-ME-Received: <xmr:98CZaCzWWjtIjDEIbmyf2PmDXrzPc4yw5ycncCFoqEazPriq1FiJQypuoia->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepjeehueefuddvgfejkeeivdejvdegjefgfeeiteevfffhtddvtdel
    udfhfeefffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopeeh
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhhiugesrhgvughhrghtrd
    gtohhmpdhrtghpthhtohepkhgvrhhnvghlsehprghnkhgrjhhrrghghhgrvhdrtghomhdp
    rhgtphhtthhopehsuhhrvghnsgesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprhihrg
    hnrdhrohgsvghrthhssegrrhhmrdgtohhmpdhrtghpthhtohepsggrohhlihhnrdifrghn
    gheslhhinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopehvsggrsghkrgessh
    hushgvrdgtiidprhgtphhtthhopeiiihihsehnvhhiughirgdrtghomhdprhgtphhtthho
    pehrphhptheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvrdhhrghnshgvnh
    eslhhinhhugidrihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:98CZaIk1g2pwnQF0ZCmAGsoZLEWfhdiqeMEMRwt6usFGJ0Z10Eq_3A>
    <xmx:98CZaOnLoiGDJjCwNk9y_0rIqxSexo1YPGRQCKaef_P_Z-NeIQf8hw>
    <xmx:98CZaOwcAoRr88sQNj8EsQDLYwPiFrzeoGpcp61tm8q1HdOyhfhrgQ>
    <xmx:98CZaFZ-7tIQCWXSINvVQZEBCDXAn-WG-vqKTLT35EnFrp5WIzvP9Q>
    <xmx:-sCZaCvSYdCPW6f41s1J5E9AZKAdplnP3VG2J6p6QFiaKVLC-CLJYKox>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 06:07:51 -0400 (EDT)
Date: Mon, 11 Aug 2025 11:07:48 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: David Hildenbrand <david@redhat.com>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, 
	Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Michal Hocko <mhocko@suse.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, willy@infradead.org, Ritesh Harjani <ritesh.list@gmail.com>, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	"Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org, gost.dev@samsung.com, hch@lst.de, 
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v3 0/5] add persistent huge zero folio support
Message-ID: <rr6kkjxizlpruc46hjnx72jl5625rsw3mcpkc5h4bvtp3wbmjf@g45yhep3ogjo>
References: <20250811084113.647267-1-kernel@pankajraghav.com>
 <hzk7e52sfhfqvo5bh7btthtyyo2tf4rwe24jxtp3fqd62vxo7k@cylwrbxqj47b>
 <dfb01243-7251-444c-8ac6-d76666742aa9@redhat.com>
 <112b4bcd-230a-4482-ae2e-67fa22b3596f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <112b4bcd-230a-4482-ae2e-67fa22b3596f@redhat.com>

On Mon, Aug 11, 2025 at 11:52:11AM +0200, David Hildenbrand wrote:
> On 11.08.25 11:49, David Hildenbrand wrote:
> > On 11.08.25 11:43, Kiryl Shutsemau wrote:
> > > On Mon, Aug 11, 2025 at 10:41:08AM +0200, Pankaj Raghav (Samsung) wrote:
> > > > From: Pankaj Raghav <p.raghav@samsung.com>
> > > > 
> > > > Many places in the kernel need to zero out larger chunks, but the
> > > > maximum segment we can zero out at a time by ZERO_PAGE is limited by
> > > > PAGE_SIZE.
> > > > 
> > > > This concern was raised during the review of adding Large Block Size support
> > > > to XFS[2][3].
> > > > 
> > > > This is especially annoying in block devices and filesystems where
> > > > multiple ZERO_PAGEs are attached to the bio in different bvecs. With multipage
> > > > bvec support in block layer, it is much more efficient to send out
> > > > larger zero pages as a part of single bvec.
> > > > 
> > > > Some examples of places in the kernel where this could be useful:
> > > > - blkdev_issue_zero_pages()
> > > > - iomap_dio_zero()
> > > > - vmalloc.c:zero_iter()
> > > > - rxperf_process_call()
> > > > - fscrypt_zeroout_range_inline_crypt()
> > > > - bch2_checksum_update()
> > > > ...
> > > > 
> > > > Usually huge_zero_folio is allocated on demand, and it will be
> > > > deallocated by the shrinker if there are no users of it left. At the moment,
> > > > huge_zero_folio infrastructure refcount is tied to the process lifetime
> > > > that created it. This might not work for bio layer as the completions
> > > > can be async and the process that created the huge_zero_folio might no
> > > > longer be alive. And, one of the main point that came during discussion
> > > > is to have something bigger than zero page as a drop-in replacement.
> > > > 
> > > > Add a config option PERSISTENT_HUGE_ZERO_FOLIO that will always allocate
> > > > the huge_zero_folio, and disable the shrinker so that huge_zero_folio is
> > > > never freed.
> > > > This makes using the huge_zero_folio without having to pass any mm struct and does
> > > > not tie the lifetime of the zero folio to anything, making it a drop-in
> > > > replacement for ZERO_PAGE.
> > > > 
> > > > I have converted blkdev_issue_zero_pages() as an example as a part of
> > > > this series. I also noticed close to 4% performance improvement just by
> > > > replacing ZERO_PAGE with persistent huge_zero_folio.
> > > > 
> > > > I will send patches to individual subsystems using the huge_zero_folio
> > > > once this gets upstreamed.
> > > > 
> > > > Looking forward to some feedback.
> > > 
> > > Why does it need to be compile-time? Maybe whoever needs huge zero page
> > > would just call get_huge_zero_page()/folio() on initialization to get it
> > > pinned?
> > 
> > That's what v2 did, and this way here is cleaner.
> 
> Sorry, RFC v2 I think. It got a bit confusing with series names/versions.

Well, my worry is that 2M can be a high tax for smaller machines.
Compile-time might be cleaner, but it has downsides.

It is also not clear if these users actually need physical HZP or virtual
is enough. Virtual is cheap.

-- 
Kiryl Shutsemau / Kirill A. Shutemov


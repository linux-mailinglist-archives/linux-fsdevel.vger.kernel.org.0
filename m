Return-Path: <linux-fsdevel+bounces-57287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD28B20403
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 11:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85F4917200E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 09:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066C629B239;
	Mon, 11 Aug 2025 09:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="G/WZXrUq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BQK+ypFX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E9A223DE1;
	Mon, 11 Aug 2025 09:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754905399; cv=none; b=uXDrYBpfvfaZS+Lm69HxTWp+X8gl+iVR6IffmQOyFCk/8LBfSUj67sE46u/U9v93l7TUUj2fCDWa5vn4Wl7mA9iBpoWXV87zFNobU9AB0uPx5JcnGvY4js+OOmBeRogYh13uGPXkS5/9yGzjex6/rT11V+SQIG7+cEgQCe2qVwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754905399; c=relaxed/simple;
	bh=TpwcyvJqFuTKzpCMzpKrBzm/g5kLEs2GB++CU4VVlHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPNzeYnYDh9HwP2en7wl5JNj2HGtQyhJdQRT7HqeEB1IS79qT6NBsIdvm7iS052fnHKnK6IXwddRMLcL5qOby7naCdAZHDVkrHgEDRamyCGvK7gjtGL7IkWCAe5UhziPVpQtKbvWyBJabvpQyhalqQ1s1sZWL19oNyqr0SqCbuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=G/WZXrUq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BQK+ypFX; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 7566D1300129;
	Mon, 11 Aug 2025 05:43:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 11 Aug 2025 05:43:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1754905392; x=
	1754912592; bh=VdjvmWy6iQXvtQ1GiKbzqztULu85VbiyFIL8fPU8btU=; b=G
	/WZXrUqh9nsKBdFTWEfHdbeqxbH3ManDGS0mzft3EVCv+32+GusH8VCChlayvYlu
	i8XqMjj5F3ltL81Qex9gLEOj3d56rW8y++gOjxE0unJgEeAmhkYeDELDDnBcwWBm
	5CxsLfUbCxivxpD3zFKKoCHK9Ln7uwFCMsJ2Lz/h8Be3voXaKW9TcBFm93pQKbI1
	+kg1aIJ0Sq2hdLswGuyNDbx0RLIIP0CMVUHdTjrVAa+7++QwgseI7tO30h6hS4DY
	1OWQQWVR5l77vkIvCEu+JKx2Uv+03PngMi69tFvI7iradTMGXcwO5qYKKAmm0ipc
	l014vUhZ64Ll/lRUqGmqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754905392; x=1754912592; bh=VdjvmWy6iQXvtQ1GiKbzqztULu85VbiyFIL
	8fPU8btU=; b=BQK+ypFXPOrbDUTH5B4wnAvNnNtfw78A8OtplJWKdEDwTYtfcm1
	mdZa/C4afcYNT5RKDSblmk6uwk5WGjqDsNYwMHcnPbVLMHJX+o/wtl39U29RyvcM
	XdRE08fuGYdiBTlJuN3Zt7M7eYwLn00p8CzsN9ib6pJrehO4FWB9+DulPEz+a3ls
	1yo8IweN6EgazJraQu10YCBpHHjnBDKk7SZd7XaqHG+w+Iu16/2PwVc5DdmW9876
	LdAOEr6htEk9SKaRSQ43vGuE2pCcYxpO+n6uJJL39AFuR2Na6lk2j0vydv4uMMae
	AOn5qR0/fc6UoTExIk4A4unytXMogWFx7sQ==
X-ME-Sender: <xms:LbuZaBRkxOnx6SpBT0QfT3s9t5SzxR-oPLhvu0ZHJpau-aa066FUUg>
    <xme:LbuZaNsc4bC5lAEpmlPiVx4gnva2b44-Zmx2uMqNgiSWDLJfMT05Rb_TAOllkLlHU
    U6y2o3l9yA1bPBTij8>
X-ME-Received: <xmr:LbuZaNk8yYai-XvLMSRc4gREbiO_Tpta32YgUk1-0sO9HaPDmGS8njyXHK2q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepjeehueefuddvgfejkeeivdejvdegjefgfeeiteevfffhtddvtdel
    udfhfeefffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopeeh
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgvrhhnvghlsehprghnkhgrjh
    hrrghghhgrvhdrtghomhdprhgtphhtthhopehsuhhrvghnsgesghhoohhglhgvrdgtohhm
    pdhrtghpthhtoheprhihrghnrdhrohgsvghrthhssegrrhhmrdgtohhmpdhrtghpthhtoh
    epsggrohhlihhnrdifrghngheslhhinhhugidrrghlihgsrggsrgdrtghomhdprhgtphht
    thhopehvsggrsghkrgesshhushgvrdgtiidprhgtphhtthhopeiiihihsehnvhhiughirg
    drtghomhdprhgtphhtthhopehrphhptheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    uggrvhgvrdhhrghnshgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhope
    hmhhhotghkohesshhushgvrdgtohhm
X-ME-Proxy: <xmx:LbuZaDJbQGaLdnwev2IPfL5uOUvnRSEIFmb59B-gJ2praKYD8hqgPQ>
    <xmx:LbuZaN6qzYaDRnyyLkHcnk-r5M3-cwVYLwQvcCCprm4d1frtQsIDug>
    <xmx:LbuZaD0pbxsjkR-8UrFYtK7ZlsBdpuvJg109DZN61JSFJ6-38xspxg>
    <xmx:LbuZaNOCGd4ZT8bdu-31kNEme9g00sMKqrISutGRJrxZSGYnZiGMkA>
    <xmx:MLuZaKRuqoK3mFiJGexCZYWZqsudz8TcN55vbnt4rHxNO9kAFX3Y9LoR>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 05:43:08 -0400 (EDT)
Date: Mon, 11 Aug 2025 10:43:06 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, Mike Rapoport <rppt@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@suse.com>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, willy@infradead.org, Ritesh Harjani <ritesh.list@gmail.com>, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	"Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org, gost.dev@samsung.com, hch@lst.de, 
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v3 0/5] add persistent huge zero folio support
Message-ID: <hzk7e52sfhfqvo5bh7btthtyyo2tf4rwe24jxtp3fqd62vxo7k@cylwrbxqj47b>
References: <20250811084113.647267-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811084113.647267-1-kernel@pankajraghav.com>

On Mon, Aug 11, 2025 at 10:41:08AM +0200, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> Many places in the kernel need to zero out larger chunks, but the
> maximum segment we can zero out at a time by ZERO_PAGE is limited by
> PAGE_SIZE.
> 
> This concern was raised during the review of adding Large Block Size support
> to XFS[2][3].
> 
> This is especially annoying in block devices and filesystems where
> multiple ZERO_PAGEs are attached to the bio in different bvecs. With multipage
> bvec support in block layer, it is much more efficient to send out
> larger zero pages as a part of single bvec.
> 
> Some examples of places in the kernel where this could be useful:
> - blkdev_issue_zero_pages()
> - iomap_dio_zero()
> - vmalloc.c:zero_iter()
> - rxperf_process_call()
> - fscrypt_zeroout_range_inline_crypt()
> - bch2_checksum_update()
> ...
> 
> Usually huge_zero_folio is allocated on demand, and it will be
> deallocated by the shrinker if there are no users of it left. At the moment,
> huge_zero_folio infrastructure refcount is tied to the process lifetime
> that created it. This might not work for bio layer as the completions
> can be async and the process that created the huge_zero_folio might no
> longer be alive. And, one of the main point that came during discussion
> is to have something bigger than zero page as a drop-in replacement.
> 
> Add a config option PERSISTENT_HUGE_ZERO_FOLIO that will always allocate
> the huge_zero_folio, and disable the shrinker so that huge_zero_folio is
> never freed.
> This makes using the huge_zero_folio without having to pass any mm struct and does
> not tie the lifetime of the zero folio to anything, making it a drop-in
> replacement for ZERO_PAGE.
> 
> I have converted blkdev_issue_zero_pages() as an example as a part of
> this series. I also noticed close to 4% performance improvement just by
> replacing ZERO_PAGE with persistent huge_zero_folio.
> 
> I will send patches to individual subsystems using the huge_zero_folio
> once this gets upstreamed.
> 
> Looking forward to some feedback.

Why does it need to be compile-time? Maybe whoever needs huge zero page
would just call get_huge_zero_page()/folio() on initialization to get it
pinned?

-- 
Kiryl Shutsemau / Kirill A. Shutemov


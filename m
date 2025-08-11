Return-Path: <linux-fsdevel+bounces-57299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0AEB2051C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 12:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0EE417AD30
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 10:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E276623C509;
	Mon, 11 Aug 2025 10:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="Hi0dhC98";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OXzzw00G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827DF225760;
	Mon, 11 Aug 2025 10:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754907467; cv=none; b=G40F53e6pnrNxzlCYbW1Si+2p0KZ8fncyIxmFFF+zEtG2s7Wxyd9uAyj6XYP+vrmLTpsWRWUG7uSizI9YXybElIB44cAuoxrpzr7LflxGZY2qZVfJhhJulVXhE5tOSNf5SXXHNaN1AWfssvnncMatfO134rpVtzLxiwS0bqvCIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754907467; c=relaxed/simple;
	bh=FeVSjMu7K6/6+Y2nlBvt72rWSYxyBFytB+EvWxSZnGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDGxzzJS9f1cHbkoMLSaSlZXVX+jfyKBzpjm/Uivtml6QH7G3zh1dmiHiHqdlrGmoeagD7GWP+NglH0QudGvO3oow6FaX1AL38/pn8iGkA9B4Ft5E/h2e1SMa4hTzeieL403+5iGZXUqhThE8mAyUViNv7U07Otwp0QX/l0625Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=Hi0dhC98; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OXzzw00G; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.stl.internal (Postfix) with ESMTP id 2E87F1300128;
	Mon, 11 Aug 2025 06:17:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 11 Aug 2025 06:17:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1754907463; x=
	1754914663; bh=JTDYGtuk5YhoXR2bU1gah20zKNI0h74bgwzfLz1JAoU=; b=H
	i0dhC98oVO0d3EOdB73fn7pi5zw4cHaGLng+8mGA0Xv7Ol5Sdz/cMUSe5T2puuMf
	57A86juVENc0pa0oKV0GW4WqYsS6nzv+uEChsL4plFBDHEHmDUvC2JRrPblg042o
	QJJplHpns5klrYhN5IjTfcgxbKQMlAN0qLCLtMQOkzWgFWPqfoAAa5PwIYyKZDrM
	KpPnO3Tm3rHvlhUScb5NHaR7MNXzKMMTPeXEFnUjb5CbkjWtejdtuBcDxcZkUfmM
	djlg5kt0DZl4cTkRTBvr1LpJi7yJrCMIlTWpEBFqmoiQvRb4/C7OEqFGjjejEQH7
	lzyKEqRZ/PADc2jApbDLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754907463; x=1754914663; bh=JTDYGtuk5YhoXR2bU1gah20zKNI0h74bgwz
	fLz1JAoU=; b=OXzzw00Gr8lmjyrxVoY0HgZkXBfQM85Or0u7ENfE4as58NkfOM8
	YO1p/zVogusB5UGiVZgQBKd4Xptv/k3OoCKP2yBwAtLSfWser9eoJIUR2H8QhZl2
	Jqo9k6TST/it+6/IiampbP7ZJN3OzhtL2cyccFQsP7R9VQyBldQ6vSxJUuO57GTI
	Sxgu7U4bq77ZfH8GDJ2lCpN+6fJ/RiKbJVRZof0LTgz27DF++XA7nY4Yd4VE608O
	S1Nrr2crc1gyC3wRbvy4M2Hp2JunTlSV2Tlf4PaUSzUQUUcJgVTClP98WYYQ3BUv
	4rZE79TUtIntEGx9SqD5DGo3HVYUm2YLUjA==
X-ME-Sender: <xms:RMOZaGDdbN1XIsEO-hfXw7mPnmjrbF4AYMeno8GnJTFN9r7YQpt9tA>
    <xme:RMOZaHqz3d0sryzqz3lMU3Cjxa90UWmMCMbKUqJbdAS2vciC2GXW93IIgfyHGR0YO
    pkmd-RYYrPV8kGLIoA>
X-ME-Received: <xmr:RMOZaL-D99bzftr3PLC3Xd_-wmfvtn68ioY8u7n7pFQVRGUB1jHEHKQuvZC8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepjeehueefuddvgfejkeeivdejvdegjefgfeeiteevfffhtddvtdel
    udfhfeefffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopeeh
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhorhgvnhiiohdrshhtohgrkh
    gvshesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepuggrvhhiugesrhgvughhrghtrdgt
    ohhmpdhrtghpthhtohepkhgvrhhnvghlsehprghnkhgrjhhrrghghhgrvhdrtghomhdprh
    gtphhtthhopehsuhhrvghnsgesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprhihrghn
    rdhrohgsvghrthhssegrrhhmrdgtohhmpdhrtghpthhtohepsggrohhlihhnrdifrghngh
    eslhhinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopehvsggrsghkrgesshhu
    shgvrdgtiidprhgtphhtthhopeiiihihsehnvhhiughirgdrtghomhdprhgtphhtthhope
    hrphhptheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:RMOZaOecNLsDQtmaDXNSQxx-pimxoWG2KoZEzFKOtXWin__9MJjLJA>
    <xmx:RMOZaBJNBNdaTBfsrZWxYUEiprG5FDP2xTOMf7u5W6mimzFP-m9Gbg>
    <xmx:RMOZaIQiJ3nY49TvMbfZglXCsbjjJyupmLC-_rUOG5Enp62Tz5llXg>
    <xmx:RMOZaPFk5jIuXuPrkSxQB_qDoTSDqS6yHBRPf0IJ0tusr6p0_JbcMA>
    <xmx:R8OZaHnqV6gmf46bwm9FyYh4KV8d9jYAZOmDJsCZGVU5yhXf5V5Rnh2d>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 06:17:40 -0400 (EDT)
Date: Mon, 11 Aug 2025 11:17:37 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, 
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, Suren Baghdasaryan <surenb@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, Mike Rapoport <rppt@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, willy@infradead.org, Ritesh Harjani <ritesh.list@gmail.com>, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	"Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org, gost.dev@samsung.com, hch@lst.de, 
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v3 0/5] add persistent huge zero folio support
Message-ID: <lkwidnuk5qtb65qz5mjkjln7k3hhc6eiixpjmh3a522drfsquu@tizjis7y467s>
References: <20250811084113.647267-1-kernel@pankajraghav.com>
 <hzk7e52sfhfqvo5bh7btthtyyo2tf4rwe24jxtp3fqd62vxo7k@cylwrbxqj47b>
 <dfb01243-7251-444c-8ac6-d76666742aa9@redhat.com>
 <112b4bcd-230a-4482-ae2e-67fa22b3596f@redhat.com>
 <rr6kkjxizlpruc46hjnx72jl5625rsw3mcpkc5h4bvtp3wbmjf@g45yhep3ogjo>
 <b087814e-8bdf-4503-a6ba-213db4263083@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b087814e-8bdf-4503-a6ba-213db4263083@lucifer.local>

On Mon, Aug 11, 2025 at 11:09:24AM +0100, Lorenzo Stoakes wrote:
> On Mon, Aug 11, 2025 at 11:07:48AM +0100, Kiryl Shutsemau wrote:
> >
> > Well, my worry is that 2M can be a high tax for smaller machines.
> > Compile-time might be cleaner, but it has downsides.
> >
> > It is also not clear if these users actually need physical HZP or virtual
> > is enough. Virtual is cheap.
> 
> The kernel config flag (default =N) literally says don't use unless you
> have plenty of memory :)
> 
> So this isn't an issue.

Distros use one-config-fits-all approach. Default N doesn't help
anything.

-- 
Kiryl Shutsemau / Kirill A. Shutemov


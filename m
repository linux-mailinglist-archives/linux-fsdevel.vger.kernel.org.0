Return-Path: <linux-fsdevel+bounces-32654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7519AC92B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 13:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A0C3281286
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 11:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434E61AB507;
	Wed, 23 Oct 2024 11:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="bMYaD7nE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F1zrF0cW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FC4134BD;
	Wed, 23 Oct 2024 11:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729683517; cv=none; b=ep4YV/qE92VCqoBvIU66VJ4VNxtE/eMCQPnlh9eAGYnhNSB/M0EPVO2NVmTLeWYwBhXAgl1Lj00QDqHSte6nxPwHnislYfwAstvQcH23bH3rMyKrbd9xhbve3KLHtQmnvXHgJuqDRzrpAxfZLOrH+FJ02kIgCcIvgkg+Ky8eW2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729683517; c=relaxed/simple;
	bh=UzYtrYpwqw1jaVXUafPAJfobNqaDaomuqS1vRObPCqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LB0CthbXaFCTjY+p0VA3s/N4hYWLpm70v+HJf5CkHZq3WzKdU/T7ftO44AVnZDDyP//39Rl9H3m5k1vuvqd2dzTQLJ4j0cNOHrET57Hl5PpcLUfu8sZjE5czn+WuwbNeFXVww1zJLcewT3K44WKrj7h/4/UnDHoe1INvz4nNiko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=bMYaD7nE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F1zrF0cW; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id E30CD13807A3;
	Wed, 23 Oct 2024 07:38:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 23 Oct 2024 07:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1729683513; x=
	1729769913; bh=G6CUi21sJIgULg4YyxpP72kDdA8AWcHDBrNG6d45KA8=; b=b
	MYaD7nEySPXh7O4/RcFrX+MizsCOUtTadpngQe0QdRJjqVSqF/jI+5/2HmBheKkt
	c5mCxMz8LDC+bttnTWAI600BShR5Gdx6d6lvhrw9f/0dVA7Y5K3hkGPD4KCXCyWf
	LhUUy6ygcjx6CqdoeexPsNUMk4VnyE+n1AQgXwGJ20bwMs/1JWxsCOlWX6l8O+pw
	Sxx4QQ4FV+zvVldo0zD62+/Wy+6XvLZ+kw1gVtaiUiWjYYkQW/4sY0lpfO2Jom2/
	vsx53REiG/RgCrw6mRcT08/PyAqZVit3zrWbEPFiVmjIKkrtVl00Azvl7i59O/lW
	7Mf0GGDFEvE862hbU4oDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729683513; x=1729769913; bh=G6CUi21sJIgULg4YyxpP72kDdA8A
	WcHDBrNG6d45KA8=; b=F1zrF0cW0VSFjM0x4dQO0iEG41G/dAsSFFHilHRv7sfu
	AIu+9rdB0V2od+a7vBO2r6ECptu354ukTLB5rQATGOKWCJ6lnqwcxqYHfqQVD2B3
	q5KC+zGIaENAffEhKt7SjDFK2QCAenIO8+MMoHxlIyXc5/2+QekVZpD9KQ3lBAAI
	DZ51zkCSz9RSC33JW+RDSFouh4g/UzMV/UKQIwxMLjGduIlqbaJqSQIP7OFM8MxW
	+tXsB4Ific2k2oNbtWTN0b38GcTcfR0u5k0qMd/9nddciUeGFEMTkLI/yDphUt4X
	whWok8f/eeC/NW81aHwQMzeVsBR2DT/vxRzVfztvvw==
X-ME-Sender: <xms:OOAYZ3NRYIeL5zW1s5qndddFNCLfYN_BMBAnzQeiW5VFnnDmdIrBog>
    <xme:OOAYZx8cKkX8nja5zUKMGGk0IcuqpAosGWiac0by3KVYDTAHnhlBp0sllrepnPWti
    UXJDKDwuk4uw4OWi1w>
X-ME-Received: <xmr:OOAYZ2QrJg5n52W9QAQbKGYvBjGJ7Zr9drRNF_THYv9bocosDxs5shR3U3yATtZUwcaiTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeijedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvden
    ucfhrhhomhepfdfmihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlse
    hshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeffvdevueetudfhhfff
    veelhfetfeevveekleevjeduudevvdduvdelteduvefhkeenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhv
    rdhnrghmvgdpnhgspghrtghpthhtohepudekpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopegurghvihgusehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdhk
    vghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    hmmheskhhvrggtkhdrohhrghdprhgtphhtthhopegtghhrohhuphhssehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepgiekieeskhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpth
    htohepfihilhhlhiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehtjheskhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:OOAYZ7u9T06DBMvGNREnx8516Mxu-KVPbQNSUO69cEHTnvymJgftEg>
    <xmx:OOAYZ_eOEUtSC-mwcGe2Co5_zRTAjtfsCU6bxzghKzFfeKaHMAawtg>
    <xmx:OOAYZ31lhju9dZbobTbDYoYBZ6i2dk90w-WlcUojz764r94TgPNgHA>
    <xmx:OOAYZ78VQX-CkXJix2eIRcGZnx1rcLekQibFSi7eobssgISEIgl7zA>
    <xmx:OeAYZyV6c18kuhT7qTXfPQ93NA49QhVjYEMB9giM0eEGtNAoul0gK3p8>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Oct 2024 07:38:27 -0400 (EDT)
Date: Wed, 23 Oct 2024 14:38:22 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, x86@kernel.org, linux-fsdevel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v1 04/17] mm: let _folio_nr_pages overlay memcg_data in
 first tail page
Message-ID: <wi53ecg3o5eemp2hwy5sjbgoroulbmnbbbz6pub2ratbwrdhg3@pnhiy45qirr3>
References: <20240829165627.2256514-1-david@redhat.com>
 <20240829165627.2256514-5-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829165627.2256514-5-david@redhat.com>

On Thu, Aug 29, 2024 at 06:56:07PM +0200, David Hildenbrand wrote:
> Let's free up some more of the "unconditionally available on 64BIT"
> space in order-1 folios by letting _folio_nr_pages overlay memcg_data in
> the first tail page (second folio page). Consequently, we have the
> optimization now whenever we have CONFIG_MEMCG, independent of 64BIT.
> 
> We have to make sure that page->memcg on tail pages does not return
> "surprises". page_memcg_check() already properly refuses PageTail().
> Let's do that earlier in print_page_owner_memcg() to avoid printing
> wrong "Slab cache page" information. No other code should touch that
> field on tail pages of compound pages.
> 
> Reset the "_nr_pages" to 0 when splitting folios, or when freeing them
> back to the buddy (to avoid false page->memcg_data "bad page" reports).
> 
> Note that in __split_huge_page(), folio_nr_pages() would stop working
> already as soon as we start messing with the subpages.
> 
> Most kernel configs should have at least CONFIG_MEMCG enabled, even if
> disabled at runtime. 64byte "struct memmap" is what we usually have
> on 64BIT.
> 
> While at it, rename "_folio_nr_pages" to "_nr_pages".
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

BTW, have anybody evaluated how much (if anything) do we gain we a
separate _nr_pages field in struct folio comparing to calculating it
based on the order in _flags_1? Mask+shift should be pretty cheap.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


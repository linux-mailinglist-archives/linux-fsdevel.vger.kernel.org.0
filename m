Return-Path: <linux-fsdevel+bounces-32652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D3A9AC8B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 13:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E531284267
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 11:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7F01A7AC7;
	Wed, 23 Oct 2024 11:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="hu/5rsxS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kkc7iPgu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093A01531F9;
	Wed, 23 Oct 2024 11:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729682310; cv=none; b=enhou2ksyFtFsdTi5t42pwRGbZi28dHWJulvbKDLw4z/jf5f65X3ChhQ3YS7S9e1BXSWtGbGbL3YMdr0bebxqVPLWwUiox1t5/uBX/VtbyABrVWYUAct0oVLa8mIrYOLN+7suVxK+7vDmABMs4pO2oXu9p90t5mYkhh0CZFHOPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729682310; c=relaxed/simple;
	bh=41+fFeT54h5/9Kenpc3V+K39uwVReLrfxuQk/RMdOYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdI0oyWXrJJfrT73EwKZFuzEYhWfM6DNo0kPXaPHrVGS7d0UIWm1G8DGLtCRmNv5IxY3YDFLF08Gho0aB7wMFFwAdzvOKl7yPjPK4Jfu7gTEdjhdxWrZa/I6tJWbzFzGPEcuGFzxO8bSxy+aI9Bn6ViVZ7tvj5U3s8M1dMzq1Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=hu/5rsxS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kkc7iPgu; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C3F691140142;
	Wed, 23 Oct 2024 07:18:26 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 23 Oct 2024 07:18:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1729682306; x=
	1729768706; bh=Vwy58cHeT5EOxz8ukcp8DVriSblRUlkuqAv1BT3YlWE=; b=h
	u/5rsxSJv7FTA9zcz3QUwAFJjxbDSMi8rGfrn2tUNqMWtHHX7TTxQgIZGAQdG4+s
	PW3i+W8mRPaSvLRr6D8YUsXMwLqKoQbr2sK/mAtYWKogGo4CRQIizk8nspSqCy15
	B4DMVVrU7e05fxRxh0sVssLSx9Z1LH7x9bG16r037iEpcLvNdQ/pfsJH6mswiOSx
	Ft8e1kOFpL2x1pQfTt3zTPwOUSdOwCSp1CNO/uiTId22KXqLNDty65QwQ1bXECeE
	TvbYf3io+Tj1dJDmtz0Rxo65GyiOs5fxD0gmq5qFp7qo5O5h3SSdgOA3HtUv/Gjf
	PVVb/t46pIXLXW42k5RVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729682306; x=1729768706; bh=Vwy58cHeT5EOxz8ukcp8DVriSblR
	UlkuqAv1BT3YlWE=; b=Kkc7iPguREoRZ0Iz3dWyjEGxJI3gNVjgQSqWcpb1/jcV
	RVnUOhL6cZ27YyYYGlTnkRkZDB1v6WwD4mzOCrP5nD4Ui2JfAFti6cSDVAEh6dki
	VFhCFHkGBFaINL7H07ra1gZVQBctesg+8Ohxl0nkDjhBrRDO7CpPDyoOJb1wV1ph
	VEVQpnY4DShezWM3qh0z4O6PcRxvxEojZBH+0Q39Al6SUxO87IDrEIXCo9f+CBdg
	r3L4tRpHfMQ2pa172M09ZEMWLceF12QW27jY4li9qx8wZjRydAawM2GyMWcKFe00
	fK1z2uY1XnY/Nd035vn6WQAeTfvtsCwa/+EogQvICw==
X-ME-Sender: <xms:gdsYZ5L6V6011EDYPzP1hTa2TH8ouvEzg_VFxmwiArTu3JOc572JhA>
    <xme:gdsYZ1L4IrxN2_ym7ZEwYTMxiY7fVBTHZ7eSFab_jZ_VndVElDcIKSrYK1BDqNdy7
    Onsz53KRIFsFZ_DV4o>
X-ME-Received: <xmr:gdsYZxu_9YTCCI6dJ0C9LRSIHB-ZB1942NvizVTULDu3yF7KfLzWvnfSASTliq4B_GtnwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeijedgfeejucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:gdsYZ6YMHEJDkejBvRYcwnlzh8ykbzD6mXigksroAnYXPg57M2YdVw>
    <xmx:gdsYZwZLmjJ9pLEQCHdZMwoWavHL8T7Ln1e_G59BNwObZxmGSdHkLA>
    <xmx:gdsYZ-DxhwnV_gpHO2U2s0PqwBoCSzt9UuYukbr7WOIKNFxgvFsWvw>
    <xmx:gdsYZ-bNTt9cnfTwvDisjzqJwayBvoG0tHkEc_eNdUdQ7F43PTPUYQ>
    <xmx:gtsYZ9SimV8y7du4jINOMoVIJGbFoCeR2ZSPdkLdr8SHZexXNUU19bar>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Oct 2024 07:18:20 -0400 (EDT)
Date: Wed, 23 Oct 2024 14:18:16 +0300
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
Subject: Re: [PATCH v1 02/17] mm: factor out large folio handling from
 folio_nr_pages() into folio_large_nr_pages()
Message-ID: <u3mwngmik3i2qgj3ymjx26chbabsjzrtf42dtvh3ejara2opa7@osasxccmufb7>
References: <20240829165627.2256514-1-david@redhat.com>
 <20240829165627.2256514-3-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829165627.2256514-3-david@redhat.com>

On Thu, Aug 29, 2024 at 06:56:05PM +0200, David Hildenbrand wrote:
> Let's factor it out into a simple helper function. This helper will
> also come in handy when working with code where we know that our
> folio is large.
> 
> Make use of it in internal.h and mm.h, where applicable.
> 
> While at it, let's consistently return a "long" value from all these
> similar functions. Note that we cannot use "unsigned int" (even though
> _folio_nr_pages is of that type), because it would break some callers
> that do stuff like "-folio_nr_pages()". Both "int" or "unsigned long"
> would work as well.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/mm.h | 27 ++++++++++++++-------------
>  mm/internal.h      |  2 +-
>  2 files changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 3c6270f87bdc3..fa8b6ce54235c 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1076,6 +1076,15 @@ static inline unsigned int folio_large_order(const struct folio *folio)
>  	return folio->_flags_1 & 0xff;
>  }
>  
> +static inline long folio_large_nr_pages(const struct folio *folio)
> +{
> +#ifdef CONFIG_64BIT
> +	return folio->_folio_nr_pages;
> +#else
> +	return 1L << folio_large_order(folio);
> +#endif
> +}
> +

Maybe it would be cleaner to move #ifdef outside of the function?

Otherwise:

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


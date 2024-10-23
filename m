Return-Path: <linux-fsdevel+bounces-32663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F8B9ACABF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 15:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 494CE1C20E57
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 13:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8931ADFF2;
	Wed, 23 Oct 2024 13:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="O2j3YHFB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JAAX0Qiz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC3C156C72;
	Wed, 23 Oct 2024 13:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729688943; cv=none; b=ZyjDzREcEvNgKK9dBR7LXH+kI13gSIQZq6yK4HpdYqADF+4l2iv4+85BreFvEX5rBjnmv4awNM959xrIY2OgfKqBQjqYYSx1bxXLf+fI6XaTBktewqF7+rVZvLtYmWzuD9cWmNEP5V0GGdSffkNp0migQAj2PAmL38M90hB7Msc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729688943; c=relaxed/simple;
	bh=tENVuhaiMyWWo1bW6uxzA9DO/LirYJrx5ICvbc2P/dU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKCdyopmv9fYvQ8/IOiUmP/B9hRst0wXdtxPDxWzL5hwB4uLF907kuAG4VVEtZhFbMMiKtiEApG+pTFI2reIdZF5AeoYbJzwrdJXqFCvRY5auxQCQjiXKT2Ake2DwLjdYaQCpMTJfJngF6SusmDsZB9fYGin+kpU7AUuEBIoEi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=O2j3YHFB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JAAX0Qiz; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id A060F1380776;
	Wed, 23 Oct 2024 09:09:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 23 Oct 2024 09:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1729688940; x=
	1729775340; bh=I3dav51KrIVO/7ueeUGHNs6IvTQpAiHG0z7kAUnAVgc=; b=O
	2j3YHFB1BAAXQgHxjDW9KPw5vrPUgbxUH7vT2rDFNCpfAuTd48A2u4wSUjsrA4gL
	Cj7nDe1HtgKpOoycYe7BZsUiyjnm4g4gCNffR8kGD1x+moqdKLvT+HDy3wjRKTu7
	lw4fKYYvB0R0WVl1hlV2Aqwx8Ea93QDqOpmhZOVXkjwfJApZSSvjwHwFzK4iV9fF
	1Q1MB0UNDH3Z5HH/VHWtWV55vcSJNV3jqbtesNlC+NGTPeY6hORUrloUN/2ScXGl
	rdMYxt4CZnbIijO7cvmdJCiZCKkJMe9A5T4VUsB5oVmcoNKFhY1o/ZOuHt4QbOtj
	oFhaqqNDZzIzfvOSxJJbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729688940; x=1729775340; bh=I3dav51KrIVO/7ueeUGHNs6IvTQp
	AiHG0z7kAUnAVgc=; b=JAAX0Qiz5T1hQD3oFlmv8IgnrOQWPDrcM6wt/fmjjpf8
	j3DZ9Q6v3Exam5qg7CG5hLlb3yr6NsBUebDmfVdVBv5Y1VRCJV9cfXYJHl/+/ZM0
	sy9L7xptV9N3ra3im8APonIdPxf76wJsgNVRTCjgqNGv9xGrbnxoCAdB+URi1jDh
	C9MhbFTaZzM3G3hESH9Se/y8Etve5pjbFk+5+ywKR8Wo6udQJfxcRay85VmGn6e0
	cTnfBb7xku7iNqYCCeQ+RkgTeUa13/w6EJuY4iIF0cZ7JbBEDiDlskmKxCvbPZf+
	dA8HFAoKUpHRxrXE2lQsFjVbEVRFcGgwd8PJtEhF8g==
X-ME-Sender: <xms:a_UYZ2kfUKz5DNTjeWswPhkePTgZ3ggYMLjpVO1G9IX1-uyjiiP4aA>
    <xme:a_UYZ93RF6W9bLdb4g5BpWKoloTdiNbrSjpvkWQTsrravoRgUxCVPPryvZKtZHfQq
    AIBCnfERKx8uhFEuuA>
X-ME-Received: <xmr:a_UYZ0pBzcYz28tyOJ2XnhgLSRBSkbdyh0BULFM22KoMNTKVBGjQhmZ5ALCr0VYypdgxiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeijedgheelucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:a_UYZ6m0KK9HymSlJf0hp6Kp-duQ25K91PjWpGiAokNwM2DZs8yr6A>
    <xmx:a_UYZ02GtHxO7rGuZT0_d0vFxl5AVCE48avVCnmdrC2w8xdw4t_VLg>
    <xmx:a_UYZxv5aF9HHvmvcQcb24ecZ6xrWGa-wkEpPVA-O8Ltcxc6Sqz7XQ>
    <xmx:a_UYZwXkAXGqLTpSbDOXIhRooUbtPSMK1N2Ji53GwtnVMj-BVrDgbA>
    <xmx:bPUYZ7v3pMAXEHKN7HL-3Rg6P-sA4F0W1tI6b8petgWf4PTtAHp7oAnQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Oct 2024 09:08:53 -0400 (EDT)
Date: Wed, 23 Oct 2024 16:08:48 +0300
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
Subject: Re: [PATCH v1 08/17] mm/rmap: initial MM owner tracking for large
 folios (!hugetlb)
Message-ID: <v2lzmdkpdzuwwdnpgncitxenx7aalcjm5zokjgcienshdjfbrr@alnz7zseqxp3>
References: <20240829165627.2256514-1-david@redhat.com>
 <20240829165627.2256514-9-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829165627.2256514-9-david@redhat.com>

On Thu, Aug 29, 2024 at 06:56:11PM +0200, David Hildenbrand wrote:
> +#ifdef CONFIG_MM_ID
> +/*
> + * For init_mm and friends, we don't allocate an ID and use the dummy value
> + * instead. Limit ourselves to 1M MMs for now: even though we might support
> + * up to 4M PIDs, having more than 1M MM instances is highly unlikely.
> + */

Hm. Should we lower PID_MAX_LIMIT limit then?

Also, do we really need IDA? Can't we derive the ID from mm_struct
address?

> +#define MM_ID_DUMMY		0
> +#define MM_ID_NR_BITS		20
> +#define MM_ID_MIN		(MM_ID_DUMMY + 1)
> +#define MM_ID_MAX		((1U << MM_ID_NR_BITS) - 1)
> +#endif /* CONFIG_MM_ID */
> +
>  #define MM_MT_FLAGS	(MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN | \
>  			 MT_FLAGS_USE_RCU)
>  extern struct mm_struct init_mm;

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


Return-Path: <linux-fsdevel+bounces-32653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A539AC8D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 13:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A5FC1F22708
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 11:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCB41AAE08;
	Wed, 23 Oct 2024 11:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="QjOAujDH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NzPlBx9Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA461A7AC7;
	Wed, 23 Oct 2024 11:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729682553; cv=none; b=Z2yedpLeUpgZHnhl+UhmStLh2L/p4rREL+S61On9yVXiX06h0aay/ZejidW2pLt6X8Th1nXvzKH5xRfNE7dtfzFqxTYZ+TArkbY3beu3Vb/vsyjjdwnj4pLhNFDwBtBGc500Lt79ycNW9h0d4zxV6YpUHJYIRZ2HMbqp4Qzy1a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729682553; c=relaxed/simple;
	bh=L/qBzKuJnIbf9IDQ+F05jGjNtmHldcEW8lewmbg+HEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqFLnNz+SOrDUkjckvgbXuelM9bextw2MKjMk1byy+CA5eC8iMvvM8abL0paarVjzBBE7mKWicEcR89DyWm4YfWCFsM8T4gBryGjP1DLedcIBEeZSKKnvAAoMr4jpH1ZF0B0SrKWj/4eq4HIdwgsWweYkpM6ii2C0Kew8MCi3nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=QjOAujDH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NzPlBx9Q; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 5C5FD1380796;
	Wed, 23 Oct 2024 07:22:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 23 Oct 2024 07:22:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1729682551; x=
	1729768951; bh=DyXy1uENe8BhOOL8uZDqsDDMDgXhYxR835mX6crlWnk=; b=Q
	jOAujDHOrZyThdD8qapTLfnoT46h9P5A9bvEdGTqPv32KYANtGHAkT1qPWAfxOAx
	Frv5Vql5inxQF2NNw1gMMOcHh5/RwBcRIQdNof6fOvsr2a2nt2UCFghqAFirOCO6
	jOCmtSygMpBfMMxdj89reZgLo3e23g8r4qSUCaKXRz2waQs0xxM8XBZ5OqsvGa4G
	mPCg07WW6JlyhDuo7SmNT+B7mdrS92H/xevUhSaaxyj6YJGWFwXJtpX5KDHXsYvZ
	4aLydJxmJ7i4/1apAe77AtF62+8oPKGJQu3uCXInQAYWECSYFb7CaDpYpegTui3p
	hXU/PRfYwHKm5rbiNc1cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729682551; x=1729768951; bh=DyXy1uENe8BhOOL8uZDqsDDMDgXh
	YxR835mX6crlWnk=; b=NzPlBx9QSepyGtxjwwTsbYWrJ5BrU1l3MkLrNLqVmN+O
	xWQT8H3LK2IYFFMM1SgSSZn5h7BE5BZLIUbZ/wDO5VNWfW8939Nj694C7Cgtv21+
	+87rG/z0LM534IOHX3aWtucylKyzoISJVKrkrftpCabE7zCcN0pIj68OPkmSGxiY
	oCdYDmYrJ94SWejDb9ZZ9N5FD7QeNOjlfCr0kCuODY0iF6nyQtNzAG3RcMQHYG8Q
	SXEHgHIvjWVqDVsF8+N6gzuEgcxuzh4+gWnamp1vh1/Ht1N/3Hd7zxFjnlCMaArx
	Wrl3RUTVX7ibbQQeK4FaeJ6tTeHqKDNLc53VOa85hg==
X-ME-Sender: <xms:dtwYZ3HpQbOu07ZTECaiHKR_er7QSKVIJRiTVxn9RmSG6QtacSD6hw>
    <xme:dtwYZ0UH7gTqI4W3ThVV0vzEnWJrAeJNtg2sIdgpRQImU6uW8aNIKVWlfHG7-5Zu8
    uS-UJZncPVtgnjoTW8>
X-ME-Received: <xmr:dtwYZ5Ju3XRb7EDiOwzlNEvMWtuMKr55LagNXnL-lY2fSag-9-Yvg7KOeOQ1Zf2mu6QLzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeijedgfeekucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:dtwYZ1GsGoNIxPCivnV6Xl1yvinA-TNb0N60_O8Z1cvNPSiW9HSJeA>
    <xmx:dtwYZ9XoGx6O3jdsjnjSMko4DKm6y48ZqMg0eBeFCFEWHSreuD4fOg>
    <xmx:dtwYZwMdVMAWWGM_Ms829pm3ktJySXv7TODcCU7sCfmTNxEkg7gJTg>
    <xmx:dtwYZ82dQkF1la7ajkyJ5bG7dokA82Hm5XVq8lz5Yekp_nYQ2M0F9Q>
    <xmx:d9wYZ0MVVRwvsvB4IISYlEOaEUCbgyDMzOl2ZmTeov370G2V_aQyoaeO>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Oct 2024 07:22:24 -0400 (EDT)
Date: Wed, 23 Oct 2024 14:22:20 +0300
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
Subject: Re: [PATCH v1 03/17] mm/rmap: use folio_large_nr_pages() in
 add/remove functions
Message-ID: <mot6mb77ijjk3lf2jnz45bz33jequkmsppvrel333assaebkdj@bv4jbfaavwtl>
References: <20240829165627.2256514-1-david@redhat.com>
 <20240829165627.2256514-4-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829165627.2256514-4-david@redhat.com>

On Thu, Aug 29, 2024 at 06:56:06PM +0200, David Hildenbrand wrote:
> Let's just use the "large" variant in code where we are sure that we
> have a large folio in our hands: this way we are sure that we don't
> perform any unnecessary "large" checks.
> 
> While at it, convert the VM_BUG_ON_VMA to a VM_WARN_ON_ONCE.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


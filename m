Return-Path: <linux-fsdevel+bounces-32651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A47F9AC8A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 13:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDE6D1F223FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 11:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB6B1A7AF6;
	Wed, 23 Oct 2024 11:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="esWd5upk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MU/aKn+a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D103154439;
	Wed, 23 Oct 2024 11:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729681933; cv=none; b=iq1snXMdU+ifuCER/z+IKgMenAwbsBY40EGtIZuXFMCy3ycpfmrGfWn5hJbsbj4VxqS+btSs7H+LWu7ZyEZPjIp4EdibsH1VfQaCuY0zAkinwSmITswUEgw7qmYY5xJNZnNIfTL36oofGOUlEciZLjK4Ypc9db6JG8yK3xom50M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729681933; c=relaxed/simple;
	bh=LQIscU26o5fPBuWQ0tCvE58DeZDwedgynA0FlcZ/EFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhia8UwOnTxsNm2o9ZqZ21N1cXESdGjgsRAwWcGtyzNthtxTb9tBW+Mt8891ADxVQj2z4XtPQC0VDcNu76g1iKs8qE4wWC3Q9qnjqX/I/Di4NpQ0CGR7Bh80LTyEl/H2DEMwOckzFPdrfN28qg0EjbkRXTRvxSXdT8ksc5Y69Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=esWd5upk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MU/aKn+a; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 61B4B13800BE;
	Wed, 23 Oct 2024 07:12:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 23 Oct 2024 07:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1729681930; x=
	1729768330; bh=DrExPGH5qC6gMqdPJrUNvKM3C7Up1PpwnopQx1G1ds0=; b=e
	sWd5upkk5VWriLH2QNH+VUxbVs1W2K+XG5Nbi4STHWuwUe63UTg66bjtE/GNFY2H
	L2zGw7g4TghT3NtVJPG0olbCAlp6+XdRQYo9IMUE/VuiPqvEDnc0LMVThyf4pP0Q
	UJz2wVWq4lUWlZ7NO6AdyTDYIl769avdIXgqQvoiRr/aGsbGHAdl3UOUhnSNKDV3
	W+kYL3/1sWT1rRLuGmu9Yt2Re4sFY3lXhZP1A2dx6Lm7ykfcREyDLBv2hJAGfqoa
	TKb78Ckvx7V1BBlIRGvebbLMG7aaYYYoUb+Wm88WplU45EzW5T22vlvuaKXgLJTi
	HObzg8tWQxLxtFts60NZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729681930; x=1729768330; bh=DrExPGH5qC6gMqdPJrUNvKM3C7Up
	1PpwnopQx1G1ds0=; b=MU/aKn+aaqxOIB0AgI94pqAB6GzADXpm7dGkuPdQZJGx
	2x5/uIFfng0pRuxXLyph8nfZD+L8ujVow3oXn5mpyZZHP+eP3uPHONGi9/kFhGB/
	4YfA+s6zOHYrtJ5kuJzXJafnkYesJLB7/cb2j2E1NeQSNwNB7oOg5dZF+45cRYUw
	kKbCebu7E5Pq2UYWrkjtwvIcmEo/wwIJePOVKxnCZrwz7EeYm9BSVap/sgLdU1fl
	l6KVwFRUolo7mBlZZFPKUYocMKY6SFSJe/2L4kdrglyTq5ts63zXjjw4SDpwt5Pc
	D1fU/9uQbSDaLEyfAsZo7qgKkJ150lPSd46+lDgkWw==
X-ME-Sender: <xms:CdoYZ88ZnDc1EHGhfQMep7rbkA1wauqwQcpj1q0ud_Vz5UvqChEEbg>
    <xme:CdoYZ0sTcYF5FkLRSAGsjsDoyy9K2Hvw1MB2omfy-Aa-M4x2BHAElwB3c5qiIIt1i
    NY_KBrG8LJcMxVeTUw>
X-ME-Received: <xmr:CdoYZyDx_n5vsKnIYo6m2dUq7SDpnBZc1bOA6XEAglDkeE1yQjdYi2tXZEGPjkBXQQDURQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeijedgfeeiucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:CdoYZ8fWkm0t4xkuko9xuUt1RqHXw6pBIU6x5oQKNwlRRI5Fznvliw>
    <xmx:CdoYZxMBNGIiftCHTwF4TbHJKkDVOyAZPUFkdnvNhhIExqphj2FyZQ>
    <xmx:CdoYZ2kjhoGdJH7kRWe0FWaIUmHF-qc85Dn9X8z_F6JfChCe5D2O9Q>
    <xmx:CdoYZzv7Vs82tyJ386wkDy3ySwiRPK3AqH0HkHwX18CvFAWfXFMfvg>
    <xmx:CtoYZ8EyuQudTx12meAXlSSrarNcohXxf0yctiV8rmOw831JqTBG3DFY>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Oct 2024 07:12:03 -0400 (EDT)
Date: Wed, 23 Oct 2024 14:11:58 +0300
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
Subject: Re: [PATCH v1 01/17] mm: factor out large folio handling from
 folio_order() into folio_large_order()
Message-ID: <m4ans5nv2brrxm6i54ydwq7qd64kuta3dwltlfnyl73iojunjc@spqvup2hmp5w>
References: <20240829165627.2256514-1-david@redhat.com>
 <20240829165627.2256514-2-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829165627.2256514-2-david@redhat.com>

On Thu, Aug 29, 2024 at 06:56:04PM +0200, David Hildenbrand wrote:
> Let's factor it out into a simple helper function. This helper will
> also come in handy when working with code where we know that our
> folio is large.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


Return-Path: <linux-fsdevel+bounces-65290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E15D9C00837
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 12:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC20D504654
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 10:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AF830AD1A;
	Thu, 23 Oct 2025 10:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="hy0pkaY9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YjL9jDYI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E748927FB2B;
	Thu, 23 Oct 2025 10:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215499; cv=none; b=iDgOeqwsrjfzir6HgmNZa3F8N30d8feACArgDg1QXHldQBh2k+Z46g2W+bZLtegBKWTSMv9R+fRdGtqR7X8Vyknget4S/hTGVA3JifzSXBDJMBDH2jtmxbMsxTpfhksouzLDWhdyzYB1NEMefg8IhlsTCFoN0+kOy1cYA1KFkrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215499; c=relaxed/simple;
	bh=2WieFsyX+Yqps68WyyPp0SgJkAoUat4dRfE/J4UOBUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jAUk9HU2746mHWTdhqZOJNu2P0lTUqXiejo4LDFXq8Od1xyPj69Vlg+x1syecyYAin0DHFAznlItpmZpNmC3Y0xWbqdyrBh/UslfVLyfRDNwP/8K636l/1ySzAdkkf4zfO8MeUz/id2l8gaJZO5Uk5P4xG6Kf1JBRyKVTVpQ780=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=hy0pkaY9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YjL9jDYI; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 884357A0178;
	Thu, 23 Oct 2025 06:31:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 23 Oct 2025 06:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1761215496; x=
	1761301896; bh=kU4wHUg441bPx7RT7b8et5JEMZCrtmo8GUTzuMPpBo4=; b=h
	y0pkaY9LCmODejm50cF3ckusmXBnosXXyTuEOWjZyzFxQCl++b5Ni6JS9HdvdLua
	QIyz47qJkQ9nGmHpswgvd2yQEnLgtHiZkPP1QkknC7XcFtdrjdU8YsyTAiujU9Pa
	XdxzMiZX8dBv1pff1i300YtGUG2I9gNQ5AEua3vqLC8PTLUMyb0nAveAIyX8f6Jq
	PlgiUta531F1nfW/PQLinAMtMQJl8H2yhvZjI+D3iKpHIcT7esWoQcFX0dE6TJLW
	ngENJpo836glZB2M+q3oJ5q2XwpQRcnmdP0jbwfYI2ps66ditNniNJ/xMcc24zU0
	tc/DnW1UhLSY4iUpCyoJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761215496; x=1761301896; bh=kU4wHUg441bPx7RT7b8et5JEMZCrtmo8GUT
	zuMPpBo4=; b=YjL9jDYIvucpP1jQifzOwIaVbO8pcRg8oC/0YrnlVuWoZhbPnLl
	AZ0WVB0I4XLYeiDdZ6QX+j6yrN+3lH1gynyOe4veJJw7BxutOA7G48aoZEVKHavw
	9rUqaUjuFHlC3jHdRtQQ9uRJax45NhVbf2uJwrSyXvvBySLzxjTpMLfrNPSIYOaV
	8GO9E9n+9Pd1d7/ZZii3QoraKDTq/A0CjRMXFI5O1WXUHg0s/jj6NZDajxMFhT5Y
	L4SX00Or6Kl8eaAHnJSxXGYIRs3ZsGLyOE35jrq1wJXkP/21cA2lW/B1fglR718B
	7GjvN1FoNugmBtNa8n0m94QiI6CPba0ezzQ==
X-ME-Sender: <xms:BwT6aLr6ZjKli_l3OG0rYx0kcXY5Q1tbqTbTf8ljrbLBNo7g0rMN-w>
    <xme:BwT6aG-OZQhCPhEFvB3L0k5oqlmZxVKPysSP0TV6llYTDQA5arQFRHMMJ6E0Ciyjt
    AIdqRZD8TzfN8lcOhCZb5hh6w21YoNk0SPthuyoedJCBEKuaDvZcjs>
X-ME-Received: <xmr:BwT6aM1juPwWSEV2S1e-QCC40U92flMlTTL6iidALSlZoQdhR7nnREnN1ixWuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeivdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepjeehueefuddvgfejkeeivdejvdegjefgfeeiteevfffhtddvtdel
    udfhfeefffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopedv
    tddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhhiugesrhgvughhrghtrd
    gtohhmpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhr
    ghdprhgtphhtthhopeifihhllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoh
    epthhorhhvrghlughssehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphht
    thhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepsg
    hrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrtghksehsuhhsvgdr
    tgiipdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:BwT6aBlU5LVBjWGWy44QP_07ndzR-KZiCFt8CQObXxH5rC0YCGC-Lg>
    <xmx:BwT6aB3i9xBDIBjK9AqEBqkIRcQQNTxiVtm9EuIU6KABWbSLQQIo7w>
    <xmx:BwT6aIgb2qLFera_KuKiOxBA-rjlXqevd3q5vwnZeEy2e4Oipj1vrQ>
    <xmx:BwT6aHUsuHGTenP2WCDU33LJydvMcHD6uuFsqWHUqVPMXqVsKEgvmA>
    <xmx:CAT6aIuPqRNc6SAmLW6J7xAKggsIg2Iu4awBfINmTMO51JBGFNIiNPgG>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 06:31:34 -0400 (EDT)
Date: Thu, 23 Oct 2025 11:31:32 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/filemap: Implement fast short reads
Message-ID: <hb54gc3iezwzpe2j6ssgqtwcnba4pnnffzlh3eb46preujhnoa@272dqbjakaiy>
References: <20251017141536.577466-1-kirill@shutemov.name>
 <dcdfb58c-5ba7-4015-9446-09d98449f022@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcdfb58c-5ba7-4015-9446-09d98449f022@redhat.com>

On Wed, Oct 22, 2025 at 07:28:27PM +0200, David Hildenbrand wrote:
> "garbage" as in pointing at something without a direct map, something that's
> protected differently (MTE? weird CoCo protection?) or even worse MMIO with
> undesired read-effects.

Pedro already points to the problem with missing direct mapping.
_nofault() copy should help with this.

Can direct mapping ever be converted to MMIO? It can be converted to DMA
buffer (which is fine), but MMIO? I have not seen it even in virtualized
environments.

I cannot say for all CoCo protections, but TDX guest shared<->private
should be fine.

I am not sure about MTE. Is there a way to bypass MTE check for a load?
And how does it deal with stray reads from load_unaligned_zeropad()?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


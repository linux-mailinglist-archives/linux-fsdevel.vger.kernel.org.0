Return-Path: <linux-fsdevel+bounces-34414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2642D9C5192
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 10:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D35D51F22A91
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 09:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F03C20DD53;
	Tue, 12 Nov 2024 09:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="buAfCkEp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XsDobdut"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E64209F4A;
	Tue, 12 Nov 2024 09:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731402746; cv=none; b=oSplU/HCj0G425WPwwaurYye8CybOaeKHIuJ+5uTxvhJMasY3L2wKvLI3xcI5Is9anBtg6ZxxxOAx15+tMHGajx0lUUNeAq1TK5H3EWQ8QKRZssKye2XdPKlgCpa9KGY2ng88qJPkcG6esiP+mAQCCK9ZPcM9iazsmcm3YtWNbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731402746; c=relaxed/simple;
	bh=6JtaLLQ/v3VECtHaMsXqeUBPZz842Chv6jk9Tfb+EaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9m4rroJNU9YLkw9UmkSGuXsRsA1+2y7SdbjqAtBm/NbZpuJQGWFySbOsICv5I9hiP6+f/2QkRqMdnKEEZ5+M2J/HNGOK5uZhkebHVXmXHVTDd/8ubGcw9Y/AzWYFbpKTagvO604HzE5sa4l6KmBZdO3rNeITh1lgkvDXv8je4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=buAfCkEp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XsDobdut; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 286331140182;
	Tue, 12 Nov 2024 04:12:23 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 12 Nov 2024 04:12:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1731402743; x=
	1731489143; bh=LviMUWp4Is8Fy/dVsm0aEbYiR7YOyd/oz5oNPRf4lTg=; b=b
	uAfCkEpImy5cjaoLEU5eFxh7p2wxjkFDdmQeReof5SL3TVEn6WausxBEwpiCioBo
	9jLsc83YaFd6ouBNhr6dG2qtVHuHM9P83YnVoqwFX+M77bReKCHcCnhS5I9P60fV
	bnSllq+u7p0s8XWiwQpIxFvr1BNFKnnSxZeUhEXsH2iFm53RTPm+AkZFu9ZAqJv6
	F+8WJm0kjoPip4QRqHA9fNJ5jjV4r1QRNxQdwKXuUnwoVKx9AycrtbKrGB10lSqi
	BGVWJFWm3dhJwQ2jpQC9MSuzvaS1d0NUqyhaNGwhvbv8hkcir6TQsyG01fP0FKXg
	P5GeCF6IShcnpG9tOyX0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731402743; x=1731489143; bh=LviMUWp4Is8Fy/dVsm0aEbYiR7YOyd/oz5o
	NPRf4lTg=; b=XsDobdutrRH1T1/TltivI79Y3Cb8DNBZBUZcxIIGJJWZaElkO4Y
	FCcDgGwaQPZUanAndjuGtWBOXjJjRobSmBB2vUkVccr0woNlj3uEWKNqmUBx/CdC
	E3cLbAPQ53KooZIhHEX/xZeBLDgbiJR/Tuq1oauzkvXAXhXpgZBUKQVKVAZ/9Kub
	qdrzYGZV31kDUp4zEKITuDodbvF+QBMmlHlBxeXMn5b/QWJG5UEBIlBXqhobFLPI
	VpXJGICsuF+J6IkaNCsvE/AcQzNOZPY2zRHUIy6soIugOElMdTH2eJ6k7mEzdOHl
	t1kyF8v5OgvV0l9fOfdaR4OTv716fPGJQuA==
X-ME-Sender: <xms:9hszZ9AXcvesEPT2Ac1yYleRPxob8aOMB3S6M58G-1oRTl1sWkvqZw>
    <xme:9hszZ7gfr3hv9PsiOsH2LMFjqHSxgcSp4YaDnEPMxW8GeOPEubdrLiMP7APTcwkx0
    j7d3fYcS7z5eZIx5m0>
X-ME-Received: <xmr:9hszZ4kpEH7hl8qKrI1nRGP3bBT53kApJN2n7HjRvUo6j7_YZ-IBpI4YqRLLZp887jh-_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgdduvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvden
    ucfhrhhomhepfdfmihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlse
    hshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeffvdevueetudfhhfff
    veelhfetfeevveekleevjeduudevvdduvdelteduvefhkeenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhv
    rdhnrghmvgdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopegrgigsohgvsehkvghrnhgvlhdrughkpdhrtghpthhtoheplhhinhhugidqmhhm
    sehkvhgrtghkrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhrghnnhgvshestghmphigtghhghdr
    ohhrghdprhgtphhtthhopegtlhhmsehmvghtrgdrtghomhdprhgtphhtthhopehlihhnuh
    igqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeifihhl
    lhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqsghtrhhfsh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgvgihtgees
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9hszZ3wxYo-EonlUCaSna0xEvY9Ye-it7EF5_DeUkCfk-vTYmJbA-g>
    <xmx:9hszZyQ-2Kf278mXEJiFImXvd0sRH-vBI_GlHrNCBIOd_xBb7YPqbA>
    <xmx:9hszZ6Zp_cC09g1441JPyU_dulG9M_TVwhc7SlgbsLh91Mkw_TN7ig>
    <xmx:9hszZzSxdqRUEs-SSCOGHa9YOoY3BM7n51A20v7kTETCDNpl5s7IcA>
    <xmx:9xszZ3KhGoeFXQWiZqiR5dKy_gf-bAqGpjBDmvrCYSz0CEgR3yJVMfw2>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 04:12:18 -0500 (EST)
Date: Tue, 12 Nov 2024 11:12:15 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, 
	clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org, 
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 03/16] mm: add PG_uncached page flag
Message-ID: <lponnb7dxjx3htksbggjoasvby6sa2a4ayrkcykdnxvypwy4pp@ci2fnmcyrke7>
References: <20241111234842.2024180-1-axboe@kernel.dk>
 <20241111234842.2024180-4-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111234842.2024180-4-axboe@kernel.dk>

On Mon, Nov 11, 2024 at 04:37:30PM -0700, Jens Axboe wrote:
> Add a page flag that file IO can use to indicate that the IO being done
> is uncached, as in it should not persist in the page cache after the IO
> has been completed.

I have not found a way to avoid using a new bit. I am unsure if we have
enough bits on 32-bit systems with all possible features enabled.

In the worst-case scenario, we may need to make the feature 64-bit only.
I believe it should be acceptable as long as userspace is prepared for the
possibility that RWF_UNCACHED may fail. It is not going to be supported by
all filesystems anyway.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


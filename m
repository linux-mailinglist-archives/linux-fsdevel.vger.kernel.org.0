Return-Path: <linux-fsdevel+bounces-34093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7E59C2588
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 20:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADC64B22043
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 19:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76851C1F21;
	Fri,  8 Nov 2024 19:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="Lnh7ig1x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DlkbYAIq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E271A9B54;
	Fri,  8 Nov 2024 19:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731093940; cv=none; b=O3WcInA5hswDFu8ncEaENzBxQ3dvlTqd8B+nDRb12U109F5O/Lc3N6ZCafHXp5haNq5WWcgrF2Y4xeqQLONKQW0LCPAvAOB/OeNiWJxL3Lmkq/k4bdKIYvYbv5FdQgdDNt2dijPZlR4vCPDJccSoFvytzSsKlpu3SfBjg/GQeDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731093940; c=relaxed/simple;
	bh=mvQKueWlpefaVNvoNbW94RqK5Dxblon3eu/LzPGEKDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHQ1fpn7apOQYq6dnnk67NzgiXs/HNRC9il/FJUsJHGIGW1ANDsmwNvH3lDDRG7GfCRvvDgYh1yNcFweLUU0S1wroLu5LRUbD+4jmyeuYJl3oplD/S2w6DMH0ZuCsPeWQzkfJcwdWUPyAEjDHiSJBjTsiSYW4tFaAd3aqEbAU38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=Lnh7ig1x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DlkbYAIq; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DDD3B25400F2;
	Fri,  8 Nov 2024 14:25:36 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 08 Nov 2024 14:25:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1731093936; x=
	1731180336; bh=Gwc623npqkQAxgOfn1Mt+u27tSynXETPHJcw58J6KR4=; b=L
	nh7ig1xMTM8fuGFJz8frj2HNK5I1TiuSJXGgBJM/wYuVso8gjWxr12u3+Ozr4X53
	2V3/OsHjazOARvd2asN3nXSa/jpfICYZkvGOWbzllO7AEbPSKFSJLjZo9na3PAFy
	PcHZ+SuYCoAvqqfCQ0Tmw4z/vjW6VpSUOy5izSb4/ZgnKAmqCgtuXmrz1TLBf94V
	dNQl9+tm2QKM17Tr8zMOKpHvfeKVx2MOoXofWPt/rPC5Jm8T/U+EhRFRdH2CyaIy
	Gcz0ar3mas8JkLOyntR6Ir3kpmGd2hZnWPJHEkfGj+GjddorE5qwU8qGbyrOZNyq
	WUVR4bC1/PUTx9rd8m+ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731093936; x=1731180336; bh=Gwc623npqkQAxgOfn1Mt+u27tSynXETPHJc
	w58J6KR4=; b=DlkbYAIq5k74q9kBOV5K+u2t1nPA0g9Do3IWxW0iDSeIy7assjx
	toxqgDMIjSr5A2C+PuqIjVGk+m8qm9+Ymhm2n+2IEireVDVyn1qOFLM+6t0+CPL/
	3ns+8UCU0fTTTSxSEfAt8RVTmFRtg93wU9gaTHiuPGRuIfX/E64DamQyrHHy62m7
	OfH7BBq+QzWXPy3L/38BZOzqH9YdYeMs+Bzd9pzpXE8BvwSLGfDmg2ejJYmA9Jvn
	30yyCw64LuWIylTtUWbsFVopDRcmSwdwsWuRexVnhuD0Gbt68dPhECDFIf7Odbul
	5kc5GvgstKDlnUjGIF/Ei5yfv0JB7N/DVIw==
X-ME-Sender: <xms:sGUuZ8qzzfHXLSeBFovIADzmO0tY0Co5R_Vbd55l9_LEFT5schAdpA>
    <xme:sGUuZyolS_YQ3UnZNndGcy1L9Qncp3cjmiZ5POjZDJaW6Aaf2h-fKlsi2tMZXEuSy
    dezA-efxHxPrpqF_1M>
X-ME-Received: <xmr:sGUuZxPnegcmUb7H4UOl8H46z8rtA_Ku7RjfSWGFuYVOe3tvWaDdwbvmiGHPREmeAYvdmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeigdduvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvden
    ucfhrhhomhepfdfmihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlse
    hshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeffvdevueetudfhhfff
    veelhfetfeevveekleevjeduudevvdduvdelteduvefhkeenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhv
    rdhnrghmvgdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheprgigsghovgeskhgvrhhnvghlrdgukhdprhgtphhtthhopehlihhnuhigqdhmmhes
    khhvrggtkhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrnhhnvghssegtmhhpgigthhhgrdho
    rhhgpdhrtghpthhtoheptghlmhesmhgvthgrrdgtohhmpdhrtghpthhtoheplhhinhhugi
    dqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:sGUuZz7hVl8oZlvI8bIstoIrF-Ust1PkX2PuzvuUtmahtDFmPs6iAA>
    <xmx:sGUuZ75fx0twImD9cymo25eqQpnXfvc5HQOKqbGFEbwzZN-cMticCw>
    <xmx:sGUuZzgU9-uaUeluO32UB2qXl852ctSTqdZA8Lf4hjTXbP9ZnElHYA>
    <xmx:sGUuZ159mxp954rg7WpHXeq0-p6sxkHrHLC7lz4NONdZUPBMF-gXxg>
    <xmx:sGUuZ4ufl-M96MvxInHIFn6neZE7yAdiA1gquiiC0FwKodU49OYl9p0X>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Nov 2024 14:25:33 -0500 (EST)
Date: Fri, 8 Nov 2024 21:25:30 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, 
	clm@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/13] mm: add PG_uncached page flag
Message-ID: <u5ug67m23arro2zlpr4c6sy3xivqpuvxosflfsdhed4ssjui3x@4br4puj5ckjs>
References: <20241108174505.1214230-1-axboe@kernel.dk>
 <20241108174505.1214230-4-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108174505.1214230-4-axboe@kernel.dk>

On Fri, Nov 08, 2024 at 10:43:26AM -0700, Jens Axboe wrote:
> Add a page flag that file IO can use to indicate that the IO being done
> is uncached, as in it should not persist in the page cache after the IO
> has been completed.

Flag bits are precious resource. It would be nice to re-use an existing
bit if possible.

PG_reclaim description looks suspiciously close to what you want.
I wounder if it would be valid to re-define PG_reclaim behaviour to drop
the page after writeback instead of moving to the tail of inactive list.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


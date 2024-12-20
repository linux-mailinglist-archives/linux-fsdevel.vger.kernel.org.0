Return-Path: <linux-fsdevel+bounces-37922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FE39F90F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 12:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831CD1898796
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 11:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCF51C3316;
	Fri, 20 Dec 2024 11:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="OfsQoP1g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kQgjIT29"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636FD74059;
	Fri, 20 Dec 2024 11:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734692971; cv=none; b=nH2FbdGr36bFpHLDSPugRAyUPybWWMmfNoMh0nW6Sf2oo7kg5vq2uYA6lYjq6hGs2YuZ0LL0Bbl8U3tSnfkLfXV3xCVe6oEVR+sN253JIeoUHdq91L+AeyB43Jmhrv4cNa3nr8Mj91+F5MmfBYxnjqcaspf5062SKNycdP+kXKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734692971; c=relaxed/simple;
	bh=i2TX5DFE8tY0eyP3vloof0lTAchecGn7vlEOJH+iTAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJm2CmgET7MCeBz3RPLUvvrtlrKJWlUoyDJOJKHfrPRMndSN7KYsG72uryCikiX2j1yFSFMNDzFTwsMLFJSAgTS8bMDDbEQjBf8sLwa1vtmNsTghh3ilWWprv0UJUKb5GlCNBo4p84S1pfdaY5tyxrzi9n/5H3tApt+IaB9aN1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=OfsQoP1g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kQgjIT29; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 70B471140187;
	Fri, 20 Dec 2024 06:09:28 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 20 Dec 2024 06:09:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1734692968; x=
	1734779368; bh=9omR+xD+raRgCMWbv7TDKzGhbyc+5pCjN0tMAvR7bXs=; b=O
	fsQoP1g87cPdXOYTKwOCS/pQIOUBriySSTYkwcvgdmgdedFc5/U4FVxBjOI3DvFJ
	qgQM79tfiamUxHsnD77Y7zhZfvxOEWIQhUl3LisrUXt8y4CXx7+kNokERtM88/Xo
	/GjM2Q1kPHSj1SywE0+kYT9hzkUVrohedbpkUqbIPnu1K7LeZLjWnqrcoiH3am+W
	9iYckL8eL8DjslCg5473NzHPlGyPKp86WY3RnFdRLm8dhkuBbpYVknX23A9drHol
	p8EBSxo1/AFRRhEXRDIzMjbuAt2rB5MMJM7H+wLkooMkq8IGAn9ZPymuFqohsZps
	jkvi3I6M8qxcfpUCnsYhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734692968; x=1734779368; bh=9omR+xD+raRgCMWbv7TDKzGhbyc+5pCjN0t
	MAvR7bXs=; b=kQgjIT29Ef6EZRo4oNU3j17pjXI52GvMG0So49fQUdCQ0wxn9Q7
	i9Go00jkEMm3t3GyB5HirjYmxxMJWA+4gKp0LBtH9O925Drub59Bun18ydHYHM41
	q/LSWA0HxKWKtiHngbuvpFOeXZUm+kKsYbD1GYXYqBDR4uoEWNpN9ruXJ1E8VeHf
	hITue5gZ3yj8M6q4w+Eyk0TXLxxkm5+nhLKIeuTJUZoTy6Yty4ZgW05sRhHbp7Fg
	sNKUj4yTZpdC+8xRqdQWIF9APATW4GqoAdtlgjZytSlHZCYQZwFe/3ScIwDkuEYS
	yVkhxNt80YyWehk2xyweGwjkDLoIlJJUPfg==
X-ME-Sender: <xms:aFBlZyFZJG6N40tCnpNYgWUumWvAKfpgWDQDaGVyxpdeoDSS9-cn_w>
    <xme:aFBlZzW1751EV62_OODYOuT-9NokAIMfhQ1t5ibcPkXxCzWsBBfYQUAGAbdW8zSb1
    Jk3rxyz_amBN2qJR8U>
X-ME-Received: <xmr:aFBlZ8IdGpbP8tZoIZIb7pGqWz4Z6iW3buFt8PwM1_DArhgpn2CyxA23V_ASUgBTxdAtAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvden
    ucfhrhhomhepfdfmihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlse
    hshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeffvdevueetudfhhfff
    veelhfetfeevveekleevjeduudevvdduvdelteduvefhkeenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhv
    rdhnrghmvgdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheprgigsghovgeskhgvrhhnvghlrdgukhdprhgtphhtthhopehlihhnuhigqdhmmhes
    khhvrggtkhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrnhhnvghssegtmhhpgigthhhgrdho
    rhhgpdhrtghpthhtoheptghlmhesmhgvthgrrdgtohhmpdhrtghpthhtoheplhhinhhugi
    dqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihilhhl
    hiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegsfhhoshhtvghrsehrvgguhh
    grthdrtghomh
X-ME-Proxy: <xmx:aFBlZ8Fjlk92B6PRlspTcenziUCiJwUMKy6V-IIqBstcUObLHUg5Sg>
    <xmx:aFBlZ4Wj15Auld0u-7Fszk-MZdyzz1uq2SPdBwexiFSUjzry8xij-A>
    <xmx:aFBlZ_O5PP76onRvWhyR3itff8VQebu56RgcN-Xeub94hievzFzWaQ>
    <xmx:aFBlZ_0PjWea6iVQeciY2ScnFuP4h98KOUqJRd0VomXeqiVKZ8dDQQ>
    <xmx:aFBlZ8r6c8Rpg-D3VW_JPPh4GW8xcJVXXJnvkaMUCPtMUewiZnlUKpoW>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 06:09:25 -0500 (EST)
Date: Fri, 20 Dec 2024 13:09:21 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, 
	clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org, 
	bfoster@redhat.com
Subject: Re: [PATCH 05/11] mm/readahead: add readahead_control->dropbehind
 member
Message-ID: <tlthyrn4i6ueutal5y7zxa7anfcfmztu7gb6pk4rngr544745e@3fwprd6pmrp7>
References: <20241213155557.105419-1-axboe@kernel.dk>
 <20241213155557.105419-6-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213155557.105419-6-axboe@kernel.dk>

On Fri, Dec 13, 2024 at 08:55:19AM -0700, Jens Axboe wrote:
> If ractl->dropbehind is set to true, then folios created are marked as
> dropbehind as well.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


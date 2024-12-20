Return-Path: <linux-fsdevel+bounces-37919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 349A69F90C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 11:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93358167C64
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 10:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316AA1C07EC;
	Fri, 20 Dec 2024 10:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="QCFiVbnI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yAWXaQzX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926E1172BD5;
	Fri, 20 Dec 2024 10:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734692226; cv=none; b=m5hqlWFi2Ule8SikonTRBgjySuGsy8FIVJ7oB50XIbE0e/900Na/WLGytdeDHy57YrOiEbAcPfsAAA7UuTmpqEBJdZ2524JzaAaZeu3De+REjXnT7XLQZAMHw8LtJzoeXLjPFIvZUMe7k0/HZdj1j+FO8wqgBwUk9KsaJmQxEwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734692226; c=relaxed/simple;
	bh=RQ589VS+jHnu+kQPgRjOFtU6olfR4bjcn9HkYyNCtic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwCVRI0gQSjzXddNngnCjRoh/PTrux32L8PJ2Ftj63mcaAcTcEXKBCJkJ+YIG3CMDLjvTCmSwL6bkRRhdTYQwERnLjUykz/+4B+Hm3pKt1JWhnlIUBqIKW1ST2mEosiuI0C2Kxkq0gtc/s+/t6xgXe0m5VjsuuYtdCL7p+9ME/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=QCFiVbnI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yAWXaQzX; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id A183113800B4;
	Fri, 20 Dec 2024 05:57:03 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 20 Dec 2024 05:57:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1734692223; x=
	1734778623; bh=l7zB+DcBUR2WNayH+8Yx83OSvOCD0+6Xtmu8O5gzexQ=; b=Q
	CFiVbnIAsxTmoyUvdMT55hJ5+IzCRFSq1wfGD7+R+glFn6B1NfO/lxbFXDoas+bO
	53wKOSnpXdY3fwDLFZncXK5ka0RaPLHbyN6/u+EYb4cIsYnyNGfGV+Pjc0Y+zj8H
	jVB/ICdCmuXTJ1qbMZddyu4YyfLG4VfRVVXPMWgvZEYtcn3/AhfB0Ir6Tyqy56qm
	L404Zl/cMJfj+sLTWTeb1RuERbQU+BAhn7iJE688HTKyx95loE+7zJPD04LR5ysz
	ZyBwrimN4tNy2NFOl1K+NTxBTEQlu8Roc3tUqF2Rw2l0RZMe2j+lOpFbtQVNOePy
	OGsLOJ6eIhvxeLDLt+NDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734692223; x=1734778623; bh=l7zB+DcBUR2WNayH+8Yx83OSvOCD0+6Xtmu
	8O5gzexQ=; b=yAWXaQzXFReix810ghkhaWZ519vEMPxaLT3QJebUNBOBjMPb+gH
	eDIlhDAzsxK4Zwa5a0cELjEeenNFBY7wE6lDiL6pqGwV3ME1NxO8PlLgq9fDrLHp
	xI4YkfRUGA4BanVv6NahbJvbaou7NA5rvFfF1CcqxtatQcI1yIQIuJ5qLIS3HH30
	wyEecfmAZX2kghSN9vYTNmmIVD9D16+T8HLQmtGPcJw/J8uiHReeWVvg0Crpvspy
	ctrbpDmQTMdZeboMRNNeINV6AGruSMYWkGLqNe672X4qWf5xznmkx0FvlFqF34Y5
	/k3E7efxqem/JPQBondNvK+hO8nyDeBq8tQ==
X-ME-Sender: <xms:fk1lZ1JbJioN1i5sn93CFpAh7M9sljam7JKMZ8cIMWZOgxikV4jjWA>
    <xme:fk1lZxKq7vvourHyaTGqyiKjD14kPL_zrMXgw4R5vyTjWA00hPkQn9BdCYV0SXO3x
    CtF-Tioq-9QnZWUDeg>
X-ME-Received: <xmr:fk1lZ9vtYg27y9JWp6WQQKtItSHNyzfRCpcoMkVzf-mpnbaGFww1yTJ-MoFsFkXqiyZ_Jg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvden
    ucfhrhhomhepfdfmihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlse
    hshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeffvdevueetudfhhfff
    veelhfetfeevveekleevjeduudevvdduvdelteduvefhkeenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhv
    rdhnrghmvgdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheprgigsghovgeskhgvrhhnvghlrdgukhdprhgtphhtthhopehlihhnuhigqdhmmhes
    khhvrggtkhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrnhhnvghssegtmhhpgigthhhgrdho
    rhhgpdhrtghpthhtoheptghlmhesmhgvthgrrdgtohhmpdhrtghpthhtoheplhhinhhugi
    dqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihilhhl
    hiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegsfhhoshhtvghrsehrvgguhh
    grthdrtghomhdprhgtphhtthhopehhtghhsehlshhtrdguvg
X-ME-Proxy: <xmx:fk1lZ2Z0mQnjyciCTZ2X0VI8BnWyy40FENG_uv7hKlgsWyW8NuPkUQ>
    <xmx:fk1lZ8b3NfOHWi4U7ovF6WC84gdhLGeDq7s4oFd9jwRhqz4Mm5IpNA>
    <xmx:fk1lZ6D_BKpScHk_B-wno74sc_5D-v9twtTqQ6yTkU5kJDHRfSPMxA>
    <xmx:fk1lZ6Yo6LsGGhJJJrnHy9cOmrQFlCOrWfFSOT6Pne0cIwqIohAYNQ>
    <xmx:f01lZ6l6LL5Pcm3ydmkHWdmqCM1mpsWY2ZiJQtALR_zDlEB_NlufGFh8>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 05:56:59 -0500 (EST)
Date: Fri, 20 Dec 2024 12:56:56 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, 
	clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org, 
	bfoster@redhat.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 02/11] mm/filemap: use page_cache_sync_ra() to kick off
 read-ahead
Message-ID: <e5pdya5cqba5c6acuzvcevhkbhqwosnh4kfui2xpbytsffv6t4@ay3smhgg6ztp>
References: <20241213155557.105419-1-axboe@kernel.dk>
 <20241213155557.105419-3-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213155557.105419-3-axboe@kernel.dk>

On Fri, Dec 13, 2024 at 08:55:16AM -0700, Jens Axboe wrote:
> Rather than use the page_cache_sync_readahead() helper, define our own
> ractl and use page_cache_sync_ra() directly. In preparation for needing
> to modify ractl inside filemap_get_pages().
> 
> No functional changes in this patch.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


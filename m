Return-Path: <linux-fsdevel+bounces-37941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BD69F9519
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 16:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8E60188B5C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 15:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7718218ADF;
	Fri, 20 Dec 2024 15:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="H3mh90PZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wJMDdXRq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED98218AB8;
	Fri, 20 Dec 2024 15:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734707523; cv=none; b=Nrj6sF1ovwDDoTPE86xGFUXWHPpuQtTF1T1qyXuNyhFZll2Qb2GtAsMxZkz8EX4clE57e+4XPR8gmx1fzHsOK4iYI1Fgy5sTcSHtYriI/wct7LZ/E09yu8Tc0OuNyyIvhHLJct8AuWB/34lCOFVP1Q/5rdp+FAsoCDkILJsPEcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734707523; c=relaxed/simple;
	bh=+AK1kDjDU1BNVh5M/h0JCmsj6l3eg1fbTV7CxG7/MoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3HnprrWqNAmrm4fwrccoYD/pOQfqNsyNWoe1rH/B/qKSfkMjW477mA3cAp5vlveyQ+xP8Y0Lv5fzK+Wxvyxp05A77ME9AsaL8VJ8+iOE1JpBGjP/hwQxmaPiaxuN+xLcR+s3G/6zUkKKjLtg+NlNxzv0fepsj3UrMjocRy6fIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=H3mh90PZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wJMDdXRq; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 7A0EA11400BD;
	Fri, 20 Dec 2024 10:12:00 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 20 Dec 2024 10:12:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1734707520; x=
	1734793920; bh=TPofL9HELSU37A75YREq16eJdd6AiIkVeEKwGxzWFQs=; b=H
	3mh90PZQeZegF2Dy6wcIMrtCSsvZPyIIuQ4lk67k5pjVImodl9E1mJhnjRKZZe6c
	IEkqYUVGsVsfUpWVBl1LXiLV/TcQpNDmMZNcRgdHb37poaU8nl+uhVAyNrAE2rg8
	scCskE+86yJjcgw12NEoE1wMv7PlE7LkpjBzKboucJGcHY21JJZ4kAG4Uo5Pca2G
	bn+1HU9uger3VRZZekJOgMALmgsQwJXhmhIl/8ypLO2ExAViGWVrg/dBas/7+R+J
	EHj3RXd0EUrtPNKNA/ZRzlIQeE7HlubLw4pUNw0/61eprT1JbKWV2nl3NKOMUyqt
	AJZYe371ICIFp55Ejbfgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734707520; x=1734793920; bh=TPofL9HELSU37A75YREq16eJdd6AiIkVeEK
	wGxzWFQs=; b=wJMDdXRqN6QJyw3L/TWM+hBR+tX11eEaiO5YPfawMIsqkk9UD0k
	FU7HUgirHDfgPwZr1dqay8aClvvcgbTL7kS1RSjnRES6LZPHEToI02i2HMrs+uUU
	1frqqmVhvsw35pSXT6+5RMaPMvSCwrQuXi61dtjkyHamF9c/B9Ltk64E2vME2yYT
	JNMIujwbEzf/rGqGRK8acXSTcZw99QPBugPYWOB9EK4OBwCfTGEmbKinM1KTERDm
	1jAeMQhapQkfz2BMQfo+AOOehsBVV9WN/VVi8jnnXllCCHjdq46SbYz0PPi7zPv1
	PrKUk53ke8MtcO3e/hHvK9J4pthUgDo6W/w==
X-ME-Sender: <xms:P4llZz2ntsxdffOzJfOpymx2kcKVdbmX5B1-iGV6cKx8BOPiqZtnxg>
    <xme:P4llZyEfOJ4aVMbABxSowFI_Tln54PfRUWz0ld6FBjzB9RytnQlMc-bEQ-fGIJ5Ij
    p_3N0Z_joJZkXjIhTw>
X-ME-Received: <xmr:P4llZz4_qRGEa95d6hBgGwYkS3kewuHmZ44n0q9ObHMXIrt7kxaDEEgk5XRdJFFT0P-T9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvden
    ucfhrhhomhepfdfmihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlse
    hshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeffvdevueetudfhhfff
    veelhfetfeevveekleevjeduudevvdduvdelteduvefhkeenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhv
    rdhnrghmvgdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopeifihhllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheprgigsgho
    vgeskhgvrhhnvghlrdgukhdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdroh
    hrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohephhgrnhhnvghssegtmhhpgigthhhgrdhorhhgpdhrtghpth
    htoheptghlmhesmhgvthgrrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghl
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghfohhsthgvrhesrhgvug
    hhrghtrdgtohhmpdhrtghpthhtohepuggrvhhiugesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:P4llZ40N7emGsY3S8AueObDAUXA5gToqysavl6Mus4eHMy4TfA3LpA>
    <xmx:P4llZ2E3W5Sgtfmkdzh4V1rDt9HMot-507Ob0M6EMwC1OjlwYZF0qw>
    <xmx:P4llZ59W6soRB-r9mUo2yXqbAvmbremi5WXXKnX847UbcStXU7_7xA>
    <xmx:P4llZzlNyx5BVzlqj8WyGAfw1mzMGsNqR7MJ3L5cinkjyJeta600tw>
    <xmx:QIllZ-9j8mny4W5lBw91QEi7Ixzp8hnSN4ZUS_9KexvBF-Ib8wzZzOoz>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 10:11:56 -0500 (EST)
Date: Fri, 20 Dec 2024 17:11:52 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, clm@meta.com, linux-kernel@vger.kernel.org, 
	bfoster@redhat.com, David Hildenbrand <david@redhat.com>, 
	Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 04/11] mm: add PG_dropbehind folio flag
Message-ID: <hyxlz2qomigaffzblpkcn6ds4ocnm6gi53lnxoy2d76j4nnlep@3gptla54rdou>
References: <20241213155557.105419-1-axboe@kernel.dk>
 <20241213155557.105419-5-axboe@kernel.dk>
 <wi3n3k26uizgm3hhbz4qxi6k342e5gxprtvqpzdqftekutfy65@3usaz63baobt>
 <Z2WBUX2OKLinNuFZ@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2WBUX2OKLinNuFZ@casper.infradead.org>

On Fri, Dec 20, 2024 at 02:38:09PM +0000, Matthew Wilcox wrote:
> On Fri, Dec 20, 2024 at 01:08:39PM +0200, Kirill A. Shutemov wrote:
> > On Fri, Dec 13, 2024 at 08:55:18AM -0700, Jens Axboe wrote:
> > > Add a folio flag that file IO can use to indicate that the cached IO
> > > being done should be dropped from the page cache upon completion.
> > > 
> > > Signed-off-by: Jens Axboe <axboe@kernel.dk>
> > 
> > Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > 
> > + David, Vlastimil.
> > 
> > I think we should consider converting existing folio_set_reclaim() /
> > SetPageReclaim() users to the new flag. From a quick scan, all of them
> > would benefit from dropping the page after writeback is complete instead
> > of leaving the folio on the LRU.
> 
> Ooh, that would be nice.  Removes the overloading of PG_reclaim with
> PG_readahead, right?

Yep.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


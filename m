Return-Path: <linux-fsdevel+bounces-37920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1179F90D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 12:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56C31167806
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 11:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F6C1C54A7;
	Fri, 20 Dec 2024 11:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="Kwot/jsE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WXa5Ukon"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074EA1C3038;
	Fri, 20 Dec 2024 11:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734692408; cv=none; b=fTVRs0fr4wsdBgSQk3f+1s1BbL5Eo6Aqho5+8H9eywGhX5wuBS8j/sQsXQY6kPXXVio1g4vlwC2/wDup0ZlUnHFjJjlrIzCtfgI/E4Kfb54pvFBYknHnvTlAvHTSUDii90fydAGWanQ64Gdj2TO4bJGENwwuSKvvWJAWrSA8FGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734692408; c=relaxed/simple;
	bh=hyQFEvZqT0gVwikdO/VVwoH+k3Ld5S1aQnx5SJb7S40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z119hIlSFMvovrfK7d7hMdvqpVPrCcHpLRVYtfsSRs2yWwzddAFL7AaHPpJNqMPnAFZE3YFuj3lbKPHuArHKLCpKzvpWz218SpTcTKdYnSfjnI6WHxBW4+A5f40rKjWpoU/4ThFg+hHQNP42i91MzSL/PaFB6TfhMLZrU8+XYWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=Kwot/jsE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WXa5Ukon; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DF8D811400D4;
	Fri, 20 Dec 2024 06:00:05 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 20 Dec 2024 06:00:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1734692405; x=
	1734778805; bh=ko6LR9Ga4DXB+RQqzBAg0bvL3abH+Spg9iRhRGKtbCg=; b=K
	wot/jsE5LJTzrk1ImWG56g20h9ysFknK2zxUWklpmO28AWLQ7kmB5QUnc/iy4fTt
	+S5QTCUMXo/uUZWaX3ArkG6Rj5F4laTrOnjLfXmNs+acm6g4CDYqJWs9V2LQX48p
	xXTcKhzKB63i9P8VZyPljKUQZ93ujLJdZg8QkSLjtWt8JxDST5EOwtqU7y5LZNFy
	66gza7CTCK76IfKLFLRpQP9Z00O9dctPoev1cZ30H/ZOYKsZkfEhBI7O3SLZx1XH
	OEzEzmsnnMspW6qbFRtQ8BNgeeQRuo2b7s1dIH3/U5INbYiSLkb/GR0aRfiMZAzg
	Uk3KL8IuTN35aoviTbMtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734692405; x=1734778805; bh=ko6LR9Ga4DXB+RQqzBAg0bvL3abH+Spg9iR
	hRGKtbCg=; b=WXa5Ukonm7boTfviNx8YwUXU2l08BffDsYHd6v/QVuJsXBOFKW7
	Vc5Nk5rH5u/C6iI3/n3qNn+DXrEH4MIpFo1ekntu6K1aAprrBPD388SSelT9g/c6
	byPq/j9C9L8DYIgE4kYXxfXu5s0cEswTrgDU2CFJcOsKgN85jVws0bLI+zwRUdaR
	SmNoV+ljt1cqyYe92w5lTvFiIwgldu1sc4tNXFsAmetpzTNzVztVhx26/zK2kvls
	4FEmJqVUHlnoLbg8Rx4caEfrW17tPK8fYO0KivhXs5t1EpfFxj3UL7qJwy8Bi9Vj
	uoiaWnGTH3LeXTeY42R7RewxJ8/EIhf/+Eg==
X-ME-Sender: <xms:NU5lZ1Xc3xwWlWmsYsnQvKOPewRVnHg6nBlKJ4V9vmLRV5gmQzO4qQ>
    <xme:NU5lZ1lKl4cWUd-XpGvQVvgaY1t5NKGcV1-x7jJ-4aYtNJZ1__wjpRx_wzTwYoHG9
    S9Jrz3SQ4b0R8egQFo>
X-ME-Received: <xmr:NU5lZxb2olc8iV8S7C8ZOrm4Mc2CrOneAWeSey0hTM9YKauhgJzhv9Kk5x7abiz9YtCN3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddgvdduucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:NU5lZ4X3pe6SVVNF1696F0Uu3Ji2qPwD1OfRvcxQz7u10XHvD2RABg>
    <xmx:NU5lZ_ml63kB-anHxWbczGTdD30xdyBoIcemhQce4EAI08k5FIAdvg>
    <xmx:NU5lZ1f95RB6koHZvn9XGCbPlFUGDtcQFfze-kfAZCZ-QEt1UceIyw>
    <xmx:NU5lZ5GZWkSmmpLqRff2l_qvIgYVmfDyrlWeyA3l57x_OvrPOaCIow>
    <xmx:NU5lZx6Q83_NkpkChKWOzD3x5UoD8Aac0EIxiO1-NCKLeqwbh8t9l3Sn>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 06:00:01 -0500 (EST)
Date: Fri, 20 Dec 2024 12:59:58 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, 
	clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org, 
	bfoster@redhat.com
Subject: Re: [PATCH 03/11] mm/readahead: add folio allocation helper
Message-ID: <3ehi4yvdnvzqmbij5u4wziqmyuqud4vj25cy2qkwl4yj5fz2sk@4pgcndonckzn>
References: <20241213155557.105419-1-axboe@kernel.dk>
 <20241213155557.105419-4-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213155557.105419-4-axboe@kernel.dk>

On Fri, Dec 13, 2024 at 08:55:17AM -0700, Jens Axboe wrote:
> Just a wrapper around filemap_alloc_folio() for now, but add it in
> preparation for modifying the folio based on the 'ractl' being passed
> in.
> 
> No functional changes in this patch.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


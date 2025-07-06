Return-Path: <linux-fsdevel+bounces-54027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D74AFA3AB
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jul 2025 10:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E02B7A27BC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jul 2025 08:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DD21D5CE0;
	Sun,  6 Jul 2025 08:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="UmS58mOU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mvPlRr+R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AD514386D;
	Sun,  6 Jul 2025 08:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751790551; cv=none; b=tMCJeiv1z8BzSu7RUpUz4HKvlPXXz8SugHpBq3N0hhWALLwM/vtUr4J1Hv4PZNR5DAGhYHFynH4trCjF3zlEkug2FwTM/BAr33HeEkkZTWDycXPoiNFdIvZ005dyn1ujzbyG4vvd6687cb5j3HySuWFT8d6JX3GTFImvGEuCVvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751790551; c=relaxed/simple;
	bh=X204WyJpXGJE8pcg02RS6uMl/7b6/IB2aPkZ6MPIwSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esQOTIHjaHNVuOG7SSQw+VP+TCwTGRJKzz6OqMs0e4hzdjkkLQAYLO9wIEqc7/TIyfmyDnqHDbXwGe/S/ZBhY97U0XGS6p3m8h4DSXDtaITOInN3DC2u/dAJ7Ori0EVsV7hqXoygFarR7nVJN8De/4taj6OM60ZqQtO9xKZzhCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=UmS58mOU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mvPlRr+R; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id BAB9C1D00241;
	Sun,  6 Jul 2025 04:29:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 06 Jul 2025 04:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1751790547;
	 x=1751876947; bh=AleHfUjihkJKz/UBvekuq0kDimlhUhmI5K7F26DJ5Qc=; b=
	UmS58mOUpr4TqTiC47XKB9WBXhZg7pvgAkfYrTCzJa0AXKXAyXH2qsoDxyhSNjGw
	TO4kNDzXvwEtv6L4gwBljepPS0fPzP/vg2UfxphXA3EMNv+w8M/EIzjNxPVhCSt7
	j6os2b7otepCCtg8rAYW3XpeixE/GdybZ/Nh5XHvPA+YDcg5svkwIS7SEP7BZ49u
	VQ1QdIoq9Gu/z11tK60AkltLENvLtXIiuXg+LhGZTARPDGmHwg7SXmX8YawE0GUv
	xzChn2Xz5PleGzI/8bpzFx1N7kQNpregnXfcDXFyp7ZgmA692zAn2j4asJZu4DAk
	Niq5LDqaPLHSwKk6IOEIBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751790547; x=
	1751876947; bh=AleHfUjihkJKz/UBvekuq0kDimlhUhmI5K7F26DJ5Qc=; b=m
	vPlRr+RUWK7Hk8c5FinYxV9Hk63QqIScOpNS2zosSGZycSdOpAkUquNfPs7gNgVj
	JHxzsUbi42WDorrWkMPu19v3sP6SixNZax8RtyOFJFB0SDE+klQCVJVH7NbPynRp
	1QHpxpyyb72xjR/QS7SWTl1+isL40xLQd0cch+LPxlZl71W4dL80vLDd86Hl7YG9
	0pTgBIYwMQxm3eSIH6geAwyAzFKg7uG5RTzbQE96XUtIddrPUzu+Fg0MBdb0FUUJ
	isCDIJ3gHCRYBwzldQpvExHwSj2VcyQJj8lyLhIHZ4pNTGovXAQfbWszP6eIJc9t
	I+GYGCa/HkH/LFjLEmmgA==
X-ME-Sender: <xms:0jNqaKFELhcDIL94s7J2JkEJRpQ7EEGTSEEhva-FyBNH7sUC6M6LBA>
    <xme:0jNqaLX6vZovBLcLKxZhu-qpklsHuV7rSM26StKiPhcR6a6mvL_CPrElXY3fLQEd4
    Pi70XgmhEXK5ZEMUFM>
X-ME-Received: <xmr:0jNqaEK1Xp7Lpj_5Rmm4gGp5BTXhiEzKHq8vSbSs8dEEYrmGHzA4XP-ySClmLZrkDMbwLERyrTRLJChxBRTZwwGOVZfizNV_j0k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvkeeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheplfgrnhhnvgcu
    ifhruhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrhhnpeevfe
    ekuedutedtvdffvefhvedvkefhgfevheefhfffheeftefgteffuefgveefhfenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjsehjrghnnhgruh
    drnhgvthdpnhgspghrtghpthhtohepudelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmihhguhgvlhdrohhjvggurgdrshgrnhguohhnihhssehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepthgrmhhirhgusehgmhgrihhlrdgtohhmpdhrtghpthhtoheprgdrhhhi
    nhgusghorhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhes
    phhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtoheplhhoshhsihhnsehkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:0zNqaEHl5x5GZzeiP-lkezzO9vIeOgNZeK4XlXPuaduT13rAi2Td0A>
    <xmx:0zNqaAXH5HIFqo_nJnrJq0uctLseIFKbY5n0n9YvkCnRFwh-D93hDA>
    <xmx:0zNqaHPXucWx3H_i9bdlnKup1MfPzWONLXltrpnAeaxfDQYcma1H0Q>
    <xmx:0zNqaH2fU_LuhBcOMQrsfLy3ez917N95wPrjGAZWivND0mAQG_t_gg>
    <xmx:0zNqaEdJL74sOBC4AI8aI1s_A3l3G0EWkMpQilbyUbtHg6ELWqEv8Pbb>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Jul 2025 04:29:06 -0400 (EDT)
Date: Sun, 6 Jul 2025 10:29:04 +0200
From: Janne Grunau <j@jannau.net>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Tamir Duberstein <tamird@gmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	Daniel Almeida <daniel.almeida@collabora.com>
Subject: Re: [PATCH 3/3] rust: xarray: add `insert` and `reserve`
Message-ID: <20250706082904.GB1546990@robin.jannau.net>
References: <20250701-xarray-insert-reserve-v1-0-25df2b0d706a@gmail.com>
 <20250701-xarray-insert-reserve-v1-3-25df2b0d706a@gmail.com>
 <CANiq72nf-h86GszE3=mLpWHi5Db+Tj0TRyUe9ANfjdNbesBEEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72nf-h86GszE3=mLpWHi5Db+Tj0TRyUe9ANfjdNbesBEEg@mail.gmail.com>

On Tue, Jul 01, 2025 at 06:56:17PM +0200, Miguel Ojeda wrote:
> On Tue, Jul 1, 2025 at 6:27 PM Tamir Duberstein <tamird@gmail.com> wrote:
> >
> > Add `Guard::{insert,reserve}` and `Guard::{insert,reserve}_limit`, which
> > are akin to `__xa_{alloc,insert}` in C.
> 
> Who will be using this? i.e. we need to justify adding code, typically
> by mentioning the users.

xa_alloc() / reserve() is used by asahi. It's still using our own
abstraction but I'm in the progress of rebase onto the upstream xarray
abstractions from v6.16-rc1. Once I'm done I'll reply with "Tested-by:".

Janne


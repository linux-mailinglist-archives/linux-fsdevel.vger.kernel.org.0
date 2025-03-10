Return-Path: <linux-fsdevel+bounces-43560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA07A589B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 01:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0454188B38B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 00:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDE538DDB;
	Mon, 10 Mar 2025 00:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="iQrLoISe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="6t0jUuUt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB87FEC5;
	Mon, 10 Mar 2025 00:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741567148; cv=none; b=iR3ucXOsLCNUbkSalAQvJn3VwTl7oDOBfGHln+eslhs6YO5zmdshLO5gR8YZkidGHCN8UfFmZZHO7aw4r7YGfiD4JM1kvb1BeDCML7YAHjFg/9THwU/LORiK6BXoY6+AvFupXtY9wi59z+V+2bOXWL5HITE+vUsIXbGb7LnOno4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741567148; c=relaxed/simple;
	bh=sSW+LXcCthYkoQB19ymXzEG+2XDygu3OBc6JsV6iAoc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=esq+q2F9KAmI698+feLZCxDsIS6SYveqJGCu691wCfvjcAD2Ys7cHerPptJIPQYFmAGSNSZpkPAxUYt5HM6ELaEdn47t27v3pzrjRhkViBLi7FR2hDlJPAaur4uFEAxDr8MFL5dtmgWqKQdiqXyxwlY+HuX5zhPycmvYnn7W95Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=iQrLoISe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=6t0jUuUt; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailflow.phl.internal (Postfix) with ESMTP id 0737F2014BD;
	Sun,  9 Mar 2025 20:39:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Sun, 09 Mar 2025 20:39:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741567146;
	 x=1741570746; bh=dYbp7qSmH/5rVUovQSDVgC5yx0+PE1mLxo8KeIhVi8U=; b=
	iQrLoISeQadWpuf8kd82dyArslICh4hs8c0Ig8NgI5MVI4d5Ef0bDzLJxadOWxed
	AFsuDP99PEyaem/T+mgX9faS2e9w3My52lubatxy6VHZ0VVwqsfbniyGYyed2soq
	pPPnBUMu6amBVpIu5XT6AgIJhwIKwCnklf3Mu5bzui2WKmKMC5YWvHe58k+rxrpE
	90n84wfLlUq926YvJVuTZ1AzMs3yq9+co4AB6662Z/6xWmJDdtvJua0ebpjfSAK1
	efPUkQNhZJWfleCZGPXDMkMreWlkLCAuh0Nhg/1dBRXnZxvMgzNGo5mSNJhwflzb
	Ophu24OdPQjVgENThogfYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741567146; x=
	1741570746; bh=dYbp7qSmH/5rVUovQSDVgC5yx0+PE1mLxo8KeIhVi8U=; b=6
	t0jUuUt1NhFh5HcB37CLl7uqE07g8Xgow81Nvht6gObhmWAvBifusCKmCM6qrt7U
	AKnXoMt3kxeh+YrxKTZKZHTYMnl/b6V6OjbissiGDMsrnB/4FT2bUqp9IEboNTY7
	GPYB3E/SwWMPQScO3oD0e9qwKoqIfogOZ4yPLIoKpMwNsbb79dx2MFCegaIje+Sp
	XiueQ5MpxqKBj/CCGmEfjIPzWWE5plrxy8EHdiZ+FUu4G1ZC7L4kS6DnulHpRw2K
	lzBmSX4AT4O9KRpVkdAxkmNjCRp9wQCFjdxp+ZQ/1i/xvoPo0iY6GPnvBeKQVAJY
	qBvRyVnojM/dBdCSE6Pvw==
X-ME-Sender: <xms:qTTOZwGFed8__Pw4yWubQh9yaQhjfDzZMzPV05c8TSpK-I15IE1n2w>
    <xme:qTTOZ5WjHhd-P7rcp0P4v0lSe4f6q16Ja67xnrffWU1UwX4Wd8xQV5ZyAtI6tEDZI
    WrcJGwSKQFayw4SieI>
X-ME-Received: <xmr:qTTOZ6Lcv1l6sqTuBGQCMl8S7kYRa5OsOySdLa84LPmKWi3blGIt-8_CMiDYAu1Y5rNx9oZvgLZVodb_9Z2d7LEwxfQ0DdcK3o9FDFrJHM8hiVppdfGCojMMkCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudejledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfhffuvfevfhgjtgfgsehtkeertddt
    vdejnecuhfhrohhmpefvihhnghhmrghoucghrghnghcuoehmsehmrghofihtmhdrohhrgh
    eqnecuggftrfgrthhtvghrnhepvdegudeugfdujefgtdetffdujeejleeliedukeeujedu
    heetgffhgedvteevffeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgtphhtthhopeekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehmihgtseguihhgihhkohgurdhnvghtpdhrtg
    hpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehjrggtkhes
    shhushgvrdgtiidprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulh
    gvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghmihhrjeefihhlsehg
    mhgrihhlrdgtohhmpdhrtghpthhtoheprhgvphhnohhpsehgohhoghhlvgdrtghomhdprh
    gtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:qTTOZyHpJb2w_o5-GkM6g38Rzo8XUAwrkk0HYpEpJbEntxg-gT-3Ow>
    <xmx:qTTOZ2WtR11NCWSQ-Yx_XymfDSQvQQn5chYicqwcCDRuBkeUUEzXbg>
    <xmx:qTTOZ1MuUA150JnlVllSAaN3bgIuJhcWrusHvyW5bjmdRjx0g81jQA>
    <xmx:qTTOZ93c49VXpv1muIypOZCCX47ffQNucO3Nhlq_cAQnWeoFlhqidA>
    <xmx:qTTOZ4fgezLKT2Rutxr8ZLWTW-ZW6XgJGa1K0UJsiGMUlAD9OQ5gAEdH>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Mar 2025 20:39:04 -0400 (EDT)
Message-ID: <543c242b-0850-4398-804c-961470275c9e@maowtm.org>
Date: Mon, 10 Mar 2025 00:39:04 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tingmao Wang <m@maowtm.org>
Subject: Re: [RFC PATCH 5/9] Define user structure for events and responses.
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org,
 Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>,
 linux-fsdevel@vger.kernel.org, Tycho Andersen <tycho@tycho.pizza>
References: <cover.1741047969.git.m@maowtm.org>
 <cde6bbf0b52710b33170f2787fdcb11538e40813.1741047969.git.m@maowtm.org>
 <20250304.eichiDu9iu4r@digikod.net>
 <fbb8e557-0b63-4bbe-b8ac-3f7ba2983146@maowtm.org>
Content-Language: en-US
In-Reply-To: <fbb8e557-0b63-4bbe-b8ac-3f7ba2983146@maowtm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/6/25 03:05, Tingmao Wang wrote:
[...]
> This is also motivated by the potential UX I'm thinking of. For example, 
> if a newly installed application tries to create ~/.app-name, it will be 
> much more reassuring and convenient to the user if we can show something 
> like
> 
>      [program] wants to mkdir ~/.app-name. Allow this and future
>      access to the new directory?
> 
> rather than just "[program] wants to mkdir under ~". (The "Allow this 
> and future access to the new directory" bit is made possible by the 
> supervisor knowing the name of the file/directory being created, and can 
> remember them / write them out to a persistent profile etc)

Another significant motivation, which I forgot to mention, is to 
auto-grant access to newly created files/sockets etc under things like 
/tmp, $XDG_RUNTIME_DIR, or ~/Downloads.

> [...]


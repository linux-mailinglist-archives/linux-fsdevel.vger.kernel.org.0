Return-Path: <linux-fsdevel+bounces-38284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 872589FEBAB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2024 00:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F22E161B86
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 23:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2375319D8B7;
	Mon, 30 Dec 2024 23:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="R6o9lKEh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tY5JfJyr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24100199EB0
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Dec 2024 23:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735602114; cv=none; b=TxNgTNWoVis56E8r/zsk+pYKmRX0siWR+zu2qoHmCNAL63vMYmmWUaTBqh5FE3KiV3yRV0YxRMS+UGxbaipgyHrJXSh9r/1anOIla8f5mFi25hnp3qfKaRhi3sngiZpZ84j+qM9UaoRY8F/N89gC3KQiy1uukuURZ36a0obYPjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735602114; c=relaxed/simple;
	bh=jWlDGLlEbWY3xUTCtT7sjGNgiI+Qr5J+G+KXQeWc3iY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hoFCx0+gdkPwzpoJgDJZPik6w+Hs6xu2thYlTFPXoVPKxbw9caBeXUizOffc9+wA5GeB6vWQb35FIAxeV/E5/hGt5hG3nhJZAjZbtGKbHksMgAXyFKVbLJJ0qHF3ghACdSoblDyf10i757c7EnIUxtvUM/DZnsSTQkcjgtWxTrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=R6o9lKEh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tY5JfJyr; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E3021114021F;
	Mon, 30 Dec 2024 18:41:49 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 30 Dec 2024 18:41:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1735602109;
	 x=1735688509; bh=pCffspHBKQVNZ2+ei8s6+TRqIDmrmuo0axMdqCNSXpI=; b=
	R6o9lKEhvRoUCuWnVNYrW7OzeS36MzJ6VEGHxoMcVzvzt4vcKzgOvpkuPHzj6aVx
	WwQdHBdJ0trdtG36PuYPrgrrtmjLpHYgX386pu/AJWACCrtkaFQ8AAOviojADvjA
	UPJ5VnbAajt2XXoE53FhVHxyYKIz9HpfJ2Wn3td4RG3es7RWcG9J2HCmbznuY8jM
	sBRh7Ci4hhLbszdYBpMs5YUXkvhKHjhgVVVPcu53SxkdAWzrtlIPweGikdjI4xpY
	YMFKsMrfZpQooiarIJZHfNdpwkHPq36wV8KCHnoPNiUME4aycgXdoKEsJHXRkb/q
	gxH4H1ZNef5vqqw/R5vOQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735602109; x=
	1735688509; bh=pCffspHBKQVNZ2+ei8s6+TRqIDmrmuo0axMdqCNSXpI=; b=t
	Y5JfJyrYbU0e4a5i1xCVd9xU+ufvsC+Fkd11H1HizP47E5H+6dmvPWDCbXrrxfa+
	qOZuj8f/8FtGxsQmQm6VX1DVLSJuPgZlLaDkFfoFS2S7JS6BNQSR4GbVMhsynHZt
	mkV26jFI536H71JhAXbtc+LBOWyX3EUwM05PKg6OP+qyhbgA0JK2oDOaHErBYJcO
	g6w8kHpxbU/CDN8ky2aN0iM5sqU8pieKoRFbUUbBj8AWHKQFUfiYpNh9wKLbhlAB
	/g96FDNF2ufRZgiOhxP15QZvBBUYb0Fr0fxdGSwNlm6A8VEwHdg4FeGD5RWTx8Pr
	V4JwXDL1d0IqOTebkI04Q==
X-ME-Sender: <xms:vS9zZwGOV0fFr2Mv6_os6lUpicuDQQvZOETiuH777JhspXD72ku9Vw>
    <xme:vS9zZ5V4vhgXGWrF9I6kJogouP_Yo8oTKFuEQ7KhL4AdJ5LwndkXzgufeJYIJSFWK
    7f-nr-KJ80dSlOo>
X-ME-Received: <xmr:vS9zZ6KNKwDitCywOwOxd52LNE2AGG83CQicwvDe164NU9UNOq_dA2e8Z8mq0FiUIhPr4AqbbGPGYtrGzr_q5mXLboVPXHZOgzh6Q3FgMrNhBreRbQFb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvjedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdej
    necuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnh
    gurdgtohhmqeenucggtffrrghtthgvrhhnpeeugfevvdeggeeutdelgffgiefgffejheff
    kedtieduffehledvfeevgeejhedtjeenucffohhmrghinhepghhithhhuhgsrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhn
    ugessghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepphhrihhntggvrhesghhoohhglhgvrdgtohhmpdhrtghpthht
    oheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopegthhgrrhhithhhtgesghhoohhglhgvrdgtohhmpdhrtghpthhtohepmhhpihhs
    vgesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrd
    gtohhm
X-ME-Proxy: <xmx:vS9zZyFGBoaMY10t29puAV2IEK8z2Kmnxo64ct8ZBCVb7sVmNMMXmg>
    <xmx:vS9zZ2VGXTRSmPnPWAoUJolas6rpdT8mTok6U8ZzuOpmasjKsUgcUQ>
    <xmx:vS9zZ1NT-BTlGpjsTzWwuS9uqfzvuLQ2AmNe1TatDFZorU9uVP7HEQ>
    <xmx:vS9zZ92duUVJfI7_bRhGqfirZK3iT0VURTi7cHuaAUX55_eBCVQ6GQ>
    <xmx:vS9zZ4et_UhzfIviElBWy8hWtDsDtNG4hLP8z78NKDqvov_VJNKYfQx->
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Dec 2024 18:41:48 -0500 (EST)
Message-ID: <3d7e9844-6f6e-493a-a93a-4d2407378395@bsbernd.com>
Date: Tue, 31 Dec 2024 00:41:47 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fuse: directory cache eviction stopped working in the linux 6.9.X
 and onwards
To: Prince Kumar <princer@google.com>, linux-fsdevel@vger.kernel.org
Cc: Charith Chowdary <charithc@google.com>, Mayuresh Pise <mpise@google.com>,
 Amir Goldstein <amir73il@gmail.com>
References: <CAEW=TRr7CYb4LtsvQPLj-zx5Y+EYBmGfM24SuzwyDoGVNoKm7w@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAEW=TRr7CYb4LtsvQPLj-zx5Y+EYBmGfM24SuzwyDoGVNoKm7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/30/24 05:41, Prince Kumar wrote:
> Hello Team,
> 
> I see a regression in the fuse-filesystem for the linux version 6.9.X
> and onwards, where the FOPEN_KEEP_CACHE flag is not working as
> intended. Just for background, I referred to this linux commit
> (https://github.com/torvalds/linux/commit/6433b8998a21dc597002731c4ceb4144e856edc4)
> to implement directory listing cache in jacobsa/fuse
> (https://github.com/jacobsa/fuse/pull/162).
> 
> Ideally, the kernel directory cache should be evicted if the
> user-daemon doesn't set FOPEN_KEEP_CACHE bit as part of the OpenDir
> response, but it's not getting evicted in the linux version 6.9.X and
> onwards.
> 
> Could you please help me in resolving this?

I think 6.9 added passthrough support. Are you using that? Also, 
FOPEN_CACHE_DIR is default when there is no fuse-server open method
defined - does your implementation have an open/dir_open?

I think the only user of FOPEN_CACHE_DIR is in fs/fuse/readdir.c and
that always checks if it is set - either the flag gets set or does not
come into role at all, because passthrough is used? 


Thanks,
Bernd


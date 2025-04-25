Return-Path: <linux-fsdevel+bounces-47408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D23A9D0EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 20:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FB9A7B8C06
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 18:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4422185BD;
	Fri, 25 Apr 2025 18:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="IuuDwWDQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ziip83B4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE04E20E330
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 18:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745607476; cv=none; b=DDkRAsiPn7lKYKbcQqXspEC06GspE+iYkAV/N71C/dlPghlTomKOf4H7fau6+E936DgKW2et1zmvDKdRUTHrNKuMTIttWyGhVG6dZuSWFa7a7eJAbdhHDJadktk0B66FxowsLRZBYIYFIhF1E1KvwwMUD5kQSMNjc2wO/lP8M8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745607476; c=relaxed/simple;
	bh=7Ydc6MpOP4gKWfYKRDrAXd6FG/8pZ36e+pYisklHy60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rMjWIknpGvEm0JS4REwxXsvLy5SioDWWdfacJrtSyc42x8XR0tQpjEcqZ+sDh+6svYZc/95WfDz6KDVLc/tKlE5pejgFzpFGyCpR3lT3+TaVB3BjWaRuWMglmrzgEOor8QxnlfFUBLtU5zqxJcnigcCPelZTo8mqFfpQatbVOAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=IuuDwWDQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ziip83B4; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id D02561140204;
	Fri, 25 Apr 2025 14:57:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 25 Apr 2025 14:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745607471;
	 x=1745693871; bh=O+PYF78DRRH+oFjpzptA6tKD8oEKGCjGoZrccpZCJDA=; b=
	IuuDwWDQd2HrP78Nq/OHaj6Zi9DWStbrUwTTBgmvAWxWrwT5l/WCShYxmz53nvo1
	oJ0fJoNn9GVwSkSIqoTQ92zcqnSn5tt1kHEF/DJ6iZ48QxYXTMnAYNqu97D8s9Hf
	a+FpKw/HyEs/n949i+pkJ41POyOK1ZulAGjxcami8jIxXRXWATJniA4Xr/dq5t6O
	lpXoTt5g2Ijl3SEqcOar1H6dgAcpJ6EZ0eVBvuctofKlBVhj9qxViii10wIOU3QD
	ovApJR9UicHdfPfiU6dryy7T0qZyrxfmgq5eGJWKhnNaEvz90gPlp7KrMMQkfIKX
	nQvOPhRd3ZuQE3MZkdOK/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745607471; x=
	1745693871; bh=O+PYF78DRRH+oFjpzptA6tKD8oEKGCjGoZrccpZCJDA=; b=Z
	iip83B4KuVIP9bGPIQ/mgSRQerR9gkyXIcD2F0d9TJMKN1LnJhA4EgTXkGwa+BuM
	zZ07OOJR5qI8SnLtB8pDzO/zxs/iBTMr32Q9sf8g/cMy2W+KMguTKqnYfH4g/Zc6
	PUoydwhxhTMYe7g6AKWjHXjACYdRx6fu6CqflvpDr58cDjAAlVYRC+3X4a5oPZV5
	aL6JXfzeyV3rw8ulFqBYK0Z4PamXlUFUvMmuQBFf0+2RpkFERDGxj5uKgo/i2uLu
	1WSv1BQLZUS0o7cP8hBl6uN837Oeu2HAEiy3Mgwbk1lE+TYFN8HycEaRQmbGuwHZ
	H59k8+YVEunB7P8Bv7NBA==
X-ME-Sender: <xms:L9sLaD9UlZiPfLad6yKaBvDo9Vs5PMbNp_IjhoZ6vz7Vd4OXZ8A4Kg>
    <xme:L9sLaPuUT7WgT8zqogj7vjUwTq-RT4xEurMWQeuqNWEIS-x-zJH9YKerxO5gMTPg4
    HXB_dTfoYREy4lIMWk>
X-ME-Received: <xmr:L9sLaBBJgKuq20Afd3_0fTGp6r3KTETPmE3FZ-4xb8KvatRuDxq06Vi6auzDzOlcNONrFT-ViXn8LpxL19weWCo3HeKbCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheefuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddt
    vdejnecuhfhrohhmpefgrhhitgcuufgrnhguvggvnhcuoehsrghnuggvvghnsehsrghnug
    gvvghnrdhnvghtqeenucggtffrrghtthgvrhhnpeevieekueetfeeujedtheeffedvgeff
    iedvjeejleffhfeggeejuedtjeeulefhvdenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehsrghnuggvvghnsehsrghnuggvvghnrdhnvghtpdhn
    sggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehprhgvih
    gthhhlsehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghl
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsegsohgstghophgvlh
    grnhgurdgtohhmpdhrtghpthhtohepshgrnhguvggvnhesrhgvughhrghtrdgtohhmpdhr
    tghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:L9sLaPfn5sa001pcsPcZ_of8q2xFd2JBhUl84S4AWa_-d9fFBwdbng>
    <xmx:L9sLaINysGqxzWOep4oZjXratE9xhfT4oOb-zBA9-SkydtPZTzb4QA>
    <xmx:L9sLaBkQrZ9_AC7iTwwzFz8QN_cZ6yeov24Mgc8BCpm-RfKn7JGf2g>
    <xmx:L9sLaCviz3DjK0MpV-sTyb7GJwEgMbDjT93nzP3yRwG2amdBcQ14AQ>
    <xmx:L9sLaONIjkzxqjmYH1vjMUQ2O7DEWS2LyPdffIpSWhTv7UK4aJ5BowTV>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 14:57:50 -0400 (EDT)
Message-ID: <a401ee68-0177-4022-8df7-35e8c52b450d@sandeen.net>
Date: Fri, 25 Apr 2025 13:57:49 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] omfs: convert to new mount API
To: Pavel Reichl <preichl@redhat.com>, linux-fsdevel@vger.kernel.org
Cc: me@bobcopeland.com, sandeen@redhat.com, brauner@kernel.org
References: <20250423220001.1535071-1-preichl@redhat.com>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <20250423220001.1535071-1-preichl@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/23/25 5:00 PM, Pavel Reichl wrote:
> Convert the OMFS filesystem to the new mount API.
> 
> Signed-off-by: Pavel Reichl <preichl@redhat.com>

This looks good to me, and passes my typical "do a bunch of
random mount operations, and ensure no behavior changed" test.

Reviewed-by: Eric Sandeen <sandeen@redhat.com>

Thanks,
-Eric


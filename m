Return-Path: <linux-fsdevel+bounces-40426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD23A234CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 20:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1F483A5BB4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 19:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CBE1946C8;
	Thu, 30 Jan 2025 19:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="dolMIwmg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tNb6eZXp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA2F187848
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 19:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738266440; cv=none; b=GtzN1Uln0pUzZiBqxEym0y1jxLwKUeL0uiCdN8kXVoL7Q7yPU9DkUW0WAe5f5/TvpX1yYQs3RxaRBMYxGtTol7p92xUw8GRwVnDbJxh63X9kmjmXduNqVSBQx+3dNijHHPXh3N8TjbH9k9oBzSuX8bbgAD4FhxgUtImq0yE9WeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738266440; c=relaxed/simple;
	bh=YDGfL2vBAvh8cN5KzXud7dZ//q3UrIiUMzeOREuUzAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CFUPYjqQ78B0mUKSVuUQb2dB08LdxWkl/rIRvXpr28LYCXkggW9vHjto0y60hET0IreD3A2K7srwkEMN83cGo7Qzxefe6ABCjhwArfcI1BTdn6/dT/xo+5jGgX2NtOGGnVFd7tnimKIh8hCuFjuSFpGrEtq1IYizRzGhvn3AMOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=dolMIwmg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tNb6eZXp; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id E4C1D114009F;
	Thu, 30 Jan 2025 14:47:17 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 30 Jan 2025 14:47:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738266437;
	 x=1738352837; bh=JKfZaLmKgYiHTwPm7G4Pxs1FSPHViKKG6RMcFmXvpg4=; b=
	dolMIwmgv/mu680TpGYgM67pXOOc/CCtEyu0nzaJcdFuylZPnuEOC4cr+eRLET1t
	G91TYSHr9bRXfqfnvUuKR/xbPkS9lgU1jAsFB4d3gl24tZBDWEadF+gU31LrBQw0
	k51aIt59kfzE6/VpNiV8AP9Fg+at5X8xuVnt7vuzgqDABbz0hIHALA3vC1ck0K5o
	WuISL4Un3ROdmi+YbCQdQk2fpZU9dl0nI+TUlmwRdL5nxuEg+rk8EhogcGIOkmKR
	5+nFlkHhTI9OV5R1UqSrlG7idfDlI9wreFv+BObeI49k+uol2/tfn2+ZGUbl+inH
	itQnvryMN3/IsDwK2hR62w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738266437; x=
	1738352837; bh=JKfZaLmKgYiHTwPm7G4Pxs1FSPHViKKG6RMcFmXvpg4=; b=t
	Nb6eZXpjEzKB1llPxX5EAJkbWHhMIW7g2tVx42iBe4+vVOGPLAti+6rj5Jwsur/A
	pDKLGJLTmuc5pnIEvGy/X1/RNbU2aHRqcDQztDei2uoMLlr/MURXXLWOy5psUwPJ
	kF/K8Pc8jn5qq2RM7sCvWxf7+/TGc8/juTlGZ8K+jUFDmF/zRFUsGgonLj7+UKGi
	t2ojIFo2c608y/P8tELgwkQG5/wF12A7FJyPSjWrONS6XvCp/jKgbwuotEQhlaLO
	r6pmH5aItPd4wULj7fh3Jdq0WpElere5lucaIrp1DqQCeL4Zn+tP/xq9RNVJ1JWM
	3FtnZV4EIK62s1yW55ujA==
X-ME-Sender: <xms:RdebZ7V9TSUdjBncBos4vXxE9NgmluTQY8K0of8OPa2hwSXYpEReYQ>
    <xme:RdebZzlAwaGo3PkE8xGFzQSfWRKLpiM4yW55mN5IZ8JTsPkrZgzR8YJhR3ivZ9HZ3
    o-Y31X3ihG0fD58oq4>
X-ME-Received: <xmr:RdebZ3bm5xibe0yLUKjKpqYZ3RO7YiPnTNGlTLD9LrH6iZG-R6bzYDWj4XRf4rKMbgfMyJ7YvaPTVDw-Q8iswNKhPztU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeijeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdej
    necuhfhrohhmpefgrhhitgcuufgrnhguvggvnhcuoehsrghnuggvvghnsehsrghnuggvvg
    hnrdhnvghtqeenucggtffrrghtthgvrhhnpeevieekueetfeeujedtheeffedvgeffiedv
    jeejleffhfeggeejuedtjeeulefhvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsrghnuggvvghnsehsrghnuggvvghnrdhnvghtpdhnsggp
    rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhgruhhnvg
    hrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghnuggvvghnsehrvgguhhgrthdr
    tghomhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepughhohifvghllhhssehrvgguhhgrthdrtghomhdprhgt
    phhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhk
X-ME-Proxy: <xmx:RdebZ2WQdgEJyWFDkUW4XXspDA6bBZc39Pn46NlFwJlBI_BqTinomQ>
    <xmx:RdebZ1n9lRRVxWLh1EcpQQkV8iY4B2yItVe4bXOXGYhi1rZNMxHnmw>
    <xmx:RdebZzdxbcKv9GjMZ0gcYsLTXXEuqAsOD3ZdBU0sOaOnWgITUCmNSA>
    <xmx:RdebZ_Evop-oYTbiutRI8V-SeZT_rTyzKcT2TvCBH3qiqVBqT5zF3g>
    <xmx:RdebZ4sks0Q9lMko8ZBSIP31t7DaOqWgYghb6SUHQbr9llWxnrug-Qsi>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 14:47:16 -0500 (EST)
Message-ID: <483844a5-cb74-4dd0-befa-0f4139b75fe2@sandeen.net>
Date: Thu, 30 Jan 2025 13:47:16 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mount api: Q on behavior of mount_single vs. get_tree_single
To: Christian Brauner <brauner@kernel.org>, Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>
References: <732c3de1-ef0b-49a9-b2c2-0c3c5e718a40@redhat.com>
 <20250116-erbeben-waren-2ad516da1343@brauner>
 <efb93d2c-c48f-4b72-b9fd-09151d2e74d6@redhat.com>
 <20250120-klappen-peitschen-824d2eb8b953@brauner>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <20250120-klappen-peitschen-824d2eb8b953@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/20/25 5:23 AM, Christian Brauner wrote:

...

>> While it seems odd to me that mounting any "_single" sb filesystem would
>> reconfigure all of its current mounts on a new mount, that's the way it
>> used to work for everyone, as far as I can tell, so I was assuming that
>> we'd need to keep the behavior. But if it's a question of just fixing it
>> up per-filesystem, I don't mind going that route either.
> 
> So far it hasn't lead to any regressions and we had the new behavior for
> quite a while.

Well, it regressed tracefs & devtmpfs so far. *shrug* Working on pstore now,
which also ends up with diff. behavior by default. But I'll just work around
it for that patch, I suppose.

Thanks,
-Eric


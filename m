Return-Path: <linux-fsdevel+bounces-73021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8ACAD08193
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 10:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DC09306B780
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 09:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60ED6358D17;
	Fri,  9 Jan 2026 09:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="xoBHJd02";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CFQ8vT01"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A541358D21;
	Fri,  9 Jan 2026 09:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767949629; cv=none; b=jgmhct/6XAAvIDOlMOmknVdXPEoJo/sB3iX0yAnHNL4dSeoKpSKD4Q98meqALGhUAKSpGHW8bVM6K648lvujktzZ6eUE3pXLyWUMbASPm5NFZYqGNA4MvI5yVnSlnKOWbpAT3D5bTGkPL1p9uI3FEWiHEgO6gvYMa1UwOsKQku4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767949629; c=relaxed/simple;
	bh=WpHdn+9neg6SFNG/OOmOlstocJq7yoEdBjtscA+pMxE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=MFNZVg1zY0gRzoar14NHqr4Y7uavyD2M8fJ1LKlBX24xNSxwbjFR1ut2x0/B/f+S3mcIF0V9w7HGKifWD+JWu1cPxW96b/Q2wJzKKrItnaEXBbfOYW+uXkNpt/yFMAXUs2/BWqBARhV+s9t0Zk0+CbF/sE+iDZO1/uM+hTmc8cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=xoBHJd02; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CFQ8vT01; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id BACC1EC00BD;
	Fri,  9 Jan 2026 04:07:06 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 09 Jan 2026 04:07:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1767949626; x=1768036026; bh=Ly5pm6xNlhmXVqIXoX888UMxH67D/f69oyX
	NeTjvr98=; b=xoBHJd02Do7RQm3AlOKNDhdeUhY6eYr2IC6XG4K1Y7Qi6QngeUb
	zUH2PQjGK8fAZ7LY8aArsl+jfew1Q2cppalINWPF5IQ3lDxXP/1IM445Xz/ZaOVJ
	7DYsvTQT9ltfRTqL6TTzIjeRz7RQwiYRwUzD+2ef4NcCvjy+wJpGmvAXsfOe6sqf
	OXIk/242+FQZrAT5zzJg5GeI+aHx/kKZy+OZxZJ9CFxn8ePPvvGMGDNu5IHJ+aj6
	U59QDoY15TXZE4BEMGS1CrCJ8lUyi2spV+BiNY0gVsEAQELz5AyIBdgmIq52tShL
	4cO13QHJdnb3GULKw2en6G27TDKLH1aQidQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767949626; x=
	1768036026; bh=Ly5pm6xNlhmXVqIXoX888UMxH67D/f69oyXNeTjvr98=; b=C
	FQ8vT01U831hsmm+IidRPVCpXQBOz2/MqMKJc8kpdG1GjwFhEPAlBSjgTthRNJj3
	EgZIBEJn8URnALfiCgY4IwR/Q6UONmC02lk9bRL+X0d2FLDRsUmIEf07DOERN3C0
	qmG0RcP+6ROJ2a8M8Clytzz4qBHvl9xBnfAJ+YBToChfEO766b0ZXYhFvM6Pthoh
	ApuMC+hnvGyEIpyV3OvO+aTIQsMZ6iPdvOMWaDsNS7I15vu2/IoOIVx8Nm7K0CI9
	fY3Hf0f37bYKxiNyFdgb7EImRcBwr03+Ijgi+WAo2Xa7MWTyomzlmooy96OhiyoF
	n9rAvjXPSjOEnFlaQdOjg==
X-ME-Sender: <xms:OsVgabJo9W0lKdrIrwTsvYZoX0SvkurTf_O6oA1EhFgeHEJG1OW1kQ>
    <xme:OsVgaZKdjqKdmJ3FVxDmq3S0OqpgOJeRt3P362I8FEhNrBfwsnCwG32Ut5NUqm3y6
    O_SRrJ_c-uUxBUxIGBybEWT1mAuT2r0rlfDIs5_HDd9bCaZgkg>
X-ME-Received: <xmr:OsVgaaXRIF-ySHS4peIdDaqIURfrJpfQiuGoKk03topmtpbSrw3Sv7btls-GR5kLGh2YTPhSpBXf-73hxU3YustPpA_fuSI-2Nd2FEqkKCh2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epudetfefhudevhedvfeeufedvffekveekgfdtfefggfekheejgefhteeihffggfelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtohepohhkoh
    hrnhhivghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghirdhnghhosehorhgr
    tghlvgdrtghomhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtg
    homhdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegtvghlsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:OsVgaSl_JzipIRKHLnptQtYo1u1UyDkuMXx4KBVUvf6_KqiNYJNIXg>
    <xmx:OsVgaQlLn6_ZsgrjuznPFVkSsqXF3tUH856BQjc4CWVtIWYz4e3mXw>
    <xmx:OsVgaSbpPBGH-5xnyaZV0_QhfYQg3ptViAXsbA9jHMqQvsDWxcd5EA>
    <xmx:OsVgaSQ-jXpDDR6y06T-9bdjjAlJmPP36nSRNFgR_yEQc5V00tc0sg>
    <xmx:OsVgaUOEUDgwl3i4rSFPrFgRVIqMOsX2vx6nc8Sl0YmA60tsAWUUYdAf>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 04:07:04 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <cel@kernel.org>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>
Subject:
 Re: [PATCH v2 5/6] nfsd: revoke NFSv4 state when filesystem is unmounted
In-reply-to: <20260108004016.3907158-6-cel@kernel.org>
References: <20260108004016.3907158-1-cel@kernel.org>,
 <20260108004016.3907158-6-cel@kernel.org>
Date: Fri, 09 Jan 2026 20:06:57 +1100
Message-id: <176794961797.16766.6650655992486998763@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 08 Jan 2026, Chuck Lever wrote:


> +
> +	old = xa_cmpxchg(&nn->nfsd_sb_pins, (unsigned long)sb, NULL, new,
> +			 GFP_KERNEL);

As you don't need the "old" value, would xa_insert() be a better fit?

> +	if (old) {
> +		/*
> +		 * Another task beat us to it. Even if the winner has not
> +		 * yet called pin_insert_sb(), returning here is safe: the
> +		 * caller holds an open file reference that prevents
> +		 * unmount from completing until state creation finishes.
> +		 */
> +		put_net(new->net);
> +		kfree(new);
> +		return nfs_ok;
> +	}

....

> +
> +
> +/**
> + * nfsd_sb_pins_shutdown - shutdown superblock pins for a network namespace
> + * @nn: nfsd_net for this network namespace
> + *
> + * Must be called during nfsd shutdown before tearing down client state.
> + * Flushes any pending work and waits for RCU callbacks to complete.
> + */
> +void nfsd_sb_pins_shutdown(struct nfsd_net *nn)
> +{
> +	nfsd_sb_pins_destroy(nn);
> +	flush_workqueue(nfsd_pin_wq);
> +	/*
> +	 * Wait for RCU callbacks from nfsd_sb_pins_destroy() to complete.
> +	 * These callbacks release network namespace references via put_net()
> +	 * which must happen before the namespace teardown continues.
> +	 */

This isn't called during namespace teardown.  It cannot be as the
namespace cannot start being torn down while there are still references
that need put_net() called on them.

It is called from nfs4_state_shutdown_net() which is called from
net_shutdown_net() when the last nfsd thread exits.

I don't think there is any need for rcu_barrier() here.

And I'm not entirely comfortable with the flush_workqueue() call.
That could cause shutdown of nfsd in one namespace block due to an
unresponsive exported filesystem in another namespace.

Could nfsd_sb_pins_destroy() call cancel_work_sync() on the relevant
work item.
Then it would only wait on work for this namespace.

Thanks,
NeilBrown


> +	rcu_barrier();
> +}


Return-Path: <linux-fsdevel+bounces-73016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF41D07EA2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 09:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3999830B9B90
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 08:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9A5352C57;
	Fri,  9 Jan 2026 08:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="TQHp8WwD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C557VQp8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B22352930;
	Fri,  9 Jan 2026 08:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767947936; cv=none; b=O7WaQy9o75TNe2/xF1tEDkM+16OSsgOcswOfmzVAHwl721lt6vg0IAnDhIkJpV5xpvUlzT667m5zhcbQ2IzcE/qnTyZVKtUsCfZj3aBLkR5aEBtuDYRMeW5gQuRSbuqIpdN7+OX7QtiRtKNr10nfnusSK06lafORpDaYVxKjVOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767947936; c=relaxed/simple;
	bh=YDiW3zmkxJhMUBIqx+aDvPSb26J54N9ldD3AuKBjvho=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Hxl5ZFWeUWChQ2yKnzGOXUr5KLOehcOVUn4v1q90gta6GtskTlVxOnGpaGh8etRXbHuHiojzeG0ngS4dHfSj2cZs1AluW0q1QtPd4GcKQIKXKfAtVIHZyQGopgGXe4jZJvoKbUB78bUAzE/zFITBrAOPjfm2Lsnvv4JnOcd07Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=TQHp8WwD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C557VQp8; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0CAFB14000CE;
	Fri,  9 Jan 2026 03:38:50 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 09 Jan 2026 03:38:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1767947930; x=1768034330; bh=G+blVvHVnXAizB4d/NX7cQRXgKclEbrkiyx
	jrZa2eTU=; b=TQHp8WwDLTskSd7syZBLWN7JeKJbeHEpgW/SHL/ksKnl8ORPHki
	X03IcMVyD10MNZWgLQTr4OYxJh21mhN22NqlggYh8PycECLYxleWem27ijzN2Ay8
	nTG+obK93do133Tgl/zi3XXqUdab+8pSmp6m+YRTngAWdux/21rh5UEOjlpqEdhB
	0+MavjgB+ZBAU0ZbvUcE+2VY+h6QjTxcV1vaIlziatk/qnIp/l9Ou8R6u7dHQxYN
	/MKUuqoBwuf6MDW5rqSbO1X1QRht26O1165nw+1bpgHOs145nh051eP0gsxp6Yai
	z5DgavabNqTqy4PRj0XEv5fv2BrV7oj1ihg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767947930; x=
	1768034330; bh=G+blVvHVnXAizB4d/NX7cQRXgKclEbrkiyxjrZa2eTU=; b=C
	557VQp8zEfF6TA+36uvueDC3PMGbz+brqfu4P/omiLVl2QdjGpKY/HyRgNW0soLz
	h7Y9nrrJxNGAWB33uMmssABaWbupRyU8kbtumxvSgt/UBdvJPxyCcdw//iq0XsFG
	G/kSpMJPU4v5gd/8CzuDlfrWT4oFyFR/9moXtciYH4kJjPwsjIFfDfyc7n2U/a7l
	qFucWGFJbIr5hp5VPGGmuKkHcfjbA5bMBmJcc/9hkFcs+XIXgyRAW/5T2YgMREcG
	V1Zio/v5h60foYs841VfjsJ2hcb4WtAssnnXnJnRP2OhLc+ow0RCNreDeTZ2jpeE
	y2hFAdo1AuTmpqwvwZdzw==
X-ME-Sender: <xms:mb5gaXLWyaLPTK3ho3EeiIkSz6JBPxfpF_HbUXgbfjM7us1ijI5DhA>
    <xme:mb5gaVLYm6gPbNjJggxRR7fkhMDtxIGa5p7Q3eqyj1mrPID9JUKRnZOPG5y1bZmfA
    4ZzveFELnw-UHXjFd1rtw25YcZKilytMAb-loPCEf_D3Bvc>
X-ME-Received: <xmr:mb5gaWVVi35h5ta5p0vjbTP1uXiMBz-Qn6b-ZXcB_P4srR7gj4hA71rLwS_ZqHzwJ2qpd4Q7_atKDv0JWJgvE8ob0_5J14p3ckrc8heP7h90>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekfeehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:mb5gaekX4D9Vx3EiRoGoCCWEoq66e1-OmWdW8ziOsaZo4rSabhmFWw>
    <xmx:mb5gacnUdCPAaKce23s7o-Ac1YVfg9VrW1dHuMokYTDUOtLGbAxJiA>
    <xmx:mb5gaeYP67nVPI5xA9yRnACVgsIw2BWkSb6Z3rr1zFrQBKboHbj-jA>
    <xmx:mb5gaeQ9hPx0mrvdtbGq9c6C1BsyGdFWWSvUzKRnh3NyNq6BzIuX6g>
    <xmx:mr5gaXU_Vj1RRGesbjp88tenR70KdZfQo9UHGf8lPMmut06JENvekUIK>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 03:38:47 -0500 (EST)
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
Subject: Re: [PATCH v2 4/6] fs: invoke group_pin_kill() during mount teardown
In-reply-to: <20260108004016.3907158-5-cel@kernel.org>
References: <20260108004016.3907158-1-cel@kernel.org>,
 <20260108004016.3907158-5-cel@kernel.org>
Date: Fri, 09 Jan 2026 19:38:43 +1100
Message-id: <176794792304.16766.452897252089076592@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 08 Jan 2026, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> The group_pin_kill() function iterates the superblock's s_pins list
> and invokes each pin's kill callback. Previously, this function was
> called only during remount read-only (in reconfigure_super).
> 
> Add a group_pin_kill() call in cleanup_mnt() so that pins registered
> via pin_insert_sb() receive callbacks during mount teardown as
> well. This call runs after mnt_pin_kill() processes the per-mount
> m_list, ensuring:
> 
>  - Pins registered via pin_insert() receive their callback from
>    mnt_pin_kill() (which also removes them from s_list via
>    pin_remove()), so group_pin_kill() skips them.
> 
>  - Pins registered via pin_insert_sb() are only on s_list, so
>    mnt_pin_kill() skips them and group_pin_kill() invokes their
>    callback.
> 
> This enables subsystems to use pin_insert_sb() for receiving
> unmount notifications while avoiding any problematic locking context
> that mnt_pin_kill() callbacks must handle.

I still don't understand.
In your code:
>  	if (unlikely(mnt->mnt_pins.first))
>  		mnt_pin_kill(mnt);
> +	if (unlikely(!hlist_empty(&mnt->mnt.mnt_sb->s_pins)))
> +		group_pin_kill(&mnt->mnt.mnt_sb->s_pins);

mnt_pin_kill and group_pin_kill() are  called in exactly the same locking
context.
Inside these functions the only extra lock taken before invoking the
callback is rcu_read_lock(), and it is the same in both cases.

So if mnt_pin_kill() callbacks must handle problematic locking, then so
must group_pin_kill() callbacks.

> 
> Because group_pin_kill() operates on the superblock's s_pins list,
> unmounting any mount of a filesystem--including bind mounts--triggers
> callbacks for all pins registered on that superblock. For NFSD, this
> means unmounting an exported bind mount revokes NFSv4 state for the
> entire filesystem, even if other mounts remain.

That doesn't sound like a result that we want.

Can you be more explicit about the problems of the locking context that
nfsd would need to face if it used pin_insert() ?

Thanks,
NeilBrown



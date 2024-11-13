Return-Path: <linux-fsdevel+bounces-34620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 752F29C6CA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 11:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04A911F22877
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 10:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA191FBC8D;
	Wed, 13 Nov 2024 10:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=e43.eu header.i=@e43.eu header.b="mRGLQjB8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WJFt5y70"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536941FBC84;
	Wed, 13 Nov 2024 10:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731493037; cv=none; b=PsEIeZ4OA8Y5KSXrPeGZ0e2YXLVXuT5DoyF4kUasIXagRl9VOX9F0EFaVpcABwQc+cFXj1DNr7iEpkMKV8Yk+YWrZthKopiDNyjlPifTmPG7xBW4ow16jYeDcyvTVziRpV9WVlr8kxznAYTBBWaqzQRAnXchEGJLbbnJI3kwRTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731493037; c=relaxed/simple;
	bh=iHOlgh6dYvG+vTJnoFeYpg9i4OEzRqgfFZG2M8zNKfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=INOpifg/PT0njjV58V1IlAfTGlAbQRowZgDgE/Q04QtUP+ZERZr2P6HJA8StWVsldC8T4Of4Hdv3/xvUVEz41wTEiDNq8cm/ocYxNaC004G7TOsSFNFb0NuF2MVezWzsdGGYDVx0jOlAkx32x1OTZG4cU6XfbLSC9lLsHzyR3dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e43.eu; spf=pass smtp.mailfrom=e43.eu; dkim=pass (2048-bit key) header.d=e43.eu header.i=@e43.eu header.b=mRGLQjB8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WJFt5y70; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e43.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e43.eu
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2506125401AE;
	Wed, 13 Nov 2024 05:17:14 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 13 Nov 2024 05:17:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=e43.eu; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1731493033;
	 x=1731579433; bh=9ZHnygEc+6vK0dp9uuxLfgMjR5J8Nzn2HU8phrSKTMM=; b=
	mRGLQjB8igKQpaHEtDFGqbub67EraOm/UX9Qk0dYYWuL+fRtOlW9GlHzEgGfchqO
	OUf3T7NCjXGhssAD2Y1oFZt7jVPJ8eOqq/ZEFgWW7dBMLYXc/GyZJSDKomA3utPm
	HGgrKZTCFoWryPMM+I2kKkIkGZNI37Vg6yoict7GYMCQHs9JuRM3DaouTKg6MnqC
	4U0P8CVJvIDVKV2KdUa4QGvY8tSW8jbUkvUN9e9xrwdiVOQgzdM5yQ41/3lZFAve
	P48GCB5k2ITvmGKevqaZ/yVRwAGhTEbSQQV53njL0qDddLDh6IzceXv/xcygbtaW
	mtiGDPer+5RfLKAobnPTRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731493033; x=
	1731579433; bh=9ZHnygEc+6vK0dp9uuxLfgMjR5J8Nzn2HU8phrSKTMM=; b=W
	JFt5y70KqyknEjur9/DIkTLWRV5bP1Xs/x7ivD2OrEQMju4odsjBfWFx8dGM80wc
	K7saiH9272w+51mL144XuLRLOdO1xZ6Q/eytnpd0xflmz/QyQMbdfKmnLG7d/l9W
	O3hL94f6Td5No6C+G8Q8pOG1aU3c/eunkKyexRKog46061MmCwz7u3H3XEkiFLt/
	NiqmJJN2dHaGc7Wn3FR4ydB874TtyQG+mKvdRvEOGo84P2z5lrDOGhmB8UppdtEW
	MDeYGRwC5a4HNRdXocAPECVSr/PjdKp4bE/XiWUauUBy5xoCmVoxnp8ZAPFoHvQ5
	O/zGLsmq46I4F+003nTgQ==
X-ME-Sender: <xms:qXw0Zx8zNHIYM4Ei0RJg5-b2TekLhn6T5IdDIx2DD6zeqoS1FiM9aw>
    <xme:qXw0Z1u6sdB9sfoUPuLXGpBMFmS3efy60NXWdIQHIjZwRTeCIgxCxE1ssGcLRxO2c
    Gh9siST7_2gX4gq2Uo>
X-ME-Received: <xmr:qXw0Z_ByXjZjbvdXgW3NqFQSuF1VYpXCfKo2rPZC4eKj8w_R6efQjC58zthAKpB0NKgBD1RS5AWWL_3A9sKrOVJnyUJ2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddtgddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeen
    ucfhrhhomhepgfhrihhnucfuhhgvphhhvghrugcuoegvrhhinhdrshhhvghphhgvrhguse
    gvgeefrdgvuheqnecuggftrfgrthhtvghrnhepjeeftdelheduueetjeehvdefhfefvddv
    ieekleejfeevffdtheduheejledvfedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepvghrihhnrdhshhgvphhhvghrugesvgegfedrvghupdhn
    sggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepughjfi
    honhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegrmhhirhejfehilhesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhig
    qdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuh
    igqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghh
    rhhishhtihgrnhessghrrghunhgvrhdrihhopdhrtghpthhtohepphgruhhlsehprghulh
    dqmhhoohhrvgdrtghomhdprhgtphhtthhopegslhhutggrseguvggsihgrnhdrohhrgh
X-ME-Proxy: <xmx:qXw0Z1f8nVu9vvQpajk4HLnRfTeiI06wcndsCi4we9S6SIRoEmVJ1g>
    <xmx:qXw0Z2NfckF_do8zYMLZ-tK-LxyaburUeE11t6q-WgwY4Bzbft9Yow>
    <xmx:qXw0Z3krkOlS3qmbzbTUBB6WSrHJazBkHZTBlzq5BQ1KzQdvseYjwA>
    <xmx:qXw0ZwvKmm3kJrwPPMcfnMh_x7Q_ed_PYG1v1Li7bMG3cQkHIqnvqA>
    <xmx:qXw0Z3GQC2wtaUAETBMNuOPXTW9kzLtkfiQu-ZuquM7sWUC4DCtYfiRm>
Feedback-ID: i313944f9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 05:17:11 -0500 (EST)
Message-ID: <e280163e-357e-400c-81e1-0149fa5bfc89@e43.eu>
Date: Wed, 13 Nov 2024 11:17:10 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] pidfs: implement file handle support
Content-Language: en-GB
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, christian@brauner.io, paul@paul-moore.com,
 bluca@debian.org, Chuck Lever <chuck.lever@oracle.com>
References: <20241101135452.19359-1-erin.shepherd@e43.eu>
 <20241112-banknoten-ehebett-211d59cb101e@brauner>
 <05af74a9-51cc-4914-b285-b50d69758de7@e43.eu>
 <20241113004011.GG9421@frogsfrogsfrogs>
From: Erin Shepherd <erin.shepherd@e43.eu>
In-Reply-To: <20241113004011.GG9421@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/11/2024 01:40, Darrick J. Wong wrote:
>> Hmm, I guess I might have made that possible, though I'm certainly not
>> familiar enough with the internals of nfsd to be able to test if I've done
>> so.
> AFAIK check_export() in fs/nfsd/export.c spells this it out:
>
> 	/* There are two requirements on a filesystem to be exportable.
> 	 * 1:  We must be able to identify the filesystem from a number.
> 	 *       either a device number (so FS_REQUIRES_DEV needed)
> 	 *       or an FSID number (so NFSEXP_FSID or ->uuid is needed).
> 	 * 2:  We must be able to find an inode from a filehandle.
> 	 *       This means that s_export_op must be set.
> 	 * 3: We must not currently be on an idmapped mount.
> 	 */
>
> Granted I've been wrong on account of stale docs before. :$
>
> Though it would be kinda funny if you *could* mess with another
> machine's processes over NFS.
>
> --D

To be clear I'm not familiar enough with the workings of nfsd to tell if
pidfs fails those requirements and therefore wouldn't become exportable as
a result of this patch, though I gather from you're message that we're in the
clear?

Regardless I think my question is: do we think either those requirements could
change in the future, or the properties of pidfs could change in the future,
in ways that could accidentally make the filesystem exportable?

I guess though that the same concern would apply to cgroupfs and it hasn't posed
an issue so far.

- Erin



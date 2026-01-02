Return-Path: <linux-fsdevel+bounces-72334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C207CEF6C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 02 Jan 2026 23:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA94C30184E1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jan 2026 22:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D252FFFA8;
	Fri,  2 Jan 2026 22:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="2D6sx33q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SR7eWBS0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27112D8DA8;
	Fri,  2 Jan 2026 22:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767392843; cv=none; b=GmHP6WPPcCLT50BBqXEu24bKHxx8q6saPc3Tq8a1Nye8AWWMB746iu4+4bTHhUyvTjvuUMX5s4s8zhqsRGgXdPo0MZgxma9IxbqOUNS7KM3jBchwmzqetLZTujQxJkJtMeaKe5TLBFZw//+8FWnq/J5RnJg7aexddJOtOTJbGfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767392843; c=relaxed/simple;
	bh=R+aYtOZH3SNOLWHEPLC374nJVfoofBCCPegvr+UH8GM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eM3+ocawRH0cTZO5pEjuqGakz2y/b+rKEFGt9hGXp8Lrho6zNZNlCJnOQ1Clm+Pc6b0VaLlemjWyxcKzXV68EL73Q+2/X5bG6Ek/I5Vb6hGDE5i3iaBIKFFDIAgvqmMODFET/NF7M7lA7ha8OjFl/m8uWCpGbyWujHBPK9LtJ6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=2D6sx33q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SR7eWBS0; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 09AFC1400089;
	Fri,  2 Jan 2026 17:27:20 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 02 Jan 2026 17:27:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1767392840;
	 x=1767479240; bh=mjIwG5ub/I588ds/AaIcKAySTR6WS3xs7Ih3AsuAnkY=; b=
	2D6sx33q85oA7/XIP/nbzvry/kdqUCpXoWKV2PhhYEPTeUrKuO8bThBDSSz9InJJ
	eHF6kfytmCBFTf9bqn/U637xNUzcHcIDL78UF/nojc1w7nMEo3R6S+lb1qFx1fRu
	/r0E2voVh0gseKkfDcLmRHNPAtIZjysseMoNJ3BitoBp5okn6gs5ZgHNdwuS8vAZ
	yGEXPa/7WGsxKegpI2r8XiuT1s7seOA1zERLu9nato7v9BkLYcIQoXNldJK7xsQs
	kx0jwoT3LyVz6KEKuTAWNciydTZCGXi31H3k86nSV5hJNgKSWxPjOPREh9ZDMJki
	WaL8V1QWfALs6pSNStIZjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767392840; x=
	1767479240; bh=mjIwG5ub/I588ds/AaIcKAySTR6WS3xs7Ih3AsuAnkY=; b=S
	R7eWBS0MlAOMsM1OMOXU5/BNHITvFbkJrDQ+hIirDzw4AOkWmu2KkjkijQlOpHhY
	NMw0IbKpnrem8ZfFYAYf2KQEKWbQ8kBj65UX4hrLrrqou1W5txAA1fcgM6QMW1e+
	F1cvZlSY9szj4zHVVeJISS+KsMMJWl/cl38mKJyvsQnY5LumnVKcrWoJ/Y3atXxB
	tsQJsi6mGijqfEkUK/UKN68aMnAZp3bJdsNLG3WMlq8IkxIir16pM11xU2nuv/TE
	ouT/eDoYN7ygkO9EBFA0LMzzghpUo0Tt/2nbUGrJ0RqmeJ9qfQ3WY3WLtjB37JYS
	AOIWdOSVQP+onAqzkgRVg==
X-ME-Sender: <xms:R0ZYaW12eZg18n9hJyebtVM1ldMAtomYWRmASEDpw_3yWjxLimGLjg>
    <xme:R0ZYaamEOkSM4Jesn-JgFvSR-MfZes2PrEy0Va6FPS6VGd9S2o1ncHux_Sg06Nz4x
    bAKiHjbM7mIGB5v9pPyrG5kswdOK0hDyAvAppROzsOIx-zEVxo>
X-ME-Received: <xmr:R0ZYae8O_K6r7SWjPhieQBdY9wyDrwIqpQpvc40aaUtBZs7cg69ZD0QPK1et_sp-hWUSU4vVMEAThvFW-Z7kYGGeK2g9KTys96JiE3-aqlRieFWmfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekleekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhepteeigfekgfetgeelvdejieeuheffhfejkeejgfehjeejjeegueduhefgleeg
    vedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnuges
    sghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepthhhohhmrghsrdifvghishhsshgthhhuhheslhhinhhuthhrohhn
    ihigrdguvgdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpth
    htoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:R0ZYaXpvDQF6LhAtDeOgQGs3wfMUvP8Um_ZDwzzxXd5qTGPql1vV4w>
    <xmx:R0ZYaflakWsLwxofYI_cJYmTwgEcMbhg9Rwy2yrJHq10CFutzgrbiA>
    <xmx:R0ZYaWiznCfaohI0j86CfTCN0qZB3ps9s920F2eucSnDfQ3FLAzhTw>
    <xmx:R0ZYafcti4MAGcmGWlNy0kioPIMxv-U21B4CqW7D0R6Y7PPqQIDnXg>
    <xmx:SEZYaZAZayW_TwfasiTs2n2cgdJ-FIMBHBfKRUt8Ec8fYST-8SmqrdDa>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Jan 2026 17:27:18 -0500 (EST)
Message-ID: <8efcbf41-7c74-4baf-9d75-1512f4f3fb03@bsbernd.com>
Date: Fri, 2 Jan 2026 23:27:16 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fuse: uapi: use UAPI types
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>
References: <20251230-uapi-fuse-v2-1-5a8788d62525@linutronix.de>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20251230-uapi-fuse-v2-1-5a8788d62525@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/30/25 13:10, Thomas Weißschuh wrote:
> Using libc types and headers from the UAPI headers is problematic as it
> introduces a dependency on a full C toolchain.
> 
> Use the fixed-width integer types provided by the UAPI headers instead.
> To keep compatibility with non-Linux platforms, add a stdint.h fallback.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
> Changes in v2:
> - Fix structure member alignments
> - Keep compatibility with non-Linux platforms
> - Link to v1: https://lore.kernel.org/r/20251222-uapi-fuse-v1-1-85a61b87baa0@linutronix.de
> ---
>  include/uapi/linux/fuse.h | 626 +++++++++++++++++++++++-----------------------
>  1 file changed, 319 insertions(+), 307 deletions(-)

I tested this and it breaks libfuse compilation

https://github.com/libfuse/libfuse/pull/1410

Any chance you could test libfuse compilation for v3? Easiest way is to
copy it to <libfuse>/include/fuse_kernel.h and then create PR. That
includes a BSD test.


libfuse3.so.3.19.0.p/fuse_uring.c.o -c
../../../home/runner/work/libfuse/libfuse/lib/fuse_uring.c
../../../home/runner/work/libfuse/libfuse/lib/fuse_uring.c:197:5: error:
format specifies type 'unsigned long' but the argument has type '__u64'
(aka 'unsigned long long') [-Werror,-Wformat]
  196 |                 fuse_log(FUSE_LOG_DEBUG, "    unique: %" PRIu64
", result=%d\n",
      |                                                       ~~~~~~~~~
  197 |                          out->unique, ent_in_out->payload_sz);
      |                          ^~~~~~~~~~~
1 error generated.


I can certainly work it around in libfuse by adding a cast, IMHO,
PRIu64 is the right format.


Thanks,
Bernd


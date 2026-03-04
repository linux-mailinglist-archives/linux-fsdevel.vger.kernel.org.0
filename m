Return-Path: <linux-fsdevel+bounces-79363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEVBBjE2qGm+pQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 14:40:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 243752008B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 14:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03E0C30FD5C5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 13:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FAB38737B;
	Wed,  4 Mar 2026 13:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="XWXJEqr0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2xB7YK2O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18AF1A681F
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 13:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772631368; cv=none; b=XlPWa49Kj2NpnTW6+78XGd8rp2nBdfNDM0HUEBkf8yYMTuw0il4lQg/lSE4EgzB1ZWi94lEBxjI0pNL1JmCcMsj9jfcGsvGxLpC3enHoZoYp3SPQbghEHmC1sHLAkhISmfVK+sJlRVPrk/xmALP/k8Sf/oc8RhLpzIsh+2aEvpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772631368; c=relaxed/simple;
	bh=phlZR2Urzj5QZLdhyScB5DSRXlwlkTbz1WbTQufDggk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JjdZ7yrCP/DmLADGcmEe7jwxE44GsTPdUS3v2YBRRcf2CWz/Wih+ov3SPb2wLauCxPjq8D6C+dx4fXLWr1+BXEVWR1pVcCsrUcWILV/qcFTpYYJXtCjA9Um5FhEZEVMzeJME4Nu5N2s0BZIIMAJdvCMm/KgKtbjqlM+quAGJf+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=XWXJEqr0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2xB7YK2O; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D0E0D1400233;
	Wed,  4 Mar 2026 08:36:05 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 04 Mar 2026 08:36:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1772631365;
	 x=1772717765; bh=UrNd6PvAF2drGw4ZcdopTLaWyVOxrTNGt9UL+DD7vrA=; b=
	XWXJEqr095OAsqG+JK/L9kZdZZZWeIv0preVTWatqm02m0rfGWL097gmmPc0zoeU
	LzIi4Y7v0L6vXyX5mc816lQ0BjzrQkopkE8JscuhDi1PMUHrhHe2ZQ1ZptsAXguU
	dy/uFUzlmI097ld/f9iGn6l7qeoTQf6Hiv642jPf2qHOnN2amfw7cK4oiUKr2jy/
	STTV+kVgFExwmEp3Qk/b7NG4xnqPidNVzA1I4pbMMM0OFq/99L7jJ42QmgSrk7QK
	g29PTfXNepdNw8PwZ/BUVMV8U9qOxUgdKqWxrbDc3rOItBC9vXrMfWGMKktFpb4u
	Xtv1S5aIstUndm2suFMIuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772631365; x=
	1772717765; bh=UrNd6PvAF2drGw4ZcdopTLaWyVOxrTNGt9UL+DD7vrA=; b=2
	xB7YK2Onpc+Ul7QJ8QadlgCePBc4h01xnc8VeV7my0f4i8P2FVJ/irWW/4250TUj
	J8rKIm1wmsi6yRV0krfLK/OHq9HG5kOJa/0UHknyHJydGoRUOh7Mpz6MbaoJ2XsP
	tqQXFpntn8PSQ3tz4EGdmKYGxA+8SEMa3Gxz43moRpvDcVfo+kytw4P/na15CZrI
	uzPqQzx/HQ1v7/VMFkxTDv/y6teIR6QcZ/s64n1/xi5b9InYMKTHD7K7ZJ8Dk4Zi
	GLDsJq3sCp6KRMKgsFqc1ZU1xO1PnrN1NphkYLM3Z8wvOKNejfXKY0s0dXynqJtc
	dw/58p4qJNsnMPNYdAlOQ==
X-ME-Sender: <xms:RTWoaXYCv1DE6Etq7NwowMZxLqdZA50HHwXVut5wmdyj7cOfGURzFQ>
    <xme:RTWoaaFRw40je1mW5MJik3DJHholqMyLm0iOFB1ihU7EnuxEFv0AdrY4wjKz9wwPZ
    adgj7BsDWtUGMV_oOx1cd13DOhFhpvTgK-pDEMR3ScITFGy-rdn>
X-ME-Received: <xmr:RTWoaTzCr_69mtYlMQ_29u6ZCErWNo-8G7eMV1lI-gqNtsTtnFrXRS_nFolOjmJWFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieefiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeeugfevvdeggeeutdelgffgiefgffejheffkedtieduffehledvfeevgeej
    hedtjeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugessghssggvrhhnugdrtgho
    mhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepug
    hjfihonhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsshgthhhusggvrhhtsegu
    ughnrdgtohhmpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoh
    epnhgvrghlsehgohhmphgrrdguvghv
X-ME-Proxy: <xmx:RTWoaUkLlVSoD92CgDxkNv6RVCN8he1AI94jsIuNNTvbOXO9IyLE1A>
    <xmx:RTWoaUkzWwdAEfcyjvPf6VIFpuXen-dxnePXXP0yWfAZXz9iuf2P9A>
    <xmx:RTWoaeyKZDZTS6osoxp9Zsf-CblJoQJChyf_wXcdKS4o3AqzfvLZWQ>
    <xmx:RTWoaRqlN0VtoyvaPrSUCzX7yCXKajwcEid8XPxEVia7gHDdKFm1CA>
    <xmx:RTWoaexJP-VH60abIcPVyQhONHDHjjLkAlpCXQSH6oNrJQOFT-Z-QOHL>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 08:36:04 -0500 (EST)
Message-ID: <0d3d5dfc-6237-4d6d-abeb-e7adddecf2d9@bsbernd.com>
Date: Wed, 4 Mar 2026 14:36:03 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] libfuse: run fuse servers as a contained service
To: "Darrick J. Wong" <djwong@kernel.org>, bschubert@ddn.com
Cc: joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org, miklos@szeredi.hu,
 neal@gompa.dev
References: <177258294351.1167732.4543535509077707738.stg-ugh@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US
In-Reply-To: <177258294351.1167732.4543535509077707738.stg-ugh@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 243752008B3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bsbernd.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[bsbernd.com:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,szeredi.hu,gompa.dev];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-79363-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bsbernd.com:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernd@bsbernd.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bsbernd.com:dkim,bsbernd.com:mid]
X-Rspamd-Action: no action



On 3/4/26 01:11, Darrick J. Wong wrote:
> Hi Bernd,
> 
> Please pull this branch with changes for libfuse.
> 
> As usual, I did a test-merge with the main upstream branch as of a few
> minutes ago, and didn't see any conflicts.  Please let me know if you
> encounter any problems.

Hi Darrick,

quite some problems actually ;)

https://github.com/libfuse/libfuse/pull/1444

Basically everything fails.  Build test with

../../../home/runner/work/libfuse/libfuse/lib/fuse_service.c:24:10:
fatal error: 'systemd/sd-daemon.h' file not found
   24 | #include <systemd/sd-daemon.h>


Two issues here:
a) meson is not testing for sd-daemon.h?
a.1) If not available needs to disable that service? Because I don't
think BSD has support for systemd.

b) .github/workflow/*.yml files need to be adjusted to add in the new
dependency.


Please also have a look at checkpatch (which is a plain linux copy) and
the spelling test failures.


Thanks,
Bernd



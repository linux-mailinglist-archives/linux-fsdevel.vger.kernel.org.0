Return-Path: <linux-fsdevel+bounces-77002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iO/+FQ2ijWlh5gAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 10:49:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FF412C026
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 10:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4915330A0C32
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 09:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1782C234C;
	Thu, 12 Feb 2026 09:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="HrUJudG3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yyg7pROo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13FB2A1BA;
	Thu, 12 Feb 2026 09:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770889733; cv=none; b=qQzeRx+JW2lqpwxxeUKGIdxdJ5+2og9a2oyWaRYnHhLZmB58Qysajw6hScI9jJdRJXk5zgaWyJndBLn/GNwc+CHpejLCZxSOHkyx3H938KS1Ao2WF9y6aDjX5mYntL/pCgiGMCPPImaqBI22++15CVrpxg3v3J9mQ+6vXjyRVTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770889733; c=relaxed/simple;
	bh=hD0lkAh5BSVhWcPi9b1RpkGwyQbvz/wmvOExF+ZvG4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=npA8K9cGkNa1IbIfXDPzG/I5YA43CfYp56AFhsa93T+Nrb3TtIwGrWgg/9ngc3c1HrakPV5jZUxaEv5F6ZCIDIbJtgnSPUiyZRu3vRGKbdUwS1A+4DG9/faBG5OUg6p2Z0+2S9w+2DSbq43T6vtFklx76AHSbW5I7cKLGy9vBac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=HrUJudG3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yyg7pROo; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9760C7A009C;
	Thu, 12 Feb 2026 04:48:50 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 12 Feb 2026 04:48:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770889730;
	 x=1770976130; bh=H7yihoYeRLt0nKbeZEzZZ8rWMnZAbmFXawWreuTtdxE=; b=
	HrUJudG3ktoltjAL9YTLeOlwkiEnd5rcvyT5GYtV27UaGCo/NASeiuLoaW4fSgyR
	sfckBHbfSAZY5Mkh5dLURYG2nRtvTbggbc/fzsYIe8bAqx5a7EtAgUPcyTSJqsbM
	R6HOqNfSy+xi2ZkKmDyvcmM7bcEou/ojAMVdqagBBlIeiinuV3DQSqEYDVx7UWOv
	K9vCsXI/ncPIfdVHTCwGGYPPUTSock2Woku0uzasklLRAZsbmLU4PetkTS3e12mx
	WS5QEwcJfRgrU1EeVCndvAa0fgToKVZZR8r0f0jsLaZw5BUJgOAV/Nuls/DaVGrD
	+ve9NwZ0qh5FDb3WE2vbuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770889730; x=
	1770976130; bh=H7yihoYeRLt0nKbeZEzZZ8rWMnZAbmFXawWreuTtdxE=; b=Y
	yg7pROok4EGodgmLeQANQJE6sk/klTl9ADOUCm3qBMwnZGhkeJs6+IsOKyACFVRy
	YCnAYNBJO6Y0H4rhM6jABuQ34s8QwinFHraIp4KGpqSoml1bysGIpORAog/PCEQ3
	LwIBchN58d7kY2LyHi+YTRQZeMH0q1/4Ii+cRfGWUk+yhXurDzhxbD/Rw1pSjauN
	hTAM47HbFt8UCfIE2jOG7z/wN+EYlhP+jjSXMmnbaOL65RNHMgngBrPJ6fdbMUti
	oYAbnt4xKey7m0mmGlHPRcbAOuCWxQPhUrfNDhb7MF4kq+4C12mqrmmZg3QlGh5U
	o9L4FZzKsqTrlTs0/lQIg==
X-ME-Sender: <xms:AqKNaaZmNqOXd5eBcYFE7uDLfTuLThvfIrzqqSbD1LDTd54SiPip0Q>
    <xme:AqKNaXb2U2jRidbga6ZIhFCdGkagiSQekO0_4XCjRVGMLXj48XE_lWy4r5b2qe66g
    2QsDRpwT9-IjU1yAX6wYF0sCHQRIPOcfxE5tk7F6AFJkVCNZ4mU>
X-ME-Received: <xmr:AqKNabmCNIw1cM1Gz_lAAy7u-F8zMn18mc7Ze78Ns5JjAbl1Ck_OiGe23lEtwbBu8CY6Wpx36-2_K_IEKjtZ4cBJabeJnhLKNQZHQA-1fAi2REW4Gg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdehtdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtg
    hpthhtohephhhorhhsthessghirhhthhgvlhhmvghrrdgtohhmpdhrtghpthhtohepsghs
    tghhuhgsvghrthesuggunhdrtghomhdprhgtphhtthhopehjohgrnhhnvghlkhhoohhngh
    esghhmrghilhdrtghomhdprhgtphhtthhopehluhhishesihhgrghlihgrrdgtohhmpdhr
    tghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehhsghirhhthhgvlhhmvghrseguughnrdgtohhm
X-ME-Proxy: <xmx:AqKNaa3cEbGZfVG5Fn-CE-d6EmC39Q7M8BTQq4vr2cwsE0DFZA6DCw>
    <xmx:AqKNaT20HWlDCsC6roTx5urzJztQC4U14y5o-_YeeVBqeUEodjxOfA>
    <xmx:AqKNaUpshLLU_mMVclQe5Ff-YZtkwgMmrXXyZoXDxowhHCMXK3BGBQ>
    <xmx:AqKNaXhsAoNMDJp79GWBomiBtIoQjxOJyrJI1PR3uipLbOCDDs8TCg>
    <xmx:AqKNaVQuFRhpDhE4jAr809P2obk77Q1m_f3aFaVgj8-gwPuiP5ocpxG5>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Feb 2026 04:48:48 -0500 (EST)
Message-ID: <bb5bf6c8-22b2-4ca8-808b-4a3c00ec72fd@bsbernd.com>
Date: Thu, 12 Feb 2026 10:48:47 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] fuse: add compound command to combine multiple
 requests
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Horst Birthelmer <horst@birthelmer.com>,
 Bernd Schubert <bschubert@ddn.com>, Joanne Koong <joannelkoong@gmail.com>,
 Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
References: <20260210-fuse-compounds-upstream-v5-0-ea0585f62daa@ddn.com>
 <20260210-fuse-compounds-upstream-v5-1-ea0585f62daa@ddn.com>
 <CAJfpegvt0HwHOmOTzkCoOqdmvU6pf-wM228QQSauDsbcL+mmUA@mail.gmail.com>
 <f38cf69e-57b9-494b-a90a-ede72aa12a54@bsbernd.com>
 <CAJfpegscqhGikqZsaAKiujWyAy6wusdVCCQ1jirnKiGX9bE5oQ@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJfpegscqhGikqZsaAKiujWyAy6wusdVCCQ1jirnKiGX9bE5oQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bsbernd.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bsbernd.com:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[birthelmer.com,ddn.com,gmail.com,igalia.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77002-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[bsbernd.com:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernd@bsbernd.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A6FF412C026
X-Rspamd-Action: no action



On 2/12/26 10:07, Miklos Szeredi wrote:
> On Wed, 11 Feb 2026 at 21:36, Bernd Schubert <bernd@bsbernd.com> wrote:
> 
>> With simple request and a single request per buffer, one can re-use the
>> existing buffer for the reply in fuse-server
>>
>> - write: Do the write operation, then store the result into the io-buffer
>> - read: Copy the relatively small header, store the result into the
>> io-buffer
>>
>> - Meta-operations: Same as read
> 
> Reminds me of the header/payload separation in io-uring.
> 
> We could actually do that on the /dev/fuse interface as well, just
> never got around to implementing it:  first page reserved for
> header(s), payload is stored at PAGE_SIZE offset in the supplied
> buffer.

Yeah, same here, I never came around to that during the past year.

> 
> That doesn't solve the overwriting problem, since in theory we could
> have a compound with a READ and a WRITE but in practice we can just
> disallow such combinations.
> 
> In fact I'd argue that most/all practical compounds will not even have
> a payload and can fit into a page sized buffer.

That is what Horst had said as well, until I came up with a use case -
write and immediately fetch updated attributes.

A bit side tracking background, I disabled auto-invalidate in the DDN
file system, because we use DLM anyway (additional patches for
background writes and mmap in our branches, should be published to the
list asap). And then that disabled auto-invalidation introduced another
xfstest failure, I think generic/323, but I would need to look it up. I
didn't have time for the details yet, but I think page read beyond EOF.
And that made me think that all operations that change file size and
time stamps could immediately return the updates attributes, if the file
system supports it - with our DLM we would support that.

> 
> So as a first iteration can we just limit compounds to small in/out sizes?

Even without write payload, there is still FUSE_NAME_MAX, that can be up
to PATH_MAX -1. Let's say there is LOOKUP, CREATE/OPEN, GETATTR. Lookup
could take >4K, CREATE/OPEN another 4K. Copying that pro-actively out of
the buffer seems a bit overhead? Especially as libfuse needs to iterate
over each compound first and figure out the exact size.


Thanks,
Bernd


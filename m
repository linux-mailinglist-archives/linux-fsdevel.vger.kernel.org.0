Return-Path: <linux-fsdevel+bounces-72954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0736D06693
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 23:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABA8830248BD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 22:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E19D31A54E;
	Thu,  8 Jan 2026 22:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="PqmrVP5j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qFtc8Vaq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7972D7810;
	Thu,  8 Jan 2026 22:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767910483; cv=none; b=Y6NzVMXiJnRxOSKsF1w26pvXf51H9TCHIKUGqo6IXBJQWz2NllDmXtMOSPoaEt0j3ttu8WCUuoYIelXU8W7YwNi4Q3MXYaIzTFuBVSBuIDkiWN8AkjoZSoV1cLV/zBWbRZCVcRiarTJNV8Q6pHpaVghMSxzXTnhd7kM3ZtNPg40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767910483; c=relaxed/simple;
	bh=KyXdhOBO7ELIBlvxWOTPpsOAE0Y2dyGPoQf8W7G5B1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TVUMHTUAsDbPE+jkologvAsCRRPuQXc7jGVBRc4G5FI9GOUNilEIy0ggCSyaBOLJ7rdyFLRBoQ2ZAA60hizRYy9pu4la8AmHzFwmPPgRLefFoh87Yvq5DPww+2h7qN6cYfUsKAwehisM0R2i/wG2h67LeWj3PmcPQkfCN94I1KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=PqmrVP5j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qFtc8Vaq; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 0A6BBEC0166;
	Thu,  8 Jan 2026 17:14:41 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 08 Jan 2026 17:14:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1767910481;
	 x=1767996881; bh=KsGSlJ1qvguO/TfJ7fNQRnfb03EW2ZCreKoAKMZ7/Lo=; b=
	PqmrVP5jFzn+4UiX0QRZEAxpMmImvPUYZBP+atOH8aN3sHKWTL5PV7P/MapeYs5i
	Yn6scyOBm6c52AMfJACrLKhSpvQjoA3Pd+tVy4X56qXVW6eHEl6UmW9Lrd5zY0Y2
	IPb4gHl6unfTZyrNO7P600q/KNrCDl7TAaFxBbCt26pcnvKrnv5vHd8eW3Fx5xtH
	nRMWagrdiO66CdBlV0VlnZbCywGaH022KUhZxuq8JkUH0Du9Leg13oeN7OpbIvQh
	Yl01d0tFANIYKukg9WPzq6OwXxWwj0svoMMZg+fFoNiWzb+pEG1DJ/u4ZDlPxVud
	uyZBCBXFpbtLnfGm0ZeFsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767910481; x=
	1767996881; bh=KsGSlJ1qvguO/TfJ7fNQRnfb03EW2ZCreKoAKMZ7/Lo=; b=q
	Ftc8Vaqny7bT0SGTTc2AcEMUyQy10ET5Lnr7WHZlLx5Uyw2uDWOAwaBgDe8fhSky
	r9W6Ymc6hiWcmrcFsRoC7qa2KYc4sgxW6NLbw48TZ/AIphismYrPnnv/cSocgCvH
	YXAyGXer1NMgUMFbHK4/nvcAFJLMvuGDIbSG9H7m/mKPxHQyS8ie8TSsuElwFbMq
	wTmeK/559H7isA1yqOgbd7r53kUGE7vX8z7oEh6YXl9VZkoVnprxa3bIm7/ZLjmG
	jDOLfZVMZCKtl7ilPMrG81ftXW3WDrMNnICj5hyvNQAgCg/C4kFFCdgKE8CJiLwI
	01vSIHPWqF2kvq0Nd3Sow==
X-ME-Sender: <xms:UCxgaWhI1cl70qZ2SV5fNMYUQARUvd4YVURCYvhcfWW0A6FSzv6C6Q>
    <xme:UCxgaYhuXgTTq-4paAPhqJcqCyFR3gnKp14LFHvUY_pLB6FCPFpRf-ZxeLdyg-hi6
    psaL1wCNK4oGr4l0obnh2sWp6li7XhpG-DJr8TaIqHn3hDZoVs>
X-ME-Received: <xmr:UCxgaeL8-L3DaNlOxpVIPXSMmJr86nPYbFGSSmxp8oAeRzc-Wg5JgrK8LwM4ZHovHxtJ0gs0g3zy1dBVmJh5n8FSUzCD9hH5IUIFJ9bhRJOvIG0cog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdejuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeefgeegfeffkeduudelfeehleelhefgffehudejvdfgteevvddtfeeiheef
    lefgvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrrhhnugesrghrnhgusgdruggvpdhrtghpthhtoh
    epthhhohhmrghsrdifvghishhsshgthhhuhheslhhinhhuthhrohhnihigrdguvgdprhgt
    phhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheplhhinhhugi
    dqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:UCxgafERi7ajkXR3YQ0rnPS3EwU2xT0CiUNFmv6h782aUmmJHIgTVQ>
    <xmx:UCxgaaRxuom71CAcn7eF9KRWAJn7jGAfIxV1S0-AsAe_GNJLSDQcag>
    <xmx:UCxgaTf8HBnzuzzAATJCLueGidyseHxp9NkvfjvgVrnAUrh_Cx8xpA>
    <xmx:UCxgaRooaDlw4h6o19IsgwQBQh_At_LsWjHgI0qX8iQuJ-cplRRVGA>
    <xmx:USxgaf_dXMoyipc1tliL9e34hBVI0bes5BuqEZswkNXlK7LXWGT5KcjN>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jan 2026 17:14:40 -0500 (EST)
Message-ID: <97ed3c52-ca12-4edb-8a3a-acc99c23857c@bsbernd.com>
Date: Thu, 8 Jan 2026 23:14:39 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fuse: uapi: use UAPI types
To: Arnd Bergmann <arnd@arndb.de>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251230-uapi-fuse-v2-1-5a8788d62525@linutronix.de>
 <8efcbf41-7c74-4baf-9d75-1512f4f3fb03@bsbernd.com>
 <b975404f-fd6d-42aa-9743-c11e0088596b@bsbernd.com>
 <20260105092847-f05669a4-f8a1-498d-a8b4-dc1c5a0ac1f8@linutronix.de>
 <51731990-37fe-4821-9feb-7ee75829d3a0@bsbernd.com>
 <2c1dc014-e5aa-4c1d-a301-e10f47c74c7d@app.fastmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <2c1dc014-e5aa-4c1d-a301-e10f47c74c7d@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/5/26 13:09, Arnd Bergmann wrote:
> On Mon, Jan 5, 2026, at 09:50, Bernd Schubert wrote:
>> On 1/5/26 09:40, Thomas Weißschuh wrote:
>>> On Sat, Jan 03, 2026 at 01:44:49PM +0100, Bernd Schubert wrote:
>>>
>>>>> libfuse3.so.3.19.0.p/fuse_uring.c.o -c
>>>>> ../../../home/runner/work/libfuse/libfuse/lib/fuse_uring.c
>>>>> ../../../home/runner/work/libfuse/libfuse/lib/fuse_uring.c:197:5: error:
>>>>> format specifies type 'unsigned long' but the argument has type '__u64'
>>>>> (aka 'unsigned long long') [-Werror,-Wformat]
>>>>>   196 |                 fuse_log(FUSE_LOG_DEBUG, "    unique: %" PRIu64
>>>>> ", result=%d\n",
>>>>>       |                                                       ~~~~~~~~~
>>>>>   197 |                          out->unique, ent_in_out->payload_sz);
>>>>>       |                          ^~~~~~~~~~~
>>>>> 1 error generated.
>>>>>
>>>>>
>>>>> I can certainly work it around in libfuse by adding a cast, IMHO,
>>>>> PRIu64 is the right format.
>>>
>>> PRIu64 is indeed the right format for uint64_t. Unfortunately not necessarily
>>> for __u64. As the vast majority of the UAPI headers to use the UAPI types,
>>> adding a cast in this case is already necessary for most UAPI users.
> 
> Which target did the warning show up on? I would expect the patch
> to not have changed anything for BSD, since not defining __linux__
> makes it use the stdint types after all.

Sorry for late reply, default Ubuntu x86_64 target.




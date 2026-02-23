Return-Path: <linux-fsdevel+bounces-77984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LQgIxWFnGm7IwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 17:49:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6265D17A229
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 17:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 11EDA3022986
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 16:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C4C315D3E;
	Mon, 23 Feb 2026 16:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="PZGo6PtE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H+z0zVvw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2408E2EB87E;
	Mon, 23 Feb 2026 16:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771865340; cv=none; b=MC+kIaSbQjzq6jUhOswyba2gixwM6z9tec+zbrq/vjbF1XeFknsQNeB98okPeR7BhQIwp6bc9Z25s1FekK8xJjmao6I5z3+n2EiXMS5mkeT07VrdGPNqAEWrKF9aNY2bJld4Bc+mRg1F0OEqrQNREpqAd6Mm8xieAMvJ1bwzI+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771865340; c=relaxed/simple;
	bh=yZKQV2mpfM4iDzIQsKdy6kTUemeDFyoF9+Q3IM7/VDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P4K7jADGX+ofHAc/CkJLA0mkywTzMbvpuCivXf58Ef4Fai0+IDDgRfhHFReIpsJBJIxdvrcxmat/audJMfnGruqDgdPNYt1etaDwmutVZ6o21t4M0KfIMOD+3qYuG8Ta/Lf4Xzchhd8Ghujgqp/DJDZOI17rNBbrvh6r6/DHRgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=PZGo6PtE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H+z0zVvw; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 4DD2A1300CC5;
	Mon, 23 Feb 2026 11:48:58 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 23 Feb 2026 11:48:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1771865338;
	 x=1771872538; bh=SgyJEL0qpQ94qCoEm7lHBgWoF3B64V+GFWj6Q/R4J4s=; b=
	PZGo6PtEpJSEwl87fgpkl4/ThYM25Q7hLy8N15Rdb/9R//SS82yALwMnkjEa8ZUS
	SSnKw9rcCp5w7nOxSb4K7MYhCcS+yqTvOZUpshvsbJrUXnBVYPGaPszV2zDtiMYZ
	WuDIDCpPx8Jq6MXq5B3fyR37U2BV+oYeUAOHUgAsXDnUFK9PCBtJiVIx6a6rl2Wc
	lyvr8muaxh00rGhG2vNLNl0ak2FKBQOdCRsEf+KgUlyRX59CaCSfB5qMhpvGcDbw
	7kyjWUKG0RNfBNNwP/wWXIO/qLaiHRtizY7GsJBXPBEQE+MBFDjADCrhNGlmmVzE
	GeinbVQPVKRgMuFB1sJTIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771865338; x=
	1771872538; bh=SgyJEL0qpQ94qCoEm7lHBgWoF3B64V+GFWj6Q/R4J4s=; b=H
	+z0zVvw+ImGK9X2q/Z0ojf6pOn+7n29b0VTkthW/aEXCp2+U61wBiAXl3gwsX/Rf
	YRRxFQmgY+lKXSIxOcTHXOSlPhGffB75O7E0pYiZvGM4oNQRR/gaiTf9dg42Oama
	j4X+o2Gb5AWka/rC6MkHRDXnUi/9zdhBCVJjPaZ/z4cOighh2xkw1W3zvCwpIbcN
	rlNNP0cMh/pQILtPwN/rFwdVRHplJI0/plju3zS27vYVHEYb+t1AXYEsezq+5u0Y
	jSwy7XTYRcif8IsGXFa/APgzEE8i6pJyR2tgrvzHdoKDWmFSEvHgY4Z7i+iZZrYD
	DFMUUiGToVSPHqQLI9YeQ==
X-ME-Sender: <xms:-YScaVGKbypzPa8QBM72gd3CFthlNhtn-gibbY1mUJQfQw5ScFDg-A>
    <xme:-YScaUXIV31o2OsNEvUkg_ZA-bBsipAxaCqbp-ZW_-Himk9ImIBPGyU5j84zPDAZz
    shNkmAgC-STyNGzoQhlZJkM1jBLCHZ5wB87ioNZ_HZbNSbLK3Zx_g>
X-ME-Received: <xmr:-YScadzRKNqKX1ASeETtIgfGkm67JIzLzxJ583V3sQ4h40tNg9gBtBujLzoIQ9t7Sw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtg
    hpthhtohephhhorhhsthessghirhhthhgvlhhmvghrrdguvgdprhgtphhtthhopehjihhm
    rdhhrghrrhhishesnhhvihguihgrrdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsug
    gvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhk
    vghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmghhurhhtoh
    hvohihsehnvhhiughirgdrtghomhdprhgtphhtthhopehkshiithihsggvrhesnhhvihgu
    ihgrrdgtohhmpdhrtghpthhtoheplhhuihhssehighgrlhhirgdrtghomh
X-ME-Proxy: <xmx:-YScaZQAda-QIpfaF89fXiQ5IB-SBvOoAsaopI12tgPS1dR_EuGmAA>
    <xmx:-YScaZiHiTYS_WxlWZ1P-knJLXttqDIOjQTlTA2PTicQPAAs6s7Ddg>
    <xmx:-YScaQksNcvKg7rBHFHrA8xFuTQNYIu7ZmTVuliqhj9XFGXlMihNVg>
    <xmx:-YScacuqnThy92owbTGZOQ9q0otqd8gqzPnWhHZ3gkquby1B66UEYw>
    <xmx:-oScafu5X5D2MZFY8XzoeUD4An4Jg62GLCmw474ON_UOxoJ5ZUbjc6Go>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 11:48:54 -0500 (EST)
Message-ID: <82c136b9-a198-4ad3-a386-9dbb9df56d9a@bsbernd.com>
Date: Mon, 23 Feb 2026 17:48:50 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: skip lookup during atomic_open() when O_CREAT is
 set
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Horst Birthelmer <horst@birthelmer.de>, Jim Harris
 <jim.harris@nvidia.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, mgurtovoy@nvidia.com, ksztyber@nvidia.com,
 Luis Henriques <luis@igalia.com>
References: <20260220204102.21317-1-jiharris@nvidia.com>
 <aZnLtrqN3u8N66GU@fedora-2.fritz.box>
 <CAJfpegstf_hPN2+jyO_vNfjSqZpUZPJqNg59hGSqTYqyWx1VVg@mail.gmail.com>
 <fa1b23a7-1dcb-4141-9334-8f9609bb13f7@bsbernd.com>
 <CAJfpeguoQ4qnvYvv2_-e7POXiPeBR2go_J68S2E6c-YW-1tYbA@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJfpeguoQ4qnvYvv2_-e7POXiPeBR2go_J68S2E6c-YW-1tYbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bsbernd.com,none];
	R_DKIM_ALLOW(-0.20)[bsbernd.com:s=fm2,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bsbernd.com:+,messagingengine.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77984-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernd@bsbernd.com,linux-fsdevel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bsbernd.com:mid,bsbernd.com:dkim,bsbernd.com:email]
X-Rspamd-Queue-Id: 6265D17A229
X-Rspamd-Action: no action



On 2/23/26 16:53, Miklos Szeredi wrote:
> On Mon, 23 Feb 2026 at 16:37, Bernd Schubert <bernd@bsbernd.com> wrote:
> 
>> After the discussion about LOOKUO_HANDLE my impression was actually that
>> we want to use compounds for the atomic open.
> 
> I think we want to introduce an atomic operation that does a lookup +
> an optional mknod, lets call this LOOKUP_CREATE_FH, this would return
> a flag indicating whether the file was created or if it existed prior
> to the operation.
> 
> Then, instead of the current CREATE operation there would be a
> compound with LOOKUP_CREATE_FH + OPEN.
> 
> Does that make sense?

Fine with me, but I need to process a bit if we want to that lookup to
return attributes or if it should be LOOKUP_CREATE_FH + OPEN + GETATTR.
Currently in the wrong time zone to do that today and also not much time
in general this week.


Thanks,
Bernd


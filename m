Return-Path: <linux-fsdevel+bounces-76349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOm+MIewg2l1swMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 21:48:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFEFEC92D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 21:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D089D3013EC6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 20:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3177A43C041;
	Wed,  4 Feb 2026 20:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="opFEprRT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EwkR12nX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A42438FF0
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Feb 2026 20:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770238084; cv=none; b=HoqTKqGjl/6JUcZvolGvvem1hPQHwJKX1AMOR+qfgk5A+deXNO6tQhLaILuY1qVCnesCq/k2BNSBOOseh9CbdPzWHfdg08tPVGPgVTR8SniuRUZOc9ZIAIZLk58m0nUhEHkGvQXJmzSGmcCdXhi6RJF3AkwMcaryscQ572QmX34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770238084; c=relaxed/simple;
	bh=OIVK1WNTokJUiYCQtjO2PSxxRS0Igut+M1dTHI3IaVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jINEwFgVNZr+oUwvQh0naozCrKm3X5onoMORotftvlcnntdSHO3byakJ+kuBjP45GVZTAA7u7nAUGG6SIwrcMURiaF9nSVMdvJRklNxwNx+G81MofZ7bHgopSo6kZhQFHmbWDmpAcRsf3RyzCOQjOtTTGUr/GNGN6hLbubIpbZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=opFEprRT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EwkR12nX; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4D7D7140007D;
	Wed,  4 Feb 2026 15:48:03 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 04 Feb 2026 15:48:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1770238083;
	 x=1770324483; bh=1U1mY9+dO3/EG1E8wzcgUrCCPNsC2zedZxHvhA79k+s=; b=
	opFEprRTyUYL1LWuKFsxxTqjlbwJF8iQ0J9SlG4IjLDPCica9xenKSYMA54X2aHm
	OjddUDo2/ZsU80FHsmfO04PB59Ip+zYJFMHSnBnkJV4gg0qWQ7RDB3L21REh8QJZ
	bpqezwn8RB+YuLzISwVtX0XtDUJb6nX9LvSb/Rncbmuu1VdEfeFq6WTiUecRj8CJ
	yS/Tgpkv7tVV6oM/qVtMZti79NyqmRHMThsIMuG31+7KxdIPHWPfPOj1BSGtKRpT
	H0We6CA+yX3joLR3h6B2Pn8LfWGVZ0N1+QbylbERszXKP7eCHKY4S53M/mutFNJ2
	R3FjbaR7XrY0d78iBfsSMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770238083; x=
	1770324483; bh=1U1mY9+dO3/EG1E8wzcgUrCCPNsC2zedZxHvhA79k+s=; b=E
	wkR12nXSkDnpo9lG8w1H5jP2p/qJ4KKYLX/Ia0mlJsud/4w4dA8x8A9FZ8BpBQre
	AlJfqlG81jcaWPfdERCH3J4DHyGR4QkXhoK2PkNYsq5ZO04ON+m7taBP4BQS0oz3
	es3+x0MeOxjHPJExO0tZ37s6rBWqcr1MoYWEBmcCuDRx4/QnAmnSbdPQGFICkl+n
	AbnYNFzgWDskZ7S5hplxQFnHwwgQiAlRkJR/h9gDMWU1bgzVz2vgN2mXfjqXaC60
	KzDDco47dON9RtQ4Lrd0CefG8LHDs2RB9x/wMSejP/xwYNrYYtqMSx5AqrqHhrLn
	2cfLa9a5Fi+AvEjce/bEg==
X-ME-Sender: <xms:grCDaf3lXt5JxFl4FStaQnY99zbqjJkY2SOJE69fBUngf0QrXaEEUw>
    <xme:grCDaTDw0WmTTcAuM3hI-iUOfV0Bb8_JQ2eGepygc02L8GsuWAZPEmjRX-vx-K-vs
    A2sRs-otxA-lY1aV0ivIpMxmrkoM-gMXrUO4GSXwFmNmZH2Tgs>
X-ME-Received: <xmr:grCDaUKU7jnIQzmZ5kRCUGtnYsRE1ifyY3BQUYy4GazdkOLZkvyOSihZaT_TxSpXTSNjTLtGEF5PZ8rYAnZg-X8G9cE0R29JWPutAhpTuRjtbkOiSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeefgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeefgeegfeffkeduudelfeehleelhefgffehudejvdfgteevvddtfeeiheef
    lefgvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtg
    homhdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohep
    rghmihhrjeefihhlsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsug
    gvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegujhifohhnghes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhhnsehgrhhovhgvshdrnhgvthdprh
    gtphhtthhopehluhhishesihhgrghlihgrrdgtohhmpdhrtghpthhtohephhhorhhsthes
    sghirhhthhgvlhhmvghrrdguvgdprhgtphhtthhopehlshhfqdhptgeslhhishhtshdrlh
    hinhhugidqfhhouhhnuggrthhiohhnrdhorhhg
X-ME-Proxy: <xmx:grCDaUkiQv4wLIW-DsK7LGQtBGxbj4bl9Tm8QzXsV26il0FnMm4pxQ>
    <xmx:grCDaVYrSV9ni0PsVuCmI-RbNl3T077F1LH_saakps2Hpu2WkQYBUQ>
    <xmx:grCDaY-eKk5FvnsRFlqlEAWETVh9xVbUv4amGGOd5QY9TP42UCiEBw>
    <xmx:grCDacY1FDQt7J2xMaK5A5wj06z1QWawbDKQlwsqZ7dSh_PZ482bmA>
    <xmx:g7CDafUF1gvhiht3Fk71sQUO0UUNdyovRoqXmxQ7BEGF0PSP2ElGRdo3>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 15:48:00 -0500 (EST)
Message-ID: <6d3cfc5f-5f27-4b20-a28f-add3c9637c48@bsbernd.com>
Date: Wed, 4 Feb 2026 21:47:59 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
To: Joanne Koong <joannelkoong@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, John Groves <John@groves.net>,
 Luis Henriques <luis@igalia.com>, Horst Birthelmer <horst@birthelmer.de>,
 lsf-pc <lsf-pc@lists.linux-foundation.org>
References: <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com>
 <CAOQ4uxjEdJHjbfCFM364V=tBrEyczYvzo-b-Xo0UPOCA2cnPGQ@mail.gmail.com>
 <CAJfpegvg=hqM1vMCyrb61VT6uA+4gdGwvqHe5Djg2RF+DTUMiw@mail.gmail.com>
 <CAJnrk1YKDi9e-eTQyGBD-rFScxGTcsfz3tnmnE_EshPd18aMrw@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1YKDi9e-eTQyGBD-rFScxGTcsfz3tnmnE_EshPd18aMrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bsbernd.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bsbernd.com:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,groves.net,igalia.com,birthelmer.de,lists.linux-foundation.org];
	DKIM_TRACE(0.00)[bsbernd.com:+,messagingengine.com:+];
	TAGGED_FROM(0.00)[bounces-76349-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bsbernd.com:mid,bsbernd.com:dkim,messagingengine.com:dkim,szeredi.hu:email];
	FREEMAIL_TO(0.00)[gmail.com,szeredi.hu];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernd@bsbernd.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 0CFEFEC92D
X-Rspamd-Action: no action



On 2/4/26 10:22, Joanne Koong wrote:
> On Mon, Feb 2, 2026 at 11:55 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>>
>> On Mon, 2 Feb 2026 at 17:14, Amir Goldstein <amir73il@gmail.com> wrote:
>>
>>> All important topics which I am sure will be discussed on a FUSE BoF.
> 
> Two other items I'd like to add to the potential discussion list are:
> 
> * leveraging io-uring multishot for batching fuse writeback and
> readahead requests, ie maximizing the throughput per roundtrip context
> switch [1]
> 
> * settling how load distribution should be done for configurable
> queues. We came to a bit of a standstill on Bernd's patchset [2] and
> it would be great to finally get this resolved and the feature landed.
> imo configurable queues and incremental buffer consumption are the two
> main features needed to make fuse-over-io-uring more feasible on
> large-scale systems.

Coincidentally I looked into this today because we had totally
imbalanced queues when this was activated - slip through in the queue
assignment, should be fixed in our branches. v4 basically has all your
comment addressed, our branch(es) have 3 bug fixes now to what I thought
would be v4 - unless I get pulled into other things again (which is
unfortunately likely), v4 will come tomorrow.


Thanks,
Bernd


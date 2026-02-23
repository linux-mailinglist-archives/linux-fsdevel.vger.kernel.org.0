Return-Path: <linux-fsdevel+bounces-77981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EC6hIO6GnGm7IwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 17:57:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7F217A381
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 17:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC69731975FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 16:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF2F30BBA9;
	Mon, 23 Feb 2026 16:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="bKsFHwmM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nOKlgPq0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB129319857;
	Mon, 23 Feb 2026 16:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864893; cv=none; b=ZZMSrnYICSX13/qBhZCk/7U1C2UusX140aknvJKlPuDPartZJUcleJjBZqhvNspeLyOuQ38NYdu2HkWMKZ+sWkQJ4oBZ9t061J7M5Fm+WmUYoP+wDypOviIIz7Lw1hIrtu/j3UaLUnLNufjfRnPeqGENCZOpLOL/a6NBFyIHBZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864893; c=relaxed/simple;
	bh=rofHlyscVixKgf1FEKFDpIDDW2u8idFiC59ENbdtkIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IGwDTFxOZmGiDd0j3F+8m5/dq6QUjfTrnOgtQK8G8B+UsE5MUuPP6G/PL+CNjvsSyEsxIcz39JH0k6BVJ712wchD/FbdwLy+84q94y+iQGC52E0iN0IS76NLzGAihq7o9iv0grquYcggooWplai3oUTLlrSq62YPqTiYOqnYclM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=bKsFHwmM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nOKlgPq0; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 9A3C11300DB5;
	Mon, 23 Feb 2026 11:41:27 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 23 Feb 2026 11:41:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1771864887;
	 x=1771872087; bh=8a6j6M0tf+i8MfAQ2TV1Q4pC8GqD34qwzwYAqy+MN8k=; b=
	bKsFHwmMY4m1J/AFr3QJ3vBdVaUg0T6D2Gksrpfr81Kj/emy7hfjnTa+AG7Hb9YX
	QExgCzqVOg+EW6FFxEdgvDu+n0kEnlLy4kpS7ndMfA6fmDOlhWDlpYkfyxySA+3d
	ryjilvVwKhILUG92pLp4TQunXvaHaAR4msP5ErSpQkWKUiXKlb4WiysS8ZFt8Kc4
	uBju0jo45feP10sipYI/g+P3o/zcz2bnP0TEYiTq4nmuNwnR50xwYQpY1KMobJxG
	notECBQtfUR3bT6w5bTr1eaYvcbXpIyu1QsQV5zrbOkIQbjQPYguGcYqa+oQBW3B
	LHeXYvYqDTWH2E9YwvqtFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771864887; x=
	1771872087; bh=8a6j6M0tf+i8MfAQ2TV1Q4pC8GqD34qwzwYAqy+MN8k=; b=n
	OKlgPq0n4u5x7uVjai2dgXar8ZFnBozsHZ++POrOdJcdBrt9WT6ovWyLmpDYEaHB
	8t/LUl963F0LH8I4Juh/8bFxbcbcqcX+e9TKDXUHcbb50xwiAttbRZO1fD/V0Cwv
	+t23HTRiDu/RYyosDOdqtEF4BYoDB5eDEpyk2JbvE0byr5YaiCsFMQeOkWUeW3xZ
	cO+fWfxlCirSAuiQBjmnpGzk//Vdd7gEuywRINwbF5vN9TzQMuK00ccciD7zkre2
	9XKitagPvhlvm/SHKObFCdh2XBQUQMPwEOOS+DT1lWA5NUrOAiSOBOLVmEsNc/yD
	01AZ2Z8KXM93/vWcRHYDg==
X-ME-Sender: <xms:N4OcaTy20niKksR9amhsmfQjhbuUAU38t9aOfhs6QQS18iITeVPEkQ>
    <xme:N4OcaUnvrqyabAaDPtP6_Q81y20RLenL2q0eONNNRPSYxjG5JxeC758HZSgh7I4D-
    1Sb1Iy4mjJ-dCN6Cu1T8U32vib9Q2goCDTwlmB3AhuWtpzVZlnR>
X-ME-Received: <xmr:N4OcaUlHOf0u8qR-dHSPNGnWAoXdDBJtcV6fNZBMniHdl676sxLitFK2KrQuVWM9c39y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjihhmrdhhrghrrhhishesnhhvihguihgrrdgtoh
    hmpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehl
    ihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepmhhguhhrthhovhhohiesnhhvihguihgrrdgtohhmpdhrtghpthhtohepkhhsiihthi
    gsvghrsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:N4OcaewO69tj8Xhb80oLIzEzDg5dLp382cqAUB_60FXUmqPvV2xE5g>
    <xmx:N4OcaRrZFUou4lF0m-e_os5ReUPn9NN93Owx6tONzSiQUSSO9T11tA>
    <xmx:N4OcaV7QINt2N7Iy6lSui0u46Mhql3r-uOOFdOrECxv3bVWd0sH5mA>
    <xmx:N4OcaQcIGU74srrUaIHFdw5sufPCJDKrIf3m_fnGs2WgK1xD-MgRQQ>
    <xmx:N4OcaRpiy-FffISfrhGnZTES3XJx7ZT3cRWmQ019X9vSxv2lPWVMogCv>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 11:41:24 -0500 (EST)
Message-ID: <a021f05c-a1bd-4219-b388-90437b4c587f@bsbernd.com>
Date: Mon, 23 Feb 2026 17:41:21 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: skip lookup during atomic_open() when O_CREAT is
 set
To: Jim Harris <jim.harris@nvidia.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 mgurtovoy@nvidia.com, ksztyber@nvidia.com
References: <20260220204102.21317-1-jiharris@nvidia.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20260220204102.21317-1-jiharris@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bsbernd.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[bsbernd.com:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-77981-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[bsbernd.com:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernd@bsbernd.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bsbernd.com:mid,bsbernd.com:dkim,nvidia.com:email]
X-Rspamd-Queue-Id: 1F7F217A381
X-Rspamd-Action: no action


On 2/20/26 21:41, Jim Harris wrote:
> From: Jim Harris <jim.harris@nvidia.com>
> 
> When O_CREAT is set, we don't need the lookup. The lookup doesn't
> harm anything, but it's an extra FUSE operation that's not required.

Problem is that it is a change of behavior - it might cause issues for
some fuse server implementations that expect that a node-id was obtained
before open of an existing file is done.


Thanks,
Bernd


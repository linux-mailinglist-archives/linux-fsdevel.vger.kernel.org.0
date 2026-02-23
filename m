Return-Path: <linux-fsdevel+bounces-77973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yANpFod1nGmwHwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 16:43:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C8060178ED7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 16:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB72F303E74E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 15:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A63C2F28E3;
	Mon, 23 Feb 2026 15:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="Z5rEfwE7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cXrhNPjK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECF42EC090;
	Mon, 23 Feb 2026 15:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771861022; cv=none; b=MX0xv7eBeqrb2YTafrA2pyD/DSIs5a+bOqewYiyjGK1eR5t02bCS7KhR7YpRY/B+ZkUFRGwauwqDtAYCMG5G65HWBWmPL2obXG9XRmKGvqNuCZSlti0AjBH2eFB5rA7ii5RKouDRHhxWcph/YgMcJUADfewf3+wNQY6j8ClURs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771861022; c=relaxed/simple;
	bh=0RMgkioBPuT2P7CS0wBcuyMqgY63Y0p8t67334WChz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NY2kbYFvfTmzL0qAJH2ZY/iSVTOe1KGcQttEA/G0Rgg816+ITER0FUHj2NIuyPHmp+dICqjjCtf+v5nt0HiUG0xdoFl8cpl/GX7uNmI/eYiE4owmdawKS16JmhBazBUatWhujuH1eAoelV9MZZSeMRC219AYRTURq8GJXnGrNDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=Z5rEfwE7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cXrhNPjK; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailflow.stl.internal (Postfix) with ESMTP id D12751300C81;
	Mon, 23 Feb 2026 10:36:58 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 23 Feb 2026 10:36:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1771861018;
	 x=1771868218; bh=/FFUXBR5U3hFVPIZNm7m/6LA2a4Y9zUWlPmCbTkG2qk=; b=
	Z5rEfwE7pLIbHLJUDKM2C1pww9ShQ8bA64hqzO7v+kl191guOxvSQgPjJ5xkSaTq
	DYh3hIBg2d4OY+wye6edZMl/a/JZQ0z2w0R2f4kEba2OpTyyXXiPmrOMRda3Zf56
	E1g6TYO6FjySkzUgtlEP6wLCuMP4czriEfQPC4bJU1GjzTvNVIBxa1+xy5NJF5NT
	OwZjh/kTwH/S6aklPYLMIOzYDAwexvyXGZDoonuXtqSNX5X5zJT4LZsDjXHeZipT
	3FH1+8QzcfZasvaxwB0my3x7okubX8DVZmsZt+WuJrzYgiVFn4rn0+zp9wGKeaCL
	A0oQbt1hZAQccEVKSDX9Sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771861018; x=
	1771868218; bh=/FFUXBR5U3hFVPIZNm7m/6LA2a4Y9zUWlPmCbTkG2qk=; b=c
	XrhNPjKOMYRcD3kZq4btnJ/o4IEKjWkDrwvMTR0SfeXydTHAtcUG0QxM6ARYw/ca
	qGQmYEJP08JAbEL7Nv8wyN3XfZEYTN7tQVY3mkbE1V0viw6Hj1UEPURxOmPDC2mZ
	ag3ppdvjnP+td5HYpRnua+qzrbibzQWY8mHGCvHmyuXr0uZ4rzys0da+WOcIdmhC
	1gM7cHaUnGYkDLNC2NtEPVVvrH2GQiCra/XG40HX2v1d0HrbgKpfEHZG9KKjppRR
	NBOzgqDdlt8XwDjhsSp1vdWNt/TFIHjNuIQj9GVNf6dvugEbdl3dM+iSy5WJ3Iq6
	9OqfeF5zFpDYOYAduQ9RQ==
X-ME-Sender: <xms:GnScaY3NipfFtM-UeKVjPq_hBjZ36D8XM_YljgyOm7rgjx5uJwmzdA>
    <xme:GnScadFQq3N2gjwNo6Va12rVKF-gJ35Fc52VsAdBI46DQAzhxy0Pyet1p5G6ACRk1
    KU3MMBzxzlM07Y60KclUhtUdS7WzQHLRg1bGKOzJHipsgm_n4Bc>
X-ME-Received: <xmr:GnScaXi9dxGku8yqXoyggCSsEUpRbnPW1hx6FVqberc1_JKXx96eXQpGEh99ZJsDoB20>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeejgfeljeeuffehhfeukedvudfhteethedtheefjefhveduteehhfdttedv
    keekveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugessghssggvrhhnugdrtgho
    mhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmh
    hikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehhohhrshhtsegsihhrthhh
    vghlmhgvrhdruggvpdhrtghpthhtohepjhhimhdrhhgrrhhrihhssehnvhhiughirgdrtg
    homhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepmhhguhhrthhovhhohiesnhhvihguihgrrdgtohhmpdhr
    tghpthhtohepkhhsiihthigsvghrsehnvhhiughirgdrtghomhdprhgtphhtthhopehluh
    hishesihhgrghlihgrrdgtohhm
X-ME-Proxy: <xmx:GnScaQB6jZ-_gPDzZdIACqlEQWc-KO3dI1B9MR9xsB-m9P87ic_83w>
    <xmx:GnScaZRCnAVYrcsrfNyfTcaCarPXcnkjFUrn3ZHcymxYOKp88HD5ug>
    <xmx:GnScaVUxfbLVLEQhnqnILYzHov3pkuDRqzBZoinUnr68dE5Sd1RFwA>
    <xmx:GnScaSc0GjGk6pafpbTtQ9SmbEexrGtY4Uhm7rQbtKTKioXMxtNGHQ>
    <xmx:GnScaceep0MMcH3DLHKXDxP9pZf0Oj-qdjOCxkITkPznLYTNouuaVFPT>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 10:36:54 -0500 (EST)
Message-ID: <fa1b23a7-1dcb-4141-9334-8f9609bb13f7@bsbernd.com>
Date: Mon, 23 Feb 2026 16:36:50 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: skip lookup during atomic_open() when O_CREAT is
 set
To: Miklos Szeredi <miklos@szeredi.hu>, Horst Birthelmer <horst@birthelmer.de>
Cc: Jim Harris <jim.harris@nvidia.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, mgurtovoy@nvidia.com, ksztyber@nvidia.com,
 Luis Henriques <luis@igalia.com>
References: <20260220204102.21317-1-jiharris@nvidia.com>
 <aZnLtrqN3u8N66GU@fedora-2.fritz.box>
 <CAJfpegstf_hPN2+jyO_vNfjSqZpUZPJqNg59hGSqTYqyWx1VVg@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJfpegstf_hPN2+jyO_vNfjSqZpUZPJqNg59hGSqTYqyWx1VVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bsbernd.com,none];
	R_DKIM_ALLOW(-0.20)[bsbernd.com:s=fm2,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77973-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DKIM_TRACE(0.00)[bsbernd.com:+,messagingengine.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernd@bsbernd.com,linux-fsdevel@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C8060178ED7
X-Rspamd-Action: no action



On 2/23/26 16:09, Miklos Szeredi wrote:
> On Sat, 21 Feb 2026 at 16:19, Horst Birthelmer <horst@birthelmer.de> wrote:
> 
>> I have been looking at that code lately a lot since I was planning to
>> replace it with a compound.
>> I'm not entirely convinced that your proposal is the right direction.
>> I would involve O_EXCL as well, since that lookup could actually
>> help in that case.
>>
>> Take a look at what Miklos wrote here:
>> https://lore.kernel.org/linux-fsdevel/CAJfpegsDxsMsyfP4a_5H1q91xFtwcEdu9-WBnzWKwjUSrPNdmw@mail.gmail.com/
> 
> Bernd had actual patches, that got sidetracked unfortunately:
> 
> https://lore.kernel.org/all/20231023183035.11035-1-bschubert@ddn.com/


After the discussion about LOOKUO_HANDLE my impression was actually that
we want to use compounds for the atomic open.


Thanks,
Bernd


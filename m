Return-Path: <linux-fsdevel+bounces-20385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 529198D2999
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 02:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03A9A287E1F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 00:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934C615A851;
	Wed, 29 May 2024 00:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="jzfEwTP/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WSS9pTAc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38741F176;
	Wed, 29 May 2024 00:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716943745; cv=none; b=JaEnCPGqzFdu3/O7WHwS3NngMdv8gkorYf+vbKUd6KpSpabg46yBqENdKoPs0zeN8sCg1I0xTvkjzfhHBssXjek7f5GRsqnBgetA9KY7+qb5Y+FHPBmtEc1TMWtWnC6Qiu/UrMcidmSgt47re/FKRvr3e/rkSoNnaepJFMbmCf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716943745; c=relaxed/simple;
	bh=bgIEuVK50e0M341nriPYsSyg1MHxN/drqYZF32jYgCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RZIyQdz5VDVFpZ5SGddh3jilUYoHQFg8oEgZf8zC6MdlzLiYrM6KwkTOmnY5IY9T+Jke05iGV1VH6hokYDwYab9y7aMcCvb6almtwWTt9P67SdCV54Rh4d3pPKAbhkeU9yfDQaDTRVirhjAQiFTBlhP7Jf5HdVjJDZg76QZ7XSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=none smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=jzfEwTP/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WSS9pTAc; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=themaw.net
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id C62B11C0016A;
	Tue, 28 May 2024 20:49:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 28 May 2024 20:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1716943742;
	 x=1717030142; bh=Rjchn31EWNLaPBTnuCkNHo37bS2rZlgzRtco4dQJSis=; b=
	jzfEwTP/2aaVBieOXB2dUgb5z3RWWDwiFutlGB4h9IAf3GOqgDvIG7VGEDEzTsf/
	P+LjLfyMDyh1tXzgHLp1AbYBzu6VsURPKwgQnFLjbVg+3Ve9kustCLuQNLM6gEce
	RWvZmV1xBEiydGkevadh3mMT5RqFHG1uRINLboZ0RPjaqWW9I7i39WFWlEI6MKks
	uwE6veRbCYvcYqw4fpT1QSZIaq+KsJS14qQL1ktdQmNdlFHeESE7iqtc6a573p1Y
	wKcEP/Hcg6TZRxuFoqVt2AdVZ5gJP+Q6LjAywnXqwiFbdKJ8DkUvSyMhbaS6qP9x
	X6fD7AgCPnIla0PH4F4Mrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716943742; x=
	1717030142; bh=Rjchn31EWNLaPBTnuCkNHo37bS2rZlgzRtco4dQJSis=; b=W
	SS9pTAcLHlT+zR+lITK8yHxiOPwCwWmmSj+BuN3LNsE2QMbo0G93bFKI7nlebn3k
	JVD7Ty1cdRl+/tgBokZQxd/1yx6Fp7ioXvWfJPrAuEN5WWQ2Gms4njphowMrGSIa
	UJb53se0vmESVnoVpVxErqRKdLfNWqLh2/MaNbxNdTfFeunDCvlU2KzkqA6tHkzT
	YYbe/TZMjm3HvnFmgKpRx5+fLDx5zF4hzt6DDavz0FrU1IavKCCUOqujqipPx1Ew
	X98n0Rb29NEsAHuamHPh8nKZIoehYXhA97kRFb1fFoDAFV7mLRQFkzQpd2L5sIC5
	2EG42fceX4MJOoNcZBCNw==
X-ME-Sender: <xms:fXtWZgyYhdBnc6LeAHWEOteIjXrYjnnhGg-GnW9-5as8nUxbq6U6fg>
    <xme:fXtWZkShgqrhpq4YVih2j_Jqp_5XsZfRbbJcCqbrvRFDaRcmEKuAKXMWxcr2lH_9T
    KGnUGvcMk6s>
X-ME-Received: <xmr:fXtWZiUakpA1fMnV3tTLBFuaEvoPG70eVDKq6hituZYWhVOQukC0QvzyF5OWJIReGx_YiXfjmX72Vs4Q3SU9tOv6vp7LBCzdwDeD65wXRNukiEv3gNx75j89>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejledgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epfeekhfegieegteelffegleetjeekuddvhfehjefhheeuiedtheeuhfekueekffehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:fntWZujLsUYHF7JHKK8Pyq_eCY6ti5qIfts3ulV7GwRPbqng42ox6g>
    <xmx:fntWZiAGCj0b8bWBXDe46pyL4UpPiQj4Myr6ZWtLRgv3E4bwExGQew>
    <xmx:fntWZvL3K-WclgGUL0OMD3SBdJkIxNmaVfkSUsrMLbc75eq1dtx1-w>
    <xmx:fntWZpCPMfZlQ4DF-Dm5a3SduiY8rwuGGa_ZpeM-l7sVyG7hlOHR5Q>
    <xmx:fntWZk0Y-Q3xoYuEosaikpQ2mLDyrRWG2_AqsSy7UfT8wNcdKZApQUrJ>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 May 2024 20:48:59 -0400 (EDT)
Message-ID: <7b4f0e3d-9c37-476e-bc83-087db8f964ca@themaw.net>
Date: Wed, 29 May 2024 08:48:54 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: autofs: add MODULE_DESCRIPTION()
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, autofs@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20240527-md-fs-autofs-v1-1-e06db1951bd1@quicinc.com>
Content-Language: en-US
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <20240527-md-fs-autofs-v1-1-e06db1951bd1@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 28/5/24 03:22, Jeff Johnson wrote:
> Fix the 'make W=1' warning:
> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/autofs/autofs4.o
>
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>   fs/autofs/init.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/fs/autofs/init.c b/fs/autofs/init.c
> index b5e4dfa04ed0..1d644a35ffa0 100644
> --- a/fs/autofs/init.c
> +++ b/fs/autofs/init.c
> @@ -38,4 +38,5 @@ static void __exit exit_autofs_fs(void)
>   
>   module_init(init_autofs_fs)
>   module_exit(exit_autofs_fs)
> +MODULE_DESCRIPTION("Kernel automounter support");
>   MODULE_LICENSE("GPL");
>
> ---
> base-commit: 2bfcfd584ff5ccc8bb7acde19b42570414bf880b
> change-id: 20240527-md-fs-autofs-62625640557b
>

Acked-by: Ian Kent <raven@themaw.net>


Ian



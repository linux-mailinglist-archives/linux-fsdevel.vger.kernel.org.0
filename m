Return-Path: <linux-fsdevel+bounces-72097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE050CDE1F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Dec 2025 22:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2740B300B91B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Dec 2025 21:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839EF26E175;
	Thu, 25 Dec 2025 21:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="bO6Mv2iK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lerySeDS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF341B652;
	Thu, 25 Dec 2025 21:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766698492; cv=none; b=tnTW/KEKInqGD6b6fepJBlBKXPCkPTHhfmdlYH4PiCCLx+DloaGob6ig/KN9P9IppJjOdNIIl7zdvg2oqvV0qCGsHN09YbVOSTZjFz2eIAeuRciX1Y6FPUYLyvBtKa+600ObmbsKwjUbumtu8M+Zt8lmLMgClrH4Ke6PbjoJLEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766698492; c=relaxed/simple;
	bh=na1cXMOr0cRlVWfUuTWQLqgLJvOO6+LPS22az9csOrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RWX/eiTYt652faYixNIGVVfyJQsynotH0hIW8g4sL1l2CSX3mv8h37GWuFMwwZOWuTL9zKL1bCCpVMA36ss5vc70ptIjAYUOjr/og4E9KcnMDOdNxt7aP7ZMA60x2lsS/znCrd4ASrd2NoARXnv6yXw0JMGIiOhK1ClY15ETBVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=bO6Mv2iK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lerySeDS; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A2714140008C;
	Thu, 25 Dec 2025 16:34:48 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 25 Dec 2025 16:34:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1766698488;
	 x=1766784888; bh=+g6bwxbARqsMNcA+6OZsSa+v4s2z0nckTmorSOHcRfI=; b=
	bO6Mv2iKW384C134FCIlTmI/hiISzNQxPLFwwqwra2oWPjZ03SIWB6YcArROmVJ3
	WR6u0ADvNm5nBdHQEqBRC6xUsQKUohlOUqvOBrUQeWB9xpWX8xMF1x0562yG9iLJ
	70u9sTQ3Gk3uWOno2A/qxH0JAV4SHoxrglqdyxC7/M5rxnf7ghFqpNCMumYYD+7t
	uM58fkNxtuD6NoA/NyEI11EN5HCZ9sj1jLSEC/ztJofXR5fXGcqCo60xYw2UxBAs
	jdxL5h9MaJKKqH0N+xpx2Pvk4yE+PVpeVLxqxff4Iv26nF7PYbtVusqd6uComHc8
	56FIOXdbjZ9oq7zsCA7/Wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766698488; x=
	1766784888; bh=+g6bwxbARqsMNcA+6OZsSa+v4s2z0nckTmorSOHcRfI=; b=l
	erySeDS+7ULW3x3655gmylLjMlUoNruv6h+9F+CtqbhHD+75meAZXhgrI/X4G8At
	GnMA8uIpncXTsmTcDCXYs2S2dMYdY/32AV5NI2sWUWjne64g0599tL1NyI/jZDPc
	9T8/ts3mLLbPIyQpTvNINmqMbd67X5pJ4tMrber2OVYGl5UkB8TRXAqE5ahcSCup
	QUIqsYOGXFKPuSiPnpDxVwik9LzVNSNwSOgha9EkaoPgHsOrz42IhMAVVYPGudmn
	0MKTDqOkz3msX5jtEhExj8JI/SaI6wwi6BYDTSQLwmSMAiQboxyAbss63cPMKd+4
	vMRGvJv0MieW0NHuTRWfQ==
X-ME-Sender: <xms:-K1NacGKXdR2ITXw4ANZErddOcYHOhi4SobT4lcnNIDohJqZ-9ZDFQ>
    <xme:-K1NaW2kCkT73NqyNugA9JVd5Y0oC-kon5tRAibOS7EO07CO8Ec0n9j85vi3LytSN
    RKo9u5j-IGu-B8lfiMsXPhQn8rlLEcVCXd7JGQ34uDrupkzSDGh>
X-ME-Received: <xmr:-K1NaWOt09c9xnSj8S7E9LbOn9i5l76Ei3hZy92XtSKp-TDKrdGk2Z1fcZgM04-CNbaifk9_VxrZmorL4wCikPdYlPt1KW6ds6zXmKrJ7mohENL3iVPV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeiieeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhephefhjeeujeelhedtheetfedvgfdtleffuedujefhheegudefvdfhheeuvedu
    ueegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    gvrhhnugessghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhurghnghhkrghisehkhihlihhnohhsrdgtnhdprh
    gtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheplhhinhhu
    gidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlih
    hnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehk
    khegjeihgiesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:-K1Nad4eKMhtO4eHs7bt608IMCrkyYlCLbQ3mKmfip81sf-iuPAFHQ>
    <xmx:-K1NaY3gsZO3xino8FxPNJCwYMCTPoJIM8z6sxztBWlAXffZiIichQ>
    <xmx:-K1NaWyL6PHyVOtq5d2pp2LE2SLhGUge57vkvrb49HELTTc0mVFo6Q>
    <xmx:-K1Naau_mWW-EJTIVIajTm0iKELVVH4Wg1hFxwIDBdlea3ww-He1xw>
    <xmx:-K1NaQTE_Eq3REpXVL8g3JlxtJlzb43-NjcqnjnDjBnTHPToc-v27aBI>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Dec 2025 16:34:47 -0500 (EST)
Message-ID: <9f54caaa-1936-4a37-8046-0335e469935d@bsbernd.com>
Date: Thu, 25 Dec 2025 22:34:46 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: show the io_uring mount option
To: Kuang Kai <kuangkai@kylinos.cn>, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 kk47yx@gmail.com
References: <20251225055021.42491-1-kuangkai@kylinos.cn>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20251225055021.42491-1-kuangkai@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/25/25 06:50, Kuang Kai wrote:
> From: kuangkai <kuangkai@kylinos.cn>
> 
> mount with io_uring options will not work if the kernel parameter of /sys/module/fuse/parameters/enable_uring has not been set,
> displaying this option can help confirm whether the fuse over io_uring function is enabled.

The problem is that is io_uring is not a mount option, showing it as
such would not be right. Maybe showing all FUSE_INIT parameters should
be added in /sys?

Thanks,
Bernd

> 
> Signed-off-by: kuangkai <kuangkai@kylinos.cn>
> ---
>  fs/fuse/inode.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 21e04c394a80..190de3f29552 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -937,6 +937,11 @@ static int fuse_show_options(struct seq_file *m, struct dentry *root)
>  		seq_puts(m, ",dax=inode");
>  #endif
>  
> +#ifdef CONFIG_FUSE_IO_URING
> +	if (fc->io_uring)
> +		seq_puts(m, ",io_uring");
> +#endif
> +
>  	return 0;
>  }
>  



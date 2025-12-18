Return-Path: <linux-fsdevel+bounces-71658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7DDCCBAA3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 12:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6048530FB549
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 11:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EA131ED6A;
	Thu, 18 Dec 2025 11:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="NAWVN8Fo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r7epyiGE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C58E2E175F;
	Thu, 18 Dec 2025 11:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766057579; cv=none; b=WT+NkLYiLGfzsreyIAblzDQ4Fc3yY3oavcb5t31jPyKTAjz36UE8C1PNwWQYAajyqxQWEmPo9S6B4LXrx2b9K8YJNuti0gJNsxNa3kF/KDBzD5fmjCe08Il2s9Grs+GziSOx+PjFIsG/1uVyxn2V/4wn2Sl9kxJardWSZPq8MS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766057579; c=relaxed/simple;
	bh=bxsnVSxhP5J+tbNYxZwZ6DbovM/373dla8nPqCGbLjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I9TI888Ry7sZWuJrvnL633NAR9JzFPPKgSMCOj1fXZHx2FCUiRrkwhg8ac6AAapU5xuMbet8hf0KhzzA14fQ93bfaTmSUiexK6If0JARqUpbd8h1YOvqNmvqo1ugYLAWEdG199YZdoCKmj7yAnV+HXz2bHGzzsHV0qI4ulAyoPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=NAWVN8Fo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r7epyiGE; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D512B7A01FD;
	Thu, 18 Dec 2025 06:32:49 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 18 Dec 2025 06:32:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1766057569;
	 x=1766143969; bh=Rut8W1+H5wqyYDTwJjq46iY+uuRoQNx6F+dh3cXj2Iw=; b=
	NAWVN8FoZIE+SC1xzzpGwaktaSMZgi2n2McXnYbDlbuFlUMoHxpwPjuC/TNkpmXb
	75jRktEAQn3bUd27U0k/n/cGvsk6VGdWLkitUCNUuGhEZUQXEIu7ldPJs/QC73oH
	XHFFR9V6fTfjqySpqcRHLvBDLYjv1hnMI/3FKafo3CYKbbH8835bOrQrNGX9v9Ur
	O1Vb5Xenu2qfDvxQQO8lYjyRMHukbAoUohNxu4o1Ng8pYoFHEzbxJ5qvJGZNhuN2
	do45FT3eRFvmfT73PKb9U2/ize0xLwsZmc/DYnyXtWv3b/YpnNfVMUQ9ejRaR3l6
	ygMJp83TiE7suM8mcc5fPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766057569; x=
	1766143969; bh=Rut8W1+H5wqyYDTwJjq46iY+uuRoQNx6F+dh3cXj2Iw=; b=r
	7epyiGEmg5iGQECW+5tuXD9r0qnFl6/j/Miotmp97jJiikxIc/L1pNplMdHx4m8l
	J+q1cs7QDtc/3FlrLxBGdBB/nPufcx002epfC8tjkSticHsnNSEsa/g9r5nGWNEe
	XMYWHhiPq7VoV3p6VpaXbtY2VRfzqCYqeVFd7H0RjGOzC9SLbd6+eJiZRWhzS0sE
	PScvysu9z04PV8AxfQwoGwiPQSTzEClKqlXC0QWMFdPHYDy9uU8qHj4Dy3m9xgCR
	s8YWTf8Ez7jKm7wP/oiLuuvDh0vslk0KENyaPMb1Ghl1PDka/Q9kYBjAmYcf/q7K
	qzJI1EVkQczWwSK4dGjRQ==
X-ME-Sender: <xms:YeZDactRNIZLshuyIUIFEv5NlIELZ3p16FvL4HvftCbuYmz6xJwhsQ>
    <xme:YeZDabs5tZWu2j5OnEdHz75ECMHC8On3vOjmjPR1X9AtSpf8BQcMskHiScxqfBXPq
    _smXO8tbRshBddfqjWwUiTwredj5Fp4DJurV64w-Aq4U0jt9g>
X-ME-Received: <xmr:YeZDaaByr92YoJFPlxJSBpMr-ZkRVeHfOXt_2dpPvRUkrA74gLDKwyBXkzN4QticPyfKS8g5iV12h4KTvrVUVPNYRI-rfNGIS-WBik4V7yLHCxmUtl4VHi82>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegheefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepkfgrnhcumfgv
    nhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpeeigf
    fgveffvdejtdetuddtfeehhefgjeeiudeuffevleeufeefueffudffvdekveenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgifrdhnvghtpdhnsggprhgtphht
    thhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhgruhhnvghrsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrnhguvggvnhesrhgvughhrghtrdgtoh
    hmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepughhohifvghllhhssehrvgguhhgrthdrtghomhdprhgtphhtth
    hopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhk
X-ME-Proxy: <xmx:YeZDaVP83v7NrB_VerJaBHZ3ZmLWDLuE9EmDleiIBWBdfgA99oVQdA>
    <xmx:YeZDabzV3LlfQr5uRK_-plEArXGPkCB8JuONoGU2SWopRK0n_J8qMA>
    <xmx:YeZDadVIq-6pd1ru5HAuBgg5D7K97--qy5LX2bsS4-P6VdLGMPvxhw>
    <xmx:YeZDaVO8k9AAwj2mF6rHjCouHhK-Rv1vBVJEppRqCVLosQKlD5bJZQ>
    <xmx:YeZDaWuc1JtykZamYIPbY4buiPyW1VmIi4sqt6GgypAZtNHOx-ULyrEL>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 06:32:47 -0500 (EST)
Message-ID: <8f7f767b-9b0f-49e0-a440-cc488806dedb@themaw.net>
Date: Thu, 18 Dec 2025 19:32:41 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: Remove internal old mount API code
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 Eric Sandeen <sandeen@redhat.com>
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com, viro@zeniv.linux.org.uk
References: <20251212174403.2882183-1-sandeen@redhat.com>
 <20251215-brummen-rosen-c4fc9d11009a@brauner>
Content-Language: en-AU
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <20251215-brummen-rosen-c4fc9d11009a@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 15/12/25 22:02, Christian Brauner wrote:
> On Fri, 12 Dec 2025 11:44:03 -0600, Eric Sandeen wrote:
>> Now that the last in-tree filesystem has been converted to the new mount
>> API, remove all legacy mount API code designed to handle un-converted
>> filesystems, and remove associated documentation as well.
>>
>> (The code to handle the legacy mount(2) syscall from userspace is still
>> in place, of course.)
>>
>> [...]
> I love this. Thanks for all the work on this! :)

Indeed, this is one time I really do wish I'd been able to do more on this.


Ian

>
> ---
>
> Applied to the vfs-6.20.namespace branch of the vfs/vfs.git tree.
> Patches in the vfs-6.20.namespace branch should appear in linux-next soon.
>
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs-6.20.namespace
>
> [1/1] fs: Remove internal old mount API code
>        https://git.kernel.org/vfs/vfs/c/51a146e0595c
>


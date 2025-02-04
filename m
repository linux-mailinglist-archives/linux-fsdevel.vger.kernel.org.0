Return-Path: <linux-fsdevel+bounces-40730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD24A27040
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 12:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25E0F7A1147
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 11:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3683B791;
	Tue,  4 Feb 2025 11:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="bqy1W5jU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dUTFICnQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959182066D4
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 11:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738668686; cv=none; b=Rk0gk8Ax4We5KFHZ8/t3HI8IvM3czQw3SYxAwnFXelcUqLhkBpIyaT17vgEeI2J7OJnhh5nlh/JNdLx5D68LMMKd2uOW9O2/AxpktZBpJrIf39BfuwW5Y+JdEuYkHW/T9TfjBmzyk7wkPromiSJh2bK5KwkziBZEKg0YcaLKfko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738668686; c=relaxed/simple;
	bh=CLxXcB1AuHdBtYTNxgqGhyt9Y0XpXN7bFMsp67LBjS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AzQnQzRx4jJB/Ro7UqoN8kENLWt8RAK5H+f+kBGbUgrWEPXNL5L6C5iIOpF5rGLAi8PODRulKjdWMrYAuqfhKqD70dq7hK905emeLZahkELhZRhZnNzhjkA+n4CG6yh/ZhhEJxkDAStk0xfnuDoKga+Zosa2x+vwYx3wPoYRyAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=bqy1W5jU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dUTFICnQ; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 62FD525401EB;
	Tue,  4 Feb 2025 06:31:23 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 04 Feb 2025 06:31:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738668683;
	 x=1738755083; bh=sa0DanZgAhzXJwqHbcHK/Dy7ODSv7HaozuiY6+scQYE=; b=
	bqy1W5jUnbzv6rjY2b/dKeG9pBkDNNlhm56FOkj7yiu0rtU++bxpGrzNilnYtrX0
	y6KVynbdY/apE/MJRBSi48TKRTzX5suINEUsmO5gFa6vOidZIsgBKGsB6i6FBd5v
	GiSPfl4hq/c4dV2+tkVnHeSRkIqKxFH5YkyQbU6WeQcue1JozowkLgHYy2HLjfl3
	bHBJhU/+u22vc0i4VNlFYjKIpKqnenaeuypwdv7mJH/h1BBKH5piLp8Zl3gR91P+
	4fynIynjREpGbvTw5OX29Ih8B2AZ548PoHU2+77g0wv3e7bAVCk+fWwC+thhzxmB
	98fGzJ6Oi2qefTHskAyM1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738668683; x=
	1738755083; bh=sa0DanZgAhzXJwqHbcHK/Dy7ODSv7HaozuiY6+scQYE=; b=d
	UTFICnQDrH4AoP47885kGzXpdWknsB/yDWK3NKzVltb1Pdb9xVkTyvvPlJcQVwWn
	7wWeVfudVibhQAiyV+icNZRgjtEKa4rC4lqoEb7eiWUdnbjHscZfbKWvZvHUJ6nO
	qks3rzzMH1Pd+YjxxJi68Uk+9NVnIOCxQm3m5dcriwByf5kkCrxOUn26vWKY9f53
	LyQzuGRPfSFNRlk1DfEr9MmnzH0HDIML8nWklZLnrYEGBuSBfa5fDo31dOGBdVTc
	9zgFa7sLMen642ZBiEJouSo8nMMZYozqjdhLPdXqDB1ZL7w2Dv7XPnKzdY4Gy8w9
	OeTorKuhjS+n6gQD9iggg==
X-ME-Sender: <xms:i_qhZ7491eGVVcQ0SQLQXGrLFpH9a6vM0TgXcw9tak3gwFQ21_FTvA>
    <xme:i_qhZw4aYrS-wTMMTWOBJahs7kEHvRoCmuPJIy0nC7R0-UKi7aGk0c7E426XYG3nH
    uRS9OqEMo-JFhLU>
X-ME-Received: <xmr:i_qhZycEdhHr23VDfNFiEROVp6sNAfJFoP25SglpX0DC1B6PmQQwck2-n-VulTn47VS_n0lusP6kEmbyyZq7_fqJrww7A87o0A7-jYOhcO-TvX_92lKx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusg
    gvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeffjeevfeefjefg
    hfefhfeiueffffetledtgffhhfdttdefueevledvleetfeevtdenucffohhmrghinhepkh
    gvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdrfhhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhgruhhn
    vghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesgh
    hmrghilhdrtghomhdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehmvghtrgdrtgho
    mhdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheplh
    hinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:i_qhZ8I60mF8PkiNvYf5l_aKmXWleCT69yMDHYuqR8ey1BHR8t8mUA>
    <xmx:i_qhZ_IUaSpXYf_WmVOL7XWlQBDAPYVcbMFgcqzlKGY1zuEjqecyGA>
    <xmx:i_qhZ1zzjSO-gu3uNydmKTklSFp1oU91lmMTRbRP4v-YriVS3KPXFg>
    <xmx:i_qhZ7LXgj8-ib8LiWFUuAJXtDC24_FVwaXVcY8SJGF1Y545AJYRQw>
    <xmx:i_qhZ1hQAs0teEG9ob_SLTFxIpdnJ_CDwkB4IhOKu2AgWm68TLABKG6l>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Feb 2025 06:31:22 -0500 (EST)
Message-ID: <17197632-8612-427b-90b0-26b2626a8ffd@fastmail.fm>
Date: Tue, 4 Feb 2025 12:31:21 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: clear FR_PENDING without holding fiq lock for uring
 requests
To: Christian Brauner <brauner@kernel.org>,
 Joanne Koong <joannelkoong@gmail.com>
Cc: kernel-team@meta.com, miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
References: <20250203185040.2365113-1-joannelkoong@gmail.com>
 <20250204-glashaus-begraben-5ea4e8fc3941@brauner>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250204-glashaus-begraben-5ea4e8fc3941@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Christian,

On 2/4/25 12:12, Christian Brauner wrote:
> On Mon, 03 Feb 2025 10:50:40 -0800, Joanne Koong wrote:
>> req->flags is set/tested/cleared atomically in fuse. When the FR_PENDING
>> bit is cleared from the request flags when assigning a request to a
>> uring entry, the fiq->lock does not need to be held.
>>
>>
> 
> Applied to the vfs-6.15.fuse branch of the vfs/vfs.git tree.
> Patches in the vfs-6.15.fuse branch should appear in linux-next soon.
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
> branch: vfs-6.15.fuse
> 
> [1/1] fuse: clear FR_PENDING without holding fiq lock for uring requests
>       https://git.kernel.org/vfs/vfs/c/c612e9f8d20b

do you see my reply?

https://lore.kernel.org/all/ff73c955-2267-4c77-8dca-0e4181d8e8b4@fastmail.fm/



Thanks,
Bernd


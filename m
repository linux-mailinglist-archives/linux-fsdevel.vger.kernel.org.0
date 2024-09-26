Return-Path: <linux-fsdevel+bounces-30187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF7A987738
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 18:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 810D1B2700D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 16:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C0F15AADB;
	Thu, 26 Sep 2024 16:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="yyN/RClC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q3MdbX/b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B29C153BF7;
	Thu, 26 Sep 2024 16:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727366700; cv=none; b=MQXofe4KSCdXQGTbr/aTrRkgW2NnlF0e1MlzSEkIg+EktJpxiFg7s/gWZTbcZKAfcXMlVroClx9W+lkUDPbHpsdNwLnwgbi0qPvITGo6rBCKsm8m1JctfnSIG07nhVQqPudx5Flcv+pcFNIv8DFjDarKbcHaehMpjDsI1kwrgvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727366700; c=relaxed/simple;
	bh=QCvQFLGrfa7YAftZaGsnPcD0VkWBB6dJL0K/Hvjw4Y0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IZpC2xjn0h+ITamFz72U9nZ+razuNAdixK5kbROeh2aS+Lqnv5h06C1lkJZKupcRN0yR5AdCfyIYMdpPToUzoNCnIAq99d53kqyV1lJ8SebCPYymtRzlVE+BSSYYePRLQJWDOM+XsWoPCTtfsqLpk7su+5B64n/xuOJoacZgmXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=yyN/RClC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q3MdbX/b; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A3A31114009C;
	Thu, 26 Sep 2024 12:04:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 26 Sep 2024 12:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1727366696;
	 x=1727453096; bh=NhqsMyJ61DtUxWQkPeeP/RCG8R6ZkNS/ze/ekXTI2Qk=; b=
	yyN/RClCa5sciCh8M9nns+i4Mh5UfIUAIVU04UmyVk16dgY1C1IEER+p5fAJEcQU
	u8D72JGMNmdvzdC0ImH8NJjOxA8yLqv/ofUn6uQXLD6LjGHCf9KH/++Y8iuPcfP4
	NQyA3sa42UtuDhcj8+0NWNTijCix8bQLd/0V5EDOgb1SK+89a2Kr/ugJPMYX48/z
	RuWRIh1jrUQgWKgtSsIQB+O2gwCRqbUX+UWkAtMLG6xZ5sjHuKDgpKnbyIgqG24n
	COwBLA09LWnoYeOP0qG9bWVL1NscTeoI3Wo3nYGiyNk2FCcoTt3lCwpw+hOuVD5/
	JhJ3QmEv7mcDw5eGdrwsVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727366696; x=
	1727453096; bh=NhqsMyJ61DtUxWQkPeeP/RCG8R6ZkNS/ze/ekXTI2Qk=; b=Q
	3MdbX/b3dOhQVCWOa+GxM1BiVzs9wJusm8IbBvYnhAJIBRKbR+mvE7g3wVyxUNhI
	ICDW25vmgKf2o2nT5dHsuUFvmicxqG7JeeuhexFjRPzumsp/0vEE5fpM0HLd4lo2
	YZR7cNOdUgdWGti8uC4KQsXNl/qwfWsN/gq6spKdp78MVk5hnLETbkp6q3aTH22J
	P0SwpEyOszRaSepkUDmL2Mj87eyQNOF7aT0bCqCb4PIo7KZgw240CMmMUqnvYmYt
	a2/eoyxhZ7mxm4SCmRtQxiSNpbkNB2lQwGMT2f0cDRAYdZRXNoswlQNCpOBSgOni
	55OwnsMD+x//ZvMyhSzvg==
X-ME-Sender: <xms:J4b1ZuofDX-HjlQbB9Z32z7vn7mIi2XyXJk_3t-7PfFqiQtxHd1ZXg>
    <xme:J4b1Zsru8ILoya_hKeXv5634X-7TY5XmIW-MRRkB66TxcRtVsWYMDlzNdoEl3O-Dx
    M3brEGgtGVLKgdZo1c>
X-ME-Received: <xmr:J4b1ZjOAt3zn6QUjTvTHW-dW7wMpx0Y7ZvXXLCjF8Hhns6d0oWCNFNis4N_FTngaVpTeO2N1dCALCNPX-qZSdiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdej
    necuhfhrohhmpefgrhhitgcuufgrnhguvggvnhcuoehsrghnuggvvghnsehsrghnuggvvg
    hnrdhnvghtqeenucggtffrrghtthgvrhhnpefgueevteekledtfeegleehudetleettdev
    heduheeifeeuvdekveduudejudetgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsrghnuggvvghnsehsrghnuggvvghnrdhnvghtpdhnsggp
    rhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhisggroh
    hkuhhnudeshhhurgifvghirdgtohhmpdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgii
    pdhrtghpthhtoheprghlvghkshgrnhgurhdrmhhikhhhrghlihhtshihnhestggrnhhonh
    hitggrlhdrtghomhdprhgtphhtthhopehthihtshhosehmihhtrdgvughupdhrtghpthht
    ohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprgguih
    hlghgvrhdrkhgvrhhnvghlseguihhlghgvrhdrtggrpdhrtghpthhtohepshhtghhrrggs
    vghrsehsthhgrhgrsggvrhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:J4b1Zt7TNqU6j-vZdUYKKrsXZqnhK0DHaDNJ3EGlyA0HbcZMuKEwxg>
    <xmx:J4b1Zt5tnavG_t24riIFztWRYHYPI4cPhFmQ1jA21jfyUVAzMbEZ_Q>
    <xmx:J4b1ZtjXS9AczPu4s_htMS6Fr3ZiytFo8QkZxdX417aFYeDqT2rGpQ>
    <xmx:J4b1Zn6I9JE6WTjOQ0g7e4RyoMFznljpUurS4L-DsV6FM4sxH0HeCA>
    <xmx:KIb1ZsIeMbwqZ1PPa0Pyl5hhaBVrjnP7fBt8YTxzt0aK-fZLPo1sCtRH>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 12:04:54 -0400 (EDT)
Message-ID: <ac29f2ba-7f77-4413-82b9-45f377f6c971@sandeen.net>
Date: Thu, 26 Sep 2024 11:04:54 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] ext4: fix crash on BUG_ON in ext4_alloc_group_tables
To: Baokun Li <libaokun1@huawei.com>, Jan Kara <jack@suse.cz>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: tytso@mit.edu, stable@vger.kernel.org,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>,
 Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Wesley Hershberger <wesley.hershberger@canonical.com>,
 Yang Erkun <yangerkun@huawei.com>
References: <20240925143325.518508-1-aleksandr.mikhalitsyn@canonical.com>
 <20240925143325.518508-2-aleksandr.mikhalitsyn@canonical.com>
 <20240925155706.zad2euxxuq7h6uja@quack3>
 <142a28f9-5954-47f6-9c0c-26f7c142dbc1@huawei.com>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <142a28f9-5954-47f6-9c0c-26f7c142dbc1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/26/24 3:28 AM, Baokun Li wrote:
> On 2024/9/25 23:57, Jan Kara wrote:
>> On Wed 25-09-24 16:33:24, Alexander Mikhalitsyn wrote:
>>> [   33.882936] EXT4-fs (dm-5): mounted filesystem 8aaf41b2-6ac0-4fa8-b92b-77d10e1d16ca r/w with ordered data mode. Quota mode: none.
>>> [   33.888365] EXT4-fs (dm-5): resizing filesystem from 7168 to 786432 blocks
>>> [   33.888740] ------------[ cut here ]------------
>>> [   33.888742] kernel BUG at fs/ext4/resize.c:324!
>> Ah, I was staring at this for a while before I understood what's going on
>> (it would be great to explain this in the changelog BTW).  As far as I
>> understand commit 665d3e0af4d3 ("ext4: reduce unnecessary memory allocation
>> in alloc_flex_gd()") can actually make flex_gd->resize_bg larger than
>> flexbg_size (for example when ogroup = flexbg_size, ngroup = 2*flexbg_size
>> - 1) which then confuses things. I think that was not really intended and
>> instead of fixing up ext4_alloc_group_tables() we should really change
>> the logic in alloc_flex_gd() to make sure flex_gd->resize_bg never exceeds
>> flexbg size. Baokun?
>>
>>                                 Honza
> 
> Hi Honza,
> 
> Your analysis is absolutely correct. It's a bug!
> Thank you for locating this issue！
> An extra 1 should not be added when calculating resize_bg in alloc_flex_gd().
> 
> 
> Hi Aleksandr,
> 
> Could you help test if the following changes work?
> 

I just got an internal bug report for this as well, and I can also confirm that
the patch fixes my testcase, thanks! Feel free to add:

Tested-by: Eric Sandeen <sandeen@redhat.com>

I had been trying to debug this and it felt like an off by one but I didn't get
to a solution in time. ;) 

Can you explain what the 2 cases under

/* Avoid allocating large 'groups' array if not needed */

are doing? I *think* the first 'if' is trying not to over-allocate for the last
batch of block groups that get added during a resize. What is the "else if" case
doing?

Thanks,
-Eric

> Thanks,
> Baokun
> 
> ---
> 
> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
> index e04eb08b9060..1f01a7632149 100644
> --- a/fs/ext4/resize.c
> +++ b/fs/ext4/resize.c
> @@ -253,10 +253,12 @@ static struct ext4_new_flex_group_data *alloc_flex_gd(unsigned int flexbg_size,
>         /* Avoid allocating large 'groups' array if not needed */
>         last_group = o_group | (flex_gd->resize_bg - 1);
>         if (n_group <= last_group)
> -               flex_gd->resize_bg = 1 << fls(n_group - o_group + 1);
> +               flex_gd->resize_bg = 1 << fls(n_group - o_group);
>         else if (n_group - last_group < flex_gd->resize_bg)
> -               flex_gd->resize_bg = 1 << max(fls(last_group - o_group + 1),
> +               flex_gd->resize_bg = 1 << max(fls(last_group - o_group),
>                                               fls(n_group - last_group));
> 
>         flex_gd->groups = kmalloc_array(flex_gd->resize_bg,
>                                         sizeof(struct ext4_new_group_data),
> 
> 



Return-Path: <linux-fsdevel+bounces-25819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F17950E17
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 22:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9D61B21349
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 20:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D396E1A704C;
	Tue, 13 Aug 2024 20:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="aY2qOOGO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GtY2C0vT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDF63B192;
	Tue, 13 Aug 2024 20:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723582062; cv=none; b=iw9cdCQT92PGyt4Y+jSnu/Ud0tv+2wy7ajr6wBGt5aBBVOmYVzkmqKqAAXduZan7Y1w07ZXpVsQVO7XdBzHg+zVdym6V70Ws8OXeM9Nddp6ow9KM3S2t3FsYZYPZi4vpSTLIeVMSGuSg+Q3kOd9X6PQU98A7WEmDSIZYBon+TSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723582062; c=relaxed/simple;
	bh=M/LwNQVprl9+escpuNpek32gpILVFHg58xZQCA0LrKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kPz1U4qXDv1eSg+ly8u4Y4/5SBaR3dR5+cI52pIBRN/aaW/NLoa2WWn6XNvFf6JWPOGgkzUJePp9hrdqMSlGjnuQE9MAHV/I2CV9fRtZmxsxrEd0Na9M/RtgLVDjzCm6ELro3zyz9GeHVIw9Zvn80Zz9KW1/nlpLja5rxiHPifM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=aY2qOOGO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GtY2C0vT; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 429E51383279;
	Tue, 13 Aug 2024 16:47:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 13 Aug 2024 16:47:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1723582059;
	 x=1723668459; bh=8s/4DJfpqgpEChzV4avMNJyyGnwMVIKgZ6HV3Q4Dz8w=; b=
	aY2qOOGO2yjehsZBQae4WoGxPQQxNqm1x0Bta+0xVqjScPmkrfTB/9DAySyKaS3C
	bC0ysJ5Q5CjmxnCSWu/6phs1Awa/l/7cs9lYhUD78yfgZdK1QJ3lu/oqj9jZUb1w
	JWHWE4Y16WovCara0rh9PSFss/55hefuwS0xRQ8TS76wLcbeHj+tlLt0EK1mCwuO
	zpazfJdQzn1Nbky1IWMEREwma+ldXkZqGqb9zl0N9Nb3Ls8iSexQUa93mlhL5pKJ
	nKDkUwgrgdS0PoueoKykpHDz0ZI0p+AutcEyOIPmkCiqhrS/EFjnmzbQhDcTmJur
	n4EG8lM+3ox5Ricl0PuDVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723582059; x=
	1723668459; bh=8s/4DJfpqgpEChzV4avMNJyyGnwMVIKgZ6HV3Q4Dz8w=; b=G
	tY2C0vTba4wRtoJO5r+xXbc7F3Kikx0fUAzV7DZ3Cy3qaPI70GHqSEBqayIaD46z
	uslnYzdhbXeOvoDCMfuYhy4GZpwc9avj+GWJmFA/ja1GOUCn1PR/vMF/7vWwVe8e
	9uRFajxMQjF4JzGT6571TLl1muWM6WVWUA0Su/Y1+2a72L890xL9PmGi3Ue1n0rn
	AdUP4ebJm+id+zmVy5NuZW92pR1BWUE6lUgVkigZAkXOamq5n6wc739SJ3urAeKX
	ShZilKDBmArDGuZxaQwpKTESyuCyVAOb0n08VE2nJGyay+EsPgLpb+XIhFxd/5AP
	Vd77qs6pKVTqqggbdkdvw==
X-ME-Sender: <xms:asa7ZgWiV3TwUsujRpzEd4kDldMxI-3m4Uo1hfGXwjupxXTwVCwJlQ>
    <xme:asa7ZkmWcj8909tfQqNQZezhruJtRKdJFYrH1zp3TOcPcYKTTFwnfEJ9rdtIW0OT5
    4zhVeFh7hlAw4Mo>
X-ME-Received: <xmr:asa7Zkbre8fh_TODnupl7T3iD5Po7JruhX97IIfelKpcUvpml9Yohg5O9fQKkM8V0R75h6a82easMDzOWRsr6zWQRFjgZs02Zs32Rwm_GALBQ7EPXovacPixWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusg
    gvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeevhffgvdeltddu
    gfdtgfegleefvdehfeeiveejieefveeiteeggffggfeulefgjeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghr
    thesfhgrshhtmhgrihhlrdhfmhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohephigrnhhghihunhehtdeshhhurgifvghirdgtohhmpdhrtghp
    thhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehlihhnuhigqd
    hfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhigi
    hirghokhgvnhhgsehhuhgrfigvihdrtghomh
X-ME-Proxy: <xmx:asa7ZvV8jyJ4xrHqmX9y3plDk8GtBJ6YdEqGX1kKvKR8A6eLhXnWzw>
    <xmx:asa7ZqkWfIVeD48EtDjVdGAtRiRF3qLsXN6HOR_fHajttpPsP8OrwQ>
    <xmx:asa7ZkcY5EQhE03jLqYmIqsEhpmMBIxUqfEQsKsLEWFxBFck3OO9Lg>
    <xmx:asa7ZsGx_6jrSYFjTWC_SwTouLCmrDMkBf6kkNEMsR8VuVg1pr9JkQ>
    <xmx:a8a7ZhtsLRrW7heaDvzmUNiJBx97m4KgOw5HKE83um-kP-lIWUtRMwR->
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 16:47:37 -0400 (EDT)
Message-ID: <5b7ac9cf-8cac-4066-a334-94a4acb4b678@fastmail.fm>
Date: Tue, 13 Aug 2024 22:47:35 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: fix race conditions on fi->nlookup
To: yangyun <yangyun50@huawei.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 lixiaokeng@huawei.com
References: <20240810034209.552795-1-yangyun50@huawei.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, fr, ru
In-Reply-To: <20240810034209.552795-1-yangyun50@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/10/24 05:42, yangyun wrote:
> Lock on fi->nlookup is missed in fuse_fill_super_submount(). Add lock
> on it to prevent race conditions.
> 
> Fixes: 1866d779d5d2 ("fuse: Allow fuse_fill_super_common() for submounts")
> Cc: stable@vger.kernel.org
> Signed-off-by: yangyun <yangyun50@huawei.com>
> ---
>  fs/fuse/inode.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 99e44ea7d875..2e220f245ceb 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1593,7 +1593,9 @@ static int fuse_fill_super_submount(struct super_block *sb,
>  	 * that, though, so undo it here.
>  	 */
>  	fi = get_fuse_inode(root);
> +	spin_lock(&fi->lock);
>  	fi->nlookup--;
> +	spin_unlock(&fi->lock);
>  
>  	sb->s_d_op = &fuse_dentry_operations;
>  	sb->s_root = d_make_root(root);

LGTM


Reviewed-by: Bernd Schubert <bschubert@ddn.com>


Return-Path: <linux-fsdevel+bounces-50678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB01ACE5F7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 23:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2AB13A8D49
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 21:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFCC214801;
	Wed,  4 Jun 2025 21:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="K5uwBi66";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a7pruAJk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4A8111BF;
	Wed,  4 Jun 2025 21:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749071110; cv=none; b=D/05AnvEvVX18nOVJLH2tbSZal7LWhBwH6/8wfbgylQl7EHVF6IKEImYS+dpoMB6xGZoouJQfJPDLw4SEQK8v7pyPJw75VuM+dCZIV6+Ke8bxKejbKKkFiE1KDFM13zOUrQDf4Bi79rmcz6DR18AK84H3RRGoE9DyyTSeXeP7w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749071110; c=relaxed/simple;
	bh=bEPicGUo4qnCOr1bD/cXt+aWZhpyEmTdF6THTGCiYRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VQRA4f8NFxeSAKANuLSVmljLzjkR3Gc+aMrREGxdALxuObZy6Rm6I33n3bibgh4Jl5Yb2EkrMmn2i0xkCIqYS/cqZdngCp5dt3ynALwePn0l3ln7BMnDLZAsv16oQlyKE3DHIZRPjBXPQZq6pPxroKuV7bfYsbrJx8ADSZOhr0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=K5uwBi66; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a7pruAJk; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 89976254010B;
	Wed,  4 Jun 2025 17:05:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 04 Jun 2025 17:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1749071104;
	 x=1749157504; bh=nCMzeyn5uLFBlTe5xWonZlY2M+t/v8JBIWqLsUIvznQ=; b=
	K5uwBi66NqBEpdjtZ6c72o180QHl2RzU5bNnI7T3QE9N67Qu6ZMiTph1qMdQkk2T
	begf/uUoKHt980BVkPdPPUuqdUW3gpOBaSitbiPvUqdN5lcquSDthG8CwF6KEemZ
	0MJdBsoQ77gVrOaMbqCSnMqiet365bFIVnl0N6z+enRpYeN3QlqPA/Fv8eR//vc7
	tT2V7fKMcormRfmFBDIy4z6Yqdhu9atzeMyg1SwPrZRHSVTwsmA441o3JGEYkTZg
	rwcFtv0yuPoesOPSRBplRmEo4hENeMM9ix3qpdhdeu4Jya3JMJAqEv9JAU3hXiwp
	8gNykMclc3816XGuNUQgpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749071104; x=
	1749157504; bh=nCMzeyn5uLFBlTe5xWonZlY2M+t/v8JBIWqLsUIvznQ=; b=a
	7pruAJklutIPcIfcFaq91us+J1a6lhTF+/dpxkYxCCNcQecKnMNNoAXdoKVFjhZw
	ke2vWGGCYKWtzJo4G5j35CrCteYvLf0EJ8s+eB9tOVNAui4gf1LqdHdfdFjDdd+U
	I574BV8sYC6wmXSwOQszTqlqrkX3zl02auFJUXEQeEY3chqKJEvjtt656xCz+xUk
	DEPK4YPzperNV+ff1Hgfx4L7ZhjT/53TXWgxBIEe/xRWg2IWIpihwKMGtIxE79Xa
	v7TQrtRLeL6tSUo/9ppD7tbgXd7q8QcmiCIdxrRFyjssprOKnYr+fK14hTJzl0Hh
	7uMK+5WI9v+pTw2UA1pQQ==
X-ME-Sender: <xms:_7RAaC2jx9TBJpcK1E1BZEfFxfH3j2pOvKLpkhRG-q-0_EynxfZm7Q>
    <xme:_7RAaFEEDbGzYgZJJD1uw65aqZ0WsY_UdlkpWPZzogjTQ9Ly75f4n1NKcYV0lS2iG
    UWcSLaNjkzUROjRw3M>
X-ME-Received: <xmr:_7RAaK70d0TSOfoQKaFhY0PXeo7kM2X8jz3DAk82y8lWD-V_ONwmIlMqOLS6K1xykTUUV9s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdej
    necuhfhrohhmpefvihhnghhmrghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqne
    cuggftrfgrthhtvghrnhepudekvefhgeevvdevieehvddvgefhgeelgfdugeeftedvkeei
    gfeltdehgeeghffgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgtphhtthhopeelpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrgh
    druhhkpdhrtghpthhtohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopehs
    ohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvg
    drtghomhdprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopegrlhgv
    gigvihdrshhtrghrohhvohhithhovhesghhmrghilhdrtghomhdprhgtphhtthhopegsrh
    gruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsvggtuhhr
    ihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:_7RAaD3uMqa2dmsPrkF4FDf9dFa4miYrsOWptcDOtHLcM41YcjimAQ>
    <xmx:_7RAaFECOkg_-b8MIxGfbmo0i43G6lwg_llEzyYxZr9GlBmvjHCFgQ>
    <xmx:_7RAaM9eWsAXB1JOP0zk-rsgcE_L07j75dkL1g0-YxQMcUDQ44Xt9w>
    <xmx:_7RAaKnpGXMNqqtQjPTrUkactomVZsaoa9ITWSZoJy4ZlcanZsrCFg>
    <xmx:ALVAaN7IKCtciXim2M9XpsBmHblpcIS64S0ZtaU6OCXPKSsoxMIrDdbF>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Jun 2025 17:05:02 -0400 (EDT)
Message-ID: <5c8476df-56c4-4dd1-b5c8-40cb604eae62@maowtm.org>
Date: Wed, 4 Jun 2025 22:05:01 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] landlock: walk parent dir without taking
 references
To: Al Viro <viro@zeniv.linux.org.uk>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>
Cc: Song Liu <song@kernel.org>, =?UTF-8?Q?G=C3=BCnther_Noack?=
 <gnoack@google.com>, Jan Kara <jack@suse.cz>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Christian Brauner <brauner@kernel.org>,
 linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <cover.1748997840.git.m@maowtm.org>
 <8cf726883f6dae564559e4aacdb2c09bf532fcc5.1748997840.git.m@maowtm.org>
 <20250604.ciecheo7EeNg@digikod.net>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20250604.ciecheo7EeNg@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/4/25 18:15, Mickaël Salaün wrote:
> On Wed, Jun 04, 2025 at 01:45:43AM +0100, Tingmao Wang wrote:
>> [..]
>> @@ -897,10 +898,14 @@ static bool is_access_to_paths_allowed(
>>  			break;
>>  jump_up:
>>  		if (walker_path.dentry == walker_path.mnt->mnt_root) {
>> +			/* follow_up gets the parent and puts the passed in path */
>> +			path_get(&walker_path);
>>  			if (follow_up(&walker_path)) {
>> +				path_put(&walker_path);
>
> path_put() cannot be safely called in a RCU read-side critical section
> because it can free memory which can sleep, and also because it can wait
> for a lock.  However, we can call rcu_read_unlock() before and
> rcu_read_lock() after (if we hold a reference).

Thanks for pointing this out.

Actually I think this might be even more tricky.  I'm not sure if we can
always rely on the dentry still being there after rcu_read_unlock(),
regardless of whether we do a path_get() before unlocking...  Even when
we're inside a RCU read-side critical section, my understanding is that if
a dentry reaches zero refcount and is selected to be freed (either
immediately or by LRU) from another CPU, dentry_free will do
call_rcu(&dentry->d_u.d_rcu, __d_free) which will cause the dentry to
immediately be freed after our rcu_read_unlock(), regardless of whether we
had a path_get() before that.

In fact because lockref_mark_dead sets the refcount to negative,
path_get() would simply be wrong.  We could use lockref_get_not_dead()
instead, and only continue if we actually acquired a reference, but then
we have the problem of not being able to dput() the dentry acquired by
follow_up(), without risking it getting killed before we can enter RCU
again (although I do wonder if it's possible for it to be killed, given
that there is an active mountpoint on it that we hold a reference for?).

While we could probably do something like "defer the dput() until we next
reach a mountpoint and can rcu_read_unlock()", or use lockref_put_return()
and assert that the dentry must still have refcount > 0 since it's an
in-use mountpoint, after a lot of thinking it seems to me the only clean
solution is to have a mechanism of walking up mounts completely
reference-free.  Maybe what we actually need is choose_mountpoint_rcu().

That function is private, so I guess a question for Al and other VFS
people here is, can we potentially expose an equivalent publicly?
(Perhaps it would only do effectively what __prepend_path in d_path.c
does, and we can track the mount_lock seqcount outside.  Also the fact
that throughout all this we have a valid reference to the leaf dentry we
started from, to me should mean that the mount can't disappear under us
anyway)

>
>>  				/* Ignores hidden mount points. */
>>  				goto jump_up;
>>  			} else {
>> +				path_put(&walker_path);
>>  				/*
>>  				 * Stops at the real root.  Denies access
>>  				 * because not all layers have granted access.
>> @@ -920,11 +925,11 @@ static bool is_access_to_paths_allowed(
>>  			}
>>  			break;
>>  		}
>> -		parent_dentry = dget_parent(walker_path.dentry);
>> -		dput(walker_path.dentry);
>> +		parent_dentry = walker_path.dentry->d_parent;
>>  		walker_path.dentry = parent_dentry;
>>  	}
>> -	path_put(&walker_path);
>> +
>> +	rcu_read_unlock();
>>
>>  	if (!allowed_parent1) {
>>  		log_request_parent1->type = LANDLOCK_REQUEST_FS_ACCESS;
>> @@ -1045,12 +1050,11 @@ static bool collect_domain_accesses(
>>  					       layer_masks_dom,
>>  					       LANDLOCK_KEY_INODE);
>>
>> -	dget(dir);
>> -	while (true) {
>> -		struct dentry *parent_dentry;
>> +	rcu_read_lock();
>>
>> +	while (true) {
>>  		/* Gets all layers allowing all domain accesses. */
>> -		if (landlock_unmask_layers(find_rule(domain, dir), access_dom,
>> +		if (landlock_unmask_layers(find_rule_rcu(domain, dir), access_dom,
>>  					   layer_masks_dom,
>>  					   ARRAY_SIZE(*layer_masks_dom))) {
>>  			/*
>> @@ -1065,11 +1069,11 @@ static bool collect_domain_accesses(
>>  		if (dir == mnt_root || WARN_ON_ONCE(IS_ROOT(dir)))
>>  			break;
>>
>> -		parent_dentry = dget_parent(dir);
>> -		dput(dir);
>> -		dir = parent_dentry;
>> +		dir = dir->d_parent;
>>  	}
>> -	dput(dir);
>> +
>> +	rcu_read_unlock();
>> +
>>  	return ret;
>>  }
>>
>> --
>> 2.49.0
>>
>>


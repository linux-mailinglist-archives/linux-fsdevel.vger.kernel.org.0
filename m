Return-Path: <linux-fsdevel+bounces-40332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0554A22494
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 20:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A247164732
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 19:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0211E260A;
	Wed, 29 Jan 2025 19:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="GJMEGBhV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xTKjkc7j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150781E2821;
	Wed, 29 Jan 2025 19:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738179065; cv=none; b=Hzzv9ABxav2Inj57oQ60dib80qOmAYIja5f2LuXGAO+iyzbblCGSxoS8Yij/ymL2Y7900R1Onk3yWwU9/syWuq5r2l6Cw8c2YIiAUwPwqujnLdSL7vk1U3SFbI1zagNewcTiGAI8R1IoVf5N7zaScCBnAVmslDlzeE/fxI7+5Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738179065; c=relaxed/simple;
	bh=vdfqN/kDPUJo29hgM+AV+zRKIxfOISJjwqXxOA9QM6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pHxojE9mKDFXeI8MvyHDigGrJzy37hzfyQvlDupffKetAxzC1jbcCOE55NVs56dMaZJt12ivDalS6A/WTYZpiC3def/Qk4e5FX5M0Npp7CD31DACGibPHqOk8BJHnzvNOohwdmA2XWP6OS7kauSVqMfcVXbqrN1SJgqd23qAWTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=GJMEGBhV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xTKjkc7j; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id EF5411380C5D;
	Wed, 29 Jan 2025 14:30:58 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 29 Jan 2025 14:30:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1738179058;
	 x=1738265458; bh=dr66PG1IrTsMSgbA+esRJRthRDTA/3E1zVY0P87TmmM=; b=
	GJMEGBhVJdNXT7TdFoyl6wMORDODmnf4df46niKkNa0Bj/glxiP7+063YIRrUEN/
	Nbh9mePad1dhZB/RzvpkRBrSxilHu4i6NUySl2o0LwxbLsQjoptE3WeVYaF53mmT
	F9cQGFwSZo2GM3zryT95h+3qs1yLj7ELOKEIEqh4cyIpi1E32ZPoYqbKzdN3/j32
	l5tpaqEpJ2wh5PsjW+e8wUKmK+NcJwLF0OAhuMSx6WT8Ull+O6om1d4Dr2HSaUuq
	zPaK2JuGrDdQBq46xC6ngoQcmmRIeUYgE8fGBZIe2AUo3ZXtoCoHQzWaIvbptFuq
	3k4to+Hm26cdubVxJAad/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738179058; x=
	1738265458; bh=dr66PG1IrTsMSgbA+esRJRthRDTA/3E1zVY0P87TmmM=; b=x
	TKjkc7jX3avYUpDHrlFFrbNSLIZ19R7PcrPJkGHAW26aRVMZpqpC9hZDC/YYS5wK
	k0ZZYi150LNEq5Q+e5zdKQ/1ukdso2TGjYJQf72CiXzuETuxnQUiU26hJfNz5WZ7
	zKC7SJBM8UmHjswluUpRVXQZ9L6VyB+4KHyki6Nc+HdJTuzBa7R3t2XyJ4xHmAIC
	S1d1yWmT4WjDWL8g02QP04Wem1criaV0YCkqz6onxD0NgvO6sHpS3Ytaitpa2v5Z
	NSKoN2MkN3afojUGQqPA0YxZSnRU5kUMxozfnVZstjiYVEQtWpfSut88q4VzNk6p
	xV0pphynsd4ancwSZRMNA==
X-ME-Sender: <xms:8oGaZ9gAuYHLmaJUh9eDNV83QpNFCgQ5sv5MAvItKvWTER1UCwNxgw>
    <xme:8oGaZyCIndEvGI7ew3LZjKRyinT2sXYrN80YyKntgNHGhTfCGX-WerPmiYMcDcDEe
    fCwZdCgWTuNrJ6r>
X-ME-Received: <xmr:8oGaZ9ENQP1ltkzJ1BW7LEbMziKrK5ijFDT6iFsqCv7_JiHO7C9AE-SUdWhRlsmMO4WvJOhlwwCPLSsL2StfziiMfgl7IWuUFUlfub3bb7zab9EyMlgO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdej
    necuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnh
    gurdgtohhmqeenucggtffrrghtthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeu
    udejhfehgedufedvhfehueevudeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehluhhishesihhgrg
    hlihgrrdgtohhmpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgt
    phhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepthhqihhnsehjuhhmphhtrhgrughinhhgrdgtohhm
X-ME-Proxy: <xmx:8oGaZyQUP6AaUdw43gDWzLBq42dIqygJLSacJ30i67pbsZvM74VkpQ>
    <xmx:8oGaZ6yvZ-y9wlmxbrG02MYms3HSI9mCtvQ9Kr5MQapmUY_P_ICL7A>
    <xmx:8oGaZ47wcGuJFuNj435k2byLiU_CEbQhaW7XoaK-9BD9sKvQDRchYQ>
    <xmx:8oGaZ_yRu5DNywMdJFm1Qu8Edzt1t2akK4pR0D4GMr9bEpeeVKvieg>
    <xmx:8oGaZxqM5y0VtpLscBi1opvdL7FiE2OcA-F4kvUDgiNQZzWjZDiytoU0>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jan 2025 14:30:57 -0500 (EST)
Message-ID: <efba1076-d14c-488b-954a-856e0427f917@bsbernd.com>
Date: Wed, 29 Jan 2025 20:30:56 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] fuse: fix race in fuse_notify_store()
To: Luis Henriques <luis@igalia.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Teng Qin <tqin@jumptrading.com>
References: <20250129184420.28417-1-luis@igalia.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250129184420.28417-1-luis@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Luis,

On 1/29/25 19:44, Luis Henriques wrote:
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 27ccae63495d..9a0cd88a9bb9 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1630,6 +1630,7 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
>  	unsigned int num;
>  	loff_t file_size;
>  	loff_t end;
> +	int fgp_flags = FGP_LOCK | FGP_ACCESSED | FGP_CREAT;
>  
>  	err = -EINVAL;
>  	if (size < sizeof(outarg))
> @@ -1645,6 +1646,9 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
>  
>  	nodeid = outarg.nodeid;
>  
> +	if (outarg.flags & FUSE_NOTIFY_STORE_NOWAIT)
> +		fgp_flags |= FGP_NOWAIT;
> +
>  	down_read(&fc->killsb);
>  
>  	err = -ENOENT;
> @@ -1668,14 +1672,25 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
>  		struct page *page;
>  		unsigned int this_num;
>  
> -		folio = filemap_grab_folio(mapping, index);
> -		err = PTR_ERR(folio);
> -		if (IS_ERR(folio))
> -			goto out_iput;
> +		folio = __filemap_get_folio(mapping, index, fgp_flags,
> +					    mapping_gfp_mask(mapping));
> +		err = PTR_ERR_OR_ZERO(folio);
> +		if (err) {
> +			if (!(outarg.flags & FUSE_NOTIFY_STORE_NOWAIT))
> +				goto out_iput;
> +			page = NULL;
> +			/* XXX */

What is the XXX for? 
Also, I think you want to go to "skip" only on -EAGAIN? And if so, need
to unset err? 


> +			this_num = min_t(unsigned int, num, PAGE_SIZE - offset);
> +		} else {
> +			page = &folio->page;
> +			this_num = min_t(unsigned int, num,
> +					 folio_size(folio) - offset);
> +		}
>  
> -		page = &folio->page;
> -		this_num = min_t(unsigned, num, folio_size(folio) - offset);
>  		err = fuse_copy_page(cs, &page, offset, this_num, 0);
> +		if (!page)
> +			goto skip;
> +
>  		if (!folio_test_uptodate(folio) && !err && offset == 0 &&
>  		    (this_num == folio_size(folio) || file_size == end)) {
>  			folio_zero_segment(folio, this_num, folio_size(folio));
> @@ -1683,7 +1698,7 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
>  		}
>  		folio_unlock(folio);
>  		folio_put(folio);
> -
> +skip:
>  		if (err)
>  			goto out_iput;
>  
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index e9e78292d107..59725f89340e 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -576,6 +576,12 @@ struct fuse_file_lock {
>   */
>  #define FUSE_EXPIRE_ONLY		(1 << 0)
>  
> +/**
> + * notify_store flags
> + * FUSE_NOTIFY_STORE_NOWAIT: skip locked pages
> + */
> +#define FUSE_NOTIFY_STORE_NOWAIT	(1 << 0)
> +
>  /**
>   * extension type
>   * FUSE_MAX_NR_SECCTX: maximum value of &fuse_secctx_header.nr_secctx
> @@ -1075,7 +1081,7 @@ struct fuse_notify_store_out {
>  	uint64_t	nodeid;
>  	uint64_t	offset;
>  	uint32_t	size;
> -	uint32_t	padding;
> +	uint32_t	flags;
>  };
>  
>  struct fuse_notify_retrieve_out {
> 

Thanks,
Bernd



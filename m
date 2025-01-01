Return-Path: <linux-fsdevel+bounces-38315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9A49FF512
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jan 2025 23:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED7C83A26A5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jan 2025 22:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112035914C;
	Wed,  1 Jan 2025 22:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="I3Js8Inc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w6FkrmeE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592061854
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jan 2025 22:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735771613; cv=none; b=ZuTDNfx1MHADL/7u4m4xRm6FdKJfwp+n8nRZjdh2esx6Vi2WUSs/BFNfJDaIGrSKcJ8R/uhdX+LJbj0YZo+7cd5K+YvEDH6xGsbwORORSUTvu6e4LFfYVZQxFBdlrDuIXhm5TfJVSbwrlB4E27HGcfnhFoikEe+xbrJ/F5DF8yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735771613; c=relaxed/simple;
	bh=BX8fh0Tb2XoBAOxPWdi6WHMZ5grzjpyUzwmZ3XzxfQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ppb3S6S8Av36nEylRcmKcDOFU56SbWH2Yx/4J8NE9w3MigtwULO1OhiHlHVUVGKnzTBdfsSkp8IzI/zaBmY3UhE5XCfqql/zaYAz3x2Lj3buZ+DbCGOO2/hBHNcnfmxBz35fdzlAvGRGrBWvsc2MznoNWYEN95ROIi9SM/unsrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=I3Js8Inc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w6FkrmeE; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 47976114011F;
	Wed,  1 Jan 2025 17:46:49 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 01 Jan 2025 17:46:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735771609;
	 x=1735858009; bh=bFLMLCCi378DrYTctTUmddpvrxwsOU6/yVQkf4Ozt+I=; b=
	I3Js8IncFBoMVcQtKWKJFPgHQon3onddcfEwX5AmKqHzhSpWmjFhdbjkhZZH37Gp
	A8Qe9W0cnnSfEP2k1KfNmTmezbwhz+iFfedyl8H/b/50bREJuc7T3cfWUGxcv+yK
	LZuiRnrFzFpzBkSpbktYyZUv8UnFYDIwmP8XUHqD1Dw+8V9mXmc8uyfj1ID7EtB5
	1GbqPyRK7Zwpj2ZtunqKzBGKk1/QSWfJ3azc0UuTU8a2PgNH496Ms2+4uokL61NT
	vw0n/ndqftjyNgYmpanuEpiYuVl0XivEkgv9+w8nYdvwcSHygYMiA+p+0t3HfGRf
	5KiVM9i/8u7fU19Ry9FQig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735771609; x=
	1735858009; bh=bFLMLCCi378DrYTctTUmddpvrxwsOU6/yVQkf4Ozt+I=; b=w
	6FkrmeE8tNstCFfJSbwskZMmSh/iT5mvA8a7yakqRjE/YJjaoEQ/JQdT7QEr4f8e
	BiOqvQ+A4IkF4B3xIyLMxz2bIO/d8lK7KRgJACNsA3f/6mTcNbNE+tKMD5D6Fw/O
	lP7rdbi06t3X9gP4RBsupanpUccy7PFQrmJiVcF58jNwtPhs/eLV9ADeXovtNf7J
	lC80y9gyfKyh1CZc1eugL+B/fKjJPM3GtOFX5a68ygHzXv4Am07T50sRlf/ZOHbv
	8py9vp/fGNb9ir21uTvogwmy6BRaozGMU9I6HdKTlPy/pPqUujwJk9gFJgXwLHH/
	GjSFjmvpCoOkgqGMHLuUA==
X-ME-Sender: <xms:2MV1Z_odVhz17l77Szm9FNdBYkAP3MjdP3bAP11prGqRA8cHQuzUQg>
    <xme:2MV1Z5p7ByZl-ysDK5vggCIsgs_4UHd9iSf1uAaZc1Uf5oimMABQtxdVK7bgIH123
    U3kQksz3oI7fL5W>
X-ME-Received: <xmr:2MV1Z8NUlF8seRi163Zkyebemy7eX8eAF_2oA6p10JdNsWRKqTWQPyxeBgX0DsLRTcZxzxY2p776u1KJ4DQt06shpt2aeRFTW-Yg7YVLjDgXEaMx9dN9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefudcutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffrtefo
    kffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsuc
    dlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfh
    rhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtse
    hfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeffjeevfeefjefghfefhfei
    ueffffetledtgffhhfdttdefueevledvleetfeevtdenucffohhmrghinhepkhgvrhhnvg
    hlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdrfhhmpdhnsggprhgtph
    htthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrmhhirhejfehilhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupd
    hrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehprhhinhgtvghrsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:2MV1Zy619ng-uSzRYbrEB3zyi9pjeu1MeahF0s4906UftIkzTCWlhQ>
    <xmx:2MV1Z-48fk44MRrkLxboKLkwswyRKAe_AbrQvsFcHjn_7Mo3mvAuLQ>
    <xmx:2MV1Z6hhzOae6Beg6d68ciljoU-ROeRpXAeLjBjLd4YhbppUUjcfiA>
    <xmx:2MV1Zw4WQA7zUoQS6RCANw3IwNxLT7nWVHgH1JO6qBONDSqenr-QhQ>
    <xmx:2cV1Z50Y7dqLxwqiEFMu1EYvxTQ2S80XSnRSBx15-o3rIG5f7SOKzswS>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jan 2025 17:46:47 -0500 (EST)
Message-ID: <84b87729-e1a5-4191-9d1f-b012a653a5e8@fastmail.fm>
Date: Wed, 1 Jan 2025 23:46:46 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: respect FOPEN_KEEP_CACHE on opendir
To: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, Prince Kumar <princer@google.com>
References: <20250101130037.96680-1-amir73il@gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250101130037.96680-1-amir73il@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/1/25 14:00, Amir Goldstein wrote:
> The re-factoring of fuse_dir_open() missed the need to invalidate
> directory inode page cache with open flag FOPEN_KEEP_CACHE.
> 
> Fixes: 7de64d521bf92 ("fuse: break up fuse_open_common()")
> Reported-by: Prince Kumar <princer@google.com>
> Closes: https://lore.kernel.org/linux-fsdevel/CAEW=TRr7CYb4LtsvQPLj-zx5Y+EYBmGfM24SuzwyDoGVNoKm7w@mail.gmail.com/
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Miklos,
> 
> I verified the fix using:
> passthrough_ll -d -o source=/src,cache=always /mnt
> 
> and watching debug prints from repeating 'ls /mnt' invocations.
> 
> With current upstream, dir cache is kept even though passthrough_ll
> never sets keep_cache in opendir.
> 
> passthrough_hp always set keep_cache together with cache_readdir,
> so it could not have noticed this regression.
> 
> I've modified passthrough_ll as follows to test the keep_cache flag:
> 
>         fi->fh = (uintptr_t) d;
> <       if (lo->cache == CACHE_ALWAYS)
>>       if (lo->cache != CACHE_NEVER)
>                 fi->cache_readdir = 1;
>>       if (lo->cache == CACHE_ALWAYS)
>>               fi->keep_cache = 1;
>         fuse_reply_open(req, fi);
>         return;
> 
> Thanks,
> Amir.
> 
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 494ac372ace07..e540d05549fff 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -1681,6 +1681,8 @@ static int fuse_dir_open(struct inode *inode, struct file *file)
>  		 */
>  		if (ff->open_flags & (FOPEN_STREAM | FOPEN_NONSEEKABLE))
>  			nonseekable_open(inode, file);
> +		if (!(ff->open_flags & FOPEN_KEEP_CACHE))
> +			invalidate_inode_pages2(inode->i_mapping);
>  	}
>  
>  	return err;

LGTM. Thanks for the quick fix Amir, especially during holidays!

Reviewed-by: Bernd Schubert <bernd.schubert@fastmail.fm>


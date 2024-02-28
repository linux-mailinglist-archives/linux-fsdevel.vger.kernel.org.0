Return-Path: <linux-fsdevel+bounces-13110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D5F86B516
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 17:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3360D1F23E6C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 16:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D606EF1B;
	Wed, 28 Feb 2024 16:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="O4QKIlwr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k9RmYnAu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821001EA99;
	Wed, 28 Feb 2024 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709138040; cv=none; b=d/NqzcFQPKb2je96cX2Q8gXEYWJ2xyRmrJk66EJauUtVSpc7IHKBBgPzlYjtMZ4oLTbD/99IDgLK/QsHBgZfRd3JRB6hTTOFmMlYCRR+Ikgq92SrBlWp7/lfYdP9FKEHKC1eWUucY8ZvrF2+IohEjF4g9gH2GLIWxGZqH18VhtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709138040; c=relaxed/simple;
	bh=fKyv3eOUkZmPNDLrZFIM2iMJCLNonlLzph3MZvWKl4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JRHEyyzthBwA9vS/aR0Kz6U64ZZINbAPoZoJh8hi/PZqUcHHJEVuuGtW+mOPlrNL/igyod/fX/HLn8jGJHmbGgGR99F8VeHJpAQk4XJlWHtIULMH0Nv4Bv8UxSKxCYAnYkKRlGFE5BUxlMwzP8X4g0+AOmJ+KA2LZNecd1ngEWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=O4QKIlwr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k9RmYnAu; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id E75393200AF4;
	Wed, 28 Feb 2024 11:33:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 28 Feb 2024 11:33:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1709138036;
	 x=1709224436; bh=5Mknzk9SCmZIEgGb6ZRq5OcLE39Ejl1tkweLomEHib0=; b=
	O4QKIlwre9w04a7q4cn8ymssclR3llpG2XlqiwHZox/2/djrsh0ey7S+33ABP7GD
	DCzqR3pUqEYzkxLpo23SGp8PiyCJakK6dYLbHcHIBDoOM2zuDGnKe7mbgJ6SyV2v
	qASGKxW6PzrjIf+WkhvHGKMnAPLlC2kXJWn02fGdzl6eVz2NHCLQuLWd6siHTeok
	pK4LPqCRGWGIirJCo9sTOQ2eawgLsXkRMLVWrLzUy0n+4sFVNYGfnSWfKaGswUII
	fz0EefECn9BwMznsTlkSM9NltMiYmO5XDi9zCaIUykvPlA6EdV0X2+Y7QPWwbizn
	YsZHGZJK+qe1sZHtEUd+4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709138036; x=
	1709224436; bh=5Mknzk9SCmZIEgGb6ZRq5OcLE39Ejl1tkweLomEHib0=; b=k
	9RmYnAuybbNKTJUXzDUPYbXLzM6n1rxsBRuKds+TlG0cB+/d60E38TcvD1REUccW
	uAYMPSA32zmWWLC7M15mYe8cny9kbaCcooLITLUsG+QEzgEHsKk7b0DwE5SA+ISL
	QnryhAzDSQz0hLveSPGYz3LGTW5edI8XuokAn84PJsSFLnLZzbGpDMVQI9qavcQx
	Tviv2jkSSdIGpp3Y50/Ir+8RFYbioMGkKRp9k0fjiEXe70My/EAPwwHduWy/RLnC
	919VmjLEcGBBvqestxCAJLYF1X+FtBP0gmsBFlr+xDyTKm0w2wZc/PbIm7Wit2QJ
	0LQSDUK846uD1fgPo+Agw==
X-ME-Sender: <xms:dGDfZWKE46g-OYQ47dwc6__pTdZBOSiSQQwsPLkAoUOfP5cQSp4QNQ>
    <xme:dGDfZeKFHaCLO4i7ZP99B6xATvf44ow2ArHrg6DZHgRiI_ui8UExU4k91jBGNz0xu
    6sNx3WDln4tySKE>
X-ME-Received: <xmr:dGDfZWtlkxJYGgrupClfJdaNuVijzhvzpTzhEAUJyKemgtbF7Gc0CDHuedcUCpiRj_soRHqTBYHXKp_eO5e0cfeQZPODJgy95e3LrM_k_7j1eh1ew5j5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeejgdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeevhffgvdeltddugfdtgfegleefvdehfeeiveej
    ieefveeiteeggffggfeulefgjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhf
    mh
X-ME-Proxy: <xmx:dGDfZba8Z-OmV3a9AAdBhS7IvvfWn0N8gdAFWkZJPMZNksnck186sw>
    <xmx:dGDfZdahwg4N1Drk946vlZCh76OaUBSxzgiYydP4a6oNRAExXeFN0Q>
    <xmx:dGDfZXDIc2z88XlzjLYI7Z-hHtSbD9gC5QPyphxB-JYw3oC9HZI6DA>
    <xmx:dGDfZRHMQlIJSpz6sNWzJ1EDALtC98NbzTf6yIWy2F6t_Jtry6TpIQ>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Feb 2024 11:33:55 -0500 (EST)
Message-ID: <fa6cd2cc-252c-492f-adb5-7a0d09c20799@fastmail.fm>
Date: Wed, 28 Feb 2024 17:33:54 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] fuse: don't unhash root
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
 stable@vger.kernel.org
References: <20240228160213.1988854-1-mszeredi@redhat.com>
 <20240228160213.1988854-3-mszeredi@redhat.com>
Content-Language: en-US, de-DE, fr
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <20240228160213.1988854-3-mszeredi@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/28/24 17:02, Miklos Szeredi wrote:
> The root inode is assumed to be always hashed.  Do not unhash the root
> inode even if it is marked BAD.
> 
> Fixes: 5d069dbe8aaf ("fuse: fix bad inode")
> Cc: <stable@vger.kernel.org> # v5.11
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/fuse/fuse_i.h | 1 -
>  fs/fuse/inode.c  | 7 +++++--
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 7bd3552b1e80..4ef6087f0e5c 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -994,7 +994,6 @@ static inline bool fuse_stale_inode(const struct inode *inode, int generation,
>  
>  static inline void fuse_make_bad(struct inode *inode)
>  {
> -	remove_inode_hash(inode);
>  	set_bit(FUSE_I_BAD, &get_fuse_inode(inode)->state);
>  }

Hmm, what about callers like fuse_direntplus_link? It now never removes
the inode hash for these? Depend on lookup/revalidate?


Thanks,
Bernd

>  
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index c26a84439934..aa0614e8791c 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -475,8 +475,11 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
>  	} else if (fuse_stale_inode(inode, generation, attr)) {
>  		/* nodeid was reused, any I/O on the old inode should fail */
>  		fuse_make_bad(inode);
> -		iput(inode);
> -		goto retry;
> +		if (inode != d_inode(sb->s_root)) {
> +			remove_inode_hash(inode);
> +			iput(inode);
> +			goto retry;
> +		}
>  	}
>  	fi = get_fuse_inode(inode);
>  	spin_lock(&fi->lock);



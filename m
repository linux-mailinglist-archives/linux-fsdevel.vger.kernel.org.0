Return-Path: <linux-fsdevel+bounces-37109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CC69EDA58
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 23:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE57D167A27
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 22:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCB41EC4F0;
	Wed, 11 Dec 2024 22:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="B3hCmr13";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bC+0q8om"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550701BC085
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 22:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733957205; cv=none; b=Ped9i2ufBD1rBBAQK5wPB0IeL7XN/GghgP+PqLFHD4pOGQXJ31db/JaztK72YtkOgv9u7aOHBaewCE+8pei4+nMN5UyZH1LgslfuLg8dOQV3VmKx246IupRokTLxBE/W09DCeo9QdXuB8MQ3LcOav+1RIhZZrzcAFpQyTVicKMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733957205; c=relaxed/simple;
	bh=QS+Hzl4vZNXt6AiBHJbjqrSqKlWiWM6ysfpl6x92Cd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZFkp2fo7BV1GWFPaqh6rW8Emg7we7d/2ADtX1YjI/ZF3zJcCkvIni3SMyTIh37Xs2RUMGNTfMbkhA9mXI5N1iy4xUQUt7NXFX9fZHkMr0G3PWNNlAFi5X4B4vdGD3Yu7YyWFONiiKRlAQH/NpQXLoIL38JS8J+4yGia/jXxwBLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=B3hCmr13; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bC+0q8om; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 08B6925402E4;
	Wed, 11 Dec 2024 17:46:40 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 11 Dec 2024 17:46:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733957199;
	 x=1734043599; bh=933xueeaJY3SDcgeC3b3mO6U30b4Yg/8kpa0Lats4AY=; b=
	B3hCmr13YllWf8G2a91DI6ldnpRHmvnvsybShoIGBVUmPfHZMsE8NL+EgCDWK036
	7why0uFCHPTMY67eXotT0eZHjwIajYhvCZN7LHaS7GZwGQE7Z3hEECJHmok/+Y9T
	UvzsM9QJYUDeVV8OeVIMj5DapmuA1PDI7LctGnO8Nc1QWh2iLmnQE4ngITXdQUfb
	Z2n3txwDX+81ExZgmRD5Z5NhWifredlC0848OQS/hgrLrgg0Iu9KhMLgbN07a/H+
	eEcYuU/I3wz1iUHMVKPkaArsKiHfA1XNxVzjros1wa67LGDxd1ZRklOVat2aBoam
	j/wiiS19VP/Zohbwhxx+Xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733957199; x=
	1734043599; bh=933xueeaJY3SDcgeC3b3mO6U30b4Yg/8kpa0Lats4AY=; b=b
	C+0q8omXTcNIji7ISeu7mH3Fp1BkSlNcR3voNGbPAga53Q2Vi70J9UGUXBji+ubh
	kAyX8EMEeDVte7t9Szksd4/YTgDMHMp9N5dxm+nfb79ZrFaqz81gD25Ly1SzqySG
	FNEPg+9U9iEoxLHtsNTewZ1tuwtKIh+x+REfSZfImZfEB5fy43UK+dOFszbzr8Cq
	AoZz5CTJAJl9WO/+GYm5rI+pzP+03P161A6CxvEf+bM2QdyMrzAiZB8PJxOVFgKs
	b15TOXsUqRbzUi6ZAP/6U3RWpgNGpx4uhpzOGYR6z7wP8F+sjV7BMavmk4wzLHvX
	AOtq4+a6PaQRZx9eFl7vg==
X-ME-Sender: <xms:TRZaZ1ORuP-GpjtylmM6yupIE4IKLB14hoHHp0wMaFK4B1-LmuH9rg>
    <xme:TRZaZ3-OoO5cYgupNX94MGWFK4A6szll86Q95vFNmL0QR2FpmLuksO0AkmlA6W9M4
    XbOpJGRBadYrGeH>
X-ME-Received: <xmr:TRZaZ0Qe11Aoqn1ic2AL5-HdorbtEOI_pNi5_xH86W-sIgHWWSp-fO7HgPR9edPLBfDgx-oLdOBiQE-0AJfVOqvSQXGuTyXQbWYRG6smyGpIm3BCgBPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkedugddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeen
    ucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrh
    htsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeevhffgvdeltddugfdt
    gfegleefvdehfeeiveejieefveeiteeggffggfeulefgjeenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthes
    fhgrshhtmhgrihhlrdhfmhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehlihhnuhigqd
    hfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhoshgv
    fhesthhogihitghprghnuggrrdgtohhmpdhrtghpthhtohepmhgrlhhtvgdrshgthhhroh
    gvuggvrhesthhngihiphdruggvpdhrtghpthhtohepfihilhhlhiesihhnfhhrrgguvggr
    ugdrohhrghdprhgtphhtthhopehkvghnthdrohhvvghrshhtrhgvvghtsehlihhnuhigrd
    guvghvpdhrtghpthhtohepjhgvfhhflhgvgihusehlihhnuhigrdgrlhhisggrsggrrdgt
    ohhmpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesmhgvthgrrdgtohhm
X-ME-Proxy: <xmx:TRZaZxtnXNQJ5yEoxlAbU7I15NAIW1-lUlbLdRngWESgdidzRZRAIA>
    <xmx:TRZaZ9fsISN46ohRlFd3Q4XqKDUW-WBym7bVwrtYMQ86_TSuZjEqUg>
    <xmx:TRZaZ92dVbn2Qp4GOGzCqorOueXxzbgHALHV9UBNOstM-jdzSidJBQ>
    <xmx:TRZaZ59WonXlFeYFoLe3EufRFjL4Cr94LK0b5E1P8nheD_6Crtwl2g>
    <xmx:TxZaZ56ElZliiq7OeUrABL0hNuSz3HuVBSWXyMfRy1QVinLMYW8dXa9n>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Dec 2024 17:46:36 -0500 (EST)
Message-ID: <47c356bd-98ef-4c24-826f-cf1f6c6690d0@fastmail.fm>
Date: Wed, 11 Dec 2024 23:46:34 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] fuse: fix direct io folio offset and length
 calculation
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com, malte.schroeder@tnxip.de, willy@infradead.org,
 kent.overstreet@linux.dev, jefflexu@linux.alibaba.com, kernel-team@meta.com
References: <20241211205556.1754646-1-joannelkoong@gmail.com>
 <20241211205556.1754646-2-joannelkoong@gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20241211205556.1754646-2-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/11/24 21:55, Joanne Koong wrote:
> For the direct io case, the pages from userspace may be part of a huge
> folio, even if all folios in the page cache for fuse are small.
> 
> Fix the logic for calculating the offset and length of the folio for
> the direct io case, which currently incorrectly assumes that all folios
> encountered are one page size.
> 
> Fixes: 3b97c3652d91 ("fuse: convert direct io to use folios")
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/file.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 88d0946b5bc9..15b08d6a5739 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1557,18 +1557,22 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
>  
>  		nbytes += ret;
>  
> -		ret += start;
> -		/* Currently, all folios in FUSE are one page */
> -		nfolios = DIV_ROUND_UP(ret, PAGE_SIZE);
> -
> -		ap->descs[ap->num_folios].offset = start;
> -		fuse_folio_descs_length_init(ap->descs, ap->num_folios, nfolios);
> -		for (i = 0; i < nfolios; i++)
> -			ap->folios[i + ap->num_folios] = page_folio(pages[i]);
> -
> -		ap->num_folios += nfolios;
> -		ap->descs[ap->num_folios - 1].length -=
> -			(PAGE_SIZE - ret) & (PAGE_SIZE - 1);
> +		nfolios = DIV_ROUND_UP(ret + start, PAGE_SIZE);
> +
> +		for (i = 0; i < nfolios; i++) {
> +			struct folio *folio = page_folio(pages[i]);
> +			unsigned int offset = start +
> +				(folio_page_idx(folio, pages[i]) << PAGE_SHIFT);
> +			unsigned int len = min_t(unsigned int, ret, PAGE_SIZE - start);
> +
> +			ap->descs[ap->num_folios].offset = offset;
> +			ap->descs[ap->num_folios].length = len;
> +			ap->folios[ap->num_folios] = folio;
> +			start = 0;
> +			ret -= len;
> +			ap->num_folios++;
> +		}
> +
>  		nr_pages += nfolios;
>  	}
>  	kfree(pages);


I had already looked at that yesterday. Had even created a
6.12 branch to remove the rather confusing 
ap->descs[ap->num_pages - 1].length
line and replaced it with

-               ap->descs[ap->num_pages - 1].length -=
-                       (PAGE_SIZE - ret) & (PAGE_SIZE - 1);
+               ap->descs[ap->num_pages - 1].length = offset_in_page(ret);


Anyway, thanks for the quick fix! Looks good to me. 

Reviewed-by: Bernd Schubert <bschubert@ddn.com>


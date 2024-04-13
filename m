Return-Path: <linux-fsdevel+bounces-16860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C048A3C9D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 13:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FE321F2225F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 11:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB8748CD4;
	Sat, 13 Apr 2024 11:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="V6F6Vd0O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DjB9GscA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27237482EB
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Apr 2024 11:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713007717; cv=none; b=E/yfU9fpZL8/yFNffZ0WOQ5uNl9guRf7hhYMKqtbLz79g8q7Z+VxGVlKo3QpHWM4smGQg+hikuedGr0BJaLKO5SZoun9w6T6tcxekrnSTKx+LaPL9tos8kqFWAdLnTHP3jeV3wSzzwqEkpG8Br5IMvNiuIEVRmiKldKVq87FYUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713007717; c=relaxed/simple;
	bh=LQrD7CdWJ50Cj5Yc433b+cHUDqVp0FYs6D+SUpZnK40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QYXzzZTqliR42qM7d6K6xg93pEUo/eAVKPnK2Z+LUxYEbsKVHenJYdUhaFBSE2oA4wx1NMGSPLSL4lxhP811bUDzERn3PuEAfoKsOloMT7a8lDo1+pNLOAIxb8LXBoaIqUdNAnHc5uazwei+OoLCfEGJK2rP4rVGZqttsBkPbEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=V6F6Vd0O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DjB9GscA; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2FEAD138023C;
	Sat, 13 Apr 2024 07:28:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 13 Apr 2024 07:28:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1713007714;
	 x=1713094114; bh=hSBXutcbVpuUAwHICt0W7LpzcSQ7Ns50APhC5PO96UE=; b=
	V6F6Vd0OWvHt0kXYZP9znIwnE4j9QWCvZEFQzGoLx7V+/OoH7kp/tuVUhVgGIZ8t
	AiV1AV31uOncJ1Dd2kp9/5oY6zSpA8s/occxe6FCTJ/AvVdLEH6uvPjH5Hn3HYIH
	z712eunrm2UXl1thafV+Va4OcWDEcwIAIAZiadkBninSmMgh7iLpsK3ZcftReKyj
	XJ9MQUzZwqwe34+j6S8FywHm6G0SrBolQKEbD6BCy0+sGn76GtdwMxoDja7SLu+L
	VhygFDaN+b/imst7QBT0yLARqYRv7qDOqoGsQRLu6VqpYsvYPCWaZOxgMtxeCCDC
	grDGaFyNLdfh4jubLdBjMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1713007714; x=
	1713094114; bh=hSBXutcbVpuUAwHICt0W7LpzcSQ7Ns50APhC5PO96UE=; b=D
	jB9GscAEWSS7D+N3/rRoDOtsplQ1k1c06upXLJg1ZWQ9vaYXmqBSX/erYFihDvxg
	alnbqqP3NHq2gC7xwlZiAQs0Rkc4XSpIPXMJtQqmVCht3mWsfKnViwZcurY7ROml
	k18Orx2HLEENnfAaly5JaUVdRbBJ38U03CbD0uKGEvf7T2MzGn7L1zxzkl0gs2f+
	SksQ/2yWroF5qV5vXiaR8ITcktHW60dxJvNsrjyHM16qaaeRgPRBZ8uJ9+BBxkq2
	hEeCj2xoIwBXHIyq+z+K8AYr0I7HBUq7y8sQOQI19iDfK3LnYkEQzN8NvKWdmJKx
	3oMB1xl9GlcD4Z7TUTQcg==
X-ME-Sender: <xms:YWwaZkUmbo6WMCwD8VSZzWqHvOaJdDnPbh1owpxgMPhYEsE6PPOu-Q>
    <xme:YWwaZoll2gCEZZMlxXoBPTnrNbVbeThoDe2JtKAVD8I4uLOwsYpfbbnaAx6jWQyj2
    vpYD7HYIeqaGAAq>
X-ME-Received: <xmr:YWwaZoap4vP7sMQ3DDGpPfhkvmovk_HYtEqwU1_FdNBaxjioTWqcgB9kt_U9rWWv76y7dbKGINh0O59YUU7022YU-7xeZxldwwnbYe5ObNjfFnd14O6k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeiiedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhephedvveegheehjeehfeejtdevffduffevteei
    heelgefhhfdtheeljeevtefhtdfgnecuffhomhgrihhnpeifrhhithgvrdhinhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhs
    tghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:YWwaZjX-OzxZTJ19CgyKCQxTUFikyrIU6TxSLqjJc3KJLS0Ab9udLg>
    <xmx:YWwaZumeDhc5vadiT96EiufVqHtFSanu2l1yH_CjSizQ5ivZwyNYPQ>
    <xmx:YWwaZoebsQH2ozrJYnmFhZc9nc2GqmprPTOAxkWPpV_ftlITibYGEw>
    <xmx:YWwaZgEUbC_8WW0X3knnkcMcacP-e7zMo9aduiozhizMuc7-KmZ3pQ>
    <xmx:YmwaZghLqcByFsAFhF3z7GP8JokS6sxQ2cbzpRLKTC4FiVSet3_kQE9Q>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Apr 2024 07:28:33 -0400 (EDT)
Message-ID: <13cbb507-45b5-48fb-a696-cb43ad14a5b2@fastmail.fm>
Date: Sat, 13 Apr 2024 13:28:31 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] fuse: Convert fuse_writepage_locked to take a folio
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org
References: <20240228182940.1404651-1-willy@infradead.org>
 <20240228182940.1404651-2-willy@infradead.org>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20240228182940.1404651-2-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/28/24 19:29, Matthew Wilcox (Oracle) wrote:
> The one remaining caller of fuse_writepage_locked() already has a folio,
> so convert this function entirely.  Saves a few calls to compound_head()
> but no attempt is made to support large folios in this patch.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/fuse/file.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 340ccaafb3f7..f173cbce1d31 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -2040,26 +2040,26 @@ static void fuse_writepage_add_to_bucket(struct fuse_conn *fc,
>  	rcu_read_unlock();
>  }
>  
> -static int fuse_writepage_locked(struct page *page)
> +static int fuse_writepage_locked(struct folio *folio)
>  {
> -	struct address_space *mapping = page->mapping;
> +	struct address_space *mapping = folio->mapping;
>  	struct inode *inode = mapping->host;
>  	struct fuse_conn *fc = get_fuse_conn(inode);
>  	struct fuse_inode *fi = get_fuse_inode(inode);
>  	struct fuse_writepage_args *wpa;
>  	struct fuse_args_pages *ap;
> -	struct page *tmp_page;
> +	struct folio *tmp_folio;
>  	int error = -ENOMEM;
>  
> -	set_page_writeback(page);
> +	folio_start_writeback(folio);
>  
>  	wpa = fuse_writepage_args_alloc();
>  	if (!wpa)
>  		goto err;
>  	ap = &wpa->ia.ap;
>  
> -	tmp_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
> -	if (!tmp_page)
> +	tmp_folio = folio_alloc(GFP_NOFS | __GFP_HIGHMEM, 0);
> +	if (!tmp_folio)
>  		goto err_free;
>  
>  	error = -EIO;
> @@ -2068,21 +2068,21 @@ static int fuse_writepage_locked(struct page *page)
>  		goto err_nofile;
>  
>  	fuse_writepage_add_to_bucket(fc, wpa);
> -	fuse_write_args_fill(&wpa->ia, wpa->ia.ff, page_offset(page), 0);
> +	fuse_write_args_fill(&wpa->ia, wpa->ia.ff, folio_pos(folio), 0);
>  
> -	copy_highpage(tmp_page, page);
> +	folio_copy(tmp_folio, folio);
>  	wpa->ia.write.in.write_flags |= FUSE_WRITE_CACHE;
>  	wpa->next = NULL;
>  	ap->args.in_pages = true;
>  	ap->num_pages = 1;
> -	ap->pages[0] = tmp_page;
> +	ap->pages[0] = &tmp_folio->page;

Hi Matthew,

sorry for late review. The part I'm totally confused with (already
without this patch), why is this handling a single page only and not the
entire folio? Is it guaranteed that the folio has a single page only?



Thanks,
Bernd


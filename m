Return-Path: <linux-fsdevel+bounces-48015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 771E4AA891C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 21:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C0491890273
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 19:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC8725760;
	Sun,  4 May 2025 19:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="NHEF4apx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t0/Ck9c2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB716F30C
	for <linux-fsdevel@vger.kernel.org>; Sun,  4 May 2025 19:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746386107; cv=none; b=BJVRh4w90+Z8QkWXXvIZePw2QI4aC63EC9iOKcUzdRAcH4wPQuzYnr7FYcp5Vv2tkODnTH35OuNPzTAJGHdMm4hJ1hkcEptJYu0A/2AC63BEZB1Zcc3llM8txKVYQ03qUE2f2S8fB+Aw4KaeIdZG2J1Sr030aiIm5en3+4WGwyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746386107; c=relaxed/simple;
	bh=jIk9ZPBALwecQqJd49UIFMtxHCi3vnw5nZSZYq0bTTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uK3aQ3ShDxxe9y5FJleVf7KT3EPR3hk1oyy8hfWvk5WEDaWhSBShCpm3g6lOqBpO1c7UE7LBF5YPtb9RDQgPMuCaLjtEqiXdZ+5DU3V8ZNcaRhbif7+ga6qqbNkfImFMbVHJpxJP/skQ6wJtF3MOVbNg7czR0SvHNiKncuYiTPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=NHEF4apx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t0/Ck9c2; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B4E27114018A;
	Sun,  4 May 2025 15:15:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 04 May 2025 15:15:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746386103;
	 x=1746472503; bh=PgwoSh59qsf74Q8sIM8xHvUGgngtA9+FpomgeB+/JYU=; b=
	NHEF4apxtSj089QpdehycvgnbKyYQwcSEUnkiz9BOZSkMsW4VVxp2tdZl6ULqRCx
	9VnGZ5JaV1gXIwWKIStINh8MLudK/ubP7EpMK8Vv+fso0Il+EJVunyaQ1Jvj31Kh
	92V2XMEYjTATOW6PYZOkGPJM4jTOTNIuxNoZEt2b42ADKNlNkT95Ep0FPmdhXKgv
	br/izNRE/XTxAXfOSdmL1zILozltrvZBfhjL3CCNVuDLSlgeNQrEy7z98kUIZ5X0
	HRcduBj+bnaXtn4qGXDZaycfDM972uHsjCoXjMgPosZl8wFMygnFBBjWWKm/21Ao
	e1XkynHHwXS8QStqRWGAzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746386103; x=
	1746472503; bh=PgwoSh59qsf74Q8sIM8xHvUGgngtA9+FpomgeB+/JYU=; b=t
	0/Ck9c2FHnIBUuQfVbuNHhBPHMVkfVwCUlkGrrthOZa+qhnu4LSZeMibGv7JC6Lx
	1PlmLduSj4rlmUqXqBrJ8mbnlL2PWW4V7B9jbdyiYGO2k6SkdiDX3YH7W1CsHeDY
	i5ZsKATdQzSDkoF05zRA2jTfSdglIscx9x0S5Cg0sfbPOAnYzEKnJmsRKXyqHVzB
	8Aed0YOHwiYPMHvG8h/qtR5iOjyS5BNXeBa/ZpjyRDpzZpGtzdgx8wQeFaNr0CAx
	3aPZUIToWH++lJknORQ1mDXw7DjuUjZMOcdrckfeBuw0RvLaS7E5dCwpgbnconut
	5lmdvgYpo1Fue4gfDgj+A==
X-ME-Sender: <xms:t7wXaB2n8ZNgXAqntpbFZSUd7rnEvvpHkgmg3qEZ2U4r1LZwYIXTSw>
    <xme:t7wXaIFRupbcW1VyZ6RYUCio9_SbcLKGyrSIJQ8HbZXJoSNVSUUpMuzDFqskxR-I1
    FJN7IKTjtEFUID5>
X-ME-Received: <xmr:t7wXaB7y2oovgRujPu2WDoYEnjw34rNcf9qEd6qH2WMLIFRZt19TSpumOfmqMRklbejP_BaMGlLb0BKgiaoye8D0v6BIUaMgYCg_8WDmZwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeeltddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddt
    vdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuh
    gsvghrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledt
    udfgtdfggeelfedvheefieevjeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggv
    rhhtsehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdp
    rhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheplhhinh
    hugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehj
    lhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjvghffhhlvgiguheslh
    hinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopehjohhsvghfsehtohigihgt
    phgrnhgurgdrtghomhdprhgtphhtthhopeifihhllhihsehinhhfrhgruggvrggurdhorh
    hgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesmhgvthgrrdgtohhm
X-ME-Proxy: <xmx:t7wXaO12S1FkOFFTncWoxa0PacWR0nS59wlc-e8LPV7AvLyttwYwjw>
    <xmx:t7wXaEFVus6z1S4n2ZOcl2fEzvAGhgkBDLTUIfxBFbUNCj5_cD_mmw>
    <xmx:t7wXaP9OweRJXaA-d1CeN19x7KLLOucQTM_2jtb80XZ6dOTtlc1U8A>
    <xmx:t7wXaBlO-XqABSF7V5oZb4QmPJBJuRzqPppsl0y3wKXBH3lZWFhwiQ>
    <xmx:t7wXaKrtTWJY_mkbyH8ZxtsEMOGojZ1Cf9BebVepOt91IWCjZsvUBVPk>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 May 2025 15:15:02 -0400 (EDT)
Message-ID: <98d5cfcb-3617-4118-a68d-d9d25e1e9aa0@fastmail.fm>
Date: Sun, 4 May 2025 21:15:00 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/11] fuse: optimize direct io large folios processing
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, jlayton@kernel.org,
 jefflexu@linux.alibaba.com, josef@toxicpanda.com, willy@infradead.org,
 kernel-team@meta.com
References: <20250426000828.3216220-1-joannelkoong@gmail.com>
 <20250426000828.3216220-11-joannelkoong@gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250426000828.3216220-11-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/26/25 02:08, Joanne Koong wrote:
> Optimize processing folios larger than one page size for the direct io
> case. If contiguous pages are part of the same folio, collate the
> processing instead of processing each page in the folio separately.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: Bernd Schubert <bschubert@ddn.com>

> ---
>  fs/fuse/file.c | 55 +++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 41 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 9a31f2a516b9..61eaec1c993b 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1490,7 +1490,8 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
>  	}
>  
>  	while (nbytes < *nbytesp && nr_pages < max_pages) {
> -		unsigned nfolios, i;
> +		struct folio *prev_folio = NULL;
> +		unsigned npages, i;
>  		size_t start;
>  
>  		ret = iov_iter_extract_pages(ii, &pages,
> @@ -1502,23 +1503,49 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
>  
>  		nbytes += ret;
>  
> -		nfolios = DIV_ROUND_UP(ret + start, PAGE_SIZE);
> +		npages = DIV_ROUND_UP(ret + start, PAGE_SIZE);
>  
> -		for (i = 0; i < nfolios; i++) {
> -			struct folio *folio = page_folio(pages[i]);
> -			unsigned int offset = start +
> -				(folio_page_idx(folio, pages[i]) << PAGE_SHIFT);
> -			unsigned int len = min_t(unsigned int, ret, PAGE_SIZE - start);
> +		/*
> +		 * We must check each extracted page. We can't assume every page
> +		 * in a large folio is used. For example, userspace may mmap() a
> +		 * file PROT_WRITE, MAP_PRIVATE, and then store to the middle of
> +		 * a large folio, in which case the extracted pages could be
> +		 *
> +		 * folio A page 0
> +		 * folio A page 1
> +		 * folio B page 0
> +		 * folio A page 3
> +		 *
> +		 * where folio A belongs to the file and folio B is an anonymous
> +		 * COW page.
> +		 */
> +		for (i = 0; i < npages && ret; i++) {
> +			struct folio *folio;
> +			unsigned int offset;
> +			unsigned int len;
> +
> +			WARN_ON(!pages[i]);
> +			folio = page_folio(pages[i]);
> +
> +			len = min_t(unsigned int, ret, PAGE_SIZE - start);
> +
> +			if (folio == prev_folio && pages[i] != pages[i - 1]) {
> +				WARN_ON(ap->folios[ap->num_folios - 1] != folio);
> +				ap->descs[ap->num_folios - 1].length += len;
> +				WARN_ON(ap->descs[ap->num_folios - 1].length > folio_size(folio));
> +			} else {
> +				offset = start + (folio_page_idx(folio, pages[i]) << PAGE_SHIFT);
> +				ap->descs[ap->num_folios].offset = offset;
> +				ap->descs[ap->num_folios].length = len;
> +				ap->folios[ap->num_folios] = folio;
> +				start = 0;
> +				ap->num_folios++;
> +				prev_folio = folio;
> +			}
>  
> -			ap->descs[ap->num_folios].offset = offset;
> -			ap->descs[ap->num_folios].length = len;
> -			ap->folios[ap->num_folios] = folio;
> -			start = 0;
>  			ret -= len;
> -			ap->num_folios++;
>  		}
> -
> -		nr_pages += nfolios;
> +		nr_pages += npages;
>  	}
>  	kfree(pages);
>  



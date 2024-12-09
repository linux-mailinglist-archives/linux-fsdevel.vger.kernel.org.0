Return-Path: <linux-fsdevel+bounces-36845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8A89E9C9F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 18:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29E4C281B83
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 17:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E8B14BF92;
	Mon,  9 Dec 2024 17:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="rYleOkj8";
	dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="nMwDLmF1";
	dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="hUaKNxnO";
	dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="ovB5jcug"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tnxip.de (mail.tnxip.de [49.12.77.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7DD288CC
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 17:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.77.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733764077; cv=none; b=kxm6l5R3BTp3X0aAg6V+Cxv+uXPcHuwmYWiTJRlUvRXS2f981AeUd397lI3SQDsUwuApvEuneRZhFScH0lHhjAavFUkwXrDu+YzOHZwi816kXE0ZwczihYYOq2V3Ipb7zomUo7L9TUbYOezCupsRF6aROLsktBU+h5XwkaMbk0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733764077; c=relaxed/simple;
	bh=NsAqgVZzvLpNkeyFCLY10pz5/VgllcfxTZSPP66t5fY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d+9RYQ4qAI6Bh8qMvInmg6OXHFwEqg6eoSxqzVmV977rzkQzIyUp8NZFeqCaIwGbeRQJW4AWmZOixm6DU60f4y6RHB/l62RibBvJBj1/+HXIqmiqBW2q/USMZnvyzUh2udISmbvlPnVcp56IsbjGn8xdKJqvb2DQ5khDuB791cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tnxip.de; spf=pass smtp.mailfrom=tnxip.de; dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=rYleOkj8; dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=nMwDLmF1; dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=hUaKNxnO; dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=ovB5jcug; arc=none smtp.client-ip=49.12.77.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tnxip.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tnxip.de
Received: from gw.tnxip.de (unknown [IPv6:fdc7:1cc3:ec03:1:3730:8d9c:b2ab:6810])
	by mail.tnxip.de (Postfix) with ESMTPS id D7A17208CC;
	Mon,  9 Dec 2024 18:07:49 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tnxip.de;
	s=mail-vps-ed; t=1733764069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dDXCkGUbcqZ4IeZ3qD4Pl2xcfvMpVff+VnLUYxwiw/Q=;
	b=rYleOkj8MJ6XRxdGPr5ocawU3p5SLlfkBlNByHbtz0gAjr0minvH6mJPr4SdO/MXvsiEcT
	wU56Slq1jE/JDLAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tnxip.de; s=mail-vps;
	t=1733764069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dDXCkGUbcqZ4IeZ3qD4Pl2xcfvMpVff+VnLUYxwiw/Q=;
	b=nMwDLmF1RMgawEupi0iW1yZFlz62wTgSx7UIbyavgWlkDySvsiisxX3CajxGMDM+PsCpeb
	mt0DQnexl4iifAJXOgArvHZ/M+orvbkJLDqvEELQYYMwwf2k5crjndHBrypspYHDozc4ZE
	ag4da1bFEVhwr5UDFRlkFqp1uhTptwc=
Received: from [IPV6:2a04:4540:8c0e:b000:7a6a:1cd6:6bc8:cdd] (highlander.local [IPv6:2a04:4540:8c0e:b000:7a6a:1cd6:6bc8:cdd])
	by gw.tnxip.de (Postfix) with ESMTPSA id 94B5B400490D7;
	Mon, 09 Dec 2024 18:07:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tnxip.de; s=mail-gw;
	t=1733764069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dDXCkGUbcqZ4IeZ3qD4Pl2xcfvMpVff+VnLUYxwiw/Q=;
	b=hUaKNxnO/0oOY3KUE6OjDzw3N8b31jLtgVW6BDHf5YJFKFp3CagnIasXpOgNabzhWkAeI+
	gMS74VMPeFvSIXCIIMmLn9voTq8/IpL1e/Kd7sfIMxTXmKhMrKiaj0oOoVKp78foSzYkqm
	C5WQoGGbGavmMeSjW5OS1D7FsutzKlU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tnxip.de;
	s=mail-gw-ed; t=1733764069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dDXCkGUbcqZ4IeZ3qD4Pl2xcfvMpVff+VnLUYxwiw/Q=;
	b=ovB5jcugFZ9QtuUAJr1zid8SZFwSQkdlWcLfyVBc6khsfotXhjlI7zA3Zyp1SnfciiDp3V
	CAdRMfFCktPE+CBA==
Message-ID: <4707aea6-addb-4dc3-96f7-691d2e94ab25@tnxip.de>
Date: Mon, 9 Dec 2024 18:07:49 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: silent data corruption in fuse in rc1
To: Josef Bacik <josef@toxicpanda.com>, Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 Miklos Szeredi <mszeredi@redhat.com>, Joanne Koong <joannelkoong@gmail.com>,
 linux-fsdevel@vger.kernel.org
References: <p3iss6hssbvtdutnwmuddvdadubrhfkdoosgmbewvo674f7f3y@cwnwffjqltzw>
 <cb2ceebc-529e-4ed1-89fa-208c263f24fd@tnxip.de>
 <Z1T09X8l3H5Wnxbv@casper.infradead.org>
 <68a165ea-e58a-40ef-923b-43dfd85ccd68@tnxip.de>
 <2143b747-f4af-4f61-9c3e-a950ab9020cf@tnxip.de>
 <20241209144948.GE2840216@perftesting>
 <Z1cMjlWfehN6ssRb@casper.infradead.org>
 <20241209154850.GA2843669@perftesting>
Content-Language: en-US, de-DE
From: =?UTF-8?Q?Malte_Schr=C3=B6der?= <malte.schroeder@tnxip.de>
In-Reply-To: <20241209154850.GA2843669@perftesting>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09/12/2024 16:48, Josef Bacik wrote:
> On Mon, Dec 09, 2024 at 03:28:14PM +0000, Matthew Wilcox wrote:
>> On Mon, Dec 09, 2024 at 09:49:48AM -0500, Josef Bacik wrote:
>>>> Ha! This time I bisected from f03b296e8b51 to d1dfb5f52ffc. I ended up
>>>> with 3b97c3652d91 as the culprit.
>>> Willy, I've looked at this code and it does indeed look like a 1:1 conversion,
>>> EXCEPT I'm fuzzy about how how this works with large folios.  Previously, if we
>>> got a hugepage in, we'd get each individual struct page back for the whole range
>>> of the hugepage, so if for example we had a 2M hugepage, we'd fill in the
>>> ->offset for each "middle" struct page as 0, since obviously we're consuming
>>> PAGE_SIZE chunks at a time.
>>>
>>> But now we're doing this
>>>
>>> 	for (i = 0; i < nfolios; i++)
>>> 		ap->folios[i + ap->num_folios] = page_folio(pages[i]);
>>>
>>> So if userspace handed us a 2M hugepage, page_folio() on each of the
>>> intermediary struct page's would return the same folio, correct?  So we'd end up
>>> with the wrong offsets for our fuse request, because they should be based from
>>> the start of the folio, correct?
>> I think you're 100% right.  We could put in some nice asserts to check
>> this is what's happening, but it does seem like a rather incautious
>> conversion.  Yes, all folios _in the page cache_ for fuse are small, but
>> that's not guaranteed to be the case for folios found in userspace for
>> directio.  At least the comment is wrong, and I'd suggest the code is too.
> Ok cool, Malte can you try the attached only compile tested patch and see if the
> problem goes away?  Thanks,
>
> Josef
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 88d0946b5bc9..c4b93ead99a5 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1562,9 +1562,19 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
>  		nfolios = DIV_ROUND_UP(ret, PAGE_SIZE);
>  
>  		ap->descs[ap->num_folios].offset = start;
> -		fuse_folio_descs_length_init(ap->descs, ap->num_folios, nfolios);
> -		for (i = 0; i < nfolios; i++)
> -			ap->folios[i + ap->num_folios] = page_folio(pages[i]);
> +		for (i = 0; i < nfolios; i++) {
> +			struct folio *folio = page_folio(pages[i]);
> +			unsigned int offset = start +
> +				(folio_page_idx(folio, pages[i]) << PAGE_SHIFT);
> +			unsigned int len = min_t(unsigned int, ret, folio_size(folio) - offset);
> +
> +			len = min_t(unsigned int, len, PAGE_SIZE);
> +
> +			ap->descs[ap->num_folios + i].offset = offset;
> +			ap->descs[ap->num_folios + i].length = len;
> +			ap->folios[i + ap->num_folios] = folio;
> +			start = 0;
> +		}
>  
>  		ap->num_folios += nfolios;
>  		ap->descs[ap->num_folios - 1].length -=

The problem persists with this patch.


/Malte



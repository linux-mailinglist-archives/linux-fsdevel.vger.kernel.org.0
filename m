Return-Path: <linux-fsdevel+bounces-53923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28260AF8FEA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 12:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C2C55A1CFC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 10:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0182EACEE;
	Fri,  4 Jul 2025 10:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rjue7v6E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08662EA72F
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 10:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751624649; cv=none; b=fy25Qup0lGLvRdt2WD5BFJ/8tq5xM6i5H028epAzBh8bmcl39WOZMRex1O9QYA9dKfXRrB0splNvKLpEKrOqQxEhheZ3DnvwEeY96+scxa9Xq4lXLSzXuzI8q/6e+xJzUjj1KA/FayPZAul10s6vqIVLMOKUASNRvSoW8w9VHhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751624649; c=relaxed/simple;
	bh=ZJwUzCRTgCIwdT0O3a29QA8yJr7c2jadRe+FBqGr2yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cTEKGhLuYWn9jgS666mZjcdUbuL5de06eA3Tqb/JS4btoItDE9l9wG1Mz9kD004DUjs0QIeshvY2+S/yDVKwcQII080d6MpqEkHnlsdFqMYlgy4XvbpDhdWJaURnzWnNiu9KeggPoKiiWbgZERlL+aPDtEWrDzLWledWjNoo2EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rjue7v6E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751624646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7AHt5Z64vpLLNCpfL1vnLoZ56sFLeXdpOw9WEu1NFok=;
	b=Rjue7v6EMIqI1j0jkXtTS0V8oNiH+WUiP+u5CeMvCdPdfxw8Chm3xCaObn0u3OcgZXhPAc
	8BfHkGPBz3JtItAPaC5ZvFjngQvCXoAAYcSznDeWMycWrg6ItYJm44/zn6ZeRi+sv5YQcY
	7KDS+iVE2hsGAkUvhispJlZPKhm3lcM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-MbIdq8TLP9-mVOH4H4Bjww-1; Fri, 04 Jul 2025 06:24:05 -0400
X-MC-Unique: MbIdq8TLP9-mVOH4H4Bjww-1
X-Mimecast-MFC-AGG-ID: MbIdq8TLP9-mVOH4H4Bjww_1751624644
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-450d290d542so4565425e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Jul 2025 03:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751624644; x=1752229444;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7AHt5Z64vpLLNCpfL1vnLoZ56sFLeXdpOw9WEu1NFok=;
        b=RuANISO3Cb5yMmFf9mG5/e0FLMhTTdYW4yvj5zdtTq6ZiK2kvlt6IIraYqHExfBjIU
         gGv1Ff7CxjHyuEvPF6e1BkIB+wJjntZP0vQInp00INUaNaS+DtKYmUC93yzgKTuGaCGU
         iIyadescsDurPN+PB+S3tYT5OeOPXp8xmuoH1ATuQks8gq6FF62MroF27ueqm3njhb0Y
         v8ParE1kmnYG2Zv6dYJ3cwoMpkKL5VSofBRIHCqpm/Dw26iFHKUgM+5R9qKKySkBXIR8
         qeqHuY3/hqx5OxqXEfmFGlCX4LGeZWGrD1kVNTa10j51jbI9umfb/985jwAkL8KMpeqj
         4qhg==
X-Gm-Message-State: AOJu0YxH5WxARYh9dyBk5ymVRUuP8ziyydIqxB8AJYBIa4/RNAQk5Qc7
	r23zhy46XLSEi+7ELWVUNc5PpBf/4WubgLJ/V5qPbF8L/UuBSbhXMUV6OsF/WoU0XN1vdturJra
	sg9RDkAs3T0+85U2YRxSZmsv42WkAQV2tptO0vCmTTYyd1g91EsoIvkAiD/km6weQ9XPBZDUrvJ
	4=
X-Gm-Gg: ASbGncuZFGzxGlAsyiwGe2Fo/AVa4Zv61wc492yEiVTI7JMgqsaet7245nVpsMAmA8r
	8eW8+sDUkvG6TobVAd/5bchYK2u2VBbsQg0R2aCJntc0p2ALKH8VT0GFUuWtgqXkE8ZOx1uJgzr
	BRdrJqHF09o09btZ3lqZXxrEJm+iR0SBkgsqQaQXUfSsRP6VEoYZErJwVeSta5O6Rtb/YgmBG7H
	mPpupKzCbAOcelycOP7wQRnLG2GeEgO5VKx1r5i2RWMW55NkcHPDvWEpLukzd3gYk053d4Nb67h
	S1G1s5kqNl23p6lYAdObCaViJQlBz5LDXVnTmZRoCH0840GVL/l3kbtgmpl+KJNawfrevwufztb
	V85KHfsHTKpe+i/aJ9E9rEIMAP7ZlncLNSsnxw6UWxiaQBfk=
X-Received: by 2002:a05:6000:2285:b0:3aa:c95b:d1d9 with SMTP id ffacd0b85a97d-3b4964eb200mr1425057f8f.6.1751624643790;
        Fri, 04 Jul 2025 03:24:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4A0/1h/B1ilYGbTmBY8ZH5/8hdcvdonFBLczJBmXXW5tX2H5RoW9cZXDpBaGbEcNzqAXTog==
X-Received: by 2002:a05:6000:2285:b0:3aa:c95b:d1d9 with SMTP id ffacd0b85a97d-3b4964eb200mr1425028f8f.6.1751624643334;
        Fri, 04 Jul 2025 03:24:03 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2c:5500:988:23f9:faa0:7232? (p200300d82f2c5500098823f9faa07232.dip0.t-ipconnect.de. [2003:d8:2f2c:5500:988:23f9:faa0:7232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030ba29sm2100881f8f.2.2025.07.04.03.24.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 03:24:02 -0700 (PDT)
Message-ID: <6d9c08dd-c1d0-48bd-aacb-b4300f87d525@redhat.com>
Date: Fri, 4 Jul 2025 12:24:01 +0200
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
 jefflexu@linux.alibaba.com, josef@toxicpanda.com,
 bernd.schubert@fastmail.fm, willy@infradead.org, kernel-team@meta.com
References: <20250426000828.3216220-1-joannelkoong@gmail.com>
 <20250426000828.3216220-11-joannelkoong@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250426000828.3216220-11-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.04.25 02:08, Joanne Koong wrote:
> Optimize processing folios larger than one page size for the direct io
> case. If contiguous pages are part of the same folio, collate the
> processing instead of processing each page in the folio separately.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> ---
>   fs/fuse/file.c | 55 +++++++++++++++++++++++++++++++++++++-------------
>   1 file changed, 41 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 9a31f2a516b9..61eaec1c993b 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1490,7 +1490,8 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
>   	}
>   
>   	while (nbytes < *nbytesp && nr_pages < max_pages) {
> -		unsigned nfolios, i;
> +		struct folio *prev_folio = NULL;
> +		unsigned npages, i;
>   		size_t start;
>   
>   		ret = iov_iter_extract_pages(ii, &pages,
> @@ -1502,23 +1503,49 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
>   
>   		nbytes += ret;
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

I don't really understand the "pages[i] != pages[i - 1]" part.

Why would you have to equal page pointers in there?


Something that might be simpler to understand and implement would be using

	num_pages_contiguous()

from

	https://lore.kernel.org/all/20250704062602.33500-2-lizhe.67@bytedance.com/T/#u

and then just making sure that we don't exceed the current folio, if we 
ever get contiguous pages that cross a folio.


-- 
Cheers,

David / dhildenb



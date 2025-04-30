Return-Path: <linux-fsdevel+bounces-47764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7276AA5679
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 23:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A13679C6B9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 21:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FD92C1080;
	Wed, 30 Apr 2025 21:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XPENOww+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCD025E454
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 21:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746047303; cv=none; b=szx6XkPId9mfsocUGqSuAEPdPwpH2cCIWtcXOcc5fmCb1gPbs1Y+Sko1FuUbO7fh9dUX38LVZs5Rio/mGshDHjWamk8bRNDqs5eTSgSYh4D567h1F6NcWYLpfpafr61zpr2FjZGWn63T5sxWprSLUxtv892lrU7Wgyjj5i35FOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746047303; c=relaxed/simple;
	bh=1WlT2SrSfy0Td2d5Rk5U/Sxd4MjTMw+198rYgCZ7nok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ELN1gtIaXGou7+1xzdF5jgNwoHSl8KLsnbUuxw+yRTvaK9ssNpNAw4SNY67KNpxWl53JZg9vh0eDQieRUXnGWZ3mX8fPpKelYH5YLaM1NYJWpzWzRiJwuPQrPDGKQIGTKkMqWQeTTsmQjI+mcvv5VoguGW21/nFSekvH9JaL2MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XPENOww+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746047296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=01jBPxnqk92t1rPGznj6ym7/qLqG6tY/jU5pL3ZoH4k=;
	b=XPENOww+hTX+N4/wV/vMoOzJgiaRulnIcxUJauskB0pz5ljv3hztSelULRguk23vG9ruHp
	YMJZpsCgWWAjtS9GdTmI/Jv0FZxtgGF4zIOepAauIXM3l2LNEBBJsw0RYmbDwqd4zdoh86
	QhFUo35YPi4LG7+HjDTsDohF5MgbGh8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-gIQSrGKgMqWZA7AxE_LCIQ-1; Wed, 30 Apr 2025 17:08:13 -0400
X-MC-Unique: gIQSrGKgMqWZA7AxE_LCIQ-1
X-Mimecast-MFC-AGG-ID: gIQSrGKgMqWZA7AxE_LCIQ_1746047292
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39ee4b91d1cso607126f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 14:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746047292; x=1746652092;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=01jBPxnqk92t1rPGznj6ym7/qLqG6tY/jU5pL3ZoH4k=;
        b=uc2DhTEKc8p4+Dr0+OJBEQ2Gqdci84DOaIZHUJ0ZLpD5egp3LPz5FdD1wq03Rmee+p
         3jhp11V0J7gWAWWBehYdAeC7K9vOmYC2zxBFdDvnMR6r91aA+MQxp7mevJLnAA7HecUS
         ojzqkZu4AVWquQLvSXnKqea0AgxjYXkHPwhRZzmd6QAOiDR7Qtxwwrx5drxL95YbCw/P
         BWOJJh4FM4d+NXqUHUlt2XSuWD3z2rh2TN/E5LqzRwlK6GFAicZF3FY9vOjovZnlxPoV
         XBsnBIeJo35hhPE7rrUWWIvHSUB0la/U2/TKo2fHwYrdBH0KdwnS5KsaPKNcN15xT2tB
         tlOA==
X-Forwarded-Encrypted: i=1; AJvYcCXSHR91n2iSKZC6y/D6juTSoCTD9tfOfLhzpsbnyYeSr459+fM4+GO+HZ4GQWd1RL1vroOyab6joNrMSaQM@vger.kernel.org
X-Gm-Message-State: AOJu0YyOaDrh5eW96YiLFCtNV5b0rFnnDrUGhU4u5+cYc7RuFOpqsKk3
	xV+5VFv0kbus5zXK10nCxXEfputkLJxiy6/q3LBKk2JbidbcBoLVCcHhc0g4GUjjqeCZZvi7Kbh
	kTJSi0/RwVt1n8O4Aj6rpS0biv1SAX3Drof+iV/ZzcydYOAppu08gL9IiVtDq5Do=
X-Gm-Gg: ASbGncuJzsMd6Hm6a23ssuzm78a42i01aEBvs7VSU2aHpLPCc5febFoHE1SgC6WZLix
	v+11pPPUJnHZh8IeXcNKva9bK/g14z0LsCcQfzTv8kYJU0iKgNJkbvsaWOmjy9iSaF85GPHa2Gt
	4Q6UrwIF/tJy6eanMbJoAeUvRvbguSy0hMIPxo9ReJhqx7W59Xmif3Zdt8LzFw6eo6chpb2dswc
	YbVPQt8V/d+/mX7JMVmTklagZqOiGN0kZYmQndJ5Q2OjVpIVr19i40JCj09RXhG/8WF+9mjEy0P
	9esW7lR8seUEgHP2RNZHrLL6ksq57VCs68W2XIVQdnCtot7yydhBI4UvhYZhhJPwSOOkXC89bVt
	CxXSkL35d0gLQjezBEp/pOzrW3JmsaP2QblaCHh8=
X-Received: by 2002:a5d:684a:0:b0:39f:d13:32a with SMTP id ffacd0b85a97d-3a092d028ccmr748154f8f.29.1746047292485;
        Wed, 30 Apr 2025 14:08:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHn7bC7vT1tiu/n8jrljv5sjGW6uSdNlOCmXc7ddSIDa2k3vXUMwpJkn2Ldnsb3A0+SQjpNkA==
X-Received: by 2002:a5d:684a:0:b0:39f:d13:32a with SMTP id ffacd0b85a97d-3a092d028ccmr748144f8f.29.1746047292033;
        Wed, 30 Apr 2025 14:08:12 -0700 (PDT)
Received: from ?IPV6:2003:cb:c745:a500:7f54:d66b:cf40:8ee9? (p200300cbc745a5007f54d66bcf408ee9.dip0.t-ipconnect.de. [2003:cb:c745:a500:7f54:d66b:cf40:8ee9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073ca543bsm18124715f8f.34.2025.04.30.14.08.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 14:08:11 -0700 (PDT)
Message-ID: <5e6cd2c8-b0d1-436a-96e7-b8cb7f6d75cc@redhat.com>
Date: Wed, 30 Apr 2025 23:08:10 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] fuse: drop usage of folio_index
To: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
 Chris Li <chrisl@kernel.org>, Yosry Ahmed <yosryahmed@google.com>,
 "Huang, Ying" <ying.huang@linux.alibaba.com>, Nhat Pham <nphamcs@gmail.com>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org,
 Miklos Szeredi <miklos@szeredi.hu>, Joanne Koong <joannelkoong@gmail.com>,
 Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org
References: <20250430181052.55698-1-ryncsn@gmail.com>
 <20250430181052.55698-2-ryncsn@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250430181052.55698-2-ryncsn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.04.25 20:10, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> folio_index is only needed for mixed usage of page cache and swap
> cache, for pure page cache usage, the caller can just use
> folio->index instead.
> 
> It can't be a swap cache folio here.  Swap mapping may only call into fs
> through `swap_rw` but fuse does not use that method for SWAP.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Joanne Koong <joannelkoong@gmail.com>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: linux-fsdevel@vger.kernel.org
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   fs/fuse/file.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 754378dd9f71..6f19a4daa559 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -487,7 +487,7 @@ static inline bool fuse_folio_is_writeback(struct inode *inode,
>   					   struct folio *folio)
>   {
>   	pgoff_t last = folio_next_index(folio) - 1;
> -	return fuse_range_is_writeback(inode, folio_index(folio), last);
> +	return fuse_range_is_writeback(inode, folio->index, last);
>   }
>   
>   static void fuse_wait_on_folio_writeback(struct inode *inode,
> @@ -2349,7 +2349,7 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, struct folio *folio,
>   		return true;
>   
>   	/* Discontinuity */
> -	if (data->orig_folios[ap->num_folios - 1]->index + 1 != folio_index(folio))
> +	if (data->orig_folios[ap->num_folios - 1]->index + 1 != folio->index)
>   		return true;
>   
>   	/* Need to grow the pages array?  If so, did the expansion fail? */

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb



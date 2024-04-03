Return-Path: <linux-fsdevel+bounces-16035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 097B7897201
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 16:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3882E1C26249
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 14:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5A0149003;
	Wed,  3 Apr 2024 14:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GQ9txCv/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD32148FF6
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Apr 2024 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712153433; cv=none; b=EHi1xkvOf5tM+PapC4u1jgyTda7Hb4G12du1buUdIfH6KvKXQ7evQEz7eO83h1M25S6Ydtjx7FtMVlEpoiSggzJgDiooRqvQ/bjRURL6ZM1NqUgzkSSYfWwVIBMXiMtwrgEBMblx3+RJFWRvXrk/NdoZFg58LpiRfHKxmvrnMFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712153433; c=relaxed/simple;
	bh=PoednBtoE1tvUhRclYnddbxZ7od4p002R25b+VPNj7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KbRNqVxpRjOlxquveXdQHbtET2TfY8E9RYSq3qSNrNRZlPXsS0R6qMeA5Ix6TLG0hiq9xCQSdV3XTezEb8wS7w9X2ZIY4+7aOLlU7/gUaG9vV6Z6cOVPAnKdngq5kgzCopfXqs/8xBJYBe/mI5O1X8hcWkNm6cfuOzKdd9TYCB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GQ9txCv/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712153430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y0+cDn0/ggKHKobWqWXUXd6pCIGaHqIXCgKr68nR+EE=;
	b=GQ9txCv/duMuPUR8zDbP0UOtScfOyDp9ihcWvKqpYJedcbExGqiJT270cq9RGKwlI/vitT
	p6R3DgwKY8pEl72z8iNXXkyvTcwaat5E2ZnhDTLTPl4vslo2PuHxPjS+h3Ns5SGYEKnQCQ
	obKgpkvLkofiLKmFycJMgFd8/SiVMT0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-MuREwq22PxCaC-Df5P2GFg-1; Wed, 03 Apr 2024 10:10:21 -0400
X-MC-Unique: MuREwq22PxCaC-Df5P2GFg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a474ac232e9so310089266b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Apr 2024 07:10:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712153420; x=1712758220;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y0+cDn0/ggKHKobWqWXUXd6pCIGaHqIXCgKr68nR+EE=;
        b=SwmZd2udkPNDWvls9hJnBYMn+hOLV/22QCl5wgcCV+K3vlt0dEnWPANjyE534QRllL
         3HEt4Q7AZuYRTJXPjLcIvvsEBRcbwOkOK2b54CdK2boHyvAtf/dpbCG08sl1ffrj1bw2
         gNWZfh9aLP8Vr2d6sNr6HoBHmcnL8418biBkJxXD3wh2D3/vW3mS3vH22giW6hZO65xJ
         n3vj1aHJfxc/cY3GaoQJLFqJdvSs8pu9HzWwWyhY7BEsQe+CYOD2JXsjOtZ5PIWxmMZ1
         Ato2fuXXTGonYDjfIcjKYIf/K3Be6Ul1CVdX52p85sYN+KG6gSGW0qicdVBCNc/UkeoS
         jtDg==
X-Forwarded-Encrypted: i=1; AJvYcCU4hFLY9EqBMZ6BHGZr+oT1C/ewSBsBANXyJLzwnpBgiQBdz5Fp13Nub6tFSQnvn7qIgGwAthHm423yB+4NTbV3Rxqq/VrosYZZRkuHeg==
X-Gm-Message-State: AOJu0YyY0NFVabTnbe6X35/XrthRNkQ11+ttyDu76IpExMgl0tFo220e
	RLa4GzALY7ZJBFYRgU0TTWVcbTplo0ZJDigC+nsaYzJKHA/K8kfZi3p1JArMOEcP7dsaJBEYcOq
	pL3t8sGdYK4ufph12mdoxMQvlvGPLaR0hsiOTUkqNGkSPdTPs4YeqgBEhJ3kdvuA=
X-Received: by 2002:a50:a446:0:b0:568:d55c:1bb3 with SMTP id v6-20020a50a446000000b00568d55c1bb3mr11923377edb.31.1712153420161;
        Wed, 03 Apr 2024 07:10:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhi00Gg7n9Ts7IAvb+tYatzzV6iMMMdxXDIzLOIHLjOh3ba8rP3luYiF+Q/5TjPb4RqxFo8w==
X-Received: by 2002:a50:a446:0:b0:568:d55c:1bb3 with SMTP id v6-20020a50a446000000b00568d55c1bb3mr11923354edb.31.1712153419787;
        Wed, 03 Apr 2024 07:10:19 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ig10-20020a056402458a00b0056c0a668316sm948334edb.3.2024.04.03.07.10.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 07:10:19 -0700 (PDT)
Message-ID: <95be6ebf-9f45-404c-a643-89dd6ee4efdf@redhat.com>
Date: Wed, 3 Apr 2024 16:10:18 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vboxsf: Avoid an spurious warning if load_nls_xxx()
 fails
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Christoph Hellwig <hch@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <d09eaaa4e2e08206c58a1a27ca9b3e81dc168773.1698835730.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <d09eaaa4e2e08206c58a1a27ca9b3e81dc168773.1698835730.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 11/1/23 11:49 AM, Christophe JAILLET wrote:
> If an load_nls_xxx() function fails a few lines above, the 'sbi->bdi_id' is
> still 0.
> So, in the error handling path, we will call ida_simple_remove(..., 0)
> which is not allocated yet.
> 
> In order to prevent a spurious "ida_free called for id=0 which is not
> allocated." message, tweak the error handling path and add a new label.
> 
> Fixes: 0fd169576648 ("fs: Add VirtualBox guest shared folder (vboxsf) support")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Thanks, both patches in this series look good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

I have added both patches to my local vboxsf branch now and I'll send
out a pull-request with this and a couple of other vboxsf fixes
soon.

Regards,

Hans





> ---
>  fs/vboxsf/super.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
> index 1fb8f4df60cb..9848af78215b 100644
> --- a/fs/vboxsf/super.c
> +++ b/fs/vboxsf/super.c
> @@ -151,7 +151,7 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
>  		if (!sbi->nls) {
>  			vbg_err("vboxsf: Count not load '%s' nls\n", nls_name);
>  			err = -EINVAL;
> -			goto fail_free;
> +			goto fail_destroy_idr;
>  		}
>  	}
>  
> @@ -224,6 +224,7 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
>  		ida_simple_remove(&vboxsf_bdi_ida, sbi->bdi_id);
>  	if (sbi->nls)
>  		unload_nls(sbi->nls);
> +fail_destroy_idr:
>  	idr_destroy(&sbi->ino_idr);
>  	kfree(sbi);
>  	return err;



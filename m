Return-Path: <linux-fsdevel+bounces-45796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE22A7C52D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 22:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2D69189AF78
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 20:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3A019F101;
	Fri,  4 Apr 2025 20:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KkN+luXV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D501990B7
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Apr 2025 20:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743799984; cv=none; b=LVFSG2+86Qr6js25h55AQBs2H/Sz5Rqm0cBXsLYJm7Ui+9uOBf+17lmEaqXpxG6juwp8GRqP2JDOraHzgdgsH+IQNO5U5UrMPZ1lVrMdWirx/io4zLxwdhpLBJbqmp9F2FSp3XG0P0P2bMEQbJ4Iri/pXsyE4f1FceQaUvMOUjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743799984; c=relaxed/simple;
	bh=x7SIygd3Yg+VNNFSc15gLpsqjkTFr9vCr175pKUouds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n8Y0OKYIrBiN+9RBSsD/yH/UOfCX6YniqrPp5C17+oR+O2VKm8/iMUf+7XIkQhWb2VD028hst4ru4Dku+zJKfB53MDIkL6ABpcb5B1W2LJ5sfGuEeWSKDKzOPGVBs0jxitRZX+HeQUXfisUUO1yHHWNm8SX/OGXhSYF9xpbLwsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KkN+luXV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743799981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=E0fOIqrzYn6BacWW5GlXYHW4/I0jmajsUoLQnZIyKoU=;
	b=KkN+luXVsaU4d8zHxSmJmTibdqDuZavRaEq1Auk9nMhorefJgOanHvs/kepPYfqFUH5kyb
	deZwJX/bIoHLwyG8ge0pSPnqGC11p43LBuZPCeedGUTx38SbL2e1c6LMvlDY4HRa9vwdu9
	G4MLK9sSRiJIbQOo6BiS1w72CRaco/I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-PVKwdrX8M5iegwXSHkjm0w-1; Fri, 04 Apr 2025 16:53:00 -0400
X-MC-Unique: PVKwdrX8M5iegwXSHkjm0w-1
X-Mimecast-MFC-AGG-ID: PVKwdrX8M5iegwXSHkjm0w_1743799979
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39979ad285bso1453451f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Apr 2025 13:52:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743799979; x=1744404779;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E0fOIqrzYn6BacWW5GlXYHW4/I0jmajsUoLQnZIyKoU=;
        b=IQD0vihWyb+STYARGT84cW8jyLVIGfQOaFJkQjop4n655H9Fb04hYzgReMNEbGg1vS
         bgJF2p39slCdoIKx7Yp3jHFBZSmRDx+5C9egfSZp//m8bWVEPU5KsrJt5xXHcuiE+pJ4
         gguy2WKWwadzSuFtMZxUhq7jS5kJAQFuAvUNpXFC8DiOTLcBMxpFQnQ4+NQ7rtdk/CxD
         IyIUPXJbeQXGtILrjmKiO6mKW1jKom/8F8LldAnOBtlsJJ3MORGmJG9jZgqVyxnNsCG1
         pE35yHzW+9pVqiRez9rZNz61avI7+PiITbv2VqG1eblOJfYyoyM4ViVeMaZGg2wCZdtx
         mIxg==
X-Forwarded-Encrypted: i=1; AJvYcCU0xgladmB1xK+kaA2UstB4R5fAX41hVq3Mjj3IKNOrUkU73AKmEJiqFE45STy/V336ww1EoRoyHQoeaNQC@vger.kernel.org
X-Gm-Message-State: AOJu0YyimIycatM+N+PR7glkdfQwCKtJ7q3PFpZcfRD9PMm4EBl6i7aM
	EdJ7qjK2YVTnYSBtC8/RC9pCP2I3VvwXgK74nxvEB4y7wMXrW45ImACK5M743kuFSCsSNiBx3bp
	j9crYednxBVttYXp8zJ4Zn3avz7iFUi1ZzTlgLqpTfHp6igq5o6msERbz27WO0y0=
X-Gm-Gg: ASbGnctIimcewFKTntXXBPdW1P3tG5nvn3KNZby72AzDrCsdKTwPaSx0knx0UyRZCpd
	mgwK1rZ6NQ3USoRfnDRvifGXv+zYjK8sOks07P7HX/FAa92vWAmgADSy1h77/At2sFs4grckH4n
	PLX+CvKv4S8WFOa1SDrsSlsUhOOQtkDHN2sJQPnQfZXmX97zy4AoEQBX6OFj4omk4aQqyEcxOQC
	nV8P4BHTwRKceCYLoJd4CxA9IvsQvNKc7nCdVBWmhFiqEafKWEBzWa4qWIFToT56vTchdmryvIy
	QZMBUf4IOThGwaFnMHFbcMn/QrhTUXUOF4KLUtdIPIkFDrKSDIT3ig1oQAWf2Sxa3w4FjkR4DtB
	J6zkL64d+NIqwVHxmLW9Ia7sZTlA7gX9QEauf8jrwiLc=
X-Received: by 2002:a05:6000:2484:b0:390:e311:a8c7 with SMTP id ffacd0b85a97d-39d0873fd0emr3498838f8f.5.1743799978403;
        Fri, 04 Apr 2025 13:52:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFd3IDdLKGcLbxxcVSxbatyeLpUDJbDVYD7+UuS2EC2o9Wvp4LumG8OsCMFo9rwqwS8Xvcljg==
X-Received: by 2002:a05:6000:2484:b0:390:e311:a8c7 with SMTP id ffacd0b85a97d-39d0873fd0emr3498830f8f.5.1743799978046;
        Fri, 04 Apr 2025 13:52:58 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71b:7900:8752:fae3:f9c9:a07e? (p200300cbc71b79008752fae3f9c9a07e.dip0.t-ipconnect.de. [2003:cb:c71b:7900:8752:fae3:f9c9:a07e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec366b571sm55551935e9.40.2025.04.04.13.52.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 13:52:57 -0700 (PDT)
Message-ID: <3d6f2f67-f25a-4dba-80ac-a442ad06fe22@redhat.com>
Date: Fri, 4 Apr 2025 22:52:56 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] mm: Remove offset_in_thp()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20250402210612.2444135-1-willy@infradead.org>
 <20250402210612.2444135-3-willy@infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250402210612.2444135-3-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.04.25 23:06, Matthew Wilcox (Oracle) wrote:
> All callers have been converted to call offset_in_folio().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   include/linux/mm.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index d910b6ffcbed..99e9addec5cf 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2428,7 +2428,6 @@ static inline void clear_page_pfmemalloc(struct page *page)
>   extern void pagefault_out_of_memory(void);
>   
>   #define offset_in_page(p)	((unsigned long)(p) & ~PAGE_MASK)
> -#define offset_in_thp(page, p)	((unsigned long)(p) & (thp_size(page) - 1))
>   #define offset_in_folio(folio, p) ((unsigned long)(p) & (folio_size(folio) - 1))
>   
>   /*

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb



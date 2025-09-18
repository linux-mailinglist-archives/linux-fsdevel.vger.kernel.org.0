Return-Path: <linux-fsdevel+bounces-62082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01470B83ABD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 11:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB477721D1F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 09:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C612FBE08;
	Thu, 18 Sep 2025 09:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MCjtsiz4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810D42E7BC0
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 09:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758186190; cv=none; b=q6YDyBUxp2w/a1fo3wTqiVsvueWaZlAoX3UXQuyl66MJS8ArfxragQdnibxphQbN0VG+UebMU5odJoMPrDf4pJzhngYkc/VstBsCc664T3MNNsySGvS/YhRPyvaRCKI2P90HcR0LBK0XCHVl8F973uA8iyDKF1QgvyqhnUxNHEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758186190; c=relaxed/simple;
	bh=3gF74B/Ah4EDnWU58ZXx6dvP16HFD3sYPDMbzivTE0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sQsM3a5PEIgrd6YdHv4HWvSq82KQKPfCUoAnRC1rwY8e9Gb2K/bwXYPv8uRuChqrXLp9IpXdt+T8r78bWCmo0hyaJ0u1EsDJCuoBRUWAP4mQ7QtX4kPknV5Xy/vylXGn/fs3orrxwn8+KnC7mxtdvpYnkaaNcNncfPr/tiVfo/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MCjtsiz4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758186188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XFCZX9eN7thiq9pavKtpP8J9JCm4he2B7yCgrgp98u4=;
	b=MCjtsiz4r9xGj+hY01nwJfnHfS/x74Wez0cQH0RlxB6nI6WsptM4xKY+TOJotUsgpZev9X
	wb/PWgC8Oc9RujZKW7PV3HM1CnV/p2eAQIF3GoyvhHSTUZjm7bcurfjEwwCrKcbtx8eAgh
	OUUiP4Rc3MsrCmEwdgpxAdJVriCXSbY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-wPDDKa1uO4alzWq2qUmbRA-1; Thu, 18 Sep 2025 05:03:06 -0400
X-MC-Unique: wPDDKa1uO4alzWq2qUmbRA-1
X-Mimecast-MFC-AGG-ID: wPDDKa1uO4alzWq2qUmbRA_1758186186
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45dd5c1b67dso3177115e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 02:03:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758186185; x=1758790985;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XFCZX9eN7thiq9pavKtpP8J9JCm4he2B7yCgrgp98u4=;
        b=NKLTXVaU2I3mqpl+jL81SnJVCv02c5ohXAMze6zP0inSOnPNaoqfi7Irq5Tjo+H9Hx
         diFkTzwPpQj9Wz5U8dTvgZz8AsZd/WOJyf2c9+g335HJ1YNL/MwRBBG3Vb8d2CQLP3nT
         KlI+5nm4cuwNdvGje8FT8kn8Cx3tm1vrWn+ixQMPHuC4iihStI35SVGxkYfkKTSDmzd0
         rXN7wrs+rAMSELG5rxuvjOT8AAYNw1ePNXyIoIQoaQkGd4PuqBr1P/5I9YqN1o539CEs
         DElgfRxlROo2TgIqwoZuJxIbvLRniyKi/gIxjVdKbCvLSUGH556L6e4y8sXEaljNDuqp
         sofA==
X-Forwarded-Encrypted: i=1; AJvYcCVH44uMlDMimdnus9yvkh0M41VyzOPomW4jFpvpJlBsOCE+JIM70h5+n1o9vPYsOIp5X7x6mKR4CFQ4TC5C@vger.kernel.org
X-Gm-Message-State: AOJu0YxGU6xHDNW7QX8heWXqH4t+KCGjh9XY2LX86LGvD2weNSKXK6jw
	aTKOI0LoCiEaATBm/7d5NPZGQ9YyHupdWHSS3RwMxGQdRd953YTnTnisglTgs4EXwQCnK6gOPzJ
	LqembHaLvoyBH/9/O+iwonDyX/ZbbtCWDGjpiC+1+PDp5mYWmFa7CYl99sNhc6i4K+Ts=
X-Gm-Gg: ASbGncvbrSHiBXBvOXHnS6DNMrp2GDeLHNPr3hBWHMHdO2nqUpWAN26jcZDtBvcwrmG
	mjwE9Amy+GwQYzpQFOUfgDk4shVcrCSaO7V8LWzHFssj5sIcvxyLMUhlM6XtZjT95FvqeoPAagY
	OMzc3rJ6IOEamTGNDtfdcy2V+NAayGVAVXkJJ9zL5TINM4nLvCEGDZg/7Gyxgp4ZHIfqCQmy39q
	txJnPdpjGup0dVF49In1E8yyXTVTM/MblPLZk5LVCAhIyzLuPi7skIbC3r8sTYksqU4wa0VVqTH
	euhJ52tOTYPI7gGFS2psLsa2GrDbcmlBXhGSiY5zG2qg7gQ4Nt4h2LldzfX6JgBwwNBDCrcj1C2
	FJEpbAM5Rk7Ka8a2/A0jNhmEoR55t12AHXsSl0JN4jDRh+/9qKDc3QXZ9tRecym9QZ9I1
X-Received: by 2002:a05:6000:2313:b0:3e7:42ba:7e66 with SMTP id ffacd0b85a97d-3ecdf9f4477mr4804892f8f.3.1758186185408;
        Thu, 18 Sep 2025 02:03:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElkxupMxmNif5/lzfzUVobHl0PSoeQ1IdEubg1s704Bcn0Lb4/+vf/JHCv5gGV276WTwwYSg==
X-Received: by 2002:a05:6000:2313:b0:3e7:42ba:7e66 with SMTP id ffacd0b85a97d-3ecdf9f4477mr4804839f8f.3.1758186184853;
        Thu, 18 Sep 2025 02:03:04 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f07:dd00:ca9c:199e:d2b6:9099? (p200300d82f07dd00ca9c199ed2b69099.dip0.t-ipconnect.de. [2003:d8:2f07:dd00:ca9c:199e:d2b6:9099])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613e754140sm70721995e9.21.2025.09.18.02.03.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 02:03:04 -0700 (PDT)
Message-ID: <45cd1637-54f6-4941-9670-7130aaf080f0@redhat.com>
Date: Thu, 18 Sep 2025 11:03:02 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V14 1/6] mm: softdirty: Add pgtable_supports_soft_dirty()
To: Chunyan Zhang <zhangchunyan@iscas.ac.cn>,
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
 Deepak Gupta <debug@rivosinc.com>, Ved Shanbhogue <ved@rivosinc.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>
References: <20250918083731.1820327-1-zhangchunyan@iscas.ac.cn>
 <20250918083731.1820327-2-zhangchunyan@iscas.ac.cn>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250918083731.1820327-2-zhangchunyan@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.09.25 10:37, Chunyan Zhang wrote:
> Some platforms can customize the PTE PMD entry soft-dirty bit making it
> unavailable even if the architecture provides the resource.
> 
> Add an API which architectures can define their specific implementations
> to detect if soft-dirty bit is available on which device the kernel is
> running.
> 
> This patch is removing "ifdef CONFIG_MEM_SOFT_DIRTY" in favor of
> pgtable_supports_soft_dirty() checks that defaults to
> IS_ENABLED(CONFIG_MEM_SOFT_DIRTY), if not overridden by
> the architecture, no change in behavior is expected.
> 
> We make sure to never set VM_SOFTDIRTY if !pgtable_supports_soft_dirty(),
> so we will never run into VM_SOFTDIRTY checks.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
> ---

[...]

>   mas_store_fail:
> diff --git a/mm/vma_exec.c b/mm/vma_exec.c
> index 922ee51747a6..a822fb73f4e2 100644
> --- a/mm/vma_exec.c
> +++ b/mm/vma_exec.c
> @@ -107,6 +107,7 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
>   int create_init_stack_vma(struct mm_struct *mm, struct vm_area_struct **vmap,
>   			  unsigned long *top_mem_p)
>   {
> +	unsigned long flags  = VM_STACK_FLAGS | VM_STACK_INCOMPLETE_SETUP;

No need to resend because of this (probably can be fixed up when 
applying): there is a double space before the "="

-- 
Cheers

David / dhildenb



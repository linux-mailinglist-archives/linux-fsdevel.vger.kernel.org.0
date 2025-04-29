Return-Path: <linux-fsdevel+bounces-47627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 518DEAA157F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 19:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F75D165B43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 17:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B6025485E;
	Tue, 29 Apr 2025 17:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lp4beAF0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A90F24111D
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 17:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947409; cv=none; b=KfpMihW54gklX9ZNxat9UqUBESPH3XRyZKBrTra/A84m32KvVVXuDDuUmTgpJthAAFpRRcvQDn9COwjiHX8oFDosUhZMr/FX+uMB116aWtYqo/HJ0UaVZJIsGtKBxlgZ2HDyYoz+cRNJzcfFTNmnG2RcMB3UWV3GmvUiER9xs60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947409; c=relaxed/simple;
	bh=aT1PNU8bBsYPPvH3P7AuZtCgRAnSsIJK828EwxpbErA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fy6+OcASpYg6H7ln+bW3h6cOOxq1I/WWshwIFlUXj7rCHN4k3VwfvlBQE7SbPgbHJc7cfPHnqTn6waWsAu/urtw1ohetTbXJhHnG1M9SZxG5kY9pgOwULUQJnV0hRxO+n3jn+TluO8uAGuk5RCnA7VgRAACWKEfbpC4Ej5iy3xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lp4beAF0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745947405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mejufdpGoxe4mxva5kvPFm+VySXa27d3Wo1WQ6UneQU=;
	b=Lp4beAF0PkqSnicuzGSBs3gszbG7Qh4QLBmuNWWJLghWDpJDcpw+PII28lHfuq2lGNU4mp
	6x8Xs1Jt9tdwgXsRLImrqNmu+dwPhB4V23+26MlBVi5PL7aGCRjujNIxkqsYdwPC3I1p3R
	wujgPbXSjAvczgqmdCvzNcZRiP7Cz8k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-2W7ONsakPAqOKGwYjgnWHw-1; Tue, 29 Apr 2025 13:23:23 -0400
X-MC-Unique: 2W7ONsakPAqOKGwYjgnWHw-1
X-Mimecast-MFC-AGG-ID: 2W7ONsakPAqOKGwYjgnWHw_1745947403
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43d5ca7c86aso36395005e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 10:23:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745947402; x=1746552202;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mejufdpGoxe4mxva5kvPFm+VySXa27d3Wo1WQ6UneQU=;
        b=MkDq1kDKi79UT9ZWO8LTFM80fCjU+jivaUDwAfPRrDwZTcDPJCi5cUR/pcDXFVrCER
         9+ojhY8gUtEVcCaWN/9qHmuZYgtXWaaQcbLMgmaUkYEAiio1IzPEFClUEmNm3ktPQwa/
         G9ACBAA8c1Ru8AIkaW8SEa1MArnGudvndgVhP0khwDuH9Ew6M0EMGkUYTjCNRVfjLmZH
         GT4XJk2IZERQn3QKUHSRzIR5pu7YRjWESOJMBgMmnqbFMg3ZYCuVPbRpSi3u9VotlRNb
         kvmd3iGiQWq1mUhCcUio5UMO3WnIVI5cUUb6zcNSpfIV56mZa8N8/hu9yvgROHI7a7U8
         mSmw==
X-Forwarded-Encrypted: i=1; AJvYcCXpbA/0e1T9vxoxOR44EJZFiD2M75tCMn9VK9nSLuVrkq3IcX4qUwRIE+Zc1tCmSute1GL9dk7INlffYQUR@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm8q+RgWvR2wK0movH08qqeuH0LxsoXLNhcBGLWrZAzhLiIuui
	Vu+Z0AwqWc1av+h08TnJGORVOFEp83b4PkVfTcJih2Fz8w1F2BsNdMcJRMAOKjdNiCRC9df9+VQ
	RYEa+k3LLt1xWSRtsxXz7QjA3jG0U18grARW9qznDxHy8PLoQQatrn6xtOJRBoUI=
X-Gm-Gg: ASbGncsYKrl8YrYTYWkw2kQAi/+0JgWeiMGi6FagkQs+gf1Sd5LR98kmB3LaFKL6xHi
	JLGW40F25X2jzVSurGJB1I82SmwsMKnoF0zjWFN2ui/rlC1FXYTDuaHN1EqmGL4h/FYIcVbxGgB
	gpCJ/9ZEwu0Y4uChKPOGHdmpirBsoquwZLYiqc1zODrYsGioKVpCh3lb5OVteXdWmwtlJxaPrP7
	dFg9jlt3ujHvRmw6/TiKgCVsUXQU8Y2OxJ98ppXYqwCycDc8tAYY3Pgtk3tn7RxQrRMTCZ+kzgM
	oja30XeCQ3TGjzQxc3yRpryDQ79zE5wcATKLkhTS+H4F12F1bKYAj/ZzKztFqPiGBev1vFrKVls
	kIcUTXRQrM8sbwPjlWfwg82IMjCjuybGIHvwTrEo=
X-Received: by 2002:a05:600c:c86:b0:43c:ec4c:25b4 with SMTP id 5b1f17b1804b1-441b1f35e4emr1438905e9.10.1745947402644;
        Tue, 29 Apr 2025 10:23:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNmnRHxTJDC6Sf1Feg9BZAcb7lU9XtPRhls0zLu4URvGAHP8TbMwuFoVKc6PogHibLfiWHcA==
X-Received: by 2002:a05:600c:c86:b0:43c:ec4c:25b4 with SMTP id 5b1f17b1804b1-441b1f35e4emr1438655e9.10.1745947402323;
        Tue, 29 Apr 2025 10:23:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73b:fa00:8909:2d07:8909:6a5a? (p200300cbc73bfa0089092d0789096a5a.dip0.t-ipconnect.de. [2003:cb:c73b:fa00:8909:2d07:8909:6a5a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2d8976sm194918965e9.27.2025.04.29.10.23.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 10:23:21 -0700 (PDT)
Message-ID: <f192c143-b5f1-4899-814d-bcc7089759ad@redhat.com>
Date: Tue, 29 Apr 2025 19:23:20 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] mm: move dup_mmap() to mm
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Kees Cook <kees@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1745853549.git.lorenzo.stoakes@oracle.com>
 <e49aad3d00212f5539d9fa5769bfda4ce451db3e.1745853549.git.lorenzo.stoakes@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <e49aad3d00212f5539d9fa5769bfda4ce451db3e.1745853549.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.04.25 17:28, Lorenzo Stoakes wrote:
> This is a key step in our being able to abstract and isolate VMA allocation
> and destruction logic.
> 
> This function is the last one where vm_area_free() and vm_area_dup() are
> directly referenced outside of mmap, so having this in mm allows us to
> isolate these.
> 
> We do the same for the nommu version which is substantially simpler.
> 
> We place the declaration for dup_mmap() in mm/internal.h and have
> kernel/fork.c import this in order to prevent improper use of this
> functionality elsewhere in the kernel.
> 
> While we're here, we remove the useless #ifdef CONFIG_MMU check around
> mmap_read_lock_maybe_expand() in mmap.c, mmap.c is compiled only if
> CONFIG_MMU is set.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Suggested-by: Pedro Falcato <pfalcato@suse.de>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb



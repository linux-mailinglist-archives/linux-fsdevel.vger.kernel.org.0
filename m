Return-Path: <linux-fsdevel+bounces-44296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4A3A66EB6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 09:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9C84178B2F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 08:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1811204840;
	Tue, 18 Mar 2025 08:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M3GnNX1U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF59F1DF27F
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 08:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742287451; cv=none; b=Qe5/JbDpyIi9lMV7z/h6HrfMUmfPerkZRKTEwo6XD4TVROD3IqierKhKYktE6f9z9EGVnSTDji3SZbOZFZhFedqPX4iq8B3dnlL/f7Hmb4Ig4ZxLx3EPxugd9FFBO2/ydT5Dzy1lvtELHPG22h+zkbBpBI7zbew8qWzHX3oBHV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742287451; c=relaxed/simple;
	bh=fHxfR/Fe1vR2g75IQ8QN4VFEb1/+MPRV0zX5VIgT1+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pdg1IS7TeMt2UlY/w9oSj1UxXrneSYRxePWzCNRBznL3Bxl74fchUF+C5Vdqi/a71e1PXvr01E4kmi8tYiumqMlT0GskxZtSMf7usuGjLxNmF6jj20tzX3mElZWmkxOWhaW/RfbMSXbd3tENjGaXbbqnSOQSZfWOoGcRZa3ZlNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M3GnNX1U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742287447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HDmgZLLIpwK6kAQW08mjGUXvGaI9Zvm7zThuVW477Ug=;
	b=M3GnNX1UiImDBtgc9tZoCcP+8lrV6mnytSFrABIY2DW2Tr8y7gBarwf3Fq+t7PmG+jegSf
	fVIDLI8CDuL+qeZYIuHWdtmA1kXyMVkV+RYrVh006HzaCM0UkzGvLxDMCmwNQoNZvi/Kir
	QRdfQYKs2o6IOR/Ld9PdUSI5QB8VLVk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-XZMN5HZFOKeVouwnB-Aaow-1; Tue, 18 Mar 2025 04:44:06 -0400
X-MC-Unique: XZMN5HZFOKeVouwnB-Aaow-1
X-Mimecast-MFC-AGG-ID: XZMN5HZFOKeVouwnB-Aaow_1742287445
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3914608e90eso3485614f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 01:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742287445; x=1742892245;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HDmgZLLIpwK6kAQW08mjGUXvGaI9Zvm7zThuVW477Ug=;
        b=QK+ZdUxNzUdHgV3oDi7KA5oQ9CdxfhiuWffrqQjNaCqmVBfcsuqQ9ZgGeVe4a6JJMq
         gS9siE8iUR3cyKUCsCZfmylPjAs0UrqLTl15qxKAo//JEIg2PB+wSfdTfQxf/8GKKb8A
         IQvi7Q3dxbzrTig/76h0b8b0rs/Z7OeAoRDSKGi0oG1HKJFWzXVXJhpXAa2EjA6Dw+kl
         7pq/Lg+2bn13b4rZxtvU94yCTSu+RIINYLeAUhbMkvUL6noPNZbWT5dEFnkbdmjspZuS
         VKp2kmnzs8p7X6pHV8dCJ1z8ddxKGGfSS2gwhOWlwXd5sRVrUtojTMD102zckpLzINqK
         wbHA==
X-Forwarded-Encrypted: i=1; AJvYcCUGCtoINxa6AIYwIGGf05oq0i+E6gO0cvBaE505E09MslDmUbb5C5Q+g6dsQQXP3m3FF7EiE8YdW1Hjuk2r@vger.kernel.org
X-Gm-Message-State: AOJu0YzX1gmPNCpzb5Gd9OcrQAxgdaDzi/dwvt0NYo2/EGv09WwolzZz
	iCPn6Rm8UDpTFbs6cb4MsjfyYxwxLZsUUF1POCV1TpxowrjRjPlQ4UG77rXil72jTawwTQgBEPF
	7CQM/eNjuHaaviBBzx3dUEgXI5rPRw/NcWUTfJxX376CD3iFWS1VAs99K+WyvgMI=
X-Gm-Gg: ASbGnct6mjj/8ZRO51tTAQeU3xBkg1P6NHnZeYKp1dHw4+zqEG2Z4l73OP6+uLAu2fB
	zApoq4kxPS5P3KCY719ailJ6GwZh0uf8JiKfQkhEdGJTup1mTOVjOEBn6GKrjy5dN5iF448zhv2
	V0oKJqioS/+SmKhLS82sg1blIYDJbVnBbsHeI/KVnPdZ/csel+o2vPyzldUiwy3/comAM2qoc2B
	VwMCb6f3o96lEvZVvQdrslsDuIUfwBiwQCMHFE0EtZtW9Lbm7aCy7Sk/mU9AmcGag4oEwdRthPq
	jIqwmiZ+YCqod21bFuqxuy1ARXFRn0RD1BsNfz1fpvbIOYDgkdRFqOrqHo3qDrj27sjQ2Pw//B5
	PDVBT58DQTrtp0ejbzJNE81FSOZNs28W6A/arBg78i1w=
X-Received: by 2002:adf:a403:0:b0:390:e2a3:cb7b with SMTP id ffacd0b85a97d-3972029e76emr12128980f8f.34.1742287445217;
        Tue, 18 Mar 2025 01:44:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsMPDk30z1VcJpRB8YjodHuvxQ4d8je3JZS6Y7eZxfRI9LeTmUeExaG8tWg4CG2GeZC+ZVcg==
X-Received: by 2002:adf:a403:0:b0:390:e2a3:cb7b with SMTP id ffacd0b85a97d-3972029e76emr12128962f8f.34.1742287444875;
        Tue, 18 Mar 2025 01:44:04 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72d:2500:94b5:4b7d:ad4a:fd0b? (p200300cbc72d250094b54b7dad4afd0b.dip0.t-ipconnect.de. [2003:cb:c72d:2500:94b5:4b7d:ad4a:fd0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b7656sm17079741f8f.40.2025.03.18.01.44.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 01:44:04 -0700 (PDT)
Message-ID: <0e48e415-b5db-4555-b73b-d2a032752bfd@redhat.com>
Date: Tue, 18 Mar 2025 09:44:03 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] fs/proc/page: Refactoring to reduce code duplication.
To: Liu Ye <liuyerd@163.com>, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev
Cc: akpm@linux-foundation.org, willy@infradead.org,
 svetly.todorov@memverge.com, vbabka@suse.cz, ran.xiaokai@zte.com.cn,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, Liu Ye <liuye@kylinos.cn>
References: <20250318063226.223284-1-liuyerd@163.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250318063226.223284-1-liuyerd@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.03.25 07:32, Liu Ye wrote:
> From: Liu Ye <liuye@kylinos.cn>
> 
> The function kpageflags_read and kpagecgroup_read is quite similar
> to kpagecount_read. Consider refactoring common code into a helper
> function to reduce code duplication.
> 
> Signed-off-by: Liu Ye <liuye@kylinos.cn>
> 
> ---
> V4 : Update code remake patch.
> V3 : Add a stub for page_cgroup_ino and remove the #ifdef CONFIG_MEMCG.
> V2 : Use an enumeration to indicate the operation to be performed
> to avoid passing functions.
> ---

Acked-by: David Hildenbrand <david@redhat.com>

Thanks!

-- 
Cheers,

David / dhildenb



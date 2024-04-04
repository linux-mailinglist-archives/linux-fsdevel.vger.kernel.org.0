Return-Path: <linux-fsdevel+bounces-16132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D364898E2D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 20:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE4EE289432
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 18:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3770113119B;
	Thu,  4 Apr 2024 18:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y4UBJDfJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D87112F590
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Apr 2024 18:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712256228; cv=none; b=hKJFt6Ry3W7GptoCcygwuIiv5mz7laGWfXYIrxfF7CCp9HnPraKPzxRxMPuFOEVD3cVgt8gog1lE7+QDGM6JhrncyXCCubXug7gas8Q6ngcojRYclkdcGzBlKJxVj9JxaJ08pqKBT661rzbOjrPvKZ5P+0jgG9DG6vMmJ80S9aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712256228; c=relaxed/simple;
	bh=iF0tIs6DN9Apfb2P/e8GSv4okNa2h9GtOyPYOGQIRkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O04ohSDaNY3IZSxZG1rATK4P7dWIjRYndrvznj0zSVblmIWwe2AHonpWVZ50G2gTzI2Wn/LrZ/996WNzTuh0PDYf6pkhPIROsxt83cGtkOIxO3RTwF+CC0lH+DYbbSYucKQ0vat6mGwFTazSyoZxUNJ9nUbNcfHBcfXgf14xj1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y4UBJDfJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712256226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=upMwz3yQy3PT+r8GNLR6Sfu1bgREhJh0qQOAAKQCpIQ=;
	b=Y4UBJDfJy4w1ODJPk+KXC+dY3mdrouE3IQHf2mfslnsiqTSpshLng2/6xzWLtpXdRtuAOK
	ki9yUyd5loKA2RbqdsaLhV8jnZuttZWhXviFloUkiH2wwGA/LURkOBTnr28U0y57ziTG2l
	UDNe3XHER549QZGpwT0ViELpNU8YVyA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-FNDPUWevOxihQCBjuwTrYw-1; Thu, 04 Apr 2024 14:43:44 -0400
X-MC-Unique: FNDPUWevOxihQCBjuwTrYw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4162b93067dso3475655e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Apr 2024 11:43:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712256224; x=1712861024;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=upMwz3yQy3PT+r8GNLR6Sfu1bgREhJh0qQOAAKQCpIQ=;
        b=kDm76j9Eg9cgg6FaSSleen4U6VOJkrhNTyq1aIwpJ/bs2Ee3c0XxIN2x5+VuKBhffC
         ro1Y309ZhPTaqBw2MtnUYeO9/uM+5o59L8HvZkMDCIjKP+VRzOUnDxSrkq2uzNQ832R2
         bvDLzoOUD97btv07ubN69L2Hb5dT/WnPP1XLWZfpvxXTJAwyWDcJDd365kYk3ZBcVLbG
         YQ7ziIiuDTJLuxOumwRgBuEraaFMrFksC+/bxbgxgZ2AuzC/7VsqWBR5dnj0NraT7K7u
         j0w/WU6nqVma8Dxrlck5n1OCsWbSBTV1EuQTj68EHN2Lo8ksiIdb/faP1kNZ6jbJWhkq
         gA3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXgc9/GzPVCtdSDUyJ/o5vRPRe2x1AwPWsRCQ+d/YM0ooHO9OofiKU8YJlUk2gpuH8xOsHOYgyYWclJ/rh76/I8C/MwI8+2R+G6AHlOxQ==
X-Gm-Message-State: AOJu0YzIMqe+GEEiZjqvYZgMFtO5HnqL+EOyGKCQEYwG9sdgJBuJtuow
	T0IWw1clB8ZVj0L3heVG5Xq5ZRmN0p8lRkjdZj3aweV0kFm4C1kqfDcxFM6s6RvtXBFCRMldpT1
	E8cE32Tf1jNRIUWPtJMP7SrT9HQhX+Ip3YeLE0ajo0IHLyFoMg17jbHIsUyb0AZ0=
X-Received: by 2002:a05:600c:209:b0:415:52a3:63ef with SMTP id 9-20020a05600c020900b0041552a363efmr2412070wmi.31.1712256223718;
        Thu, 04 Apr 2024 11:43:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuGJAFvtIXGThmplt8ct5Ju8k+xlMgZkyPYd0yjA9WD1pike4adIpSBwdPINaHGVvUD7jFGg==
X-Received: by 2002:a05:600c:209:b0:415:52a3:63ef with SMTP id 9-20020a05600c020900b0041552a363efmr2412061wmi.31.1712256223309;
        Thu, 04 Apr 2024 11:43:43 -0700 (PDT)
Received: from ?IPV6:2003:cb:c743:de00:7030:120f:d1c9:4c3c? (p200300cbc743de007030120fd1c94c3c.dip0.t-ipconnect.de. [2003:cb:c743:de00:7030:120f:d1c9:4c3c])
        by smtp.gmail.com with ESMTPSA id fm22-20020a05600c0c1600b004162c119b6esm1629028wmb.27.2024.04.04.11.43.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 11:43:42 -0700 (PDT)
Message-ID: <7e771e6e-e715-4842-ae55-db0c88a58dc2@redhat.com>
Date: Thu, 4 Apr 2024 20:43:42 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] mm: Generate PAGE_IDLE_FLAG definitions
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20240402201252.917342-1-willy@infradead.org>
 <20240402201252.917342-5-willy@infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240402201252.917342-5-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.04.24 22:12, Matthew Wilcox (Oracle) wrote:
> If CONFIG_PAGE_IDLE_FLAG is not set, we can use FOLIO_FLAG_FALSE()
> to generate these definitions.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb



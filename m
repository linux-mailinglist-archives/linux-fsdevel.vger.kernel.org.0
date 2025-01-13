Return-Path: <linux-fsdevel+bounces-39026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFFBA0B413
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 11:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B242E188801C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 10:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988812045A2;
	Mon, 13 Jan 2025 10:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LUdp5X8y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C841FDA7B
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 10:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736762836; cv=none; b=isbylPpAhzBFHAu7Ttt/Zf/JYThU8VCZ05XPizk8R4v7cqM2o9ZJuZbxc7rbTaXUvwj8obQRX6I0c7yWYpQyRPTDirFUUiy49RB8fl3ZEXnCjNMiGq7RBaunWD8qnCZLt/Z/bFRUDA2rN3uhUB12xQNOkbukFDNud3GAg9nYATE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736762836; c=relaxed/simple;
	bh=U8t8wOoQ/iIZqM3VHX+lcCBV4tyZ4SovjUch7+PrBJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z1JagJ7Xa6L+ASFcjLy6HEybt//Vp/aOA/KTYzpQKcRfJ7BhpiZdKHhPYS44xD8u/irL5KGeHc3BPQDPnEDW7jSmkbm+r1eKDqrYdftliHUqeovfGZckW3L7RiNFzl0M8+xTP7eA0WEeKWe0sQPLAfWixtrIk5DQxZVkRmq6KNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LUdp5X8y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736762833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6RoMHKqn+OEQUYxBDfwfMpacXoRqdmw+E8HI3RxVKFo=;
	b=LUdp5X8yFf+8B3RUcwyj07uarR1VO+6FUZZx5O4Wb9I8/2igEN2XV3vzrrFS1G9zSOVMNi
	39b1QWWRc2UiId2yOrJlP2PBG9q2prVvmsgLjGyX9Kj7rOmRqWhXp2nWR4yxYRHTyc7OZU
	FgKW6EU1xStC3+CW5LJdCKCVQWzzwwE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-Goo8pRglOMe_5BPFfy_Rnw-1; Mon, 13 Jan 2025 05:07:11 -0500
X-MC-Unique: Goo8pRglOMe_5BPFfy_Rnw-1
X-Mimecast-MFC-AGG-ID: Goo8pRglOMe_5BPFfy_Rnw
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385e1fd40acso2197259f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 02:07:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736762830; x=1737367630;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6RoMHKqn+OEQUYxBDfwfMpacXoRqdmw+E8HI3RxVKFo=;
        b=BajS8vN5r1t/ll1SpXE4mhgMIXetzZstzwKiWfwHRzyqIgVJagudtyTFO9TJBFP0aE
         mMbSEHlLeZcTS3PT0FkKfU5cvUnYdnFUY/QtS0vWIrl5gPcLIv4ODbKoOHdq5fG6tf8r
         5TrF6ttovEfip55otXjAaqIwt2hnKLrPmU8rNI/fKcyeD+qQd4EVTonR738JEMEjI7JR
         QMBh56vvZrvvrvXF3gsr8cAm9rGqWwJjyuaie/0nMenMspBsOuQ6EOmDTC95/Ee87NUO
         SVnX5A0ZdI+nGieCaOxR/Qf1+JWX+hRXdoiNj9mZPlL00FghvGLeGQvuUp/fcv/MmcO1
         q2mQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyR63MfEwBh+KWI7jTnzj1JPJac/k248NO79L3D1RpEx6ftRIYx1SIKH9vNbfaB+kqWnQhqybeto8xNEDk@vger.kernel.org
X-Gm-Message-State: AOJu0YzEFImuATzAwQCeMj+d3RgnRaNouLJF6VRkuUjA4JKzTZdOPZxe
	NCYvVY/6as6nqORkQph6An7x7cbyqoycjejYl0tGfgjM8xRhPT3qSEB9O0NN/lZH5wd/yuKUbvg
	OBq7E9w+q4col0karVN+TzgZ9Z3ARS5YVMrDTB46kJ1jmzau/W6M7F5UiMkS3hx0=
X-Gm-Gg: ASbGncumeGE7wkNk/6Osj1hDqEy4rBkgTlXBDryn5tDwVJwO342AjoS/YtM2DzwR4nI
	xUs2Fa91ormAGXZG2AXcQRJtfFQtOL1fcXmgCAo9IWH6TRHQJcpu2n+J/Peco7BkiDHO3TyTuX2
	wLtbNXxCTSnLfck5Ma3pScFh2QXRl3OfvmghpkQb9t3PH5NK1HOUkAh1YVGcT9xNF/21Mbr9kCZ
	tiHrUw5QDXL++vkYsv556QeX9QzVmQY6YT9idOCxARVgHp0vf/HDhJPQsuHYa0rHaXKfxEBmUUX
	Ke03mTMkMMaDaw4=
X-Received: by 2002:a05:6000:1a8a:b0:386:1cd3:8a07 with SMTP id ffacd0b85a97d-38a872fc363mr16123002f8f.7.1736762830524;
        Mon, 13 Jan 2025 02:07:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEE1u3AbP8k0hrWiLnmAaC1HOmF7dCy3Vq3DJZiBdWZ8I2mC3mR+CAZnCUncnjCDV69fFYbQ==
X-Received: by 2002:a05:6000:1a8a:b0:386:1cd3:8a07 with SMTP id ffacd0b85a97d-38a872fc363mr16122940f8f.7.1736762830154;
        Mon, 13 Jan 2025 02:07:10 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9d8fb99sm140017115e9.3.2025.01.13.02.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 02:07:09 -0800 (PST)
Message-ID: <cb057735-c4e6-439a-aada-9432aae3fed6@redhat.com>
Date: Mon, 13 Jan 2025 11:07:07 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] mm/swap: Use PG_dropbehind instead of PG_reclaim
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Andi Shyti <andi.shyti@linux.intel.com>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Christian Brauner <brauner@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Dan Carpenter <dan.carpenter@linaro.org>, David Airlie <airlied@gmail.com>,
 Hao Ge <gehao@kylinos.cn>, Jani Nikula <jani.nikula@linux.intel.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Josef Bacik <josef@toxicpanda.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Miklos Szeredi <miklos@szeredi.hu>, Nhat Pham <nphamcs@gmail.com>,
 Oscar Salvador <osalvador@suse.de>, Ran Xiaokai <ran.xiaokai@zte.com.cn>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>,
 Steven Rostedt <rostedt@goodmis.org>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Vlastimil Babka <vbabka@suse.cz>, Yosry Ahmed <yosryahmed@google.com>,
 Yu Zhao <yuzhao@google.com>, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org
References: <20250113093453.1932083-1-kirill.shutemov@linux.intel.com>
 <20250113093453.1932083-5-kirill.shutemov@linux.intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250113093453.1932083-5-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.01.25 10:34, Kirill A. Shutemov wrote:
> The recently introduced PG_dropbehind allows for freeing folios
> immediately after writeback. Unlike PG_reclaim, it does not need vmscan
> to be involved to get the folio freed.
> 
> Instead of using folio_set_reclaim(), use folio_set_dropbehind() in
> lru_deactivate_file().
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>   mm/swap.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/mm/swap.c b/mm/swap.c
> index fc8281ef4241..4eb33b4804a8 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -562,14 +562,8 @@ static void lru_deactivate_file(struct lruvec *lruvec, struct folio *folio)
>   	folio_clear_referenced(folio);
>   
>   	if (folio_test_writeback(folio) || folio_test_dirty(folio)) {
> -		/*
> -		 * Setting the reclaim flag could race with
> -		 * folio_end_writeback() and confuse readahead.  But the
> -		 * race window is _really_ small and  it's not a critical
> -		 * problem.
> -		 */
>   		lruvec_add_folio(lruvec, folio);
> -		folio_set_reclaim(folio);
> +		folio_set_dropbehind(folio);
>   	} else {
>   		/*
>   		 * The folio's writeback ended while it was in the batch.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb



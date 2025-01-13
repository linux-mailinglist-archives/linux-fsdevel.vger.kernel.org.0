Return-Path: <linux-fsdevel+bounces-39028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CAFA0B41E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 11:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11D4D161ABB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 10:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E43A20459C;
	Mon, 13 Jan 2025 10:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I1m50Btb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3491FDA97
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 10:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736762914; cv=none; b=UGN7I+/GnQN9SAHT87Az9Ia6jXPAwf3HDWU1fjrb+8kmM/YWKoTZo+Nv5oV+V45ux0OyTI5OLwuvRN2OGr+1HIdgP9UoFWHo+GCtFeaNeKlZOGxyknjHIiRD8J6nMnOY090w0lLI3DNlJzjIQXmeoOp3WZ+pOdVlbWj7faA2QLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736762914; c=relaxed/simple;
	bh=UY2x7lfphtbFL2jTlUUfVdt6pXxH98Yr7thjLaQaAQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QIax7I5+2oYzi72v02R1ualdu4aWeIGSOW8hFzAfN0/c/dUrIHAm7+PjJHTpVZJ9Dj9Rb3VlI5LmA5VAHB8Z5qiyBzs9MYz+odPoeCVK7FJqobc+POp1Tm8x8tRDpQ5+4M1P/qkmON/h8YgoInwkfPHG6DNh241rgNG2/gv809k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I1m50Btb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736762911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=w9g1LslBk3KnkNcF/p4M2vlNVEzNEkixwrIJc+UAHcc=;
	b=I1m50BtbnHJ6lW0fiz9TdQNYA2nNklMFwW/M0cB7kkqqzJF12cNV5K8L1+V3jO8HFFlFAC
	dJpP1+HXDJ9OxZYjZ7rxkjapadayVbXGW2mWk6QWsNaPwTHcQ1BdR0qcAxGm1vgQUuK8Oa
	s0SySFaxODheEKqe5pZFEGIdknP0CO0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-FFT9oGCcOz-Eio08XtEZ5g-1; Mon, 13 Jan 2025 05:08:30 -0500
X-MC-Unique: FFT9oGCcOz-Eio08XtEZ5g-1
X-Mimecast-MFC-AGG-ID: FFT9oGCcOz-Eio08XtEZ5g
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3862c67763dso1564915f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 02:08:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736762909; x=1737367709;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w9g1LslBk3KnkNcF/p4M2vlNVEzNEkixwrIJc+UAHcc=;
        b=DFYrg8jeKDgm+RMHaYnGtqqM1oPubwWFTvB/rtzyeaDxlQ02purdOL5nDuD4KiOdnW
         lhHPZ+lyGmpphQwp/QTzF1J5qUarmRbMNtkmOEftjxM7KXxLgXwKZMrM67W7tyeUmPzU
         kmThjffYv22H5+qXYDBDz0sPvazi1NYx88EDNCoRq8k+BgNYHAQZugXNJVPMBo0hp0YO
         6GqI2/Bvt8gsl4yohrKy2SMXuF6+4kXBt4Jhyojyfnals74hqDAmbqpBgR/04n0B/gbz
         CAYNpwX0lt3OoU7umgCKfXFNUgxuq4De5eKMRxubwqW1CF/dJ4FolT0Z4Flx5N6auxL3
         k+8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWemOJieP5aps2Zf6Fsnw9wBWZXrzSEVViDaO68wwSncEzhxJhabMfdvWv1VqaKMBQmTdmGS24AQtV6yJWn@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5c66nsWZprT1137QCZF0OYnHh7s3V9pwvhd/SAOr/zhY4NXQH
	WesDFPM91leIcVJJ8h1LR4whu4PR8FfBOeFjr6FRj6BFw4dHLC6RLLTf3Uw5/OVKg4F8l4NNIlk
	/tYVFoa9muULWoAV6bV7LEEVnqo+Foktisa80Qrh6zygH74hk36mG5gRUqfJHJ1U=
X-Gm-Gg: ASbGncuQ+2ChgJeExkPApl1V0NeNxUV58ATEi778bXcaoYQ0lkeaz9CWcLXR5pSY2n+
	Evy/RY5Y50BRvPueAFos+8B1mivLZ6+OkpaeT7IzL7EuPbrqWnFbm2EvWJXTNRu1z7mySI3DCJf
	1o4dLt73xamscocCS7GYP2DpFWYXXHgcpXn0/kcD2A840oTj/0lnqfQ9gaec8Jdtgp2tDrBAJ4u
	3aIxVj4yHc/8JTEw4iZnoC5T/uKCBAP4ismMVpHP7Z/KqF0ZVhnl308URWsFE/x5qrjqvqWa0bi
	u5EXbhzaT24KAkA=
X-Received: by 2002:adf:ab0c:0:b0:38a:8888:c0ef with SMTP id ffacd0b85a97d-38a8888c2eemr11512963f8f.52.1736762908864;
        Mon, 13 Jan 2025 02:08:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZaJWGDGSA+V3h2fBword2TX3it3Iw21VUBChJlSgVAPvtBC3cixWVuRKOu8C8idzCDyAMpQ==
X-Received: by 2002:adf:ab0c:0:b0:38a:8888:c0ef with SMTP id ffacd0b85a97d-38a8888c2eemr11512915f8f.52.1736762908489;
        Mon, 13 Jan 2025 02:08:28 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da6271sm172066975e9.9.2025.01.13.02.08.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 02:08:27 -0800 (PST)
Message-ID: <1ba00ad0-bb75-476d-a0cc-e3e6029774be@redhat.com>
Date: Mon, 13 Jan 2025 11:08:25 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] mm/vmscan: Use PG_dropbehind instead of PG_reclaim in
 shrink_folio_list()
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
 <20250113093453.1932083-7-kirill.shutemov@linux.intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250113093453.1932083-7-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.01.25 10:34, Kirill A. Shutemov wrote:
> The recently introduced PG_dropbehind allows for freeing folios
> immediately after writeback. Unlike PG_reclaim, it does not need vmscan
> to be involved to get the folio freed.
> 
> Instead of using folio_set_reclaim(), use folio_set_dropbehind() in
> shrink_folio_list().
> 
> It is safe to leave PG_dropbehind on the folio if, for some reason
> (bug?), the folio is not in a writeback state after ->writepage().
> In these cases, the kernel had to clear PG_reclaim as it shared a page
> flag bit with PG_readahead.
> 
> Also use PG_dropbehind instead PG_reclaim to detect I/O congestion.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb



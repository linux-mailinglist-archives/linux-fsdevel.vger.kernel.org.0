Return-Path: <linux-fsdevel+bounces-32177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCAC9A1E05
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 11:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E04331C21B3A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 09:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069B31D9353;
	Thu, 17 Oct 2024 09:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hRpWs82L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70381D90D7
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Oct 2024 09:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729156650; cv=none; b=F/Hro+KaO+BJzirv8IyBPqGMoK0eQWH7TTa4/lOxIdywQzB4k+2yHIJGELsH79AHPJ6e14CEmdYyTkiKgBhx8TI68OkJmIG6UiZQrwHk+mRg0PmqZ3jJrT87P3AeEEuewZZQYR5myJqIrq5pCclyemqrqc2EXI8e70LCqYulMlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729156650; c=relaxed/simple;
	bh=oKjrXzkgRahBm9YgYsm12a15J1buLoTHkOyYj9ZLKg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sPQPbIIWQLW3K84oHC/x6D4lSHM/Y9dU9D5LtzHkGIHgJ8cDQxVI+BmNaXEOnPg4OBI2AumWj3/VSvjMd0n//SmjdCHCAiak3K+LzS40HsAcIdD2aUEBlELy9E8CvIIzoweOC//fdk21uYRV02Tv+JT+JZh9TwyAbfjQSDD6JZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hRpWs82L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729156645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Z2iv1vGKh4wlxyI1d63A6+aJrtUaUDwoToyYZfv5Jh8=;
	b=hRpWs82LO4jKM8/JMiHXFe37TBDlltAWO3H39WDOYYj0muaIy4QFoSQcbfk/9HNsHgwC5a
	qMCC9AaemqoJX/B2pIcO5fTTIa6Vpy38BFUqQwAuiRJI4DCuxMUwxmPaQeNzMEF+cBqHdn
	aIyC0MpzIzUVlj4zW8S2qoj+ZWRaFCw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-JMlgOqiUN3GJktNixZyBOQ-1; Thu, 17 Oct 2024 05:17:23 -0400
X-MC-Unique: JMlgOqiUN3GJktNixZyBOQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4315cefda02so2043925e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Oct 2024 02:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729156642; x=1729761442;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z2iv1vGKh4wlxyI1d63A6+aJrtUaUDwoToyYZfv5Jh8=;
        b=M5QFXnx+rVe2BoGIwm8dsjdXOJvDOfUrzjxqgGksCbadx46Hb42NLlRm6duqo6baiJ
         K+MxeHtXxQBP+oOjpS/dmCmCVATa925KaIglWaD4IMpuw1X+1HGfHScBION1FyK/0bSo
         FY9ro+sQSw7bJvRqZizr+qQ+IYDbu+GjhDkb6dfbMgzMzt/u5GjMui+lWfMb1Gu/hK5c
         w1cH8f+4uROdN+G+vkatHpO2X2duRQV/1BJSNKWMFRrLQLVbtTFy2GRjaHmQpBpEXxEX
         rkGCco0LdjMIpl8kER1V0XTnakW5nTWBsvfZ52kFoY4kDIS+XAi4ZZBKYfb4N4F1vGUa
         JwWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHP5Q/wvNqsV+9LYBYCz9EzHLrwKcvJg4Wt2QVhYf9IdWV/BLpSpht7qdwQjkN95U272n6qw/+zBTvbB4L@vger.kernel.org
X-Gm-Message-State: AOJu0YxBmiOosYjbEcLsd+0ExMAMR7yk/m/UXINMZHBHN9euTpi24NQ5
	B3tPdFekMH5Ve+o7CmNr4uM2K6yLU7jnJHQVFQ2bQj767oeA1tpOjadWvQR3LsRILJ6w/1VA+7I
	0ynvjx89ObKk6peO3+B7aha4TKNT6ekgwNcXl17OESFpvWNBTFHcoulNgC8gPeis=
X-Received: by 2002:adf:a11a:0:b0:37d:47b3:7b82 with SMTP id ffacd0b85a97d-37d5530a1a0mr12523374f8f.57.1729156641955;
        Thu, 17 Oct 2024 02:17:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFS62OhpSmQrgQCHpmVEc58+cHKX80vkIdArfgkQ3soXoC3Eohssh228PxnXny58LvmYnqYpA==
X-Received: by 2002:adf:a11a:0:b0:37d:47b3:7b82 with SMTP id ffacd0b85a97d-37d5530a1a0mr12523354f8f.57.1729156641499;
        Thu, 17 Oct 2024 02:17:21 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:7600:62cc:24c1:9dbe:a2f5? (p200300cbc705760062cc24c19dbea2f5.dip0.t-ipconnect.de. [2003:cb:c705:7600:62cc:24c1:9dbe:a2f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fbf814esm6615837f8f.68.2024.10.17.02.17.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 02:17:20 -0700 (PDT)
Message-ID: <d62bd511-13ac-4030-a4f3-ff81025170c1@redhat.com>
Date: Thu, 17 Oct 2024 11:17:19 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] lib/buildid: handle memfd_secret() files in
 build_id_parse()
To: Shakeel Butt <shakeel.butt@linux.dev>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Yi Lai <yi1.lai@intel.com>,
 pbonzini@redhat.com, seanjc@google.com, tabba@google.com,
 jackmanb@google.com, yosryahmed@google.com, jannh@google.com, rppt@kernel.org
References: <20241014235631.1229438-1-andrii@kernel.org>
 <2rweiiittlxcio6kknwy45wez742mlgjnfdg3tq3xdkmyoq5nn@g7bfoqy4vdwt>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <2rweiiittlxcio6kknwy45wez742mlgjnfdg3tq3xdkmyoq5nn@g7bfoqy4vdwt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.10.24 20:39, Shakeel Butt wrote:
> Ccing couple more folks who are doing similar work (ASI, guest_memfd)
> 
> Folks, what is the generic way to check if a given mapping has folios
> unmapped from kernel address space?


Can't we just lookup the mapping and refuse these folios that really 
shouldn't be looked at?

See gup_fast_folio_allowed() where we refuse secretmem_mapping().


-- 
Cheers,

David / dhildenb



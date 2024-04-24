Return-Path: <linux-fsdevel+bounces-17629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 844E98B08C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 13:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4043C28837C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 11:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709E515AAB3;
	Wed, 24 Apr 2024 11:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KYqRr83H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953DF15AAA3
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Apr 2024 11:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713959727; cv=none; b=uPHdr5ZtJV4Nyutea3ACztFcFnGweWaSqwIZuC4skUhFQMwAX71Yb7f0gmXXGZUT2b3BfXN+zi/G3c7tK8ec4/MkjYsmgrHHYXb6isr1XiBzEeV1MCT8t2FYPFdOBDT1/c0S5FMIaN6uiMCPo0y0TQebXd28RJic+nAS8h3BqzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713959727; c=relaxed/simple;
	bh=8K5zhx6yDCvJm1l41BT/kCYCU/emBpn32GX9Yy3CM9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ema90lAH5uyWYn53d/6TzP9rFCaLSu6TXys8uD3iDhMztyDQyiTQpvCFtNnEEY5zu1Aw/uf1vFx/aBUMkEqaeF5w3Y1q+tf8GHF3s53GcMKhvM64QDZ8+4X2976Uot/cWFxOhoMbHdvXvMC0RYWgMtNQyj3RRHGdJ3cIJuUtngQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KYqRr83H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713959725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9zT0IFJDVsNKakGu1Yx/bEyqtl1wWoC8Kg4VpGAhahg=;
	b=KYqRr83HABtkncSHwuQVf1dpNgXD2OnaVkzV8Ifun3mkE6xN9u67XPd3lbooIPIybCqXAz
	EB1UknnNYq7LkaXHNAZZO53al8OZTvnq3rEtZPWKXGHfGX5RRZN7+yy43GtnYijt+dudAO
	EGtefxRGzCDW2fnMjySuqNoktTUNM2E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-H_KKcxxoN6SG9iyXhcYSiQ-1; Wed, 24 Apr 2024 07:55:24 -0400
X-MC-Unique: H_KKcxxoN6SG9iyXhcYSiQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-41a1eb33994so16113205e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Apr 2024 04:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713959723; x=1714564523;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zT0IFJDVsNKakGu1Yx/bEyqtl1wWoC8Kg4VpGAhahg=;
        b=E3YXFJqSDp8MpDk3/faKu1CEGw4/ZI2GLm90WuBP2Gv/uEgSQuBGuPunQ6n0PiE97X
         ZYRY12/cEyF6WeA1UB2Qfr0YaowpMe/BKwhMk3N4pZYl5rkyt/WS/Vc8EpdJM3hhUkRh
         7iYQl5LeamxYmb5BbQ7Jbo2NSA/2m4K3QxuyAItrySWW63JEFn56VxIgPcE5NHA3vErF
         auLJCjLd93heOthyeJje0TBT3gcD2t5f/CTYitb3SOxrESztDdyyBrzwFLRZLaMHMbdd
         wWH3dwVY9kAY9pF9dJawIfSTR1fYG2lT6dCvPJNUX9n48VWTKqkoxqhYwlQynF6NKSbM
         xbDQ==
X-Gm-Message-State: AOJu0Yz5xJHIzRqUKoGxUgwgKXPtJVl1qNH1rGpaEdilB/vncGksObah
	IiNCdfKfzcWHEPKTMO7xd+zriQPUArYkjGzC93HlDUD2Ar2J4qvUqMcTtyvtQskwHlnRvh7a+DH
	G/ti2X56OeLQSWvZO/KcK2Xf+zsPvWCYVuj/WCqbZwAKmp1ApXYa5Nylt0AN/RRW3cfkhZOA=
X-Received: by 2002:a05:600c:511c:b0:41a:3369:6179 with SMTP id o28-20020a05600c511c00b0041a33696179mr2289442wms.26.1713959723168;
        Wed, 24 Apr 2024 04:55:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXZl+JvrX7Y7hTJQvM6mjeENPIODbxA04L5q02+eXTh0mx7u7TnzM1+bHZyOFXAJ6wYhbXtQ==
X-Received: by 2002:a05:600c:511c:b0:41a:3369:6179 with SMTP id o28-20020a05600c511c00b0041a33696179mr2289427wms.26.1713959722844;
        Wed, 24 Apr 2024 04:55:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:1f00:7a4e:8f21:98db:baef? (p200300cbc70d1f007a4e8f2198dbbaef.dip0.t-ipconnect.de. [2003:cb:c70d:1f00:7a4e:8f21:98db:baef])
        by smtp.gmail.com with ESMTPSA id iv20-20020a05600c549400b00418e4cc9de7sm23283826wmb.7.2024.04.24.04.55.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 04:55:22 -0700 (PDT)
Message-ID: <e1ac21f7-06df-4c24-bbf2-c49e72328db1@redhat.com>
Date: Wed, 24 Apr 2024 13:55:21 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] userfault; Expand folio use in
 mfill_atomic_install_pte()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20240423225552.4113447-1-willy@infradead.org>
 <20240423225552.4113447-6-willy@infradead.org>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240423225552.4113447-6-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.04.24 00:55, Matthew Wilcox (Oracle) wrote:
> Call page_folio() a little earlier so we can use folio_mapping()
> instead of page_mapping(), saving a call to compound_head().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb



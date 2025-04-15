Return-Path: <linux-fsdevel+bounces-46452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0867A8993D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 12:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8187188E904
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 10:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2940328F513;
	Tue, 15 Apr 2025 10:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="THRww4Nj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F48E28DEF7
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 10:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744711242; cv=none; b=UUI6k3n4D+ZQDkxLkL5TDW/t5r2vlFbAOi+PgwHeWJfA4l0IO18V/Z4x2tY0dsMjCtkQlLh6147CK4LEUka7GYcpiYeCiY2dfNu/U2q6RAXA0MtVgmtI3dtX92fcHn9dCHe/ej0XVd2vq1vP0WS69e0vaCmLC8WqNKf8eAr7KIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744711242; c=relaxed/simple;
	bh=Ih0rwTsgMwn2qHbqbjhFKJobk3RzLxITuqyzYdo1Mfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k7yCE6gnlNa+Jsv7SnmFf/n4DIIpl64zbWI3zhYRfvyi1YNfi/8Wj39NBMHvDX1xABwey1juGi5N5jOH5GP5P/ncM34B5mniYucMQx6UcukJdXfJSvUftTtDmqgiNcym7+RbWGelYSlsKECkwqNPpKumZYo+AYz2F/biujKvjF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=THRww4Nj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744711239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7mAeOW/b2ubB4qNjTwwEbjGSRwZqSyZVqpozBB+ugwA=;
	b=THRww4Nj4tv0fnOkPkVT0g0YWbeWYSOxCh/1Bp8ZWozycSAKYeyBg6jE/1PaSMqepgI1Z8
	XW0PL/ffbaMyVQh4jUHr+C2dMEhHPO1h6ZxPpFQux8UCFqe3tHOEjeYBqAdpiyF49ILRxw
	XGgrPb4UxAdUqHo3yJtPK/djKMJHSsU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-9ESJ7FmaNmOFxcpGE7pI4w-1; Tue, 15 Apr 2025 06:00:38 -0400
X-MC-Unique: 9ESJ7FmaNmOFxcpGE7pI4w-1
X-Mimecast-MFC-AGG-ID: 9ESJ7FmaNmOFxcpGE7pI4w_1744711237
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43d0830c3f7so40564795e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 03:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744711237; x=1745316037;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7mAeOW/b2ubB4qNjTwwEbjGSRwZqSyZVqpozBB+ugwA=;
        b=weTmk6YspCBWuXr7KX1o00phbpjfdvWhfsBWI8yF3sKhgIsu5A7KlrIBxDZPiun39W
         Ba/JkwKK0eVtx2O2emeE2kTaOF4WPsuR1X0imodpUECIwsL3TrHZ87TGvqYkN3naPD8Y
         LZuqCX1oEAhJru8XCx6Ffzh6OUqJ2lqAE//ZjRM1pLdjw96iwbQQr0C3qYIQj6hrwFKN
         guIHdSnlKWWTW7upJ3A+oxrmp44xgYtWJbOxHftBeYfMu5lOnXUEaFUIN6V/66/yVPvY
         8n4RfVI/kBMHpw+xvNU0v+ghg5BX3WK3U2SVaCimTJv1G4oK3hmPO92gPEyVJ/gu+Moa
         TV2g==
X-Forwarded-Encrypted: i=1; AJvYcCVHE0JZmUwc+lD7sgRZgqCiNwbEQEVYQmebVd+XXoNqEArcH6ekliFK+5U+CetzaJekExLYXvTWxSQNlgxF@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo1BEHl1rGhUz0Di5YiV2pK85NEFN/2S6JLX3mSNZYTqXGInpA
	JcBfAJcjwP4z9qcz0EqHMuZmSV8tecmvuLJ1KnhBuDnmx9jZRtwcB5VAU8U7AIiCi9kQ0P1f77v
	tCYyrVOEdNfEK2QIIkbVn1puI5QswclPcKHb1hf/7twkHKIAQDRdj4yz8+9t7Xu0=
X-Gm-Gg: ASbGncuKDhB/DfuoxYqTX5m321mluwhgdkj1ZP5yjnom7g7HSLK87+AMdBkmfV6JXLk
	HM6vvxAzQ8j42zzaPHdz+sWcXLmvBJaZDME0PrWW7fzOHSGqa2q6aL6weEgXgV4kK8IO0Cyhqyf
	oVeGHatKpufGp8IBnOWVCY/miT6Yp2n3w9sKDjbOscFR9dgLBIpmsIU0h/TCy41VJ2SmIMFxrrD
	FBg2+8lFBpNHA1rMLjVaW6EI9NYC6C39rT4q/O6RlUx8BnRkz27Ypd7eB6dlpXGpGSQlfzIB6Oa
	dZz/xG4LN4kiG8BPvWYCwj8qOV0nLPn307KBEhEOZdoMrjRvV2emEDCCZwdMUgkNMISct7H0ZKE
	+DMxR6PXV/aBtpFWMK9ZD/pWZOCOsuthrEPYwSA==
X-Received: by 2002:a05:600c:3113:b0:43c:fe5e:f03b with SMTP id 5b1f17b1804b1-43f3a9b5acdmr143132895e9.30.1744711236756;
        Tue, 15 Apr 2025 03:00:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFua0RrMbLY9ixZJsGuyoUtI/FvxeaQUjCr3cFk2q+7C5IW0Bap/mKr+ZFuPq527qax9dAqAg==
X-Received: by 2002:a05:600c:3113:b0:43c:fe5e:f03b with SMTP id 5b1f17b1804b1-43f3a9b5acdmr143132505e9.30.1744711236329;
        Tue, 15 Apr 2025 03:00:36 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f02:2900:f54f:bad7:c5f4:9404? (p200300d82f022900f54fbad7c5f49404.dip0.t-ipconnect.de. [2003:d8:2f02:2900:f54f:bad7:c5f4:9404])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2075fc78sm207798535e9.27.2025.04.15.03.00.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 03:00:35 -0700 (PDT)
Message-ID: <7ef1f10e-b835-4cd6-be82-0c92412e2ecf@redhat.com>
Date: Tue, 15 Apr 2025 12:00:34 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/2] mm: skip folio reclaim in legacy memcg contexts
 for deadlockable mappings
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc: jefflexu@linux.alibaba.com, shakeel.butt@linux.dev,
 bernd.schubert@fastmail.fm, ziy@nvidia.com, jlayton@kernel.org,
 kernel-team@meta.com, Miklos Szeredi <mszeredi@redhat.com>
References: <20250414222210.3995795-1-joannelkoong@gmail.com>
 <20250414222210.3995795-2-joannelkoong@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250414222210.3995795-2-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>   			/* Case 1 above */
>   			if (current_is_kswapd() &&
>   			    folio_test_reclaim(folio) &&
> @@ -1201,7 +1205,9 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>   			/* Case 2 above */
>   			} else if (writeback_throttling_sane(sc) ||
>   			    !folio_test_reclaim(folio) ||
> -			    !may_enter_fs(folio, sc->gfp_mask)) {
> +			    !may_enter_fs(folio, sc->gfp_mask) ||
> +			    (mapping &&
> +			     mapping_writeback_may_deadlock_on_reclaim(mapping))) {

Nit: Would have put that into a single line (we can exceed 80c where 
reasonable)

Thanks!

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb



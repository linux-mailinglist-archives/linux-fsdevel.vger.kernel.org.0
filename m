Return-Path: <linux-fsdevel+bounces-44866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C69A6D998
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 12:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 548833A90C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 11:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00E825E46A;
	Mon, 24 Mar 2025 11:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MK0DP0ZZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AB3BA53
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Mar 2025 11:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742817313; cv=none; b=bMvALZiVYMkb4SJSd98VPV+DBLojPJtDOTazFwstcBr87mPt+sIqyhsP4GVTlQXIddlMjBnW3/5vZVop8wYj+XqQSG/POcCEV90jxIvp+nZh4dK7ZXeifisSRy6YT9B3dBDkBub7gEsBTg+ngI7omVjsubnswFOvCywbEaJCLZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742817313; c=relaxed/simple;
	bh=0aYfIUc2aXBOdWiFJw2ve+BEVJO9t/pdyGnD0rTByV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a4K1ieeLazEhN3zuGfRHOYgb+BYo3GiBD9WIEwS+Iw++UiXqlTA3bibVp7GVo3/V/W+sqTxebA27RwOH8NxcVRHgQwzd321UFie5Z8MUTpM9iLsUUKbA253yc1AnaW8qLjF4JiGl3z+IzOIxwp6ePT3tS1Jg3jQojV9jMfGHnCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MK0DP0ZZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742817310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=N/mWgufSKxZcjFvRtGtAluf+mmnEUNmccTQzoSLEPJo=;
	b=MK0DP0ZZ+Fww+xO5H2NKI5a2QRyuL5gm35GVFChHJ20Eqr+19sHYwNGaoKmIjlUglwr8MZ
	iLSyiNLi5ZjStamIdKKF4DJjscx0YUlY9swdpgqZ5J0fKBvqnB5+/OkcA5VikMHp2bsXsE
	XPmSPrKzrZdyC8NfH3qQzr+8AnfBmDw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-AtX7FiY2MiC-xAN7LoEyiA-1; Mon, 24 Mar 2025 07:55:09 -0400
X-MC-Unique: AtX7FiY2MiC-xAN7LoEyiA-1
X-Mimecast-MFC-AGG-ID: AtX7FiY2MiC-xAN7LoEyiA_1742817309
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-476870bad3bso71248791cf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Mar 2025 04:55:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742817309; x=1743422109;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N/mWgufSKxZcjFvRtGtAluf+mmnEUNmccTQzoSLEPJo=;
        b=BUfyrZ22wk3uwR9wsrM/Xegs+eCShqkPwr0Nx/ptm7cZCXy8TWof+xvMCUsA/5LG8B
         vWUI9OulhSCMUTEFc1L93DO9Ak2MB/ENoSouyjpctitE+YIexYMPtaTmbFaBiTNKKoGd
         c99wNdGE4EnjP8lSY8j8lJcwXrbTcNRrweScsLR8rf4XdUVn5/MjIsKqD/wKNSB3phtt
         7+L+fp0JDw3A6YItV0WUT8vl1DJMMu+TO5dklvNHpQDNHwWB81h3DRen2VN6wKJCxTwT
         3WB4VKkdYH88eP6WBAmaojfGTZ43grySiV3S/sf2yvRLDXbg3eRtX6+i5CCO7FhECCCW
         kltQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDwTr9+8YsnmaQK4WGBw++M3DfDRqXcvD9f5juDs1YL53LwibrbGTh6LXX6Qbvc4C+uOZUyihL4wIQlyyk@vger.kernel.org
X-Gm-Message-State: AOJu0YwLw+kcp4mZbz21Wolf6S0zyBZQWT6xFjTQPCu2DLIAWmBsdKyw
	dGWsk0/Vi4+nBhBIj8N6zi0PwWA79Y5nZy76jj40lroGBgkIzHDaGTovegAyBWW8W7v5Ah2vNFm
	k/aWSs0xgkdlhuESe0zYaIOekPs0P9XOD8xHohhCjSvzdsZtQj05cNWiRce2PIY8=
X-Gm-Gg: ASbGnctLTj1YRzfZiDZjiV9oA1kSsY54e/gJHEaDgtCbDz7G8/ZaysMjFFlQgAzhwsn
	fCx3KyCr4iWax3BRuJfPtDuWP81aMX7jEcI+pfINO/Xb1ph0zUDIbbEeS3bnoHhkCyoOuqtBolk
	yPOzZ8H7iCTRYsP84zxB/GJZwEMKjilAzJYYtdXxp7u4omnObpStsxVflZiT1WIEEZVzQIjy5kS
	G6nXWteNYRngwv6W8LUL8BaRm/8NN/uMGB1shn+NN7VBjsGMN9DQFA/tLD6zrt3ZdHJp2okv6JY
	sQ1qheAcLf8q
X-Received: by 2002:ad4:5ca3:0:b0:6e8:9797:f94e with SMTP id 6a1803df08f44-6eb3f34460emr178872566d6.35.1742817308887;
        Mon, 24 Mar 2025 04:55:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQ+le9nN7sPrKfGN8U2wHmBTLgV+PHDtk7LyTbNYUZlAPQBSCgY7ucs38FPy724WOtICr/eg==
X-Received: by 2002:ad4:5ca3:0:b0:6e8:9797:f94e with SMTP id 6a1803df08f44-6eb3f34460emr178872226d6.35.1742817308476;
        Mon, 24 Mar 2025 04:55:08 -0700 (PDT)
Received: from [172.20.3.205] ([99.209.85.25])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3efc51f1sm43198896d6.84.2025.03.24.04.55.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 04:55:08 -0700 (PDT)
Message-ID: <da852e3c-3a71-4830-8284-faa836200c69@redhat.com>
Date: Mon, 24 Mar 2025 12:55:07 +0100
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
 <c21dbc6b-3f1b-4015-9aee-44979ef0233e@163.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <c21dbc6b-3f1b-4015-9aee-44979ef0233e@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.03.25 04:25, Liu Ye wrote:
> Friendly ping.

Likely material for after the merge window.

-- 
Cheers,

David / dhildenb



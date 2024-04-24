Return-Path: <linux-fsdevel+bounces-17627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A53F8B08B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 13:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AD822883D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 11:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E59215A4AF;
	Wed, 24 Apr 2024 11:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="US8fFKhe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F497158A0B
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Apr 2024 11:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713959661; cv=none; b=AZbyMUKXP/+r1EYjvbnzV+f/PMaaIwLaAXNl8y40rBi8PBsfuKIC9NJuSsrCrFCKDmOIA308TWQ5mAdUcvDBXPxmK7vfIxzpDM+vtvd9CxOY2bhQ+uUdVJ0+uz7FfZczwjNNdPLOv8eA49PwKRYIGRYOeC+e/dzO7rBDscSiGdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713959661; c=relaxed/simple;
	bh=8en3hpBWhpMlpKxg5LUumWogtEzXk0aX7muj23S7iK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oaKWV3kjTE89av0E+gMklrNe4ONBfxnvhhWmVGztjxQQN4TuZv1PPwk9u6fAuyG7E3qU/iOahhnnarTX02DMpf2vIl+/5a+WKaZ1wU3aQefUmg8LJMOlnfWOBivgylnHUWoE6yNTgJducKF3wCI6dRy69rbOEFNJk1h14zuek44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=US8fFKhe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713959657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oiEdD1jUhHpGlDgtp9e4uee9N7LMbprET2o2Fr27svE=;
	b=US8fFKhei0fuHuFghoEhojtD9GMFku3IWqNoYIafxNy+orWBjMxM06nVP84TtFsBJCVcZH
	e6Q2fFN2Pw6mOKv53+zXMlVNvjU1ujj3TyCuM1CED+lHl/If3IjIcfF2dUw/g1wJcxjSB0
	x+4F3VaY90TYPt2Ar9N1QTFB2ypl4f4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-DWay2jPJM8q4GZ7eOSJcNg-1; Wed, 24 Apr 2024 07:54:16 -0400
X-MC-Unique: DWay2jPJM8q4GZ7eOSJcNg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-41a54b30c86so16513215e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Apr 2024 04:54:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713959655; x=1714564455;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oiEdD1jUhHpGlDgtp9e4uee9N7LMbprET2o2Fr27svE=;
        b=m2N6hH8r8P+Z5/b0iKiY1uZ/8GQO8Ry5D5ibETO9yW9m1YvyPQ8M39IyjYCOUQp3ia
         6q4NDH0coFyMH1FymxOeeqnKfXeNbW4ohqllcPJWApxkQ30D+HYJX1X3dWg/8xS57A/4
         diY69LmDrM+R/ZAxACyWYa5nRHr1FaSwR5EVLfOsdIWBD7tV94753a/bXZOk1kULQzjX
         f8SZMTGf7NIX/XHtZxdGDI2eMnN2elgsGgfH0vXX3g8PF9nBrrgv7U6pzw1XOzs8Mfhg
         ayXZGsqRlqS5zLsOkpiC32vpgo9DFR+SQ04hJ3lAHsBDFuNZR1ttrk5zw3sbIvVqaiY2
         fR0g==
X-Gm-Message-State: AOJu0YxTz6m0VNXSfoj9t8z1NM3xq7NaBgXV1o+cLeywB+wv7mhN1mgc
	LkR/EK+OP3gmRho6koAyuURO73ZiAeqOWBtPQALSoSjLfU/Csu8DQNZiRmR3rkbiQYnqs++8ZuA
	XggsomGlgOGxgH61X4Fms1q/5+UW3nmxx72UAdKVws4XIOgJWWx6enTZdxCrTR6R+T+JvxH0=
X-Received: by 2002:a05:6000:18ad:b0:342:a8db:603f with SMTP id b13-20020a05600018ad00b00342a8db603fmr1916968wri.26.1713959655090;
        Wed, 24 Apr 2024 04:54:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3cxU6Cgdr2fSSlc7NQBh2SZDnkgqXrrYX0qBaSBo/hicEaOwpxmPbCH103VYTA0dC2rxbrA==
X-Received: by 2002:a05:6000:18ad:b0:342:a8db:603f with SMTP id b13-20020a05600018ad00b00342a8db603fmr1916956wri.26.1713959654842;
        Wed, 24 Apr 2024 04:54:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:1f00:7a4e:8f21:98db:baef? (p200300cbc70d1f007a4e8f2198dbbaef.dip0.t-ipconnect.de. [2003:cb:c70d:1f00:7a4e:8f21:98db:baef])
        by smtp.gmail.com with ESMTPSA id fm13-20020a05600c0c0d00b0041b0ade42b1sm1569357wmb.7.2024.04.24.04.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 04:54:14 -0700 (PDT)
Message-ID: <b9685104-0f2d-4689-b4f5-2d4cea5c63d3@redhat.com>
Date: Wed, 24 Apr 2024 13:54:13 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] memory-failure: Remove calls to page_mapping()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20240423225552.4113447-1-willy@infradead.org>
 <20240423225552.4113447-4-willy@infradead.org>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240423225552.4113447-4-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.04.24 00:55, Matthew Wilcox (Oracle) wrote:
> This is mostly just inlining page_mapping() into the two callers.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb



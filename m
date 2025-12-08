Return-Path: <linux-fsdevel+bounces-70975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2CCCADC7C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 08 Dec 2025 17:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A70FD3014BE3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Dec 2025 16:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F87B1EB5E3;
	Mon,  8 Dec 2025 16:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AgYLjQN3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F77520322
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Dec 2025 16:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765212429; cv=none; b=nAEDxExwkXCwBA8if7xXXtyOvDv43aaPg+vIxTOQJj4Sia1wBfW+yeXmkFdLxvjdW3hQMlzZFWaQjEPpfwaM4BBWzNBIk64NqHoTl9jcxK6WCj3o0aXQpMLTEZbWyKEwJnLo/Av0RTGJu0WXSZRHKXAuKQ6U/VaBef+3JiL9jUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765212429; c=relaxed/simple;
	bh=yTq0LKrarkdXvIO0tZ1H6xJySqjSUdTNygcNC164iwY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pUcB/ohx89rik7zRNQfy0Lyf3VR+uSaB0FAOGKFpOBLKbavGQsG1SAiPI5uf+O20HamrqCXh0A2VtTQq+hKkPkXIRdQHRDmmGnnEwxmrWulCWpTLyEP07jwZq49BnO2k7b90EuNe32wSmKoQMHF428jMskI+gk6Qv7RuAAc4e9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AgYLjQN3; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7b6b194cf71so7866840b3a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Dec 2025 08:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765212427; x=1765817227; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y21xYnymZNnyNmi/HtnuQMz5IMpcwyYducXo/2wK1DU=;
        b=AgYLjQN3GFcE4C9S0coiJnGB0WfSHAFLD7Y8c0/toiRNfww1BJV+uNuuXuR0bK8UyF
         h46usM0ERN4tJIlEF3+J2sMEyNy2EtIheR7a6gAFLqNzBER17EfqT/Y/EzDLXQyJEG4V
         yWHejEXWCbTBfLIzS4SsEIBodRbuXKhCyEkH9wY3dmO0sHgLRBLl3DGytuoRRe/BsurN
         /OtpaidtiTjAN+Zjk/i0fdA56b1/hPNZAmtsyJB+LH5GEQmKylZPaRnoz4wXmKgwHuqu
         A3y2EFjwxF96awOv4piyfszi3+rsARnRNOAaX67Qit/Y/GTc7uyGKDPN7ihK8pkwzyzN
         UITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765212427; x=1765817227;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y21xYnymZNnyNmi/HtnuQMz5IMpcwyYducXo/2wK1DU=;
        b=OcaLVQu759R6YNfJhHPsnAv2GYdmW1m2a5brqrHRoEua1gRChP5UyVugT8i8BDSbDy
         DFV+TuXBY/5Y0681tozS+2f5ILdgYjitk+hZS/1dECfL1eOuU6hqG3ppRjDyaVMSOjiz
         A6kpZEZj54tf2Ay8qkdIRIhK23CSp1Ioc2/MeHGuPJEd5OBdW+ZqtsY9E2wITFTB/YUe
         yHo/rZFkyZLxt3tOVG87lqbF1IMvaAD/MLnKx73u3pv5aBtksTm3k0I+P4MB8Pc0Ykav
         XrV0/IiKtu9HiFKp4RuP5R/6Flosf4EgXv7pakaNgBcrFOeTv4nJ0Zfhbujt2LwRPUBx
         YQSg==
X-Forwarded-Encrypted: i=1; AJvYcCWeiwQtyEYGd329UPmvVmRVs9BRWBbkN/NdA7c9pCtgJB/E7ghZL+VkAyUkLuzo71ewX83UXffPRgC6VIJf@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmd4vlDmGoCRoCA39Dlju42EfA8jsBHOMbNzpIwnODh3vrOSrO
	DEvvZTn+r9x9InIMThBOLphfM+dp/deltcQlBQLHHd+bnB0uxJq4/xnjd3hA9PD6dnvar1PYI4e
	eIViYLdKzdYDdlJnriMq4905dYg==
X-Google-Smtp-Source: AGHT+IE5FQZIbtJOztigBOS9Avg82hSfSlcy7E3hwkLPHM/P7YdR0xqCIo+8j17gC4LIdPH64C7KVQUZllrbHiWF8g==
X-Received: from pghx12.prod.google.com ([2002:a63:f70c:0:b0:bac:a20:5ee0])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:3d85:b0:35e:d74:e4b6 with SMTP id adf61e73a8af0-36617e37d65mr8176588637.7.1765212427234;
 Mon, 08 Dec 2025 08:47:07 -0800 (PST)
Date: Mon, 08 Dec 2025 08:47:05 -0800
In-Reply-To: <E3AB23B6-9B6C-432C-BD92-27520ADA0739@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251117224701.1279139-1-ackerleytng@google.com>
 <20251117224701.1279139-5-ackerleytng@google.com> <E3AB23B6-9B6C-432C-BD92-27520ADA0739@nvidia.com>
Message-ID: <diqzy0nc53au.fsf@google.com>
Subject: Re: [RFC PATCH 4/4] XArray: test: Increase split order test range in check_split()
From: Ackerley Tng <ackerleytng@google.com>
To: Zi Yan <ziy@nvidia.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, david@redhat.com, michael.roth@amd.com, 
	vannapurve@google.com
Content-Type: text/plain; charset="UTF-8"

Zi Yan <ziy@nvidia.com> writes:

> On 17 Nov 2025, at 17:47, Ackerley Tng wrote:
>
>> Expand the range of order values for check_split_1() from 2 *
>> XA_CHUNK_SHIFT to 4 * XA_CHUNK_SHIFT to test splitting beyond 2 levels.
>>
>> Separate the loops for check_split_1() and check_split_2() calls, since
>> xas_try_split() does not yet support splitting beyond 2 levels.
>
> xas_try_split() is designed to only split at most 1 level. It is used
> for non-uniform split, which always splits a folio from order N to order N-1.
>

Thanks for explaining! In the next revision, I'll rename

  + check_split_1() to check_split_uniform() and
  + check_split_2() to check_split_non_uniform()

in an earlier patch before, fixing the wording, in this patch, to be

  Separate the loops for check_split_uniform() and
  check_split_non_uniform() calls. Expanding the range of order values
  only applies for uniform splits, since non-uniform splits always split
  a folio from order N to order N-1.

>>
>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>> ---
>>  lib/test_xarray.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/test_xarray.c b/lib/test_xarray.c
>> index 42626fb4dc0e..fbdf647e4ef8 100644
>> --- a/lib/test_xarray.c
>> +++ b/lib/test_xarray.c
>> @@ -1905,12 +1905,16 @@ static noinline void check_split(struct xarray *xa)
>>
>>  	XA_BUG_ON(xa, !xa_empty(xa));
>>
>> -	for (order = 1; order < 2 * XA_CHUNK_SHIFT; order++) {
>> +	for (order = 1; order < 4 * XA_CHUNK_SHIFT; order++) {
>>  		for (new_order = 0; new_order < order; new_order++) {
>>  			check_split_1(xa, 0, order, new_order);
>>  			check_split_1(xa, 1UL << order, order, new_order);
>>  			check_split_1(xa, 3UL << order, order, new_order);
>> +		}
>> +	}
>>
>> +	for (order = 1; order < 2 * XA_CHUNK_SHIFT; order++) {
>> +		for (new_order = 0; new_order < order; new_order++) {
>>  			check_split_2(xa, 0, order, new_order);
>>  			check_split_2(xa, 1UL << order, order, new_order);
>>  			check_split_2(xa, 3UL << order, order, new_order);
>> --
>> 2.52.0.rc1.455.g30608eb744-goog
>
>
> --
> Best Regards,
> Yan, Zi


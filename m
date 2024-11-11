Return-Path: <linux-fsdevel+bounces-34261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D34729C4236
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 16:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C4D9B2712D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 15:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5E719E99C;
	Mon, 11 Nov 2024 15:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ASQzsI++"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C3D142E6F
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 15:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731340642; cv=none; b=ds75WScQnGmK/rWb904fIrFZyrWsaTy1pn3wmbyyrCe6HSTv4VvB5Kd7P0WuDPQxIyxrfSjNrIoVlEx0hW55DEytw99z/V2W+pBsp/s/jrR0OkbeuO94BBPfLK84nZviIzv3APhYDylMkYBA6SC+bsseAYijcHgX4yz7RNiyMmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731340642; c=relaxed/simple;
	bh=/Ezjw7iweKivIIad7vOgJKgtvb4WVv8UnM9lGfTv6Sw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b9H3pLuhG85TEWS1w1yAWfxtdWWkFBDPeZytI1w1uR4h+7l/jnvmnlCig1Xq7kHOV2QIDCwPbrzKTQZ4xACCHQLuuV6ra9W7eUqqQDZdSieORK2o3VAGu/+VULa5XLLgVWLm1E+mO+kABeOb2P0eBHGJV8eic09LujqMnChiSfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ASQzsI++; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5ebc52deca0so2313948eaf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 07:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731340639; x=1731945439; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ju3j5igJOosMwn70qDznK7zcecUMPNasKKnWD2d241M=;
        b=ASQzsI++4fC+THxAREH0hheEtWa0toeeo5LgkTR1+2NYGzmOrKS9GjUmcOKZC/gxdP
         ptI5M7h1XlTvvkq+QSKqKQR6VWxpGyCpgBAMp6Hlc/bZDVmAUwwcafaoACAyH1v5Levw
         8gZtOzoOoDJ6v4g0GJ73lHfoySHKV3BcuSy1KGO1Utn8WiSw92tpyyBDDWcjn+QrqGQS
         2FM3cLmdW/7N8nhNG8ZrXYCRGhoED9svuiGo6eTCLnDfvsiOROC3MYU0PXmfRNXUfaZu
         dio6ZXwFNuO7iZdlb0VKbcLmkfVZnu+WQBhsu6tQu91n2dXkWNLl4VV/7GYv7uFhs0FM
         XXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731340639; x=1731945439;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ju3j5igJOosMwn70qDznK7zcecUMPNasKKnWD2d241M=;
        b=cArxjvo7vHR5dTIW79ye9KKRwRJ4TaCgtCS35ollDC3PZeH3hbJ5U9QXo9i/TJmmDP
         ZfKi8p55hLsn7BZLU1kTHVsvmByjkyKsmuOk/T+FfKwkCSmVxKxKMF3l3tIyZyCliXed
         FIks9U7dM93zhg/zJe9iIGp6y2DUpPNoeNUtrlxpylC/F/jJ2CdPdca76K/3Id30X7Rp
         BQ1MwfUg3xhB+WebP9ImaVzMcB5M5ATPAt8fXZmRMTXGFGhIVWt5s322DFcO/6GQ27FL
         TY5ZPP0QWQWiQpWUB8u8YNdWrAh8KFIDfWd3vTFZjUPOxadCGXtBr5ITOfrOPvJXt0yo
         S98Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUqciDvHkrWd8Fw036CDbS3dmJsi4fYhx4P504RAuhHaKawpeIv8064nDaxA3yLgMj92yHVrv2fhn2MPCi@vger.kernel.org
X-Gm-Message-State: AOJu0YykM5GLRMB9Hmzk70WqK8DLi73YBBjv62w2lhUEGJTca+0+D6DG
	FojidifsxPYjoRuWKyi3Zd8Kaxadoo1KNOA/JPI/zAefoePpZxMHPCCUUlnB0Eo=
X-Google-Smtp-Source: AGHT+IGaR1PqbbjtaiXdsjeWdZcHVhMIc95tbonrmfCgnNUfOPReGyI9Wcp+ZBXIqvomwXE4PDwxzA==
X-Received: by 2002:a05:6820:179a:b0:5ed:feae:d5bd with SMTP id 006d021491bc7-5ee57cc4966mr8725265eaf.3.1731340639428;
        Mon, 11 Nov 2024 07:57:19 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ee4952777fsm1975301eaf.26.2024.11.11.07.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 07:57:18 -0800 (PST)
Message-ID: <9f86d417-9ae7-466e-a48f-27c447bb706d@kernel.dk>
Date: Mon, 11 Nov 2024 08:57:17 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/15] mm/filemap: add read support for RWF_UNCACHED
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
 clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org
References: <20241110152906.1747545-1-axboe@kernel.dk>
 <20241110152906.1747545-9-axboe@kernel.dk>
 <s3sqyy5iz23yfekiwb3j6uhtpfhnjasiuxx6pufhb4f4q2kbix@svbxq5htatlh>
 <221590fa-b230-426a-a8ec-7f18b74044b8@kernel.dk>
 <kda46xt3rzrb7xs34flewgxnv5vb34bvkfngsmu3y2tycyuva5@4uy4w332ulhc>
 <1c45f4e0-c222-4c47-8b65-5d4305fdb998@kernel.dk>
 <bi5byc65zc54au7mrzf3lcfyhwfvnbigz3f3cn3a4ski6oecbw@rbnepvj4qrgf>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <bi5byc65zc54au7mrzf3lcfyhwfvnbigz3f3cn3a4ski6oecbw@rbnepvj4qrgf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/24 8:51 AM, Kirill A. Shutemov wrote:
> On Mon, Nov 11, 2024 at 08:31:28AM -0700, Jens Axboe wrote:
>> On 11/11/24 8:25 AM, Kirill A. Shutemov wrote:
>>> On Mon, Nov 11, 2024 at 07:12:35AM -0700, Jens Axboe wrote:
>>>> On 11/11/24 2:15 AM, Kirill A. Shutemov wrote:
>>>>>> @@ -2706,8 +2712,16 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
>>>>>>  			}
>>>>>>  		}
>>>>>>  put_folios:
>>>>>> -		for (i = 0; i < folio_batch_count(&fbatch); i++)
>>>>>> -			folio_put(fbatch.folios[i]);
>>>>>> +		for (i = 0; i < folio_batch_count(&fbatch); i++) {
>>>>>> +			struct folio *folio = fbatch.folios[i];
>>>>>> +
>>>>>> +			if (folio_test_uncached(folio)) {
>>>>>> +				folio_lock(folio);
>>>>>> +				invalidate_complete_folio2(mapping, folio, 0);
>>>>>> +				folio_unlock(folio);
>>>>>
>>>>> I am not sure it is safe. What happens if it races with page fault?
>>>>>
>>>>> The only current caller of invalidate_complete_folio2() unmaps the folio
>>>>> explicitly before calling it. And folio lock prevents re-faulting.
>>>>>
>>>>> I think we need to give up PG_uncached if we see folio_mapped(). And maybe
>>>>> also mark the page accessed.
>>>>
>>>> Ok thanks, let me take a look at that and create a test case that
>>>> exercises that explicitly.
>>>
>>> It might be worth generalizing it to clearing PG_uncached for any page cache
>>> lookups that don't come from RWF_UNCACHED.
>>
>> We can do that - you mean at lookup time? Eg have __filemap_get_folio()
>> do:
>>
>> if (folio_test_uncached(folio) && !(fgp_flags & FGP_UNCACHED))
>> 	folio_clear_uncached(folio);
>>
>> or do you want this logic just in filemap_read()? Arguably it should
>> already clear it in the quoted code above, regardless, eg:
>>
>> 	if (folio_test_uncached(folio)) {
>> 		folio_lock(folio);
>> 		invalidate_complete_folio2(mapping, folio, 0);
>> 		folio_clear_uncached(folio);
>> 		folio_unlock(folio);
>> 	}
>>
>> in case invalidation fails.
> 
> The point is to leave the folio in page cache if there's a
> non-RWF_UNCACHED user of it.

Right. The uncached flag should be ephemeral, hitting it should be
relatively rare. But if it does happen, yeah we should leave the page in
cache.

> Putting the check in __filemap_get_folio() sounds reasonable.

OK will do.

> But I am not 100% sure it would be enough to never get PG_uncached mapped.
> Will think about it more.

Thanks!

> Anyway, I think we need BUG_ON(folio_mapped(folio)) inside
> invalidate_complete_folio2().

Isn't that a bit rough? Maybe just a:

if (WARN_ON_ONCE(folio_mapped(folio)))
	return;

would do? I'm happy to do either one, let me know what you prefer.

-- 
Jens Axboe


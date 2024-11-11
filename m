Return-Path: <linux-fsdevel+bounces-34241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 506D39C406F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 15:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1368B2198E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 14:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D1119F118;
	Mon, 11 Nov 2024 14:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MsjPSJoV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A9E19DFB5
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 14:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334361; cv=none; b=SybavocW0Ve3MVMNIhyAkZ3XZ/dRylSY87QkJviLx8wme2YKT+lvgjLjit0RY4fVeoPQ1k61z1cmwC9pUh3spBCYZVQjArgyEOz20NIU0KZkOTz6vM59516p3mYv8u5xRxe8PsgH4I8amNqS+5b+VfE3KNRm7LBYSBa0HlgNUEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334361; c=relaxed/simple;
	bh=y6v1Vwuu9NHE+26R0D2cweNBEfu1yKI914fpXfcyO8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pQJZtWTpK7bYpM2cyxNCtfvG/V+SDZQs4TYGAQRBubrRDfPFEU0M9JGRDSqdZnsQMuUkNVU+V2EqO7MzfFm/jlxQkrMANDFWh4qlrgRRVsrYJn+h0wW36zU2A+NxjufDqGzFmYRlkypddhZ1W+0SZIPi1abqSEILgbcUzOll5PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MsjPSJoV; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-288d74b3a91so2888203fac.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 06:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731334358; x=1731939158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=66uLGc0gYWY6pl4vJKWVk60NF3N9pYxdiSnhiB0bZ+0=;
        b=MsjPSJoVwuhF1WW5SDMaDgeQ5JqU1coxJVfH+ybEFTggL1ldPexTOL03JW51I8WTdQ
         YmzlyIS2QZGcgLHaoR29v9C2EtWEgGgLdwpa+17XwdIFB/XEXK/COvmWfYpwokL3cyKn
         NtH47dvKcb0gYzk4uUnXaMn10RQ7/c5TyKlzsbr+6L33Gz487Nv/AjPnw1+15ZnTr3aH
         sThIWjCWqM7iYAyeUQwB0zMupzLf9M5iS73o3A3Clov5RXZZ+X/QkNU3X1DujJWnZ6BT
         am/CGsYEitUi1bCTzLuaAmmcieGGKumtt/U2/cExA4ZIfehIrojGTb77JfgVHn//Pdkf
         dk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731334358; x=1731939158;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=66uLGc0gYWY6pl4vJKWVk60NF3N9pYxdiSnhiB0bZ+0=;
        b=eeM1SHoI/+ooU5+27CDVNwkRa5vpbmjc83WuTDVaQupZb0GYoYBX2zZP1e3sI4GzRW
         VvFoHLQRYowOC7HClof72h46Z2phGdnqcCREcbsPLg11Sh353TJv+c52WLFmt4i0OxX8
         WJ+lrQIIuyh+MZTDPXB6lkTSWeeIln4DUPCIlXKpAT1lwBjhllWU2lnfU5kaGfq551hV
         +2TrRKuuIJl/fHt2U0a2XH2rp4tZmA99CdPZs42UgrRSpCZvmgrYmsWuP5DavVG0Ry0G
         YCZbef89vsDCEJqRfLpG3GzherYDkgE5Wl6l99T8TtAkers/7A/lMvrXwOsd6oYlrOtX
         UvZw==
X-Forwarded-Encrypted: i=1; AJvYcCXIlrh2F/KG2/91yz+ZQDGe/ASkThU2mMfVjPEfR2G4cLgBv63arrOjxNaJjLkB8stI81X2IaT/+aFlsfHN@vger.kernel.org
X-Gm-Message-State: AOJu0YwciufKdtgfEDcw63busuHL30vC/ALZ/0eAHaGj+tJGmM/3FnEN
	55s8sWl0FaN+msA3VEpud8F9MHHmQf71r7Z0YL3TbA45OyaB6ZoeQpKRCXyXkPk=
X-Google-Smtp-Source: AGHT+IHWv0kv6W+zOTjySZdLHaaUykzq/EEMfTz+FtiPzYyUcdtRJI2JmM+5cYpADP+e2ShIZZv6SA==
X-Received: by 2002:a05:6870:d8cd:b0:277:d9f6:26f6 with SMTP id 586e51a60fabf-29560063fa6mr11114760fac.12.1731334357158;
        Mon, 11 Nov 2024 06:12:37 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29546f4ff2fsm2787996fac.51.2024.11.11.06.12.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 06:12:36 -0800 (PST)
Message-ID: <221590fa-b230-426a-a8ec-7f18b74044b8@kernel.dk>
Date: Mon, 11 Nov 2024 07:12:35 -0700
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
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <s3sqyy5iz23yfekiwb3j6uhtpfhnjasiuxx6pufhb4f4q2kbix@svbxq5htatlh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/24 2:15 AM, Kirill A. Shutemov wrote:
>> @@ -2706,8 +2712,16 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
>>  			}
>>  		}
>>  put_folios:
>> -		for (i = 0; i < folio_batch_count(&fbatch); i++)
>> -			folio_put(fbatch.folios[i]);
>> +		for (i = 0; i < folio_batch_count(&fbatch); i++) {
>> +			struct folio *folio = fbatch.folios[i];
>> +
>> +			if (folio_test_uncached(folio)) {
>> +				folio_lock(folio);
>> +				invalidate_complete_folio2(mapping, folio, 0);
>> +				folio_unlock(folio);
> 
> I am not sure it is safe. What happens if it races with page fault?
> 
> The only current caller of invalidate_complete_folio2() unmaps the folio
> explicitly before calling it. And folio lock prevents re-faulting.
> 
> I think we need to give up PG_uncached if we see folio_mapped(). And maybe
> also mark the page accessed.

Ok thanks, let me take a look at that and create a test case that
exercises that explicitly.

>> diff --git a/mm/swap.c b/mm/swap.c
>> index 835bdf324b76..f2457acae383 100644
>> --- a/mm/swap.c
>> +++ b/mm/swap.c
>> @@ -472,6 +472,8 @@ static void folio_inc_refs(struct folio *folio)
>>   */
>>  void folio_mark_accessed(struct folio *folio)
>>  {
>> +	if (folio_test_uncached(folio))
>> +		return;
> 
> 	if (folio_test_uncached(folio)) {
> 		if (folio_mapped(folio))
> 			folio_clear_uncached(folio);
> 		else
> 			return;
> 	}

Noted, thanks!

-- 
Jens Axboe


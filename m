Return-Path: <linux-fsdevel+bounces-34090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 400A59C257D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 20:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78B3A1C22A3B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 19:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916221AA1CD;
	Fri,  8 Nov 2024 19:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="L7wH1N9k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E79E233D83
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 19:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731093783; cv=none; b=iZMsvS6Wz7gm4Ulyglg4j5AjJB/xUBGAkjyuIFOuC2uwR+eqapcq6+TRw+9yQm2VSb3lHqmppH32nX3y5fGZLqwtmTfF+gQllGG4h95cLMvx90IzV8eby/xDPVrv8yaD+/dZs//TaGLnN4ZXuGOhlYKkvML3yJCeBwUitLzoSjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731093783; c=relaxed/simple;
	bh=IAUJIwBdYWKtBE0Vnmi7VVdntZtwfeaeU0vVOBR4Wjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ueLR9dqG5HbRH83FrX0q2kB0VUX0HDcPZOE9yJzJ1sJZy7sNepG6k8q0uYtbpb6QlMtDyRcKlH5JomLdMHhm6nKBhE+LgzsRoS7P90LTGQODiCoTzPHwdvnwBdiXI2CTLQ8XMRoI83F5ciC3kaYL3AjEREGYXuGnM7VMDWVfY8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=L7wH1N9k; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20c803787abso22103505ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2024 11:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731093780; x=1731698580; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0WHvEPzIuaCnloxy5m0FklyFacTs1MbmOXmxDfeZH5M=;
        b=L7wH1N9k+K525MaDLKhxBFrM1oCn6BFGIVSA8UdvkWQYzDEfmogPWaTiGoDq1w997r
         L+SrQSFiJceUjt6ehXxjdS/dVf5O0W19bXTgdtXwCUyiAQEWdtwqLooAMKYYlIVNSGwi
         +ADbrJ0fGimhxRx/SNhKZil/xPHurjYIoQNIhPqcgGciJIg7tIJ5j2fF5W55skSLaITG
         EHJzbbMAPFFTNJrscu9GpdBTNQoUYdIUumBLxH8kC3v4WWbPdZ/JtrRFbHt7zw7iB8Am
         CDFUAwRZumZJVFKGItfcn8+fhm/dc3EfjadAXePdd+JmQ6fwnNzY1CSwQXzF867cu+LF
         WpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731093780; x=1731698580;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0WHvEPzIuaCnloxy5m0FklyFacTs1MbmOXmxDfeZH5M=;
        b=LgtHjtzRY9Gye1Snv6nqNFMjCcExktYRe1mD9pdDkupxbCMjbPAzN+cdy+9/8U5xVC
         0b9sc695PHDED5VYeKKY8HOoH2dsu37d6DPv/nafrdTMoXnup2baqPKhtgJCSRtXsX4i
         I/DF2x2cnkYfaeQ30f91MQddCeA7UgIbFdEcSjYtshkws0qcXARvP8XGfKhN4X8r3dM2
         moVlDfvr+7cyp+/FpdvSc36INe2ZsHgipmaV0LH/XAofAf1vYH4ibI6y5HAxTah/p48P
         Iqj6y9dCstYXvxj9TNuON1WdXLdjoI1ClcwAMdGA1rA7HZIXzlkk9XEr2LXl9enQAiby
         MleQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxlYJJtbhnKL/kcjzGYaDNtejsSHX88lsH77X/LiN+kGqJe+ldwp0CCuWpJJpMDeclb22UE4rGm76DFQb4@vger.kernel.org
X-Gm-Message-State: AOJu0YxYwK013hx//cR8Gc9wiHNBH4NuGYHKhCzNfCJ7R8ZJIRchklaY
	0sL3dF6UbfBV+OLuoilJgJ7FdmkFvw1mWt1xLpZiOnL4uEufodDLK0aHcglX0yQ=
X-Google-Smtp-Source: AGHT+IH5C0D4ueeoqV9ISt39iXPf8LxCV5vetd5L0Cqq3YdVf2ODnHsEYmqvjt7hO0+vEYelcHAarQ==
X-Received: by 2002:a17:903:945:b0:20b:a9b2:b558 with SMTP id d9443c01a7336-2118223b6b4mr62359465ad.28.1731093780491;
        Fri, 08 Nov 2024 11:23:00 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177ddf2b8sm34454365ad.91.2024.11.08.11.22.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 11:22:59 -0800 (PST)
Message-ID: <ca1f78bb-47e2-424b-a57e-f3272b1450cf@kernel.dk>
Date: Fri, 8 Nov 2024 12:22:59 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] mm/readahead: add readahead_control->uncached
 member
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
 clm@meta.com, linux-kernel@vger.kernel.org
References: <20241108174505.1214230-1-axboe@kernel.dk>
 <20241108174505.1214230-5-axboe@kernel.dk>
 <Zy5Wl84aHADMe8MQ@casper.infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Zy5Wl84aHADMe8MQ@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/8/24 11:21 AM, Matthew Wilcox wrote:
> On Fri, Nov 08, 2024 at 10:43:27AM -0700, Jens Axboe wrote:
>> +++ b/mm/readahead.c
>> @@ -191,7 +191,13 @@ static void read_pages(struct readahead_control *rac)
>>  static struct folio *ractl_alloc_folio(struct readahead_control *ractl,
>>  				       gfp_t gfp_mask, unsigned int order)
>>  {
>> -	return filemap_alloc_folio(gfp_mask, order);
>> +	struct folio *folio;
>> +
>> +	folio = filemap_alloc_folio(gfp_mask, order);
>> +	if (folio && ractl->uncached)
>> +		folio_set_uncached(folio);
> 
> If we've just allocated it, it should be safe to use
> __folio_set_uncached() here, no?

Indeed, we can use __folio_set_uncached() here. I'll make that change.

> Not that I'm keen on using a folio flag here, but I'm reserving judgement
> on that unti I've got further through this series and see how it's used.
> I can see that it might be necessary.

I knew that'd be one of the more contentious items here... On the read
side, we can get by without the flag. But for writeback we do need it.
I just kept it consistent and used folio_*_uncached() throughout
because of that.

-- 
Jens Axboe



Return-Path: <linux-fsdevel+bounces-37223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A136E9EFC94
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 20:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58F1C28C0B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 19:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB18192B9A;
	Thu, 12 Dec 2024 19:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="mDLSo9B4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64F1183CD9
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 19:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734032213; cv=none; b=eMMZaV37IrYJi6XDf3bfPeaZ2Nx0Kled1Fh6l9amY51HITPPqan9fqc6b7MkpCDOKsKtu+WFqQAT98nRCyuuqv+Qqk+V1qOe3Xxpqs1hX3+nOOOkd+93IxMORQbQhfQxHB8O2r5yqVhGc/wE35/CqCyIXm5NjJ2lcUu3LieqHWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734032213; c=relaxed/simple;
	bh=hN40wVujLck1OPcPBoMWv5wRDTLaKdwuOj5RSFQsQxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pAwniXKURCA+5zVL4icGCq10+mIOjmigT0k75I3BNG9M1Xd8+F3goJvo27KazA3HlXc3McCrCb1QS8lb6+5ApOrtRclQC/e00lZBwFe3Ev1nouaKRTv23R2eRbc2hJnAq5fcEF3zct2ILOAmXAbuPVwdX8sQhOeGblsldhFF5wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=mDLSo9B4; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-844d555491eso36328539f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 11:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734032210; x=1734637010; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l9NetkofdTc3tauCZ/TmBHJ2OFlOWg9pJutokK1isp4=;
        b=mDLSo9B4UGopirAQy13jM2sHlQUc+XCYB4YKRLTcFKkRwQ1ycvWofqQnQ/FIVD+GJR
         BCVM1jFxp1zn4LAbdUXDqvH7voRDZWciNY/YMwHmDTZBlWE56bmG4cDtlcprRwoWaP43
         YURZvlV+Fs0u1fAQbZJha1zDIwu/hC7WhFqBppA3iidBidms3BuA+2SHx1NupYUaZWln
         wWS6yjRLLs+TDKUHhu0dviB+z/FPJfMBWhT5fMm+X48MTqH/L8XC91nd8Owobhg4IRnQ
         Uk9UGi3UTMuJk4JFI5fRmC07JGk4i7gDGBYX1L5RMXVQ5k7OiQ+LLjk96eHGGLQYy3A6
         65Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734032210; x=1734637010;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l9NetkofdTc3tauCZ/TmBHJ2OFlOWg9pJutokK1isp4=;
        b=oYDvTDMz0xeVfKDJemxHbCmaaqba4ZZtmcjUs7wWus4B8sHoQKwKlUG1mot5tkBU8Z
         K30vdn1jmh1e9R9LoSUZeJJ8TBADRXVMPxWFEMou8NsQvuo93BJ30EmCSaatzkC5M4QX
         +fEOR/5aWj3J8xG7ogIFybFJ72MBfG8PXzeEyhtTrE+iHknP1QuaiJsy9x6psYsCq0zS
         GHPeSlgphvvJS9JqO2jlTar/rD2yRU2DZJZTe8hNsu2reNQG18LvIDgMS5YAJpvZwjMD
         O8tSaF6yj7upsAfV45Og+ZDxxmExbTs/TA40wjS/RbobLhg5fZELNLRNumdD0VqcIMbY
         JP4g==
X-Forwarded-Encrypted: i=1; AJvYcCX5ke60mG0pKpXizJxrDleDpH0PJ9sWaG60ybQ8xPwl4ocXoZUu8fqAaMwxMBNq0B3dcz9aaj+1tRHy4NqQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzM74GqmG+J4h5ORrFr7qMjkJnpePJV5/aAtRDMGdJTBC4gd5mL
	yfdRItIqAsqPTaY4NY+NWT6TCYG53JJ8c3ho9gZaZzY946mAmgD9Y9S5YByFRvI=
X-Gm-Gg: ASbGncvJ87qslIAa7I81h3uMG+517lViIoqC+KjdCgntAfsfxZzedaJHHcLrTr+YQrV
	FmHL9CpB9hrQBOnyJmBEvGEBpRV9ZPoA37VUO6s1nxZNvn9VPId06bjx2Ur2jKS+U0KpwMPb7d3
	HeE6Xe/+32ZjoFa97azyj0Jj3AhmcbR+FkAdR+uOrObfwJgQZn01xiqYrC0kd3bRSokL2lbvj1e
	U8eR5YL+j9Fu3rpUpus9lb1qEQEhxxX81bBLTaRB74Gsl762PBQ
X-Google-Smtp-Source: AGHT+IGYXaH6gW0H4DnJ9sYH8avclTqtNpIW4Ov9pR/4ZeyaZ0uX5YVu7ZLP35uMyaDy9lriE0bidw==
X-Received: by 2002:a05:6e02:1a2d:b0:3a7:8720:9deb with SMTP id e9e14a558f8ab-3aff5b520damr412565ab.11.1734032209886;
        Thu, 12 Dec 2024 11:36:49 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e2be15f178sm2311129173.142.2024.12.12.11.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 11:36:49 -0800 (PST)
Message-ID: <64b0c304-221d-4d8e-9bc7-dfeaa49872f7@kernel.dk>
Date: Thu, 12 Dec 2024 12:36:48 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v6 0/12] Uncached buffered IO
To: Matthew Wilcox <willy@infradead.org>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>,
 Christoph Hellwig <hch@infradead.org>, "Darrick J. Wong"
 <djwong@kernel.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 hannes@cmpxchg.org, clm@meta.com, linux-kernel@vger.kernel.org,
 kirill@shutemov.name, bfoster@redhat.com
References: <20241203153232.92224-2-axboe@kernel.dk>
 <e31a698c-09f0-c551-3dfe-646816905e65@gentwo.org>
 <668f271f-dc44-49e1-b8dc-08e65e1fec23@kernel.dk>
 <36599cce-42ba-ddfb-656f-162548fdb300@gentwo.org>
 <f70b7fa7-f88e-4692-ad07-c1da4aba9300@kernel.dk>
 <20241204055241.GA7820@frogsfrogsfrogs> <Z1gh0lCqkCoUKHtC@infradead.org>
 <04e11417-cf68-4014-a7f7-e51392352e9d@kernel.dk>
 <2f79ff03-48ee-54bf-b928-e9519b3edfc7@gentwo.org>
 <383d3adc-e939-44b2-9110-4db9b4477401@kernel.dk>
 <Z1s7AGxZKhK1V4qv@casper.infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z1s7AGxZKhK1V4qv@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/12/24 12:35 PM, Matthew Wilcox wrote:
> On Thu, Dec 12, 2024 at 12:14:23PM -0700, Jens Axboe wrote:
>> Like I mentioned earlier, the fact that it's cached for the duration of
>> the operation is more of an implementation detail that developers need
>> not worry about. What's important is that it's not cached AFTER. I still
>> feel UNCACHED is the best description, but I'll change it to DONTCACHE
>> for the next version just to avoid the overlap with other in-kernel
>> uses.
> 
> Regardless of the user API name, I like PG_streaming for the folio
> flag name.

Sure, I can make that change.

-- 
Jens Axboe



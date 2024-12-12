Return-Path: <linux-fsdevel+bounces-37184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 508C39EEE50
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 16:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF69D188F1B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 15:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECFC221D9C;
	Thu, 12 Dec 2024 15:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dPh69NUN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563B9215764
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734018588; cv=none; b=kwY6MDVUruCBaDtWBqNl0BAf82M4FQQVYD8m6/ViEI1xveW+uxfKszcTvcOXeD4KTJbcR2xg+LxmPYm8Bj23t8NVjhxHFlU/28dXCzw+DSO4ICcaJx24IjXEWtQL2aMcOr7dg8Y6rdNQzMbBibtyzBNx31wrhvUYdVlLDZmFnRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734018588; c=relaxed/simple;
	bh=lN4MUxPKoJApshMw3UQg1h/DxihUEuhLvyfrSkJfkw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fl7CgLOs0THa+OP+UlnaQR719e0h1M7u8Oc/n7xZK/KFR93tKELJrr0HhxnlKwE+p75dwSXbVDAq8czHrFEPmgGHjLnmAZWHt7nt/rjQiiIWKvWHnOpk0jDuB/t0ILb/mxj6TDRB6xBPmnU+Uq0kFURSnVp6Hte6M71HG5O8KaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dPh69NUN; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-844d7f81dd1so29568139f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 07:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734018585; x=1734623385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YVaKQZU7nloKckjwhdDnxOF9PtevW4t5K7qzUvbh2h8=;
        b=dPh69NUNUtbwPgNSlSjEQ6oT9vxhIPPxQ7TheWzOrLONeIYA1o9eSFAGbR0kp+5n0I
         RU0lUjesoYvEypMhwiCO5tIUWaziN3DOex/g+RziJMzo7Ja64b2C6K1FBNxJj61i5OhM
         65z1ORmNZthIFpbVQS1mApi2JaCyz61/9HQ24ZEf5oeI3P7dsMnTFscYyALYiVOtWF0w
         FKhabGwWIV61gHOKvlC+V8MQq2dbn3UhonjlfasEyB5cH9z/qFMppP2G5Rpc/Ht5YU2D
         1+ua5sym96aFyPniJfMVGdjA15nupIp9TAAjdn0jh2NBbRt86gxmKKS0c3OESwdeb1D8
         lXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734018585; x=1734623385;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YVaKQZU7nloKckjwhdDnxOF9PtevW4t5K7qzUvbh2h8=;
        b=S0ZGpXTC3gf1R1TojhgLDPugEDewA2HINCCX7pCCAk+bge0zXuIH8OSSRub6ftmaSq
         Y47mjlo92YTnrChzObfHHSDjg2j0UOofsPQxyv6QNYTJQ+Fq56IvdQuCk74OAl9Aw4Xc
         QdMIRVvErhevReHLb3EgR4CRqE0oCqT+npJMaahZ4ZrhvPv0BdtMsCpLaKHfjc/lf3hq
         FCf56qiUkEftWeWBGu48tTiqDYhb4EGR19u2m2Nflx2EAfCYivR7yyF11VXqG+VOmGAf
         XmcMjXvAbV2uUprgMy94gbzLwJ8hURZRrqZAk+PK1t+vWQE6GbTBgkCDODNz1CGUBxCU
         jPeg==
X-Forwarded-Encrypted: i=1; AJvYcCVmCkNMCh/AXIZwbtwK6ImUz8cc3M3K7FyKiU96bIDGpnwrHmGwa6CcSNZkd8Vg1fyxbvgb3IGSC/zxPX8G@vger.kernel.org
X-Gm-Message-State: AOJu0YxYzMBDAKY74Q4Bx19doggCwRPMojoihK+eOd0a0YbAv8nXrtMa
	ubOXN/Kqj0ONXF9aPgj9/6+uuqxruIZ5nIbC2XJNgTRu/Dh2IG2PS4oEfQJmMHs=
X-Gm-Gg: ASbGnct9szE9UaJCNCIt/rkkUFZBPv5D/hXaIak3W/rjKXn1H53IzseQlgj7daOx2EV
	UgZ9soaxUGVbFwII9wGe+3mokVtI4gYbjjBpnjrGiuO/ges0qsrOg1jJ0EUvNgefGTfG1erdCwb
	3mZUKEBIQy/fIMztMWWpqxR3D56sluPRw772bEBePgVZQugYXkdoxErI/o348tjRvG5b3yK/IJK
	nw+EUODeyg7NMGvZueCZ6cmPXsmA1Fk5eZYgVr6aZoTuQG+ct8F
X-Google-Smtp-Source: AGHT+IGmxw/YiyqxPRIzbjFmn/JAK77sZXtipYzHL1BIv7+IHJ3asyE+OvBsoy5xKnX8eBVpXS4m2Q==
X-Received: by 2002:a05:6602:14cb:b0:82c:d768:aa4d with SMTP id ca18e2360f4ac-844e56595f5mr70126339f.9.1734018585556;
        Thu, 12 Dec 2024 07:49:45 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e2d57dbf74sm1247971173.54.2024.12.12.07.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 07:49:44 -0800 (PST)
Message-ID: <2c009af9-a92c-464a-aeea-50c2520b4a04@kernel.dk>
Date: Thu, 12 Dec 2024 08:49:44 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] mm/filemap: change filemap_create_folio() to take a
 struct kiocb
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
 clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org,
 kirill@shutemov.name, bfoster@redhat.com
References: <20241203153232.92224-2-axboe@kernel.dk>
 <20241203153232.92224-3-axboe@kernel.dk> <Z1giRw7nEebrPfpN@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z1giRw7nEebrPfpN@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/10/24 4:13 AM, Christoph Hellwig wrote:
> On Tue, Dec 03, 2024 at 08:31:37AM -0700, Jens Axboe wrote:
>> +static int filemap_create_folio(struct kiocb *iocb,
>> +		struct address_space *mapping, struct folio_batch *fbatch)
> 
> We might as well drop passing the mapping and deriving it from the iocb
> as well.
> 
> Otherwise this looks fine to me.

Sure, I can do that cleanup at the same time.

-- 
Jens Axboe



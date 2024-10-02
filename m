Return-Path: <linux-fsdevel+bounces-30721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F6298DE86
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 17:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDD62B2CD93
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 15:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE9D1D04B4;
	Wed,  2 Oct 2024 15:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xGLJdNMe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6A01D014D
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Oct 2024 15:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881406; cv=none; b=unMcTmc6pxi9KkOyWwch/YrbFl+SDeP4CGYLEqRK4gWe5gMQaY2XDIgs7hcL6SEugfKyXZ2FcnKc+zItE2Vcvbj5InsK+YNf4KXpYUsEgx95sI4tNGmuuUMoJf7nhmXiLORMzeA0CxWZnHdjzogz6TN71kwI5NwBGeea5NVOvrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881406; c=relaxed/simple;
	bh=A5bkOqDxFmnjWOcQv7M8QGENshtutAhVmgSm7Ft1O2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AAxf5/+cmmuEHUbLlpSm1Za+I89dcOLICjYhedmHFIpEwF2b8x/R/ajoPKakjCLvtKwi5BCDyjT0cV64jupdcOIvQPghpaJz53+HQeGniG1IahutRHGaWMJgxfWkK8DIl4tANYaEGu8nkEpOKsKXN7iDlPyRjE0gF6X9uFdxbxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=xGLJdNMe; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-8325044e388so315059839f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Oct 2024 08:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727881404; x=1728486204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YN8tLxTNLoc6Z+6iyULY22+FNGpb/PmZBsYC0aDr5nk=;
        b=xGLJdNMeYj1JJFCK5pq/+u/EqfTPs2viaPoMJX76e+b6EtIzioliSstzI9B12w5/e/
         C7vHhzNJ/AXyhBVnvDyNlTbKfwdd8AQnn0WgmUgSAG7F9xzg2FvZS2hYUi7Z8J8m4P+A
         Fm4nxBK/NHZQJOML9UgGK28nAT0iEj9sBAgkjHL+Tqhwo9/nvW8zcAMHEWFHjJP8qTH+
         I7rUI0zQVqtgJFj2g8Ss0mM8up848OHXG2rRMp3YxlUd9RqaX/l2q41M6nCJsBIi/2fo
         4QZtmAeIxZh7PXIn+UAELBbSzMIu4NL11WT3V9gDMCufWpFbhF927tUrqyU+leXObu9n
         AzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727881404; x=1728486204;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YN8tLxTNLoc6Z+6iyULY22+FNGpb/PmZBsYC0aDr5nk=;
        b=ePFMwfBsXGcr7v1mijpFAzyZWCnWnCwvZ+2gOHffCEVFfoJFNfnqE4NBY6AcrQ61CD
         03NDZMeBBi78hP+e1XO+fyQvMb5FkgJP3LmW4/OD3MG9tESKwwUy1/UxXzW1cQmg1ILv
         DgC8JIqPpnDo/f9D6vm5iDw8nU5ASw3ilJ3XKV7VRntu2JVHS4eEeFp81+9Cc+umyQrE
         eLg3ar/YEtlTOak842CyZJW83xwN367f6xms0B782nVQ3Q+qTmOME52yHHoFKLWxbKxX
         dwXQ1UATJhYH/06oYZJcJL0c4gYrQTE27KE8ZLWRPHieb9hNmxZXwkVzAQRw/1XySrJu
         BX/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOrtUnnSL9320lEgYGXI0pJUCu0799k4aNw1s79vqz+ICpIH2y3sx5RKF+A/Lk3oYBqJwWDWj023tY3S+f@vger.kernel.org
X-Gm-Message-State: AOJu0YyK4KBizNdYEl3NQXW6Bl1Fy3n4LAGrVRpGItin5OKb42wbFb32
	BGpmtFUH94Gd/2OiU5a3rJN9Q4yNbTDoI7W0yYr4k7mhMY4Wqc3UGZ6F3AthLrM=
X-Google-Smtp-Source: AGHT+IHxepFVron7PObO0zlx42lsa/dU5NCcXVtGwmYpMS9i6sDKEx8F2iCKxC41JSaFOYey3Om7Gw==
X-Received: by 2002:a05:6602:60c1:b0:82d:8a8:b97 with SMTP id ca18e2360f4ac-834d8519045mr390417439f.10.1727881404221;
        Wed, 02 Oct 2024 08:03:24 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-834936c8597sm334094439f.16.2024.10.02.08.03.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 08:03:23 -0700 (PDT)
Message-ID: <f14a246b-10bf-40c1-bf8f-19101194a6dc@kernel.dk>
Date: Wed, 2 Oct 2024 09:03:22 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, kbusch@kernel.org, hare@suse.de,
 sagi@grimberg.me, martin.petersen@oracle.com, brauner@kernel.org,
 viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org, bcrl@kvack.org,
 dhowells@redhat.com, bvanassche@acm.org, asml.silence@gmail.com,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-block@vger.kernel.org, linux-aio@kvack.org,
 gost.dev@samsung.com, vishak.g@samsung.com, javier.gonz@samsung.com
References: <CGME20240930182052epcas5p37edefa7556b87c3fbb543275756ac736@epcas5p3.samsung.com>
 <20240930181305.17286-1-joshi.k@samsung.com> <20241001092047.GA23730@lst.de>
 <99c95f26-d6fb-4354-822d-eac94fdba765@kernel.dk>
 <20241002075140.GB20819@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241002075140.GB20819@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/24 1:51 AM, Christoph Hellwig wrote:
> On Tue, Oct 01, 2024 at 10:18:41AM -0600, Jens Axboe wrote:
>> Have to say, that neither have your responses been. Can't really fault
>> people for just giving up at some point, when no productive end seems to
>> be in sight.
> 
> I heavily disagree and take offence on that.
> 
> The previous stream separation approach made total sense, but just
> needed a fair amount of work.  But it closely matches how things work
> at the hardware and file system level, so it was the right approach.

What am I missing that makes this effort that different from streams?
Both are a lifetime hint.

> Suddenly dropping that and ignoring all comments really feels like
> someone urgently needs to pull a marketing stunt here.

I think someone is just trying to finally get this feature in, so it
can get used by customers, after many months of fairly unproductive
discussion.

-- 
Jens Axboe



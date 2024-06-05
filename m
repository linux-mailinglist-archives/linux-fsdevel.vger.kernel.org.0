Return-Path: <linux-fsdevel+bounces-21040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BDD8FD080
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 16:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16A22B2A20E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 14:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333AA1640B;
	Wed,  5 Jun 2024 14:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pl4eW1Sd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A71810A12
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jun 2024 14:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717596467; cv=none; b=pCGea/pKVrL8W+ltUh8X3jxUFY17e67XA+WRciQmjY2lhyxJkRnDKIdCNCJzJQ1OKBFTlPYhDYGhEvvxCUEJAJqI6G1iiXykGF+4pAh/RkJH4c0dIhYTlhG+BvcapDfURM43s3DtoHon2UcnkuAGDhxC9dcfEaumPA+PN8GO/3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717596467; c=relaxed/simple;
	bh=G1kz/PRN23+QpsWh23o6YWf2s2yCUPcJwpFAPBnT3k0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SMUXEc4dF4ZOb67vH9E166TmGyKwjg547auqYXdvtUCgQ/KuyzsJFSDCOq8dCSijeXjdnuPVpFj7+QagidY8j1hsoMFit4fxiRxFo796EIlJ8ttFqWi+BCmSZCei8pZ/2NDSPYbctNur8QlhGKkZaJA1D75MoxhjnczgbsZTn8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pl4eW1Sd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717596465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VEkSv/wkJy5gIacDcugoCBVPAdCY8hqPso/BOhBGtKA=;
	b=Pl4eW1Sd0oIOIdXuqjhPe/pEUPVBUeHh0wolmOOYhTCByPLmai28jNd/F2f+nlH9BEsAU4
	l19+6xMP6hCkjRksRzwfT0ZQo7CmaEgUa4zy3PIrOOyE5JylfKwzIAcnlVjDBqyxpeKXug
	YFqtUy/nL2ksCUB6xPLJd1ucS6HF9jQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-HJmGWwQKPgGoJ1-fZ3aIBA-1; Wed, 05 Jun 2024 10:07:43 -0400
X-MC-Unique: HJmGWwQKPgGoJ1-fZ3aIBA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-52b98d73cf9so2631916e87.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jun 2024 07:07:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717596460; x=1718201260;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VEkSv/wkJy5gIacDcugoCBVPAdCY8hqPso/BOhBGtKA=;
        b=MkoTgCMNrENInah5LYwDLk7zofuEhPIBe1XXgpjhMUFLcyeWh9Knjthujaxz9noFer
         +JFj+dY7DiVfiy3DkhTPrn+wwr6UpIyzZrjy/bMG8q6XGI4ULyuzmjE8ezIKiQEodwl9
         HtL0//akkGL51Q7OSfIXXECMDRwvwkU/UEl3Tgw3DVHF4Y9BTlDFQjLIVSzhiREfL/4i
         NP7qBMaZ/37Utk/28s8iX0Ia1hP2vuSoy4FLO0qQmh3KJr7+TVTu2T5HgR8VBuh8ooVb
         X+9IgXnEXvfVXp4WSGZgSuoSCjcgbEqC/7UZaFk5xSeyPIdV4zhwXvfHmTlShXC5K2v0
         OR0w==
X-Forwarded-Encrypted: i=1; AJvYcCWb1yH323mrIFPm4GuYgE2CgnzvXolx96lJ5e4gu/+vFIUSqCKgtJeJp8noAjt3owhekt6TNgVgkcMxA+hvNj+yexevLh2nseuvAu6omw==
X-Gm-Message-State: AOJu0YxdChZiav8FVH44YMfAmwGspzFtTonWxDbBIT5Zp8f2ztGEen5D
	MnP1g3Fp/ifvTeDlrsO8sRevX2BzxempvBy8aDYimxAjqW2+mKAwaF44i+YKoZTSlvGcxEQAs2z
	vmoSNfw0iQAG5O0W8PLY997rrDMGNyQR2rfDxr+ZHiKMA3OKPUi94RQGFiUlgoHs=
X-Received: by 2002:a05:6512:3e1e:b0:521:cc8a:46dd with SMTP id 2adb3069b0e04-52bab4ca688mr2447051e87.11.1717596459951;
        Wed, 05 Jun 2024 07:07:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWQkEGTiF2US910j6qATuYv6PWll++dJZVRQ+oWbzvMc1eD4nMBj6V7rtuZUfVx9VVE5M1nw==
X-Received: by 2002:a05:6512:3e1e:b0:521:cc8a:46dd with SMTP id 2adb3069b0e04-52bab4ca688mr2447030e87.11.1717596459494;
        Wed, 05 Jun 2024 07:07:39 -0700 (PDT)
Received: from [192.168.0.161] (host-79-23-6-148.retail.telecomitalia.it. [79.23.6.148])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68e6b5cdf8sm559531466b.81.2024.06.05.07.07.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 07:07:38 -0700 (PDT)
Message-ID: <af031e33-74db-40ba-abdd-ef1bf32e4caf@redhat.com>
Date: Wed, 5 Jun 2024 16:07:37 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] sched/rt: Clean up usage of rt_task()
To: Qais Yousef <qyousef@layalina.io>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Metin Kaya <metin.kaya@arm.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, Phil Auld <pauld@redhat.com>
References: <20240604144228.1356121-1-qyousef@layalina.io>
 <20240604144228.1356121-2-qyousef@layalina.io>
 <b298bca1-190f-48a2-8d2c-58d54b879c72@redhat.com>
 <20240605093246.4h0kCR67@linutronix.de>
 <20240605132454.cjo4sjtybaeyeuze@airbuntu>
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20240605132454.cjo4sjtybaeyeuze@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/5/24 15:24, Qais Yousef wrote:
>>> But rt is a shortened version of realtime, and so it is making *it less*
>>> clear that we also have DL here.
>> Can SCHED_DL be considered a real-time scheduling class as in opposite
>> to SCHED_BATCH for instance? Due to its requirements it fits for a real
>> time scheduling class, right?
>> And RT (as in real time) already includes SCHED_RR and SCHED_FIFO.
> Yeah I think the usage of realtime to cover both makes sense. I followed your
> precedence with task_is_realtime().
> 
> Anyway. If people really find this confusing, what would make sense is to split
> them and ask users to call rt_task() and dl_task() explicitly without this
> wrapper. I personally like it better with the wrapper. But happy to follow the
> crowd.

For me, doing dl_ things it is better to keep them separate, so I can
easily search for dl_ specific checks.

rt_or_dl_task(p);

would also make it clear that we have both.

-- Daniel



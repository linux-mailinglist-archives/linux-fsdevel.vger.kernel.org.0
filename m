Return-Path: <linux-fsdevel+bounces-21037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1A18FCFB0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 15:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1F451F25B5A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 13:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F47A19581B;
	Wed,  5 Jun 2024 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="w+Cb8xr0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5233A19538B
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jun 2024 13:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717593899; cv=none; b=K74DfArTuNnS6wQ1Y4VKKWutm/2YLYYLSwZ6RaKtOfV47e1LzKAvy8aJ+Q/ngyOJ4aJY0JYqt0p3o+8xF5ZySwIoPF7Q4s5YBcIJ80JdrBcXYKzbBGT5NBREXcF+C4aV+v9TqYWcEHxGxnNrQWHwti3Rh56ybW1VNQ7Dovy4CaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717593899; c=relaxed/simple;
	bh=IGgoHOYvpbTfxvF2N3hmgx/MFZ0LCAAfov2fRiE7iLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lK9rcGAkhzDg7gHBCYHQ+x2APf64ZOos9jJnrVRQ0X5LW71Hdb+GqV4LkT5BiT5VwjflQVBz7zDfrgOBBE15VIjUumMtKeeCossgbB38ng/JsXn294KiWLkRPouUhUsFhZE4ddD1qEUuHQ+V6ICMPIhJjMDy+e9jk1DePj8gp88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=w+Cb8xr0; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3550134ef25so6360988f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jun 2024 06:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1717593897; x=1718198697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xq9gIboeIP0lLm6D7yyfMwZHyoZ/EmvE2lx3bVnUJH8=;
        b=w+Cb8xr0DLUkEiF25I2+ao+PrrD+CxzU7bXJkwia1qIQFJe5qePWIGI6knsgLGx925
         1pg0KmdvOqp2JaKkyFjqZycakRMvp9Ui3ipK60zOysjUEP0EQWImgJ5LozNmHHnCEyLJ
         7juMRmSymxXA8FpewX7CwIfEO/9XiHOPerghwCcHNyAIyH/F2oxlHOo+YgL5qez8bfB2
         y9OXJwvmgeYtc2hT6SgLrd+cyRRbIy1gnIflaYFRPj4NWeuKDHekS4v761pmGrSq0Grf
         NIGb6c/d2bfjJdsg/aN2WU3XSbXXJPpYqj24r7pkJB17VHsJhF7n5Rzf92oSGpFePZ6U
         bisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717593897; x=1718198697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xq9gIboeIP0lLm6D7yyfMwZHyoZ/EmvE2lx3bVnUJH8=;
        b=pKYeDyvxOKZCbfvrh6DD4PHNyGpAHDq3f1E+6nhFbheG1SyfWQRUZ5NokqbnDqJDi4
         2GJI5XT85VyPnX0BJaUNcgkfOXjI2Gzj1rwwKG5zhgT1snYBfn1qgmQEbghi/GQeWaBp
         TZGcd2XNKHfYbbi3ThHCOJDow9F88WmgQ6V0c1NYrKusBnOYJbyQgXziHbLKmAs8Mq/Q
         k8K3CwDOB7Nd8yBdAbF0ck9Bt/49AbEmpZrZWQVs52svnlPTJq2JzPlrKRKuZ6jdZPbZ
         y7CkGj5m3X5m8r2M2knTnFzzMJocW0QgFcWT4vmilmdcEQHufO5PUWRURbqaDMkIxS5a
         FTLA==
X-Forwarded-Encrypted: i=1; AJvYcCW07W7fJXDBRHns//2lEI4ZzfenCCRtGTl1TpMxRVerYtQ6vMyQ/kDnCshiltfKJqNSSWvouWrnDM9HzBRSfMdY8EquYhxmXXgrWYq6nw==
X-Gm-Message-State: AOJu0YyD281C1zGMM8Hnv5St84jbuDgDHt5NuGDfZDxURXI8crMHQa8x
	Kowtq5c4VffW6NUrBszIXuHdgQOAJKQJOXLQx+lqwYMVq1RRRO51tGdSQcduZz8=
X-Google-Smtp-Source: AGHT+IEDSLWBHNvCjuH/hvXgGFQjAPtCtaPrhm+JcG8FGeW9Ms1o+F8Qs/onHstEDi9CUXB1JupgJg==
X-Received: by 2002:a05:6000:1f8c:b0:35e:5b61:23b8 with SMTP id ffacd0b85a97d-35e85feecf2mr2435818f8f.34.1717593896475;
        Wed, 05 Jun 2024 06:24:56 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c0f7esm14621490f8f.22.2024.06.05.06.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 06:24:56 -0700 (PDT)
Date: Wed, 5 Jun 2024 14:24:54 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, Metin Kaya <metin.kaya@arm.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
	Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v5 1/2] sched/rt: Clean up usage of rt_task()
Message-ID: <20240605132454.cjo4sjtybaeyeuze@airbuntu>
References: <20240604144228.1356121-1-qyousef@layalina.io>
 <20240604144228.1356121-2-qyousef@layalina.io>
 <b298bca1-190f-48a2-8d2c-58d54b879c72@redhat.com>
 <20240605093246.4h0kCR67@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240605093246.4h0kCR67@linutronix.de>

On 06/05/24 11:32, Sebastian Andrzej Siewior wrote:
> On 2024-06-04 17:57:46 [+0200], Daniel Bristot de Oliveira wrote:
> > On 6/4/24 16:42, Qais Yousef wrote:
> > > -	    (wakeup_rt && !dl_task(p) && !rt_task(p)) ||
> > > +	    (wakeup_rt && !realtime_task(p)) ||
> > 
> > I do not like bikeshedding, and no hard feelings...

No hard feelings :-)

> > 
> > But rt is a shortened version of realtime, and so it is making *it less*
> > clear that we also have DL here.
> 
> Can SCHED_DL be considered a real-time scheduling class as in opposite
> to SCHED_BATCH for instance? Due to its requirements it fits for a real
> time scheduling class, right?
> And RT (as in real time) already includes SCHED_RR and SCHED_FIFO.

Yeah I think the usage of realtime to cover both makes sense. I followed your
precedence with task_is_realtime().

Anyway. If people really find this confusing, what would make sense is to split
them and ask users to call rt_task() and dl_task() explicitly without this
wrapper. I personally like it better with the wrapper. But happy to follow the
crowd.


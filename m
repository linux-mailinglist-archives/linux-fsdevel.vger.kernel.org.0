Return-Path: <linux-fsdevel+bounces-20425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFC88D3483
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 12:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D190B2125E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 10:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F03817B432;
	Wed, 29 May 2024 10:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="zELE13gd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AB616D9DD
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 10:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716978386; cv=none; b=TWOpV4oJ0uk7dh4klt6zqYNXKWKnwHF1B5vPTYYQ2yglOYL4Q4+Nbin+YWMJHbt7mj/MJPYY94J0G++Uwz+mFcRKrgOG1shKE64dj00+4vNHJ+k6Dn/ukFMO88Z1I3NfqtXzzFu2WpoEyAouXO7aPAWyzV8Bldj1x4KPtjxOIcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716978386; c=relaxed/simple;
	bh=lnRddKFcAoYT+tdiO+T64N/X4UwtldTOoym7fVYnzRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLI8nse171e3TB8AwdC4Rl3DGoQaBebGlOU/jLMt4aYhT4BFNnOX6uo7rHyR/L6B6ryOq+l8D80vgOgsYXaLzzWOpJZFFbaYcY0X7GKkylZJmQva21jHCMdNI1ToSRUIwLKQ1sjTlvoEm5q+yMh5NoPyrWots0kQTZOobycKMPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=zELE13gd; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42011507a54so4362915e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 03:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1716978383; x=1717583183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LG4i7mbUzkEJRUAZg6ZfpW9p6gCCgVIHlxO5mLVFmZE=;
        b=zELE13gdHD2dG804Dlvjij5M/QsVkBUbcR8MueYEh8oVJ4kTjlKvfa7a27MNqdSPIR
         TJnI6M3l+7nfuOyI7Fb6oE+NLIdSaQ6XioY+kErtL/lIXkKtP5NbUpGZqNFdBSEsajJh
         sQ6G2TzkuS2LkBWsioRCjpQV9Ssik5ny6c5F8HtCWRknMTk0t9CYX3+MwFV43zIyoLmH
         KGdDk1zkbGvyeJMJt6aeLuS4VkLZh4DbgPc/mXMiJ4SEn98KvdGW6R8WfmogjLm8fjUj
         qPDhWyCOxP/rFNWRILTCPo9xFQ+jZMDzUGzKvAIhRWqYKpI4APGJLN7DeWzbzW4jIszQ
         VmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716978383; x=1717583183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LG4i7mbUzkEJRUAZg6ZfpW9p6gCCgVIHlxO5mLVFmZE=;
        b=FXJvDCGKKvHS2Mkg4a7tjdinZmAOrD3FusEzdGeKFnvnzpdQYe/zFN6iqR96oRSXUp
         +kFfsXNQXek+VGqocynymRcgRbDTLIELDBebr7rkURmqXH6c2IWsizF4ftAcVpWQKB/D
         WuIU1Wk7t4mCvgskJg11wtogZF2z5gjlXZYen24r+7/C3UpfZFT2014CA6F8TCLKmQ/t
         t3Dhvs8Q+No57mAFKMVVwWeMjGQqV5887qomlSjKL7eFmfS9K7FqgiakVR/j3sZkfhjc
         knkj//WSCQSkunoYCbWP7CHNw1qjAjlujVqbssO0zTD535ArjgLXtxVp9w0zsrxUChNC
         PuXw==
X-Forwarded-Encrypted: i=1; AJvYcCU6Ny2BIim+//5knw/yumy9SWAN9Inx7ikde7STP4J2TSHaXNh9BhZbpH2D6/MKhX9ZID691GieK0ThpLrqiqrShC+phPOPo1JNcD0YpQ==
X-Gm-Message-State: AOJu0Yy20aUr1KxXHcSFzFZMUQJunN24yphQEvd3uUJxrUBKA0beQ8A4
	4yMkjL7o3Iu00xGpDey8pQrCvxvO9XsGmPN6SXqg5qUydCbShOpNgl78g3RqQhs=
X-Google-Smtp-Source: AGHT+IFL2rVV6ZbLHtKwQ0pcVenJyjGhOLmyWzjE6L3t1oMaAdsd+Kz4zXnPAVzfGK1vk+ACrvUJSQ==
X-Received: by 2002:a05:600c:21c2:b0:41c:a9:26b3 with SMTP id 5b1f17b1804b1-42122b0d580mr13483695e9.19.1716978382753;
        Wed, 29 May 2024 03:26:22 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212348aa22sm19748435e9.36.2024.05.29.03.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 03:26:22 -0700 (PDT)
Date: Wed, 29 May 2024 11:26:21 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 3/3] sched/rt, dl: Convert functions to return bool
Message-ID: <20240529102621.km5ajaeyzzpqke4g@airbuntu>
References: <20240527234508.1062360-1-qyousef@layalina.io>
 <20240527234508.1062360-4-qyousef@layalina.io>
 <20240529073451.IIA7HXMj@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240529073451.IIA7HXMj@linutronix.de>

On 05/29/24 09:34, Sebastian Andrzej Siewior wrote:
> On 2024-05-28 00:45:08 [+0100], Qais Yousef wrote:
> > diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
> > index 5cb88b748ad6..87d2370dd3db 100644
> > --- a/include/linux/sched/deadline.h
> > +++ b/include/linux/sched/deadline.h
> > @@ -10,7 +10,7 @@
> >  
> >  #include <linux/sched.h>
> >  
> > -static inline int dl_prio(int prio)
> > +static inline bool dl_prio(int prio)
> >  {
> >  	if (unlikely(prio < MAX_DL_PRIO))
> >  		return 1;
> 
> if we return a bool we should return true/ false.

Right. Fixed.

Thanks!

--
Qais Yousef


Return-Path: <linux-fsdevel+bounces-10824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 842C084E908
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 20:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E43A5B30401
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 19:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC43F381BB;
	Thu,  8 Feb 2024 19:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNHfjcP+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED86A374C3;
	Thu,  8 Feb 2024 19:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707420733; cv=none; b=pSy4RLmeV/7AEQt1quaTbb/FJ+xrOSmCLsk1IhGRrh3nT/yfMwtmLhSSj7ayPsh/5Z1Dj3bOEcu/BBKKLvbMNbPzuZ9ttjm8BgE0/l6YzePHcvS4q1bYlOvAt3EW5Qx6I4nJ7yKOBDe7a2S030mK45drEwbAhBX5qfxtuhAZoao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707420733; c=relaxed/simple;
	bh=StmfRvVFHB61GvrwpRMVoEigPV+RQzGMP6z/i0RiVlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSJPOFEt5h4U+FUU3qqJvoEcAuhUZadSIA/PzY5WKxCZ/556xR5qlU/L3wvQN73y71aaGypBa4zOYQJOqJlkCdl/UeUu1x6trz2fayzKOfRkgQVNoVe8BxzL5XbJ3vTmEv28OZq1bZXMDmMdPWzXLGjnqcJun4NPlGesUYTPWMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNHfjcP+; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5d8df2edd29so83832a12.2;
        Thu, 08 Feb 2024 11:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707420731; x=1708025531; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w3bEV6G7AILHzWRDb6GXrkF6SdkK3/w9panlonnMl9o=;
        b=gNHfjcP+Up2LGLmoWKn7qucWrkNBqzkt0dOKWsNZRBmUe7i7Y3I36RWEN4uziqvOoP
         1oz6zBytMQ/mUnNlBpm6lu3ljyWhVODn+OEUEib3I2K3l8befD7RZxuURmq1cfDDC2rv
         iwZ/SjV2B+KMjbfbvotY9dsGKx/7jk7TJBYsTEiwEdUnn6ZjAimijy9veCQiNy5tGABn
         yzB6+LVCVVBoaZN+rzsOs0U7Rpd7tngCgajC4wwCQ9U98oxl05aevBfy9XuIjqRbEYE1
         5+QRArsordsoOVD2MQ2KY4pOveL3Cecvrnz2nwb3AqfLXuPgFMWtYBD+xwPrG2y1ahj2
         pzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707420731; x=1708025531;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3bEV6G7AILHzWRDb6GXrkF6SdkK3/w9panlonnMl9o=;
        b=jeGTB2qUeBjPbb+h1TPWDd2oHzRac11HxAIBB5cNj1UrtRvb20EOunKyYbhz4dJ3vd
         BlUeVi2ktIrEZvqhGsrTXSq1R3WVeTi4jbkVFdA7cTvxJfOCY7h5FRDP8gjtIdpBNi1E
         VUmwrdu3KBlUTHjDcGd9VACoa/zDwle5f9BaZnc0tA1rePuyb3oLu/XZLdQRv3et4wZC
         MWh39XMHYNYQdtPqafWOB28kdbARXZ1ij3BWo736lP/qOvxJceeWR1HgtVT8rpIAyyeD
         wIF/KuVnAdhS36aZqKxysS70e7TwOvjN1y6K0NmCCVhgZL9O9EO23hFaYeF9q2Xr0Tf5
         1+kQ==
X-Gm-Message-State: AOJu0Yyk8ujyLaxKM0IznIq2ET1iLl8TlZLGk563+rhmsb9P839pzKxQ
	r7WdF3qEsKphoV8VzkTbCncGx7497u0qlpIJvGfhzFsQFeDBsbMcL2522H+YqtQ=
X-Google-Smtp-Source: AGHT+IFUFtBkgN+XYjnOixZNsmqmk71LfGanz5wkj3aYHGe4rvLwzdB8rEWYqLYv0r00wRAB8jL57g==
X-Received: by 2002:a05:6a20:9753:b0:19e:a85b:854b with SMTP id hs19-20020a056a20975300b0019ea85b854bmr428329pzc.48.1707420730987;
        Thu, 08 Feb 2024 11:32:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWXucN7a4KrzdxMiZ9FwIbyeCimIkQ5zGfEKnCcFqDC+Zwl9Hd4VhfAD3KVXDu+16ImUOx7wwor0VQkK/PB9gg5lMggl14EScXE3NpTyWL7pQHW08DcLOdjYpUUZPxhwkv23Qkj1tGM8HSwFPn3Dn0GClUTkkz1uMFjAqQGaEe4aTRzox7DlLh1ONRhQh9SV+/B1DfSDEJml4YN3l9ak42liXHGMhsuZPvzJOc87DmQLk90ez173/Cc5RcL03849dtAgVUJ6NAR4X6zZjp0LJmiGq5Pd65x6YmZ7WOEi7OaM2Z9piTTY5zm+PTP2p4=
Received: from localhost ([2620:10d:c090:400::4:3c45])
        by smtp.gmail.com with ESMTPSA id t6-20020a62d146000000b006db05eb1301sm119360pfl.21.2024.02.08.11.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 11:32:10 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 8 Feb 2024 09:32:09 -1000
From: Tejun Heo <tj@kernel.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: willy@infradead.org, akpm@linux-foundation.org,
	hcochran@kernelspring.com, mszeredi@redhat.com, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] mm: correct calculation of cgroup wb's bg_thresh in
 wb_over_bg_thresh
Message-ID: <ZcUsOb_fyvYr-zZ-@slm.duckdns.org>
References: <20240123183332.876854-1-shikemeng@huaweicloud.com>
 <20240123183332.876854-3-shikemeng@huaweicloud.com>
 <ZbAk8HfnzHoSSFWC@slm.duckdns.org>
 <a747dc7d-f24a-08bd-d969-d3fb35e151b7@huaweicloud.com>
 <ZbgR5-yOn7f5MtcD@slm.duckdns.org>
 <ad794d74-5f58-2fed-5a04-2c50c8594723@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad794d74-5f58-2fed-5a04-2c50c8594723@huaweicloud.com>

Hello, Kemeng.

On Thu, Feb 08, 2024 at 05:26:10PM +0800, Kemeng Shi wrote:
> Hi Tejun, sorry for the delay as I found there is a issue that keep triggering
> writeback even the dirty page is under dirty background threshold. The issue
> make it difficult to observe the expected improvment from this patch. I try to
> fix it in [1] and test this patch based on the fix patches.
> Run test as following:

Ah, that looks promising and thanks a lot for looking into this. It's great
to have someone actually poring over the code and behavior. Understanding
the wb and cgroup wb behaviors have always been challenging because the only
thing we have is the tracepoints and it's really tedious and difficult to
build an overall understanding from the trace outputs. Can I persuade you
into writing a drgn monitoring script similar to e.g.
tools/workqueues/wq_monitor.py? I think there's a pretty good chance the
visibility can be improved substantially.

Thanks.

-- 
tejun


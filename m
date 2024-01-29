Return-Path: <linux-fsdevel+bounces-9456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 065C48414C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 22:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98ED91F255A7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 21:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E544F15698F;
	Mon, 29 Jan 2024 21:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNqjoyrk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93BB15703E;
	Mon, 29 Jan 2024 21:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706562027; cv=none; b=Yf5fi//H4NmiGQIsmqYIZR9JV2qHKVq8kEv1ntf5yhbgW/mjSY6Rr4OgT8ymfSSvi6hkYrl+RPYHmUxivifd6bbXK9jt5i8oRSitK0KNE9AAzDV4xb5Hu9LFknTc7vxeHPJpUsEmUDi9qSGPJXChZSYlvvXCWAt1jRSK6xO1kds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706562027; c=relaxed/simple;
	bh=RX13r1dz9d3j+IiG4sjZBqgMjcVtZG7aJt2pnrzL9Bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QtmAk35IcXc5UumBE8TR4sNm0DTknbyv30K8zZvnS83//wHilz1B2zKRjHGWHdspqLZCJMLze55qqWk9o9wfD4RBKEEBarp9WGN9rqExz7wJLCE3P8eAT2r82/rgVLBc44fCuc2gJ0im7hja+WJyEe0fa+1ThecVZCfXNQPxmPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNqjoyrk; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bbbc6b4ed1so2435620b6e.2;
        Mon, 29 Jan 2024 13:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706562025; x=1707166825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DFggPS+olvhz5RaAN6PbMUp4vTeYAiwxyo5MJLQn+3A=;
        b=QNqjoyrkMY2AauSuVtc8jLzZkCHTgBU4KbWehng1p9428W/tCBMx170wZc6yWWiBEX
         5ze+6EzHTO3QevD4qr/AhG5z1f50/0yiU6/Kf7Hu9uzWmyxF6b9eBINwk0Iqf60NpUjF
         SUC+KKtcDwhGSRBsPWt09eqk30I7h3VGG9sPgwG/i1n1tINKg6VIczF2hjg3wK6v5fXh
         e7M680Xt5OeIT2MQsAcAbvHkgPZfEdePu79hdHDSKZbHVbp572kv95GNQ8BxE9MP+cmL
         E4XqncQaGZHuyJyOp8aDZ9/Y7ZEHha3209tjtKeMGdDn1T01Rtf5uHR9m9/I3i5jKlTq
         zj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706562025; x=1707166825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DFggPS+olvhz5RaAN6PbMUp4vTeYAiwxyo5MJLQn+3A=;
        b=YZl9YrjlLchAG6vgzMQtzHGRcXUdf7VsvUPWgRxjA6B03GDoMpDZPNLoAr8z7PJyAU
         mUY0/2aVbyHRYKKOMpJEKTY+mVy2V3Dr0wYqC0BSyLaAgFZJPnGy2WFwrd/GyK1OGqCT
         Xb/2C9uHrnJ3IF2NqGG4rqslUHc4tS2HRjda7/4PjYpxDRfA4m2J+cjvRhbPXIIQ+6p+
         wA8TLBVIAN8FDoIyYTMV5mmpPNIFCDqfw1igwTmTfAUWbZv+DLKVJfMkfLfJhJO9htpm
         6TWiKgQ584EUDF4NQHw+O4Zgplxm2VrnNSfav61eNYTuPbKg9d1BDuPY6sOi7A0Wborj
         cKYw==
X-Gm-Message-State: AOJu0YzQMc0KVZp5hpvSQjsGr37Xr6eDTyF8AdeV5DmsajRp/52ggRSR
	n8KoNPJ4AOan7l3GPv1mgOrRPOcWWPPbEo9I2n/QQlbpkSXowPMl
X-Google-Smtp-Source: AGHT+IG6lvs9rD1TD0S7JakS/rVYog6omuvqEGVQ3sg9e9r8HpesmJPGJg1pAZZW5PFlHWtBvnE8vw==
X-Received: by 2002:a05:6870:d3c8:b0:218:5067:7108 with SMTP id l8-20020a056870d3c800b0021850677108mr6841732oag.19.1706562024802;
        Mon, 29 Jan 2024 13:00:24 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id p30-20020a63951e000000b005d8aef12380sm5578537pgd.73.2024.01.29.13.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 13:00:24 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 29 Jan 2024 11:00:23 -1000
From: Tejun Heo <tj@kernel.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: willy@infradead.org, akpm@linux-foundation.org,
	hcochran@kernelspring.com, mszeredi@redhat.com, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] mm: correct calculation of cgroup wb's bg_thresh in
 wb_over_bg_thresh
Message-ID: <ZbgR5-yOn7f5MtcD@slm.duckdns.org>
References: <20240123183332.876854-1-shikemeng@huaweicloud.com>
 <20240123183332.876854-3-shikemeng@huaweicloud.com>
 <ZbAk8HfnzHoSSFWC@slm.duckdns.org>
 <a747dc7d-f24a-08bd-d969-d3fb35e151b7@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a747dc7d-f24a-08bd-d969-d3fb35e151b7@huaweicloud.com>

Hello,

On Wed, Jan 24, 2024 at 10:01:47AM +0800, Kemeng Shi wrote:
> Hi Tejun, thanks for reply. For cgroup wb, it will belongs to a global wb
> domain and a cgroup domain. I agree the way how we calculate wb's threshold
> in global domain as you described above. This patch tries to fix calculation
> of wb's threshold in cgroup domain which now is wb_calc_thresh(mdtc->wb,
> mdtc->bg_thresh)), means:
> (wb bandwidth) / (system bandwidth) * (*cgroup domain threshold*)
> The cgroup domain threshold is
> (memory of cgroup domain) / (memory of system) * (system threshold).
> Then the wb's threshold in cgroup will be smaller than expected.
> 
> Consider following domain hierarchy:
>                 global domain (100G)
>                 /                 \
>         cgroup domain1(50G)     cgroup domain2(50G)
>                 |                 |
> bdi            wb1               wb2
> Assume wb1 and wb2 has the same bandwidth.
> We have global domain bg_thresh 10G, cgroup domain bg_thresh 5G.
> Then we have:
> wb's thresh in global domain = 10G * (wb bandwidth) / (system bandwidth)
> = 10G * 1/2 = 5G
> wb's thresh in cgroup domain = 5G * (wb bandwidth) / (system bandwidth)
> = 5G * 1/2 = 2.5G
> At last, wb1 and wb2 will be limited at 2.5G, the system will be limited
> at 5G which is less than global domain bg_thresh 10G.
> 
> After the fix, threshold in cgroup domain will be:
> (wb bandwidth) / (cgroup bandwidth) * (cgroup domain threshold)
> The wb1 and wb2 will be limited at 5G, the system will be limited at
> 10G which equals to global domain bg_thresh 10G.
> 
> As I didn't take a deep look into memory cgroup, please correct me if
> anything is wrong. Thanks!
> > Also, how is this tested? Was there a case where the existing code
> > misbehaved that's improved by this patch? Or is this just from reading code?
>
> This is jut from reading code. Would the case showed above convince you
> a bit. Look forward to your reply, thanks!.

So, the explanation makes some sense to me but can you please construct a
case to actually demonstrate the problem and fix? I don't think it'd be wise
to apply the change without actually observing the code change does what it
says it does.

Thanks.

-- 
tejun


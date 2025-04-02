Return-Path: <linux-fsdevel+bounces-45512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F57FA78E0C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 14:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7BBE1711A2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 12:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C487238D5A;
	Wed,  2 Apr 2025 12:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NzRbdd68"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D97420E01D
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Apr 2025 12:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743596245; cv=none; b=pAC9lHjjgSlJbRHUUE9eRNfQyXqnoJWzv49T0hdDL6agsGf2G/sTS0DihX5y9UOD8NBIzUrWEakiQM0C5dxIe8FW42kgEpzU5JphLKSWd62z2+HvimFOzURu6X9VgObqKjFG6smccSil1m0WLposKIDaEzbU5k/yQ0PZvg9NYnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743596245; c=relaxed/simple;
	bh=HQGjOlzvci/jDuFTBkrPI44ZTebsBLaao/xXoxWcPnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCb7aULgBaCQnroK9WKLM/P16Z0aRz6O5a1fRG8cc3iOij2s7Zs5NdQH8e0I/SLh5nuWv/NaFyFrZO/Vtmmz1Hg1e48qMWBUPS1cAUNjgli7YjqSGHIpHjW5GKVLRC4wgmPT9CYq+aAeymq9YK009v9Q7Tmph7xYH+JtSihekq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NzRbdd68; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4394036c0efso45539775e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Apr 2025 05:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743596242; x=1744201042; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u+KkYGiRVTeKTKTukwG7gqG5k92Sb1BtHpbYVZQpWnQ=;
        b=NzRbdd68w/3cF3pfboU0wmUuH71+V+SMeqlZNsXE1auOEArhOpUEAHn+BqbSb2agEd
         pgy6C8kN5Zp8lYLNNHT3YS6kpuLyXEw9+XVNH9INSTDR+xBTa+36BBgsLn6lU9PkIaMN
         0dG44DI6R1lNfG48++w2PaTTRUCWcvnePw+uclOq18uMANbrL5GaWUr45k7GP1Okphl8
         Ku7U5N0a+geqOgnCXGVcEPRiVOzzOQg0Ma6vqRb2hfTsRUn0hIyPVFO6z0Kz6ygWQP5p
         zCz8JlKatPuNhLIlMvfSMKkQt9tn9AAYTHopjAw30CzulrTw6yKmsKPSOkCwYPY6pdA5
         GXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743596242; x=1744201042;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u+KkYGiRVTeKTKTukwG7gqG5k92Sb1BtHpbYVZQpWnQ=;
        b=cAZ41QeS+h8CEgiwvXBJEY8RY1UNCl60bjgKYlLCV8Nd6npXYM54vQW1ESwFq57XxO
         BkPeB6Xe/d/JBiHsvsQrDtBUeDHcDJz4/YNtsD+GOO0YdUKZvs1sZfnsRhir7tW7YH6C
         La77flo6pHfqu+YxJNLutYwsrgvRiY5vpoc/GdGWoQ1rLBgOBw2Rqubg6wIPjwt9OdQA
         Oj41szM4nBp+8oJ8E2ypCL06ArMrlJfaTYxr1vVEjqltQTpOx4S/jTNNu7VfJkfFwch7
         3hJHXjW346/IV1ndNyhGu3f46Wgd2nPFvVVnhqDUbvkeqtrBqtAWHMhDCM1A2Q3i5VVr
         E1qw==
X-Forwarded-Encrypted: i=1; AJvYcCUW7A0TAGkqbZ7OQ0/vfpyTatjlhPIyJAjKJDnUDJzj49vpy1P3KYedEfV2dmyCNRmKghRq5j+43zjAsDXs@vger.kernel.org
X-Gm-Message-State: AOJu0YyH0FsPxasZt0tvdqVSpSrIIbo2qUH3YCWqBtXrbCLMO3VUY0L2
	Xktulatv7DjQ1m3R6x8SYoWUtAhf0lEnjW4W2Suedpo2RxQGdpbe5Ezyb0hwyZM=
X-Gm-Gg: ASbGncvXqny7ZpfnVp6ePqwnSR4hLUGxjxlgVeN3FUayy7BUoGri626EzGc98RRs4JX
	aaa6opV8G1DS2hsg4ckmOVJL3LIxTYFbunvPbe34b980a/g1+xYUlXdx9Kr73nXroROa/+Md1nz
	UARbWqLUDGz0Sg6itdMEpzzVD1mWP8B95us6uGZM4wFFzg0k1BOVRXScDDr1oxl5SHkD35FYh0W
	BhylLNiqQmOz7DMQ2Qr8raZEEoX/fShxIygFN0OClPs5Ji1KawL2Ve+VF2Vo/lEHmTRh4D/RpNN
	7Pw80FN7pzsDcz5qcJ1xElxvhGuW+WFylDrr447d1dd6Y6bwKX+uTq5wwA==
X-Google-Smtp-Source: AGHT+IEzL1dLp6w4/vrpTpg8YH1leTJhRx3ESY+EtSrwaEQ5UAajY5nV9dBkST09FFg5gDba1jeZjA==
X-Received: by 2002:a05:600c:3d0c:b0:43d:8ea:8d7a with SMTP id 5b1f17b1804b1-43e8eeb6696mr111382655e9.28.1743596241822;
        Wed, 02 Apr 2025 05:17:21 -0700 (PDT)
Received: from localhost (109-81-92-185.rct.o2.cz. [109.81.92.185])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43eb5fd138esm18831065e9.13.2025.04.02.05.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 05:17:21 -0700 (PDT)
Date: Wed, 2 Apr 2025 14:17:20 +0200
From: Michal Hocko <mhocko@suse.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Yafang Shao <laoar.shao@gmail.com>, Harry Yoo <harry.yoo@oracle.com>,
	Kees Cook <kees@kernel.org>, joel.granados@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>, linux-mm@kvack.org
Subject: Re: [PATCH] proc: Avoid costly high-order page allocations when
 reading proc files
Message-ID: <Z-0q0LIsb03f9TfC@tiehlicka>
References: <20250401073046.51121-1-laoar.shao@gmail.com>
 <3315D21B-0772-4312-BCFB-402F408B0EF6@kernel.org>
 <Z-y50vEs_9MbjQhi@harry>
 <CALOAHbBSvMuZnKF_vy3kGGNOCg5N2CgomLhxMxjn8RNwMTrw7A@mail.gmail.com>
 <c6823186-9267-418c-a676-390be9d4524d@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c6823186-9267-418c-a676-390be9d4524d@suse.cz>

On Wed 02-04-25 11:25:12, Vlastimil Babka wrote:
> On 4/2/25 10:42, Yafang Shao wrote:
> > On Wed, Apr 2, 2025 at 12:15 PM Harry Yoo <harry.yoo@oracle.com> wrote:
> >>
> >> On Tue, Apr 01, 2025 at 07:01:04AM -0700, Kees Cook wrote:
> >> >
> >> >
> >> > On April 1, 2025 12:30:46 AM PDT, Yafang Shao <laoar.shao@gmail.com> wrote:
> >> > >While investigating a kcompactd 100% CPU utilization issue in production, I
> >> > >observed frequent costly high-order (order-6) page allocations triggered by
> >> > >proc file reads from monitoring tools. This can be reproduced with a simple
> >> > >test case:
> >> > >
> >> > >  fd = open(PROC_FILE, O_RDONLY);
> >> > >  size = read(fd, buff, 256KB);
> >> > >  close(fd);
> >> > >
> >> > >Although we should modify the monitoring tools to use smaller buffer sizes,
> >> > >we should also enhance the kernel to prevent these expensive high-order
> >> > >allocations.
> >> > >
> >> > >Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> >> > >Cc: Josef Bacik <josef@toxicpanda.com>
> >> > >---
> >> > > fs/proc/proc_sysctl.c | 10 +++++++++-
> >> > > 1 file changed, 9 insertions(+), 1 deletion(-)
> >> > >
> >> > >diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> >> > >index cc9d74a06ff0..c53ba733bda5 100644
> >> > >--- a/fs/proc/proc_sysctl.c
> >> > >+++ b/fs/proc/proc_sysctl.c
> >> > >@@ -581,7 +581,15 @@ static ssize_t proc_sys_call_handler(struct kiocb *iocb, struct iov_iter *iter,
> >> > >     error = -ENOMEM;
> >> > >     if (count >= KMALLOC_MAX_SIZE)
> >> > >             goto out;
> >> > >-    kbuf = kvzalloc(count + 1, GFP_KERNEL);
> >> > >+
> >> > >+    /*
> >> > >+     * Use vmalloc if the count is too large to avoid costly high-order page
> >> > >+     * allocations.
> >> > >+     */
> >> > >+    if (count < (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
> >> > >+            kbuf = kvzalloc(count + 1, GFP_KERNEL);
> >> >
> >> > Why not move this check into kvmalloc family?
> >>
> >> Hmm should this check really be in kvmalloc family?
> > 
> > Modifying the existing kvmalloc functions risks performance regressions.
> > Could we instead introduce a new variant like vkmalloc() (favoring
> > vmalloc over kmalloc) or kvmalloc_costless()?
> 
> We have gfp flags and kmalloc_gfp_adjust() to moderate how aggressive
> kmalloc() is before the vmalloc() fallback. It does e.g.:
> 
>                 if (!(flags & __GFP_RETRY_MAYFAIL))
>                         flags |= __GFP_NORETRY;
> 
> However if your problem is kcompactd utilization then the kmalloc() attempt
> would have to avoid ___GFP_KSWAPD_RECLAIM to avoid waking up kswapd and then
> kcompactd. Should we remove the flag for costly orders? Dunno. Ideally the
> deferred compaction mechanism would limit the issue in the first place.

Yes, triggering heavy compation for costly allocations seems to be quite
bad. We have GFP_RETRY_MAYFAIL for that purpose if the caller really
needs the allocation to try really hard.

> The ad-hoc fixing up of a particular place (/proc files reading) or creating
> a new vkmalloc() and then spreading its use as you see other places
> triggering the issue seems quite suboptimal to me.

Yes I absolutely agree.
-- 
Michal Hocko
SUSE Labs


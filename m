Return-Path: <linux-fsdevel+bounces-45514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEC2A78E41
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 14:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 290B27A5D0B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 12:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB787239570;
	Wed,  2 Apr 2025 12:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PVuc/GpR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265D223906B
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Apr 2025 12:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743596690; cv=none; b=Lf5IEWVugBZjc4afLn6bt5TE3mfTA5W1vWC+9R6mBlI+HhinNyDu6/PvU6GqRXHajC/dAvO4paCAY+s683ifjuD61pVbiWfsNC6fHo8tgtzTgsGjmUbqQxvBfOGHY2SZ6lMv0pkHOf2Vr3XAU1ureJi9f0FWAtbwx3FNbUWgRlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743596690; c=relaxed/simple;
	bh=LqeonuKBobu5rkPqsZ3oev/LqKwXyYHgqrbMyezVleA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfilH5NZyrP24MIJj1lNuURxIkVjdfuT0n2kW+alLL6lCCfNZcTwbxJmtK1Nx1ebM/mDfbb3xmxfr/Qyf95KN5K/iUlOHUuHuxN6PyWNGR6djYWmifJazRmeH3Hf6GDVTcZ62kNmy3V49d69L5YoWct8trmUECdZtN4+GZD7svg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PVuc/GpR; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39c13fa05ebso1901008f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Apr 2025 05:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743596686; x=1744201486; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KRFn/kYndNELtCs9bm4l6TqR46CF9PJ02S18fDZOVDM=;
        b=PVuc/GpR/uh9AFQgPx3tcXmeHnFdrN/PnvAUg6a6fRE8lEmdzP8aWLwFUyAYnaOxno
         zQzq06NQWgui9LTQcfDvsaQn1saezlzon7BGn/PkWPIXS4dBrHPGwDOYJArxnsSwatkf
         GOK4Who+Cok8A2NeuBsxI4PWlK1fz+m1VYc1s1u3mbN74J4R8Bf55uJsAt4j30tuNX8t
         VYvt0l7KqvHMpOz+aA5CU737KMWueyEWt5wtPJYYbKnH/SPeKB0lP2F3A9RVGKZSV5hY
         Ldap9H6VBb/0UuW+oZzShgx2CwVgmHW/B36q8RCpqM+goQI1mO0uweem4FuNRlLQGZeN
         4ZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743596686; x=1744201486;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KRFn/kYndNELtCs9bm4l6TqR46CF9PJ02S18fDZOVDM=;
        b=asom4dG2DFyQR2SuBY789OpwJPrEIj8Ar2Qd+uOitRubtzrvm1i8BU5nSZTOCoNV7k
         5HYDttOwFCzcxY4XDJMWKGVl/gB/VzMO6z3jEcHjL5yOtAZpnPHWzTxSczTCFkx9mhuy
         +OHBZKMu3n0uSF5U34aKJMsnTxknXnDsBn9VS7xq1yzkJK7HMBb/xuTxXwZW8KSlgGMc
         D74JCSl5KnhRuu02LzXC6UiUH4fqWYhgjG6EzNGUYlFo/PgZNkRdq+tYV/rsnKwJjWw7
         fEj6HdVYLGosjQ9cG7Ig0tDzhJqhylKgN6Z098/+Yr/AQxMnEdZsGRtOR7f1T+j4hJAG
         6gvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrbiaD8NdwJfrdWZ3a0HAOMN39SFb2SqmLO4iLLZMb1gJYOC3zl0Z6+edwiFpsboX5ZG174u+O9IB8woj6@vger.kernel.org
X-Gm-Message-State: AOJu0YxTLV62G3q3GxKMnqz4swCWQVNVVFlaYDtrGFKMBNN400eS/S4a
	rBCdh9g6ayJ7QaIVTGP++VF7AjVhLBzXD3EOeMWebX7Of0VoKRkv7umKsiebJbM=
X-Gm-Gg: ASbGncugwy6OWiSTxPX3XwoDOGDQkTi/k8b1UXPsM3vwsV4MmgF4sI9rnH2aCuqj73i
	lVbmKgbck6jGlLp/F5Bf4ZzGRZRyl5ANCyLfwbFhRmaXnXZjzfAjjpUm8y5eZ6l4pnf6ZU9WjKr
	A9f+lTVdZ8OXnORIqkjYW7AsCgb+wqJBnSX8S0N7IAGC+uPpGkal3jLNRaalo4yAh9end1bZgFO
	J+RxxHyJopWsrO2vwZ8dqJJD8zwMYhf84OViSF4gqYQk17XqjDlZItTBsCDZq7uFmngYQyIf1kX
	4jqAEqe6mljSMO9Uk1lf9sn85YGbmOSxpvM8+KmrTVR5jMwmUE8t9BkdQyT/e8FiT+vI
X-Google-Smtp-Source: AGHT+IH94G8NMZggEmYTqBe2slfssz4AV4QqXUWOJ4XU66EOBQZvQTodDOoaZK39wpDvzUvmqsjg2Q==
X-Received: by 2002:a5d:59a2:0:b0:399:71d4:a2 with SMTP id ffacd0b85a97d-39c120de28cmr14089922f8f.14.1743596686324;
        Wed, 02 Apr 2025 05:24:46 -0700 (PDT)
Received: from localhost (109-81-92-185.rct.o2.cz. [109.81.92.185])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43eb6135dc4sm19179155e9.33.2025.04.02.05.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 05:24:46 -0700 (PDT)
Date: Wed, 2 Apr 2025 14:24:45 +0200
From: Michal Hocko <mhocko@suse.com>
To: Dave Chinner <david@fromorbit.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, Harry Yoo <harry.yoo@oracle.com>,
	Kees Cook <kees@kernel.org>, joel.granados@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>, linux-mm@kvack.org,
	Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] proc: Avoid costly high-order page allocations when
 reading proc files
Message-ID: <Z-0sjd8SEtldbxB1@tiehlicka>
References: <20250401073046.51121-1-laoar.shao@gmail.com>
 <3315D21B-0772-4312-BCFB-402F408B0EF6@kernel.org>
 <Z-y50vEs_9MbjQhi@harry>
 <CALOAHbBSvMuZnKF_vy3kGGNOCg5N2CgomLhxMxjn8RNwMTrw7A@mail.gmail.com>
 <Z-0gPqHVto7PgM1K@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z-0gPqHVto7PgM1K@dread.disaster.area>

On Wed 02-04-25 22:32:14, Dave Chinner wrote:
> On Wed, Apr 02, 2025 at 04:42:06PM +0800, Yafang Shao wrote:
> > On Wed, Apr 2, 2025 at 12:15 PM Harry Yoo <harry.yoo@oracle.com> wrote:
> > >
> > > On Tue, Apr 01, 2025 at 07:01:04AM -0700, Kees Cook wrote:
> > > >
> > > >
> > > > On April 1, 2025 12:30:46 AM PDT, Yafang Shao <laoar.shao@gmail.com> wrote:
> > > > >While investigating a kcompactd 100% CPU utilization issue in production, I
> > > > >observed frequent costly high-order (order-6) page allocations triggered by
> > > > >proc file reads from monitoring tools. This can be reproduced with a simple
> > > > >test case:
> > > > >
> > > > >  fd = open(PROC_FILE, O_RDONLY);
> > > > >  size = read(fd, buff, 256KB);
> > > > >  close(fd);
> > > > >
> > > > >Although we should modify the monitoring tools to use smaller buffer sizes,
> > > > >we should also enhance the kernel to prevent these expensive high-order
> > > > >allocations.
> > > > >
> > > > >Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > > >Cc: Josef Bacik <josef@toxicpanda.com>
> > > > >---
> > > > > fs/proc/proc_sysctl.c | 10 +++++++++-
> > > > > 1 file changed, 9 insertions(+), 1 deletion(-)
> > > > >
> > > > >diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> > > > >index cc9d74a06ff0..c53ba733bda5 100644
> > > > >--- a/fs/proc/proc_sysctl.c
> > > > >+++ b/fs/proc/proc_sysctl.c
> > > > >@@ -581,7 +581,15 @@ static ssize_t proc_sys_call_handler(struct kiocb *iocb, struct iov_iter *iter,
> > > > >     error = -ENOMEM;
> > > > >     if (count >= KMALLOC_MAX_SIZE)
> > > > >             goto out;
> > > > >-    kbuf = kvzalloc(count + 1, GFP_KERNEL);
> > > > >+
> > > > >+    /*
> > > > >+     * Use vmalloc if the count is too large to avoid costly high-order page
> > > > >+     * allocations.
> > > > >+     */
> > > > >+    if (count < (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
> > > > >+            kbuf = kvzalloc(count + 1, GFP_KERNEL);
> > > >
> > > > Why not move this check into kvmalloc family?
> > >
> > > Hmm should this check really be in kvmalloc family?
> > 
> > Modifying the existing kvmalloc functions risks performance regressions.
> > Could we instead introduce a new variant like vkmalloc() (favoring
> > vmalloc over kmalloc) or kvmalloc_costless()?
> 
> We should fix kvmalloc() instead of continuing to force
> subsystems to work around the limitations of kvmalloc().

Agreed!

> Have a look at xlog_kvmalloc() in XFS. It implements a basic
> fast-fail, no retry high order kmalloc before it falls back to
> vmalloc by turning off direct reclaim for the kmalloc() call.
> Hence if the there isn't a high-order page on the free lists ready
> to allocate, it falls back to vmalloc() immediately.
> 
> For XFS, using xlog_kvmalloc() reduced the high-order per-allocation
> overhead by around 80% when compared to a standard kvmalloc()
> call. Numbers and profiles were documented in the commit message
> (reproduced in whole below)...

Btw. it would be really great to have such concerns to be posted to the
linux-mm ML so that we are aware of that.

kvmalloc currently doesn't support GFP_NOWAIT semantic but it does allow
to express - I prefer SLAB allocator over vmalloc. I think we could make
the default kvmalloc slab path weaker by default as those who really
want slab already have means to achieve that. There is a risk of long
term fragmentation but I think this is worth trying
diff --git a/mm/util.c b/mm/util.c
index 60aa40f612b8..8386f6976d7d 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -601,14 +601,18 @@ static gfp_t kmalloc_gfp_adjust(gfp_t flags, size_t size)
 	 * We want to attempt a large physically contiguous block first because
 	 * it is less likely to fragment multiple larger blocks and therefore
 	 * contribute to a long term fragmentation less than vmalloc fallback.
-	 * However make sure that larger requests are not too disruptive - no
-	 * OOM killer and no allocation failure warnings as we have a fallback.
+	 * However make sure that larger requests are not too disruptive - i.e.
+	 * do not direct reclaim unless physically continuous memory is preferred
+	 * (__GFP_RETRY_MAYFAIL mode). We still kick in kswapd/kcompactd to start
+	 * working in the background but the allocation itself.
 	 */
 	if (size > PAGE_SIZE) {
 		flags |= __GFP_NOWARN;
 
 		if (!(flags & __GFP_RETRY_MAYFAIL))
 			flags |= __GFP_NORETRY;
+		else
+			flags &= ~__GFP_DIRECT_RECLAIM;
 
 		/* nofail semantic is implemented by the vmalloc fallback */
 		flags &= ~__GFP_NOFAIL;
-- 
Michal Hocko
SUSE Labs


Return-Path: <linux-fsdevel+bounces-54326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DCDAFDE1A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 05:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5097E7ADE92
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 03:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993F51FBCAA;
	Wed,  9 Jul 2025 03:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6nPG+fJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7E78BE8;
	Wed,  9 Jul 2025 03:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752031847; cv=none; b=lF7obTtJF8Koays+hmUApnm0qJx08DKRJntSS0udP3wLE1sc6vb8ctjPyeohz3rxrbNHQF0j4WtYdObGWnr0jOXR4D18LeSrW6jPyEa31PVIpQ6Uc+CSqFReZwsMaeKCawCSOraL7OXC6xqJHiSqLTMGJ5S1jAnIYBFSYkQKK9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752031847; c=relaxed/simple;
	bh=sRl4Hjt7dCHQsKRKroSHXOw0yql/z4y4NaV3OQKumdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJA17IP4Mh61TNixERmIUQwvrjSis1x5d81r8/E/ldUggnI2gN+jOj/6C0KKntypoaxvYMqGxQq1c+/e3IzhGWKX6rrXivl6NNutv1z7jlmbpwFO1794MXqCYpL5ax02y1iOrHv2GRbqvvn1UDvUf0OlxzPMatHltybp0w8wDuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6nPG+fJ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23c8a505177so35307775ad.2;
        Tue, 08 Jul 2025 20:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752031845; x=1752636645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mu6qUOHQ62RBIp+xk62nasWAenaXUSglvP48pK3Jf0=;
        b=g6nPG+fJp3W/33ss/wafFGOSR9VEDssebNt15UcEB9gcJrD4zcOgOj27jaziku7DwX
         24vB1JUD/fx3F+sltAoJttMD9IbscgqeHr5jXqQLSTZzMqkvKe6uLpgN4CGqlpohsrzL
         cRU52VXPy9CfBkYqNGYjY1o/mQ0rxX6VY4rUFmcJVOtOG7c2DIE1dQUOo+7VymjzwyiB
         vw3c7CsDhEnBl6mkEKTG+sOi61bpP0LRxFRMKiIBYofrtxblz2KCky/Ntz0VfEe4mZHK
         KrK09UC3ZKL2Iisxjib6bHyiagi5mt0f+IWBj5Qd1W3GNgOPqJe8iXFyoZbdTn99KcOe
         7WFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752031845; x=1752636645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8mu6qUOHQ62RBIp+xk62nasWAenaXUSglvP48pK3Jf0=;
        b=c6lTY0ZsxDBqJSRPe9OKVb4OqOuEfxMzXm5TJM3l/wyzxx2+dB1dLdekjBD07UpeLA
         0DsbjiRRbLuPJkPO8Hy8qM/28ZZ7qH8wE2x5DC9B/sm7j2YzSvsSRL7IOmOhz+krXbHM
         GJ1tOiLmbBhSGpkmx4uXXApBukU769banPGu8buX45eO91q7vJD+lz17FhwidXsZY/6Y
         +klO1OJQsxVOxMWDDzSm9HClJEYcD46/q+TqUOntpwEQFOdym2NIB+oLsUrjc45AYNDp
         IK1d+2dSoGMpi2y+exjglwPgD2UeHoqN7dZKIXYZ9A5+xqNDJ5tc2NAWAQJks1uW5auV
         Pewg==
X-Forwarded-Encrypted: i=1; AJvYcCUX1ttpxm2oOesfZSDlV3YUkABLMcRvz7Bs5aLLSEnTbYk555iDQ11+VL8XtInjpile5+t3m8NPBAUFPH0L@vger.kernel.org, AJvYcCUZfC+sYeHUeFokgFHNEJdaWIru6JPFff70B5fZeQMATFRR3z+EHm7Gl2uPRVZPKHpTEnTfVZdvpQoK@vger.kernel.org, AJvYcCWZOxeVqCihAVQmTmE6nwbXM2TY0ynB2WZjeGmUFNEIzl2yd/UISW+6541dU6LKS3289v0JcWPoditExEEL@vger.kernel.org
X-Gm-Message-State: AOJu0YySB2I/Ru+QxPazIxjtD7Y+xrX7U3Gp4vUpTaF1ODQ/Qju1c5ia
	Z5+QPV4y21lzEvpuX9l83RIwPcoFeY6d9aHspUZu97y3nW7pHxkqnw+k
X-Gm-Gg: ASbGnctmu7mWlGwYXftn6TmX1Sj/1Iswt77hOwH6NH1BtfEkhtMbGyDEPOB8PvZMoEL
	L+0iUbHgAS0wSsXcqJP/CAl0Hhyl3uEC0dD2d8zcDZRN/hmk/0OvuvMl0m0juDbv1OjcTjekEPV
	mglI7P0liZp6FRZayHT6OkpQz/vXOWt3jfRM9dmtOsdC9saelgN6rwuXEqk/SgMt8blVDZVorbO
	M+M13hmB1xBQOdrRPSc1TnEpcP/TW7ZidK43UFVlgAGlWqamQQ9id7zm0DCsZbbsM6Kp+UqhRbR
	NXDU5srZ2M+yVNREZVq8Cob5nEW6N1o+MaCKMSmWEihe3cyEHLhqMI/FMzJLYcRZ/KBAqlOhSlU
	=
X-Google-Smtp-Source: AGHT+IG7aZWTUwn23SxMC3eQ/hg09TylcFKw+KpHm/fuTh5OjVZqgq1jP2PLgDc/JKXSil+HGnCm7A==
X-Received: by 2002:a17:903:2a85:b0:235:2e0:aa9 with SMTP id d9443c01a7336-23ddb1a6e5bmr17280675ad.14.1752031844730;
        Tue, 08 Jul 2025 20:30:44 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3017ca59sm666369a91.27.2025.07.08.20.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 20:30:44 -0700 (PDT)
From: Jinliang Zheng <alexjlzheng@gmail.com>
X-Google-Original-From: Jinliang Zheng <alexjlzheng@tencent.com>
To: hch@infradead.org
Cc: alexjlzheng@gmail.com,
	alexjlzheng@tencent.com,
	brauner@kernel.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH] iomap: avoid unnecessary ifs_set_range_uptodate() with locks
Date: Wed,  9 Jul 2025 11:30:42 +0800
Message-ID: <20250709033042.249954-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <aGaLLHq3pRjGlO2W@infradead.org>
References: <aGaLLHq3pRjGlO2W@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 3 Jul 2025 06:52:44 -0700, Christoph Hellwig wrote:
> On Tue, Jul 01, 2025 at 10:48:47PM +0800, alexjlzheng@gmail.com wrote:
> > From: Jinliang Zheng <alexjlzheng@tencent.com>
> > 
> > In the buffer write path, iomap_set_range_uptodate() is called every
> > time iomap_end_write() is called. But if folio_test_uptodate() holds, we
> > know that all blocks in this folio are already in the uptodate state, so
> > there is no need to go deep into the critical section of state_lock to
> > execute bitmap_set().
> > 
> > Although state_lock may not have significant lock contention due to
> > folio lock, this patch at least reduces the number of instructions.
> 
> That means the uptodate bitmap is stale in that case.  That would

Hi, after days of silence, I re-read this email thread to make sure I
didn't miss something important.

I realized that maybe we are not aligned and I didn't understand your
sentence above. Would you mind explaining your meaning in more detail?

In addition, what I want to say is that once folio_test_uptodate() is
true, all bits in ifs->state are in the uptodate state. So there is no
need to acquire the lock and set it again. This repeated setting happens
in __iomap_write_end().

thanks,
Jinliang Zheng. :)

> only matter if we could clear the folio uptodate bit and still
> expect the page content to survive.  Which sounds dubious and I could
> not find anything relevant grepping the tree, but I'm adding the
> linux-mm list just in case.
> 
> > 
> > Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
> > ---
> >  fs/iomap/buffered-io.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 3729391a18f3..fb4519158f3a 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -71,6 +71,9 @@ static void iomap_set_range_uptodate(struct folio *folio, size_t off,
> >  	unsigned long flags;
> >  	bool uptodate = true;
> >  
> > +	if (folio_test_uptodate(folio))
> > +		return;
> > +
> >  	if (ifs) {
> >  		spin_lock_irqsave(&ifs->state_lock, flags);
> >  		uptodate = ifs_set_range_uptodate(folio, ifs, off, len);
> > -- 
> > 2.49.0
> > 
> > 
> ---end quoted text---


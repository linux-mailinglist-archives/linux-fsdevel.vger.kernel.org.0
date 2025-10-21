Return-Path: <linux-fsdevel+bounces-65012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F46BF942F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 01:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E983B3BC457
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 23:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1338C2C11FE;
	Tue, 21 Oct 2025 23:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="OXiEj+wP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E752BE7AB
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 23:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761089980; cv=none; b=FqVmFiHT+SJAPtWATqBYJDzn4gj49BHNB4MxqpAgb4s/FQ5MlFPFvSjynFIRMP2/BAtfLZZmyiK3oMetwvZtoq0iA36RYoNRiiVnCi++bolsLZr2Y9HAeX36d/HuPRzbYRW46UKNtG+JShtEVMZh6idiXCq7ieWSDm8AJ9699kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761089980; c=relaxed/simple;
	bh=uE6R0xgGK28/CHgA533bB00Mwj2oIm/4Ink+mD+7h90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzl6FhQPxYaS7+bIGWZis+Xm147ZWaFI28e3GGL92gFB0wOMcfRSwp0xw6xbeZm3z7ENrvblzxWlxR3SGPlLBhyeWd8BdK7Cr687crnYbDFZJyJ42tSjLi5ErqlT/5Y5rylBzuZ3eWzZKNY4/4UZzhvWpFea12mRcLKN7ifjpHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=OXiEj+wP; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so5092876b3a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 16:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1761089978; x=1761694778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ekz2VvXis0CGgykoGefhdHPuzvi4qz8tP9mZjwte4JE=;
        b=OXiEj+wP6lJ/KRjZH95Z1ThhYlDJOdfT9XeoG7CFq5ozwwwW4qpoCtTuZmK6Dp57J+
         SM5nym47cWult5crmWn0VN/IKQsvP05uVqMMvwcCkUduFsiD8/emPSsbQeq8l76rIGCl
         pblXh9+5xjLWZNxEJLGUz2fXbsvSXIvRD8cj8t7ZZc7Uq/tGTT4OnKZh2Ei12j9PXB7b
         n0JcGBGeDFFGpEI8CnPv3atnxLGXUdHVbGG5Wxnm9RGcEIge3BKU1/Wzul1QbgxN2A+4
         XyYc+xVCHDOQxPjuR7VCwJDCgdbSwk5Yindvh9fBF00LeqeU7MUleKupWFmXZiEQMVnE
         GWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761089978; x=1761694778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ekz2VvXis0CGgykoGefhdHPuzvi4qz8tP9mZjwte4JE=;
        b=vW6k0q8HVBt/hNwPImjivA9abhR4jiWvvSYZxTY+7ndfPDyapk1GVJjS3CHl5Fe8Kt
         Brr8wJFYUQ6RuQyoOAuXYbEyx0l+Nszt5G1ghJHV0IXl0NzUFgjL7RHMumzUIzOZ3NV6
         akZC4vSFcfOZOB9L31M/LbrlmPr8PtBULvdpO8hHZUWk9tvR3RvVbaa58bNPvLVp58bF
         6LiFD+Pz+OHsjb5bQAs5MgEXvmwcbHqJvBYzV+HwEljmvsfZU0eUrVkU6gZAn9vj0e9k
         AJD4ZckF8VN/26t5o/w5rYIwsOFSrI206AbRJzC3c25nGzZNwig/LBrofqE6B2w4fvQ8
         il+A==
X-Forwarded-Encrypted: i=1; AJvYcCWfiPjAkl2rmTaHLcfGQfXwSja/mUAUhg3Jp/G4IF5Z0tZfaaV/L+9e9XKMmpNUNuaCWD1zjXAhkPanzgFT@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhw5AKHACx5sDHbjfQR1Ai36MQpw5Ti3cAS/RRYvacQ3zwjtLS
	0FObpMgCOeRs21culEE09LyaCYoudTjaWmb/Af5k8eblRnc5U2Qs+IZ+3OOmalKtrg4=
X-Gm-Gg: ASbGnctN51WZpdrkxrTewXNxqtL5dQR1J1PRDU0Gq+6BfDVtQOBImjGcKIXVsBQLWuA
	LkblkWRDEhYcJul3Ro4iFzBRVtReHw2hDH1jzxxSE5p9RiA4BwZXndJrqAufRZels2YvTty+iS+
	3W9JdvDV2v6AzLT2jJ389jCkYNwIEK1kQzXl+6ZYRSNufEoGRH1nqVvaHZfyk8+mKbXdTxCoGIS
	TB75bG4TyKj3D/+7piL7BHqvH07uwfIPLox4BB6OYoj3NaDzNIM+e46Un4yeZqHRVc7eqKrIoG5
	omlg1AcxMcyDizpDora0WAPwH7taYDluAZFAcrG5MU9vGTGgVUBuL9ckdRw5LgvKsK6TYVYIHQO
	HwgS/t6llsoFKpxx/YDms2drAezY5F2cavkPPD8XbrTVq/5xRipBCIIWhg+J0E2bb1FPYvBh3z8
	LcD4ZNX1PeUI7BFUd1QRuNPxVn5iTVC9Fz2SnOCSC2XD3EgblJjBhgMJit/hdUQA==
X-Google-Smtp-Source: AGHT+IEeKxOQzdS4L5wZVGG2YsfGQ4VfOG5WxuGIyPNKK1Wog0FyGOuQbFK7NwXfAtyNg8VMiQjC4w==
X-Received: by 2002:a05:6300:8002:b0:33b:1dce:9941 with SMTP id adf61e73a8af0-33b1dce9c71mr125201637.45.1761089977976;
        Tue, 21 Oct 2025 16:39:37 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff15c89sm12888451b3a.1.2025.10.21.16.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:39:37 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1vBLx0-00000000NAO-1MVp;
	Wed, 22 Oct 2025 10:39:34 +1100
Date: Wed, 22 Oct 2025 10:39:34 +1100
From: Dave Chinner <david@fromorbit.com>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH] mm/filemap: Implement fast short reads
Message-ID: <aPgZthYaP7Flda0z@dread.disaster.area>
References: <20251017141536.577466-1-kirill@shutemov.name>
 <20251019215328.3b529dc78222787226bd4ffe@linux-foundation.org>
 <44ubh4cybuwsb4b6na3m4h3yrjbweiso5pafzgf57a4wgzd235@pgl54elpqgxa>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44ubh4cybuwsb4b6na3m4h3yrjbweiso5pafzgf57a4wgzd235@pgl54elpqgxa>

On Mon, Oct 20, 2025 at 12:33:08PM +0100, Kiryl Shutsemau wrote:
> On Sun, Oct 19, 2025 at 09:53:28PM -0700, Andrew Morton wrote:
> > On Fri, 17 Oct 2025 15:15:36 +0100 Kiryl Shutsemau <kirill@shutemov.name> wrote:
> > 
> > > From: Kiryl Shutsemau <kas@kernel.org>
> > > 
> > > The protocol for page cache lookup is as follows:
> > > 
> > >   1. Locate a folio in XArray.
> > >   2. Obtain a reference on the folio using folio_try_get().
> > >   3. If successful, verify that the folio still belongs to
> > >      the mapping and has not been truncated or reclaimed.

What about if it has been hole-punched?

The i_size checks after testing the folio is up to date catch races
with truncate down.  This "works" because truncate_setsize() changes
i_size before we invalidate the mapping and so we don't try to
access folios that have pending invalidation.

It also catches the case where the invalidation is only a partial
EOF folio zero (e.g. truncate down within the same EOF folio). In
this case, the deletion sequence number won't catch the invalidation
because no pages are freed from the page cache. Hence reads need to
check i_size to detect this case.

However, fallocate() operations such as hole punching and extent
shifting have exactly the same partial folio invalidation problems
as truncate but they don't change i_size like truncate does (both at
the front and rear edges of the ranges being operated on)

Hence invalidation races with fallocate() operations cannot be
detected via i_size checks and we have to serialise them differently.
fallocate() also requires barriers prevent new page cache operations
whilst the filesystem operation is in progress, so we actually need
the invalidation serialisation to also act as a page cache instantiation
barrier. This is what the mapping->invalidate_lock provides, and I
suspect that this new read fast path doesn't actually work correctly
w.r.t. fallocate() based invalidation because it can't detect races
with partial folio invalidations that are pending nor does it take
the mapping->invalidate_lock....

I also wonder if there might be other subtle races with
->remap_file_range based operations, because they also run
invalidations and need page cache instatiation barriers whilst the
operations run.  At least with XFS, remap operations hold both the
inode->i_rwsem and the mapping->invalidate_lock so nobody can access
the page cache across the destination range being operated on whilst
the extent mapping underlying the file is in flux.

Given these potential issues, I really wonder if this niche fast
path is really worth the potential pain racing against these sorts
of operations could bring us. It also increases the cognitive
load for anyone trying to understand how buffered reads interact
with everything else (i.e. yet another set of race conditions we
have to worry about when thinking about truncate!), and it is not
clear to me that it is (or can be made) safe w.r.t. more complex
invalidation interactions that filesystem have to handle these days.

So: is the benefit for this niche workload really worth the
additional complexity it adds to what is already a very complex set
of behaviours and interactions?

> > > +	if (!folio_test_referenced(folio))
> > > +		return 0;
> > > +
> > > +	/* i_size check must be after folio_test_uptodate() */
> > 
> > why?
> 
> There is comment for i_size_read() in slow path that inidicates that it
> is required, but, to be honest, I don't fully understand interaction
> uptodate vs i_size here.

As per above, it's detecting a race with a concurrent truncate that
is about to invalidate the folio but hasn't yet got to that folio in
the mapping.

This is where we'd also need to detect pending fallocate() or other
invalidations that are in progress, but there's no way to do that
easily....

-Dave.
-- 
Dave Chinner
david@fromorbit.com


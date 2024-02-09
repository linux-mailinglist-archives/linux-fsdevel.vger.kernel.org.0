Return-Path: <linux-fsdevel+bounces-10870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BE784EEAB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 02:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED949B233CD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 01:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466A81370;
	Fri,  9 Feb 2024 01:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="PewTwzEb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398D6A34
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 01:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707443721; cv=none; b=qhkSpR8qdmm6LGolz6N8BjXBsTFGNAmjcFOjzJUdLinLFn40Td41edR85wi8ilPA7vdSTg9fp+aTxcYB9WQdKnuyNqKNlhCf6OkXXVWXN6o8nEMTCUl910nBlkHrZ9RW+wS1cT6ihV54Iog8YducOq7hssUUA47nQPyR6b51ugc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707443721; c=relaxed/simple;
	bh=km8RfSoIhq4OlQItyglFP30YRBjC2JQ86CUek4SLJFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlgHCEvWGTIfiBWoaqrzcdG3Cl+uO6bMtUDm0htIK+k7L6/NlnGj0es7sP+ouK0RMarTCp5leUHirKcqX7KkpBh+dhD7WGqxElvVV4zZb36dRqQ9FwnV8uFw3ZrEyBQXyzs1q3+b0PR5vysUZaMKoOZ+dcejscxRddh+vEz2xYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=PewTwzEb; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d932f6ccfaso3769695ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Feb 2024 17:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1707443719; x=1708048519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FPcxmfF1K+emjGX7/juChDlmt4cDFHRmhTmTnNlE/Ts=;
        b=PewTwzEbHpz1Myll3pCkxUeLClRcyX0uqOX91Bmk8gPFOSn3PDOzb64LZrg2ruLpYC
         MbPWWJNF0GS2r/r4BJXOsBJLOi7e+SC6j8L4JHOsSTyWV69oQUE4mR/OHm0DLaRhrubG
         BY+QJorXARzhLIbdGVeHl2ogW0DLJaFZQVmK+J0pJBe+idBNh9QzYYh7AC09aRQkpgxK
         KrVnM7OtFR/UK8+uT+IHkqRSqn4JV3qPvmiJvQfsOfakQZQ+c9dN1SDdhhMepO/dM8uk
         DYfBcDlpNr7CPCMp0FluTD0d+gUJa6ErwYu4wHYrol7XikMtYQhMffkAJPNf1VCa2gVT
         hbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707443719; x=1708048519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPcxmfF1K+emjGX7/juChDlmt4cDFHRmhTmTnNlE/Ts=;
        b=arFbg5I2VvnGQLqZ68LlbNYb7P/PQOzAVpjnVBd9BU9JhJcltqcYjCxxbKnf8DCKCv
         hqXGfBkLElGCt2QBY0o0bNOVN+vuFqhDwtyhqLpI/ERwrHxHf7Wl8VNViGvNM8aBnGgf
         8h6VXKNYa5MBCk4J5UF2V1f3fJhZBLNwvQDc/HTJ3yThS3JhOOzt5V6eM74R0YRrGA4f
         4gP7mWL9D7WBwmAZy+rcYOmcUkyVBeDp4twAEsAI/bfUB0Gz+t7Jk1GGB9VHpjgsRz44
         KKDeI4Rd2YVgv6f63uuUmSV0cbXfHCAO+fD1qlMC8CygdjKjJg26PC9Ky40x4Bp+P/aF
         ameQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9ssDMXa43XjnjDct3bF2ptXGhTK8LzbGwDNptrsh23tG5FD4AzwWTXThcNC4OFCFNQbPBrnbe/KDwFqiDTSMJMj/FplKowBwMboyBrw==
X-Gm-Message-State: AOJu0YzYNCHTqOn/LT0rdC9T+Majbauv2t7gscAr121jaGB2r2Pk33u9
	NkmWZO9V1/XXZ19ISyBbkBMkqZKfy0WTnuGDvTSGof+cZKFylqzxThTh9/SJwHM=
X-Google-Smtp-Source: AGHT+IGGQ//i5yw3BV9iZEZHf7YAhLEeHJnu7fbFVOuv6QJ6Q3i2u60pix7ahaQAHDgvGPyN99ChrQ==
X-Received: by 2002:a17:903:40c7:b0:1d7:3067:aab5 with SMTP id t7-20020a17090340c700b001d73067aab5mr197967pld.57.1707443719552;
        Thu, 08 Feb 2024 17:55:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU1PvnZbiSzchAIBR5d5DntiI+g6t6bp6Qdq9z31jaP4L/jxarBoPRNW5d+fcFZ0eWMk6rfe7NF1+jTu9kD9QccvyK0vfbpjx5xzZWHll0K3V17nWt87wHGkPe28UmC4RaTINg7WPROmJY3pRQCn69HstkGwG5hwU2pBTgBDhu3I3fMGyRWCfREIfZ0ZVdF
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id kj11-20020a17090306cb00b001d8edfec673sm423161plb.214.2024.02.08.17.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 17:55:19 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rYG6m-003y41-2g;
	Fri, 09 Feb 2024 12:55:16 +1100
Date: Fri, 9 Feb 2024 12:55:16 +1100
From: Dave Chinner <david@fromorbit.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	lsf-pc <lsf-pc@lists.linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] tracing the source of errors
Message-ID: <ZcWGBLGYzNWZC+ze@dread.disaster.area>
References: <CAJfpegtw0-88qLjy0QDLyYFZEM7PJCG3R-mBMa9s8TNSVZmJTA@mail.gmail.com>
 <ZcP4GewZ9jPw5NbA@dread.disaster.area>
 <ZcT5540Bv7U8qoUa@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcT5540Bv7U8qoUa@casper.infradead.org>

On Thu, Feb 08, 2024 at 03:57:27PM +0000, Matthew Wilcox wrote:
> On Thu, Feb 08, 2024 at 08:37:29AM +1100, Dave Chinner wrote:
> > ftrace using the function_graph tracer will emit the return values
> > of the functions if you use it with the 'funcgraph-retval' option.
> 
> OK, but that may not be fine grained enough.  Why is mmap() returning
> -ENOMEM?
> 
> unsigned long do_mmap(struct file *file, unsigned long addr,
> ...
>        /* Careful about overflows.. */
>         len = PAGE_ALIGN(len);
>         if (!len)
>                 return -ENOMEM;
> ...
>         /* Too many mappings? */
>         if (mm->map_count > sysctl_max_map_count)
>                 return -ENOMEM;
> 
> So it can distinguish between mmap() returning ENOMEM because
> get_unmapped_area() returned ENOMEM and do_mmap() returning ENOMEM of
> its own accord (right?),

The call stack trace should tell you which function the error
originated from, yes?

> but it can't tell you which of the above two
> cases you hit.  Or can it?

Never used it, but it might be able to - the "sym-offset" option
will display exact offsets of the function in the trace. If you then
add "funcgraph-tail" it will emit the function being returned from.
If the return location is generated with an offset indicating the
actual return, then it might tell you the exact location.

If it doesn't, then this would seem like a reasonable thing to add
to ftrace - function return tracing with a filter to grab the return
location when the return value is less than 0 seems exactly the sort
of thing ftrace was intended to be used for...

-Dave.
-- 
Dave Chinner
david@fromorbit.com


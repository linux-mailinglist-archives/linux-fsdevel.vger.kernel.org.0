Return-Path: <linux-fsdevel+bounces-40162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91842A20015
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 22:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E19EC1656C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 21:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E332B1DB346;
	Mon, 27 Jan 2025 21:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="cgDgaDm3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67FC198E92
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jan 2025 21:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738014414; cv=none; b=ZUHcDiYeHNn767H8OSPg+0kKX4+v6qI7jWgy0rNZTK8Dp6WA+YXLKppnprk8pYw1rGgr+Itie0kiNJoGbKcGECR4ytRCgBBucoYlbpg2n1s6RGOIUGKgBJNcs+Dl3O39sJOxnkP+zemwyr9qB/ibuMm+EaN8gW0KkzEicuwCRXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738014414; c=relaxed/simple;
	bh=lxgjK/YaP9QEM+cP1snuQp98WWK2Il9QCcHaoiANiKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxr1er1Xh660qnZNSgNrfAU09ArlMui2m/JmrYNoGtqbM9k6S6HZv9qLhOCGPHYGZIQUUxretQ7NZSEzCUg+NSRXzFUjCoVNMu/WGDy+TvhaSN+6V2WQX2BVSyTk8JnGuQpL7YQ+enabL4EVFXNVcQ6hoRzYBIBZcJR6TtL/4qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=cgDgaDm3; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21675fd60feso110295605ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jan 2025 13:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1738014411; x=1738619211; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tE/pKF5Qpj4D13Y1PjIw9zjH1S0tIXaq7kjvEPBHMJ8=;
        b=cgDgaDm3rzgH0yHnpSdkcQdfoxaF9sdAf0+o4P3KdrS3v3uSKz5W26SQ4L6BaZ2ils
         Q1j2Q8YAQNomSw0pJBFfqg5aBsuUKc9l7XC/goX9cDdNUecpNpv2Jeh9ImT7u2flTbpT
         XyjBVv7I/jDMCO4h1rOI976OHJB8xoI4VezMig0c1KpuIwUltGtvCiz4ZfytWH1j19q7
         BDXz7ckrQEoAgq9b/WgUPNB00SDMnAzwfWHILo6QiiowwlBEVQxuQJ/xM3SUOUm4f7hp
         06bE+KHwxh+H8NXCtObTuX3jb9rA/jMVu0l2jg2vRmsgZZnSBah6jWTegYSj8z8TP0dy
         rGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738014411; x=1738619211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tE/pKF5Qpj4D13Y1PjIw9zjH1S0tIXaq7kjvEPBHMJ8=;
        b=b8dmsDD/4wynJPHoyphJsfrksqEP8mEIeJ8WhdJixNnBOxVFm9CojDcj0dbJ9oWZOj
         BqmCQdd+9oE90pv61dyzghMsowk+ys6p16lSVxAMTIYzW3QAf0sxQkYbVNg0XxC+byDB
         wooWqKwNzQ5UQdNROILNqHnf0oPtD8xfWlp2clDuJUg2ADdaoRcVAr7CyubEl4dKN2lE
         yi7mrUXj+OSXVeDdxF5xhYxQy2aBEMH7x1zkBT157q2JTqBcInDT7jBAIuJWePR+13iF
         XUoj3w2KuzB4AnbymVtMILxuu/L4W4BYhAjRHdy2pTlE+N0q0sss+tZ8F1oLXEtHXrip
         BT0A==
X-Forwarded-Encrypted: i=1; AJvYcCXwJSnr0kIPpabOa++j3Rki9B22DV0WGRd4P1TgyOiWVT5uyOMSV4ZVYmb4JGsyXh5CtaN7b/QvVyOyCFYF@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe043f/ltt1JKBsWP55xQOaE8heeAD0sFvSPPsBh7digxIrDBq
	00GHm6NEYcCThNqTkG8qrVi7AtlzbEA7lu02BN7A6pNI5ZRUUgn4Wm5E5CfoCus=
X-Gm-Gg: ASbGncuuNp5jcHZ2g8Ir8j1X8j5rMc9LIujDYvc7ZzIpQ2BzXwRJYjbVf3qpv/LlvBQ
	Jvk9DKkDgEUPdogeIwDurZGU9XxzFQZsRpPmof03ErMf82wrpl5t6vRlMwI1JILaQGRp/r0nqSo
	3CkCyyFf/hdrRRlEE9JcZlCNehaoubJNgWlN7K6rOz2U9EpXGn8XxreU5uU2/5dyNRGopDmDKIG
	SpOm6Ny4X27nyCno9DdbxJCgORBPRy6oVt3JBhuf1xdUUtx7RMXjx/3pGPhoF/AGriVZA8kYa3U
	IySc0TBASAgpC15BxGzXyoH5b04ANBMyImo6uVYFaiaL7/inMVy1Bsfq
X-Google-Smtp-Source: AGHT+IFOwuNx7AccdAPMTsFd/TrWMswt+hLsvIyhT6c29rKAdR6DsscbjKEXbJOOcqxAD+W5F/S89g==
X-Received: by 2002:a17:903:2306:b0:216:4676:dfaf with SMTP id d9443c01a7336-21c355eeb01mr670638065ad.34.1738014410766;
        Mon, 27 Jan 2025 13:46:50 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414edb3sm67875775ad.202.2025.01.27.13.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 13:46:50 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tcWwR-0000000BKHp-2nR9;
	Tue, 28 Jan 2025 08:46:47 +1100
Date: Tue, 28 Jan 2025 08:46:47 +1100
From: Dave Chinner <david@fromorbit.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Ext4 Developers List <linux-ext4@vger.kernel.org>,
	Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] ext4: use private version of page_zero_new_buffers() for
 data=journal mode
Message-ID: <Z5f-x278Z3wTIugL@dread.disaster.area>
References: <20151007154303.GC24678@thunk.org>
 <1444363269-25956-1-git-send-email-tytso@mit.edu>
 <yxyuijjfd6yknryji2q64j3keq2ygw6ca6fs5jwyolklzvo45s@4u63qqqyosy2>
 <CAHk-=wigdcg+FtWm5Fds5M2P_7GKSfXxpk-m9jkx0C6FMCJ_Jw@mail.gmail.com>
 <CAGudoHGJah8VNm6V1pZo2-C0P-y6aUbjMedp1SeAGwwDLua2OQ@mail.gmail.com>
 <CAHk-=wh=UVTC1ayTBTksd+mWiuA+pgLq75Ude2++ybAoSZAX3g@mail.gmail.com>
 <CAGudoHHyEQ1swCJkFDicb8hYYSMCXyMUcRVrtWkbeYwSChCmpQ@mail.gmail.com>
 <76b80fff-0f62-4708-95e6-87de272f35a5@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76b80fff-0f62-4708-95e6-87de272f35a5@intel.com>

On Mon, Jan 27, 2025 at 12:52:51PM -0800, Dave Hansen wrote:
> On 1/26/25 14:45, Mateusz Guzik wrote:
> >>
> >> So if you don't get around to it, and _if_ I remember this when the
> >> merge window is open, I might do it in my local tree, but then it will
> >> end up being too late for this merge window.
> >>
> > The to-be-unreverted change was written by Dave (cc'ed).
> > 
> > I had a brief chat with him on irc, he said he is going to submit an
> > updated patch.
> 
> I poked at it a bit today. There's obviously been the page=>folio churn
> and also iov_iter_fault_in_readable() got renamed and got some slightly
> new semantics.
....

> Anyway, here's a patch that compiles, boots and doesn't immediately fall
> over on ext4 in case anyone else wants to poke at it. I'll do a real
> changelog, SoB, etc.... and send it out for real tomorrow if it holds up.

> 
> index 4f476411a9a2d..98b37e4c6d43c 100644
> 
> ---
> 
>  b/mm/filemap.c |   25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff -puN mm/filemap.c~generic_perform_write-1 mm/filemap.c
> --- a/mm/filemap.c~generic_perform_write-1	2025-01-27 09:53:13.219120969 -0800
> +++ b/mm/filemap.c	2025-01-27 12:28:40.333920434 -0800
> @@ -4027,17 +4027,6 @@ retry:
>  		bytes = min(chunk - offset, bytes);
>  		balance_dirty_pages_ratelimited(mapping);
>  
> -		/*
> -		 * Bring in the user page that we will copy from _first_.
> -		 * Otherwise there's a nasty deadlock on copying from the
> -		 * same page as we're writing to, without it being marked
> -		 * up-to-date.
> -		 */
> -		if (unlikely(fault_in_iov_iter_readable(i, bytes) == bytes)) {
> -			status = -EFAULT;
> -			break;
> -		}
> -
>  		if (fatal_signal_pending(current)) {
>  			status = -EINTR;
>  			break;
> @@ -4055,6 +4044,11 @@ retry:
>  		if (mapping_writably_mapped(mapping))
>  			flush_dcache_folio(folio);
>  
> +		/*
> +		 * This needs to be atomic because actually handling page
> +		 * faults on 'i' can deadlock if the copy targets a
> +		 * userspace mapping of 'folio'.
> +		 */
>  		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
>  		flush_dcache_folio(folio);
>  
> @@ -4080,6 +4074,15 @@ retry:
>  				bytes = copied;
>  				goto retry;
>  			}
> +			/*
> +			 * 'folio' is now unlocked and faults on it can be
> +			 * handled. Ensure forward progress by trying to
> +			 * fault it in now.
> +			 */
> +                        if (fault_in_iov_iter_readable(i, bytes) == bytes) {
> +                                status = -EFAULT;
> +                                break;
> +                        }
>  		} else {
>  			pos += status;
>  			written += status;

Shouldn't all the other places that have exactly the same
fault_in_iov_iter_readable()/copy_folio_from_iter_atomic() logic
and comments (e.g.  iomap_write_iter()) be changed to do this the
same way as this new code in generic_perform_write()?

-Dave.
-- 
Dave Chinner
david@fromorbit.com


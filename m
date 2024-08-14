Return-Path: <linux-fsdevel+bounces-25882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CF79513FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 07:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16CDFB21888
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 05:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF05502B1;
	Wed, 14 Aug 2024 05:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="N9CcwDCj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7673920B0F
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 05:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723614131; cv=none; b=e+jRJmVXz2+n2NkLzFl2iDKsmnthE8ucMVLRzhZnOc6FuwrrnCOy1YOMdDhnY7grJR9nUTL8pY8IlMAMbB9AN/Cd27yfhJiTXgBOwLZTA3OqRvi+ZVobMvhc6TS3ZXbcaWtpDAUIsJS/0JSCS0wmQRlZYf2y9yrQu/+kxQPfcNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723614131; c=relaxed/simple;
	bh=gktj6fi0bMNMpMio16krDpOfCfMSkqGI+TFidwvFj1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yxlto9rjj23MTAADzL2/eDdsyhEE42L9913dsPCzBf2SQlaOANp9VC8UY6qK2Xz7P9DPEc1K+qKp6mKr2hds5ufGrKAIJ+65FiWcKTA8HIzxFg18bjXNrtzdnbLRRkJMn0ZLSVXpSToqkvl8mvtV5FCxfDvJt0D8XaNqIFGVNt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=N9CcwDCj; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70d23caf8ddso5480858b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 22:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1723614129; x=1724218929; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2xThy7G5turHsTiFyeJ9AMtp0dOmT8fMh/o92Prf5HU=;
        b=N9CcwDCjQh5GfzYfBtMp2Q+T+i8z8bUeCN7oa1Iy2jVf6ueiBsOGStoLw6uYxpB2Sd
         u/Nuno34ju61cpl3PyK9Cxroboek6RL2lOXbz8MPIJ97RUJeIl/vIStlvNdN4jKowsUb
         BN6iNI66tJstHFfkZxX5PJpXqUdP5QHuCjWpNWfx2AJsaOy4ZLMVowXyRXwC4q4k4i4e
         Hw8KIJ4q9EJEoUZQzqQuJe4XTVzOCWa82ISPsv+BMwqBy2xM1cyrfNCxOBZOwKRqW6Lb
         prZDqSLSCM4ZWfIiIxybS5doXN9qazu9sg6dyzVc3DggOf+vHWpOkISKhylGGryhNAoi
         0ewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723614129; x=1724218929;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2xThy7G5turHsTiFyeJ9AMtp0dOmT8fMh/o92Prf5HU=;
        b=GHDIcffYtXuqAjZbYbGdAt3XRJwK6sC10RgkKS3gzSk5VNdlVqdAbqQ9fubxmSgYmV
         lb6VSvsipvhhRA/aJjUpzSFXED+DtdZHGiFt7i44xl9Hib/aTfKAmX9WIBetZEdYql+L
         9oiOj0R1yhTgkZj5NVAsZEuizK6v5ee+1fC+6rG41tk+NY28bPHablYwPRHZpG7xzEGk
         8nXm3Rp+lmzZPRmnSud8M28Dvfdq22pHXwu+eBOxeLAJqlBsL/IJn26THsRK2o8L1mjt
         3pwNn+6FRKcND2hdSJZJdbw7SBtDU+7TUGWsvYDKg7RPqx3ue3+YD9GlWC7nx8FU5ZQP
         79rg==
X-Forwarded-Encrypted: i=1; AJvYcCUji/B32UNzp4bDh5kSlK2n6K4abRyfI0V7pDDovU/Xz3vjzBbrGR1MSDDyB3cfgoI3d8O6dy+cKRNr3zuR/y6oRp+OI5QE6rK+9ZL2Zw==
X-Gm-Message-State: AOJu0YzvELF7UvTVN52ZxVSpS6x8NXgGgHw9sXtbsuJOOazbktMWXlWU
	F9oGv+FgZYmj2uEJLNDt/xCnywCoz2/yzCNGrXqXCdRyiWDrnR5rZwfYyxSwTNU=
X-Google-Smtp-Source: AGHT+IFzgtfdVJw2YmfGXvfYUxRq68O3860D/avVRnbR5lVSvLogif4/KElpAzV9WjmtAh8Hc2c+xw==
X-Received: by 2002:a05:6a00:1ad1:b0:706:29e6:2ed2 with SMTP id d2e1a72fcca58-712670fa392mr2756945b3a.5.1723614129018;
        Tue, 13 Aug 2024 22:42:09 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5a4a609sm6567500b3a.119.2024.08.13.22.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 22:42:08 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1se6lp-00GSZP-2r;
	Wed, 14 Aug 2024 15:42:05 +1000
Date: Wed, 14 Aug 2024 15:42:05 +1000
From: Dave Chinner <david@fromorbit.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH 1/2] mm: Add memalloc_nowait_{save,restore}
Message-ID: <ZrxDrSjOJRmjTGvM@dread.disaster.area>
References: <20240812090525.80299-1-laoar.shao@gmail.com>
 <20240812090525.80299-2-laoar.shao@gmail.com>
 <Zrv6Fts73FECScyd@dread.disaster.area>
 <CALOAHbAfQPdpXt0SHGxQdJEi1R_u+1x2KSwZ5XfrQD-sQmhKiA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbAfQPdpXt0SHGxQdJEi1R_u+1x2KSwZ5XfrQD-sQmhKiA@mail.gmail.com>

On Wed, Aug 14, 2024 at 10:19:36AM +0800, Yafang Shao wrote:
> On Wed, Aug 14, 2024 at 8:28 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Mon, Aug 12, 2024 at 05:05:24PM +0800, Yafang Shao wrote:
> > > The PF_MEMALLOC_NORECLAIM flag was introduced in commit eab0af905bfc
> > > ("mm: introduce PF_MEMALLOC_NORECLAIM, PF_MEMALLOC_NOWARN"). To complement
> > > this, let's add two helper functions, memalloc_nowait_{save,restore}, which
> > > will be useful in scenarios where we want to avoid waiting for memory
> > > reclamation.
> >
> > Readahead already uses this context:
> >
> > static inline gfp_t readahead_gfp_mask(struct address_space *x)
> > {
> >         return mapping_gfp_mask(x) | __GFP_NORETRY | __GFP_NOWARN;
> > }
> >
> > and __GFP_NORETRY means minimal direct reclaim should be performed.
> > Most filesystems already have GFP_NOFS context from
> > mapping_gfp_mask(), so how much difference does completely avoiding
> > direct reclaim actually make under memory pressure?
> 
> Besides the __GFP_NOFS , ~__GFP_DIRECT_RECLAIM also implies
> __GPF_NOIO. If we don't set __GPF_NOIO, the readahead can wait for IO,
> right?

There's a *lot* more difference between __GFP_NORETRY and
__GFP_NOWAIT than just __GFP_NOIO. I don't need you to try to
describe to me what the differences are; What I'm asking you is this:

> > i.e. doing some direct reclaim without blocking when under memory
> > pressure might actually give better performance than skipping direct
> > reclaim and aborting readahead altogether....
> >
> > This really, really needs some numbers (both throughput and IO
> > latency histograms) to go with it because we have no evidence either
> > way to determine what is the best approach here.

Put simply: does the existing readahead mechanism give better results
than the proposed one, and if so, why wouldn't we just reenable
readahead unconditionally instead of making it behave differently
for this specific case?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com


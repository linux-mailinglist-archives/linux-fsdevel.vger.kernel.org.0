Return-Path: <linux-fsdevel+bounces-6489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEB3818839
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 14:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5C63B24F16
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 13:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE22418E2A;
	Tue, 19 Dec 2023 13:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dilU4n7r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BDE18E13;
	Tue, 19 Dec 2023 13:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Aso/PSABcXQ/18wC+IQ9g/IA0o4shEADqRKW81TUoxw=; b=dilU4n7ryxuYedzFlRzioKja08
	4qj4ySuGV9Ae6scuCXIItPCot64QClJ3OZL0DgZB1yBLjM7y/FcLrj1rvgWN8c7Zr0E5riKO2k0RE
	DUgvs/tfgogxwmzjpe/1h5UZl+e4jDniEebdOYXZVtVvww2NBkcIctFHWyYnCGiueh18lET6gfdGy
	XnblBn1md0RYvkpieKhEV22DdCyikiwtmTJY6E2ISWD1LSvLFuRX9N8Hqf4Vx1ITNQf10gamCX5/v
	hMgDUxOZCRiFaK/z7sdIIKcFI33+jI5CqyhInR1ylG7vEbtJdw/2aj0HsbuILnihcFPhQKLNct1xV
	vlz4RYcQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rFZjG-002z7C-LZ; Tue, 19 Dec 2023 13:01:46 +0000
Date: Tue, 19 Dec 2023 13:01:46 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: shr@devkernel.io, akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm: fix arithmetic for max_prop_frac when setting
 max_ratio
Message-ID: <ZYGUOslxxwe1sNzR@casper.infradead.org>
References: <20231219024246.65654-1-jefflexu@linux.alibaba.com>
 <20231219024246.65654-3-jefflexu@linux.alibaba.com>
 <ZYEWyn5g/jG/ixMk@casper.infradead.org>
 <5460aaf1-44f6-475f-b980-cb9058cc1df4@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5460aaf1-44f6-475f-b980-cb9058cc1df4@linux.alibaba.com>

On Tue, Dec 19, 2023 at 01:58:21PM +0800, Jingbo Xu wrote:
> On 12/19/23 12:06 PM, Matthew Wilcox wrote:
> > On Tue, Dec 19, 2023 at 10:42:46AM +0800, Jingbo Xu wrote:
> >>  	} else {
> >>  		bdi->max_ratio = max_ratio;
> >> -		bdi->max_prop_frac = (FPROP_FRAC_BASE * max_ratio) / 100;
> >> +		bdi->max_prop_frac = div64_u64(FPROP_FRAC_BASE * max_ratio,
> >> +					       100 * BDI_RATIO_SCALE);
> >>  	}
> > 
> > Why use div64_u64 here?
> > 
> > FPROP_FRAC_BASE is an unsigned long.  max_ratio is an unsigned int, so
> > the numerator is an unsigned long.  BDI_RATIO_SCALE is 10,000, so the
> > numerator is an unsigned int.  There's no 64-bit arithmetic needed here.
> 
> Yes, div64_u64() is actually not needed here. So it seems
> 
> bdi->max_prop_frac = FPROP_FRAC_BASE * max_ratio / 100 / BDI_RATIO_SCALE;
> 
> is adequate?

I'd rather spell that as:

		bdi->max_prop_frac = (FPROP_FRAC_BASE * max_ratio) /
					(100 * BDI_RATIO_SCALE);

It's closer to how you'd write it out mathematically and so it reads
more easily.  At least for me.


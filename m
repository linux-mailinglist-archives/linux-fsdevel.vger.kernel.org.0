Return-Path: <linux-fsdevel+bounces-10781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F1384E486
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 16:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CC911C23CED
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 15:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6917C7D3E7;
	Thu,  8 Feb 2024 15:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NvpUrVWo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAFE78667;
	Thu,  8 Feb 2024 15:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707407852; cv=none; b=AzCvF2wJkZLJjmYgFbs6WSnDXhcPdR80L5PaiWkCm4lGlODAzqP4vtUOs9xG9XC/VShmx/gicuavGZ8skX38VYuji5zsu+YKe0tq8IQrr6WaOCxIkZnqX703FuZfHWpn1I1XRA/kKbOI5ZCcffPLHm1TnQoTkYQPEUV4EtOv2/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707407852; c=relaxed/simple;
	bh=bkgCg8au7LfeVfvNrJ66O6mKN9DrBki99ad9iLLkyBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iz4LCj0VlF92HW3No6w22y5Ca+Kj1OghKdfeant1U7MTsOXtSW16s79/iaaGiPgR/pZgVHIUV8kcoeTBuj86YlYL/56DfcSlLnGY+EFvjeTgQh3B58tW9uK7kEt2mls9jm6mBAL46U4Z+X0Jqv+WHCNf0mxTM5DY6e8bxpsmPqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NvpUrVWo; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pZmjNkOlpDcLyDisihTSliS4k10LTq4xXnsbeSxuXWg=; b=NvpUrVWopC7y/fN0hniAwnZUrE
	GDAw/K1WrEhvtcw6Dy4HEgE9sG60nUVRgk0CvCfln6O6LMxlZo/Naq/YjOQQZv8/lABeLOK5+Y+24
	oOErLvks2G5v4alWiuLu4957oAZ1riLKWS9hEcIgTs/6VNBKLkliXLdWYzLDyEpjGisbffXvvssco
	UgAbrWgO3O+MYig/a/MyubvhnxXbvHHF1+NuszDyNjFs04oRmNsvo3+LSiy6TILutZQ7ImCdH+NOa
	ZRitkZWiEok09+OZj385yeIZCz9tEnzV2+bN9YhaiKo/VakwnYKAq80lcctiCMD9l+XfCuki5xh+h
	1aZX/33A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rY6mF-00000000cFf-3uYW;
	Thu, 08 Feb 2024 15:57:27 +0000
Date: Thu, 8 Feb 2024 15:57:27 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	lsf-pc <lsf-pc@lists.linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] tracing the source of errors
Message-ID: <ZcT5540Bv7U8qoUa@casper.infradead.org>
References: <CAJfpegtw0-88qLjy0QDLyYFZEM7PJCG3R-mBMa9s8TNSVZmJTA@mail.gmail.com>
 <ZcP4GewZ9jPw5NbA@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcP4GewZ9jPw5NbA@dread.disaster.area>

On Thu, Feb 08, 2024 at 08:37:29AM +1100, Dave Chinner wrote:
> ftrace using the function_graph tracer will emit the return values
> of the functions if you use it with the 'funcgraph-retval' option.

OK, but that may not be fine grained enough.  Why is mmap() returning
-ENOMEM?

unsigned long do_mmap(struct file *file, unsigned long addr,
...
       /* Careful about overflows.. */
        len = PAGE_ALIGN(len);
        if (!len)
                return -ENOMEM;
...
        /* Too many mappings? */
        if (mm->map_count > sysctl_max_map_count)
                return -ENOMEM;

So it can distinguish between mmap() returning ENOMEM because
get_unmapped_area() returned ENOMEM and do_mmap() returning ENOMEM of
its own accord (right?), but it can't tell you which of the above two
cases you hit.  Or can it?


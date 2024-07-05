Return-Path: <linux-fsdevel+bounces-23198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A64CF9288EB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 14:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D452282EC7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 12:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8DD14D6E0;
	Fri,  5 Jul 2024 12:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="HnrTJ3hX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AB214B94C;
	Fri,  5 Jul 2024 12:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720183567; cv=none; b=q7NZYKisb8lOrqDlylJ6aLnZlA7hJda6vSIWPCmELMHmjjaLk8Zp0DN2CXEbqpFNOZc4MrQE6grTj68hDDTieCZTIW9MXCu2gG6UVpByFMcPdVav0OmXZmGk+UMhIj4cnuuTmGcKE86ysKo6qoH/0JlT7GJ9Bss/4ehRS2EJCjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720183567; c=relaxed/simple;
	bh=kvzYcoBRB6muJWISQbz3/uX6QREXqC6XkTMnu+4vIY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBIIhq50NwH9OqCQArYGpz3tWPRkFfw4BCFlIX2aDicOmCR5UvhoOqJ1qi+3nAYhfDfQzqdmMz2TkOsVCcAjEO1/r3IaJUoAg5PlHRMKVAGr9vANuvQkQtV9EeW7yiGZFKetnx4HanCdB2xh6utZ6szTq2io6YTkKhRvicFW8Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=HnrTJ3hX; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WFtY35G6lz9snG;
	Fri,  5 Jul 2024 14:45:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1720183559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KiRhD8gjkNly0VzoFRI/T7DqOqqz5F9zI7sRKqsklio=;
	b=HnrTJ3hXg4TcedHC4quAPAipQIsjo92Sc1NxBYqY1oxDv/2/xTIRKMj9lN5xgioJHLBOvK
	L0kp+qNcxHWsthfLROMVJ1XNZ6mJIoYmiLlGV/Wz8huHAlDVytbSnMI45rxG4tnTi3NnV/
	30bBFuvbW5VdXc3jAGZ/U0e9HxpHarwN/JTL8FBAHg0hALF1EYoWhw0GfzrkpNwBoOT7iv
	0cW2aGm+9D6CQVf8szISEWTgjnujRJCIITzrxPr2okAWHuL6Mk7H9wi0lS8qfKw5748cN7
	jIhj5Epz1cL0V2xd0LyxZV7mP8sVPuaROr2P/HUAn+w98xwT9/a+PMbWhoM6uQ==
Date: Fri, 5 Jul 2024 12:45:52 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Dave Chinner <david@fromorbit.com>,
	Matthew Wilcox <willy@infradead.org>, chandan.babu@oracle.com,
	djwong@kernel.org, brauner@kernel.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
	mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, hch@lst.de, Zi Yan <zi.yan@sent.com>
Subject: Re: [PATCH v8 01/10] fs: Allow fine-grained control of folio sizes
Message-ID: <20240705124552.oastd7oyxs3u75yo@quentin>
References: <20240625114420.719014-1-kernel@pankajraghav.com>
 <20240625114420.719014-2-kernel@pankajraghav.com>
 <cb644a36-67a7-4692-b002-413e70ac864a@arm.com>
 <Zoa9rQbEUam467-q@casper.infradead.org>
 <Zocc+6nIQzfUTPpd@dread.disaster.area>
 <Zoc2rCPC5thSIuoR@casper.infradead.org>
 <Zod3ZQizBL7MyWEA@dread.disaster.area>
 <03b9ea6c-a3c4-41e8-ad47-4e82344da419@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03b9ea6c-a3c4-41e8-ad47-4e82344da419@arm.com>

On Fri, Jul 05, 2024 at 10:03:31AM +0100, Ryan Roberts wrote:
> On 05/07/2024 05:32, Dave Chinner wrote:
> > On Fri, Jul 05, 2024 at 12:56:28AM +0100, Matthew Wilcox wrote:
> >> On Fri, Jul 05, 2024 at 08:06:51AM +1000, Dave Chinner wrote:
> >>>>> It seems strange to silently clamp these? Presumably for the bs>ps usecase,
> >>>>> whatever values are passed in are a hard requirement? So wouldn't want them to
> >>>>> be silently reduced. (Especially given the recent change to reduce the size of
> >>>>> MAX_PAGECACHE_ORDER to less then PMD size in some cases).
> >>>>
> >>>> Hm, yes.  We should probably make this return an errno.  Including
> >>>> returning an errno for !IS_ENABLED() and min > 0.
> >>>
> >>> What are callers supposed to do with an error? In the case of
> >>> setting up a newly allocated inode in XFS, the error would be
> >>> returned in the middle of a transaction and so this failure would
> >>> result in a filesystem shutdown.
> >>
> >> I suggest you handle it better than this.  If the device is asking for a
> >> blocksize > PMD_SIZE, you should fail to mount it.
> 
> A detail, but MAX_PAGECACHE_ORDER may be smaller than PMD_SIZE even on systems
> with CONFIG_TRANSPARENT_HUGEPAGE as of a fix that is currently in mm-unstable:

> 
> 	#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> 	#define PREFERRED_MAX_PAGECACHE_ORDER	HPAGE_PMD_ORDER
> 	#else
> 	#define PREFERRED_MAX_PAGECACHE_ORDER	8
> 	#endif
> 
> 	/*
> 	 * xas_split_alloc() does not support arbitrary orders. This implies no
> 	 * 512MB THP on ARM64 with 64KB base page size.
> 	 */
> 	#define MAX_XAS_ORDER		(XA_CHUNK_SHIFT * 2 - 1)
> 	#define MAX_PAGECACHE_ORDER	min(MAX_XAS_ORDER,
> 					    PREFERRED_MAX_PAGECACHE_ORDER)
> 
> But that also implies that the page cache can handle up to order-8 without
> CONFIG_TRANSPARENT_HUGEPAGE so sounds like there isn't a dependcy on
> CONFIG_TRANSPARENT_HUGEPAGE in this respect?
> 

I remember seeing willy's comment about dependency on CONFIG_TRANSPARENT_HUGEPAGE 
for large folios[0]:

Some parts of the VM still depend on THP to handle large folios
correctly.  Until those are fixed, prevent creating large folios
if THP are disabled.

This was Jan of 2022. I don't know the status of it now but we enable
large folios for filesystem only when THP is enabled(as you can see in
the helpers mapping_set_folio_order_range()).

[0] https://lore.kernel.org/lkml/20220116121822.1727633-8-willy@infradead.org/


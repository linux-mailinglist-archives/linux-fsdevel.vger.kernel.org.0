Return-Path: <linux-fsdevel+bounces-33639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 447829BC0B5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 23:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D736B21868
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 22:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC52D1FDF89;
	Mon,  4 Nov 2024 22:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="M4itB+t5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741E92AF12
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Nov 2024 22:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730758607; cv=none; b=GD7+I01pxLDtP1hwVCNHpTIum8L6xoKwJ30o60+mFxr/2bwQ/3Uc6Fwif1b/UC9l1+2iHmQdmWb/xUArTFGbXbMGxEQBRVqFgCz/Jxh6gRax+pCGnAWgkheQfvwgapG8qhj4dd11yAm8yKjcRUYfgKHU5BnzyfdcJIbSH0NozR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730758607; c=relaxed/simple;
	bh=KspYLPaVUiBiulhfcb/F9ddte9kdJsUyFpLrtdXID7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ns3bfi992wireHH54d6/+H+/TzwOeJKmpa3v15BOg5HoXUunbmVnP4wWjEf+vpGKK4Eanf1c2XKSz/Af3+LSvSTpzK4nroJN+Y16NomHZ0WTMxzj58lGZY0y5MUa1JwBpi1ZnHZD3h0PX+lSd4Q3KRdbl9dnBNjGA8szxr/n+0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=M4itB+t5; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7eda47b7343so2960127a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Nov 2024 14:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1730758604; x=1731363404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wx+CQscmonr+En4OMi1iBJFsPpXGN7GSbg6rvgqJS3g=;
        b=M4itB+t5OimE8V9OPKgJxb7E60XFbYR2AclUAcNobyP3WdwMxaQhNBdNNMiD7hVWHS
         8e8tuYJXKHvgCuo5dVTtN0zBiES0RMfQimxML1l+ETF0TV+gMivsMnjWKqi6qebEof7D
         CoHp40hIEZS0Z+VdLEsKdkdF4I/Y4CR1VqDGRY3n+3PlnR/woLETODcrqJxhLCjbNYtV
         uTcoKV65VJkVm3Ct/FNfxoScxifNjT+9uoUILNqrAQ/pmneFFNM5ccmWrtrO3Zza7Ss2
         SZ6Sal6G7x1u/jVt6t1ZBoy2Y42T089rX2DGhxkMZC8r5XlYf190TfPHzcs8rCchdsD8
         dM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730758604; x=1731363404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wx+CQscmonr+En4OMi1iBJFsPpXGN7GSbg6rvgqJS3g=;
        b=C4zjMeKEtM/1as88LT4fTSX5F3uBNlY5rMBA7h/rk61O2P9OWZZM6bgT+MjPftvvnF
         VXW1nX3dQB9cJxW0TRq6oCJwhw/GhlqEna2C1DkOqo3Ovf7yCG5OgvOoXdPDXqqCpZni
         X4XSg8dWPo0m+a+enUnw1TS2P9sDXVseAp0s7hTDxxWk1X48DyjJk05Q8164sLKrqFbl
         skowCltOL2UR9KEDoD9Wp6iXUcdaz6uNLVu4ODempVnuWn9055Hi7pwy5e4nBbpwo21A
         KpHWVvjxI+bYRG5HfLAStr0rv3DvthII5BimrW6PyK9BjAzFd7Z4T1TGXj1TgilD6SM+
         GsTA==
X-Forwarded-Encrypted: i=1; AJvYcCUBQQQkBH8aDl9NEFBqLmq7KWDhsedA3ACE7VuoeNctZnSCNyhVOcRWoSVAchb/Lj+QEXAfj0w7Jpks9xsM@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh80O9DXDK0CXam0M4BGDGQSBp2+wxpdw/Kdof5B2nWnwOwB7Y
	KM+j+TeuW1JUOuom3m40PnkMKB7GYPH4OSnTRhD3PXR36BmY9jkPXBjMdzi/m/M=
X-Google-Smtp-Source: AGHT+IH/GmFwfz/KLQqwABZCJIOJSQdacBDN9n3cToWkKGuNB5vkYCzMkd096fPZfHkRC1ZU+KBkfQ==
X-Received: by 2002:a17:902:e80c:b0:20b:b93f:300a with SMTP id d9443c01a7336-210c6872dabmr463716335ad.7.1730758603626;
        Mon, 04 Nov 2024 14:16:43 -0800 (PST)
Received: from dread.disaster.area (pa49-186-86-168.pa.vic.optusnet.com.au. [49.186.86.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21105708681sm65856185ad.89.2024.11.04.14.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 14:16:43 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1t85NI-00AE83-1f;
	Tue, 05 Nov 2024 09:16:40 +1100
Date: Tue, 5 Nov 2024 09:16:40 +1100
From: Dave Chinner <david@fromorbit.com>
To: Asahi Lina <lina@asahilina.net>
Cc: Jan Kara <jack@suse.cz>, Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Sergio Lopez Pascual <slp@redhat.com>,
	linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH] dax: Allow block size > PAGE_SIZE
Message-ID: <ZylHyD7Z+ApaiS5g@dread.disaster.area>
References: <20241101-dax-page-size-v1-1-eedbd0c6b08f@asahilina.net>
 <20241104105711.mqk4of6frmsllarn@quack3>
 <7f0c0a15-8847-4266-974e-c3567df1c25a@asahilina.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f0c0a15-8847-4266-974e-c3567df1c25a@asahilina.net>

On Tue, Nov 05, 2024 at 12:31:22AM +0900, Asahi Lina wrote:
> 
> 
> On 11/4/24 7:57 PM, Jan Kara wrote:
> > On Fri 01-11-24 21:22:31, Asahi Lina wrote:
> >> For virtio-dax, the file/FS blocksize is irrelevant. FUSE always uses
> >> large DAX blocks (2MiB), which will work with all host page sizes. Since
> >> we are mapping files into the DAX window on the host, the underlying
> >> block size of the filesystem and its block device (if any) are
> >> meaningless.
> >>
> >> For real devices with DAX, the only requirement should be that the FS
> >> block size is *at least* as large as PAGE_SIZE, to ensure that at least
> >> whole pages can be mapped out of the device contiguously.
> >>
> >> Fixes warning when using virtio-dax on a 4K guest with a 16K host,
> >> backed by tmpfs (which sets blksz == PAGE_SIZE on the host).
> >>
> >> Signed-off-by: Asahi Lina <lina@asahilina.net>
> >> ---
> >>  fs/dax.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Well, I don't quite understand how just relaxing the check is enough. I
> > guess it may work with virtiofs (I don't know enough about virtiofs to
> > really tell either way) but for ordinary DAX filesystem it would be
> > seriously wrong if DAX was used with blocksize > pagesize as multiple
> > mapping entries could be pointing to the same PFN which is going to have
> > weird results.
> 
> Isn't that generally possible by just mapping the same file multiple
> times? Why would that be an issue?

I think what Jan is talking about having multiple inode->i_mapping
entries point to the same pfn, not multiple vm mapped regions
pointing at the same file offset....

> Of course having a block size smaller than the page size is never going
> to work because you would not be able to map single blocks out of files
> directly. But I don't see why a larger block size would cause any
> issues. You'd just use several pages to map a single filesystem block.

If only it were that simple.....

> For example, if the block size is 16K and the page size is 4K, then a
> single file block would be DAX mapped as four contiguous 4K pages in
> both physical and virtual memory.

Up until 6.12, filesystems on linux did not support block size >
page size. This was a constraint of the page cache implementation
being based around the xarray indexing being tightly tied to
PAGE_SIZE granularity indexing. Folios and large folio support
provided the infrastructure to allow indexing to increase to order-N
based index granularity. It's only taken 20 years to get a solution
to this problem merged, but it's finally there now.

Unfortunately, the DAX infrastructure is independent of the page
cache but is also tightly tied to PAGE_SIZE based inode->i_mapping
index granularity. In a way, this is even more fundamental than the
page cache issues we had to solve. That's because we don't have
folios with their own locks and size tracking. In DAX, we use the
inode->i_mapping xarray entry for a given file offset to -serialise
access to the backing pfn- via lock bits held in the xarray entry.
We also encode the size of the dax entry in bits held in the xarray
entry.

The filesystem needs to track dirty state with filesystem block
granularity. Operations on filesystem blocks (e.g. partial writes,
page faults) need to be co-ordinated across the entire filesystem
block. This means we have to be able to lock a single filesystem
block whilst we are doing instantiation, sub-block zeroing, etc.

Large folio support in the page cache provided this "single tracking
object for a > PAGE_SIZE range" support needed to allow fsb >
page_size in filesystems. The large folio spans the entire
filesystem block, providing a single serialisation and state
tracking for all the page cache operations needing to be done on
that filesystem block.

The DAX infrastructure needs the same changes for fsb > page size
support. We have a limited number bits we can use for DAX entry
state:

/*
 * DAX pagecache entries use XArray value entries so they can't be mistaken
 * for pages.  We use one bit for locking, one bit for the entry size (PMD)
 * and two more to tell us if the entry is a zero page or an empty entry that
 * is just used for locking.  In total four special bits.
 *
 * If the PMD bit isn't set the entry has size PAGE_SIZE, and if the ZERO_PAGE
 * and EMPTY bits aren't set the entry is a normal DAX entry with a filesystem
 * block allocation.
 */
#define DAX_SHIFT       (4)
#define DAX_LOCKED      (1UL << 0)
#define DAX_PMD         (1UL << 1)
#define DAX_ZERO_PAGE   (1UL << 2)
#define DAX_EMPTY       (1UL << 3)

I *think* that we have at most PAGE_SHIFT worth of bits we can
use because we only store the pfn part of the pfn_t in the dax
entry. There are PAGE_SHIFT high bits in the pfn_t that hold
pfn state that we mask out.

Hence I think we can easily steal another 3 bits for storing an
order - orders 0-4 are needed (3 bits) for up to 64kB on 4kB
PAGE_SIZE - so I think this is a solvable problem. There's a lot
more to it than "just use several pages to map to a single
filesystem block", though.....

> > If virtiofs can actually map 4k subpages out of 16k page on
> > host (and generally perform 4k granular tracking etc.), it would seem more
> > appropriate if virtiofs actually exposed the filesystem 4k block size instead
> > of 16k blocksize? Or am I missing something?
> 
> virtiofs itself on the guest does 2MiB mappings into the SHM region, and
> then the guest is free to map blocks out of those mappings. So as long
> as the guest page size is less than 2MiB, it doesn't matter, since all
> files will be aligned in physical memory to that block size. It behaves
> as if the filesystem block size is 2MiB from the point of view of the
> guest regardless of the actual block size. For example, if the host page
> size is 16K, the guest will request a 2MiB mapping of a file, which the
> VMM will satisfy by mmapping 128 16K pages from its page cache (at
> arbitrary physical memory addresses) into guest "physical" memory as one
> contiguous block. Then the guest will see the whole 2MiB mapping as
> contiguous, even though it isn't in physical RAM, and it can use any
> page granularity it wants (that is supported by the architecture) to map
> it to a userland process.

Clearly I'm missing something important because, from this
description, I honestly don't know which mapping is actually using
DAX.

Can you draw out the virtofs stack from userspace in the guest down
to storage in the host so dumb people like myself know exactly where
what is being directly accessed and how?

-Dave.
-- 
Dave Chinner
david@fromorbit.com


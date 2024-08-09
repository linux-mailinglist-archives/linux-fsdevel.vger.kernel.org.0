Return-Path: <linux-fsdevel+bounces-25544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8098194D422
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 18:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 404A82853B7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 16:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451911991BB;
	Fri,  9 Aug 2024 16:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U06bC5C7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3D918AF9;
	Fri,  9 Aug 2024 16:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723219442; cv=none; b=Uzk5clgtpIKT17UzzWmwNolsE7fUkVTaM174ZCNHBfhtWz2W1Ga2E53ag/Cy3YI8VzlVixkGREcar6ev/GhpMh22G5Jq3vYqV+/SXLgnW5C/Mx6AaIwkKf9PlZrxfhRDXmIVfX/w1NxlB7eBLrUMIzR55JeMZaq9dJkx5IrT7pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723219442; c=relaxed/simple;
	bh=/TwqSYdP2eTeRw4+V9mHKhuIJJr/NXSu+QP2k09qYYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HpcgPZFKOQIwW/JTRknbxcOoyY1KsUIfVolDJIQeJP5pwhoBmreq0VhRfh67KF7ldTt6LiAbsELX2Z6xWpyf1o2f3bJm5uEL9NmOjugiQX1HUJolw4Dk8TdS8we5fUyCUiDWWogmz/fiU/rRZ9OpbtmIW5Hkb9xgPuz8Tm9IMco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=U06bC5C7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=p+HKet5Xq76vUhEX4KeY5OC4X4HMbnKEvmndrRAXLrs=; b=U06bC5C7BHpLcTbm6mHky7qz/P
	6UYO6pJt0LYGfEs11cG4CPcrL/RRQWJFNQ2LEkGX5jJmFNizKWWltlJaN2advBQUB7WH4kdjqJHnH
	VQWAVqnh8YIBwMVA3HpuW6sWb2hwgh/ljZlXp3AButxmZUbS3WYHDkYyqKVF622LL83n5caz5OUCK
	GxyiwyVhexkqyvEyNjrkVIiRxkzpQaDBxoCgBcWciIbD6lbaJ+yNYEDwGYdeqOMJEGAtd77zs8hFY
	keK8xHCD9wKOPjbS9X6LH6QYLRQ7EiBF6GP+BtGx4IUCzV2ew0xD0bH845AqG6xwGBf8ZOy9hTxQl
	iP/RIakA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scS5s-0000000AnjP-30no;
	Fri, 09 Aug 2024 16:03:56 +0000
Date: Fri, 9 Aug 2024 17:03:56 +0100
From: Matthew Wilcox <willy@infradead.org>
To: =?iso-8859-1?Q?J=FCrg?= Billeter <j@bitron.ch>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [REGRESSION] fuse: copy_file_range() fails with EIO
Message-ID: <ZrY97Pq9xM-fFhU2@casper.infradead.org>
References: <792a3f54b1d528c2b056ae3c4ebaefe46bca8ef9.camel@bitron.ch>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <792a3f54b1d528c2b056ae3c4ebaefe46bca8ef9.camel@bitron.ch>

On Fri, Aug 09, 2024 at 05:53:26PM +0200, Jürg Billeter wrote:
> Starting with 6.10, I'm seeing `copy_file_range()`, with source and
> destination being on the same FUSE filesystem[1], failing with EIO in
> some cases. The (low-level libfuse3) userspace filesystem does not
> implement `copy_file_range`, so the kernel falls back to the generic
> implementation. The userspace filesystem receives read requests and
> replies with the `FUSE_BUF_SPLICE_MOVE` flag.
> 
> I'm not sure what exactly triggers the issue but it may depend on the
> file size, among other things. I can reproduce it fairly reliably
> attempting to copy files that are exactly 65536 bytes in size.
> 
> 6.9 works fine but I see the issue in 6.10, 6.10.3 and also in current
> master ee9a43b7cfe2.
> 
> 413e8f014c8b848e4ce939156f210df59fbd1c24 is the first bad commit
> commit 413e8f014c8b848e4ce939156f210df59fbd1c24 (HEAD)
> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> Date:   Sat Apr 20 03:50:06 2024 +0100
> 
>     fuse: Convert fuse_readpages_end() to use folio_end_read()
>     
>     Nobody checks the error flag on fuse folios, so stop setting it.
>     Optimise the (optional) setting of the uptodate flag and clearing
>     of the lock flag by using folio_end_read().
>     
>     Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>     Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> 
> I've confirmed the bisection by reverting this commit on top of 6.10.3,
> which resolves the issue.

Umm.  I don't see it.  This is all that's in the commit:

        for (i = 0; i < ap->num_pages; i++) {
-               struct page *page = ap->pages[i];
+               struct folio *folio = page_folio(ap->pages[i]);

-               if (!err)
-                       SetPageUptodate(page);
-               else
-                       SetPageError(page);
-               unlock_page(page);
-               put_page(page);
+               folio_end_read(folio, !err);
+               folio_put(folio);
        }

Do you have CONFIG_DEBUG_VM enabled?  There are some debugging asserts
which that will enable that might indicate a problem.

Otherwise we can try splitting the commit into individual steps and
seeing which one shows the problem.


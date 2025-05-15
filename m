Return-Path: <linux-fsdevel+bounces-49133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA35AB869D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 14:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44D541888942
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 12:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D23F299925;
	Thu, 15 May 2025 12:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FDolNnM3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529BF298CC8;
	Thu, 15 May 2025 12:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747312892; cv=none; b=j9cObpu3wQ88JGTkVtZ1j2gJItWgymX1rdcARlK2liaLal+rkDku6QkQDnTS//fz/pShdFoYI9Py1+fGckOGWVsC6SeAmXkh7tSjqVL0oPNkeVHMETClZygyDyoFhsUWuqChlRajcAisNOfgCynWGhLpiQkih4GKxF/FbX06iNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747312892; c=relaxed/simple;
	bh=TptLzb5vQcTb+qBHiic0HAxYPTY3KdgjudOHvVWUWfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DfheTqbJ+9bxZ5CbEOPX58T3JiH6SABbkkhMO6FwTBrUyvRCL3Tj7xTRQ/v66sIK+Ocz0J3tkvXeC0DjNUuJtUfk9gjKvSMPVRN7YDu7rxqIiIcdwwo/3NUpHFqCLLSLVaeACUfVlYSw7C2xIxOAUONdlP72hc0EcJDOM2N+Ics=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FDolNnM3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=x439nFdj0JqrVnR7s3pD2PNUHpBEt74IyK6JahhugHc=; b=FDolNnM3Yt6NoNDDgWYo0yFS+7
	/SL6KmaICbkSnUN6GrcHeutQmyOkZKx8aSTlm+kfHtvJUqt0uKZTjmirOhA8JlVofuDS+NMFu7dMr
	zR527oz+E86aKDgnyAmrMG5frrip0LZfEORrPU0p/wHkxPfXazM8ODuVz2YQipMQt3LmWiwdtHsxN
	e8q+nnAXPQg1+LW/P/sXOexRdltjeslbE2eMB3nvpZYEtpcC7fR/RGyuWy96TDxJCdVfz8idWitZ1
	bgsYm+CBC7uS+Dk0NtPVr/6CCpjsfbmz9bFc8WMhED5Uia2xHp9M9DafhiXmlDRNY/qkBx8/k238z
	Ps0VOd6g==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFXtu-0000000Dtgf-2u1c;
	Thu, 15 May 2025 12:41:26 +0000
Date: Thu, 15 May 2025 13:41:26 +0100
From: Matthew Wilcox <willy@infradead.org>
To: caius.zone@icloud.com
Cc: phillip@squashfs.org.uk, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Caius Zone <zone@ai-sast.com>
Subject: Re: [PATCH] squashfs: fix NULL pointer dereference in
 bio_alloc_clone failure path
Message-ID: <aCXg9t1QWR5jgpqX@casper.infradead.org>
References: <20250515120154.1658556-1-caius.zone@icloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515120154.1658556-1-caius.zone@icloud.com>

On Thu, May 15, 2025 at 08:01:54PM +0800, caius.zone@icloud.com wrote:
> diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
> index 2dc730800f44..b00a71f8933c 100644
> --- a/fs/squashfs/block.c
> +++ b/fs/squashfs/block.c
> @@ -115,6 +115,9 @@ static int squashfs_bio_read_cached(struct bio *fullbio,
>  			struct bio *new = bio_alloc_clone(bdev, fullbio,
>  							  GFP_NOIO, &fs_bio_set);
>  
> +			if (!new)
> +				return -ENOMEM;
> +
>  			if (bio) {
>  				bio_trim(bio, start_idx * PAGE_SECTORS,
>  					 (end_idx - start_idx) * PAGE_SECTORS);

This is definitely wrong.  The check for 'new' being NULL should be
after the submit_bio() otherwise we'll leak the previous bio.

But then we need to not call bio_chain() ... so I think this ends up
looking like:

@@ -115,12 +115,15 @@ static int squashfs_bio_read_cached(struct bio *fullbio,
                        struct bio *new = bio_alloc_clone(bdev, fullbio,
                                                          GFP_NOIO, &fs_bio_set);

+                       if (new)
+                               bio_chain(bio, new);
                        if (bio) {
                                bio_trim(bio, start_idx * PAGE_SECTORS,
                                         (end_idx - start_idx) * PAGE_SECTORS);
-                               bio_chain(bio, new);
                                submit_bio(bio);
                        }
+                       if (!new)
+                               return -ENOMEM;

                        bio = new;
                        start_idx = idx;

... but that might not be right either.  We might need to break out of
the loop, rather than returning and do the submit_bio_wait() followed by
the bio_put().


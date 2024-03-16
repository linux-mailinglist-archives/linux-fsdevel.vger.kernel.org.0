Return-Path: <linux-fsdevel+bounces-14552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED9E87D8C9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Mar 2024 05:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2277C28294A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Mar 2024 04:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C27C63D0;
	Sat, 16 Mar 2024 04:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ELsTsi58"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9EC5C83;
	Sat, 16 Mar 2024 04:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710564862; cv=none; b=gSUUEb/+E8k0XDrREiAY4v9nfYu/JgX7N7qr3bCOnLEKnM3RDD9jDoYotDeiTCn0BhbiKUhUbrvR4atrLuQKtUn19cSQCoqyjpwniOwkcb7qkol+6rUtArFOmbZeEt7xZC8dKEtubqiMMk/6VhMJaKaV2hfedBRBRldXI5fz9s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710564862; c=relaxed/simple;
	bh=CTsbWJOvMkHNA1a9M4r6D5hlnI1m51V5yGT3CTImS10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSp2b5tZUy7twgFTuTagUL2ZRZz2/UBv8Zg1byJhd1qoZEjKGvosveEtE6X6XANf0TYG00SMrNGgGfNl8ACQK7b7wxjKQ2ieJ00uIdoold07I/HOijdsNlx5wrEoQOQv/jFY+Zy4xe9eTIVP0Cp6vm0/ZV6cLF/99Ft5FgNPXqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ELsTsi58; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aqwB40EDkNKO/7P+bqgQOH7uayQrqvlFGFa8SadIFBU=; b=ELsTsi58TRxFPpdXxeuBrUzpae
	MLVlMvlljPXkKFz/R1/7sPtIOTVdYcXMirYM62G6RF2moFGZRnlRjBFQ51Hwy6BB9O3pHsTBfGGSg
	FMDEpFEcM5Dq+JOd+I62953F1P0rJ9YFddW+4/HMMSwmOWNl1iJ/gQu5mO0H3HyxrdskTYnWmuffw
	d1ChfETm+kSitX+4v4poQKxD88NVCRqQuLH9dBC/QiYN5UBQwmz40dGsY6S4j5tY76wWOOjiTddkP
	UlzqC8DNgVdwcNXIXoqgZlnYnwjA7HxqfYM67Ti0dSmb1gtuDwXLBtRScPVwNkKvl2bwDLdN0waZj
	C3op9s7w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rlM3e-0000000BnqB-26fL;
	Sat, 16 Mar 2024 04:54:10 +0000
Date: Sat, 16 Mar 2024 04:54:10 +0000
From: Matthew Wilcox <willy@infradead.org>
To: cheung wall <zzqq0103.hey@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: WARNING in mark_buffer_dirty
Message-ID: <ZfUl8pGp_JMWMaVI@casper.infradead.org>
References: <CAKHoSAuCUF8kNFdv5Chb2Fnup2vwDb0W+UPOxHzgCg_O=KJA0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKHoSAuCUF8kNFdv5Chb2Fnup2vwDb0W+UPOxHzgCg_O=KJA0A@mail.gmail.com>


This might be an iomap bug, so adding Christoph & Darrick.

On Sat, Mar 16, 2024 at 12:29:36PM +0800, cheung wall wrote:
> HEAD commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a  (tag: v6.7)
> WARNING: CPU: 0 PID: 2920 at fs/buffer.c:1176
> mark_buffer_dirty+0x232/0x290

This is WARN_ON_ONCE(!buffer_uptodate(bh)), so we're trying to mark a
buffer dirty when that buffer is not uptodate.

> RIP: 0010:mark_buffer_dirty+0x232/0x290
> fs/buffer.c:1176
> Call Trace:
>  <TASK>
>  __block_commit_write+0xe9/0x200
> fs/buffer.c:2191

... but line 2190 and 91 are:

                        set_buffer_uptodate(bh);
                        mark_buffer_dirty(bh);

and the folio is locked.  So how do we clear the uptodate flag on the
buffer without the folio locked?

>  block_write_end+0xb1/0x1f0
> fs/buffer.c:2267
>  iomap_write_end+0x461/0x8c0
> fs/iomap/buffered-io.c:857
>  iomap_write_iter
> fs/iomap/buffered-io.c:938
> [inline]
>  iomap_file_buffered_write+0x4eb/0x800
> fs/iomap/buffered-io.c:987
>  blkdev_buffered_write
> block/fops.c:646
> [inline]
>  blkdev_write_iter+0x4ae/0xa40
> block/fops.c:696
>  call_write_iter


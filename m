Return-Path: <linux-fsdevel+bounces-54896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0EAB04AF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 00:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0414D1AA0717
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 22:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4173F24469B;
	Mon, 14 Jul 2025 22:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="0xaGZV5J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD6B231C8D;
	Mon, 14 Jul 2025 22:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752533036; cv=none; b=RlnbDibX4GsArI90ZcxkwxRHNAfFkBK//2tOA3+2fyrHLyMkQdVrKGLu8qTpo4ht7UWrIHUluntfjvibFETPBha5aR9tQvg7cWEabnw56DrJ9GiilqT8uSzzDX0gI5zb/qdZbpePECbaNN3HgEqGnl8LWyL0HTAiRFl4+a58f3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752533036; c=relaxed/simple;
	bh=es64UHQaAjssKVP7Q+amFSDjcaSOz6kzJxPAwja6zLk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CKpiSPTrneNkCYlTQ9J9bBPxCkr0ZbxW4+0iEcLktsXhz8EjodBUg5C5CUbBNJrtuPFETwANBo1aB4dRnmPArVt00d3/2o/jqRyJ8uxsU1SFZXVw8zAEkSwVO9gCYRfg2tM/V9WcfKfR2ewTn6rw+KhDxLFo2C4t+pjDX56Xe1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=0xaGZV5J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC3F3C4CEF0;
	Mon, 14 Jul 2025 22:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1752533036;
	bh=es64UHQaAjssKVP7Q+amFSDjcaSOz6kzJxPAwja6zLk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=0xaGZV5JNuxEd758647VUeGZuaPcMPo0TYMXy8plVNavRRg0pBU+TzrBETY5qLhaK
	 edJ30zgDGu1NId+4P8tSMgI10vYBI4JD2teO+jIxCn7vOq9rkzn1CJzTKn3TBQla4y
	 c5V4qPiCcL6fZqOzaNbqRLVjhF3MC3RuhKfuMrB4=
Date: Mon, 14 Jul 2025 15:43:55 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Klara Modin <klarasmodin@gmail.com>
Cc: Youling Tang <youling.tang@linux.dev>, Matthew Wilcox
 <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, chizhiling@163.com, Youling Tang
 <tangyouling@kylinos.cn>, Chi Zhiling <chizhiling@kylinos.cn>
Subject: Re: [PATCH] mm/filemap: Align last_index to folio size
Message-Id: <20250714154355.e27c812d71b5968bdd83764c@linux-foundation.org>
In-Reply-To: <yru7qf5gvyzccq5ohhpylvxug5lr5tf54omspbjh4sm6pcdb2r@fpjgj2pxw7va>
References: <20250711055509.91587-1-youling.tang@linux.dev>
	<yru7qf5gvyzccq5ohhpylvxug5lr5tf54omspbjh4sm6pcdb2r@fpjgj2pxw7va>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Jul 2025 00:34:12 +0200 Klara Modin <klarasmodin@gmail.com> wrote:

> iocb->ki_pos is loff_t (long long) while pgoff_t is unsigned long and
> this overflow seems to happen in practice, resulting in last_index being
> before index.
> 
> The following diff resolves the issue for me:
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 3c071307f40e..d2902be0b845 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2585,8 +2585,8 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
>  	int err = 0;
>  
>  	/* "last_index" is the index of the folio beyond the end of the read */
> -	last_index = round_up(iocb->ki_pos + count, mapping_min_folio_nrbytes(mapping));
> -	last_index >>= PAGE_SHIFT;
> +	last_index = round_up(iocb->ki_pos + count,
> +			mapping_min_folio_nrbytes(mapping)) >> PAGE_SHIFT;
>  retry:
>  	if (fatal_signal_pending(current))
>  		return -EINTR;

Looks good, thanks.  I added your signed-off-by (which I trust is OK?)
and queued this up.


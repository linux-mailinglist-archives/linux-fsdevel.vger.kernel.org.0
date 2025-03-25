Return-Path: <linux-fsdevel+bounces-45039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F79A708E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 19:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7590189750C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 18:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EB7176AB5;
	Tue, 25 Mar 2025 18:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RmOWayAr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F6E6FC5;
	Tue, 25 Mar 2025 18:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742926569; cv=none; b=nk98PwC6PYhQcejuFG8DG/iQP3se2tAuvu4oeoD/YA32DLU+/ClnvwJ0K/8IQMjwGfVleGKsgkF9EK9ZB9gPk0d4ShIYjHyLbMLC13fCQQqYOatv/H1BEDiVev3RMca8n4rQtRAi7qErHGTXjrrKtG7DWxcRJX3bLmoPJPLk1EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742926569; c=relaxed/simple;
	bh=65rCZNQs6EZ0buDHqicZ+I5bloOPYQ+8g7Em/dz5SlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQbw4C5TqhQ0f0e7cW7z4ftLEfj3sPeOGvYODNHdzZaPFqS5Hidsiz0WfzHGi21owEkE5mbqzhOyw//s1I/cef7JpXeBfAEtGBVkDCgLBLZoWqcgWDNY555BMmW/xEwYbFUALLFzEaB5XFDnVz/uMsxLIArYTo+mTLOq6HD0Lh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RmOWayAr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lYyjJpFN+4r949AIjfJWDERe1gpar+pYQQDNgz0TyGE=; b=RmOWayAruvO73AFD/tA0zOVWHc
	u57faV0DetF3XcIBCDiNxKaPyZ89WpJTJxN9D6F9meSbZvYWhfoKw3i7bLN/EDP+rADtQriL2ZntB
	DGYLCuxF5ZaAH9QEvoF8x+RSUwnXtCL4gdSrsixUFOUXjWx+8Q9d8DEJvahnZvchnyj2BhTtE7XAV
	+W+Eg2g6ks4QQP/1PBHeeQOxnA64wuBu0j4CAsMGBf8dSwc0T9nC6Sw9kG5Fv9j9fOali4SYTbLsM
	TUPnFymx4ssf5kNXggYUy15R+nAS1vXkO3ytvPKWc6p+hub94L6IQZKfjhHRbNnkKOT2avvOQRW0n
	ASZrjqdw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tx8oj-0000000847V-2cd2;
	Tue, 25 Mar 2025 18:16:01 +0000
Date: Tue, 25 Mar 2025 18:16:01 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Purva Yeshi <purvayeshi550@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+219127d0a3bce650e1b6@syzkaller.appspotmail.com
Subject: Re: [PATCH] fs: Fix jfs_fsync() Sleeping in Invalid Context
Message-ID: <Z-Ly4WmAaN7aev3R@casper.infradead.org>
References: <20250325173336.8225-1-purvayeshi550@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325173336.8225-1-purvayeshi550@gmail.com>

On Tue, Mar 25, 2025 at 11:03:36PM +0530, Purva Yeshi wrote:
> +++ b/fs/direct-io.c
> @@ -356,13 +356,9 @@ static void dio_bio_end_aio(struct bio *bio)
>  			defer_completion = dio->defer_completion ||
>  					   (dio_op == REQ_OP_WRITE &&
>  					    dio->inode->i_mapping->nrpages);
> -		if (defer_completion) {
> -			INIT_WORK(&dio->complete_work, dio_aio_complete_work);
> -			queue_work(dio->inode->i_sb->s_dio_done_wq,
> -				   &dio->complete_work);
> -		} else {
> -			dio_complete(dio, 0, DIO_COMPLETE_ASYNC);
> -		}
> +
> +		INIT_WORK(&dio->complete_work, dio_aio_complete_work);
> +		queue_work(dio->inode->i_sb->s_dio_done_wq, &dio->complete_work);

This patch is definitely wrong.  If it were the right thing to do, then
since defer_completion is now un-read, we should stop calculating it.

I'm not sure what the right solution is; should we simply do:

                        defer_completion = dio->defer_completion ||
+					   in_atomic() ||
                                           (dio_op == REQ_OP_WRITE &&
                                            dio->inode->i_mapping->nrpages);

I'm kind of surprised this problem hasn't cropped up before now ...


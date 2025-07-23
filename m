Return-Path: <linux-fsdevel+bounces-55837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B31CB0F562
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 16:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2972E542E7B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 14:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2242F5080;
	Wed, 23 Jul 2025 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sBf234vd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6322D9EDC;
	Wed, 23 Jul 2025 14:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753281251; cv=none; b=G5FQqQJ/2+Mt4wQobrNIPoi4+xgwdxzctBFOGFFOz5nVYfrnUOdkMFMdd+VC6oHWjzg0Tqo5V+U8Ymo01VWrA7qcWWZMxAUVntLb/nAOc9M4V3MMvXeZuRZpxqlenNsc6Uv3NQtHzNsYod32WkjohEzrNecz0eZRvbAl5N18MO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753281251; c=relaxed/simple;
	bh=wWuI3uT5wjoTOeZPP7CPLLKesy5RfF2/nPgncQZdttY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOj+yQz1icCcEqT2+aofIDioe/2FGojLW2Ww0pFeB609ZLLHTCWsCGWgiydSaF6FHCgA54wvpIczNH+k/Yunu6BU1J/4Xqz7NLob1D6AxOcblv86KlAXXrEPAKc1PBZh3h8ltFVWmhRRtiOSGjh+d2EvO9IkAx1nIYOEO8OGQe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sBf234vd; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2B1Vo0/j3crJLhvogIai1rlzti+SXL6KBl2BvGLFRhs=; b=sBf234vd9tTmtB4mGJO2IwKMol
	7fb0Xmtgn+nj1hGNM5uxxxgM48aPT4lP6jh+BzTUNLl/GHIKRIoIlO4q2O9aDNEYWk9dYxq6eW43i
	ul3hjgcdF3aCz+McqDWehRRBtz0f1nR/TklA6RR+RXyGZcwEsFx+d1Lgl+ei2GPnJE+3T+QRD7G6V
	hYxgjHWh0QO+m6xkekEmgQ4hSV7qxarvVS5nc73ZnLWkKyJnY+ZQlRQWoGXPSlarLeL2r2J7pAJE7
	N2JqSp+uY+ln2juW+KcTsBjngH55i3LZByWQHqRcn/BQoAiM2ViGbEd3fbmXYD8H38FrMpubaBwtw
	s34NQXuQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueaXc-0000000DLA2-0fWm;
	Wed, 23 Jul 2025 14:33:56 +0000
Date: Wed, 23 Jul 2025 15:33:55 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Chi Zhiling <chizhiling@163.com>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: Re: [RFC PATCH 2/3] mm/filemap: Avoid modifying iocb->ki_flags for
 AIO in filemap_get_pages()
Message-ID: <aIDy076Sxt544qja@casper.infradead.org>
References: <20250723101825.607184-1-chizhiling@163.com>
 <20250723101825.607184-3-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723101825.607184-3-chizhiling@163.com>

On Wed, Jul 23, 2025 at 06:18:24PM +0800, Chi Zhiling wrote:
> From: Chi Zhiling <chizhiling@kylinos.cn>
> 
> Setting IOCB_NOWAIT in filemap_get_pages() for AIO is only used to
> indicate not to block in the filemap_update_page(), with no other purpose.
> Moreover, in filemap_read(), IOCB_NOWAIT will be set again for AIO.
> 
> Therefore, adding a parameter to the filemap_update_page function to
> explicitly indicate not to block serves the same purpose as indicating
> through iocb->ki_flags, thus avoiding modifications to iocb->ki_flags.
> 
> This patch does not change the original logic and is preparation for the
> next patch.

Passing multiple booleans to a function is an antipattern.
Particularly in this case, since we could just pass iocb->ki_flags
to the function.

But I think there's a less complicated way to do what you want.
Just don't call filemap_update_page() if there are uptodate folios
in the batch:

+++ b/mm/filemap.c
@@ -2616,9 +2616,10 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
                        goto err;
        }
        if (!folio_test_uptodate(folio)) {
-               if ((iocb->ki_flags & IOCB_WAITQ) &&
-                   folio_batch_count(fbatch) > 1)
-                       iocb->ki_flags |= IOCB_NOWAIT;
+               if (folio_batch_count(fbatch) > 1) {
+                       err = -EAGAIN;
+                       goto err;
+               }
                err = filemap_update_page(iocb, mapping, count, folio,
                                          need_uptodate);
                if (err)



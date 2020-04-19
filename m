Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B791AF854
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 09:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgDSHrd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 03:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725903AbgDSHrd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 03:47:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD0AC061A0C;
        Sun, 19 Apr 2020 00:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i1xXJbaM1li30HgehGQVeiyVaSFgheRxPtl8vSYN6os=; b=EBcDD7eL1hN8TgzS+YStIUy6BS
        cwneAl+yO/6/qwXL/Zk7cvflUc8xPQdIGrMpzrAoPFcDqbb436Rs3hYWUz7W9RsqPcd9wa0etNUzL
        3lUui5vXRtKNMU27/Od4HNVH5zXEbMOsBgSQTuyF12z4KzYr9z4TdD9Xii7WA/IDGj7EgHB7WrLem
        9NjQXMwYnIjhR4WTBY/uE3OK7Iy8uSYyOXwTdwHIAvOONx2FF+oM/IoDvzlGPGYjMWuH+/0Zk1X6E
        CdM/D6m8dj1DeaboJBE6YmiahCHY2n9+KrajWCBwJHMCDFkS7hCCgFT/O9ZtjZPAQJ/hZFBNVlRAj
        QJvbOLcQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQ4fp-000564-56; Sun, 19 Apr 2020 07:47:29 +0000
Date:   Sun, 19 Apr 2020 00:47:29 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 3/5] iomap: call __clear_page_buffers in
 iomap_page_release
Message-ID: <20200419074729.GA17062@infradead.org>
References: <20200418225123.31850-1-guoqing.jiang@cloud.ionos.com>
 <20200418225123.31850-4-guoqing.jiang@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200418225123.31850-4-guoqing.jiang@cloud.ionos.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 19, 2020 at 12:51:21AM +0200, Guoqing Jiang wrote:
> After the helper is exported, we can call it to simplify code a little.
> 
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Darrick J. Wong <darrick.wong@oracle.com>
> Cc: linux-xfs@vger.kernel.org
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> ---
>  fs/iomap/buffered-io.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 89e21961d1ad..b06568ad9a7a 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -74,9 +74,7 @@ iomap_page_release(struct page *page)
>  		return;
>  	WARN_ON_ONCE(atomic_read(&iop->read_count));
>  	WARN_ON_ONCE(atomic_read(&iop->write_count));
> -	ClearPagePrivate(page);
> -	set_page_private(page, 0);
> -	put_page(page);
> +	__clear_page_buffers(page);

We should not call a helper mentioning buffers in code that has
nothing to do with buffers.  If you want to us __clear_page_buffers
more widely please give it a better name first.

You'll also forgot to Cc me on the other patches in the series, which is
a completel no-go as it doesn't allow for a proper review.

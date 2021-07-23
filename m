Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C993D3C24
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jul 2021 17:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235440AbhGWOZT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jul 2021 10:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235351AbhGWOZS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jul 2021 10:25:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE835C061575;
        Fri, 23 Jul 2021 08:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TH+UO+4GlVJPwsICtqlb2GDVZ2D9S2sacJqluLD1cbU=; b=ryUceu+cYHelVxJMnHQDMyfPmq
        1CmyM/LHAHkQgUx4cO8EdjLvKifP61OBPlPyUgIcxSaTkiH+a4dktu+nR+Gs+zi1cyNxG2Yd46ojm
        KxL0i0AytbtSWTbmcpgpLAgCZKlIxwEIKAn6SRJrpA0ZkVBZTAaybsgiyKcmtqYMkV3R2cEOAMa8I
        b9W8adfTMvE8RA61u57/ieX9FkjfJ1LgFRBAdezhXjx8d3AvAMQRJhAkIK1/urYh/4UGodi0SAHjZ
        p/d6loPEz9qZZq7hJPbgZ4M/XQVjZLZs+zMZA2gXsxalO2C5fU/1Q/npBzRRu0DGpsfadyaxZ7dhm
        TbWYshoQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6wjx-00BSns-9o; Fri, 23 Jul 2021 15:05:32 +0000
Date:   Fri, 23 Jul 2021 16:05:29 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Subject: Re: [PATCH v6] iomap: support tail packing inline read
Message-ID: <YPrauRjG7+vCw7f9@casper.infradead.org>
References: <20210722031729.51628-1-hsiangkao@linux.alibaba.com>
 <20210722053947.GA28594@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722053947.GA28594@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 22, 2021 at 07:39:47AM +0200, Christoph Hellwig wrote:
> @@ -675,7 +676,7 @@ static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
>  
>  	flush_dcache_page(page);
>  	addr = kmap_atomic(page);
> -	memcpy(iomap->inline_data + pos, addr + pos, copied);
> +	memcpy(iomap_inline_buf(iomap, pos), addr + pos, copied);

This is wrong; pos can be > PAGE_SIZE, so this needs to be
addr + offset_in_page(pos).


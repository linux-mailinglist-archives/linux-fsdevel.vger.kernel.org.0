Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDB027A7BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Sep 2020 08:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgI1GlU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Sep 2020 02:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgI1GlU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Sep 2020 02:41:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B173C0613CE;
        Sun, 27 Sep 2020 23:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=C1ZhthwT6GCyuOQr6B6dYOTLb2FPoU8txQN+oDdWZU4=; b=ahYA8bRzbFOs+QLC9HY4AAUsdr
        ukSHhFAJBaGlY7vgE6j5SrzYClwhLywHNDVESTku7xJSyQ04C857XP5LgDRX7+Hmpg/t9nP6ytTmR
        JRRALHxrM79i0IizwhZb90dVagxWO8a4nP7DrFI2i1HugjHO189Oz+bSgEE5S9fZBe40Z0xNKjvaV
        AruV5nth2qazZk9GVzhGsOzLj7rV77ApOXgujcqnDYKT7BIcXECzkDzq0MRQFBpIgDOfv4dPZNdd/
        L4bawF2Y6TBQ/YFqHtg2SwjHVHSzPbn1LEq+fGxjUjuWlaDC9bGpgxEBVMIFRjuCqbOz2UuezHZFK
        KIYB7HuQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kMmqc-0004Qe-Mi; Mon, 28 Sep 2020 06:41:18 +0000
Date:   Mon, 28 Sep 2020 07:41:18 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Qian Cai <cai@redhat.com>, Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH] iomap: Set all uptodate bits for an Uptodate page
Message-ID: <20200928064118.GA16179@infradead.org>
References: <20200924125608.31231-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924125608.31231-1-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 24, 2020 at 01:56:08PM +0100, Matthew Wilcox (Oracle) wrote:
> For filesystems with block size < page size, we need to set all the
> per-block uptodate bits if the page was already uptodate at the time
> we create the per-block metadata.  This can happen if the page is
> invalidated (eg by a write to drop_caches) but ultimately not removed
> from the page cache.
> 
> This is a data corruption issue as page writeback skips blocks which
> are marked !uptodate.
> 
> Fixes: 9dc55f1389f9 ("iomap: add support for sub-pagesize buffered I/O without buffer heads")
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reported-by: Qian Cai <cai@redhat.com>
> Cc: Brian Foster <bfoster@redhat.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

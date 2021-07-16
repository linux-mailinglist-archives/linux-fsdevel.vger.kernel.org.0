Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 518D63CB7A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 15:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239574AbhGPNG5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 09:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbhGPNG4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 09:06:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF456C061760;
        Fri, 16 Jul 2021 06:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZnncS7EMVgffQsq6qFPh/18HhJ7accRmRlB/yo0s+qU=; b=JSAv+m6ZpKT/OgpPZ5INhBHanu
        QVyPEIr/P4R+CJu/yBbb24MkyFoVlRsOhkblNsYi+CBUoalGt+yQLUtQ3PMNxYtPDBRBGc6LB62jU
        XOcXv8JP7Htt4hYsHDeeBN0ZeqGwM3MouwXrhVMkRVQWeztziQ9eNQR8T/xZe8KGTqXMWdv8JePdu
        snYUMYkPAdRMiWJmWnBasals+i5LGXq8PACRz1efviUrq1ahXYxCVgcsla2P+zXpN3vMBS61C4gri
        DntZyk/SJXTLoCRkKaDzsL0L0vswEtdBFgClxONP/qIEs0NSlGCSz1TUhIrHRt34N1SahOCOpvtGs
        XjGd69zQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m4NU5-004URh-SL; Fri, 16 Jul 2021 13:02:44 +0000
Date:   Fri, 16 Jul 2021 14:02:29 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Chao Yu <chao@kernel.org>, Liu Bo <bo.liu@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>
Subject: Re: [PATCH 1/2] iomap: support tail packing inline read
Message-ID: <YPGDZYT9OxdgNYf2@casper.infradead.org>
References: <20210716050724.225041-1-hsiangkao@linux.alibaba.com>
 <20210716050724.225041-2-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210716050724.225041-2-hsiangkao@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 16, 2021 at 01:07:23PM +0800, Gao Xiang wrote:
> This tries to add tail packing inline read to iomap. Different from
> the previous approach, it only marks the block range uptodate in the
> page it covers.

Why?  This path is called under two circumstances: readahead and readpage.
In both cases, we're trying to bring the entire page uptodate.  The inline
extent is always the tail of the file, so we may as well zero the part of
the page past the end of file and mark the entire page uptodate instead
and leaving the end of the page !uptodate.

I see the case where, eg, we have the first 2048 bytes of the file
out-of-inode and then 20 bytes in the inode.  So we'll create the iop
for the head of the file, but then we may as well finish the entire
PAGE_SIZE chunk as part of this iteration rather than update 2048-3071
as being uptodate and leave the 3072-4095 block for a future iteration.


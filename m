Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D0C3CD3BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 13:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236691AbhGSKlY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 06:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236825AbhGSKlL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 06:41:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15651C061574;
        Mon, 19 Jul 2021 03:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oHvZCvnyWx34050zBCmoBlfirYI9L7hPimae0Gd3np4=; b=H4yUT9cWMYv6PGWGnrxRQtjaqD
        tikdFFkPspmpm9WWHPs2lMO3rgdjm+yD8xfWJ4m8QSvKpK0FmtEvknaMdhjHm32O60PZ7W3ONTuLn
        9JXAac35lG0QVkL8qmcTP6EvkRwAyM0IFklG6p8pq5Cyp/YVAd8uAvbm/I3YMiCnNmBJFp/lj5wjv
        ii3u9rPfSPFUDDkSDCqrwtPepY5ShmRTv4r5H1XKzTdQfGvbvj98RGa21oYlDCxeteU8dV7LRLk5y
        iKZyCZy2iKDHqLpEEKk5BJTJ+7TDna/d7Mk9NuvRNAhfekwXOl3NH24wEJWNvwTJkzBq2jzk3/cac
        1XZtUd7Q==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5RJ8-006naF-3J; Mon, 19 Jul 2021 11:19:42 +0000
Date:   Mon, 19 Jul 2021 12:19:34 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andreas Gr?nbacher <andreas.gruenbacher@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-erofs@lists.ozlabs.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Chao Yu <chao@kernel.org>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>
Subject: Re: [PATCH 1/2] iomap: support tail packing inline read
Message-ID: <YPVfxn6/oCPBZpKu@infradead.org>
References: <20210716050724.225041-2-hsiangkao@linux.alibaba.com>
 <YPGDZYT9OxdgNYf2@casper.infradead.org>
 <YPGQB3zT4Wp4Q38X@B-P7TQMD6M-0146.local>
 <YPGbNCdCNXIpNdqd@casper.infradead.org>
 <YPGfqLcSiH3/z2RT@B-P7TQMD6M-0146.local>
 <CAHpGcMJzEiJUbD=7ZOdH7NF+gq9MuEi8=ym34ay7QAm5_91s7g@mail.gmail.com>
 <YPLdSja/4FBsjss/@B-P7TQMD6M-0146.local>
 <YPLw0uc1jVKI8uKo@casper.infradead.org>
 <YPL0LqHzEbUY4zY/@B-P7TQMD6M-0146.local>
 <YPMkKfegS+9KzEhK@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPMkKfegS+9KzEhK@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 17, 2021 at 07:40:41PM +0100, Matthew Wilcox wrote:
> Well, either sense of a WARN_ON is wrong.
> 
> For a file which is PAGE_SIZE + 3 bytes in size, to_iomap_page() will
> be NULL.  For a file which is PAGE_SIZE/2 + 3 bytes in size,
> to_iomap_page() will not be NULL.  (assuming the block size is <=
> PAGE_SIZE / 2).
> 
> I think we need a prep patch that looks something like this:

Something like this is where we should eventually end up, but it
also affects the read from disk case so we need to be careful.

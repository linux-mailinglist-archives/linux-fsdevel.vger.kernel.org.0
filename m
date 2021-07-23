Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2110C3D4100
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jul 2021 21:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhGWTAq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jul 2021 15:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhGWTAq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jul 2021 15:00:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE78C061575;
        Fri, 23 Jul 2021 12:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wLxpkipMgvxMPaddvglb23fn92nRwXLxVzoe/PF9JSQ=; b=DUvza/oQxDEBXJqJ5qe+4PTwXC
        ChPVxolPzM+XTosRn0XRvWFQ1OexQFajE9Z4o9uitWBobGl7UU32YrNCyj13LnbxrrY7sbjBM5sOR
        jem8Ki3m+t/iECfVFQlshxNX45nc/eyPN3oj8wmvTLfxkTpY33/OiXq+3GtkUPO3QkQoHn9w6nVwp
        uzii5hHtVnIYlPPFUwAKLO3vYU7S7rkj+XqvPCeK8GEQtCKAATVF/wDFqFQwJgz4us0q/h/xs0hY6
        WtG0OT4Y1X0p3fVH2+2M05eariMyo6FgboYSkFr32VXkQ9kHDCOKAkAzitN4xwH7RALnAOMwdwUqX
        gIUnrWJQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m712R-00BgWf-O0; Fri, 23 Jul 2021 19:41:00 +0000
Date:   Fri, 23 Jul 2021 20:40:51 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Andreas Gruenbacher <andreas.gruenbacher@gmail.com>,
        Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH v7] iomap: make inline data support more flexible
Message-ID: <YPsbQzcNz+r4V7P2@casper.infradead.org>
References: <20210723174131.180813-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723174131.180813-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 24, 2021 at 01:41:31AM +0800, Gao Xiang wrote:
> Add support for reading inline data content into the page cache from
> nonzero page-aligned file offsets.  This enables the EROFS tailpacking
> mode where the last few bytes of the file are stored right after the
> inode.
> 
> The buffered write path remains untouched since EROFS cannot be used
> for testing. It'd be better to be implemented if upcoming real users
> care and provide a real pattern rather than leave untested dead code
> around.

My one complaint with this version is the subject line.  It's a bit vague.
I went with:

iomap: Support file tail packing

I also wrote a changelog entry that reads:
    The existing inline data support only works for cases where the entire
    file is stored as inline data.  For larger files, EROFS stores the
    initial blocks separately and then can pack a small tail adjacent to
    the inode.  Generalise inline data to allow for tail packing.  Tails
    may not cross a page boundary in memory.

... but I'm not sure that's necessarily better than what you've written
here.

> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Darrick J. Wong <djwong@kernel.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
> Tested-by: Huang Jianan <huangjianan@oppo.com> # erofs
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>


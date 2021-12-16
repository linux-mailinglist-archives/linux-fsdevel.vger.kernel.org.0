Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4AF7477DC2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Dec 2021 21:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236123AbhLPUn6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 15:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbhLPUn6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 15:43:58 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E447C061574;
        Thu, 16 Dec 2021 12:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YfhwUBS2lrVjAKDoz7mKoyOUc8g9bLIUsgePZeXTb8o=; b=bWkst33a+Ic7U7iKhFkHODkaeZ
        yPMCrxKpAQREkQ0JPFB00jPk14VLvWhn91P6GMttexp1K6Jv6knybv8O+/uuup4czcWvfA1SIO9Nw
        ZaI3TzgbLv6i7LIN55sCN7wVgWjgeAY0zlXlpVlTHNMWfoqS4j09E+Vfb+G+pE/if/OmB7VfsNVYg
        Lgkq+B2UmgOlyxriOPZeluqpKxVxukx3BCQftN5aihISXoPGZw7GYEJin0Zcn9DrIzbgHjWSL91Xp
        slUtKjoqpykWqmepdJmc8lQ1BBgotzLoDaUUzlKh1pSQ/3fKYP9204CwgEJt1mCIBRO7SlzxUBw5D
        WlRE8ukQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxxbV-00Fw7k-NY; Thu, 16 Dec 2021 20:43:53 +0000
Date:   Thu, 16 Dec 2021 20:43:53 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 19/28] iomap: Convert __iomap_zero_iter to use a folio
Message-ID: <YbulCVh8xwwRKAN3@casper.infradead.org>
References: <20211108040551.1942823-1-willy@infradead.org>
 <20211108040551.1942823-20-willy@infradead.org>
 <YbJ3O1qf+9p/HWka@casper.infradead.org>
 <20211216193614.GA27676@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216193614.GA27676@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 16, 2021 at 11:36:14AM -0800, Darrick J. Wong wrote:
> > 
> > +       /* gfs2 does not support large folios yet */
> > +       if (len > PAGE_SIZE)
> > +               len = PAGE_SIZE;
> 
> This is awkward -- gfs2 doesn't set the mapping flag to indicate that it
> supports large folios, so it should never be asked to deal with more
> than a page at a time.  Shouldn't iomap_write_begin clamp its len
> argument to PAGE_SIZE at the start if the mapping doesn't have the large
> folios flag set?

You're right, this is awkward.  And it's a bit of a beartrap for
another filesystem that wants to implement ->prepare_page in the
future.

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 9270db17c435..d67108489148 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -968,9 +968,6 @@ static int gfs2_iomap_page_prepare(struct inode *inode, loff_t pos,
        struct gfs2_sbd *sdp = GFS2_SB(inode);
        unsigned int blocks;

-       /* gfs2 does not support large folios yet */
-       if (len > PAGE_SIZE)
-               len = PAGE_SIZE;
        blocks = ((pos & blockmask) + len + blockmask) >> inode->i_blkbits;
        return gfs2_trans_begin(sdp, RES_DINODE + blocks, 0);
 }
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 1a9e897ee25a..b1ded5204d1c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -619,6 +619,9 @@ static int iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
        if (fatal_signal_pending(current))
                return -EINTR;
 
+       if (!mapping_large_folio_support(iter->inode->i_mapping))
+               len = min_t(size_t, len, PAGE_SIZE - offset_in_page(pos));
+
        if (page_ops && page_ops->page_prepare) {
                status = page_ops->page_prepare(iter->inode, pos, len);
                if (status)


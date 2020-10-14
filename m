Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4608528E607
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 20:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbgJNSIa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 14:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbgJNSIa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 14:08:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A66C061755;
        Wed, 14 Oct 2020 11:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KWD6jqk7DO3TA+OtoTnfkcN25TphkDSloy3OC+012Cs=; b=m4gPus3SG3TcPhK21rXnWRk5kQ
        GBvXLtmTTxqIUglmZgUS2pOmspxQ2Vy96kN2G/NnEbOIMry7WYHGEJEb0Abck0OyVN3upTvy50BQ6
        iZZA8uVlCCljQa0Gcqqrmk76HjM84oV7l7EYzHswLO4j8GFymOICB3hVljxMKbM/cACYNK45yqZiy
        b+p4Rrc/P3Hy7s5Um2NpG4mVlKYKGYumVHTyrd8EHu6zukFuRNlHBz2w+neUaUrpNlEtdKSggKw6u
        oIyv9EFIJOBDDYjgZOxOkx70FfXNXLJyGRQMETb+XXwMIZ1HdW3BaIT3JlEK6mCu1GySj3dyCKJwN
        clnijFlg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSlCO-0007NX-Gh; Wed, 14 Oct 2020 18:08:28 +0000
Date:   Wed, 14 Oct 2020 19:08:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 09/14] iomap: Change iomap_write_begin calling convention
Message-ID: <20201014180828.GT20115@casper.infradead.org>
References: <20201014030357.21898-1-willy@infradead.org>
 <20201014030357.21898-10-willy@infradead.org>
 <20201014164744.GK9832@magnolia>
 <20201014174158.GS20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014174158.GS20115@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 14, 2020 at 06:41:58PM +0100, Matthew Wilcox wrote:
> On Wed, Oct 14, 2020 at 09:47:44AM -0700, Darrick J. Wong wrote:
> > > -static int
> > > -iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
> > > -		struct page **pagep, struct iomap *iomap, struct iomap *srcmap)
> > > +static ssize_t iomap_write_begin(struct inode *inode, loff_t pos, loff_t len,
> > > +		unsigned flags, struct page **pagep, struct iomap *iomap,
> > 
> > loff_t len?  You've been using size_t (ssize_t?) for length elsewhere,
> > can't return more than ssize_t, and afaik MAX_RW_COUNT will never go
> > larger than 2GB so I'm confused about types here...?
> 
> Yes, you're right.  This one should be size_t.
> 
> > >  	if (page_ops && page_ops->page_prepare) {
> > > +		if (len > UINT_MAX)
> > > +			len = UINT_MAX;
> > 
> > I'm not especially familiar with page_prepare (since it's a gfs2 thing);
> > why do you clamp len to UINT_MAX here?
> 
> The len parameter of ->page_prepare is an unsigned int.  I don't want
> a 1<<32+1 byte I/O to be seen as a 1 byte I/O.  We could upgrade the
> parameter to size_t from unsigned int?

OK, here's what I have -- two patches (copy-and-wasted):

    iomap: Prepare page ops for larger I/Os
    
    Just adjust the types for the page_prepare() and page_done() callbacks
    to size_t from unsigned int.  While I don't see individual pages that
    large in our near future, it's convenient to be able to pass in larger
    lengths and has no cost.
    
    Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 0f69fbd4af66..9a94d7e58199 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1028,7 +1028,7 @@ static void gfs2_write_unlock(struct inode *inode)
 }
 
 static int gfs2_iomap_page_prepare(struct inode *inode, loff_t pos,
-                                  unsigned len, struct iomap *iomap)
+                                  size_t len, struct iomap *iomap)
 {
        unsigned int blockmask = i_blocksize(inode) - 1;
        struct gfs2_sbd *sdp = GFS2_SB(inode);
@@ -1039,7 +1039,7 @@ static int gfs2_iomap_page_prepare(struct inode *inode, loff_t pos,
 }
 
 static void gfs2_iomap_page_done(struct inode *inode, loff_t pos,
-                                unsigned copied, struct page *page,
+                                size_t copied, struct page *page,
                                 struct iomap *iomap)
 {
        struct gfs2_trans *tr = current->journal_info;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 4d1d3c3469e9..d3b06bffd996 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -106,9 +106,9 @@ iomap_sector(struct iomap *iomap, loff_t pos)
  * associated page could not be obtained.
  */
 struct iomap_page_ops {
-       int (*page_prepare)(struct inode *inode, loff_t pos, unsigned len,
+       int (*page_prepare)(struct inode *inode, loff_t pos, size_t len,
                        struct iomap *iomap);
-       void (*page_done)(struct inode *inode, loff_t pos, unsigned copied,
+       void (*page_done)(struct inode *inode, loff_t pos, size_t copied,
                        struct page *page, struct iomap *iomap);
 };
 


The other is an amendment of this:

-static int
-iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags
,
-               struct page **pagep, struct iomap *iomap, struct iomap *srcmap)
+static ssize_t iomap_write_begin(struct inode *inode, loff_t pos, size_t len,
+               unsigned flags, struct page **pagep, struct iomap *iomap,
+               struct iomap *srcmap)

and I drop the clamp to UINT_MAX.  I also added:

-               unsigned long offset;   /* Offset into pagecache page */
-               unsigned long bytes;    /* Bytes to write to page */
+               size_t offset;          /* Offset into pagecache page */
+               size_t bytes;           /* Bytes to write to page */

which won't change anything, but does fit the general pattern of
using size_t for a byte count of in-memory things.  It matches
iomap_unshare_actor(), for example.

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECCB415BF97
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 14:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730030AbgBMNnW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 08:43:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51498 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729801AbgBMNnW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 08:43:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=57P4Q/GU2ra8qTXmZpI2Z/3+4gqtkjqSHRcsBClNQtg=; b=rSzaYz7/rumIfdFG+MdlTwtWLq
        KJDbhGYitV4p48O5SGrNFqm7b6XrkzPNvpJkvwLsbmPzqOjljvrrI/kGme5i39kPjSCbZwMVJj/gp
        /vZh8pgUFXWHWX8sVicFVEOt39rpppNWYqPj6hi4J8dYGEOsWyymiKiHcRkxOz883kzq6ZSKHqjk3
        fsehuyu0gDewtgLxKPXDc7teJpZ6SJQvrPw6Tb1R8zCLV/rYe5SP5WtC5ElJI7KBaqIo6dB7dEuoo
        fa9oGjFgIiPAK7v7SmERxvNZ+0wRUV+dCDxCmPFGbyPDr/p1ZkogJK5cSzTw9SfomXbDVvK3/M17m
        Yx42/x7g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j2Elw-0008Pa-QR; Thu, 13 Feb 2020 13:43:16 +0000
Date:   Thu, 13 Feb 2020 05:43:16 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        cluster-devel@redhat.com, ocfs2-devel@oss.oracle.com,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [PATCH 00/12] Change readahead API
Message-ID: <20200213134316.GK7778@bombadil.infradead.org>
References: <20200125013553.24899-1-willy@infradead.org>
 <20200212203852.8b7e0b28974e41227bd97329@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212203852.8b7e0b28974e41227bd97329@linux-foundation.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 12, 2020 at 08:38:52PM -0800, Andrew Morton wrote:
> On Fri, 24 Jan 2020 17:35:41 -0800 Matthew Wilcox <willy@infradead.org> wrote:
> 
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > This series adds a readahead address_space operation to eventually
> > replace the readpages operation.  The key difference is that
> > pages are added to the page cache as they are allocated (and
> > then looked up by the filesystem) instead of passing them on a
> > list to the readpages operation and having the filesystem add
> > them to the page cache.  It's a net reduction in code for each
> > implementation, more efficient than walking a list, and solves
> > the direct-write vs buffered-read problem reported by yu kuai at
> > https://lore.kernel.org/linux-fsdevel/20200116063601.39201-1-yukuai3@huawei.com/
> 
> Unclear which patch fixes this and how it did it?

I suppose the problem isn't fixed until patch 13/13 is applied.
What yu kuai is seeing is a race where readahead allocates a page,
then passes it to iomap_readpages, which calls xfs_read_iomap_begin()
which looks up the extent.  Then thread 2 does DIO which modifies the
extent, because there's nothing to say that thread 1 is still using it.
With this patch series, the readpages code puts the locked pages in the
cache before calling iomap_readpages, so any racing write will block on
the locked page until readahead is completed.

If you're tempted to put this into -mm, I have a couple of new changes;
one to fix a kernel-doc warning for mpage_readahead() and one to add
kernel-doc for iomap_readahead():

+++ b/fs/mpage.c
@@ -339,9 +339,7 @@
 
 /**
  * mpage_readahead - start reads against pages
- * @mapping: the address_space
- * @start: The number of the first page to read.
- * @nr_pages: The number of consecutive pages to read.
+ * @rac: Describes which pages to read.
  * @get_block: The filesystem's block mapper function.
  *
  * This function walks the pages and the blocks within each page, building and

+++ b/fs/iomap/buffered-io.c
@@ -395,6 +395,21 @@
 	return done;
 }
 
+/**
+ * iomap_readahead - Attempt to read pages from a file.
+ * @rac: Describes the pages to be read.
+ * @ops: The operations vector for the filesystem.
+ *
+ * This function is for filesystems to call to implement their readahead
+ * address_space operation.
+ *
+ * Context: The file is pinned by the caller, and the pages to be read are
+ * all locked and have an elevated refcount.  This function will unlock
+ * the pages (once I/O has completed on them, or I/O has been determined to
+ * not be necessary).  It will also decrease the refcount once the pages
+ * have been submitted for I/O.  After this point, the page may be removed
+ * from the page cache, and should not be referenced.
+ */
 void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 {
 	struct inode *inode = rac->mapping->host;

I'll do a v6 with those changes soon, but I would really like a bit more
review from filesystem people, particularly ocfs2 and gfs2.

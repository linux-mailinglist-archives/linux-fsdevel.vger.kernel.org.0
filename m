Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17C448F30E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 20:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732731AbfHOSSG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 14:18:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52518 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfHOSSG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 14:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=juAhuh8ocNm+VLit5UQVJy7awwSz34vKy9CkzRbIwc4=; b=FD17lM8uIRJr1AZE/aoLJqIZx
        h90MHL/pF6QIZK2zqCFYxFYstB6Z4nmBc4xPd8DLr/nRgBuuGODBKAQJvWFh1HjsN0FVbPk1VPkj7
        0B0HkT22vo/HlvCKRaGIcSBdJ5ATcT5mwzgAZWFg8FkBUggJ2kL1u/yuFrbjkAkpMeHgOnGGe+Zb+
        fulYAX/V9Mvfmge/UTIuPdiGDF27SxJr6VqkAHW9vvfjW8a24Kv3bZSv6EnF+ZnTOUXbzVcEm+OkM
        gNa8cZFeXzmbQr1mUXd/jTrzmM6UT09TiTHpbRfO+s5pBaI4YeFlZEW0lbCU7TNdG77W3kIv/Qpjq
        r7Z9QdtNg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hyKK4-0004PO-Of; Thu, 15 Aug 2019 18:18:04 +0000
Date:   Thu, 15 Aug 2019 11:18:04 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        fdmanana@gmail.com, gaoxiang25@huawei.com
Subject: Re: [PATCH v4] vfs: fix page locking deadlocks when deduping files
Message-ID: <20190815181804.GB18474@bombadil.infradead.org>
References: <20190815164940.GA15198@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815164940.GA15198@magnolia>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 15, 2019 at 09:49:40AM -0700, Darrick J. Wong wrote:
> Fixes: 876bec6f9bbfcb3 ("vfs: refactor clone/dedupe_file_range common functions")
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

(I approve of this patch going upstream)

However, I think there are further simplifications to be made here.
With this patch applied, vfs_dedupe_get_page() now looks like this:

static struct page *vfs_dedupe_get_page(struct inode *inode, loff_t offset)
{
        struct page *page;

        page = read_mapping_page(inode->i_mapping, offset >> PAGE_SHIFT, NULL);
        if (IS_ERR(page))
                return page;
        if (!PageUptodate(page)) {
                put_page(page);
                return ERR_PTR(-EIO);
        }
        return page;
}

But I don't think read_mapping_page() can return a page which doesn't have
PageUptodate set.  Follow the path down through read_cache_page() into
do_read_cache_page().

Other than the locations which return an ERR_PTR, the only return point
is at the out: label.  Three of the gotos to 'out' are guarded by 'if
(PageUptodate)'.  The fourth is after calling wait_on_page_read().  Which
will return ERR_PTR(-EIO) if the page isn't Uptodate after being unlocked.

Subtracting that never-exercised check from the routine leaves us with:

static struct page *vfs_dedupe_get_page(struct inode *inode, loff_t offset)
{
        struct page *page;

        page = read_mapping_page(inode->i_mapping, offset >> PAGE_SHIFT, NULL);
        if (IS_ERR(page))
                return page;
        return page;
}

which is fundamentally just:

static struct page *vfs_dedupe_get_page(struct inode *inode, loff_t offset)
{
        return read_mapping_page(inode->i_mapping, offset >> PAGE_SHIFT, NULL);
}

which seems like it might have a better name and be located in pagemap.h?

I might also like to see

 out:
+	VM_BUG_ON(!PageUptodate(page));
 	mark_page_accessed(page);

at the end of do_read_cache_page(), just to be sure nobody ever screws
that up.


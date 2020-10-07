Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A9B286AB6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 00:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgJGWJT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Oct 2020 18:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgJGWJT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Oct 2020 18:09:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EC3C061755;
        Wed,  7 Oct 2020 15:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FEyhRMHjvO7n4JR1kZOaUpAum7aLXI1/AmH/kM8Di7Q=; b=jEQFarLVGmJvJtUMk7xjGMLhHE
        ksIEFR5pAQc9z0QNSgqcXKyCc2ixuFlwwpafyim20TV/jPW8Rc8fYoMlVPDDzNmRe4+4Cq90ACmx4
        hTm2i6ZKXEYViCRFk/1m1WZu6EyPWr27SMVKyRAQIoSfZQ5c8fy1/ZCActML71txswZbHwqsGxbog
        L6soLM5Tn5mDPs88ZZV3TXf+ybIUD4UVdD9ft7ABL4R1OTnBT4JyQFFj6Rmor3YdBRpmmGfgEOSrU
        4mHu3/zP5mTEtQiPYTt4xHoUr6JheZYj1EhlTIj0ZD7OK8X0NWoN5lOUKxL/qGgXWRyEwWq3cKEsy
        BG1NyvrA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQHca-0008Qf-M0; Wed, 07 Oct 2020 22:09:16 +0000
Date:   Wed, 7 Oct 2020 23:09:16 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH 00/14] Small step toward KSM for file back page.
Message-ID: <20201007220916.GX20115@casper.infradead.org>
References: <20201007010603.3452458-1-jglisse@redhat.com>
 <20201007032013.GS20115@casper.infradead.org>
 <20201007144835.GA3471400@redhat.com>
 <20201007170558.GU20115@casper.infradead.org>
 <20201007175419.GA3478056@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007175419.GA3478056@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 07, 2020 at 01:54:19PM -0400, Jerome Glisse wrote:
> > For other things (NUMA distribution), we can point to something which
> > isn't a struct page and can be distiguished from a real struct page by a
> > bit somewhere (I have ideas for at least three bits in struct page that
> > could be used for this).  Then use a pointer in that data structure to
> > point to the real page.  Or do NUMA distribution at the inode level.
> > Have a way to get from (inode, node) to an address_space which contains
> > just regular pages.
> 
> How do you find all the copies ? KSM maintains a list for a reasons.
> Same would be needed here because if you want to break the write prot
> you need to find all the copy first. If you intend to walk page table
> then how do you synchronize to avoid more copy to spawn while you
> walk reverse mapping, we could lock the struct page i guess. Also how
> do you walk device page table which are completely hidden from core mm.

So ... why don't you put a PageKsm page in the page cache?  That way you
can share code with the current KSM implementation.  You'd need
something like this:

+++ b/mm/filemap.c
@@ -1622,6 +1622,9 @@ struct page *find_lock_entry(struct address_space *mapping
, pgoff_t index)
                lock_page(page);
                /* Has the page been truncated? */
                if (unlikely(page->mapping != mapping)) {
+                       if (PageKsm(page)) {
+                               ...
+                       }
                        unlock_page(page);
                        put_page(page);
                        goto repeat;
@@ -1655,6 +1658,7 @@ struct page *find_lock_entry(struct address_space *mapping, pgoff_t index)
  * * %FGP_WRITE - The page will be written
  * * %FGP_NOFS - __GFP_FS will get cleared in gfp mask
  * * %FGP_NOWAIT - Don't get blocked by page lock
+ * * %FGP_KSM - Return KSM pages
  *
  * If %FGP_LOCK or %FGP_CREAT are specified then the function may sleep even
  * if the %GFP flags specified for %FGP_CREAT are atomic.
@@ -1687,6 +1691,11 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 
                /* Has the page been truncated? */
                if (unlikely(page->mapping != mapping)) {
+                       if (PageKsm(page) {
+                               if (fgp_flags & FGP_KSM)
+                                       return page;
+                               ...
+                       }
                        unlock_page(page);
                        put_page(page);
                        goto repeat;

I don't know what you want to do when you find a KSM page, so I just left
an ellipsis.


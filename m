Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB0332B4E8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Mar 2021 06:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450168AbhCCFa7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 00:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237684AbhCCBfB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Mar 2021 20:35:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D70C061756
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Mar 2021 17:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UUCunpPK/kEanZj5qySdAgYlSOPrCb0CzB9Vx5ufnXY=; b=KwIWmwUhK2ceCpxvoFWtLsuxLu
        mayXYnhwOt/Q8WQI7S8tL6z/cRUtwyWdrmQwOuOEwQwUcU529uChVXxmpUhZS7dMjBY0c3STSR7qB
        A6ujRtTGvvMY9Rc0BA80wyoXja0TCviYQ2CPyEm0Ry6tVwDIV/aAzoXQzUSpg5jt9YSApJWLPGl7T
        FXE+bedrynxDeAAn519S72xD/rISeTaIONR69bzLVoRsDdkS392N7LhKqXGMw6RJspOJzYTTfVphy
        8qCe2HYHyX8dCE6v9PHubLeKZGxcbNdsu9MI7xi91xqGQA1tlGm6MOO7tZn+p7ZBYDGCeeaChMEtr
        V7UsGGhg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lHGO1-000sSZ-KF; Wed, 03 Mar 2021 01:33:14 +0000
Date:   Wed, 3 Mar 2021 01:33:13 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] mm/filemap: Use filemap_read_page in filemap_fault
Message-ID: <20210303013313.GZ2723601@casper.infradead.org>
References: <20210226140011.2883498-1-willy@infradead.org>
 <20210302173039.4625f403846abd20413f6dad@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302173039.4625f403846abd20413f6dad@linux-foundation.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 02, 2021 at 05:30:39PM -0800, Andrew Morton wrote:
> On Fri, 26 Feb 2021 14:00:11 +0000 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:
> 
> > After splitting generic_file_buffered_read() into smaller parts, it
> > turns out we can reuse one of the parts in filemap_fault().  This fixes
> > an oversight -- waiting for the I/O to complete is now interruptible
> > by a fatal signal.  And it saves us a few bytes of text in an unlikely
> > path.
> 
> We also handle AOP_TRUNCATED_PAGE which the present code fails to do. 
> Should this be in the changelog?

No, the present code does handle AOP_TRUNCATED_PAGE.  It's perhaps not
the clearest in the diff, but it's there.  Here's git show -U5:

-       ClearPageError(page);
        fpin = maybe_unlock_mmap_for_io(vmf, fpin);
-       error = mapping->a_ops->readpage(file, page);
-       if (!error) {
-               wait_on_page_locked(page);
-               if (!PageUptodate(page))
-                       error = -EIO;
-       }
+       error = filemap_read_page(file, mapping, page);
        if (fpin)
                goto out_retry;
        put_page(page);
 
        if (!error || error == AOP_TRUNCATED_PAGE)
                goto retry_find;
 
-       shrink_readahead_size_eio(ra);
        return VM_FAULT_SIGBUS;

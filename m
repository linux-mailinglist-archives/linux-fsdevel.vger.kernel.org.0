Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96CF141837A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Sep 2021 19:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhIYRMY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Sep 2021 13:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhIYRMY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Sep 2021 13:12:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E7DC061570;
        Sat, 25 Sep 2021 10:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6GW8m99cwWwrKJpThjZDb6GAcdSzWmr59+OAVUULh/4=; b=wIJ/z5Pf4qc/NRbdHahqEcKlFh
        xi7rk3SB+eFCQsAivXx/SZlAI3nZ1B+Gexsbziymg38NFlt+qNOeNhfDFGS7WNpoy9P6lPKzYF3lM
        QIIMcZWj6sSt6VCo3rctoO1eExcMHzmgXDygsJmbQlPKeaKyb2UzmvXKCjpcWtRhEFCg8pxiaiV5c
        g3cm7c8o/yMJ2MKP+jYoEaHx/i5AP2faYXraXpMpk9DxZ+VDQj7kYDpdzFLJ41tZdkDFSed6UuGez
        zxyg/1q8QZPXx5qrAPb5K6iborPgrk3HHDUXxBVim2uGXeZ/jq7QixuVz65AY2QlRgJRB5l0aNark
        jbWVBjwA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUBBK-008GPg-Vk; Sat, 25 Sep 2021 17:09:55 +0000
Date:   Sat, 25 Sep 2021 18:09:46 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     hch@lst.de, trond.myklebust@primarydata.com,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, darrick.wong@oracle.com,
        viro@zeniv.linux.org.uk, jlayton@kernel.org,
        torvalds@linux-foundation.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 9/9] mm: Remove swap BIO paths and only use DIO paths
Message-ID: <YU9X2o74+aZP4iWV@casper.infradead.org>
References: <YU84rYOyyXDP3wjp@casper.infradead.org>
 <163250387273.2330363.13240781819520072222.stgit@warthog.procyon.org.uk>
 <163250396319.2330363.10564506508011638258.stgit@warthog.procyon.org.uk>
 <2396106.1632584202@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2396106.1632584202@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 25, 2021 at 04:36:42PM +0100, David Howells wrote:
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > On Fri, Sep 24, 2021 at 06:19:23PM +0100, David Howells wrote:
> > > Delete the BIO-generating swap read/write paths and always use ->swap_rw().
> > > This puts the mapping layer in the filesystem.
> > 
> > Is SWP_FS_OPS now unused after this patch?
> 
> Ummm.  Interesting question - it's only used in swap_set_page_dirty():
> 
> int swap_set_page_dirty(struct page *page)
> {
> 	struct swap_info_struct *sis = page_swap_info(page);
> 
> 	if (data_race(sis->flags & SWP_FS_OPS)) {
> 		struct address_space *mapping = sis->swap_file->f_mapping;
> 
> 		VM_BUG_ON_PAGE(!PageSwapCache(page), page);
> 		return mapping->a_ops->set_page_dirty(page);
> 	} else {
> 		return __set_page_dirty_no_writeback(page);
> 	}
> }

I suspect that's no longer necessary.  NFS was the only filesystem
using SWP_FS_OPS and ...

fs/nfs/file.c:  .set_page_dirty = __set_page_dirty_nobuffers,

so it's not like NFS does anything special to reserve memory to write
back swap pages.

> > Also, do we still need ->swap_activate and ->swap_deactivate?
> 
> f2fs does quite a lot of work in its ->swap_activate(), as does btrfs.  I'm
> not sure how necessary it is.  cifs looks like it intends to use it, but it's
> not fully implemented yet.  zonefs and nfs do some checking, including hole
> checking in nfs's case.  nfs also does some setting up for the sunrpc
> transport.
> 
> btrfs, cifs, f2fs and nfs all supply ->swap_deactivate() to undo the effects
> of the activation.

Right ... so my question really is, now that we're doing I/O through
aops->direct_IO (or ->swap_rw), do those magic things need to be done?
After all, open(O_DIRECT) doesn't do these same magic things.  They're
really there to allow the direct-to-BIO path to work, and you're removing
that here.

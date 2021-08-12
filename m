Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B09A3EA514
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 15:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237613AbhHLNCu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 09:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235971AbhHLNCt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 09:02:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C797C061765;
        Thu, 12 Aug 2021 06:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KapCwCgb5M/iDHR5WR0+lkw3WeXDUWMNBxTJHFQJfdk=; b=mUxh/OAAFJWkKC9+tghFkWl6hg
        SZiBaIayBiLszQP6Y6dHB8UvkrxEK3sQ9wab2rBSWRK2bhYHSwZa129SIRI2avRPZfWPJeGzG060b
        T3zCuCccJk3aevzfE5d6a/3Hb7gnv/gNqQweiqHELVODBTwRc4Rwr1y2FVZswU170C5YfHboMqiXS
        5dR3EmfcarVaOGLY+8q5RBjYsga667g5MwbuNeieBs98bD8acNKTJhoW8UyYEG5U92f4IWX+uNy3u
        X9Psw1hLChFTCFrgqcNzV0/rKUbyOKhVzTYsko3pZGzje14uic6S4HZdHO29oLJxYBi0xWoIrfK1t
        fUfKRYvw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mEAJi-00EaEh-DM; Thu, 12 Aug 2021 13:00:28 +0000
Date:   Thu, 12 Aug 2021 14:00:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     trond.myklebust@primarydata.com, darrick.wong@oracle.com,
        hch@lst.de, jlayton@kernel.org, sfrench@samba.org,
        torvalds@linux-foundation.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: Make swap_readpage() for SWP_FS_OPS use
 ->direct_IO() not ->readpage()
Message-ID: <YRUbXoMzWVX9X/Vf@casper.infradead.org>
References: <162876946134.3068428.15475611190876694695.stgit@warthog.procyon.org.uk>
 <162876947840.3068428.12591293664586646085.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162876947840.3068428.12591293664586646085.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 12, 2021 at 12:57:58PM +0100, David Howells wrote:

I'm not quite sure why we need the refcount.

> +	refcount_set(&ki->ki_refcnt, 2);
> +	init_sync_kiocb(&ki->iocb, swap_file);
> +	ki->page = page;
> +	ki->iocb.ki_flags = IOCB_DIRECT | IOCB_SWAP;
> +	ki->iocb.ki_pos	= page_file_offset(page);
> +	ki->iocb.ki_filp = get_file(swap_file);
> +	if (!synchronous)
> +		ki->iocb.ki_complete = swapfile_read_complete;
> +
> +	iov_iter_bvec(&to, READ, &bv, 1, PAGE_SIZE);
> +	ret = swap_file->f_mapping->a_ops->direct_IO(&ki->iocb, &to);

After submitting the IO here ...

> +	if (ret != -EIOCBQUEUED)
> +		swapfile_read_complete(&ki->iocb, ret, 0);

We only touch the 'ki' here ... if the caller didn't call read_complete

> +	swapfile_put_kiocb(ki);

Except for here, which is only touched in order to put the refcount.

So why can't swapfile_read_complete() do the work of freeing the ki?


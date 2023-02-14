Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C242695DA7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Feb 2023 09:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjBNIyR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 03:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbjBNIyQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 03:54:16 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFFF30C1;
        Tue, 14 Feb 2023 00:54:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D1B23CE1F9A;
        Tue, 14 Feb 2023 08:54:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86853C433EF;
        Tue, 14 Feb 2023 08:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676364851;
        bh=eC80PHI1ooSblGe91IHUzwxVElTDY0sMh4t/9tmkIwA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jaCrsMIIV0pkTizi04A78l7Vc23QZg8siZQ9wqEdEJqT1imU6XoRZl8Me4hQuNN3f
         Ez8CXWABSHLfW11IdUq+F5CdYpc6uW5WS+ZRPkZEi7oC45rdB+QwbLOhunCCyrz81k
         I1pQweAPsj7n+g+ZstP6kUMb7zBSKATwQnBafEYI=
Date:   Tue, 14 Feb 2023 09:54:08 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Daniel Golle <daniel@makrotopia.org>,
        Guenter Roeck <groeck7@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Hugh Dickins <hughd@google.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>,
        Arnd Bergmann <arnd@arndb.de>, coda@cs.cmu.edu,
        codalist@coda.cs.cmu.edu, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v3 5/5] shmem, overlayfs, coda, tty, proc, kernfs,
 random: Fix splice-read
Message-ID: <Y+tMMAEiKUEDzZMa@kroah.com>
References: <20230214083710.2547248-1-dhowells@redhat.com>
 <20230214083710.2547248-6-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214083710.2547248-6-dhowells@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 14, 2023 at 08:37:10AM +0000, David Howells wrote:
> The new filemap_splice_read() has an implicit expectation via
> filemap_get_pages() that ->read_folio() exists if ->readahead() doesn't
> fully populate the pagecache of the file it is reading from[1], potentially
> leading to a jump to NULL if this doesn't exist.
> 
> A filesystem or driver shouldn't suffer from this if:
> 
>   - It doesn't set ->splice_read()
>   - It implements ->read_folio()
>   - It implements its own ->splice_read()
> 
> Note that some filesystems set generic_file_splice_read() and
> generic_file_read_iter() but don't set ->read_folio().  g_f_read_iter()
> will fall back to filemap_read_iter() which looks like it should suffer
> from the same issue.
> 
> Certain drivers, can just use direct_splice_read() rather than
> generic_file_splice_read() as that creates an output buffer and then just
> calls their ->read_iter() function:
> 
>   - random & urandom
>   - tty
>   - kernfs
>   - proc
>   - proc_namespace
> 
> Stacked filesystems just need to pass the operation down a layer:
> 
>   - coda
>   - overlayfs
> 
> And finally, there's shmem (used in tmpfs, ramfs, rootfs).  This needs its
> own splice-read implementation, based on filemap_splice_read(), but able to
> paste in zero_page when there's a page missing.
> 
> Fixes: d9722a475711 ("splice: Do splice read from a buffered file without using ITER_PIPE")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Daniel Golle <daniel@makrotopia.org>
> cc: Guenter Roeck <groeck7@gmail.com>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: John Hubbard <jhubbard@nvidia.com>
> cc: David Hildenbrand <david@redhat.com>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: Miklos Szeredi <miklos@szeredi.hu>
> cc: Hugh Dickins <hughd@google.com>
> cc: Jan Harkes <jaharkes@cs.cmu.edu>
> cc: Arnd Bergmann <arnd@arndb.de>
> cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> cc: coda@cs.cmu.edu
> cc: codalist@coda.cs.cmu.edu
> cc: linux-unionfs@vger.kernel.org
> cc: linux-block@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> Link: https://lore.kernel.org/r/Y+pdHFFTk1TTEBsO@makrotopia.org/ [1]
> ---

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

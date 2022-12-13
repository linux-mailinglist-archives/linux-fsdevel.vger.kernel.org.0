Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2383264BDB8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 21:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236790AbiLMUDq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 15:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236458AbiLMUDp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 15:03:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2F324F38;
        Tue, 13 Dec 2022 12:03:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0186BB81202;
        Tue, 13 Dec 2022 20:03:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86A1C433F0;
        Tue, 13 Dec 2022 20:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670961821;
        bh=GvhiLr0xC3KUZwXYNSzLzaLgDZGXIId+AdtK4eHrDmo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j+xn84Gt1gG+TdS9u/ofHXEagnykFX4dtpUxJYAAXF2hfQKIckvMa2H+QZPX7eidQ
         YbWzXEZWxJxY7z2KCnd2lTTHwPRPHrw6eeXhV/CQFItM9p4XVhg2RyCZ/XhsqOzwqu
         uEJN7BqjnuRWF1Ek61JvCWPlqU5CpyiisGG6TXlaK0O+9UvmaODzFIPMx6iouRoKCy
         ZmTo3x6UrjxKlCNbwyy0qUIAwkxu6utnWVjqcPlAeLbVgVhTcRSen2q6zo+6P0gInW
         k+nTX0Pew5OklLZKzU/oiDoa10ch5kBCSCo+OLHp0wau04MLRR2Dxvg8h7yiJYwEfE
         /P910fdm21Eow==
Date:   Tue, 13 Dec 2022 12:03:41 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: Move page_done callback under the folio lock
Message-ID: <Y5janUs2/29XZRbc@magnolia>
References: <20221213194833.1636649-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213194833.1636649-1-agruenba@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 13, 2022 at 08:48:33PM +0100, Andreas Gruenbacher wrote:
> Hi Darrick,
> 
> I'd like to get the following iomap change into this merge window.  This
> only affects gfs2, so I can push it as part of the gfs2 updates if you
> don't mind, provided that I'll get your Reviewed-by confirmation.
> Otherwise, if you'd prefer to pass this through the xfs tree, could you
> please take it?

I don't mind you pushing changes to ->page_done through the gfs2 tree,
but don't you need to move the other callsite at the bottom of
iomap_write_begin?

--D

> Thanks,
> Andreas
> 
> --
> 
> Move the ->page_done() call in iomap_write_end() under the folio lock.
> This closes a race between journaled data writes and the shrinker in
> gfs2.  What's happening is that gfs2_iomap_page_done() is called after
> the page has been unlocked, so try_to_free_buffers() can come in and
> free the buffers while gfs2_iomap_page_done() is trying to add them to
> the current transaction.  The folio lock prevents that from happening.
> 
> The only user of ->page_done() is gfs2, so other filesystems are not
> affected.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  fs/iomap/buffered-io.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 91ee0b308e13..476c9ed1b333 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -714,12 +714,12 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
>  		i_size_write(iter->inode, pos + ret);
>  		iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
>  	}
> +	if (page_ops && page_ops->page_done)
> +		page_ops->page_done(iter->inode, pos, ret, &folio->page);
>  	folio_unlock(folio);
>  
>  	if (old_size < pos)
>  		pagecache_isize_extended(iter->inode, old_size, pos);
> -	if (page_ops && page_ops->page_done)
> -		page_ops->page_done(iter->inode, pos, ret, &folio->page);
>  	folio_put(folio);
>  
>  	if (ret < len)
> -- 
> 2.38.1
> 

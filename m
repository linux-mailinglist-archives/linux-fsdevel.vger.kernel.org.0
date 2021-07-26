Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC1B3D6532
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 19:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbhGZQ2z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 12:28:55 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47440 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240703AbhGZQWX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 12:22:23 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B18C022025;
        Mon, 26 Jul 2021 17:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627318970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FAwjGM+xVmGYEdHGyZqTvRWuEDVGbGLsmHWyTizXLgg=;
        b=KMUhGR0hlInRskRLIj5AjMSJvlsUuU5HlzWO0Vq6usp28f2s72UvULjWbGSK39AHGdVNjc
        ZrEiD7Sz83RNH9aSNvWxU/4j+Kh8XDnnfzrrAd/Vopm51zeMB7+85+pV/J/tiJ2tu45eP4
        N/cbANT0fM5JxI25fHE7lr5qxeRvivs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627318970;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FAwjGM+xVmGYEdHGyZqTvRWuEDVGbGLsmHWyTizXLgg=;
        b=Mqv4WKMaz0NjmCbEvD+unTy7KXQsBYFZShH+ZVhc20E7QercjFlOAg9EMWuXVCLsTEJ8Px
        P1CT3FnjvyBeyzBw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 9BD91A3B9F;
        Mon, 26 Jul 2021 17:02:50 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6EA851E3B13; Mon, 26 Jul 2021 19:02:50 +0200 (CEST)
Date:   Mon, 26 Jul 2021 19:02:50 +0200
From:   Jan Kara <jack@suse.cz>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH v3 7/7] gfs2: Fix mmap + page fault deadlocks for direct
 I/O
Message-ID: <20210726170250.GL20621@quack2.suse.cz>
References: <20210723205840.299280-1-agruenba@redhat.com>
 <20210723205840.299280-8-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723205840.299280-8-agruenba@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 23-07-21 22:58:40, Andreas Gruenbacher wrote:
> Also disable page faults during direct I/O requests and implement the same kind
> of retry logic as in the buffered I/O case.
> 
> Direct I/O requests differ from buffered I/O requests in that they use
> bio_iov_iter_get_pages for grabbing page references and faulting in pages
> instead of triggering real page faults.  Those manual page faults can be
> disabled with the iocb->noio flag.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  fs/gfs2/file.c | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
> index f66ac7f56f6d..7986f3be69d2 100644
> --- a/fs/gfs2/file.c
> +++ b/fs/gfs2/file.c
> @@ -782,21 +782,41 @@ static ssize_t gfs2_file_direct_read(struct kiocb *iocb, struct iov_iter *to,
>  	struct file *file = iocb->ki_filp;
>  	struct gfs2_inode *ip = GFS2_I(file->f_mapping->host);
>  	size_t count = iov_iter_count(to);
> +	size_t written = 0;
>  	ssize_t ret;
>  
> +	/*
> +	 * In this function, we disable page faults when we're holding the
> +	 * inode glock while doing I/O.  If a page fault occurs, we drop the
> +	 * inode glock, fault in the pages manually, and then we retry.  Other
> +	 * than in gfs2_file_read_iter, iomap_dio_rw can trigger implicit as
> +	 * well as manual page faults, and we need to disable both kinds
> +	 * separately.
> +	 */
> +
>  	if (!count)
>  		return 0; /* skip atime */
>  
>  	gfs2_holder_init(ip->i_gl, LM_ST_DEFERRED, 0, gh);
> +retry:
>  	ret = gfs2_glock_nq(gh);
>  	if (ret)
>  		goto out_uninit;
>  
> +	pagefault_disable();

Is there any use in pagefault_disable() here? iomap_dio_rw() should not
trigger any page faults anyway, should it?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

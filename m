Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E677A4A3CED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 05:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357627AbiAaE2m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jan 2022 23:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiAaE2l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jan 2022 23:28:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D6EC061714;
        Sun, 30 Jan 2022 20:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ES2qGLKjk4kMyKJP2zSqS3u5uFPSOTFVXfX3BK4dR8Q=; b=nOyiGMrYnkL+cwvfxXygFZ0+pe
        IFhK0DanjYrlTWy2+2tJ0Fv5NYmVsHmrEg8r3Tv7fUWI7zSsVRDC5KXHQXmYtz1fyZ1AxVVixOnT/
        80XbkI+T3/PzAUQcnwieiIW0EY3cnC0Izgv2gH8DefwqBUKVQXfMKxB0SRyMKF4wS80AAjI4RW4qo
        AegECF3AFlMGMPv4gkAI1YJwN5Z0iY4W7ixlA39NqIwt5cV4BHiMS/813+j+MELpIGzdKjkGDM7Or
        vhpU5p8MXT5Q8UAkIGfSdIIFi8sts1jlCtbZU73uVhbG3ZNP8eUrEY5Tr8LQee4DkL4D750dxV9st
        JYF3cT9w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEOIp-009GEh-4h; Mon, 31 Jan 2022 04:28:31 +0000
Date:   Mon, 31 Jan 2022 04:28:31 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] fuse: remove reliance on bdi congestion
Message-ID: <YfdlbxezYSOSYmJf@casper.infradead.org>
References: <164360127045.4233.2606812444285122570.stgit@noble.brown>
 <164360183348.4233.761031466326833349.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164360183348.4233.761031466326833349.stgit@noble.brown>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 31, 2022 at 03:03:53PM +1100, NeilBrown wrote:
> diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
> index 182b24a14804..5f74e2585f50 100644
> --- a/fs/fuse/dax.c
> +++ b/fs/fuse/dax.c
> @@ -781,6 +781,9 @@ static int fuse_dax_writepages(struct address_space *mapping,
>  	struct inode *inode = mapping->host;
>  	struct fuse_conn *fc = get_fuse_conn(inode);
>  
> +	if (wbc->sync_mode == WB_SYNC_NONE &&
> +	    fc->num_background >= fc->congestion_threshold)
> +		return 0;
>  	return dax_writeback_mapping_range(mapping, fc->dax->dev, wbc);

This makes no sense.  Doing writeback for DAX means flushing the
CPU cache (in a terribly inefficient way), but it's not going to
be doing anything in the background; it's a sync operation.

> +++ b/fs/fuse/file.c
> @@ -958,6 +958,8 @@ static void fuse_readahead(struct readahead_control *rac)
>  
>  	if (fuse_is_bad(inode))
>  		return;
> +	if (fc->num_background >= fc->congestion_threshold)
> +		return;

This seems like a bad idea to me.  If we don't even start reads on
readahead pages, they'll get ->readpage called on them one at a time
and the reading thread will block.  It's going to lead to some nasty
performance problems, exactly when you don't want them.  Better to
queue the reads internally and wait for congestion to ease before
submitting the read.


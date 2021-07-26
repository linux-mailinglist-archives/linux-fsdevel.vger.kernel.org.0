Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398EC3D6592
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 19:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241746AbhGZQjt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 12:39:49 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48564 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238015AbhGZQjN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 12:39:13 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 63A151FECC;
        Mon, 26 Jul 2021 17:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627319980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zqJFxm3DslHec2M18KWDSFwDCWT/wQs0v44ZacRghJw=;
        b=2YBb2jw9T9G6mkASlJjYijLvhkUlorvux5veJW+aM/pXrPugQ1fPtYa55eRRCX4bZnBT42
        Ex6K01Io2qgEGJdAur9YsMR19EKAtyFTnZgz7k9BH9oyyLR9Ye5lyKzrTkxu1QUvlOAEHI
        ObJ26+X46A5cPqOwq8VGthxX1mU1glI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627319980;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zqJFxm3DslHec2M18KWDSFwDCWT/wQs0v44ZacRghJw=;
        b=77GddXGKjj5sKVpoFtfwFsp261+LjVICZ0p0a3SfxGi2cCD9JTyetXCDtXm5waqN+ATKeQ
        /GholCGNP9LQLHBA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 4ECF8A3B85;
        Mon, 26 Jul 2021 17:19:40 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1C1F11E3B13; Mon, 26 Jul 2021 19:19:40 +0200 (CEST)
Date:   Mon, 26 Jul 2021 19:19:40 +0200
From:   Jan Kara <jack@suse.cz>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH v3 5/7] iomap: Support restarting direct I/O requests
 after user copy failures
Message-ID: <20210726171940.GM20621@quack2.suse.cz>
References: <20210723205840.299280-1-agruenba@redhat.com>
 <20210723205840.299280-6-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723205840.299280-6-agruenba@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 23-07-21 22:58:38, Andreas Gruenbacher wrote:
> In __iomap_dio_rw, when iomap_apply returns an -EFAULT error, complete the
> request synchronously and reset the iterator to the start position.  This
> allows callers to deal with the failure and retry the operation.
> 
> In gfs2, we need to disable page faults while we're holding glocks to prevent
> deadlocks.  This patch is the minimum solution I could find to make
> iomap_dio_rw work with page faults disabled.  It's still expensive because any
> I/O that was carried out before hitting -EFAULT needs to be retried.
> 
> A possible improvement would be to add an IOMAP_DIO_FAULT_RETRY or similar flag
> that would allow iomap_dio_rw to return a short result when hitting -EFAULT.
> Callers could then retry only the rest of the request after dealing with the
> page fault.
> 
> Asynchronous requests turn into synchronous requests up to the point of the
> page fault in any case, but they could be retried asynchronously after dealing
> with the page fault.  To make that work, the completion notification would have
> to include the bytes read or written before the page fault(s) as well, and we'd
> need an additional iomap_dio_rw argument for that.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  fs/iomap/direct-io.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index cc0b4bc8861b..b0a494211bb4 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -561,6 +561,15 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		ret = iomap_apply(inode, pos, count, iomap_flags, ops, dio,
>  				iomap_dio_actor);
>  		if (ret <= 0) {
> +			if (ret == -EFAULT) {
> +				/*
> +				 * To allow retrying the request, fail
> +				 * synchronously and reset the iterator.
> +				 */
> +				wait_for_completion = true;
> +				iov_iter_revert(dio->submit.iter, dio->size);
> +			}
> +

Hum, OK, but this means that if userspace submits large enough write, GFS2
will livelock trying to complete it? While other filesystems can just
submit multiple smaller bios constructed in iomap_apply() (paging in
different parts of the buffer) and thus complete the write?

								Honza

>  			/* magic error code to fall back to buffered I/O */
>  			if (ret == -ENOTBLK) {
>  				wait_for_completion = true;
> -- 
> 2.26.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

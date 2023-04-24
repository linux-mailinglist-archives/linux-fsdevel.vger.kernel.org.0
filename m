Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC946EC614
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 08:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjDXGSi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 02:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjDXGS2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 02:18:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342D22132;
        Sun, 23 Apr 2023 23:18:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C355A611C1;
        Mon, 24 Apr 2023 06:18:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E9EC433D2;
        Mon, 24 Apr 2023 06:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682317106;
        bh=yrOHoQW3uvuLL/IhB326kZ2OBDh3o24byU0KV1vIAfs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UT/Dbssa7FMu87YCTTzaTmgLkwn75ydoQ5e1ln1O+ABDNIqGOzM3jqE84LcFRLXtQ
         8PuuiokVVXrvBeYIF8iLRJehcsneFbeO541NlPuyK4WYdzoxYQNo4Ct81C2GCviI+E
         79/CFqU6DUXRwrF75TfpgUzUqpnzqkrSmaHscnDlFYff2Q092otoUICLTqHPcjNycW
         C7ARkCXD0SS6fhBsNHyLWVZjmfBZdVWOaqI2B3r1Z1l+wSYSI5vYVpmU08euCPzUsC
         TVc0sjLEGEsQXHIvBCt48O7duOfV2QNgFrxe001cpPfOwYHak5QZkXJngosDVkNNLc
         yFrTv1XJj1gDg==
Date:   Sun, 23 Apr 2023 23:18:25 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/17] iomap: assign current->backing_dev_info in
 iomap_file_buffered_write
Message-ID: <20230424061825.GO360889@frogsfrogsfrogs>
References: <20230424054926.26927-1-hch@lst.de>
 <20230424054926.26927-12-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424054926.26927-12-hch@lst.de>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 24, 2023 at 07:49:20AM +0200, Christoph Hellwig wrote:
> Move the assignment to current->backing_dev_info from the callers into
> iomap_file_buffered_write.  Note that zonefs was missing this assignment
> before.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/gfs2/file.c         | 3 ---
>  fs/iomap/buffered-io.c | 4 ++++
>  fs/xfs/xfs_file.c      | 5 -----
>  3 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
> index 8c4fad359ff538..4d88c6080b3e30 100644
> --- a/fs/gfs2/file.c
> +++ b/fs/gfs2/file.c
> @@ -25,7 +25,6 @@
>  #include <linux/dlm.h>
>  #include <linux/dlm_plock.h>
>  #include <linux/delay.h>
> -#include <linux/backing-dev.h>
>  #include <linux/fileattr.h>
>  
>  #include "gfs2.h"
> @@ -1041,11 +1040,9 @@ static ssize_t gfs2_file_buffered_write(struct kiocb *iocb,
>  			goto out_unlock;
>  	}
>  
> -	current->backing_dev_info = inode_to_bdi(inode);
>  	pagefault_disable();
>  	ret = iomap_file_buffered_write(iocb, from, &gfs2_iomap_ops);
>  	pagefault_enable();
> -	current->backing_dev_info = NULL;
>  	if (ret > 0) {
>  		iocb->ki_pos += ret;
>  		written += ret;
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 2986be63d2bea6..3d5042efda202a 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -3,6 +3,7 @@
>   * Copyright (C) 2010 Red Hat, Inc.
>   * Copyright (C) 2016-2019 Christoph Hellwig.
>   */
> +#include <linux/backing-dev.h>
>  #include <linux/module.h>
>  #include <linux/compiler.h>
>  #include <linux/fs.h>
> @@ -876,8 +877,11 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
>  	if (iocb->ki_flags & IOCB_NOWAIT)
>  		iter.flags |= IOMAP_NOWAIT;
>  
> +	current->backing_dev_info = inode_to_bdi(iter.inode);

Dumb question from me late on a Sunday night, but does the iomap_unshare
code need to set this too?  Since it works by dirtying pagecache folios
without actually changing the contents?

--D

>  	while ((ret = iomap_iter(&iter, ops)) > 0)
>  		iter.processed = iomap_write_iter(&iter, i);
> +	current->backing_dev_info = NULL;
> +
>  	if (iter.pos == iocb->ki_pos)
>  		return ret;
>  	return iter.pos - iocb->ki_pos;
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 705250f9f90a1b..f5442e689baf15 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -27,7 +27,6 @@
>  
>  #include <linux/dax.h>
>  #include <linux/falloc.h>
> -#include <linux/backing-dev.h>
>  #include <linux/mman.h>
>  #include <linux/fadvise.h>
>  #include <linux/mount.h>
> @@ -717,9 +716,6 @@ xfs_file_buffered_write(
>  	if (ret)
>  		goto out;
>  
> -	/* We can write back this queue in page reclaim */
> -	current->backing_dev_info = inode_to_bdi(inode);
> -
>  	trace_xfs_file_buffered_write(iocb, from);
>  	ret = iomap_file_buffered_write(iocb, from,
>  			&xfs_buffered_write_iomap_ops);
> @@ -753,7 +749,6 @@ xfs_file_buffered_write(
>  		goto write_retry;
>  	}
>  
> -	current->backing_dev_info = NULL;
>  out:
>  	if (iolock)
>  		xfs_iunlock(ip, iolock);
> -- 
> 2.39.2
> 

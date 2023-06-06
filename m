Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039967233EA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 02:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjFFAES (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 20:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjFFAER (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 20:04:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B69F9;
        Mon,  5 Jun 2023 17:04:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA1BC62915;
        Tue,  6 Jun 2023 00:04:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1C3C433D2;
        Tue,  6 Jun 2023 00:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686009855;
        bh=xPqDBnA9crfcda+QJHDEogmu65T/ezefUhM18Debbm0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ddPmBSXSMvlY9x94xIIznZYGaNuipQq3VI72KC0oXDBKaGeDQjKtRJmfrsGmehWvO
         +dPcgrPTfGtR6It+kcXJltBdEm6/kbNCqegUMdcjJLpThWScaZHuyrI92e+KxL5eSE
         6UYfqRlb93ixurnxyFXwOAH/gstR61UDyavP5IbH3jiHC6gYnE66jfhBxNASdfvKoO
         3g91Y67k3IwVIP5kIbGlNmjoUpg38PKL0tJCWBDOdkxq0zpo0hU4ztLFtuUy69XDvZ
         pgOw60wCPj40tpC46Ad5a91ebl7gCGcJ/iJcwmK8v80Pnvc61AL6XuQN4t+34IdDjQ
         mC0Xvp8bW0hvA==
Date:   Mon, 5 Jun 2023 17:04:14 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [PATCH 09/12] fs: factor out a direct_write_fallback helper
Message-ID: <20230606000414.GJ1325469@frogsfrogsfrogs>
References: <20230601145904.1385409-1-hch@lst.de>
 <20230601145904.1385409-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601145904.1385409-10-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 01, 2023 at 04:59:01PM +0200, Christoph Hellwig wrote:
> Add a helper dealing with handling the syncing of a buffered write fallback
> for direct I/O.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>

Looks good to me; whose tree do you want this to go through?

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/libfs.c         | 41 ++++++++++++++++++++++++++++
>  include/linux/fs.h |  2 ++
>  mm/filemap.c       | 66 +++++++++++-----------------------------------
>  3 files changed, 58 insertions(+), 51 deletions(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 89cf614a327158..5b851315eeed03 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -1613,3 +1613,44 @@ u64 inode_query_iversion(struct inode *inode)
>  	return cur >> I_VERSION_QUERIED_SHIFT;
>  }
>  EXPORT_SYMBOL(inode_query_iversion);
> +
> +ssize_t direct_write_fallback(struct kiocb *iocb, struct iov_iter *iter,
> +		ssize_t direct_written, ssize_t buffered_written)
> +{
> +	struct address_space *mapping = iocb->ki_filp->f_mapping;
> +	loff_t pos = iocb->ki_pos - buffered_written;
> +	loff_t end = iocb->ki_pos - 1;
> +	int err;
> +
> +	/*
> +	 * If the buffered write fallback returned an error, we want to return
> +	 * the number of bytes which were written by direct I/O, or the error
> +	 * code if that was zero.
> +	 *
> +	 * Note that this differs from normal direct-io semantics, which will
> +	 * return -EFOO even if some bytes were written.
> +	 */
> +	if (unlikely(buffered_written < 0)) {
> +		if (direct_written)
> +			return direct_written;
> +		return buffered_written;
> +	}
> +
> +	/*
> +	 * We need to ensure that the page cache pages are written to disk and
> +	 * invalidated to preserve the expected O_DIRECT semantics.
> +	 */
> +	err = filemap_write_and_wait_range(mapping, pos, end);
> +	if (err < 0) {
> +		/*
> +		 * We don't know how much we wrote, so just return the number of
> +		 * bytes which were direct-written
> +		 */
> +		if (direct_written)
> +			return direct_written;
> +		return err;
> +	}
> +	invalidate_mapping_pages(mapping, pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
> +	return direct_written + buffered_written;
> +}
> +EXPORT_SYMBOL_GPL(direct_write_fallback);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 91021b4e1f6f48..6af25137543824 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2738,6 +2738,8 @@ extern ssize_t __generic_file_write_iter(struct kiocb *, struct iov_iter *);
>  extern ssize_t generic_file_write_iter(struct kiocb *, struct iov_iter *);
>  extern ssize_t generic_file_direct_write(struct kiocb *, struct iov_iter *);
>  ssize_t generic_perform_write(struct kiocb *, struct iov_iter *);
> +ssize_t direct_write_fallback(struct kiocb *iocb, struct iov_iter *iter,
> +		ssize_t direct_written, ssize_t buffered_written);
>  
>  ssize_t vfs_iter_read(struct file *file, struct iov_iter *iter, loff_t *ppos,
>  		rwf_t flags);
> diff --git a/mm/filemap.c b/mm/filemap.c
> index ddb6f8aa86d6ca..137508da5525b6 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -4006,23 +4006,19 @@ ssize_t __generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  {
>  	struct file *file = iocb->ki_filp;
>  	struct address_space *mapping = file->f_mapping;
> -	struct inode 	*inode = mapping->host;
> -	ssize_t		written = 0;
> -	ssize_t		err;
> -	ssize_t		status;
> +	struct inode *inode = mapping->host;
> +	ssize_t ret;
>  
> -	err = file_remove_privs(file);
> -	if (err)
> -		goto out;
> +	ret = file_remove_privs(file);
> +	if (ret)
> +		return ret;
>  
> -	err = file_update_time(file);
> -	if (err)
> -		goto out;
> +	ret = file_update_time(file);
> +	if (ret)
> +		return ret;
>  
>  	if (iocb->ki_flags & IOCB_DIRECT) {
> -		loff_t pos, endbyte;
> -
> -		written = generic_file_direct_write(iocb, from);
> +		ret = generic_file_direct_write(iocb, from);
>  		/*
>  		 * If the write stopped short of completing, fall back to
>  		 * buffered writes.  Some filesystems do this for writes to
> @@ -4030,45 +4026,13 @@ ssize_t __generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  		 * not succeed (even if it did, DAX does not handle dirty
>  		 * page-cache pages correctly).
>  		 */
> -		if (written < 0 || !iov_iter_count(from) || IS_DAX(inode))
> -			goto out;
> -
> -		pos = iocb->ki_pos;
> -		status = generic_perform_write(iocb, from);
> -		/*
> -		 * If generic_perform_write() returned a synchronous error
> -		 * then we want to return the number of bytes which were
> -		 * direct-written, or the error code if that was zero.  Note
> -		 * that this differs from normal direct-io semantics, which
> -		 * will return -EFOO even if some bytes were written.
> -		 */
> -		if (unlikely(status < 0)) {
> -			err = status;
> -			goto out;
> -		}
> -		/*
> -		 * We need to ensure that the page cache pages are written to
> -		 * disk and invalidated to preserve the expected O_DIRECT
> -		 * semantics.
> -		 */
> -		endbyte = pos + status - 1;
> -		err = filemap_write_and_wait_range(mapping, pos, endbyte);
> -		if (err == 0) {
> -			written += status;
> -			invalidate_mapping_pages(mapping,
> -						 pos >> PAGE_SHIFT,
> -						 endbyte >> PAGE_SHIFT);
> -		} else {
> -			/*
> -			 * We don't know how much we wrote, so just return
> -			 * the number of bytes which were direct-written
> -			 */
> -		}
> -	} else {
> -		written = generic_perform_write(iocb, from);
> +		if (ret < 0 || !iov_iter_count(from) || IS_DAX(inode))
> +			return ret;
> +		return direct_write_fallback(iocb, from, ret,
> +				generic_perform_write(iocb, from));
>  	}
> -out:
> -	return written ? written : err;
> +
> +	return generic_perform_write(iocb, from);
>  }
>  EXPORT_SYMBOL(__generic_file_write_iter);
>  
> -- 
> 2.39.2
> 

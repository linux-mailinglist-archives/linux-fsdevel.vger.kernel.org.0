Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87306EEE9D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Apr 2023 08:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239603AbjDZGyF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Apr 2023 02:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239309AbjDZGyD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Apr 2023 02:54:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808E42693;
        Tue, 25 Apr 2023 23:53:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F6BB62963;
        Wed, 26 Apr 2023 06:53:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 219EDC433D2;
        Wed, 26 Apr 2023 06:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682492032;
        bh=QIhBfq3ajoFrTFgvdAxQ5iAO7C3Q5qspZKjzhdSkFDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G8fiQSngd2qR//FFL6mNV7TiZ0hHExG3DHtksT8WRTQ2IEiiKvj+87IE8fz1JCSPk
         90pfbu1IicetwgG1l3aeiX9kJjBtMjGh1LXIqVpFrDM8aGqCoY8i1gBQU6gX3U32v+
         p8ukg9m7oelvw396eLvBAvui7OT7Mp5GBk02ebdaHLPQa1L2e6mP0pm64b5PO6XIoq
         V1sYIBnXBSv7l646PNYYrpOpUAZfrlZXdPcBZNiy4dv+J3MjQi1Kz6ThTJ456rw0SM
         GF6+JDokL6O9FnKDuLQi0zOhbeOeaFwXbZEICIku8KX9fFBatJSDz5eLozlDnJNEft
         CpWXdnfqp2WkA==
Date:   Wed, 26 Apr 2023 08:53:45 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 1/3] fs: add infrastructure for multigrain inode
 i_m/ctime
Message-ID: <20230426-meerblick-tortur-c6606f6126fa@brauner>
References: <20230424151104.175456-1-jlayton@kernel.org>
 <20230424151104.175456-2-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230424151104.175456-2-jlayton@kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 24, 2023 at 11:11:02AM -0400, Jeff Layton wrote:
> The VFS always uses coarse-grained timestamp updates for filling out the
> ctime and mtime after a change. This has the benefit of allowing
> filesystems to optimize away a lot metaupdates, to around once per
> jiffy, even when a file is under heavy writes.
> 
> Unfortunately, this has always been an issue when we're exporting via
> NFSv3, which relies on timestamps to validate caches. Even with NFSv4, a
> lot of exported filesystems don't properly support a change attribute
> and are subject to the same problems with timestamp granularity. Other
> applications have similar issues (e.g backup applications).
> 
> Switching to always using fine-grained timestamps would improve the
> situation for NFS, but that becomes rather expensive, as the underlying
> filesystem will have to log a lot more metadata updates.
> 
> What we need is a way to only use fine-grained timestamps when they are
> being actively queried:
> 
> Whenever the mtime changes, the ctime must also change since we're
> changing the metadata. When a superblock has a s_time_gran >1, we can
> use the lowest-order bit of the inode->i_ctime as a flag to indicate
> that the value has been queried. Then on the next write, we'll fetch a
> fine-grained timestamp instead of the usual coarse-grained one.
> 
> We could enable this for any filesystem that has a s_time_gran >1, but
> for now, this patch adds a new SB_MULTIGRAIN_TS flag to allow filesystems
> to opt-in to this behavior.
> 
> It then adds a new current_ctime function that acts like the
> current_time helper, but will conditionally grab fine-grained timestamps
> when the flag is set in the current ctime. Also, there is a new
> generic_fill_multigrain_cmtime for grabbing the c/mtime out of the inode
> and atomically marking the ctime as queried.
> 
> Later patches will convert filesystems over to this new scheme.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/inode.c         | 57 +++++++++++++++++++++++++++++++++++++++---
>  fs/stat.c          | 24 ++++++++++++++++++
>  include/linux/fs.h | 62 ++++++++++++++++++++++++++++++++--------------
>  3 files changed, 121 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 4558dc2f1355..4bd11bdb46d4 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2030,6 +2030,7 @@ EXPORT_SYMBOL(file_remove_privs);
>  static int inode_needs_update_time(struct inode *inode, struct timespec64 *now)
>  {
>  	int sync_it = 0;
> +	struct timespec64 ctime = inode->i_ctime;
>  
>  	/* First try to exhaust all avenues to not sync */
>  	if (IS_NOCMTIME(inode))
> @@ -2038,7 +2039,9 @@ static int inode_needs_update_time(struct inode *inode, struct timespec64 *now)
>  	if (!timespec64_equal(&inode->i_mtime, now))
>  		sync_it = S_MTIME;
>  
> -	if (!timespec64_equal(&inode->i_ctime, now))
> +	if (is_multigrain_ts(inode))
> +		ctime.tv_nsec &= ~I_CTIME_QUERIED;
> +	if (!timespec64_equal(&ctime, now))
>  		sync_it |= S_CTIME;
>  
>  	if (IS_I_VERSION(inode) && inode_iversion_need_inc(inode))
> @@ -2062,6 +2065,50 @@ static int __file_update_time(struct file *file, struct timespec64 *now,
>  	return ret;
>  }
>  
> +/**
> + * current_ctime - Return FS time (possibly high-res)
> + * @inode: inode.
> + *
> + * Return the current time truncated to the time granularity supported by
> + * the fs, as suitable for a ctime/mtime change.
> + *
> + * For a multigrain timestamp, if the timestamp is flagged as having been
> + * QUERIED, then get a fine-grained timestamp.
> + */
> +struct timespec64 current_ctime(struct inode *inode)
> +{
> +	struct timespec64 now;
> +	long nsec = 0;
> +	bool multigrain = is_multigrain_ts(inode);
> +
> +	if (multigrain) {
> +		atomic_long_t *pnsec = (atomic_long_t *)&inode->i_ctime.tv_nsec;
> +
> +		nsec = atomic_long_fetch_and(~I_CTIME_QUERIED, pnsec);
> +	}
> +
> +	if (nsec & I_CTIME_QUERIED) {
> +		ktime_get_real_ts64(&now);
> +	} else {
> +		ktime_get_coarse_real_ts64(&now);
> +
> +		if (multigrain) {
> +			/*
> +			 * If we've recently fetched a fine-grained timestamp
> +			 * then the coarse-grained one may be earlier than the
> +			 * existing one. Just keep the existing ctime if so.
> +			 */
> +			struct timespec64 ctime = inode->i_ctime;
> +
> +			if (timespec64_compare(&ctime, &now) > 0)
> +				now = ctime;
> +		}
> +	}
> +
> +	return timestamp_truncate(now, inode);
> +}
> +EXPORT_SYMBOL(current_ctime);
> +
>  /**
>   * file_update_time - update mtime and ctime time
>   * @file: file accessed
> @@ -2080,7 +2127,7 @@ int file_update_time(struct file *file)
>  {
>  	int ret;
>  	struct inode *inode = file_inode(file);
> -	struct timespec64 now = current_time(inode);
> +	struct timespec64 now = current_ctime(inode);
>  
>  	ret = inode_needs_update_time(inode, &now);
>  	if (ret <= 0)
> @@ -2109,7 +2156,7 @@ static int file_modified_flags(struct file *file, int flags)
>  {
>  	int ret;
>  	struct inode *inode = file_inode(file);
> -	struct timespec64 now = current_time(inode);
> +	struct timespec64 now = current_ctime(inode);
>  
>  	/*
>  	 * Clear the security bits if the process is not being run by root.
> @@ -2419,9 +2466,11 @@ struct timespec64 timestamp_truncate(struct timespec64 t, struct inode *inode)
>  	if (unlikely(t.tv_sec == sb->s_time_max || t.tv_sec == sb->s_time_min))
>  		t.tv_nsec = 0;
>  
> -	/* Avoid division in the common cases 1 ns and 1 s. */
> +	/* Avoid division in the common cases 1 ns, 2 ns and 1 s. */
>  	if (gran == 1)
>  		; /* nothing */
> +	else if (gran == 2)
> +		t.tv_nsec &= ~1L;

Is that trying to mask off I_CTIME_QUERIED?
If so, can we please use that constant as raw constants tend to be
confusing in the long run.

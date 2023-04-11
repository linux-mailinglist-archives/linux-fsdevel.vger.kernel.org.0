Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9AC6DDEF3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 17:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjDKPHn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 11:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjDKPHi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:07:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7925278;
        Tue, 11 Apr 2023 08:07:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81D7B6282F;
        Tue, 11 Apr 2023 15:07:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C16C433EF;
        Tue, 11 Apr 2023 15:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681225638;
        bh=sZyOp9FyHjFY8Ijg56XZndRZkaDLI3AILJspX6fqzyE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=faSha008mhaP7F6Mb6PjpHGM8UWH6bJuVHhtAaUybY1IhSeqSDKwk3Xkl01Hf6wgq
         vtHVzTLvioS4dReDgA0w8F21rX3+s+KfJiPan+Y1ABiR/KYdfaX60GwQyd3DZ0RrfN
         nH45POKQrFDpdS7deCs4xmnqrYnS9fHzvJ3jpJYcbNbI6OseG4pUlgskvhFBzCldTv
         UwgyDWlC8onNuaXfWQ2Nv3MPknICoLOtVUM1iDWWzX7oy/Zp3zm6C3CyyLF5gsOVAE
         nocFI4Ul9FXxGMGoh/4r4BOHNnGMzGIIDqYgPmzigBwpxoiOjCBVb8eDfe6dJ7wlTN
         wbMzsf3CBFGZA==
Date:   Tue, 11 Apr 2023 17:07:12 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH 1/3][RESEND] fs: add infrastructure for opportunistic
 high-res ctime/mtime updates
Message-ID: <20230411-unwesen-prunk-cb7de3cc6cc8@brauner>
References: <20230411143702.64495-1-jlayton@kernel.org>
 <20230411143702.64495-2-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230411143702.64495-2-jlayton@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 11, 2023 at 10:37:00AM -0400, Jeff Layton wrote:
> The VFS always uses coarse-grained timestamp updates for filling out the
> ctime and mtime after a change. This has the benefit of allowing
> filesystems to optimize away metadata updates.
> 
> Unfortunately, this has always been an issue when we're exporting via
> NFSv3, which relies on timestamps to validate caches. Even with NFSv4, a
> lot of exported filesystems don't properly support a change attribute
> and are subject to the same problem of timestamp granularity. Other
> applications have similar issues (e.g backup applications).
> 
> Switching to always using high resolution timestamps would improve the
> situation for NFS, but that becomes rather expensive, as we'd have to
> log a lot more metadata updates.
> 
> This patch grabs a new i_state bit to use as a flag that filesystems can
> set in their getattr routine to indicate that the mtime or ctime was
> queried since it was last updated.
> 
> It then adds a new current_cmtime function that acts like the
> current_time helper, but will conditionally grab high-res timestamps
> when the i_state flag is set in the inode.
> 
> This allows NFS and other applications to reap the benefits of high-res
> ctime and mtime timestamps, but at a substantially lower cost than
> fetching them every time.
> 
> Cc: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/inode.c         | 40 ++++++++++++++++++++++++++++++++++++++--
>  fs/stat.c          | 10 ++++++++++
>  include/linux/fs.h |  5 ++++-
>  3 files changed, 52 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 4558dc2f1355..3630f67fd042 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2062,6 +2062,42 @@ static int __file_update_time(struct file *file, struct timespec64 *now,
>  	return ret;
>  }
>  
> +/**
> + * current_cmtime - Return FS time (possibly high-res)
> + * @inode: inode.
> + *
> + * Return the current time truncated to the time granularity supported by
> + * the fs, as suitable for a ctime or mtime change. If something recently
> + * fetched the ctime or mtime out of the inode via getattr, then get a
> + * high-resolution timestamp.
> + *
> + * Note that inode and inode->sb cannot be NULL.
> + * Otherwise, the function warns and returns coarse time without truncation.
> + */
> +struct timespec64 current_cmtime(struct inode *inode)
> +{
> +	struct timespec64 now;
> +
> +	if (unlikely(!inode->i_sb)) {
> +		WARN(1, "%s() called with uninitialized super_block in the inode", __func__);

How would this happen? Seems weird to even bother checking this.

> +		ktime_get_coarse_real_ts64(&now);
> +		return now;
> +	}
> +
> +	/* Do a lockless check for the flag before taking the spinlock */
> +	if (READ_ONCE(inode->i_state) & I_CMTIME_QUERIED) {
> +		ktime_get_real_ts64(&now);
> +		spin_lock(&inode->i_lock);
> +		inode->i_state &= ~I_CMTIME_QUERIED;
> +		spin_unlock(&inode->i_lock);
> +	} else {
> +		ktime_get_coarse_real_ts64(&now);
> +	}
> +
> +	return timestamp_truncate(now, inode);
> +}
> +EXPORT_SYMBOL(current_cmtime);
> +
>  /**
>   * file_update_time - update mtime and ctime time
>   * @file: file accessed
> @@ -2080,7 +2116,7 @@ int file_update_time(struct file *file)
>  {
>  	int ret;
>  	struct inode *inode = file_inode(file);
> -	struct timespec64 now = current_time(inode);
> +	struct timespec64 now = current_cmtime(inode);
>  
>  	ret = inode_needs_update_time(inode, &now);
>  	if (ret <= 0)
> @@ -2109,7 +2145,7 @@ static int file_modified_flags(struct file *file, int flags)
>  {
>  	int ret;
>  	struct inode *inode = file_inode(file);
> -	struct timespec64 now = current_time(inode);
> +	struct timespec64 now = current_cmtime(inode);
>  
>  	/*
>  	 * Clear the security bits if the process is not being run by root.
> diff --git a/fs/stat.c b/fs/stat.c
> index 7c238da22ef0..d8b80a2e36b7 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -64,6 +64,16 @@ void generic_fillattr(struct mnt_idmap *idmap, struct inode *inode,
>  }
>  EXPORT_SYMBOL(generic_fillattr);
>  
> +void fill_cmtime_and_mark(struct inode *inode, struct kstat *stat)
> +{
> +	spin_lock(&inode->i_lock);
> +	inode->i_state |= I_CMTIME_QUERIED;
> +	stat->ctime = inode->i_ctime;
> +	stat->mtime = inode->i_mtime;
> +	spin_unlock(&inode->i_lock);
> +}
> +EXPORT_SYMBOL(fill_cmtime_and_mark);

So that means that each stat call would mark an inode for a
high-resolution update. There's some performance concerns here. Calling
stat() is super common and it would potentially make the next iop more
expensive. Recursively changing ownership in the container use-case come
to mind which are already expensive.

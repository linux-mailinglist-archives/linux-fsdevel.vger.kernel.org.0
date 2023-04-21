Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2406EA802
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 12:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjDUKNk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 06:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjDUKNg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 06:13:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62438AF04;
        Fri, 21 Apr 2023 03:13:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 15F091FDDC;
        Fri, 21 Apr 2023 10:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682072012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r6wWKx5dDKFmTIcIYNBq1MQUPmJkbAp8f/jd3WbQHMU=;
        b=Z24b84qaXsafYxTU01etW0C6yQx+jEUWbuL2ZTAaKXxwRestqLVw4E0xENQSwVPoR09DNQ
        FaNYM9anVh/Y9fXugiohOGxxhkbQ1viU53UJayzTRsmmfqNFHUjxumkbW9Zo+J1GjStVUg
        2GWyv3jHPVOsKnj7NTSlArB4EvZiDsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682072012;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r6wWKx5dDKFmTIcIYNBq1MQUPmJkbAp8f/jd3WbQHMU=;
        b=wluaBxVfb+rzQ3wrkA8IStKDPvQj84jb9cZ3zM0az/l+GWLEuYDNm0m9jBpORjgAGMABU4
        fsTWTgo6EqaZzFCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F37A51390E;
        Fri, 21 Apr 2023 10:13:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 83RPO8thQmS1ZwAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 21 Apr 2023 10:13:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7EE2EA0729; Fri, 21 Apr 2023 12:13:31 +0200 (CEST)
Date:   Fri, 21 Apr 2023 12:13:31 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [RFC PATCH 1/3] fs: add infrastructure for opportunistic
 high-res ctime/mtime updates
Message-ID: <20230421101331.dlxom6b5e7yds5tn@quack3>
References: <20230411142708.62475-1-jlayton@kernel.org>
 <20230411142708.62475-2-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411142708.62475-2-jlayton@kernel.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 11-04-23 10:27:06, Jeff Layton wrote:
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

I don't think we can have inodes without a superblock. Did you ever hit
this?

> +		WARN(1, "%s() called with uninitialized super_block in the inode", __func__);
> +		ktime_get_coarse_real_ts64(&now);
> +		return now;
> +	}
> +
> +	/* Do a lockless check for the flag before taking the spinlock */
> +	if (READ_ONCE(inode->i_state) & I_CMTIME_QUERIED) {
> +		ktime_get_real_ts64(&now);
> +		spin_lock(&inode->i_lock);
> +		inode->i_state &= ~I_CMTIME_QUERIED;

Isn't this a bit fragile? If someone does:

	inode->i_mtime = current_cmtime(inode);
	inode->i_ctime = current_cmtime(inode);

the ctime update will be coarse although it should be fine-grained.

> +		spin_unlock(&inode->i_lock);
> +	} else {
> +		ktime_get_coarse_real_ts64(&now);
> +	}
> +
> +	return timestamp_truncate(now, inode);

I'm a bit confused here. Isn't the point of this series also to give NFS
finer grained granularity time stamps than what the filesystem is possibly
able to store on disk?

Hmm, checking XFS it sets 1 ns granularity (as well as tmpfs) so for these
using the coarser timers indeed gives a performance benefit. And probably
you've decided not implement the "better NFS support with coarse grained
timestamps" yet.

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

The name could be better here :). Maybe stat_fill_cmtime_and_mark()?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

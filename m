Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8C467B6D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 17:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235978AbjAYQVw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 11:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235986AbjAYQVg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 11:21:36 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258DB5A815;
        Wed, 25 Jan 2023 08:21:10 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3E64F1F854;
        Wed, 25 Jan 2023 16:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674663640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HKEnDl7csQ+0+t/iqHglTAc7cEfTIinKAWBsLL25EQw=;
        b=Ud2BsBuClrkdEaqETuF2PE7m3P/lFQfFf0x8jnUGEGmx+lZAVH4mCNi30yEOeORtwOfgHM
        6nn/h7nzj1liEYUjCRBXlhR9EY+rhhKBZRiG2WxN4N+qMjIZxee1ZQfw3O0pCWPvk77TWF
        xJ7xkEfiD0h4dHd14mys/wWBhCtgfSQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674663640;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HKEnDl7csQ+0+t/iqHglTAc7cEfTIinKAWBsLL25EQw=;
        b=9R8LTQinysPeXO1GBb3wDtLBeYizazt1WwrpH1yGLtYHTLA4AFWiTvOG97w9cQBZZNvQke
        8yon8PzSNCAzneCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 24E601358F;
        Wed, 25 Jan 2023 16:20:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Xkv/CNhW0WPRCwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 25 Jan 2023 16:20:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 96E1FA06B4; Wed, 25 Jan 2023 17:20:39 +0100 (CET)
Date:   Wed, 25 Jan 2023 17:20:39 +0100
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com, neilb@suse.de,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, brauner@kernel.org, fweimer@redhat.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH v8 RESEND 3/8] vfs: plumb i_version handling into struct
 kstat
Message-ID: <20230125162039.wquoqycq35t2skqj@quack3>
References: <20230124193025.185781-1-jlayton@kernel.org>
 <20230124193025.185781-4-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124193025.185781-4-jlayton@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 24-01-23 14:30:20, Jeff Layton wrote:
> The NFS server has a lot of special handling for different types of
> change attribute access, depending on the underlying filesystem. In
> most cases, it's doing a getattr anyway and then fetching that value
> after the fact.
> 
> Rather that do that, add a new STATX_CHANGE_COOKIE flag that is a
> kernel-only symbol (for now). If requested and getattr can implement it,
> it can fill out this field. For IS_I_VERSION inodes, add a generic
> implementation in vfs_getattr_nosec. Take care to mask
> STATX_CHANGE_COOKIE off in requests from userland and in the result
> mask.
> 
> Since not all filesystems can give the same guarantees of monotonicity,
> claim a STATX_ATTR_CHANGE_MONOTONIC flag that filesystems can set to
> indicate that they offer an i_version value that can never go backward.
> 
> Eventually if we decide to make the i_version available to userland, we
> can just designate a field for it in struct statx, and move the
> STATX_CHANGE_COOKIE definition to the uapi header.
> 
> Reviewed-by: NeilBrown <neilb@suse.de>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/stat.c            | 17 +++++++++++++++--
>  include/linux/stat.h |  9 +++++++++
>  2 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/stat.c b/fs/stat.c
> index d6cc74ca8486..f43afe0081fe 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -18,6 +18,7 @@
>  #include <linux/syscalls.h>
>  #include <linux/pagemap.h>
>  #include <linux/compat.h>
> +#include <linux/iversion.h>
>  
>  #include <linux/uaccess.h>
>  #include <asm/unistd.h>
> @@ -122,6 +123,11 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
>  	stat->attributes_mask |= (STATX_ATTR_AUTOMOUNT |
>  				  STATX_ATTR_DAX);
>  
> +	if ((request_mask & STATX_CHANGE_COOKIE) && IS_I_VERSION(inode)) {
> +		stat->result_mask |= STATX_CHANGE_COOKIE;
> +		stat->change_cookie = inode_query_iversion(inode);
> +	}
> +
>  	mnt_userns = mnt_user_ns(path->mnt);
>  	if (inode->i_op->getattr)
>  		return inode->i_op->getattr(mnt_userns, path, stat,
> @@ -602,9 +608,11 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
>  
>  	memset(&tmp, 0, sizeof(tmp));
>  
> -	tmp.stx_mask = stat->result_mask;
> +	/* STATX_CHANGE_COOKIE is kernel-only for now */
> +	tmp.stx_mask = stat->result_mask & ~STATX_CHANGE_COOKIE;
>  	tmp.stx_blksize = stat->blksize;
> -	tmp.stx_attributes = stat->attributes;
> +	/* STATX_ATTR_CHANGE_MONOTONIC is kernel-only for now */
> +	tmp.stx_attributes = stat->attributes & ~STATX_ATTR_CHANGE_MONOTONIC;
>  	tmp.stx_nlink = stat->nlink;
>  	tmp.stx_uid = from_kuid_munged(current_user_ns(), stat->uid);
>  	tmp.stx_gid = from_kgid_munged(current_user_ns(), stat->gid);
> @@ -643,6 +651,11 @@ int do_statx(int dfd, struct filename *filename, unsigned int flags,
>  	if ((flags & AT_STATX_SYNC_TYPE) == AT_STATX_SYNC_TYPE)
>  		return -EINVAL;
>  
> +	/* STATX_CHANGE_COOKIE is kernel-only for now. Ignore requests
> +	 * from userland.
> +	 */
> +	mask &= ~STATX_CHANGE_COOKIE;
> +
>  	error = vfs_statx(dfd, filename, flags, &stat, mask);
>  	if (error)
>  		return error;
> diff --git a/include/linux/stat.h b/include/linux/stat.h
> index ff277ced50e9..52150570d37a 100644
> --- a/include/linux/stat.h
> +++ b/include/linux/stat.h
> @@ -52,6 +52,15 @@ struct kstat {
>  	u64		mnt_id;
>  	u32		dio_mem_align;
>  	u32		dio_offset_align;
> +	u64		change_cookie;
>  };
>  
> +/* These definitions are internal to the kernel for now. Mainly used by nfsd. */
> +
> +/* mask values */
> +#define STATX_CHANGE_COOKIE		0x40000000U	/* Want/got stx_change_attr */
> +
> +/* file attribute values */
> +#define STATX_ATTR_CHANGE_MONOTONIC	0x8000000000000000ULL /* version monotonically increases */
> +
>  #endif
> -- 
> 2.39.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

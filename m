Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D447976D7E2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 21:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbjHBTfp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 15:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjHBTfo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 15:35:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7DD1722;
        Wed,  2 Aug 2023 12:35:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F0BF521987;
        Wed,  2 Aug 2023 19:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691004938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ulKixWFBkBTfBdkO5sWa5tXT2YgU4XInJIq1ozkKtSE=;
        b=DjXaxen1sq4kpGaMppGd1N+JIfTj9HOAcpPUY3nYVP6c1CS55I9aJrwdGLjtWwdAY1FOVu
        7h9B+PeJlt4RS68pUEsCVe9Le2uYGr345UEUjKDUXQvhWd8g6usWCdakZ8iOJDW3qlAY37
        rkvVSdD3pOdwBn/7bHM0H5P30JGfplw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691004938;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ulKixWFBkBTfBdkO5sWa5tXT2YgU4XInJIq1ozkKtSE=;
        b=aLkA0QTXkbYEVOnW7vJtVSlFeMZVV3Zl7kxy3ZHa/T3CZ09+i6wqB3pIRRGJUI7M9eWJaT
        fViuNZXYQtVvYWCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CEE4C13919;
        Wed,  2 Aug 2023 19:35:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2hh0MgmwymRGHgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 02 Aug 2023 19:35:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 41D93A076B; Wed,  2 Aug 2023 21:35:37 +0200 (CEST)
Date:   Wed, 2 Aug 2023 21:35:37 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        Tyler Hicks <code@tyhicks.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Jan Kara <jack@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Richard Weinberger <richard@nod.at>,
        Hans de Goede <hdegoede@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Anthony Iliopoulos <ailiop@suse.com>, v9fs@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-nfs@vger.kernel.org,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        devel@lists.orangefs.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-mtd@lists.infradead.org,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v6 2/7] fs: add infrastructure for multigrain timestamps
Message-ID: <20230802193537.vtuuwuwazocjbatv@quack3>
References: <20230725-mgctime-v6-0-a794c2b7abca@kernel.org>
 <20230725-mgctime-v6-2-a794c2b7abca@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725-mgctime-v6-2-a794c2b7abca@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 25-07-23 10:58:15, Jeff Layton wrote:
> The VFS always uses coarse-grained timestamps when updating the ctime
> and mtime after a change. This has the benefit of allowing filesystems
> to optimize away a lot metadata updates, down to around 1 per jiffy,
> even when a file is under heavy writes.
> 
> Unfortunately, this has always been an issue when we're exporting via
> NFSv3, which relies on timestamps to validate caches. A lot of changes
> can happen in a jiffy, so timestamps aren't sufficient to help the
> client decide to invalidate the cache. Even with NFSv4, a lot of
> exported filesystems don't properly support a change attribute and are
> subject to the same problems with timestamp granularity. Other
> applications have similar issues with timestamps (e.g backup
> applications).
> 
> If we were to always use fine-grained timestamps, that would improve the
> situation, but that becomes rather expensive, as the underlying
> filesystem would have to log a lot more metadata updates.
> 
> What we need is a way to only use fine-grained timestamps when they are
> being actively queried.
> 
> POSIX generally mandates that when the the mtime changes, the ctime must
> also change. The kernel always stores normalized ctime values, so only
> the first 30 bits of the tv_nsec field are ever used.
> 
> Use the 31st bit of the ctime tv_nsec field to indicate that something
> has queried the inode for the mtime or ctime. When this flag is set,
> on the next mtime or ctime update, the kernel will fetch a fine-grained
> timestamp instead of the usual coarse-grained one.
> 
> Filesytems can opt into this behavior by setting the FS_MGTIME flag in
> the fstype. Filesystems that don't set this flag will continue to use
> coarse-grained timestamps.
> 
> Later patches will convert individual filesystems to use the new
> infrastructure.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/inode.c         | 98 ++++++++++++++++++++++++++++++++++++++----------------
>  fs/stat.c          | 41 +++++++++++++++++++++--
>  include/linux/fs.h | 45 +++++++++++++++++++++++--
>  3 files changed, 151 insertions(+), 33 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index d4ab92233062..369621e7faf5 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1919,6 +1919,21 @@ int inode_update_time(struct inode *inode, struct timespec64 *time, int flags)
>  }
>  EXPORT_SYMBOL(inode_update_time);
>  
> +/**
> + * current_coarse_time - Return FS time
> + * @inode: inode.
> + *
> + * Return the current coarse-grained time truncated to the time
> + * granularity supported by the fs.
> + */
> +static struct timespec64 current_coarse_time(struct inode *inode)
> +{
> +	struct timespec64 now;
> +
> +	ktime_get_coarse_real_ts64(&now);
> +	return timestamp_truncate(now, inode);
> +}
> +
>  /**
>   *	atime_needs_update	-	update the access time
>   *	@path: the &struct path to update
> @@ -1952,7 +1967,7 @@ bool atime_needs_update(const struct path *path, struct inode *inode)
>  	if ((mnt->mnt_flags & MNT_NODIRATIME) && S_ISDIR(inode->i_mode))
>  		return false;
>  
> -	now = current_time(inode);
> +	now = current_coarse_time(inode);
>  
>  	if (!relatime_need_update(mnt, inode, now))
>  		return false;
> @@ -1986,7 +2001,7 @@ void touch_atime(const struct path *path)
>  	 * We may also fail on filesystems that have the ability to make parts
>  	 * of the fs read only, e.g. subvolumes in Btrfs.
>  	 */
> -	now = current_time(inode);
> +	now = current_coarse_time(inode);
>  	inode_update_time(inode, &now, S_ATIME);
>  	__mnt_drop_write(mnt);
>  skip_update:

There are also calls in fs/smb/client/file.c:cifs_readpage_worker() and in
fs/ocfs2/file.c:ocfs2_update_inode_atime() that should probably use
current_coarse_time() to avoid needless querying of fine grained
timestamps. But see below...

> @@ -2072,6 +2087,56 @@ int file_remove_privs(struct file *file)
>  }
>  EXPORT_SYMBOL(file_remove_privs);
>  
> +/**
> + * current_mgtime - Return FS time (possibly fine-grained)
> + * @inode: inode.
> + *
> + * Return the current time truncated to the time granularity supported by
> + * the fs, as suitable for a ctime/mtime change. If the ctime is flagged
> + * as having been QUERIED, get a fine-grained timestamp.
> + */
> +static struct timespec64 current_mgtime(struct inode *inode)
> +{
> +	struct timespec64 now;
> +	atomic_long_t *pnsec = (atomic_long_t *)&inode->__i_ctime.tv_nsec;
> +	long nsec = atomic_long_read(pnsec);
> +
> +	if (nsec & I_CTIME_QUERIED) {
> +		ktime_get_real_ts64(&now);
> +	} else {
> +		struct timespec64 ctime;
> +
> +		ktime_get_coarse_real_ts64(&now);
> +
> +		/*
> +		 * If we've recently fetched a fine-grained timestamp
> +		 * then the coarse-grained one may still be earlier than the
> +		 * existing one. Just keep the existing ctime if so.
> +		 */
> +		ctime = inode_get_ctime(inode);
> +		if (timespec64_compare(&ctime, &now) > 0)
> +			now = ctime;
> +	}
> +
> +	return timestamp_truncate(now, inode);
> +}
> +
> +/**
> + * current_time - Return timestamp suitable for ctime update
> + * @inode: inode to eventually be updated
> + *
> + * Return the current time, which is usually coarse-grained but may be fine
> + * grained if the filesystem uses multigrain timestamps and the existing
> + * ctime was queried since the last update.
> + */
> +struct timespec64 current_time(struct inode *inode)
> +{
> +	if (is_mgtime(inode))
> +		return current_mgtime(inode);
> +	return current_coarse_time(inode);
> +}
> +EXPORT_SYMBOL(current_time);
> +

So if you modify current_time() to handle multigrain timestamps the code
will be still racy. In particular fill_mg_cmtime() can race with
inode_set_ctime_current() like:

fill_mg_cmtime()				inode_set_ctime_current()
  stat->mtime = inode->i_mtime;
  stat->ctime.tv_sec = inode->__i_ctime.tv_sec;
						  now = current_time();
							/* fetches coarse
							 * grained timestamp */
  stat->ctime.tv_nsec = atomic_long_fetch_or(I_CTIME_QUERIED, pnsec) &
				~I_CTIME_QUERIED;
						  inode_set_ctime(inode, now.tv_sec, now.tv_nsec);

and the information about a need for finegrained timestamp update gets
lost. So what I'd propose is to leave current_time() alone (just always
reporting coarse grained timestamps) and put all the magic into
inode_set_ctime_current() only. There we need something like:

struct timespec64 inode_set_ctime_current(struct inode *inode)
{
	... variables ...

	nsec = READ_ONCE(inode->__i_ctime.tv_nsec);
 	if (!(nsec & I_CTIME_QUERIED)) {
		now = current_time(inode);

		if (!is_gmtime(inode)) {
			inode_set_ctime_to_ts(inode, now);
		} else {
			/*
			 * If we've recently fetched a fine-grained
			 * timestamp then the coarse-grained one may still
			 * be earlier than the existing one. Just keep the
			 * existing ctime if so.
			 */
			ctime = inode_get_ctime(inode);
			if (timespec64_compare(&ctime, &now) > 0)
				now = ctime;

			/*
			 * Ctime updates are generally protected by inode
			 * lock but we could have raced with setting of
			 * I_CTIME_QUERIED flag.
			 */
			if (cmpxchg(&inode->__i_ctime.tv_nsec, nsec,
				    now.tv_nsec) != nsec)
				goto fine_grained;
			inode->__i_ctime.tv_sec = now.tv_sec;
		}
		return now;
	}
fine_grained:
	ktime_get_real_ts64(&now);
	inode_set_ctime_to_ts(inode, now);

	return now;
}

								Honza

>  static int inode_needs_update_time(struct inode *inode, struct timespec64 *now)
>  {
>  	int sync_it = 0;
> @@ -2480,37 +2545,12 @@ struct timespec64 timestamp_truncate(struct timespec64 t, struct inode *inode)
>  }
>  EXPORT_SYMBOL(timestamp_truncate);
>  
> -/**
> - * current_time - Return FS time
> - * @inode: inode.
> - *
> - * Return the current time truncated to the time granularity supported by
> - * the fs.
> - *
> - * Note that inode and inode->sb cannot be NULL.
> - * Otherwise, the function warns and returns time without truncation.
> - */
> -struct timespec64 current_time(struct inode *inode)
> -{
> -	struct timespec64 now;
> -
> -	ktime_get_coarse_real_ts64(&now);
> -
> -	if (unlikely(!inode->i_sb)) {
> -		WARN(1, "current_time() called with uninitialized super_block in the inode");
> -		return now;
> -	}
> -
> -	return timestamp_truncate(now, inode);
> -}
> -EXPORT_SYMBOL(current_time);
> -
>  /**
>   * inode_set_ctime_current - set the ctime to current_time
>   * @inode: inode
>   *
> - * Set the inode->i_ctime to the current value for the inode. Returns
> - * the current value that was assigned to i_ctime.
> + * Set the inode->__i_ctime to the current value for the inode. Returns
> + * the current value that was assigned to __i_ctime.
>   */
>  struct timespec64 inode_set_ctime_current(struct inode *inode)
>  {
> diff --git a/fs/stat.c b/fs/stat.c
> index 062f311b5386..51effd1c2bc2 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -26,6 +26,37 @@
>  #include "internal.h"
>  #include "mount.h"
>  
> +/**
> + * fill_mg_cmtime - Fill in the mtime and ctime and flag ctime as QUERIED
> + * @request_mask: STATX_* values requested
> + * @inode: inode from which to grab the c/mtime
> + * @stat: where to store the resulting values
> + *
> + * Given @inode, grab the ctime and mtime out if it and store the result
> + * in @stat. When fetching the value, flag it as queried so the next write
> + * will use a fine-grained timestamp.
> + */
> +void fill_mg_cmtime(u32 request_mask, struct inode *inode, struct kstat *stat)
> +{
> +	atomic_long_t *pnsec = (atomic_long_t *)&inode->__i_ctime.tv_nsec;
> +
> +	/* If neither time was requested, then don't report them */
> +	if (!(request_mask & (STATX_CTIME|STATX_MTIME))) {
> +		stat->result_mask &= ~(STATX_CTIME|STATX_MTIME);
> +		return;
> +	}
> +
> +	stat->mtime = inode->i_mtime;
> +	stat->ctime.tv_sec = inode->__i_ctime.tv_sec;
> +	/*
> +	 * Atomically set the QUERIED flag and fetch the new value with
> +	 * the flag masked off.
> +	 */
> +	stat->ctime.tv_nsec = atomic_long_fetch_or(I_CTIME_QUERIED, pnsec) &
> +					~I_CTIME_QUERIED;
> +}
> +EXPORT_SYMBOL(fill_mg_cmtime);
> +
>  /**
>   * generic_fillattr - Fill in the basic attributes from the inode struct
>   * @idmap:	idmap of the mount the inode was found from
> @@ -58,8 +89,14 @@ void generic_fillattr(struct mnt_idmap *idmap, u32 request_mask,
>  	stat->rdev = inode->i_rdev;
>  	stat->size = i_size_read(inode);
>  	stat->atime = inode->i_atime;
> -	stat->mtime = inode->i_mtime;
> -	stat->ctime = inode_get_ctime(inode);
> +
> +	if (is_mgtime(inode)) {
> +		fill_mg_cmtime(request_mask, inode, stat);
> +	} else {
> +		stat->mtime = inode->i_mtime;
> +		stat->ctime = inode_get_ctime(inode);
> +	}
> +
>  	stat->blksize = i_blocksize(inode);
>  	stat->blocks = inode->i_blocks;
>  
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 42d1434cc427..a0bdbefbf293 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1477,15 +1477,43 @@ static inline bool fsuidgid_has_mapping(struct super_block *sb,
>  struct timespec64 current_time(struct inode *inode);
>  struct timespec64 inode_set_ctime_current(struct inode *inode);
>  
> +/*
> + * Multigrain timestamps
> + *
> + * Conditionally use fine-grained ctime and mtime timestamps when there
> + * are users actively observing them via getattr. The primary use-case
> + * for this is NFS clients that use the ctime to distinguish between
> + * different states of the file, and that are often fooled by multiple
> + * operations that occur in the same coarse-grained timer tick.
> + *
> + * The kernel always keeps normalized struct timespec64 values in the ctime,
> + * which means that only the first 30 bits of the value are used. Use the
> + * 31st bit of the ctime's tv_nsec field as a flag to indicate that the value
> + * has been queried since it was last updated.
> + */
> +#define I_CTIME_QUERIED		(1L<<30)
> +
>  /**
>   * inode_get_ctime - fetch the current ctime from the inode
>   * @inode: inode from which to fetch ctime
>   *
> - * Grab the current ctime from the inode and return it.
> + * Grab the current ctime tv_nsec field from the inode, mask off the
> + * I_CTIME_QUERIED flag and return it. This is mostly intended for use by
> + * internal consumers of the ctime that aren't concerned with ensuring a
> + * fine-grained update on the next change (e.g. when preparing to store
> + * the value in the backing store for later retrieval).
> + *
> + * This is safe to call regardless of whether the underlying filesystem
> + * is using multigrain timestamps.
>   */
>  static inline struct timespec64 inode_get_ctime(const struct inode *inode)
>  {
> -	return inode->__i_ctime;
> +	struct timespec64 ctime;
> +
> +	ctime.tv_sec = inode->__i_ctime.tv_sec;
> +	ctime.tv_nsec = inode->__i_ctime.tv_nsec & ~I_CTIME_QUERIED;
> +
> +	return ctime;
>  }
>  
>  /**
> @@ -2261,6 +2289,7 @@ struct file_system_type {
>  #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
>  #define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
>  #define FS_ALLOW_IDMAP         32      /* FS has been updated to handle vfs idmappings. */
> +#define FS_MGTIME		64	/* FS uses multigrain timestamps */
>  #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
>  	int (*init_fs_context)(struct fs_context *);
>  	const struct fs_parameter_spec *parameters;
> @@ -2284,6 +2313,17 @@ struct file_system_type {
>  
>  #define MODULE_ALIAS_FS(NAME) MODULE_ALIAS("fs-" NAME)
>  
> +/**
> + * is_mgtime: is this inode using multigrain timestamps
> + * @inode: inode to test for multigrain timestamps
> + *
> + * Return true if the inode uses multigrain timestamps, false otherwise.
> + */
> +static inline bool is_mgtime(const struct inode *inode)
> +{
> +	return inode->i_sb->s_type->fs_flags & FS_MGTIME;
> +}
> +
>  extern struct dentry *mount_bdev(struct file_system_type *fs_type,
>  	int flags, const char *dev_name, void *data,
>  	int (*fill_super)(struct super_block *, void *, int));
> @@ -2919,6 +2959,7 @@ extern void page_put_link(void *);
>  extern int page_symlink(struct inode *inode, const char *symname, int len);
>  extern const struct inode_operations page_symlink_inode_operations;
>  extern void kfree_link(void *);
> +void fill_mg_cmtime(u32 request_mask, struct inode *inode, struct kstat *stat);
>  void generic_fillattr(struct mnt_idmap *, u32, struct inode *, struct kstat *);
>  void generic_fill_statx_attr(struct inode *inode, struct kstat *stat);
>  extern int vfs_getattr_nosec(const struct path *, struct kstat *, u32, unsigned int);
> 
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8716F6E7A64
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 15:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbjDSNOr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 09:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbjDSNOq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 09:14:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3F859D5;
        Wed, 19 Apr 2023 06:14:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B07891FD8B;
        Wed, 19 Apr 2023 13:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681910082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QtjhfqmMCpw6lHRWz0N8Ga5N5qteeYp8BzWdG3/wNBM=;
        b=IsIokdc5ULeAPE8ib9rNiO+9ZHOZJgAVKbyq1zPdwlLkX4DjARLib0vtTMY0z18ktl68cg
        yy39h91cCrNh/MeUtIUhINFdjD0YlfH6ScGZIkfUKsiZkUZOFn4TjPhBqnnEi9rvnBJUv9
        7sUNjzRWK504CENLkteMSJHA61mKIdY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681910082;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QtjhfqmMCpw6lHRWz0N8Ga5N5qteeYp8BzWdG3/wNBM=;
        b=GLP0i43LdEW5Ngw+vZdo7k0c0uqHYYl7YlJyf9YaXhiaKpTT/AJB9Q/HJwEr0EGlbagVTE
        diVVTNz75papKDDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E1391390E;
        Wed, 19 Apr 2023 13:14:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wRmYJkLpP2RRIwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 19 Apr 2023 13:14:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D64E6A0722; Wed, 19 Apr 2023 15:14:41 +0200 (CEST)
Date:   Wed, 19 Apr 2023 15:14:41 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [RFC][PATCH 1/2] fanotify: add support for FAN_UNMOUNT event
Message-ID: <20230419131441.rox6m2k5354j22ss@quack3>
References: <20230414182903.1852019-1-amir73il@gmail.com>
 <20230414182903.1852019-2-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414182903.1852019-2-amir73il@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 14-04-23 21:29:02, Amir Goldstein wrote:
> inotify generates unsolicited IN_UNMOUNT events for every inode
> mark before the filesystem containing the inode is shutdown.
> 
> Unlike IN_UNMOUNT, FAN_UNMOUNT is an opt-in event that can only be
> set on a mount mark and is generated when the mount is unmounted.
> 
> FAN_UNMOUNT requires FAN_REPORT_FID and reports an fid info record
> with fsid of the filesystem and an empty file handle.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Seeing the discussion further in this thread regarding FAN_IGNORED won't
it be more consistent (extensible) to implement the above functionality as
FAN_IGNORED delivered to mount mark when it is getting destroyed?

I.e., define FAN_IGNORED as an event that gets delivered when a mark is
getting destroyed (with the records identifying the mark). For now start
supporting it on mount marks, later we can add support to other mark types
if there's demand. Thoughts?

								Honza

> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 90d9210dc0d2..384d2b2e55e7 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -713,7 +713,7 @@ static struct fanotify_event *fanotify_alloc_error_event(
>  	inode = report->inode;
>  	fh_len = fanotify_encode_fh_len(inode);
>  
> -	/* Bad fh_len. Fallback to using an invalid fh. Should never happen. */
> +	/* Record empty fh for errors not associated with specific inode */
>  	if (!fh_len && inode)
>  		inode = NULL;
>  
> @@ -745,7 +745,10 @@ static struct fanotify_event *fanotify_alloc_event(
>  	bool ondir = mask & FAN_ONDIR;
>  	struct pid *pid;
>  
> -	if ((fid_mode & FAN_REPORT_DIR_FID) && dirid) {
> +	if (mask & FAN_UNMOUNT && !WARN_ON_ONCE(!path || !fid_mode)) {
> +		/* Record fid event with fsid and empty fh */
> +		id = NULL;
> +	} else if ((fid_mode & FAN_REPORT_DIR_FID) && dirid) {
>  		/*
>  		 * For certain events and group flags, report the child fid
>  		 * in addition to reporting the parent fid and maybe child name.
> @@ -951,10 +954,11 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
>  	BUILD_BUG_ON(FAN_ONDIR != FS_ISDIR);
>  	BUILD_BUG_ON(FAN_OPEN_EXEC != FS_OPEN_EXEC);
>  	BUILD_BUG_ON(FAN_OPEN_EXEC_PERM != FS_OPEN_EXEC_PERM);
> +	BUILD_BUG_ON(FAN_UNMOUNT != FS_UNMOUNT);
>  	BUILD_BUG_ON(FAN_FS_ERROR != FS_ERROR);
>  	BUILD_BUG_ON(FAN_RENAME != FS_RENAME);
>  
> -	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 21);
> +	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 22);
>  
>  	mask = fanotify_group_event_mask(group, iter_info, &match_mask,
>  					 mask, data, data_type, dir);
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index 7f0bf00a90f0..f98dcf5b7a19 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -382,10 +382,12 @@ static inline int fanotify_event_dir2_fh_len(struct fanotify_event *event)
>  	return info ? fanotify_info_dir2_fh_len(info) : 0;
>  }
>  
> +/* For error and unmount events, fsid with empty fh are reported. */
> +#define FANOTIFY_EMPTY_FH_EVENTS (FAN_FS_ERROR | FAN_UNMOUNT)
> +
>  static inline bool fanotify_event_has_object_fh(struct fanotify_event *event)
>  {
> -	/* For error events, even zeroed fh are reported. */
> -	if (event->type == FANOTIFY_EVENT_TYPE_FS_ERROR)
> +	if (event->mask & FANOTIFY_EMPTY_FH_EVENTS)
>  		return true;
>  	return fanotify_event_object_fh_len(event) > 0;
>  }
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 554b335b1733..0b3de6218c56 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1766,6 +1766,16 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  	    (!fid_mode || mark_type == FAN_MARK_MOUNT))
>  		goto fput_and_out;
>  
> +	/*
> +	 * inotify sends unsoliciled IN_UNMOUNT per marked inode on sb shutdown.
> +	 * FAN_UNMOUNT event is about unmount of a mount, not about sb shutdown,
> +	 * so allow setting it only in mount mark mask.
> +	 * FAN_UNMOUNT requires FAN_REPORT_FID to report fsid with empty fh.
> +	 */
> +	if (mask & FAN_UNMOUNT &&
> +	    (!(fid_mode & FAN_REPORT_FID) || mark_type != FAN_MARK_MOUNT))
> +		goto fput_and_out;
> +
>  	/*
>  	 * FAN_RENAME uses special info type records to report the old and
>  	 * new parent+name.  Reporting only old and new parent id is less
> diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> index 4c6f40a701c2..a64c26d9626f 100644
> --- a/include/linux/fanotify.h
> +++ b/include/linux/fanotify.h
> @@ -80,7 +80,8 @@
>   * FSNOTIFY_EVENT_INODE.
>   */
>  #define FANOTIFY_PATH_EVENTS	(FAN_ACCESS | FAN_MODIFY | \
> -				 FAN_CLOSE | FAN_OPEN | FAN_OPEN_EXEC)
> +				 FAN_CLOSE | FAN_OPEN | FAN_OPEN_EXEC | \
> +				 FAN_UNMOUNT)
>  
>  /*
>   * Directory entry modification events - reported only to directory
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index bb8467cd11ae..3898bf858407 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -176,11 +176,27 @@ static inline void fsnotify_inode_delete(struct inode *inode)
>  	__fsnotify_inode_delete(inode);
>  }
>  
> +/*
> + * fsnotify_unmount - mount was unmounted.
> + */
> +static inline int fsnotify_unmount(struct vfsmount *mnt)
> +{
> +	struct path path = { .mnt = mnt, .dentry = mnt->mnt_root };
> +
> +	if (atomic_long_read(&mnt->mnt_sb->s_fsnotify_connectors) == 0)
> +		return 0;
> +
> +	return fsnotify(FS_UNMOUNT, &path, FSNOTIFY_EVENT_PATH, NULL, NULL,
> +			d_inode(path.dentry), 0);
> +}
> +
>  /*
>   * fsnotify_vfsmount_delete - a vfsmount is being destroyed, clean up is needed
>   */
>  static inline void fsnotify_vfsmount_delete(struct vfsmount *mnt)
>  {
> +	/* Send FS_UNMOUNT to groups and then clear mount marks */
> +	fsnotify_unmount(mnt);
>  	__fsnotify_vfsmount_delete(mnt);
>  }
>  
> diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
> index 014e9682bd76..70f2d43e8ba4 100644
> --- a/include/uapi/linux/fanotify.h
> +++ b/include/uapi/linux/fanotify.h
> @@ -19,6 +19,7 @@
>  #define FAN_MOVE_SELF		0x00000800	/* Self was moved */
>  #define FAN_OPEN_EXEC		0x00001000	/* File was opened for exec */
>  
> +#define FAN_UNMOUNT		0x00002000	/* Filesystem unmounted */
>  #define FAN_Q_OVERFLOW		0x00004000	/* Event queued overflowed */
>  #define FAN_FS_ERROR		0x00008000	/* Filesystem error */
>  
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

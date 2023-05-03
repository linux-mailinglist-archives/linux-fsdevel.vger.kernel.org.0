Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8754A6F5D03
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 19:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjECRXV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 13:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjECRXU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 13:23:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AAFCF;
        Wed,  3 May 2023 10:23:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D719E22A5C;
        Wed,  3 May 2023 17:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683134596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cv+elkPAiL0b6M6X4eQlejQvMyx1+5dv0hzsbr3+9TM=;
        b=MlgMW4tvVsQvcAo+shbio7jBTif5IhTW0QlfnP5U1nj/RSYKW+ouwrPVbnSdIgzoOOpZpd
        btTCsYBKF1CsJjUYxLyMScP4+hbYPBrK+kExA4SOZE8PfaKAKnGhO7/fVjcYvYOmFJ1Wvx
        711ZhJLVihIGluy9M63xTIMVPFmPGas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683134596;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cv+elkPAiL0b6M6X4eQlejQvMyx1+5dv0hzsbr3+9TM=;
        b=05ae4LPwCgmpiXLOXGry/DPZhFPAs4Tdq44z7A9LHk53ByR5nxuq6hthy2Jdg9fOCy5LmQ
        Qb69+RUDyWba+SDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA6F51331F;
        Wed,  3 May 2023 17:23:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VHZ3LYSYUmT3IQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 03 May 2023 17:23:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B79EDA0744; Wed,  3 May 2023 19:23:14 +0200 (CEST)
Date:   Wed, 3 May 2023 19:23:14 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-api@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH v2 3/4] exportfs: allow exporting non-decodeable file
 handles to userspace
Message-ID: <20230503172314.kptbcaluwd6xiamz@quack3>
References: <20230502124817.3070545-1-amir73il@gmail.com>
 <20230502124817.3070545-4-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502124817.3070545-4-amir73il@gmail.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 02-05-23 15:48:16, Amir Goldstein wrote:
> Some userspace programs use st_ino as a unique object identifier, even
> though inode numbers may be recycable.
> 
> This issue has been addressed for NFS export long ago using the exportfs
> file handle API and the unique file handle identifiers are also exported
> to userspace via name_to_handle_at(2).
> 
> fanotify also uses file handles to identify objects in events, but only
> for filesystems that support NFS export.
> 
> Relax the requirement for NFS export support and allow more filesystems
> to export a unique object identifier via name_to_handle_at(2) with the
> flag AT_HANDLE_FID.
> 
> A file handle requested with the AT_HANDLE_FID flag, may or may not be
> usable as an argument to open_by_handle_at(2).
> 
> To allow filesystems to opt-in to supporting AT_HANDLE_FID, a struct
> export_operations is required, but even an empty struct is sufficient
> for encoding FIDs.

Christian (or Al), are you OK with sparing one AT_ flag for this
functionality? Otherwise the patch series looks fine to me so I'd like to
queue it into my tree. Thanks!

								Honza

> 
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/fhandle.c               | 22 ++++++++++++++--------
>  include/uapi/linux/fcntl.h |  5 +++++
>  2 files changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/fhandle.c b/fs/fhandle.c
> index f2bc27d1975e..4a635cf787fc 100644
> --- a/fs/fhandle.c
> +++ b/fs/fhandle.c
> @@ -16,7 +16,7 @@
>  
>  static long do_sys_name_to_handle(const struct path *path,
>  				  struct file_handle __user *ufh,
> -				  int __user *mnt_id)
> +				  int __user *mnt_id, int fh_flags)
>  {
>  	long retval;
>  	struct file_handle f_handle;
> @@ -24,11 +24,14 @@ static long do_sys_name_to_handle(const struct path *path,
>  	struct file_handle *handle = NULL;
>  
>  	/*
> -	 * We need to make sure whether the file system
> -	 * support decoding of the file handle
> +	 * We need to make sure whether the file system support decoding of
> +	 * the file handle if decodeable file handle was requested.
> +	 * Otherwise, even empty export_operations are sufficient to opt-in
> +	 * to encoding FIDs.
>  	 */
>  	if (!path->dentry->d_sb->s_export_op ||
> -	    !path->dentry->d_sb->s_export_op->fh_to_dentry)
> +	    (!(fh_flags & EXPORT_FH_FID) &&
> +	     !path->dentry->d_sb->s_export_op->fh_to_dentry))
>  		return -EOPNOTSUPP;
>  
>  	if (copy_from_user(&f_handle, ufh, sizeof(struct file_handle)))
> @@ -45,10 +48,10 @@ static long do_sys_name_to_handle(const struct path *path,
>  	/* convert handle size to multiple of sizeof(u32) */
>  	handle_dwords = f_handle.handle_bytes >> 2;
>  
> -	/* we ask for a non connected handle */
> +	/* we ask for a non connectable maybe decodeable file handle */
>  	retval = exportfs_encode_fh(path->dentry,
>  				    (struct fid *)handle->f_handle,
> -				    &handle_dwords,  0);
> +				    &handle_dwords, fh_flags);
>  	handle->handle_type = retval;
>  	/* convert handle size to bytes */
>  	handle_bytes = handle_dwords * sizeof(u32);
> @@ -84,6 +87,7 @@ static long do_sys_name_to_handle(const struct path *path,
>   * @handle: resulting file handle
>   * @mnt_id: mount id of the file system containing the file
>   * @flag: flag value to indicate whether to follow symlink or not
> + *        and whether a decodable file handle is required.
>   *
>   * @handle->handle_size indicate the space available to store the
>   * variable part of the file handle in bytes. If there is not
> @@ -96,17 +100,19 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const char __user *, name,
>  {
>  	struct path path;
>  	int lookup_flags;
> +	int fh_flags;
>  	int err;
>  
> -	if ((flag & ~(AT_SYMLINK_FOLLOW | AT_EMPTY_PATH)) != 0)
> +	if (flag & ~(AT_SYMLINK_FOLLOW | AT_EMPTY_PATH | AT_HANDLE_FID))
>  		return -EINVAL;
>  
>  	lookup_flags = (flag & AT_SYMLINK_FOLLOW) ? LOOKUP_FOLLOW : 0;
> +	fh_flags = (flag & AT_HANDLE_FID) ? EXPORT_FH_FID : 0;
>  	if (flag & AT_EMPTY_PATH)
>  		lookup_flags |= LOOKUP_EMPTY;
>  	err = user_path_at(dfd, name, lookup_flags, &path);
>  	if (!err) {
> -		err = do_sys_name_to_handle(&path, handle, mnt_id);
> +		err = do_sys_name_to_handle(&path, handle, mnt_id, fh_flags);
>  		path_put(&path);
>  	}
>  	return err;
> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> index e8c07da58c9f..3091080db069 100644
> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> @@ -112,4 +112,9 @@
>  
>  #define AT_RECURSIVE		0x8000	/* Apply to the entire subtree */
>  
> +/* Flags for name_to_handle_at(2) */
> +#define AT_HANDLE_FID		0x10000	/* file handle is needed to compare
> +					   object indentity and may not be
> +					   usable to open_by_handle_at(2) */
> +
>  #endif /* _UAPI_LINUX_FCNTL_H */
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

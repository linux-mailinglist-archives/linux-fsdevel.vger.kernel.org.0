Return-Path: <linux-fsdevel+bounces-758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2A97CFC66
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 16:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6F1AB21340
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 14:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD4F29D0D;
	Thu, 19 Oct 2023 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vVR3nSdq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="w3uMPTFc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF692744F
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 14:23:37 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C29119;
	Thu, 19 Oct 2023 07:23:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7843F21A48;
	Thu, 19 Oct 2023 14:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1697725414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vHVKbvz5KKhBcLpNoYotjBcpsCJS93EZbgmfvvObLpI=;
	b=vVR3nSdqgJ+JeDlDXdQb2sJdrOxl0PMAGBBcfbKJYJP95A+RRojpl5FujNvF8mPk5jlmRu
	To8Iy8c0Zoy6ojJl241PwO+B0C+i7HjJzvbFI5TgAiqCTryRZNQQprR2anFxH/FIU+Uf5Z
	Lxg5CtP777N5jo/UgHPZg1SfOPxVsFo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1697725414;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vHVKbvz5KKhBcLpNoYotjBcpsCJS93EZbgmfvvObLpI=;
	b=w3uMPTFcTPrXfpqnkdeLtmNuaJ6ylNuS0rD/fQPpp+6RJ57WUfSyCRloZ1x0UxPyxp1ak+
	35PMnX5kf/WgiHDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B84B139C2;
	Thu, 19 Oct 2023 14:23:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id QO47GuY7MWXRfQAAMHmgww
	(envelope-from <jack@suse.cz>); Thu, 19 Oct 2023 14:23:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EEBFBA06B0; Thu, 19 Oct 2023 16:23:33 +0200 (CEST)
Date: Thu, 19 Oct 2023 16:23:33 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/5] exportfs: add helpers to check if filesystem can
 encode/decode file handles
Message-ID: <20231019142333.tuao3phsvqqgfqix@quack3>
References: <20231018100000.2453965-1-amir73il@gmail.com>
 <20231018100000.2453965-3-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018100000.2453965-3-amir73il@gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -6.60
X-Spamd-Result: default: False [-6.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Wed 18-10-23 12:59:57, Amir Goldstein wrote:
> The logic of whether filesystem can encode/decode file handles is open
> coded in many places.
> 
> In preparation to changing the logic, move the open coded logic into
> inline helpers.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Yeah, good cleanup. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/exportfs/expfs.c                |  8 ++------
>  fs/fhandle.c                       |  6 +-----
>  fs/nfsd/export.c                   |  3 +--
>  fs/notify/fanotify/fanotify_user.c |  4 ++--
>  fs/overlayfs/util.c                |  2 +-
>  include/linux/exportfs.h           | 27 +++++++++++++++++++++++++++
>  6 files changed, 34 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
> index c20704aa21b3..9ee205df8fa7 100644
> --- a/fs/exportfs/expfs.c
> +++ b/fs/exportfs/expfs.c
> @@ -396,11 +396,7 @@ int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
>  {
>  	const struct export_operations *nop = inode->i_sb->s_export_op;
>  
> -	/*
> -	 * If a decodeable file handle was requested, we need to make sure that
> -	 * filesystem can decode file handles.
> -	 */
> -	if (nop && !(flags & EXPORT_FH_FID) && !nop->fh_to_dentry)
> +	if (!exportfs_can_encode_fh(nop, flags))
>  		return -EOPNOTSUPP;
>  
>  	if (nop && nop->encode_fh)
> @@ -456,7 +452,7 @@ exportfs_decode_fh_raw(struct vfsmount *mnt, struct fid *fid, int fh_len,
>  	/*
>  	 * Try to get any dentry for the given file handle from the filesystem.
>  	 */
> -	if (!nop || !nop->fh_to_dentry)
> +	if (!exportfs_can_decode_fh(nop))
>  		return ERR_PTR(-ESTALE);
>  	result = nop->fh_to_dentry(mnt->mnt_sb, fid, fh_len, fileid_type);
>  	if (IS_ERR_OR_NULL(result))
> diff --git a/fs/fhandle.c b/fs/fhandle.c
> index 6ea8d35a9382..18b3ba8dc8ea 100644
> --- a/fs/fhandle.c
> +++ b/fs/fhandle.c
> @@ -26,12 +26,8 @@ static long do_sys_name_to_handle(const struct path *path,
>  	/*
>  	 * We need to make sure whether the file system support decoding of
>  	 * the file handle if decodeable file handle was requested.
> -	 * Otherwise, even empty export_operations are sufficient to opt-in
> -	 * to encoding FIDs.
>  	 */
> -	if (!path->dentry->d_sb->s_export_op ||
> -	    (!(fh_flags & EXPORT_FH_FID) &&
> -	     !path->dentry->d_sb->s_export_op->fh_to_dentry))
> +	if (!exportfs_can_encode_fh(path->dentry->d_sb->s_export_op, fh_flags))
>  		return -EOPNOTSUPP;
>  
>  	if (copy_from_user(&f_handle, ufh, sizeof(struct file_handle)))
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index 11a0eaa2f914..dc99dfc1d411 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -421,8 +421,7 @@ static int check_export(struct path *path, int *flags, unsigned char *uuid)
>  		return -EINVAL;
>  	}
>  
> -	if (!inode->i_sb->s_export_op ||
> -	    !inode->i_sb->s_export_op->fh_to_dentry) {
> +	if (!exportfs_can_decode_fh(inode->i_sb->s_export_op)) {
>  		dprintk("exp_export: export of invalid fs type.\n");
>  		return -EINVAL;
>  	}
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 537c70beaad0..ce926eb9feea 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1595,7 +1595,7 @@ static int fanotify_test_fid(struct dentry *dentry, unsigned int flags)
>  	 * file handles so user can use name_to_handle_at() to compare fids
>  	 * reported with events to the file handle of watched objects.
>  	 */
> -	if (!nop)
> +	if (!exportfs_can_encode_fid(nop))
>  		return -EOPNOTSUPP;
>  
>  	/*
> @@ -1603,7 +1603,7 @@ static int fanotify_test_fid(struct dentry *dentry, unsigned int flags)
>  	 * supports decoding file handles, so user has a way to map back the
>  	 * reported fids to filesystem objects.
>  	 */
> -	if (mark_type != FAN_MARK_INODE && !nop->fh_to_dentry)
> +	if (mark_type != FAN_MARK_INODE && !exportfs_can_decode_fh(nop))
>  		return -EOPNOTSUPP;
>  
>  	return 0;
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index 89e0d60d35b6..f0a712214ec2 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -55,7 +55,7 @@ int ovl_can_decode_fh(struct super_block *sb)
>  	if (!capable(CAP_DAC_READ_SEARCH))
>  		return 0;
>  
> -	if (!sb->s_export_op || !sb->s_export_op->fh_to_dentry)
> +	if (!exportfs_can_decode_fh(sb->s_export_op))
>  		return 0;
>  
>  	return sb->s_export_op->encode_fh ? -1 : FILEID_INO32_GEN;
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index 11fbd0ee1370..5b3c9f30b422 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -233,6 +233,33 @@ extern int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
>  extern int exportfs_encode_fh(struct dentry *dentry, struct fid *fid,
>  			      int *max_len, int flags);
>  
> +static inline bool exportfs_can_encode_fid(const struct export_operations *nop)
> +{
> +	return nop;
> +}
> +
> +static inline bool exportfs_can_decode_fh(const struct export_operations *nop)
> +{
> +	return nop && nop->fh_to_dentry;
> +}
> +
> +static inline bool exportfs_can_encode_fh(const struct export_operations *nop,
> +					  int fh_flags)
> +{
> +	/*
> +	 * If a non-decodeable file handle was requested, we only need to make
> +	 * sure that filesystem can encode file handles.
> +	 */
> +	if (fh_flags & EXPORT_FH_FID)
> +		return exportfs_can_encode_fid(nop);
> +
> +	/*
> +	 * If a decodeable file handle was requested, we need to make sure that
> +	 * filesystem can also decode file handles.
> +	 */
> +	return exportfs_can_decode_fh(nop);
> +}
> +
>  static inline int exportfs_encode_fid(struct inode *inode, struct fid *fid,
>  				      int *max_len)
>  {
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


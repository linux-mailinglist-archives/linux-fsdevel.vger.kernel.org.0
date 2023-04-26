Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAA76EF62C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Apr 2023 16:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241292AbjDZOSM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Apr 2023 10:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjDZOSL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Apr 2023 10:18:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC7E6E8F;
        Wed, 26 Apr 2023 07:18:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04B4E60E8B;
        Wed, 26 Apr 2023 14:18:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB981C433EF;
        Wed, 26 Apr 2023 14:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682518685;
        bh=bfT+Azg5dNxOCEllC6Lkb6Uvbr+IGHIAOiPSM9/cKGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eUDqcHfaXBdQuqHJIqVCPdlshtmutIKB46VhGoMKFGXLuiaCtDPXNvAqIgFsC73MG
         nkn6qclIrxtFvwhO/4w+3o3/KakD2mQsh4FPGAqEbBd4Nzib2fLy+amcv3NHV+3pfP
         1Qslbk5Wj6af+hDAre6PLel+J1mNsH/o2jnhcdHmLhRYn0fOWxGbBpekaRx5X88Vfe
         B1I3elkUQCypnjxsPET4gkHebG4CbKF9lRxYGd/sSbU7xu8oRfU11P78DVXHMdzeNC
         /nJA2wmQozpu+0+QJTxCiyddOpo0s8oTxjEIRW7MtrFruyF/LDXMLx2p0+JMNegH0/
         GyVIHEI80m1LQ==
Date:   Wed, 26 Apr 2023 10:18:02 -0400
From:   Chuck Lever <cel@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-nfs@vger.kernel.org,
        jlayton@kernel.org
Subject: Re: [RFC][PATCH 2/4] exportfs: add explicit flag to request
 non-decodeable file handles
Message-ID: <ZEkymuGnFT/Rbo2k@manet.1015granger.net>
References: <20230425130105.2606684-1-amir73il@gmail.com>
 <20230425130105.2606684-3-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425130105.2606684-3-amir73il@gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 25, 2023 at 04:01:03PM +0300, Amir Goldstein wrote:
> So far, all callers of exportfs_encode_inode_fh(), except for fsnotify's
> show_mark_fhandle(), check that filesystem can decode file handles, but
> we would like to add more callers that do not require a file handle that
> can be decoded.
> 
> Introduce a flag to explicitly request a file handle that may not to be
> decoded later and a wrapper exportfs_encode_fid() that sets this flag
> and convert show_mark_fhandle() to use the new wrapper.
> 
> This will be used to allow adding fanotify support to filesystems that
> do not support NFS export.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  Documentation/filesystems/nfs/exporting.rst |  4 ++--
>  fs/exportfs/expfs.c                         | 18 ++++++++++++++++--
>  fs/notify/fanotify/fanotify.c               |  4 ++--
>  fs/notify/fdinfo.c                          |  2 +-
>  include/linux/exportfs.h                    | 12 +++++++++++-
>  5 files changed, 32 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/filesystems/nfs/exporting.rst b/Documentation/filesystems/nfs/exporting.rst
> index 0e98edd353b5..3d97b8d8f735 100644
> --- a/Documentation/filesystems/nfs/exporting.rst
> +++ b/Documentation/filesystems/nfs/exporting.rst
> @@ -122,8 +122,8 @@ are exportable by setting the s_export_op field in the struct
>  super_block.  This field must point to a "struct export_operations"
>  struct which has the following members:
>  
> - encode_fh  (optional)
> -    Takes a dentry and creates a filehandle fragment which can later be used
> +  encode_fh (optional)
> +    Takes a dentry and creates a filehandle fragment which may later be used
>      to find or create a dentry for the same object.  The default
>      implementation creates a filehandle fragment that encodes a 32bit inode
>      and generation number for the inode encoded, and if necessary the
> diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
> index bf1b4925fedd..1b35dda5bdda 100644
> --- a/fs/exportfs/expfs.c
> +++ b/fs/exportfs/expfs.c
> @@ -381,11 +381,25 @@ static int export_encode_fh(struct inode *inode, struct fid *fid,
>  	return type;
>  }
>  
> +/**
> + * exportfs_encode_inode_fh - encode a file handle from inode
> + * @inode:   the object to encode
> + * @fid:     where to store the file handle fragment
> + * @max_len: maximum length to store there
> + * @flags:   properties of the requrested file handle
> + */

Same comment here: /requrested/requested and add a " * Returns an ..."

>  int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
> -			     int *max_len, struct inode *parent)
> +			     int *max_len, struct inode *parent, int flags)
>  {
>  	const struct export_operations *nop = inode->i_sb->s_export_op;
>  
> +	/*
> +	 * If a decodeable file handle was requested, we need to make sure that
> +	 * filesystem can decode file handles.
> +	 */
> +	if (nop && !(flags & EXPORT_FH_FID) && !nop->fh_to_dentry)
> +		return -EOPNOTSUPP;
> +
>  	if (nop && nop->encode_fh)
>  		return nop->encode_fh(inode, fid->raw, max_len, parent);
>  
> @@ -416,7 +430,7 @@ int exportfs_encode_fh(struct dentry *dentry, struct fid *fid, int *max_len,
>  		parent = p->d_inode;
>  	}
>  
> -	error = exportfs_encode_inode_fh(inode, fid, max_len, parent);
> +	error = exportfs_encode_inode_fh(inode, fid, max_len, parent, flags);
>  	dput(p);
>  
>  	return error;
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 29bdd99b29fa..d1a49f5b6e6d 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -380,7 +380,7 @@ static int fanotify_encode_fh_len(struct inode *inode)
>  	if (!inode)
>  		return 0;
>  
> -	exportfs_encode_inode_fh(inode, NULL, &dwords, NULL);
> +	exportfs_encode_inode_fh(inode, NULL, &dwords, NULL, 0);
>  	fh_len = dwords << 2;
>  
>  	/*
> @@ -443,7 +443,7 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
>  	}
>  
>  	dwords = fh_len >> 2;
> -	type = exportfs_encode_inode_fh(inode, buf, &dwords, NULL);
> +	type = exportfs_encode_inode_fh(inode, buf, &dwords, NULL, 0);
>  	err = -EINVAL;
>  	if (!type || type == FILEID_INVALID || fh_len != dwords << 2)
>  		goto out_err;
> diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
> index 55081ae3a6ec..5c430736ec12 100644
> --- a/fs/notify/fdinfo.c
> +++ b/fs/notify/fdinfo.c
> @@ -50,7 +50,7 @@ static void show_mark_fhandle(struct seq_file *m, struct inode *inode)
>  	f.handle.handle_bytes = sizeof(f.pad);
>  	size = f.handle.handle_bytes >> 2;
>  
> -	ret = exportfs_encode_inode_fh(inode, (struct fid *)f.handle.f_handle, &size, NULL);
> +	ret = exportfs_encode_fid(inode, (struct fid *)f.handle.f_handle, &size);
>  	if ((ret == FILEID_INVALID) || (ret < 0)) {
>  		WARN_ONCE(1, "Can't encode file handler for inotify: %d\n", ret);
>  		return;
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index 2b1048238170..635e89e1dae7 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -136,6 +136,7 @@ struct fid {
>  };
>  
>  #define EXPORT_FH_CONNECTABLE	0x1
> +#define EXPORT_FH_FID		0x2
>  
>  /**
>   * struct export_operations - for nfsd to communicate with file systems
> @@ -226,9 +227,18 @@ struct export_operations {
>  };
>  
>  extern int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
> -				    int *max_len, struct inode *parent);
> +				    int *max_len, struct inode *parent,
> +				    int flags);
>  extern int exportfs_encode_fh(struct dentry *dentry, struct fid *fid,
>  			      int *max_len, int flags);
> +
> +static inline int exportfs_encode_fid(struct inode *inode, struct fid *fid,
> +				      int *max_len)
> +{
> +	return exportfs_encode_inode_fh(inode, fid, max_len, NULL,
> +					EXPORT_FH_FID);
> +}
> +
>  extern struct dentry *exportfs_decode_fh_raw(struct vfsmount *mnt,
>  					     struct fid *fid, int fh_len,
>  					     int fileid_type,
> -- 
> 2.34.1
> 

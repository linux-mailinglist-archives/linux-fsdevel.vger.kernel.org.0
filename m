Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DB26EF622
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Apr 2023 16:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240825AbjDZOQe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Apr 2023 10:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239964AbjDZOQc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Apr 2023 10:16:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2729065BE;
        Wed, 26 Apr 2023 07:16:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAAD1636F8;
        Wed, 26 Apr 2023 14:16:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631DAC433D2;
        Wed, 26 Apr 2023 14:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682518590;
        bh=VRjUEWt/kW/Xa+uINaPWCBCrQ1cIT2Ul20MybP9eZL8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tijeAtwSYtJ+7NhK0HPJILPdYUw+VVnHRrKNExWS4sGwgI41F46WtN6Ux2G177yfs
         Lle85Y0P8xMGxb4QmlMB0gJPdEoNbMH5yTapdJCHf8f1iyzCQVHTNzDos5KXMmA/cl
         bljusGMhoPwwoatWIcbO0rmkaRK+hBC27q7oVr4NWaqaYJvVo6xoPfl8XGhAmBphTF
         nu/tgQsXuoZt39bOH7B+6BB+jezc9tWBUIrf/3DHclJRtZ+qGkNcJPMT5cLJzUr47g
         ASAWJo4yxKgJY/jMFsO3KwrrNQrUYjmhumsGz7UhGNzculIFa8DHBZZXRx0h8VMsTq
         tYQKJB5IjePMg==
Date:   Wed, 26 Apr 2023 10:16:27 -0400
From:   Chuck Lever <cel@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-nfs@vger.kernel.org,
        jlayton@kernel.org
Subject: Re: [RFC][PATCH 1/4] exportfs: change connectable argument to bit
 flags
Message-ID: <ZEkyO1xnmhBaGLgE@manet.1015granger.net>
References: <20230425130105.2606684-1-amir73il@gmail.com>
 <20230425130105.2606684-2-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425130105.2606684-2-amir73il@gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 25, 2023 at 04:01:02PM +0300, Amir Goldstein wrote:
> Convert the bool connectable arguemnt into a bit flags argument and
> define the EXPORT_FS_CONNECTABLE flag as a requested property of the
> file handle.
> 
> We are going to add a flag for requesting non-decodeable file handles.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/exportfs/expfs.c      | 11 +++++++++--
>  fs/nfsd/nfsfh.c          |  5 +++--
>  include/linux/exportfs.h |  6 ++++--
>  3 files changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
> index ab88d33d106c..bf1b4925fedd 100644
> --- a/fs/exportfs/expfs.c
> +++ b/fs/exportfs/expfs.c
> @@ -393,14 +393,21 @@ int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
>  }
>  EXPORT_SYMBOL_GPL(exportfs_encode_inode_fh);
>  
> +/**
> + * exportfs_encode_fh - encode a file handle from dentry
> + * @dentry:  the object to encode
> + * @fid:     where to store the file handle fragment
> + * @max_len: maximum length to store there
> + * @flags:   properties of the requrested file handle

Thanks for adding the KDOC comment!

/requrested/requested

And please add:

 *
 * Returns an enum fid_type or a negative errno

> + */
>  int exportfs_encode_fh(struct dentry *dentry, struct fid *fid, int *max_len,
> -		int connectable)
> +		       int flags)
>  {
>  	int error;
>  	struct dentry *p = NULL;
>  	struct inode *inode = dentry->d_inode, *parent = NULL;
>  
> -	if (connectable && !S_ISDIR(inode->i_mode)) {
> +	if ((flags & EXPORT_FH_CONNECTABLE) && !S_ISDIR(inode->i_mode)) {
>  		p = dget_parent(dentry);
>  		/*
>  		 * note that while p might've ceased to be our parent already,
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index ccd8485fee04..31e4505c0df3 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -414,10 +414,11 @@ static void _fh_update(struct svc_fh *fhp, struct svc_export *exp,
>  		struct fid *fid = (struct fid *)
>  			(fhp->fh_handle.fh_fsid + fhp->fh_handle.fh_size/4 - 1);
>  		int maxsize = (fhp->fh_maxsize - fhp->fh_handle.fh_size)/4;
> -		int subtreecheck = !(exp->ex_flags & NFSEXP_NOSUBTREECHECK);
> +		int fh_flags = (exp->ex_flags & NFSEXP_NOSUBTREECHECK) ? 0 :
> +				EXPORT_FH_CONNECTABLE;
>  
>  		fhp->fh_handle.fh_fileid_type =
> -			exportfs_encode_fh(dentry, fid, &maxsize, subtreecheck);
> +			exportfs_encode_fh(dentry, fid, &maxsize, fh_flags);
>  		fhp->fh_handle.fh_size += maxsize * 4;
>  	} else {
>  		fhp->fh_handle.fh_fileid_type = FILEID_ROOT;
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index 601700fedc91..2b1048238170 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -135,6 +135,8 @@ struct fid {
>  	};
>  };
>  
> +#define EXPORT_FH_CONNECTABLE	0x1
> +
>  /**
>   * struct export_operations - for nfsd to communicate with file systems
>   * @encode_fh:      encode a file handle fragment from a dentry
> @@ -150,7 +152,7 @@ struct fid {
>   * encode_fh:
>   *    @encode_fh should store in the file handle fragment @fh (using at most
>   *    @max_len bytes) information that can be used by @decode_fh to recover the
> - *    file referred to by the &struct dentry @de.  If the @connectable flag is
> + *    file referred to by the &struct dentry @de.  If @flag has CONNECTABLE bit
>   *    set, the encode_fh() should store sufficient information so that a good
>   *    attempt can be made to find not only the file but also it's place in the
>   *    filesystem.   This typically means storing a reference to de->d_parent in
> @@ -226,7 +228,7 @@ struct export_operations {
>  extern int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
>  				    int *max_len, struct inode *parent);
>  extern int exportfs_encode_fh(struct dentry *dentry, struct fid *fid,
> -	int *max_len, int connectable);
> +			      int *max_len, int flags);
>  extern struct dentry *exportfs_decode_fh_raw(struct vfsmount *mnt,
>  					     struct fid *fid, int fh_len,
>  					     int fileid_type,
> -- 
> 2.34.1
> 

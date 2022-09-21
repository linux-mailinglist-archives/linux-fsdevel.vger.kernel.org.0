Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB83E5BFA92
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 11:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbiIUJRZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 05:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbiIUJQw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:16:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EF78E464
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 02:16:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7EDD3B82EEC
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 09:15:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5320AC43470;
        Wed, 21 Sep 2022 09:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663751758;
        bh=3/00ybOL5lDL0Wu9eppAOeF222hbXJIo5rBMxKEz3po=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NJDetcYCKgXe6mtH71j13yFG9bJdHxZvrkr3BgrkKktSsH8KnZsQpCNLLYibh+aus
         PlknoT25kXH8gfAZpxJvPkIgzP02NprYntERwuWAfg/wAMySC2OseDizoNIfIfwd9N
         Or2SKb61Wtb4VkVtO8hRKeQWzGsTk8BBZFdF0OSG0j2j+YSq7EuUzHYM1pyCegFXr6
         /WtI/R84hIjii0wbYQzZNdDvwcE/Afi07iTABxpyQEuWYvmBxLiIHYG0z8zw7pJjF+
         EuewSIxUdccD+UcG2v26UiUTGIDvdzj3feu9andBWUaIw8solycHFEmJ+9TOCVpep0
         UJ/d3GqhFg2ZQ==
Date:   Wed, 21 Sep 2022 11:15:53 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: [PATCH v3 9/9] fuse: implement ->tmpfile()
Message-ID: <20220921091553.6iawx562png2pmnk@wittgenstein>
References: <20220920193632.2215598-1-mszeredi@redhat.com>
 <20220920193632.2215598-10-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220920193632.2215598-10-mszeredi@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 20, 2022 at 09:36:32PM +0200, Miklos Szeredi wrote:
> This is basically equivalent to the FUSE_CREATE operation which creates and
> opens a regular file.
> 
> Add a new FUSE_TMPFILE operation, otherwise just reuse the protocol and the
> code for FUSE_CREATE.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/fuse/dir.c             | 25 ++++++++++++++++++++++---
>  fs/fuse/fuse_i.h          |  3 +++
>  include/uapi/linux/fuse.h |  6 +++++-
>  3 files changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index b585b04e815e..01b2d5c5a64a 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -529,7 +529,7 @@ static int get_security_context(struct dentry *entry, umode_t mode,
>   */
>  static int fuse_create_open(struct inode *dir, struct dentry *entry,
>  			    struct file *file, unsigned int flags,
> -			    umode_t mode)
> +			    umode_t mode, u32 opcode)
>  {
>  	int err;
>  	struct inode *inode;
> @@ -573,7 +573,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
>  		inarg.open_flags |= FUSE_OPEN_KILL_SUIDGID;
>  	}
>  
> -	args.opcode = FUSE_CREATE;
> +	args.opcode = opcode;
>  	args.nodeid = get_node_id(dir);
>  	args.in_numargs = 2;
>  	args.in_args[0].size = sizeof(inarg);
> @@ -676,7 +676,7 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
>  	if (fc->no_create)
>  		goto mknod;
>  
> -	err = fuse_create_open(dir, entry, file, flags, mode);
> +	err = fuse_create_open(dir, entry, file, flags, mode, FUSE_CREATE);
>  	if (err == -ENOSYS) {
>  		fc->no_create = 1;
>  		goto mknod;
> @@ -802,6 +802,24 @@ static int fuse_create(struct user_namespace *mnt_userns, struct inode *dir,
>  	return fuse_mknod(&init_user_ns, dir, entry, mode, 0);
>  }
>  
> +static int fuse_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
> +			struct file *file, umode_t mode)
> +{
> +	struct fuse_conn *fc = get_fuse_conn(dir);
> +	int err;
> +
> +	if (fc->no_tmpfile)
> +		goto no_tmpfile;
> +
> +	err = fuse_create_open(dir, file->f_path.dentry, file, file->f_flags, mode, FUSE_TMPFILE);
> +	if (err == -ENOSYS) {
> +		fc->no_tmpfile = 1;
> +no_tmpfile:
> +		err = -EOPNOTSUPP;
> +	}
> +	return err;
> +}

Hm, seems like this could avoid the goto into an if-block:

static int fuse_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
			struct file *file, umode_t mode)
{
	struct fuse_conn *fc = get_fuse_conn(dir);
	int err;

	if (fc->no_tmpfile)
		return -EOPNOTSUPP;

	err = fuse_create_open(dir, file->f_path.dentry, file, file->f_flags, mode, FUSE_TMPFILE);
	if (err == -ENOSYS) {
		fc->no_tmpfile = 1;
		err = -EOPNOTSUPP;
	}
	return err;
}

> +
>  static int fuse_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
>  		      struct dentry *entry, umode_t mode)
>  {
> @@ -1913,6 +1931,7 @@ static const struct inode_operations fuse_dir_inode_operations = {
>  	.setattr	= fuse_setattr,
>  	.create		= fuse_create,
>  	.atomic_open	= fuse_atomic_open,
> +	.tmpfile	= fuse_tmpfile,
>  	.mknod		= fuse_mknod,
>  	.permission	= fuse_permission,
>  	.getattr	= fuse_getattr,
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 488b460e046f..98a9cf531873 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -784,6 +784,9 @@ struct fuse_conn {
>  	/* Does the filesystem support per inode DAX? */
>  	unsigned int inode_dax:1;
>  
> +	/* Is tmpfile not implemented by fs? */
> +	unsigned int no_tmpfile:1;

Just a nit, it might be nicer to turn this into a positive, i.e.,
unsigned int has_tmpfile:1. Easier to understand as people usually
aren't great at processing negations.

> +
>  	/** The number of requests waiting for completion */
>  	atomic_t num_waiting;
>  
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index d6ccee961891..76ee8f9e024a 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -194,6 +194,9 @@
>   *  - add FUSE_SECURITY_CTX init flag
>   *  - add security context to create, mkdir, symlink, and mknod requests
>   *  - add FUSE_HAS_INODE_DAX, FUSE_ATTR_DAX
> + *
> + *  7.37
> + *  - add FUSE_TMPFILE
>   */
>  
>  #ifndef _LINUX_FUSE_H
> @@ -229,7 +232,7 @@
>  #define FUSE_KERNEL_VERSION 7
>  
>  /** Minor version number of this interface */
> -#define FUSE_KERNEL_MINOR_VERSION 36
> +#define FUSE_KERNEL_MINOR_VERSION 37
>  
>  /** The node ID of the root inode */
>  #define FUSE_ROOT_ID 1
> @@ -537,6 +540,7 @@ enum fuse_opcode {
>  	FUSE_SETUPMAPPING	= 48,
>  	FUSE_REMOVEMAPPING	= 49,
>  	FUSE_SYNCFS		= 50,
> +	FUSE_TMPFILE		= 51,
>  
>  	/* CUSE specific operations */
>  	CUSE_INIT		= 4096,
> -- 
> 2.37.3
> 

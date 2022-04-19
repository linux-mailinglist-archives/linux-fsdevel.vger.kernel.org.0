Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117AD506F67
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 15:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352920AbiDSNz5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 09:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344219AbiDSNz4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 09:55:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBECFC8;
        Tue, 19 Apr 2022 06:53:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77AA8B819A6;
        Tue, 19 Apr 2022 13:53:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC2FC385A5;
        Tue, 19 Apr 2022 13:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650376391;
        bh=Be3mZfJoy0CliryOA2fBQjHR8BmfJsfmh99b6jOi7Ko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VOfxYf7hFONmEEb4I6j9FfesGbo0DFnS3JlG0i8asRHkYXXMRUTcRcdlKO9nLI06e
         GsSXV6h/udGJYNLMtkDw+6waQDQS92NVEeX8a8haCKMqmBZr5KWEf7ZMc79nIPSVKF
         IcRPqtMueCqZvd0mQtunSdnUCriA66iwIXNVefs26jJzZ8YmiFWaU2OjsJraxe2fwe
         542pz8CIyFpW3UJhypr3gu2fseDAk9t05ltRW3rraYz3psE/uYR6z9VHePpDsH6j7G
         rl5GK7pJj5RrlsKO4RQq5Ra+xjoRRp7UeiN7m24nxWagFpupPNbT370X4mCOeqWjoi
         Ww5bhSvoipNEA==
Date:   Tue, 19 Apr 2022 15:53:05 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        viro@zeniv.linux.org.uk, david@fromorbit.com, djwong@kernel.org,
        jlayton@kernel.org, ntfs3@lists.linux.dev, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v4 3/8] xfs: only call posix_acl_create under
 CONFIG_XFS_POSIX_ACL
Message-ID: <20220419135305.7vztxq5mld5jynt5@wittgenstein>
References: <1650368834-2420-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1650368834-2420-3-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1650368834-2420-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 19, 2022 at 07:47:09PM +0800, Yang Xu wrote:
> Since xfs_generic_create only calls xfs_set_acl when enable this kconfig, we
> don't need to call posix_acl_create for the !CONFIG_XFS_POSIX_ACL case.
> 
> The previous patch has added missing umask strip for tmpfile, so all creation
> paths handle umask in the vfs directly if the filesystem doesn't support or
> enable POSIX ACLs.
> 
> So just put this function under CONFIG_XFS_POSIX_ACL and umask strip still works
> well.
> 
> Also use unified rule for CONFIG_XFS_POSIX_ACL in this file, so use IS_ENABLED in
> xfs_generic_create.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  fs/xfs/xfs_iops.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index b34e8e4344a8..6b8df9ab215a 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -150,6 +150,7 @@ xfs_create_need_xattr(
>  		return true;
>  	if (default_acl)
>  		return true;
> +
>  #if IS_ENABLED(CONFIG_SECURITY)
>  	if (dir->i_sb->s_security)
>  		return true;
> @@ -169,7 +170,7 @@ xfs_generic_create(
>  {
>  	struct inode	*inode;
>  	struct xfs_inode *ip = NULL;
> -	struct posix_acl *default_acl, *acl;
> +	struct posix_acl *default_acl = NULL, *acl = NULL;
>  	struct xfs_name	name;
>  	int		error;
>  
> @@ -184,9 +185,11 @@ xfs_generic_create(
>  		rdev = 0;
>  	}
>  
> +#if IS_ENABLED(CONFIG_XFS_POSIX_ACL)
>  	error = posix_acl_create(dir, &mode, &default_acl, &acl);
>  	if (error)
>  		return error;
> +#endif

Does this actually fix or improve anything?
If CONFIG_XFS_POSIX_ACL isn't selected then SB_POSIXACL won't be set in
inode->i_sb->s_flags and consequently posix_acl_create() is a nop. So
ifdefing this doesn't really do anything so I'd argue to not bother with
this change.

>  	/* Verify mode is valid also for tmpfile case */
>  	error = xfs_dentry_mode_to_name(&name, dentry, mode);
> @@ -209,7 +212,7 @@ xfs_generic_create(
>  	if (unlikely(error))
>  		goto out_cleanup_inode;
>  
> -#ifdef CONFIG_XFS_POSIX_ACL
> +#if IS_ENABLED(CONFIG_XFS_POSIX_ACL)
>  	if (default_acl) {
>  		error = __xfs_set_acl(inode, default_acl, ACL_TYPE_DEFAULT);
>  		if (error)

Side-note, I think

	#ifdef CONFIG_XFS_POSIX_ACL
	extern struct posix_acl *xfs_get_acl(struct inode *inode, int type, bool rcu);
	extern int xfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
			       struct posix_acl *acl, int type);
	extern int __xfs_set_acl(struct inode *inode, struct posix_acl *acl, int type);
	#else
	extern int xfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
			       struct posix_acl *acl, int type)
	{
		return 0;
	}
	
	extern int __xfs_set_acl(struct inode *inode, struct posix_acl *acl, int type)
	{
		return 0;
	}
	#endif

and then removing the inline-ifdef might be an improvement.

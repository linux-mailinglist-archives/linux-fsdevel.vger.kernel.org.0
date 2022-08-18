Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75357597F7B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 09:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243567AbiHRHrg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 03:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236549AbiHRHrf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 03:47:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D1182849
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Aug 2022 00:47:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 099C4616FC
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Aug 2022 07:47:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E65C433C1;
        Thu, 18 Aug 2022 07:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660808853;
        bh=WbZnBXHfkCGTNiPqYLLnGPQyGjyaS/GI70iNcYE0Jy8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rKpeIDIpbkmJyPo5zmB3eXJc5xT27EPu+qZebdPjcqp3Y/kjL5nwOuH1wq3C6q0fy
         WoX9IKcumx6Xmngszq3SAh3ZHwDkNEVGPeEMJYXGr8KyKVcw59lpoq1H/gShOfqeAN
         avIUSBxx4oSegu5Xxj+4/OLggRyj/xknfSF2i/ePJtrRReBPzSnZQvvxAJJzi1/dVm
         jUhcStDGoKdrArkhVJlEfDggW7PI5HKwtG4RiFr74WfqxuPSwdopXEGSrQOT8p3VY9
         fnrmo26I64q7N8FauVtPx6+FPSNrFgWAh9kxUllobCAscQdKRz9Au9jfzr3MVkLokR
         6wCnXdoaxFODg==
Date:   Thu, 18 Aug 2022 09:47:29 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] ntfs: fix acl handling
Message-ID: <20220818074729.u45tzc3lq7y6zibd@wittgenstein>
References: <20220720123252.686466-1-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220720123252.686466-1-brauner@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 20, 2022 at 02:32:52PM +0200, Christian Brauner wrote:
> While looking at our current POSIX ACL handling in the context of some
> overlayfs work I went through a range of other filesystems checking how they
> handle them currently and encountered ntfs3.
> 
> The posic_acl_{from,to}_xattr() helpers always need to operate on the
> filesystem idmapping. Since ntfs3 can only be mounted in the initial user
> namespace the relevant idmapping is init_user_ns.
> 
> The posix_acl_{from,to}_xattr() helpers are concerned with translating between
> the kernel internal struct posix_acl{_entry} and the uapi struct
> posix_acl_xattr_{header,entry} and the kernel internal data structure is cached
> filesystem wide.
> 
> Additional idmappings such as the caller's idmapping or the mount's idmapping
> are handled higher up in the VFS. Individual filesystems usually do not need to
> concern themselves with these.
> 
> The posix_acl_valid() helper is concerned with checking whether the values in
> the kernel internal struct posix_acl can be represented in the filesystem's
> idmapping. IOW, if they can be written to disk. So this helper too needs to
> take the filesystem's idmapping.
> 
> Fixes: be71b5cba2e6 ("fs/ntfs3: Add attrib operations")
> Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> Cc: ntfs3@lists.linux.dev
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> ---

Somehow this patch fell through the cracks and this should really be
fixed. Do you plan on sending a PR for this soon or should I just send
it through my tree?

>  fs/ntfs3/xattr.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
> index 5e0e0280e70d..3e9118705174 100644
> --- a/fs/ntfs3/xattr.c
> +++ b/fs/ntfs3/xattr.c
> @@ -478,8 +478,7 @@ static noinline int ntfs_set_ea(struct inode *inode, const char *name,
>  }
>  
>  #ifdef CONFIG_NTFS3_FS_POSIX_ACL
> -static struct posix_acl *ntfs_get_acl_ex(struct user_namespace *mnt_userns,
> -					 struct inode *inode, int type,
> +static struct posix_acl *ntfs_get_acl_ex(struct inode *inode, int type,
>  					 int locked)
>  {
>  	struct ntfs_inode *ni = ntfs_i(inode);
> @@ -514,7 +513,7 @@ static struct posix_acl *ntfs_get_acl_ex(struct user_namespace *mnt_userns,
>  
>  	/* Translate extended attribute to acl. */
>  	if (err >= 0) {
> -		acl = posix_acl_from_xattr(mnt_userns, buf, err);
> +		acl = posix_acl_from_xattr(&init_user_ns, buf, err);
>  	} else if (err == -ENODATA) {
>  		acl = NULL;
>  	} else {
> @@ -537,8 +536,7 @@ struct posix_acl *ntfs_get_acl(struct inode *inode, int type, bool rcu)
>  	if (rcu)
>  		return ERR_PTR(-ECHILD);
>  
> -	/* TODO: init_user_ns? */
> -	return ntfs_get_acl_ex(&init_user_ns, inode, type, 0);
> +	return ntfs_get_acl_ex(inode, type, 0);
>  }
>  
>  static noinline int ntfs_set_acl_ex(struct user_namespace *mnt_userns,
> @@ -595,7 +593,7 @@ static noinline int ntfs_set_acl_ex(struct user_namespace *mnt_userns,
>  		value = kmalloc(size, GFP_NOFS);
>  		if (!value)
>  			return -ENOMEM;
> -		err = posix_acl_to_xattr(mnt_userns, acl, value, size);
> +		err = posix_acl_to_xattr(&init_user_ns, acl, value, size);
>  		if (err < 0)
>  			goto out;
>  		flags = 0;
> @@ -641,7 +639,7 @@ static int ntfs_xattr_get_acl(struct user_namespace *mnt_userns,
>  	if (!acl)
>  		return -ENODATA;
>  
> -	err = posix_acl_to_xattr(mnt_userns, acl, buffer, size);
> +	err = posix_acl_to_xattr(&init_user_ns, acl, buffer, size);
>  	posix_acl_release(acl);
>  
>  	return err;
> @@ -665,12 +663,12 @@ static int ntfs_xattr_set_acl(struct user_namespace *mnt_userns,
>  	if (!value) {
>  		acl = NULL;
>  	} else {
> -		acl = posix_acl_from_xattr(mnt_userns, value, size);
> +		acl = posix_acl_from_xattr(&init_user_ns, value, size);
>  		if (IS_ERR(acl))
>  			return PTR_ERR(acl);
>  
>  		if (acl) {
> -			err = posix_acl_valid(mnt_userns, acl);
> +			err = posix_acl_valid(&init_user_ns, acl);
>  			if (err)
>  				goto release_and_out;
>  		}
> 
> base-commit: ff6992735ade75aae3e35d16b17da1008d753d28
> -- 
> 2.34.1
> 

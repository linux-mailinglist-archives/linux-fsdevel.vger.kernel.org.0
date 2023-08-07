Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB1A7725FA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 15:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbjHGNik (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 09:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbjHGNii (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:38:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408EB10DB;
        Mon,  7 Aug 2023 06:38:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D53161B74;
        Mon,  7 Aug 2023 13:38:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB48CC433C7;
        Mon,  7 Aug 2023 13:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691415512;
        bh=I5WseB4Y4y1ZofTJjbEO6OaEQ9v3he1pcuEPu99HYt4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AQbPvqqPxs/H4iK5d0ajPk6kgbyPUlsPhXJNlkdXMUntzSq6nFTwyEN8PkOdsmtXa
         frs/XAolt/P5MZZG6nvV7uHBNQvDd/UafhyEbAkVDZkhw1pOKpEKy8dHkE8t8ieQC8
         gWTerIKpOLTedkfext+qS814gB46v4ueE06EzhSy6EpM6uWbXHVXWn/E+fg1fIi1xF
         znvuydI90Vn+RIvixWU1ohojaZ5kdjXg2ZFDHRHVlGUwt4F9XCY51OhOJEzugMItBc
         1oFxk19rwPdUCGuOQvxkf5tzx+DXYbuWcyHDrI26skurIPJmHIC9V9rw1L0yMlQbos
         4fz6A2vyJi7XQ==
Date:   Mon, 7 Aug 2023 15:38:25 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Scott Mayhew <smayhew@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Subject: Re: [PATCH v8] vfs, security: Fix automount superblock LSM init
 problem, preventing NFS sb sharing
Message-ID: <20230807-ohrfeigen-misswirtschaft-29303ebbc83b@brauner>
References: <20230807-master-v8-1-54e249595f10@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230807-master-v8-1-54e249595f10@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 07, 2023 at 09:18:01AM -0400, Jeff Layton wrote:
> From: David Howells <dhowells@redhat.com>
> 
> When NFS superblocks are created by automounting, their LSM parameters
> aren't set in the fs_context struct prior to sget_fc() being called,
> leading to failure to match existing superblocks.
> 
> This bug leads to messages like the following appearing in dmesg when
> fscache is enabled:
> 
>     NFS: Cache volume key already in use (nfs,4.2,2,108,106a8c0,1,,,,100000,100000,2ee,3a98,1d4c,3a98,1)
> 
> Fix this by adding a new LSM hook to load fc->security for submount
> creation.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> Fixes: 9bc61ab18b1d ("vfs: Introduce fs_context, switch vfs_kern_mount() to it.")
> Fixes: 779df6a5480f ("NFS: Ensure security label is set for root inode)
> Tested-by: Jeff Layton <jlayton@kernel.org>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> Acked-by: "Christian Brauner (Microsoft)" <brauner@kernel.org>
> Link: https://lore.kernel.org/r/165962680944.3334508.6610023900349142034.stgit@warthog.procyon.org.uk/ # v1
> Link: https://lore.kernel.org/r/165962729225.3357250.14350728846471527137.stgit@warthog.procyon.org.uk/ # v2
> Link: https://lore.kernel.org/r/165970659095.2812394.6868894171102318796.stgit@warthog.procyon.org.uk/ # v3
> Link: https://lore.kernel.org/r/166133579016.3678898.6283195019480567275.stgit@warthog.procyon.org.uk/ # v4
> Link: https://lore.kernel.org/r/217595.1662033775@warthog.procyon.org.uk/ # v5
> ---
> ver #2)
> - Added Smack support
> - Made LSM parameter extraction dependent on reference != NULL.
> 
> ver #3)
> - Made LSM parameter extraction dependent on fc->purpose ==
>    FS_CONTEXT_FOR_SUBMOUNT.  Shouldn't happen on FOR_RECONFIGURE.
> 
> ver #4)
> - When doing a FOR_SUBMOUNT mount, don't set the root label in SELinux or Smack.
> 
> ver #5)
> - Removed unused variable.
> - Only allocate smack_mnt_opts if we're dealing with a submount.
> 
> ver #6)
> - Rebase onto v6.5.0-rc4
> - Link to v6: https://lore.kernel.org/r/20230802-master-v6-1-45d48299168b@kernel.org
> 
> ver #7)
> - Drop lsm_set boolean
> - Link to v7: https://lore.kernel.org/r/20230804-master-v7-1-5d4e48407298@kernel.org
> 
> ver #8)
> - Remove spurious semicolon in smack_fs_context_init
> - Make fs_context_init take a superblock as reference instead of dentry
> - WARN_ON_ONCE's when fc->purpose != FS_CONTEXT_FOR_SUBMOUNT
> - Call the security hook from fs_context_for_submount instead of alloc_fs_context
> ---
>  fs/fs_context.c               | 23 +++++++++++++++++-
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/security.h      |  6 +++++
>  security/security.c           | 14 +++++++++++
>  security/selinux/hooks.c      | 25 ++++++++++++++++++++
>  security/smack/smack_lsm.c    | 54 +++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 122 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/fs_context.c b/fs/fs_context.c
> index 851214d1d013..a76d7c82e091 100644
> --- a/fs/fs_context.c
> +++ b/fs/fs_context.c
> @@ -315,10 +315,31 @@ struct fs_context *fs_context_for_reconfigure(struct dentry *dentry,
>  }
>  EXPORT_SYMBOL(fs_context_for_reconfigure);
>  
> +/**
> + * fs_context_for_submount: allocate a new fs_context for a submount
> + * @type: file_system_type of the new context
> + * @reference: reference dentry from which to copy relevant info
> + *
> + * Allocate a new fs_context suitable for a submount. This also ensures that
> + * the fc->security object is inherited from @reference (if needed).
> + */
>  struct fs_context *fs_context_for_submount(struct file_system_type *type,
>  					   struct dentry *reference)
>  {
> -	return alloc_fs_context(type, reference, 0, 0, FS_CONTEXT_FOR_SUBMOUNT);
> +	struct fs_context *fc;
> +	int ret;
> +
> +	fc = alloc_fs_context(type, reference, 0, 0, FS_CONTEXT_FOR_SUBMOUNT);
> +	if (IS_ERR(fc))
> +		return fc;
> +
> +	ret = security_fs_context_init(fc, reference->d_sb);
> +	if (ret) {
> +		put_fs_context(fc);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return fc;
>  }
>  EXPORT_SYMBOL(fs_context_for_submount);
>  
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 7308a1a7599b..2876dd6114c0 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -54,6 +54,7 @@ LSM_HOOK(int, 0, bprm_creds_from_file, struct linux_binprm *bprm, struct file *f
>  LSM_HOOK(int, 0, bprm_check_security, struct linux_binprm *bprm)
>  LSM_HOOK(void, LSM_RET_VOID, bprm_committing_creds, struct linux_binprm *bprm)
>  LSM_HOOK(void, LSM_RET_VOID, bprm_committed_creds, struct linux_binprm *bprm)
> +LSM_HOOK(int, 0, fs_context_init, struct fs_context *fc, struct super_block *reference)
>  LSM_HOOK(int, 0, fs_context_dup, struct fs_context *fc,
>  	 struct fs_context *src_sc)
>  LSM_HOOK(int, -ENOPARAM, fs_context_parse_param, struct fs_context *fc,
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 32828502f09e..fe9bf5e805ee 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -293,6 +293,7 @@ int security_bprm_creds_from_file(struct linux_binprm *bprm, struct file *file);
>  int security_bprm_check(struct linux_binprm *bprm);
>  void security_bprm_committing_creds(struct linux_binprm *bprm);
>  void security_bprm_committed_creds(struct linux_binprm *bprm);
> +int security_fs_context_init(struct fs_context *fc, struct super_block *reference);
>  int security_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc);
>  int security_fs_context_parse_param(struct fs_context *fc, struct fs_parameter *param);
>  int security_sb_alloc(struct super_block *sb);
> @@ -629,6 +630,11 @@ static inline void security_bprm_committed_creds(struct linux_binprm *bprm)
>  {
>  }
>  
> +static inline int security_fs_context_init(struct fs_context *fc,
> +					   struct super_block *reference)
> +{
> +	return 0;
> +}

Sorry, my point is we shouldn't be adding a generic
security_fs_context_init() hook at all. Pre superblock creation we have
a hook during parameter parsing for LSMs and another one during actual
superblock creation in vfs_get_tree() and yet another one for fs_context
duplicaton. We don't need another generic one during fs_context
allocation.

Yes, we may need a hook for submount allocation but then we'll add one
exactly for that. And then for fs_context_for_submount @sb can't be
empty so there's also no point in checking whether it is empty because
you've already crashed in fs_context_for_submount(). All the checks
below for !reference and fc->purpose != FS_CONTEXT_FOR_SUBMOUNT can go
away then as well.

So we end up with something easier and stricter.

>  static inline int security_fs_context_dup(struct fs_context *fc,
>  					  struct fs_context *src_fc)
>  {
> diff --git a/security/security.c b/security/security.c
> index b720424ca37d..f8a666d089f9 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1138,6 +1138,20 @@ void security_bprm_committed_creds(struct linux_binprm *bprm)
>  	call_void_hook(bprm_committed_creds, bprm);
>  }
>  
> +/**
> + * security_fs_context_init() - Initialise fc->security
> + * @fc: new filesystem context
> + * @reference: dentry reference for submount/remount
> + *
> + * Fill out the ->security field for a new fs_context.
> + *
> + * Return: Returns 0 on success or negative error code on failure.
> + */
> +int security_fs_context_init(struct fs_context *fc, struct super_block *reference)
> +{
> +	return call_int_hook(fs_context_init, 0, fc, reference);
> +}
> +
>  /**
>   * security_fs_context_dup() - Duplicate a fs_context LSM blob
>   * @fc: destination filesystem context
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index d06e350fedee..c8fb0d77104f 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2745,6 +2745,30 @@ static int selinux_umount(struct vfsmount *mnt, int flags)
>  				   FILESYSTEM__UNMOUNT, NULL);
>  }
>  
> +static int selinux_fs_context_init(struct fs_context *fc,
> +				   struct super_block *reference)
> +{
> +	const struct superblock_security_struct *sbsec;
> +	struct selinux_mnt_opts *opts;
> +
> +	if (!reference || WARN_ON_ONCE(fc->purpose != FS_CONTEXT_FOR_SUBMOUNT))
> +		return 0;

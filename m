Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9EA31122F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 21:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbhBEShV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 13:37:21 -0500
Received: from mail.hallyn.com ([178.63.66.53]:53186 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233033AbhBEPJd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:09:33 -0500
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 44266A5E; Fri,  5 Feb 2021 08:17:49 -0600 (CST)
Date:   Fri, 5 Feb 2021 08:17:49 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        John Johansen <john.johansen@canonical.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v28 05/12] LSM: Infrastructure management of the
 superblock
Message-ID: <20210205141749.GB17981@mail.hallyn.com>
References: <20210202162710.657398-1-mic@digikod.net>
 <20210202162710.657398-6-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210202162710.657398-6-mic@digikod.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 02, 2021 at 05:27:03PM +0100, Mickaël Salaün wrote:
> From: Casey Schaufler <casey@schaufler-ca.com>
> 
> Move management of the superblock->sb_security blob out of the
> individual security modules and into the security infrastructure.
> Instead of allocating the blobs from within the modules, the modules
> tell the infrastructure how much space is required, and the space is
> allocated there.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: Serge Hallyn <serge@hallyn.com>

I wonder how many out of tree modules this will impact :)  Actually
if some new incoming module does an rcu callback to free the
sb_security, then the security_sb_free will need an update, but
that seems unlikely.

> ---
> 
> Changes since v26:
> * Rebase on commit b159e86b5a2a ("selinux: drop super_block backpointer
>   from superblock_security_struct").  No change in the patch itself,
>   only a trivial conflict because of an updated nearby line in
>   selinux_set_mnt_opts() variable declarations.
> 
> Changes since v20:
> * Remove all Reviewed-by except Stephen Smalley:
>   https://lore.kernel.org/lkml/CAEjxPJ7ARJO57MBW66=xsBzMMRb=9uLgqocK5eskHCaiVMx7Vw@mail.gmail.com/
> * Cosmetic fix in the commit message.
> 
> Changes since v17:
> * Rebase the original LSM stacking patch from v5.3 to v5.7: I fixed some
>   diff conflicts caused by code moves and function renames in
>   selinux/include/objsec.h and selinux/hooks.c .  I checked that it
>   builds but I didn't test the changes for SELinux nor SMACK.
>   https://lore.kernel.org/r/20190829232935.7099-2-casey@schaufler-ca.com
> ---
>  include/linux/lsm_hooks.h         |  1 +
>  security/security.c               | 46 ++++++++++++++++++++----
>  security/selinux/hooks.c          | 58 ++++++++++++-------------------
>  security/selinux/include/objsec.h |  6 ++++
>  security/selinux/ss/services.c    |  3 +-
>  security/smack/smack.h            |  6 ++++
>  security/smack/smack_lsm.c        | 35 +++++--------------
>  7 files changed, 85 insertions(+), 70 deletions(-)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index a19adef1f088..970106d98306 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1563,6 +1563,7 @@ struct lsm_blob_sizes {
>  	int	lbs_cred;
>  	int	lbs_file;
>  	int	lbs_inode;
> +	int	lbs_superblock;
>  	int	lbs_ipc;
>  	int	lbs_msg_msg;
>  	int	lbs_task;
> diff --git a/security/security.c b/security/security.c
> index 7b09cfbae94f..9f979d4afe6c 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -203,6 +203,7 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
>  	lsm_set_blob_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
>  	lsm_set_blob_size(&needed->lbs_ipc, &blob_sizes.lbs_ipc);
>  	lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
> +	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
>  	lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
>  }
>  
> @@ -333,12 +334,13 @@ static void __init ordered_lsm_init(void)
>  	for (lsm = ordered_lsms; *lsm; lsm++)
>  		prepare_lsm(*lsm);
>  
> -	init_debug("cred blob size     = %d\n", blob_sizes.lbs_cred);
> -	init_debug("file blob size     = %d\n", blob_sizes.lbs_file);
> -	init_debug("inode blob size    = %d\n", blob_sizes.lbs_inode);
> -	init_debug("ipc blob size      = %d\n", blob_sizes.lbs_ipc);
> -	init_debug("msg_msg blob size  = %d\n", blob_sizes.lbs_msg_msg);
> -	init_debug("task blob size     = %d\n", blob_sizes.lbs_task);
> +	init_debug("cred blob size       = %d\n", blob_sizes.lbs_cred);
> +	init_debug("file blob size       = %d\n", blob_sizes.lbs_file);
> +	init_debug("inode blob size      = %d\n", blob_sizes.lbs_inode);
> +	init_debug("ipc blob size        = %d\n", blob_sizes.lbs_ipc);
> +	init_debug("msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
> +	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
> +	init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
>  
>  	/*
>  	 * Create any kmem_caches needed for blobs
> @@ -670,6 +672,27 @@ static void __init lsm_early_task(struct task_struct *task)
>  		panic("%s: Early task alloc failed.\n", __func__);
>  }
>  
> +/**
> + * lsm_superblock_alloc - allocate a composite superblock blob
> + * @sb: the superblock that needs a blob
> + *
> + * Allocate the superblock blob for all the modules
> + *
> + * Returns 0, or -ENOMEM if memory can't be allocated.
> + */
> +static int lsm_superblock_alloc(struct super_block *sb)
> +{
> +	if (blob_sizes.lbs_superblock == 0) {
> +		sb->s_security = NULL;
> +		return 0;
> +	}
> +
> +	sb->s_security = kzalloc(blob_sizes.lbs_superblock, GFP_KERNEL);
> +	if (sb->s_security == NULL)
> +		return -ENOMEM;
> +	return 0;
> +}
> +
>  /*
>   * The default value of the LSM hook is defined in linux/lsm_hook_defs.h and
>   * can be accessed with:
> @@ -867,12 +890,21 @@ int security_fs_context_parse_param(struct fs_context *fc, struct fs_parameter *
>  
>  int security_sb_alloc(struct super_block *sb)
>  {
> -	return call_int_hook(sb_alloc_security, 0, sb);
> +	int rc = lsm_superblock_alloc(sb);
> +
> +	if (unlikely(rc))
> +		return rc;
> +	rc = call_int_hook(sb_alloc_security, 0, sb);
> +	if (unlikely(rc))
> +		security_sb_free(sb);
> +	return rc;
>  }
>  
>  void security_sb_free(struct super_block *sb)
>  {
>  	call_void_hook(sb_free_security, sb);
> +	kfree(sb->s_security);
> +	sb->s_security = NULL;
>  }
>  
>  void security_free_mnt_opts(void **mnt_opts)
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 644b17ec9e63..ecf0ca8c3108 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -322,7 +322,7 @@ static void inode_free_security(struct inode *inode)
>  
>  	if (!isec)
>  		return;
> -	sbsec = inode->i_sb->s_security;
> +	sbsec = selinux_superblock(inode->i_sb);
>  	/*
>  	 * As not all inode security structures are in a list, we check for
>  	 * empty list outside of the lock to make sure that we won't waste
> @@ -340,13 +340,6 @@ static void inode_free_security(struct inode *inode)
>  	}
>  }
>  
> -static void superblock_free_security(struct super_block *sb)
> -{
> -	struct superblock_security_struct *sbsec = sb->s_security;
> -	sb->s_security = NULL;
> -	kfree(sbsec);
> -}
> -
>  struct selinux_mnt_opts {
>  	const char *fscontext, *context, *rootcontext, *defcontext;
>  };
> @@ -458,7 +451,7 @@ static int selinux_is_genfs_special_handling(struct super_block *sb)
>  
>  static int selinux_is_sblabel_mnt(struct super_block *sb)
>  {
> -	struct superblock_security_struct *sbsec = sb->s_security;
> +	struct superblock_security_struct *sbsec = selinux_superblock(sb);
>  
>  	/*
>  	 * IMPORTANT: Double-check logic in this function when adding a new
> @@ -486,7 +479,7 @@ static int selinux_is_sblabel_mnt(struct super_block *sb)
>  
>  static int sb_finish_set_opts(struct super_block *sb)
>  {
> -	struct superblock_security_struct *sbsec = sb->s_security;
> +	struct superblock_security_struct *sbsec = selinux_superblock(sb);
>  	struct dentry *root = sb->s_root;
>  	struct inode *root_inode = d_backing_inode(root);
>  	int rc = 0;
> @@ -599,7 +592,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>  				unsigned long *set_kern_flags)
>  {
>  	const struct cred *cred = current_cred();
> -	struct superblock_security_struct *sbsec = sb->s_security;
> +	struct superblock_security_struct *sbsec = selinux_superblock(sb);
>  	struct dentry *root = sb->s_root;
>  	struct selinux_mnt_opts *opts = mnt_opts;
>  	struct inode_security_struct *root_isec;
> @@ -836,8 +829,8 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>  static int selinux_cmp_sb_context(const struct super_block *oldsb,
>  				    const struct super_block *newsb)
>  {
> -	struct superblock_security_struct *old = oldsb->s_security;
> -	struct superblock_security_struct *new = newsb->s_security;
> +	struct superblock_security_struct *old = selinux_superblock(oldsb);
> +	struct superblock_security_struct *new = selinux_superblock(newsb);
>  	char oldflags = old->flags & SE_MNTMASK;
>  	char newflags = new->flags & SE_MNTMASK;
>  
> @@ -869,8 +862,9 @@ static int selinux_sb_clone_mnt_opts(const struct super_block *oldsb,
>  					unsigned long *set_kern_flags)
>  {
>  	int rc = 0;
> -	const struct superblock_security_struct *oldsbsec = oldsb->s_security;
> -	struct superblock_security_struct *newsbsec = newsb->s_security;
> +	const struct superblock_security_struct *oldsbsec =
> +						selinux_superblock(oldsb);
> +	struct superblock_security_struct *newsbsec = selinux_superblock(newsb);
>  
>  	int set_fscontext =	(oldsbsec->flags & FSCONTEXT_MNT);
>  	int set_context =	(oldsbsec->flags & CONTEXT_MNT);
> @@ -1049,7 +1043,7 @@ static int show_sid(struct seq_file *m, u32 sid)
>  
>  static int selinux_sb_show_options(struct seq_file *m, struct super_block *sb)
>  {
> -	struct superblock_security_struct *sbsec = sb->s_security;
> +	struct superblock_security_struct *sbsec = selinux_superblock(sb);
>  	int rc;
>  
>  	if (!(sbsec->flags & SE_SBINITIALIZED))
> @@ -1399,7 +1393,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>  	if (isec->sclass == SECCLASS_FILE)
>  		isec->sclass = inode_mode_to_security_class(inode->i_mode);
>  
> -	sbsec = inode->i_sb->s_security;
> +	sbsec = selinux_superblock(inode->i_sb);
>  	if (!(sbsec->flags & SE_SBINITIALIZED)) {
>  		/* Defer initialization until selinux_complete_init,
>  		   after the initial policy is loaded and the security
> @@ -1750,7 +1744,8 @@ selinux_determine_inode_label(const struct task_security_struct *tsec,
>  				 const struct qstr *name, u16 tclass,
>  				 u32 *_new_isid)
>  {
> -	const struct superblock_security_struct *sbsec = dir->i_sb->s_security;
> +	const struct superblock_security_struct *sbsec =
> +						selinux_superblock(dir->i_sb);
>  
>  	if ((sbsec->flags & SE_SBINITIALIZED) &&
>  	    (sbsec->behavior == SECURITY_FS_USE_MNTPOINT)) {
> @@ -1781,7 +1776,7 @@ static int may_create(struct inode *dir,
>  	int rc;
>  
>  	dsec = inode_security(dir);
> -	sbsec = dir->i_sb->s_security;
> +	sbsec = selinux_superblock(dir->i_sb);
>  
>  	sid = tsec->sid;
>  
> @@ -1930,7 +1925,7 @@ static int superblock_has_perm(const struct cred *cred,
>  	struct superblock_security_struct *sbsec;
>  	u32 sid = cred_sid(cred);
>  
> -	sbsec = sb->s_security;
> +	sbsec = selinux_superblock(sb);
>  	return avc_has_perm(&selinux_state,
>  			    sid, sbsec->sid, SECCLASS_FILESYSTEM, perms, ad);
>  }
> @@ -2559,11 +2554,7 @@ static void selinux_bprm_committed_creds(struct linux_binprm *bprm)
>  
>  static int selinux_sb_alloc_security(struct super_block *sb)
>  {
> -	struct superblock_security_struct *sbsec;
> -
> -	sbsec = kzalloc(sizeof(struct superblock_security_struct), GFP_KERNEL);
> -	if (!sbsec)
> -		return -ENOMEM;
> +	struct superblock_security_struct *sbsec = selinux_superblock(sb);
>  
>  	mutex_init(&sbsec->lock);
>  	INIT_LIST_HEAD(&sbsec->isec_head);
> @@ -2571,16 +2562,10 @@ static int selinux_sb_alloc_security(struct super_block *sb)
>  	sbsec->sid = SECINITSID_UNLABELED;
>  	sbsec->def_sid = SECINITSID_FILE;
>  	sbsec->mntpoint_sid = SECINITSID_UNLABELED;
> -	sb->s_security = sbsec;
>  
>  	return 0;
>  }
>  
> -static void selinux_sb_free_security(struct super_block *sb)
> -{
> -	superblock_free_security(sb);
> -}
> -
>  static inline int opt_len(const char *s)
>  {
>  	bool open_quote = false;
> @@ -2659,7 +2644,7 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
>  static int selinux_sb_remount(struct super_block *sb, void *mnt_opts)
>  {
>  	struct selinux_mnt_opts *opts = mnt_opts;
> -	struct superblock_security_struct *sbsec = sb->s_security;
> +	struct superblock_security_struct *sbsec = selinux_superblock(sb);
>  	u32 sid;
>  	int rc;
>  
> @@ -2897,7 +2882,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
>  	int rc;
>  	char *context;
>  
> -	sbsec = dir->i_sb->s_security;
> +	sbsec = selinux_superblock(dir->i_sb);
>  
>  	newsid = tsec->create_sid;
>  
> @@ -3142,7 +3127,7 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
>  	if (!selinux_initialized(&selinux_state))
>  		return (inode_owner_or_capable(inode) ? 0 : -EPERM);
>  
> -	sbsec = inode->i_sb->s_security;
> +	sbsec = selinux_superblock(inode->i_sb);
>  	if (!(sbsec->flags & SBLABEL_MNT))
>  		return -EOPNOTSUPP;
>  
> @@ -3384,13 +3369,14 @@ static int selinux_inode_setsecurity(struct inode *inode, const char *name,
>  				     const void *value, size_t size, int flags)
>  {
>  	struct inode_security_struct *isec = inode_security_novalidate(inode);
> -	struct superblock_security_struct *sbsec = inode->i_sb->s_security;
> +	struct superblock_security_struct *sbsec;
>  	u32 newsid;
>  	int rc;
>  
>  	if (strcmp(name, XATTR_SELINUX_SUFFIX))
>  		return -EOPNOTSUPP;
>  
> +	sbsec = selinux_superblock(inode->i_sb);
>  	if (!(sbsec->flags & SBLABEL_MNT))
>  		return -EOPNOTSUPP;
>  
> @@ -6882,6 +6868,7 @@ struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init = {
>  	.lbs_inode = sizeof(struct inode_security_struct),
>  	.lbs_ipc = sizeof(struct ipc_security_struct),
>  	.lbs_msg_msg = sizeof(struct msg_security_struct),
> +	.lbs_superblock = sizeof(struct superblock_security_struct),
>  };
>  
>  #ifdef CONFIG_PERF_EVENTS
> @@ -6982,7 +6969,6 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(bprm_committing_creds, selinux_bprm_committing_creds),
>  	LSM_HOOK_INIT(bprm_committed_creds, selinux_bprm_committed_creds),
>  
> -	LSM_HOOK_INIT(sb_free_security, selinux_sb_free_security),
>  	LSM_HOOK_INIT(sb_free_mnt_opts, selinux_free_mnt_opts),
>  	LSM_HOOK_INIT(sb_remount, selinux_sb_remount),
>  	LSM_HOOK_INIT(sb_kern_mount, selinux_sb_kern_mount),
> diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
> index ca4d7ab6a835..2953132408bf 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -188,4 +188,10 @@ static inline u32 current_sid(void)
>  	return tsec->sid;
>  }
>  
> +static inline struct superblock_security_struct *selinux_superblock(
> +					const struct super_block *superblock)
> +{
> +	return superblock->s_security + selinux_blob_sizes.lbs_superblock;
> +}
> +
>  #endif /* _SELINUX_OBJSEC_H_ */
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 597b79703584..74e3905dd9c5 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -47,6 +47,7 @@
>  #include <linux/sched.h>
>  #include <linux/audit.h>
>  #include <linux/vmalloc.h>
> +#include <linux/lsm_hooks.h>
>  #include <net/netlabel.h>
>  
>  #include "flask.h"
> @@ -2873,7 +2874,7 @@ int security_fs_use(struct selinux_state *state, struct super_block *sb)
>  	struct sidtab *sidtab;
>  	int rc = 0;
>  	struct ocontext *c;
> -	struct superblock_security_struct *sbsec = sb->s_security;
> +	struct superblock_security_struct *sbsec = selinux_superblock(sb);
>  	const char *fstype = sb->s_type->name;
>  
>  	if (!selinux_initialized(state)) {
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index a9768b12716b..7077b18c79ec 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -357,6 +357,12 @@ static inline struct smack_known **smack_ipc(const struct kern_ipc_perm *ipc)
>  	return ipc->security + smack_blob_sizes.lbs_ipc;
>  }
>  
> +static inline struct superblock_smack *smack_superblock(
> +					const struct super_block *superblock)
> +{
> +	return superblock->s_security + smack_blob_sizes.lbs_superblock;
> +}
> +
>  /*
>   * Is the directory transmuting?
>   */
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index f69c3dd9a0c6..767084dc2c29 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -535,12 +535,7 @@ static int smack_syslog(int typefrom_file)
>   */
>  static int smack_sb_alloc_security(struct super_block *sb)
>  {
> -	struct superblock_smack *sbsp;
> -
> -	sbsp = kzalloc(sizeof(struct superblock_smack), GFP_KERNEL);
> -
> -	if (sbsp == NULL)
> -		return -ENOMEM;
> +	struct superblock_smack *sbsp = smack_superblock(sb);
>  
>  	sbsp->smk_root = &smack_known_floor;
>  	sbsp->smk_default = &smack_known_floor;
> @@ -549,22 +544,10 @@ static int smack_sb_alloc_security(struct super_block *sb)
>  	/*
>  	 * SMK_SB_INITIALIZED will be zero from kzalloc.
>  	 */
> -	sb->s_security = sbsp;
>  
>  	return 0;
>  }
>  
> -/**
> - * smack_sb_free_security - free a superblock blob
> - * @sb: the superblock getting the blob
> - *
> - */
> -static void smack_sb_free_security(struct super_block *sb)
> -{
> -	kfree(sb->s_security);
> -	sb->s_security = NULL;
> -}
> -
>  struct smack_mnt_opts {
>  	const char *fsdefault, *fsfloor, *fshat, *fsroot, *fstransmute;
>  };
> @@ -772,7 +755,7 @@ static int smack_set_mnt_opts(struct super_block *sb,
>  {
>  	struct dentry *root = sb->s_root;
>  	struct inode *inode = d_backing_inode(root);
> -	struct superblock_smack *sp = sb->s_security;
> +	struct superblock_smack *sp = smack_superblock(sb);
>  	struct inode_smack *isp;
>  	struct smack_known *skp;
>  	struct smack_mnt_opts *opts = mnt_opts;
> @@ -871,7 +854,7 @@ static int smack_set_mnt_opts(struct super_block *sb,
>   */
>  static int smack_sb_statfs(struct dentry *dentry)
>  {
> -	struct superblock_smack *sbp = dentry->d_sb->s_security;
> +	struct superblock_smack *sbp = smack_superblock(dentry->d_sb);
>  	int rc;
>  	struct smk_audit_info ad;
>  
> @@ -905,7 +888,7 @@ static int smack_bprm_creds_for_exec(struct linux_binprm *bprm)
>  	if (isp->smk_task == NULL || isp->smk_task == bsp->smk_task)
>  		return 0;
>  
> -	sbsp = inode->i_sb->s_security;
> +	sbsp = smack_superblock(inode->i_sb);
>  	if ((sbsp->smk_flags & SMK_SB_UNTRUSTED) &&
>  	    isp->smk_task != sbsp->smk_root)
>  		return 0;
> @@ -1157,7 +1140,7 @@ static int smack_inode_rename(struct inode *old_inode,
>   */
>  static int smack_inode_permission(struct inode *inode, int mask)
>  {
> -	struct superblock_smack *sbsp = inode->i_sb->s_security;
> +	struct superblock_smack *sbsp = smack_superblock(inode->i_sb);
>  	struct smk_audit_info ad;
>  	int no_block = mask & MAY_NOT_BLOCK;
>  	int rc;
> @@ -1398,7 +1381,7 @@ static int smack_inode_removexattr(struct dentry *dentry, const char *name)
>  	 */
>  	if (strcmp(name, XATTR_NAME_SMACK) == 0) {
>  		struct super_block *sbp = dentry->d_sb;
> -		struct superblock_smack *sbsp = sbp->s_security;
> +		struct superblock_smack *sbsp = smack_superblock(sbp);
>  
>  		isp->smk_inode = sbsp->smk_default;
>  	} else if (strcmp(name, XATTR_NAME_SMACKEXEC) == 0)
> @@ -1668,7 +1651,7 @@ static int smack_mmap_file(struct file *file,
>  	isp = smack_inode(file_inode(file));
>  	if (isp->smk_mmap == NULL)
>  		return 0;
> -	sbsp = file_inode(file)->i_sb->s_security;
> +	sbsp = smack_superblock(file_inode(file)->i_sb);
>  	if (sbsp->smk_flags & SMK_SB_UNTRUSTED &&
>  	    isp->smk_mmap != sbsp->smk_root)
>  		return -EACCES;
> @@ -3283,7 +3266,7 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
>  		return;
>  
>  	sbp = inode->i_sb;
> -	sbsp = sbp->s_security;
> +	sbsp = smack_superblock(sbp);
>  	/*
>  	 * We're going to use the superblock default label
>  	 * if there's no label on the file.
> @@ -4696,6 +4679,7 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
>  	.lbs_inode = sizeof(struct inode_smack),
>  	.lbs_ipc = sizeof(struct smack_known *),
>  	.lbs_msg_msg = sizeof(struct smack_known *),
> +	.lbs_superblock = sizeof(struct superblock_smack),
>  };
>  
>  static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
> @@ -4707,7 +4691,6 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(fs_context_parse_param, smack_fs_context_parse_param),
>  
>  	LSM_HOOK_INIT(sb_alloc_security, smack_sb_alloc_security),
> -	LSM_HOOK_INIT(sb_free_security, smack_sb_free_security),
>  	LSM_HOOK_INIT(sb_free_mnt_opts, smack_free_mnt_opts),
>  	LSM_HOOK_INIT(sb_eat_lsm_opts, smack_sb_eat_lsm_opts),
>  	LSM_HOOK_INIT(sb_statfs, smack_sb_statfs),
> -- 
> 2.30.0

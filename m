Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6AA311205
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 21:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhBESae (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 13:30:34 -0500
Received: from mail.hallyn.com ([178.63.66.53]:53330 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233134AbhBEPND (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:13:03 -0500
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 30841283; Fri,  5 Feb 2021 08:21:43 -0600 (CST)
Date:   Fri, 5 Feb 2021 08:21:43 -0600
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
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>
Subject: Re: [PATCH v28 06/12] fs,security: Add sb_delete hook
Message-ID: <20210205142143.GA18451@mail.hallyn.com>
References: <20210202162710.657398-1-mic@digikod.net>
 <20210202162710.657398-7-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210202162710.657398-7-mic@digikod.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 02, 2021 at 05:27:04PM +0100, Mickaël Salaün wrote:
> From: Mickaël Salaün <mic@linux.microsoft.com>
> 
> The sb_delete security hook is called when shutting down a superblock,
> which may be useful to release kernel objects tied to the superblock's
> lifetime (e.g. inodes).
> 
> This new hook is needed by Landlock to release (ephemerally) tagged
> struct inodes.  This comes from the unprivileged nature of Landlock
> described in the next commit.
> 
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: James Morris <jmorris@namei.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Serge E. Hallyn <serge@hallyn.com>

One note below, but

Acked-by: Serge Hallyn <serge@hallyn.com>

> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
> Reviewed-by: Jann Horn <jannh@google.com>
> ---
> 
> Changes since v22:
> * Add Reviewed-by: Jann Horn <jannh@google.com>
> 
> Changes since v17:
> * Initial patch to replace the direct call to landlock_release_inodes()
>   (requested by James Morris).
>   https://lore.kernel.org/lkml/alpine.LRH.2.21.2005150536440.7929@namei.org/
> ---
>  fs/super.c                    | 1 +
>  include/linux/lsm_hook_defs.h | 1 +
>  include/linux/lsm_hooks.h     | 2 ++
>  include/linux/security.h      | 4 ++++
>  security/security.c           | 5 +++++
>  5 files changed, 13 insertions(+)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 2c6cdea2ab2d..c3c5178cde65 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -454,6 +454,7 @@ void generic_shutdown_super(struct super_block *sb)
>  		evict_inodes(sb);
>  		/* only nonzero refcount inodes can have marks */
>  		fsnotify_sb_delete(sb);
> +		security_sb_delete(sb);
>  
>  		if (sb->s_dio_done_wq) {
>  			destroy_workqueue(sb->s_dio_done_wq);
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 7aaa753b8608..32472b3849bc 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -59,6 +59,7 @@ LSM_HOOK(int, 0, fs_context_dup, struct fs_context *fc,
>  LSM_HOOK(int, -ENOPARAM, fs_context_parse_param, struct fs_context *fc,
>  	 struct fs_parameter *param)
>  LSM_HOOK(int, 0, sb_alloc_security, struct super_block *sb)
> +LSM_HOOK(void, LSM_RET_VOID, sb_delete, struct super_block *sb)
>  LSM_HOOK(void, LSM_RET_VOID, sb_free_security, struct super_block *sb)
>  LSM_HOOK(void, LSM_RET_VOID, sb_free_mnt_opts, void *mnt_opts)
>  LSM_HOOK(int, 0, sb_eat_lsm_opts, char *orig, void **mnt_opts)
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 970106d98306..e339b201f79b 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -108,6 +108,8 @@
>   *	allocated.
>   *	@sb contains the super_block structure to be modified.
>   *	Return 0 if operation was successful.
> + * @sb_delete:
> + *	Release objects tied to a superblock (e.g. inodes).

It's customary here to add the line detailing the @sb argument.

>   * @sb_free_security:
>   *	Deallocate and clear the sb->s_security field.
>   *	@sb contains the super_block structure to be modified.
> diff --git a/include/linux/security.h b/include/linux/security.h
> index c35ea0ffccd9..c41a94e29b62 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -288,6 +288,7 @@ void security_bprm_committed_creds(struct linux_binprm *bprm);
>  int security_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc);
>  int security_fs_context_parse_param(struct fs_context *fc, struct fs_parameter *param);
>  int security_sb_alloc(struct super_block *sb);
> +void security_sb_delete(struct super_block *sb);
>  void security_sb_free(struct super_block *sb);
>  void security_free_mnt_opts(void **mnt_opts);
>  int security_sb_eat_lsm_opts(char *options, void **mnt_opts);
> @@ -620,6 +621,9 @@ static inline int security_sb_alloc(struct super_block *sb)
>  	return 0;
>  }
>  
> +static inline void security_sb_delete(struct super_block *sb)
> +{ }
> +
>  static inline void security_sb_free(struct super_block *sb)
>  { }
>  
> diff --git a/security/security.c b/security/security.c
> index 9f979d4afe6c..1b4a73b2549a 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -900,6 +900,11 @@ int security_sb_alloc(struct super_block *sb)
>  	return rc;
>  }
>  
> +void security_sb_delete(struct super_block *sb)
> +{
> +	call_void_hook(sb_delete, sb);
> +}
> +
>  void security_sb_free(struct super_block *sb)
>  {
>  	call_void_hook(sb_free_security, sb);
> -- 
> 2.30.0

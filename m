Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53605B2CFB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 05:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiIIDhP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 23:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiIIDhM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 23:37:12 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E18F9FA9;
        Thu,  8 Sep 2022 20:37:09 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 573D93F3B3;
        Fri,  9 Sep 2022 03:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1662694628;
        bh=I9Pvh0sqIm2HlivSL7vW8JCwpG0/3MeBCV7NtQP/ma0=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=vQVDOQDd1SV7LScurmRQZ6etJUrr0TWHngGyPpctl98uMpR8o71QwpbkeRIzIkezI
         D/imwHwua41DBDXVr103DdPEPQeECNvZbqbBVE2nxWg+ekGTCxsP3XPN1EuT+u5EHc
         twX7j9ESAAZlzn2rXnlf+YBxvd/gCjnSo2y7rEalPg0j6ri0RWdK99da2j8eUEArhh
         RhSNBD6My0i+jvw2JbODyk5RYnivazsSHI11JhCcXab7j47qFiFZHXuxiCwXwexuR5
         76RwS+7iEvLnxnbSP24eKVf/YmCf1Ea0fuXedZmlsxPEIQEydi3pjPse0NNjzmqM+D
         b3SJ91ONzraXQ==
Message-ID: <7518c623-c067-8a2e-5ae9-4bc8cb865d7b@canonical.com>
Date:   Thu, 8 Sep 2022 20:37:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 1/5] security: create file_truncate hook from
 path_truncate hook
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        linux-security-module@vger.kernel.org
Cc:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
References: <20220908195805.128252-1-gnoack3000@gmail.com>
 <20220908195805.128252-2-gnoack3000@gmail.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20220908195805.128252-2-gnoack3000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/8/22 12:58, Günther Noack wrote:
> Like path_truncate, the file_truncate hook also restricts file
> truncation, but is called in the cases where truncation is attempted
> on an already-opened file.
> 
> This is required in a subsequent commit to handle ftruncate()
> operations differently to truncate() operations.
> 
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>

Acked-by: John Johansen <john.johansen@canonical.com>

> ---
>   fs/namei.c                    |  6 +++---
>   fs/open.c                     |  4 ++--
>   include/linux/lsm_hook_defs.h |  1 +
>   include/linux/security.h      |  6 ++++++
>   security/apparmor/lsm.c       |  6 ++++++
>   security/security.c           |  5 +++++
>   security/tomoyo/tomoyo.c      | 13 +++++++++++++
>   7 files changed, 36 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 53b4bc094db2..52105873d1f8 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -53,8 +53,8 @@
>    * The new code replaces the old recursive symlink resolution with
>    * an iterative one (in case of non-nested symlink chains).  It does
>    * this with calls to <fs>_follow_link().
> - * As a side effect, dir_namei(), _namei() and follow_link() are now
> - * replaced with a single function lookup_dentry() that can handle all
> + * As a side effect, dir_namei(), _namei() and follow_link() are now
> + * replaced with a single function lookup_dentry() that can handle all
>    * the special cases of the former code.
>    *
>    * With the new dcache, the pathname is stored at each inode, at least as
> @@ -3211,7 +3211,7 @@ static int handle_truncate(struct user_namespace *mnt_userns, struct file *filp)
>   	if (error)
>   		return error;
>   
> -	error = security_path_truncate(path);
> +	error = security_file_truncate(filp);
>   	if (!error) {
>   		error = do_truncate(mnt_userns, path->dentry, 0,
>   				    ATTR_MTIME|ATTR_CTIME|ATTR_OPEN,
> diff --git a/fs/open.c b/fs/open.c
> index 8a813fa5ca56..0831433e493a 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -188,7 +188,7 @@ long do_sys_ftruncate(unsigned int fd, loff_t length, int small)
>   	if (IS_APPEND(file_inode(f.file)))
>   		goto out_putf;
>   	sb_start_write(inode->i_sb);
> -	error = security_path_truncate(&f.file->f_path);
> +	error = security_file_truncate(f.file);
>   	if (!error)
>   		error = do_truncate(file_mnt_user_ns(f.file), dentry, length,
>   				    ATTR_MTIME | ATTR_CTIME, f.file);
> @@ -1271,7 +1271,7 @@ struct file *filp_open(const char *filename, int flags, umode_t mode)
>   {
>   	struct filename *name = getname_kernel(filename);
>   	struct file *file = ERR_CAST(name);
> -	
> +
>   	if (!IS_ERR(name)) {
>   		file = file_open_name(name, flags, mode);
>   		putname(name);
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 60fff133c0b1..dee35ab253ba 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -177,6 +177,7 @@ LSM_HOOK(int, 0, file_send_sigiotask, struct task_struct *tsk,
>   	 struct fown_struct *fown, int sig)
>   LSM_HOOK(int, 0, file_receive, struct file *file)
>   LSM_HOOK(int, 0, file_open, struct file *file)
> +LSM_HOOK(int, 0, file_truncate, struct file *file)
>   LSM_HOOK(int, 0, task_alloc, struct task_struct *task,
>   	 unsigned long clone_flags)
>   LSM_HOOK(void, LSM_RET_VOID, task_free, struct task_struct *task)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 7bd0c490703d..f80b23382dd9 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -394,6 +394,7 @@ int security_file_send_sigiotask(struct task_struct *tsk,
>   				 struct fown_struct *fown, int sig);
>   int security_file_receive(struct file *file);
>   int security_file_open(struct file *file);
> +int security_file_truncate(struct file *file);
>   int security_task_alloc(struct task_struct *task, unsigned long clone_flags);
>   void security_task_free(struct task_struct *task);
>   int security_cred_alloc_blank(struct cred *cred, gfp_t gfp);
> @@ -1011,6 +1012,11 @@ static inline int security_file_open(struct file *file)
>   	return 0;
>   }
>   
> +static inline int security_file_truncate(struct file *file)
> +{
> +	return 0;
> +}
> +
>   static inline int security_task_alloc(struct task_struct *task,
>   				      unsigned long clone_flags)
>   {
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index e29cade7b662..98ecb7f221b8 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -329,6 +329,11 @@ static int apparmor_path_truncate(const struct path *path)
>   	return common_perm_cond(OP_TRUNC, path, MAY_WRITE | AA_MAY_SETATTR);
>   }
>   
> +static int apparmor_file_truncate(struct file *file)
> +{
> +	return apparmor_path_truncate(&file->f_path);
> +}
> +
>   static int apparmor_path_symlink(const struct path *dir, struct dentry *dentry,
>   				 const char *old_name)
>   {
> @@ -1232,6 +1237,7 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(mmap_file, apparmor_mmap_file),
>   	LSM_HOOK_INIT(file_mprotect, apparmor_file_mprotect),
>   	LSM_HOOK_INIT(file_lock, apparmor_file_lock),
> +	LSM_HOOK_INIT(file_truncate, apparmor_file_truncate),
>   
>   	LSM_HOOK_INIT(getprocattr, apparmor_getprocattr),
>   	LSM_HOOK_INIT(setprocattr, apparmor_setprocattr),
> diff --git a/security/security.c b/security/security.c
> index 4b95de24bc8d..e491120c48ba 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1210,6 +1210,11 @@ int security_path_truncate(const struct path *path)
>   	return call_int_hook(path_truncate, 0, path);
>   }
>   
> +int security_file_truncate(struct file *file)
> +{
> +	return call_int_hook(file_truncate, 0, file);
> +}
> +
>   int security_path_chmod(const struct path *path, umode_t mode)
>   {
>   	if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
> diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
> index 71e82d855ebf..af04a7b7eb28 100644
> --- a/security/tomoyo/tomoyo.c
> +++ b/security/tomoyo/tomoyo.c
> @@ -134,6 +134,18 @@ static int tomoyo_path_truncate(const struct path *path)
>   	return tomoyo_path_perm(TOMOYO_TYPE_TRUNCATE, path, NULL);
>   }
>   
> +/**
> + * tomoyo_file_truncate - Target for security_file_truncate().
> + *
> + * @file: Pointer to "struct file".
> + *
> + * Returns 0 on success, negative value otherwise.
> + */
> +static int tomoyo_file_truncate(struct file *file)
> +{
> +	return tomoyo_path_truncate(&file->f_path);
> +}
> +
>   /**
>    * tomoyo_path_unlink - Target for security_path_unlink().
>    *
> @@ -545,6 +557,7 @@ static struct security_hook_list tomoyo_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(bprm_check_security, tomoyo_bprm_check_security),
>   	LSM_HOOK_INIT(file_fcntl, tomoyo_file_fcntl),
>   	LSM_HOOK_INIT(file_open, tomoyo_file_open),
> +	LSM_HOOK_INIT(file_truncate, tomoyo_file_truncate),
>   	LSM_HOOK_INIT(path_truncate, tomoyo_path_truncate),
>   	LSM_HOOK_INIT(path_unlink, tomoyo_path_unlink),
>   	LSM_HOOK_INIT(path_mkdir, tomoyo_path_mkdir),


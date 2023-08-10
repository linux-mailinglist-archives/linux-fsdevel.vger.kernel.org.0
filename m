Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D021C777CD7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 17:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjHJPzF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 11:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233933AbjHJPzD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:55:03 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B67426B9;
        Thu, 10 Aug 2023 08:55:02 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.47.134.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 6FC853F5DF;
        Thu, 10 Aug 2023 15:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691682901;
        bh=c1aYbWxZodJUGn7+nYKv5vHAURIePOx4+fQCHOTMfEA=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Gt5ROF+U4z88tTfPUEjl6ZqKBDav7LO5RJRQWHBeZwbPzqjV4SHSE6LMS3A//8TPJ
         dWctXIB+m4xbSvU2SLKRhj5IHOX8LtDfHS4YsZBdPO8SKKMC11Z2qKmhhGthw6D/eW
         EDUPxyLJ8RYNfxiLYZClrYSXYepKFmooLRAtTk9OH7baHAJoYdiVYbp92EWYwHlHMi
         mAmWSeRKjlNuOCelW+Y6rIRjTcWFmWH8M5zeWYTZ5uLp4yefX0dFyfqI5/yNezh9Qh
         h808X4bPkXVB7D+GaIF9i53P20m4d6+OMQqJqvbWQOCmVVywr/GnwZzmCrsi6PocTD
         Wfy3/D3CO7jvQ==
Message-ID: <df6161f0-e91c-0e86-6c80-041bbfcba704@canonical.com>
Date:   Thu, 10 Aug 2023 08:54:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v13 03/11] proc: Use lsmids instead of lsm names for attrs
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net, linux-fsdevel@vger.kernel.org
References: <20230802174435.11928-1-casey@schaufler-ca.com>
 <20230802174435.11928-4-casey@schaufler-ca.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20230802174435.11928-4-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/2/23 10:44, Casey Schaufler wrote:
> Use the LSM ID number instead of the LSM name to identify which
> security module's attibute data should be shown in /proc/self/attr.
> The security_[gs]etprocattr() functions have been changed to expect
> the LSM ID. The change from a string comparison to an integer comparison
> in these functions will provide a minor performance improvement.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
> Reviewed-by: Mickael Salaun <mic@digikod.net>
> Cc: linux-fsdevel@vger.kernel.org

Reviewed-by: John Johansen <john.johansen@canonical.com>


> ---
>   fs/proc/base.c           | 29 +++++++++++++++--------------
>   fs/proc/internal.h       |  2 +-
>   include/linux/security.h | 11 +++++------
>   security/security.c      | 15 +++++++--------
>   4 files changed, 28 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 05452c3b9872..f999bb5c497b 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -97,6 +97,7 @@
>   #include <linux/resctrl.h>
>   #include <linux/cn_proc.h>
>   #include <linux/ksm.h>
> +#include <uapi/linux/lsm.h>
>   #include <trace/events/oom.h>
>   #include "internal.h"
>   #include "fd.h"
> @@ -146,10 +147,10 @@ struct pid_entry {
>   	NOD(NAME, (S_IFREG|(MODE)),			\
>   		NULL, &proc_single_file_operations,	\
>   		{ .proc_show = show } )
> -#define ATTR(LSM, NAME, MODE)				\
> +#define ATTR(LSMID, NAME, MODE)				\
>   	NOD(NAME, (S_IFREG|(MODE)),			\
>   		NULL, &proc_pid_attr_operations,	\
> -		{ .lsm = LSM })
> +		{ .lsmid = LSMID })
>   
>   /*
>    * Count the number of hardlinks for the pid_entry table, excluding the .
> @@ -2730,7 +2731,7 @@ static ssize_t proc_pid_attr_read(struct file * file, char __user * buf,
>   	if (!task)
>   		return -ESRCH;
>   
> -	length = security_getprocattr(task, PROC_I(inode)->op.lsm,
> +	length = security_getprocattr(task, PROC_I(inode)->op.lsmid,
>   				      file->f_path.dentry->d_name.name,
>   				      &p);
>   	put_task_struct(task);
> @@ -2788,7 +2789,7 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
>   	if (rv < 0)
>   		goto out_free;
>   
> -	rv = security_setprocattr(PROC_I(inode)->op.lsm,
> +	rv = security_setprocattr(PROC_I(inode)->op.lsmid,
>   				  file->f_path.dentry->d_name.name, page,
>   				  count);
>   	mutex_unlock(&current->signal->cred_guard_mutex);
> @@ -2837,27 +2838,27 @@ static const struct inode_operations proc_##LSM##_attr_dir_inode_ops = { \
>   
>   #ifdef CONFIG_SECURITY_SMACK
>   static const struct pid_entry smack_attr_dir_stuff[] = {
> -	ATTR("smack", "current",	0666),
> +	ATTR(LSM_ID_SMACK, "current",	0666),
>   };
>   LSM_DIR_OPS(smack);
>   #endif
>   
>   #ifdef CONFIG_SECURITY_APPARMOR
>   static const struct pid_entry apparmor_attr_dir_stuff[] = {
> -	ATTR("apparmor", "current",	0666),
> -	ATTR("apparmor", "prev",	0444),
> -	ATTR("apparmor", "exec",	0666),
> +	ATTR(LSM_ID_APPARMOR, "current",	0666),
> +	ATTR(LSM_ID_APPARMOR, "prev",		0444),
> +	ATTR(LSM_ID_APPARMOR, "exec",		0666),
>   };
>   LSM_DIR_OPS(apparmor);
>   #endif
>   
>   static const struct pid_entry attr_dir_stuff[] = {
> -	ATTR(NULL, "current",		0666),
> -	ATTR(NULL, "prev",		0444),
> -	ATTR(NULL, "exec",		0666),
> -	ATTR(NULL, "fscreate",		0666),
> -	ATTR(NULL, "keycreate",		0666),
> -	ATTR(NULL, "sockcreate",	0666),
> +	ATTR(LSM_ID_UNDEF, "current",	0666),
> +	ATTR(LSM_ID_UNDEF, "prev",		0444),
> +	ATTR(LSM_ID_UNDEF, "exec",		0666),
> +	ATTR(LSM_ID_UNDEF, "fscreate",	0666),
> +	ATTR(LSM_ID_UNDEF, "keycreate",	0666),
> +	ATTR(LSM_ID_UNDEF, "sockcreate",	0666),
>   #ifdef CONFIG_SECURITY_SMACK
>   	DIR("smack",			0555,
>   	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> index 9dda7e54b2d0..a889d9ef9584 100644
> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -92,7 +92,7 @@ union proc_op {
>   	int (*proc_show)(struct seq_file *m,
>   		struct pid_namespace *ns, struct pid *pid,
>   		struct task_struct *task);
> -	const char *lsm;
> +	int lsmid;
>   };
>   
>   struct proc_inode {
> diff --git a/include/linux/security.h b/include/linux/security.h
> index a20a4ceda6d9..b5fd3f7f4cd3 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -470,10 +470,9 @@ int security_sem_semctl(struct kern_ipc_perm *sma, int cmd);
>   int security_sem_semop(struct kern_ipc_perm *sma, struct sembuf *sops,
>   			unsigned nsops, int alter);
>   void security_d_instantiate(struct dentry *dentry, struct inode *inode);
> -int security_getprocattr(struct task_struct *p, const char *lsm, const char *name,
> +int security_getprocattr(struct task_struct *p, int lsmid, const char *name,
>   			 char **value);
> -int security_setprocattr(const char *lsm, const char *name, void *value,
> -			 size_t size);
> +int security_setprocattr(int lsmid, const char *name, void *value, size_t size);
>   int security_netlink_send(struct sock *sk, struct sk_buff *skb);
>   int security_ismaclabel(const char *name);
>   int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
> @@ -1332,14 +1331,14 @@ static inline void security_d_instantiate(struct dentry *dentry,
>   					  struct inode *inode)
>   { }
>   
> -static inline int security_getprocattr(struct task_struct *p, const char *lsm,
> +static inline int security_getprocattr(struct task_struct *p, int lsmid,
>   				       const char *name, char **value)
>   {
>   	return -EINVAL;
>   }
>   
> -static inline int security_setprocattr(const char *lsm, char *name,
> -				       void *value, size_t size)
> +static inline int security_setprocattr(int lsmid, char *name, void *value,
> +				       size_t size)
>   {
>   	return -EINVAL;
>   }
> diff --git a/security/security.c b/security/security.c
> index 87b70a55a028..5e9cd548dd95 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -3801,7 +3801,7 @@ EXPORT_SYMBOL(security_d_instantiate);
>   /**
>    * security_getprocattr() - Read an attribute for a task
>    * @p: the task
> - * @lsm: LSM name
> + * @lsmid: LSM identification
>    * @name: attribute name
>    * @value: attribute value
>    *
> @@ -3809,13 +3809,13 @@ EXPORT_SYMBOL(security_d_instantiate);
>    *
>    * Return: Returns the length of @value on success, a negative value otherwise.
>    */
> -int security_getprocattr(struct task_struct *p, const char *lsm,
> -			 const char *name, char **value)
> +int security_getprocattr(struct task_struct *p, int lsmid, const char *name,
> +			 char **value)
>   {
>   	struct security_hook_list *hp;
>   
>   	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
> -		if (lsm != NULL && strcmp(lsm, hp->lsmid->name))
> +		if (lsmid != 0 && lsmid != hp->lsmid->id)
>   			continue;
>   		return hp->hook.getprocattr(p, name, value);
>   	}
> @@ -3824,7 +3824,7 @@ int security_getprocattr(struct task_struct *p, const char *lsm,
>   
>   /**
>    * security_setprocattr() - Set an attribute for a task
> - * @lsm: LSM name
> + * @lsmid: LSM identification
>    * @name: attribute name
>    * @value: attribute value
>    * @size: attribute value size
> @@ -3834,13 +3834,12 @@ int security_getprocattr(struct task_struct *p, const char *lsm,
>    *
>    * Return: Returns bytes written on success, a negative value otherwise.
>    */
> -int security_setprocattr(const char *lsm, const char *name, void *value,
> -			 size_t size)
> +int security_setprocattr(int lsmid, const char *name, void *value, size_t size)
>   {
>   	struct security_hook_list *hp;
>   
>   	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
> -		if (lsm != NULL && strcmp(lsm, hp->lsmid->name))
> +		if (lsmid != 0 && lsmid != hp->lsmid->id)
>   			continue;
>   		return hp->hook.setprocattr(name, value, size);
>   	}


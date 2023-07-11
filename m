Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5257E74F3A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 17:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbjGKPgr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 11:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbjGKPgN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:36:13 -0400
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [IPv6:2001:1600:3:17::8fa9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506B91711
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jul 2023 08:36:05 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4R0lMR2ptWzMqPNh;
        Tue, 11 Jul 2023 15:36:03 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4R0lMQ2NDgz7c7;
        Tue, 11 Jul 2023 17:36:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1689089763;
        bh=PWURGYRuHISzTiSalmUSLUcYsg4A7DqCIVPScz344JY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SHXQgkQ2l4Z2F0mX3qPLGfKADm9kawDWiRbZA/Rqg9HwHvW287D5A66a1uJAieSkd
         MiejnSe9DEQ9ERlJdr+V624h2j2VvWqp89ngm5Z0agPteFrZJjPD2PBiA7/8DraewE
         HFKXqmo8XRlfn/EPsDkZijjTHnGMqIndzzR0d0Xk=
Message-ID: <a426acc5-87e8-265c-4b63-393683f3cdeb@digikod.net>
Date:   Tue, 11 Jul 2023 17:36:01 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v12 03/11] proc: Use lsmids instead of lsm names for attrs
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20230629195535.2590-1-casey@schaufler-ca.com>
 <20230629195535.2590-4-casey@schaufler-ca.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20230629195535.2590-4-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 29/06/2023 21:55, Casey Schaufler wrote:
> Use the LSM ID number instead of the LSM name to identify which
> security module's attibute data should be shown in /proc/self/attr.
> The security_[gs]etprocattr() functions have been changed to expect
> the LSM ID. The change from a string comparison to an integer comparison
> in these functions will provide a minor performance improvement.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
> Cc: linux-fsdevel@vger.kernel.org

Reviewed-by: Mickaël Salaün <mic@digikod.net>

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
> index 569b1d8ab002..945101b0d404 100644
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
> index 5a699e47478b..d942b0c8e32f 100644
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

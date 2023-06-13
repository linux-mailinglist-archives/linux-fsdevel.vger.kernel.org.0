Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D2B72EB10
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 20:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjFMSfe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 14:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbjFMSfb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 14:35:31 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4902DB3;
        Tue, 13 Jun 2023 11:35:28 -0700 (PDT)
Received: from jerom (99-112-204-245.lightspeed.hstntx.sbcglobal.net [99.112.204.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: serge)
        by mail.hallyn.com (Postfix) with ESMTPSA id 9B9FF7BD;
        Tue, 13 Jun 2023 13:35:23 -0500 (CDT)
Date:   Tue, 13 Jun 2023 13:35:11 -0500
From:   Serge Hallyn <serge@hallyn.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v10 03/11] proc: Use lsmids instead of lsm names for attrs
Message-ID: <ZIi2utcInNAbRfPu@jerom>
References: <20230428203417.159874-1-casey@schaufler-ca.com>
 <20230428203417.159874-4-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428203417.159874-4-casey@schaufler-ca.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 28, 2023 at 01:34:09PM -0700, Casey Schaufler wrote:
> Use the LSM ID number instead of the LSM name to identify which
> security module's attibute data should be shown in /proc/self/attr.
> The security_[gs]etprocattr() functions have been changed to expect
> the LSM ID. The change from a string comparison to an integer comparison
> in these functions will provide a minor performance improvement.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

for patches 1-3,

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> Cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/proc/base.c           | 29 +++++++++++++++--------------
>  fs/proc/internal.h       |  2 +-
>  include/linux/security.h | 11 +++++------
>  security/security.c      | 11 +++++------
>  4 files changed, 26 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 5e0e0ccd47aa..cb6dec7473fe 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -96,6 +96,7 @@
>  #include <linux/time_namespace.h>
>  #include <linux/resctrl.h>
>  #include <linux/cn_proc.h>
> +#include <uapi/linux/lsm.h>
>  #include <trace/events/oom.h>
>  #include "internal.h"
>  #include "fd.h"
> @@ -145,10 +146,10 @@ struct pid_entry {
>  	NOD(NAME, (S_IFREG|(MODE)),			\
>  		NULL, &proc_single_file_operations,	\
>  		{ .proc_show = show } )
> -#define ATTR(LSM, NAME, MODE)				\
> +#define ATTR(LSMID, NAME, MODE)				\
>  	NOD(NAME, (S_IFREG|(MODE)),			\
>  		NULL, &proc_pid_attr_operations,	\
> -		{ .lsm = LSM })
> +		{ .lsmid = LSMID })
>  
>  /*
>   * Count the number of hardlinks for the pid_entry table, excluding the .
> @@ -2730,7 +2731,7 @@ static ssize_t proc_pid_attr_read(struct file * file, char __user * buf,
>  	if (!task)
>  		return -ESRCH;
>  
> -	length = security_getprocattr(task, PROC_I(inode)->op.lsm,
> +	length = security_getprocattr(task, PROC_I(inode)->op.lsmid,
>  				      file->f_path.dentry->d_name.name,
>  				      &p);
>  	put_task_struct(task);
> @@ -2788,7 +2789,7 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
>  	if (rv < 0)
>  		goto out_free;
>  
> -	rv = security_setprocattr(PROC_I(inode)->op.lsm,
> +	rv = security_setprocattr(PROC_I(inode)->op.lsmid,
>  				  file->f_path.dentry->d_name.name, page,
>  				  count);
>  	mutex_unlock(&current->signal->cred_guard_mutex);
> @@ -2837,27 +2838,27 @@ static const struct inode_operations proc_##LSM##_attr_dir_inode_ops = { \
>  
>  #ifdef CONFIG_SECURITY_SMACK
>  static const struct pid_entry smack_attr_dir_stuff[] = {
> -	ATTR("smack", "current",	0666),
> +	ATTR(LSM_ID_SMACK, "current",	0666),
>  };
>  LSM_DIR_OPS(smack);
>  #endif
>  
>  #ifdef CONFIG_SECURITY_APPARMOR
>  static const struct pid_entry apparmor_attr_dir_stuff[] = {
> -	ATTR("apparmor", "current",	0666),
> -	ATTR("apparmor", "prev",	0444),
> -	ATTR("apparmor", "exec",	0666),
> +	ATTR(LSM_ID_APPARMOR, "current",	0666),
> +	ATTR(LSM_ID_APPARMOR, "prev",		0444),
> +	ATTR(LSM_ID_APPARMOR, "exec",		0666),
>  };
>  LSM_DIR_OPS(apparmor);
>  #endif
>  
>  static const struct pid_entry attr_dir_stuff[] = {
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
>  #ifdef CONFIG_SECURITY_SMACK
>  	DIR("smack",			0555,
>  	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> index 9dda7e54b2d0..a889d9ef9584 100644
> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -92,7 +92,7 @@ union proc_op {
>  	int (*proc_show)(struct seq_file *m,
>  		struct pid_namespace *ns, struct pid *pid,
>  		struct task_struct *task);
> -	const char *lsm;
> +	int lsmid;
>  };
>  
>  struct proc_inode {
> diff --git a/include/linux/security.h b/include/linux/security.h
> index e70fc863b04a..8faed81fc3b4 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -473,10 +473,9 @@ int security_sem_semctl(struct kern_ipc_perm *sma, int cmd);
>  int security_sem_semop(struct kern_ipc_perm *sma, struct sembuf *sops,
>  			unsigned nsops, int alter);
>  void security_d_instantiate(struct dentry *dentry, struct inode *inode);
> -int security_getprocattr(struct task_struct *p, const char *lsm, const char *name,
> +int security_getprocattr(struct task_struct *p, int lsmid, const char *name,
>  			 char **value);
> -int security_setprocattr(const char *lsm, const char *name, void *value,
> -			 size_t size);
> +int security_setprocattr(int lsmid, const char *name, void *value, size_t size);
>  int security_netlink_send(struct sock *sk, struct sk_buff *skb);
>  int security_ismaclabel(const char *name);
>  int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
> @@ -1344,14 +1343,14 @@ static inline void security_d_instantiate(struct dentry *dentry,
>  					  struct inode *inode)
>  { }
>  
> -static inline int security_getprocattr(struct task_struct *p, const char *lsm,
> +static inline int security_getprocattr(struct task_struct *p, int lsmid,
>  				       const char *name, char **value)
>  {
>  	return -EINVAL;
>  }
>  
> -static inline int security_setprocattr(const char *lsm, char *name,
> -				       void *value, size_t size)
> +static inline int security_setprocattr(int lsmid, char *name, void *value,
> +				       size_t size)
>  {
>  	return -EINVAL;
>  }
> diff --git a/security/security.c b/security/security.c
> index e390001a32c9..5a48b1b539e5 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2176,26 +2176,25 @@ void security_d_instantiate(struct dentry *dentry, struct inode *inode)
>  }
>  EXPORT_SYMBOL(security_d_instantiate);
>  
> -int security_getprocattr(struct task_struct *p, const char *lsm,
> -			 const char *name, char **value)
> +int security_getprocattr(struct task_struct *p, int lsmid, const char *name,
> +			 char **value)
>  {
>  	struct security_hook_list *hp;
>  
>  	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
> -		if (lsm != NULL && strcmp(lsm, hp->lsmid->name))
> +		if (lsmid != 0 && lsmid != hp->lsmid->id)
>  			continue;
>  		return hp->hook.getprocattr(p, name, value);
>  	}
>  	return LSM_RET_DEFAULT(getprocattr);
>  }
>  
> -int security_setprocattr(const char *lsm, const char *name, void *value,
> -			 size_t size)
> +int security_setprocattr(int lsmid, const char *name, void *value, size_t size)
>  {
>  	struct security_hook_list *hp;
>  
>  	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
> -		if (lsm != NULL && strcmp(lsm, hp->lsmid->name))
> +		if (lsmid != 0 && lsmid != hp->lsmid->id)
>  			continue;
>  		return hp->hook.setprocattr(name, value, size);
>  	}
> -- 
> 2.39.2
> 

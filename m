Return-Path: <linux-fsdevel+bounces-19741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AAC8C9849
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 05:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C9791C218F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 03:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5906A10958;
	Mon, 20 May 2024 03:31:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C185107A9;
	Mon, 20 May 2024 03:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716175869; cv=none; b=qeJSj7sH+3BkZRwwjSevhvK/+/+b6lm4GZmV16VzvHYWaErd0tJ5fIqU1m0qZVWNpAOZlRvu+AOB0dtgCbsdR1founw69UNtRYALxuWb+K2EPdOV8F1IMIcoi5r3A05HksO3Tx2jLtz8XUUrW+E2njRxILuerETbsITWlAmFy0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716175869; c=relaxed/simple;
	bh=bWi6GM1ZjfN+LLbqPY6EwmWWTad8t0Sg2YE6Pjjdm7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXi+paxHgq4evF2VLJcL8Z4XvYFHtPkqSZu4wheWh2gtjYf3OBzZ2ZWo3co3w4px2F6cmES1p86MB2jsVCyjXiMZbT1hKY+SrwIOJfPCs8t7+dlm5/g6BooS68UGxEzsTLuXUkWTmhsygkYsB/7f73oDAqZaGKpOdkUfVTLiHxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 94ABE46C; Sun, 19 May 2024 22:30:58 -0500 (CDT)
Date: Sun, 19 May 2024 22:30:58 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Jonathan Calmels <jcalmels@3xx0.net>
Cc: brauner@kernel.org, ebiederm@xmission.com,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>, containers@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Subject: Re: [PATCH 1/3] capabilities: user namespace capabilities
Message-ID: <20240520033058.GA1815759@mail.hallyn.com>
References: <20240516092213.6799-1-jcalmels@3xx0.net>
 <20240516092213.6799-2-jcalmels@3xx0.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240516092213.6799-2-jcalmels@3xx0.net>

On Thu, May 16, 2024 at 02:22:03AM -0700, Jonathan Calmels wrote:
> Attackers often rely on user namespaces to get elevated (yet confined)
> privileges in order to target specific subsystems (e.g. [1]). Distributions
> have been pretty adamant that they need a way to configure these, most of
> them carry out-of-tree patches to do so, or plainly refuse to enable them.
> As a result, there have been multiple efforts over the years to introduce
> various knobs to control and/or disable user namespaces (e.g. [2][3][4]).
> 
> While we acknowledge that there are already ways to control the creation of
> such namespaces (the most recent being a LSM hook), there are inherent
> issues with these approaches. Preventing the user namespace creation is not
> fine-grained enough, and in some cases, incompatible with various userspace
> expectations (e.g. container runtimes, browser sandboxing, service
> isolation)
> 
> This patch addresses these limitations by introducing an additional
> capability set used to restrict the permissions granted when creating user
> namespaces. This way, processes can apply the principle of least privilege
> by configuring only the capabilities they need for their namespaces.
> 
> For compatibility reasons, processes always start with a full userns
> capability set.
> 
> On namespace creation, the userns capability set (pU) is assigned to the
> new effective (pE), permitted (pP) and bounding set (X) of the task:
> 
>     pU = pE = pP = X
> 
> The userns capability set obeys the invariant that no bit can ever be set
> if it is not already part of the task’s bounding set. This ensures that no
> namespace can ever gain more privileges than its predecessors.
> Additionally, if a task is not privileged over CAP_SETPCAP, setting any bit
> in the userns set requires its corresponding bit to be set in the permitted
> set. This effectively mimics the inheritable set rules and means that, by
> default, only root in the initial user namespace can gain userns
> capabilities:
> 
>     p’U = (pE & CAP_SETPCAP) ? X : (X & pP)
> 
> Note that since userns capabilities are strictly hierarchical, policies can
> be enforced at various levels (e.g. init, pam_cap) and inherited by every
> child namespace.
> 
> Here is a sample program that can be used to verify the functionality:
> 
> /*
>  * Test program that drops CAP_SYS_RAWIO from subsequent user namespaces.
>  *
>  * ./cap_userns_test unshare -r grep Cap /proc/self/status
>  * CapInh: 0000000000000000
>  * CapPrm: 000001fffffdffff
>  * CapEff: 000001fffffdffff
>  * CapBnd: 000001fffffdffff
>  * CapAmb: 0000000000000000
>  * CapUNs: 000001fffffdffff
>  */
> 
> int main(int argc, char *argv[])
> {
>         if (prctl(PR_CAP_USERNS, PR_CAP_USERNS_LOWER, CAP_SYS_RAWIO, 0, 0) < 0)
>                 err(1, "cannot drop userns cap");
> 
>         execvp(argv[1], argv + 1);
>         err(1, "cannot exec");
> }
> 
> Link: https://security.googleblog.com/2023/06/learnings-from-kctf-vrps-42-linux.html
> Link: https://lore.kernel.org/lkml/1453502345-30416-1-git-send-email-keescook@chromium.org
> Link: https://lore.kernel.org/lkml/20220815162028.926858-1-fred@cloudflare.com
> Link: https://lore.kernel.org/containers/168547265011.24337.4306067683997517082-0@git.sr.ht
> 
> Signed-off-by: Jonathan Calmels <jcalmels@3xx0.net>

Thanks! Of course we'llnsee how the conversations fall out, but

Reviewed-by: Serge Hallyn <serge@hallyn.com>


> ---
>  fs/proc/array.c              |  9 ++++++
>  include/linux/cred.h         |  3 ++
>  include/uapi/linux/prctl.h   |  7 +++++
>  kernel/cred.c                |  3 ++
>  kernel/umh.c                 | 16 ++++++++++
>  kernel/user_namespace.c      | 12 +++-----
>  security/commoncap.c         | 59 ++++++++++++++++++++++++++++++++++++
>  security/keys/process_keys.c |  3 ++
>  8 files changed, 105 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/proc/array.c b/fs/proc/array.c
> index 34a47fb0c57f..364e8bb19f9d 100644
> --- a/fs/proc/array.c
> +++ b/fs/proc/array.c
> @@ -313,6 +313,9 @@ static inline void task_cap(struct seq_file *m, struct task_struct *p)
>  	const struct cred *cred;
>  	kernel_cap_t cap_inheritable, cap_permitted, cap_effective,
>  			cap_bset, cap_ambient;
> +#ifdef CONFIG_USER_NS
> +	kernel_cap_t cap_userns;
> +#endif
>  
>  	rcu_read_lock();
>  	cred = __task_cred(p);
> @@ -321,6 +324,9 @@ static inline void task_cap(struct seq_file *m, struct task_struct *p)
>  	cap_effective	= cred->cap_effective;
>  	cap_bset	= cred->cap_bset;
>  	cap_ambient	= cred->cap_ambient;
> +#ifdef CONFIG_USER_NS
> +	cap_userns	= cred->cap_userns;
> +#endif
>  	rcu_read_unlock();
>  
>  	render_cap_t(m, "CapInh:\t", &cap_inheritable);
> @@ -328,6 +334,9 @@ static inline void task_cap(struct seq_file *m, struct task_struct *p)
>  	render_cap_t(m, "CapEff:\t", &cap_effective);
>  	render_cap_t(m, "CapBnd:\t", &cap_bset);
>  	render_cap_t(m, "CapAmb:\t", &cap_ambient);
> +#ifdef CONFIG_USER_NS
> +	render_cap_t(m, "CapUNs:\t", &cap_userns);
> +#endif
>  }
>  
>  static inline void task_seccomp(struct seq_file *m, struct task_struct *p)
> diff --git a/include/linux/cred.h b/include/linux/cred.h
> index 2976f534a7a3..adab0031443e 100644
> --- a/include/linux/cred.h
> +++ b/include/linux/cred.h
> @@ -124,6 +124,9 @@ struct cred {
>  	kernel_cap_t	cap_effective;	/* caps we can actually use */
>  	kernel_cap_t	cap_bset;	/* capability bounding set */
>  	kernel_cap_t	cap_ambient;	/* Ambient capability set */
> +#ifdef CONFIG_USER_NS
> +	kernel_cap_t	cap_userns;	/* User namespace capability set */
> +#endif
>  #ifdef CONFIG_KEYS
>  	unsigned char	jit_keyring;	/* default keyring to attach requested
>  					 * keys to */
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 370ed14b1ae0..e09475171f62 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -198,6 +198,13 @@ struct prctl_mm_map {
>  # define PR_CAP_AMBIENT_LOWER		3
>  # define PR_CAP_AMBIENT_CLEAR_ALL	4
>  
> +/* Control the userns capability set */
> +#define PR_CAP_USERNS			48
> +# define PR_CAP_USERNS_IS_SET		1
> +# define PR_CAP_USERNS_RAISE		2
> +# define PR_CAP_USERNS_LOWER		3
> +# define PR_CAP_USERNS_CLEAR_ALL	4
> +
>  /* arm64 Scalable Vector Extension controls */
>  /* Flag values must be kept in sync with ptrace NT_ARM_SVE interface */
>  #define PR_SVE_SET_VL			50	/* set task vector length */
> diff --git a/kernel/cred.c b/kernel/cred.c
> index 075cfa7c896f..9912c6f3bc6b 100644
> --- a/kernel/cred.c
> +++ b/kernel/cred.c
> @@ -56,6 +56,9 @@ struct cred init_cred = {
>  	.cap_permitted		= CAP_FULL_SET,
>  	.cap_effective		= CAP_FULL_SET,
>  	.cap_bset		= CAP_FULL_SET,
> +#ifdef CONFIG_USER_NS
> +	.cap_userns		= CAP_FULL_SET,
> +#endif
>  	.user			= INIT_USER,
>  	.user_ns		= &init_user_ns,
>  	.group_info		= &init_groups,
> diff --git a/kernel/umh.c b/kernel/umh.c
> index 1b13c5d34624..51f1e1d25d49 100644
> --- a/kernel/umh.c
> +++ b/kernel/umh.c
> @@ -32,6 +32,9 @@
>  
>  #include <trace/events/module.h>
>  
> +#ifdef CONFIG_USER_NS
> +static kernel_cap_t usermodehelper_userns = CAP_FULL_SET;
> +#endif
>  static kernel_cap_t usermodehelper_bset = CAP_FULL_SET;
>  static kernel_cap_t usermodehelper_inheritable = CAP_FULL_SET;
>  static DEFINE_SPINLOCK(umh_sysctl_lock);
> @@ -94,6 +97,10 @@ static int call_usermodehelper_exec_async(void *data)
>  	new->cap_bset = cap_intersect(usermodehelper_bset, new->cap_bset);
>  	new->cap_inheritable = cap_intersect(usermodehelper_inheritable,
>  					     new->cap_inheritable);
> +#ifdef CONFIG_USER_NS
> +	new->cap_userns = cap_intersect(usermodehelper_userns,
> +					new->cap_userns);
> +#endif
>  	spin_unlock(&umh_sysctl_lock);
>  
>  	if (sub_info->init) {
> @@ -560,6 +567,15 @@ static struct ctl_table usermodehelper_table[] = {
>  		.mode		= 0600,
>  		.proc_handler	= proc_cap_handler,
>  	},
> +#ifdef CONFIG_USER_NS
> +	{
> +		.procname	= "userns",
> +		.data		= &usermodehelper_userns,
> +		.maxlen		= 2 * sizeof(unsigned long),
> +		.mode		= 0600,
> +		.proc_handler	= proc_cap_handler,
> +	},
> +#endif
>  	{ }
>  };
>  
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index 0b0b95418b16..7e624607330b 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -42,15 +42,13 @@ static void dec_user_namespaces(struct ucounts *ucounts)
>  
>  static void set_cred_user_ns(struct cred *cred, struct user_namespace *user_ns)
>  {
> -	/* Start with the same capabilities as init but useless for doing
> -	 * anything as the capabilities are bound to the new user namespace.
> -	 */
> -	cred->securebits = SECUREBITS_DEFAULT;
> +	/* Start with the capabilities defined in the userns set. */
> +	cred->cap_bset = cred->cap_userns;
> +	cred->cap_permitted = cred->cap_userns;
> +	cred->cap_effective = cred->cap_userns;
>  	cred->cap_inheritable = CAP_EMPTY_SET;
> -	cred->cap_permitted = CAP_FULL_SET;
> -	cred->cap_effective = CAP_FULL_SET;
>  	cred->cap_ambient = CAP_EMPTY_SET;
> -	cred->cap_bset = CAP_FULL_SET;
> +	cred->securebits = SECUREBITS_DEFAULT;
>  #ifdef CONFIG_KEYS
>  	key_put(cred->request_key_auth);
>  	cred->request_key_auth = NULL;
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 162d96b3a676..b3d3372bf910 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -228,6 +228,28 @@ static inline int cap_inh_is_capped(void)
>  	return 1;
>  }
>  
> +/*
> + * Determine whether a userns capability can be raised.
> + * Returns 1 if it can, 0 otherwise.
> + */
> +#ifdef CONFIG_USER_NS
> +static inline int cap_uns_is_raiseable(unsigned long cap)
> +{
> +	if (!!cap_raised(current_cred()->cap_userns, cap))
> +		return 1;
> +	/* a capability cannot be raised unless the current task has it in
> +	 * its bounding set and, without CAP_SETPCAP, its permitted set.
> +	 */
> +	if (!cap_raised(current_cred()->cap_bset, cap))
> +		return 0;
> +	if (cap_capable(current_cred(), current_cred()->user_ns,
> +			CAP_SETPCAP, CAP_OPT_NONE) != 0 &&
> +	    !cap_raised(current_cred()->cap_permitted, cap))
> +		return 0;
> +	return 1;
> +}
> +#endif
> +
>  /**
>   * cap_capset - Validate and apply proposed changes to current's capabilities
>   * @new: The proposed new credentials; alterations should be made here
> @@ -1382,6 +1404,43 @@ int cap_task_prctl(int option, unsigned long arg2, unsigned long arg3,
>  			return commit_creds(new);
>  		}
>  
> +#ifdef CONFIG_USER_NS
> +	case PR_CAP_USERNS:
> +		if (arg2 == PR_CAP_USERNS_CLEAR_ALL) {
> +			if (arg3 | arg4 | arg5)
> +				return -EINVAL;
> +
> +			new = prepare_creds();
> +			if (!new)
> +				return -ENOMEM;
> +			cap_clear(new->cap_userns);
> +			return commit_creds(new);
> +		}
> +
> +		if (((!cap_valid(arg3)) | arg4 | arg5))
> +			return -EINVAL;
> +
> +		if (arg2 == PR_CAP_USERNS_IS_SET) {
> +			return !!cap_raised(current_cred()->cap_userns, arg3);
> +		} else if (arg2 != PR_CAP_USERNS_RAISE &&
> +			   arg2 != PR_CAP_USERNS_LOWER) {
> +			return -EINVAL;
> +		} else {
> +			if (arg2 == PR_CAP_USERNS_RAISE &&
> +			    !cap_uns_is_raiseable(arg3))
> +				return -EPERM;
> +
> +			new = prepare_creds();
> +			if (!new)
> +				return -ENOMEM;
> +			if (arg2 == PR_CAP_USERNS_RAISE)
> +				cap_raise(new->cap_userns, arg3);
> +			else
> +				cap_lower(new->cap_userns, arg3);
> +			return commit_creds(new);
> +		}
> +#endif
> +
>  	default:
>  		/* No functionality available - continue with default */
>  		return -ENOSYS;
> diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
> index b5d5333ab330..e3670d815435 100644
> --- a/security/keys/process_keys.c
> +++ b/security/keys/process_keys.c
> @@ -944,6 +944,9 @@ void key_change_session_keyring(struct callback_head *twork)
>  	new->cap_effective	= old->cap_effective;
>  	new->cap_ambient	= old->cap_ambient;
>  	new->cap_bset		= old->cap_bset;
> +#ifdef CONFIG_USER_NS
> +	new->cap_userns		= old->cap_userns;
> +#endif
>  
>  	new->jit_keyring	= old->jit_keyring;
>  	new->thread_keyring	= key_get(old->thread_keyring);
> -- 
> 2.45.0
> 


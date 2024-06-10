Return-Path: <linux-fsdevel+bounces-21302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 973BB90194E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 03:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17CD7281FAD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 01:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED27E6FBE;
	Mon, 10 Jun 2024 01:56:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39C11869;
	Mon, 10 Jun 2024 01:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717984606; cv=none; b=WvZr3cKFr2YpszOHvgWeA//q7Hw+yw0Y7WLQTMHMVUSikxKuJsPhUVNt892PcXwILMulB5aaAZvkNcDC8+UQKMtYivp/IbZhUyrFOHbuuHbbHDHFE9OQoRm2dRn+mrW5LISR8k+fFaR1nR4R+SDEZHB1w99v+mEnooyXtRXvtEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717984606; c=relaxed/simple;
	bh=9RtOrIRG7Q5rLyGf+dPFSpjxT8d+KyE+OSPnO8gZjyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elVTftVsT+uWZTBxlxGMSxGFtL4QnOmanE1O0oSya2HztvRVpcb6mF5B1BLC0yMHRfB3pv68+ERrgz19rbwLQbKbze51YOxGQxNzspTYeA8PorWLCuttkujiFSd5BcurXpjk27uoejQwbiIjmFPBMAFH7NpgCyXv8xqkZcVZwNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id CF129234; Sun,  9 Jun 2024 20:50:24 -0500 (CDT)
Date: Sun, 9 Jun 2024 20:50:24 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Jonathan Calmels <jcalmels@3xx0.net>, Andrew Morgan <morgan@kernel.org>
Cc: brauner@kernel.org, ebiederm@xmission.com,
	Jonathan Corbet <corbet@lwn.net>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>, Joel Granados <j.granados@samsung.com>,
	John Johansen <john.johansen@canonical.com>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	containers@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	apparmor@lists.ubuntu.com, keyrings@vger.kernel.org,
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/4] capabilities: Add user namespace capabilities
Message-ID: <20240610015024.GA2182786@mail.hallyn.com>
References: <20240609104355.442002-1-jcalmels@3xx0.net>
 <20240609104355.442002-2-jcalmels@3xx0.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240609104355.442002-2-jcalmels@3xx0.net>

On Sun, Jun 09, 2024 at 03:43:34AM -0700, Jonathan Calmels wrote:

(Adding amorgan as he doesn't seem to be on cc list)

> Attackers often rely on user namespaces to get elevated (yet confined)
> privileges in order to target specific subsystems (e.g. [1]). Distributions

I'd modify this to say "in order to target *bugs* in specific subsystems" :)

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

I think this is precisely the right thing to do.  In each of these cases,
there is a kernel bug in code which is only reachable with some
CAP_X, regardless of which user namespace the CAP_X is targeted towards.
So there's really no better way to resist this (apart from not having the
bugs in the first place) than to allow CAP_X to be denied in unprivileged
user namespaces.

> For compatibility reasons, processes always start with a full userns
> capability set.
> 
> On namespace creation, the userns capability set (pU) is assigned to the
> new effective (pE), permitted (pP) and bounding set (X) of the task:
> 
>     pU = pE = pP = X
> 
> The userns capability set obeys the invariant that no bit can ever be set
> if it is not already part of the task’s bounding set. This ensures that
> no namespace can ever gain more privileges than its predecessors.
> Additionally, if a task is not privileged over CAP_SETPCAP, setting any bit
> in the userns set requires its corresponding bit to be set in the permitted
> set. This effectively mimics the inheritable set rules and means that, by
> default, only root in the user namespace can regain userns capabilities
> previously dropped:

Something about this last sentence feels wrong, but I'm not sure what
the best alternative would be.  As is, though, it makes it sound as though
root in the userns can always regain previously dropped capabilities, but
that's not true if dropped in ancestor ns, or if root also dropped the
bits from its bounding set (right?).

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
>     if (prctl(PR_CAP_USERNS, PR_CAP_USERNS_LOWER, CAP_SYS_RAWIO, 0, 0) < 0)
>             err(1, "cannot drop userns cap");
> 
>     execvp(argv[1], argv + 1);
>     err(1, "cannot exec");
> }
> 
> [1] https://security.googleblog.com/2023/06/learnings-from-kctf-vrps-42-linux.html
> [2] https://lore.kernel.org/lkml/1453502345-30416-1-git-send-email-keescook@chromium.org
> [3] https://lore.kernel.org/lkml/20220815162028.926858-1-fred@cloudflare.com
> [4] https://lore.kernel.org/containers/168547265011.24337.4306067683997517082-0@git.sr.ht
> 
> Signed-off-by: Jonathan Calmels <jcalmels@3xx0.net>

Thanks.

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> ---
>  Documentation/filesystems/proc.rst     |  1 +
>  Documentation/security/credentials.rst |  6 +++
>  fs/proc/array.c                        |  9 ++++
>  include/linux/cred.h                   |  3 ++
>  include/uapi/linux/prctl.h             |  7 +++
>  kernel/cred.c                          |  3 ++
>  kernel/umh.c                           | 15 +++++++
>  kernel/user_namespace.c                | 12 +++--
>  security/commoncap.c                   | 62 ++++++++++++++++++++++++--
>  security/keys/process_keys.c           |  3 ++
>  10 files changed, 111 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 7c3a565ffbef..b5de4eaf1b7b 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -294,6 +294,7 @@ It's slow but very precise.
>   CapEff                      bitmap of effective capabilities
>   CapBnd                      bitmap of capabilities bounding set
>   CapAmb                      bitmap of ambient capabilities
> + CapUns                      bitmap of user namespace capabilities
>   NoNewPrivs                  no_new_privs, like prctl(PR_GET_NO_NEW_PRIV, ...)
>   Seccomp                     seccomp mode, like prctl(PR_GET_SECCOMP, ...)
>   Speculation_Store_Bypass    speculative store bypass mitigation status
> diff --git a/Documentation/security/credentials.rst b/Documentation/security/credentials.rst
> index 357328d566c8..7ee904237023 100644
> --- a/Documentation/security/credentials.rst
> +++ b/Documentation/security/credentials.rst
> @@ -148,6 +148,7 @@ The Linux kernel supports the following types of credentials:
>  	- Set of permitted capabilities
>  	- Set of inheritable capabilities
>  	- Set of effective capabilities
> +	- Set of user namespace capabilities
>  	- Capability bounding set
>  
>       These are only carried by tasks.  They indicate superior capabilities
> @@ -170,6 +171,11 @@ The Linux kernel supports the following types of credentials:
>       ``execve()``, especially when a binary is executed that will execute as
>       UID 0.
>  
> +     The user namespace set limits the capabilities granted to user namespaces.
> +     It defines what capabilities will be available in the other sets after
> +     creating a new user namespace, such as when calling ``clone()`` or
> +     ``unshare()`` with ``CLONE_NEWUSER``.
> +
>   3. Secure management flags (securebits).
>  
>       These are only carried by tasks.  These govern the way the above
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
> index 35791791a879..b58325ebdc9e 100644
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
> index 598b3ffe1522..0a5a9cf10d83 100644
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
> @@ -94,6 +97,9 @@ static int call_usermodehelper_exec_async(void *data)
>  	new->cap_bset = cap_intersect(usermodehelper_bset, new->cap_bset);
>  	new->cap_inheritable = cap_intersect(usermodehelper_inheritable,
>  					     new->cap_inheritable);
> +#ifdef CONFIG_USER_NS
> +	new->cap_userns = cap_intersect(usermodehelper_userns, new->cap_userns);
> +#endif
>  	spin_unlock(&umh_sysctl_lock);
>  
>  	if (sub_info->init) {
> @@ -560,6 +566,15 @@ static struct ctl_table usermodehelper_table[] = {
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
>  };
>  
>  static int __init init_umh_sysctls(void)
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
> index 162d96b3a676..59fafbfcfc5e 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -214,10 +214,10 @@ int cap_capget(const struct task_struct *target, kernel_cap_t *effective,
>  }
>  
>  /*
> - * Determine whether the inheritable capabilities are limited to the old
> + * Determine whether the capabilities are limited to the old
>   * permitted set.  Returns 1 if they are limited, 0 if they are not.
>   */
> -static inline int cap_inh_is_capped(void)
> +static inline int cap_is_capped(void)
>  {
>  	/* they are so limited unless the current task has the CAP_SETPCAP
>  	 * capability
> @@ -228,6 +228,29 @@ static inline int cap_inh_is_capped(void)
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
> +
> +	/*
> +	 * A capability cannot be raised unless the current task has it in
> +	 * its bounding set and, without CAP_SETPCAP, its permitted set.
> +	 */
> +	if (!cap_raised(current_cred()->cap_bset, cap))
> +		return 0;
> +	if (cap_is_capped() && !cap_raised(current_cred()->cap_permitted, cap))
> +		return 0;
> +
> +	return 1;
> +}
> +#endif
> +
>  /**
>   * cap_capset - Validate and apply proposed changes to current's capabilities
>   * @new: The proposed new credentials; alterations should be made here
> @@ -246,7 +269,7 @@ int cap_capset(struct cred *new,
>  	       const kernel_cap_t *inheritable,
>  	       const kernel_cap_t *permitted)
>  {
> -	if (cap_inh_is_capped() &&
> +	if (cap_is_capped() &&
>  	    !cap_issubset(*inheritable,
>  			  cap_combine(old->cap_inheritable,
>  				      old->cap_permitted)))
> @@ -1382,6 +1405,39 @@ int cap_task_prctl(int option, unsigned long arg2, unsigned long arg3,
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
> +		if (arg2 == PR_CAP_USERNS_IS_SET)
> +			return !!cap_raised(current_cred()->cap_userns, arg3);
> +		if (arg2 != PR_CAP_USERNS_RAISE && arg2 != PR_CAP_USERNS_LOWER)
> +			return -EINVAL;
> +		if (arg2 == PR_CAP_USERNS_RAISE && !cap_uns_is_raiseable(arg3))
> +			return -EPERM;
> +
> +		new = prepare_creds();
> +		if (!new)
> +			return -ENOMEM;
> +		if (arg2 == PR_CAP_USERNS_RAISE)
> +			cap_raise(new->cap_userns, arg3);
> +		else
> +			cap_lower(new->cap_userns, arg3);
> +		return commit_creds(new);
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
> 2.45.2


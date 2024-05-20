Return-Path: <linux-fsdevel+bounces-19744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0588C9877
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 05:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC94A1C215A7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 03:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE62412B73;
	Mon, 20 May 2024 03:38:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CC6DDAB;
	Mon, 20 May 2024 03:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716176313; cv=none; b=eCWXWahg7upRoQ5DlWDxXS3o0jG4QY8nXGKozSytBi5O9+epauA8URmmF/FkWS2uxhGwamMEIomL2SqfMrxqTLe+0WPpmR3seKEDJTCbP5QdKoJ4qcA0RPNfnkiQ3+X+oi27CvtkNPXqTfr0UK8dkRJY1zpx4wORcVh2ctWIBYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716176313; c=relaxed/simple;
	bh=J/8eSJxWNcuvgo9lHIasRKrxSlhP5goxP0wEgoAeBEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTKWyflqlYf/ZMtebQ3mYeK1oBzyCOZ1MRWZ6HZmObbAzMqEEkbonCoY72lhRNBczKMeR1TGZf84kiMKl4szStcb6VHMFhhtzAIaD7o+WgkjDil1vvrC3+a2WPXVJ2iJstuT/vXeW6fAxn1NtPVYsC+mdkc8XmetbEFvC7LGeUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 8E72A176A; Sun, 19 May 2024 22:38:29 -0500 (CDT)
Date: Sun, 19 May 2024 22:38:29 -0500
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
Subject: Re: [PATCH 3/3] capabilities: add cap userns sysctl mask
Message-ID: <20240520033829.GB1816262@mail.hallyn.com>
References: <20240516092213.6799-1-jcalmels@3xx0.net>
 <20240516092213.6799-4-jcalmels@3xx0.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516092213.6799-4-jcalmels@3xx0.net>

On Thu, May 16, 2024 at 02:22:05AM -0700, Jonathan Calmels wrote:
> This patch adds a new system-wide userns capability mask designed to mask
> off capabilities in user namespaces.
> 
> This mask is controlled through a sysctl and can be set early in the boot
> process or on the kernel command line to exclude known capabilities from
> ever being gained in namespaces. Once set, it can be further restricted to
> exert dynamic policies on the system (e.g. ward off a potential exploit).
> 
> Changing this mask requires privileges over CAP_SYS_ADMIN and CAP_SETPCAP
> in the initial user namespace.
> 
> Example:
> 
>     # sysctl -qw kernel.cap_userns_mask=0x1fffffdffff && \
>       unshare -r grep Cap /proc/self/status
>     CapInh: 0000000000000000
>     CapPrm: 000001fffffdffff
>     CapEff: 000001fffffdffff
>     CapBnd: 000001fffffdffff
>     CapAmb: 0000000000000000
>     CapUNs: 000001fffffdffff
> 
> Signed-off-by: Jonathan Calmels <jcalmels@3xx0.net>

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> ---
>  include/linux/user_namespace.h |  7 ++++
>  kernel/sysctl.c                | 10 ++++++
>  kernel/user_namespace.c        | 66 ++++++++++++++++++++++++++++++++++
>  3 files changed, 83 insertions(+)
> 
> diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
> index 6030a8235617..e3478bd54ee5 100644
> --- a/include/linux/user_namespace.h
> +++ b/include/linux/user_namespace.h
> @@ -2,6 +2,7 @@
>  #ifndef _LINUX_USER_NAMESPACE_H
>  #define _LINUX_USER_NAMESPACE_H
>  
> +#include <linux/capability.h>
>  #include <linux/kref.h>
>  #include <linux/nsproxy.h>
>  #include <linux/ns_common.h>
> @@ -14,6 +15,12 @@
>  #define UID_GID_MAP_MAX_BASE_EXTENTS 5
>  #define UID_GID_MAP_MAX_EXTENTS 340
>  
> +#ifdef CONFIG_SYSCTL
> +extern kernel_cap_t cap_userns_mask;
> +int proc_cap_userns_handler(struct ctl_table *table, int write,
> +			    void *buffer, size_t *lenp, loff_t *ppos);
> +#endif
> +
>  struct uid_gid_extent {
>  	u32 first;
>  	u32 lower_first;
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 81cc974913bb..1546eebd6aea 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -62,6 +62,7 @@
>  #include <linux/sched/sysctl.h>
>  #include <linux/mount.h>
>  #include <linux/userfaultfd_k.h>
> +#include <linux/user_namespace.h>
>  #include <linux/pid.h>
>  
>  #include "../lib/kstrtox.h"
> @@ -1846,6 +1847,15 @@ static struct ctl_table kern_table[] = {
>  		.mode		= 0444,
>  		.proc_handler	= proc_dointvec,
>  	},
> +#ifdef CONFIG_USER_NS
> +	{
> +		.procname	= "cap_userns_mask",
> +		.data		= &cap_userns_mask,
> +		.maxlen		= sizeof(kernel_cap_t),
> +		.mode		= 0644,
> +		.proc_handler	= proc_cap_userns_handler,
> +	},
> +#endif
>  #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86)
>  	{
>  		.procname       = "unknown_nmi_panic",
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index 53848e2b68cd..e0cf606e9140 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -26,6 +26,66 @@
>  static struct kmem_cache *user_ns_cachep __ro_after_init;
>  static DEFINE_MUTEX(userns_state_mutex);
>  
> +#ifdef CONFIG_SYSCTL
> +static DEFINE_SPINLOCK(cap_userns_lock);
> +kernel_cap_t cap_userns_mask = CAP_FULL_SET;
> +
> +int proc_cap_userns_handler(struct ctl_table *table, int write,
> +			    void *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	struct ctl_table t;
> +	unsigned long mask_array[2];
> +	kernel_cap_t new_mask, *mask;
> +	int err;
> +
> +	if (write && (!capable(CAP_SETPCAP) ||
> +		      !capable(CAP_SYS_ADMIN)))
> +		return -EPERM;
> +
> +	/*
> +	 * convert from the global kernel_cap_t to the ulong array to print to
> +	 * userspace if this is a read.
> +	 *
> +	 * capabilities are exposed as one 64-bit value or two 32-bit values
> +	 * depending on the architecture
> +	 */
> +	mask = table->data;
> +	spin_lock(&cap_userns_lock);
> +	mask_array[0] = (unsigned long) mask->val;
> +#if BITS_PER_LONG != 64
> +	mask_array[1] = mask->val >> BITS_PER_LONG;
> +#endif
> +	spin_unlock(&cap_userns_lock);
> +
> +	t = *table;
> +	t.data = &mask_array;
> +
> +	/*
> +	 * actually read or write and array of ulongs from userspace.  Remember
> +	 * these are least significant bits first
> +	 */
> +	err = proc_doulongvec_minmax(&t, write, buffer, lenp, ppos);
> +	if (err < 0)
> +		return err;
> +
> +	new_mask.val = mask_array[0];
> +#if BITS_PER_LONG != 64
> +	new_mask.val += (u64)mask_array[1] << BITS_PER_LONG;
> +#endif
> +
> +	/*
> +	 * Drop everything not in the new_mask (but don't add things)
> +	 */
> +	if (write) {
> +		spin_lock(&cap_userns_lock);
> +		*mask = cap_intersect(*mask, new_mask);
> +		spin_unlock(&cap_userns_lock);
> +	}
> +
> +	return 0;
> +}
> +#endif
> +
>  static bool new_idmap_permitted(const struct file *file,
>  				struct user_namespace *ns, int cap_setid,
>  				struct uid_gid_map *map);
> @@ -46,6 +106,12 @@ static void set_cred_user_ns(struct cred *cred, struct user_namespace *user_ns)
>  	/* Limit userns capabilities to our parent's bounding set. */
>  	if (iscredsecure(cred, SECURE_USERNS_STRICT_CAPS))
>  		cred->cap_userns = cap_intersect(cred->cap_userns, cred->cap_bset);
> +#ifdef CONFIG_SYSCTL
> +	/* Mask off userns capabilities that are not permitted by the system-wide mask. */
> +	spin_lock(&cap_userns_lock);
> +	cred->cap_userns = cap_intersect(cred->cap_userns, cap_userns_mask);
> +	spin_unlock(&cap_userns_lock);
> +#endif
>  
>  	/* Start with the capabilities defined in the userns set. */
>  	cred->cap_bset = cred->cap_userns;
> -- 
> 2.45.0
> 


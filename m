Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B64E54BA1F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 21:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344022AbiFNTJ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jun 2022 15:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357202AbiFNTJr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jun 2022 15:09:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A40B726136
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jun 2022 12:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655233780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KSjupKkK8x/u1DR7Toiz0yobIfYojPXZnI/3b8IMrtE=;
        b=g+ynlqIdrJwYupzKJXAJWhgLSMrZXZ2aCAvML14EpLrilBdq0DKXWa/kKbFzi5EMW4mNSl
        yBXqvSx0PU9GEEDpLsC8BfJNOtf6Jk49+eueBlYRXDxv0MPRboPYzT71bVXVnN6KDbL3dg
        ANBMgpgHr0VJq7bm57QfZjYZOBxKeYg=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-JsUvv39KNMSuVoV_PasyWQ-1; Tue, 14 Jun 2022 15:09:39 -0400
X-MC-Unique: JsUvv39KNMSuVoV_PasyWQ-1
Received: by mail-io1-f69.google.com with SMTP id i126-20020a6bb884000000b006691e030971so4785999iof.15
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jun 2022 12:09:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KSjupKkK8x/u1DR7Toiz0yobIfYojPXZnI/3b8IMrtE=;
        b=AG4m70o3E4+ipjQ08d7jiTvVybeWiZpuqeKhkuVWFcKEnJWHukqroNPbIowc3mXBZZ
         hUHPapMqD1KMaALTq7QB3gTDNfQgcfe0iPGABVdO3QgAZE8vAYBsCCYeOrvWwME5cEi4
         KJVgR19tYIYVRP8k502n9dVxy3RBu2RjxxT9eRSrXvOWmfkWpG3yGwfaonr7GfPC6i75
         ZbeVH05sa+7ynYv6BmufFAy7M6tJ2ydRGwxsJInftrrz7ZlyF1GRIU6qHwDhumDiApvL
         5Czvn/atCRADe0bcFRUyZzPU7swllOWnL50BhJ+hGPhI6T/PzV/U8qeEVRAg4Ou8GDGo
         M6JA==
X-Gm-Message-State: AJIora8lK2OUXSHnxzKiusGay/OZSnmWVm7M36LpxscQUzE9abMArxNl
        JdD95w/gJsceyMQVXQ96Eme+fKfDB33AJ8ojWTBaMhGNRSp8mgxQr7YziSsoWGkTtZEFIjDgQf5
        wggW4jetNWo51nf3jH6+1Bn5Epw==
X-Received: by 2002:a05:6e02:5b1:b0:2d3:a948:74ea with SMTP id k17-20020a056e0205b100b002d3a94874eamr3846486ils.106.1655233778374;
        Tue, 14 Jun 2022 12:09:38 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v+LV1dAJd5rNK7e750znesDsH1BQ7qfU02Wftj2iy45jU8vPQIQi2XrD5KURL93syHWgxz2g==
X-Received: by 2002:a05:6e02:5b1:b0:2d3:a948:74ea with SMTP id k17-20020a056e0205b100b002d3a94874eamr3846454ils.106.1655233777988;
        Tue, 14 Jun 2022 12:09:37 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id f98-20020a0284eb000000b0032df31d45fesm5141715jai.166.2022.06.14.12.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 12:09:37 -0700 (PDT)
Date:   Tue, 14 Jun 2022 15:09:34 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Charan Teja Reddy <charante@codeaurora.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        zhangyi <yi.zhang@huawei.com>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 2/6] userfaultfd: add /dev/userfaultfd for fine
 grained access control
Message-ID: <Yqjc7t+XPtfWUVlw@xz-m1.local>
References: <20220601210951.3916598-1-axelrasmussen@google.com>
 <20220601210951.3916598-3-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220601210951.3916598-3-axelrasmussen@google.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 01, 2022 at 02:09:47PM -0700, Axel Rasmussen wrote:
> Historically, it has been shown that intercepting kernel faults with
> userfaultfd (thereby forcing the kernel to wait for an arbitrary amount
> of time) can be exploited, or at least can make some kinds of exploits
> easier. So, in 37cd0575b8 "userfaultfd: add UFFD_USER_MODE_ONLY" we
> changed things so, in order for kernel faults to be handled by
> userfaultfd, either the process needs CAP_SYS_PTRACE, or this sysctl
> must be configured so that any unprivileged user can do it.
> 
> In a typical implementation of a hypervisor with live migration (take
> QEMU/KVM as one such example), we do indeed need to be able to handle
> kernel faults. But, both options above are less than ideal:
> 
> - Toggling the sysctl increases attack surface by allowing any
>   unprivileged user to do it.
> 
> - Granting the live migration process CAP_SYS_PTRACE gives it this
>   ability, but *also* the ability to "observe and control the
>   execution of another process [...], and examine and change [its]
>   memory and registers" (from ptrace(2)). This isn't something we need
>   or want to be able to do, so granting this permission violates the
>   "principle of least privilege".
> 
> This is all a long winded way to say: we want a more fine-grained way to
> grant access to userfaultfd, without granting other additional
> permissions at the same time.
> 
> To achieve this, add a /dev/userfaultfd misc device. This device
> provides an alternative to the userfaultfd(2) syscall for the creation
> of new userfaultfds. The idea is, any userfaultfds created this way will
> be able to handle kernel faults, without the caller having any special
> capabilities. Access to this mechanism is instead restricted using e.g.
> standard filesystem permissions.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  fs/userfaultfd.c                 | 76 ++++++++++++++++++++++++++------
>  include/uapi/linux/userfaultfd.h |  4 ++
>  2 files changed, 66 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index e943370107d0..8b92c1398169 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -30,6 +30,7 @@
>  #include <linux/security.h>
>  #include <linux/hugetlb.h>
>  #include <linux/swapops.h>
> +#include <linux/miscdevice.h>
>  
>  int sysctl_unprivileged_userfaultfd __read_mostly;
>  
> @@ -413,13 +414,8 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
>  
>  	if (ctx->features & UFFD_FEATURE_SIGBUS)
>  		goto out;
> -	if ((vmf->flags & FAULT_FLAG_USER) == 0 &&
> -	    ctx->flags & UFFD_USER_MODE_ONLY) {
> -		printk_once(KERN_WARNING "uffd: Set unprivileged_userfaultfd "
> -			"sysctl knob to 1 if kernel faults must be handled "
> -			"without obtaining CAP_SYS_PTRACE capability\n");
> +	if (!(vmf->flags & FAULT_FLAG_USER) && (ctx->flags & UFFD_USER_MODE_ONLY))
>  		goto out;
> -	}
>  
>  	/*
>  	 * If it's already released don't get it. This avoids to loop
> @@ -2052,19 +2048,33 @@ static void init_once_userfaultfd_ctx(void *mem)
>  	seqcount_spinlock_init(&ctx->refile_seq, &ctx->fault_pending_wqh.lock);
>  }
>  
> -SYSCALL_DEFINE1(userfaultfd, int, flags)
> +static inline bool userfaultfd_allowed(bool is_syscall, int flags)
> +{
> +	bool kernel_faults = !(flags & UFFD_USER_MODE_ONLY);
> +	bool allow_unprivileged = sysctl_unprivileged_userfaultfd;
> +
> +	/* userfaultfd(2) access is controlled by sysctl + capability. */
> +	if (is_syscall && kernel_faults) {
> +		if (!allow_unprivileged && !capable(CAP_SYS_PTRACE))
> +			return false;
> +	}
> +
> +	/*
> +	 * For /dev/userfaultfd, access is to be controlled using e.g.
> +	 * permissions on the device node. We assume this is correctly
> +	 * configured by userspace, so we simply allow access here.
> +	 */
> +
> +	return true;
> +}

This helper reads a bit weird because potentially it constantly returns
"true" for !syscall use case but it's very not obvious..

Would it be cleaner to not pass in the bool at all?  Something like (I also
un-nested some of the condition checks, hopefully it'll be easier to read):

bool userfaultfd_syscall_allowed(int flags)
{
        /* Userspace-only page faults are always allowed */
        if (flags & UFFD_USER_MODE_ONLY)
                return true;

        /*
         * The user is requesting kernel fault capabilities. Privileged
         * users are always allowed even for kernel fault traps.
         */
        if (capable(CAP_SYS_PTRACE))
                return true;

        /* Whether we allow unprivileged users for kernel faults? */
        return sysctl_unprivileged_userfaultfd;
}

Then below...

> +
> +static int new_userfaultfd(bool is_syscall, int flags)
>  {
>  	struct userfaultfd_ctx *ctx;
>  	int fd;
>  
> -	if (!sysctl_unprivileged_userfaultfd &&
> -	    (flags & UFFD_USER_MODE_ONLY) == 0 &&
> -	    !capable(CAP_SYS_PTRACE)) {
> -		printk_once(KERN_WARNING "uffd: Set unprivileged_userfaultfd "
> -			"sysctl knob to 1 if kernel faults must be handled "
> -			"without obtaining CAP_SYS_PTRACE capability\n");
> +	if (!userfaultfd_allowed(is_syscall, flags))
>  		return -EPERM;
> -	}

.. we could write it as:

        if (is_syscall && !userfaultfd_syscall_allowed(flags))
                return -EPERM;

What do you think?

>  
>  	BUG_ON(!current->mm);
>  
> @@ -2083,6 +2093,10 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
>  	refcount_set(&ctx->refcount, 1);
>  	ctx->flags = flags;
>  	ctx->features = 0;
> +	/*
> +	 * If UFFD_USER_MODE_ONLY is not set, then userfaultfd_allowed() above
> +	 * decided that kernel faults were allowed and should be handled.
> +	 */

Hmm.. why this needs to be added above "released=false"? Did you want to
add this (perhaps) above "flags" instead?

IMHO when people reading the flags it'll be clear already on how it was
handled, the thing is the comment probably hide deep anyway so I'd consider
omitting it.

The rest looks good to me, thanks.

>  	ctx->released = false;
>  	atomic_set(&ctx->mmap_changing, 0);
>  	ctx->mm = current->mm;
> @@ -2098,8 +2112,42 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
>  	return fd;
>  }
>  
> +SYSCALL_DEFINE1(userfaultfd, int, flags)
> +{
> +	return new_userfaultfd(true, flags);
> +}
> +
> +static int userfaultfd_dev_open(struct inode *inode, struct file *file)
> +{
> +	return 0;
> +}
> +
> +static long userfaultfd_dev_ioctl(struct file *file, unsigned int cmd, unsigned long flags)
> +{
> +	if (cmd != USERFAULTFD_IOC_NEW)
> +		return -EINVAL;
> +
> +	return new_userfaultfd(false, flags);
> +}
> +
> +static const struct file_operations userfaultfd_dev_fops = {
> +	.open = userfaultfd_dev_open,
> +	.unlocked_ioctl = userfaultfd_dev_ioctl,
> +	.compat_ioctl = userfaultfd_dev_ioctl,
> +	.owner = THIS_MODULE,
> +	.llseek = noop_llseek,
> +};
> +
> +static struct miscdevice userfaultfd_misc = {
> +	.minor = MISC_DYNAMIC_MINOR,
> +	.name = "userfaultfd",
> +	.fops = &userfaultfd_dev_fops
> +};
> +
>  static int __init userfaultfd_init(void)
>  {
> +	WARN_ON(misc_register(&userfaultfd_misc));
> +
>  	userfaultfd_ctx_cachep = kmem_cache_create("userfaultfd_ctx_cache",
>  						sizeof(struct userfaultfd_ctx),
>  						0,
> diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
> index 7d32b1e797fb..005e5e306266 100644
> --- a/include/uapi/linux/userfaultfd.h
> +++ b/include/uapi/linux/userfaultfd.h
> @@ -12,6 +12,10 @@
>  
>  #include <linux/types.h>
>  
> +/* ioctls for /dev/userfaultfd */
> +#define USERFAULTFD_IOC 0xAA
> +#define USERFAULTFD_IOC_NEW _IO(USERFAULTFD_IOC, 0x00)
> +
>  /*
>   * If the UFFDIO_API is upgraded someday, the UFFDIO_UNREGISTER and
>   * UFFDIO_WAKE ioctls should be defined as _IOW and not as _IOR.  In
> -- 
> 2.36.1.255.ge46751e96f-goog
> 

-- 
Peter Xu


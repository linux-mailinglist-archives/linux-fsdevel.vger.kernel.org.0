Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA061D013B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 23:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731367AbgELVs4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 17:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731332AbgELVsv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 17:48:51 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C70C061A0C
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2020 14:48:51 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y9so3385624plk.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2020 14:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=BH68aI0oQr5XDzZW0luU51A/BIPRDAp0yTX1Iz85hDQ=;
        b=F4wn6zhY07YPs8Yum7lds5dP7zLANkJajZiLj+0FWVpy7usMDM5EVDLBUaknp68g1T
         cIwGbZlgyKJ17fcZqO1T+uXAeGdRnL/rs4NnEMXagE2m2DjLx+lGCzlQ17XUdd3bgbO/
         TFQXEWFJGrCu0R3LZKFjLhLXnMOWWgQUTD2Tk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BH68aI0oQr5XDzZW0luU51A/BIPRDAp0yTX1Iz85hDQ=;
        b=Kk+wZ3KUF3vgjf1ZQ/y6LuJaIv1Ihoi5GfanNob5qGHwnngvEkptTUrrdPS54dg9ch
         QaRoZl+bsMPbMJ0scY65RkoUSwF8otL3PTIj1at72riF6tqEw8+C27ZPQukGhdaDqfNl
         dYkQwtFIqwXIcivbsF1hPS8Q7nlvwvIdzJcgka9T7kW4buO2pt5pPhnweA3LtJomxsKE
         Eitui6Itm0v6ilst8YVavchtWmoqaewCJeLZf/Qz9360sBYw16zeTGZ0NprJLIq9B0pP
         /TlO+vJmDbXG7e9nosxqQ3iI9vAXAe/pun1BH37oCSqc2O+LxxAU1V69gFPtuJ0QZNQZ
         LiMQ==
X-Gm-Message-State: AGi0PuapIjfzeehOtvLkQcFE0e/PPITJ+J7K2XIpi8pOl054x7dpT897
        80nRVC7Acd2gaFy73eXuqrxTxA==
X-Google-Smtp-Source: APiQypII8UuV4yHAxH8LJsskwEWph/59edW3u+0sNOHJPsQ0p9U6r1TZ1H4vqolzSRl9fHhrYYhDeQ==
X-Received: by 2002:a17:902:207:: with SMTP id 7mr21216610plc.331.1589320130727;
        Tue, 12 May 2020 14:48:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b1sm12713657pfa.202.2020.05.12.14.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 14:48:49 -0700 (PDT)
Date:   Tue, 12 May 2020 14:48:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 3/6] fs: Enable to enforce noexec mounts or file exec
 through O_MAYEXEC
Message-ID: <202005121422.411001F1@keescook>
References: <20200505153156.925111-1-mic@digikod.net>
 <20200505153156.925111-4-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200505153156.925111-4-mic@digikod.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 05, 2020 at 05:31:53PM +0200, Mickaël Salaün wrote:
> Enable to forbid access to files open with O_MAYEXEC.  Thanks to the
> noexec option from the underlying VFS mount, or to the file execute
> permission, userspace can enforce these execution policies.  This may
> allow script interpreters to check execution permission before reading
> commands from a file, or dynamic linkers to allow shared object loading.

Some language tailoring. I might change the first sentence to:

Allow for the enforcement of the O_MAYEXEC openat2(2) flag.

> Add a new sysctl fs.open_mayexec_enforce to enable system administrators
> to enforce two complementary security policies according to the
> installed system: enforce the noexec mount option, and enforce
> executable file permission.  Indeed, because of compatibility with
> installed systems, only system administrators are able to check that
> this new enforcement is in line with the system mount points and file
> permissions.  A following patch adds documentation.
> 
> For tailored Linux distributions, it is possible to enforce such
> restriction at build time thanks to the CONFIG_OMAYEXEC_STATIC option.
> The policy can then be configured with CONFIG_OMAYEXEC_ENFORCE_MOUNT and
> CONFIG_OMAYEXEC_ENFORCE_FILE.

OMAYEXEC feels like the wrong name here. Maybe something closer to the
sysctl name? CONFIG_OPEN_MAYEXEC?

And I think it's not needed to have 3 configs for this. That's a lot of
mess for a corner case option. I think I would model this after other
sysctl CONFIGs, and just call this CONFIG_OPEN_MAYEXEC_DEFAULT.

Is _disabling_ the sysctl needed? This patch gets much smaller without
the ..._STATIC bit. (And can we avoid "static", it means different
things to different people. How about invert the logic and call it
CONFIG_OPEN_MAYEXEC_SYSCTL?)

Further notes below...

> [...]
> diff --git a/fs/namei.c b/fs/namei.c
> index 33b6d372e74a..70f179f6bc6c 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -39,6 +39,7 @@
>  #include <linux/bitops.h>
>  #include <linux/init_task.h>
>  #include <linux/uaccess.h>
> +#include <linux/sysctl.h>
>  
>  #include "internal.h"
>  #include "mount.h"
> @@ -411,10 +412,90 @@ static int sb_permission(struct super_block *sb, struct inode *inode, int mask)
>  	return 0;
>  }
>  
> +#define OMAYEXEC_ENFORCE_NONE	0

Like the CONFIG, I'd stay close to the sysctl, OPEN_MAYEXEC_ENFORCE_...

> +#define OMAYEXEC_ENFORCE_MOUNT	(1 << 0)
> +#define OMAYEXEC_ENFORCE_FILE	(1 << 1)

Please use BIT(0), BIT(1)...

> +#define _OMAYEXEC_LAST		OMAYEXEC_ENFORCE_FILE
> +#define _OMAYEXEC_MASK		((_OMAYEXEC_LAST << 1) - 1)
> +
> +#ifdef CONFIG_OMAYEXEC_STATIC
> +const int sysctl_omayexec_enforce =
> +#ifdef CONFIG_OMAYEXEC_ENFORCE_MOUNT
> +	OMAYEXEC_ENFORCE_MOUNT |
> +#endif
> +#ifdef CONFIG_OMAYEXEC_ENFORCE_FILE
> +	OMAYEXEC_ENFORCE_FILE |
> +#endif
> +	OMAYEXEC_ENFORCE_NONE;
> +#else /* CONFIG_OMAYEXEC_STATIC */
> +int sysctl_omayexec_enforce __read_mostly = OMAYEXEC_ENFORCE_NONE;
> +#endif /* CONFIG_OMAYEXEC_STATIC */


If you keep CONFIG_OPEN_MAYEXEC_SYSCTL, you could do this in namei.h:

#ifdef CONFIG_OPEN_MAYEXEC_SYSCTL
#define __sysctl_writable	__read_mostly
#else
#define __sysctl_write		const
#endif

Then with my proposed change to the enforce CONFIG, all of this is
reduced to simply:

int open_mayexec_enforce __sysctl_writable = CONFIG_OPEN_MAYEXEC_DEFAULT;

> +
> +/*
> + * Handle open_mayexec_enforce sysctl
> + */
> +#if defined(CONFIG_SYSCTL) && !defined(CONFIG_OMAYEXEC_STATIC)
> +int proc_omayexec(struct ctl_table *table, int write, void __user *buffer,
> +		size_t *lenp, loff_t *ppos)
> +{
> +	int error;
> +
> +	if (write) {
> +		struct ctl_table table_copy;
> +		int tmp_mayexec_enforce;
> +
> +		if (!capable(CAP_MAC_ADMIN))
> +			return -EPERM;
> +
> +		tmp_mayexec_enforce = *((int *)table->data);
> +		table_copy = *table;
> +		/* Do not erase sysctl_omayexec_enforce. */
> +		table_copy.data = &tmp_mayexec_enforce;
> +		error = proc_dointvec(&table_copy, write, buffer, lenp, ppos);
> +		if (error)
> +			return error;
> +
> +		if ((tmp_mayexec_enforce | _OMAYEXEC_MASK) != _OMAYEXEC_MASK)
> +			return -EINVAL;
> +
> +		*((int *)table->data) = tmp_mayexec_enforce;
> +	} else {
> +		error = proc_dointvec(table, write, buffer, lenp, ppos);
> +		if (error)
> +			return error;
> +	}
> +	return 0;
> +}
> +#endif

I don't think any of this is needed. There are no complex bit field
interactions to check for. The sysctl is min=0, max=3. The only thing
special here is checking CAP_MAC_ADMIN. I would just add
proc_dointvec_minmax_macadmin(), like we have for ..._minmax_sysadmin().

> +
> +/**
> + * omayexec_inode_permission - Check O_MAYEXEC before accessing an inode
> + *
> + * @inode: Inode to check permission on
> + * @mask: Right to check for (%MAY_OPENEXEC, %MAY_EXECMOUNT, %MAY_EXEC)
> + *
> + * Returns 0 if access is permitted, -EACCES otherwise.
> + */
> +static inline int omayexec_inode_permission(struct inode *inode, int mask)
> +{
> +	if (!(mask & MAY_OPENEXEC))
> +		return 0;
> +
> +	if ((sysctl_omayexec_enforce & OMAYEXEC_ENFORCE_MOUNT) &&
> +			!(mask & MAY_EXECMOUNT))
> +		return -EACCES;
> +
> +	if (sysctl_omayexec_enforce & OMAYEXEC_ENFORCE_FILE)
> +		return generic_permission(inode, MAY_EXEC);
> +
> +	return 0;
> +}

More naming nits: I think this should be called may_openexec() to match
the other may_*() functions.

> +
>  /**
>   * inode_permission - Check for access rights to a given inode
>   * @inode: Inode to check permission on
> - * @mask: Right to check for (%MAY_READ, %MAY_WRITE, %MAY_EXEC)
> + * @mask: Right to check for (%MAY_READ, %MAY_WRITE, %MAY_EXEC, %MAY_OPENEXEC,
> + *        %MAY_EXECMOUNT)
>   *
>   * Check for read/write/execute permissions on an inode.  We use fs[ug]id for
>   * this, letting us set arbitrary permissions for filesystem access without
> @@ -454,6 +535,10 @@ int inode_permission(struct inode *inode, int mask)
>  	if (retval)
>  		return retval;
>  
> +	retval = omayexec_inode_permission(inode, mask);
> +	if (retval)
> +		return retval;
> +
>  	return security_inode_permission(inode, mask);
>  }
>  EXPORT_SYMBOL(inode_permission);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 79435fca6c3e..39c80a64d054 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -83,6 +83,9 @@ extern int sysctl_protected_symlinks;
>  extern int sysctl_protected_hardlinks;
>  extern int sysctl_protected_fifos;
>  extern int sysctl_protected_regular;
> +#ifndef CONFIG_OMAYEXEC_STATIC
> +extern int sysctl_omayexec_enforce;
> +#endif

Now there's no need to wrap this in ifdef.

>  
>  typedef __kernel_rwf_t rwf_t;
>  
> @@ -3545,6 +3548,8 @@ int proc_nr_dentry(struct ctl_table *table, int write,
>  		  void __user *buffer, size_t *lenp, loff_t *ppos);
>  int proc_nr_inodes(struct ctl_table *table, int write,
>  		   void __user *buffer, size_t *lenp, loff_t *ppos);
> +int proc_omayexec(struct ctl_table *table, int write, void __user *buffer,
> +		size_t *lenp, loff_t *ppos);
>  int __init get_filesystem_list(char *buf);
>  
>  #define __FMODE_EXEC		((__force int) FMODE_EXEC)
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 8a176d8727a3..29bbf79f444c 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1892,6 +1892,15 @@ static struct ctl_table fs_table[] = {
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= &two,
>  	},
> +#ifndef CONFIG_OMAYEXEC_STATIC
> +	{
> +		.procname       = "open_mayexec_enforce",
> +		.data           = &sysctl_omayexec_enforce,
> +		.maxlen         = sizeof(int),
> +		.mode           = 0600,
> +		.proc_handler   = proc_omayexec,

This can just be min/max of 0/3 with a new macadmin handler.

> +	},
> +#endif
>  #if defined(CONFIG_BINFMT_MISC) || defined(CONFIG_BINFMT_MISC_MODULE)
>  	{
>  		.procname	= "binfmt_misc",
> diff --git a/security/Kconfig b/security/Kconfig
> index cd3cc7da3a55..d8fac9240d14 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -230,6 +230,32 @@ config STATIC_USERMODEHELPER_PATH
>  	  If you wish for all usermode helper programs to be disabled,
>  	  specify an empty string here (i.e. "").
>  
> +menuconfig OMAYEXEC_STATIC
> +	tristate "Configure O_MAYEXEC behavior at build time"
> +	---help---
> +	  Enable to enforce O_MAYEXEC at build time, and disable the dedicated
> +	  fs.open_mayexec_enforce sysctl.
> +
> +	  See Documentation/admin-guide/sysctl/fs.rst for more details.
> +
> +if OMAYEXEC_STATIC
> +
> +config OMAYEXEC_ENFORCE_MOUNT
> +	bool "Mount restriction"
> +	default y
> +	---help---
> +	  Forbid opening files with the O_MAYEXEC option if their underlying VFS is
> +	  mounted with the noexec option or if their superblock forbids execution
> +	  of its content (e.g., /proc).
> +
> +config OMAYEXEC_ENFORCE_FILE
> +	bool "File permission restriction"
> +	---help---
> +	  Forbid opening files with the O_MAYEXEC option if they are not marked as
> +	  executable for the current process (e.g., POSIX permissions).
> +
> +endif # OMAYEXEC_STATIC
> +
>  source "security/selinux/Kconfig"
>  source "security/smack/Kconfig"
>  source "security/tomoyo/Kconfig"
> -- 
> 2.26.2
> 

Otherwise, yeah, the intent here looks good to me.

-- 
Kees Cook

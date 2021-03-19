Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E28734257C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 19:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhCSS5x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 14:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbhCSS5l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:57:41 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F01BC061762
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Mar 2021 11:57:41 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id h3so6534729pfr.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Mar 2021 11:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+ARMNZdORcwZHyTBcp0LfNJtX5idoKO6mMLl8I2vul8=;
        b=Z7F3kFo/VDaBVbJVAStnHQDEhUdf4n8PDfoorw2hl7hlDsBjay176p0QAY1nOep5EN
         GoSbgp4HkvZFWRjxSq4llepmA+IqVoMiDZd0dShfMZXHDUIx1vRJ+4s7dzv1C/aUS0sc
         V32Zl+gmW6O4KBbO0i9Z0PPwl8yBdJtyjpTeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+ARMNZdORcwZHyTBcp0LfNJtX5idoKO6mMLl8I2vul8=;
        b=RgNC5BhrhDe9chVkg6j78BwsslrDgkaT1W1MYXW2a+1DgQ5wCVbFZK5Fy6E9sZMl2o
         iZYGcUIExm8oXfR6ZIFaCF9Rn1WltTKm3IKUdHsqfswzwJtJcZ3aIJKYqFCvPtQL5q9P
         Q5IjZeaGPb2qBv9hS30Vs4Z8cEdeWHztVPudOI77ii8tsbkU+x5VMSoPL5dOJRvZPX8e
         are5CJ/kK/9JwxcrDdM1m4r9xWtzcYyGGmflr7wpJNO2fBBmkiXp06ultj686xhzDW3F
         SFWszNwzjoSUOHTW1cMNJs0CPoAiTW5q0pQ2xJhF99FUjfwIvce5WikU4EDeth2yYMAE
         QMvw==
X-Gm-Message-State: AOAM531AE/CZzxVL1qqKcC+Z1UOetU8Nwr/FXL/eoiB/FMv+9Y2y0Iub
        VfDUP2Br5+fs/9jR0Gc8mhyC0g==
X-Google-Smtp-Source: ABdhPJyFzmcsL01nknQUed0WZD7+sNXok+4SU/jGDlRL8k3BLDDOsYFR22DxJkDBiUX0DFbR4gIt7w==
X-Received: by 2002:a63:5942:: with SMTP id j2mr12740232pgm.351.1616180260468;
        Fri, 19 Mar 2021 11:57:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 142sm6268015pfz.196.2021.03.19.11.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 11:57:39 -0700 (PDT)
Date:   Fri, 19 Mar 2021 11:57:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
Subject: Re: [PATCH v30 07/12] landlock: Support filesystem access-control
Message-ID: <202103191148.6E819426D@keescook>
References: <20210316204252.427806-1-mic@digikod.net>
 <20210316204252.427806-8-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210316204252.427806-8-mic@digikod.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 16, 2021 at 09:42:47PM +0100, Mickaël Salaün wrote:
> From: Mickaël Salaün <mic@linux.microsoft.com>
> 
> Using Landlock objects and ruleset, it is possible to tag inodes
> according to a process's domain.  To enable an unprivileged process to
> express a file hierarchy, it first needs to open a directory (or a file)
> and pass this file descriptor to the kernel through
> landlock_add_rule(2).  When checking if a file access request is
> allowed, we walk from the requested dentry to the real root, following
> the different mount layers.  The access to each "tagged" inodes are
> collected according to their rule layer level, and ANDed to create
> access to the requested file hierarchy.  This makes possible to identify
> a lot of files without tagging every inodes nor modifying the
> filesystem, while still following the view and understanding the user
> has from the filesystem.
> 
> Add a new ARCH_EPHEMERAL_INODES for UML because it currently does not
> keep the same struct inodes for the same inodes whereas these inodes are
> in use.
> 
> This commit adds a minimal set of supported filesystem access-control
> which doesn't enable to restrict all file-related actions.  This is the
> result of multiple discussions to minimize the code of Landlock to ease
> review.  Thanks to the Landlock design, extending this access-control
> without breaking user space will not be a problem.  Moreover, seccomp
> filters can be used to restrict the use of syscall families which may
> not be currently handled by Landlock.
> 
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
> Link: https://lore.kernel.org/r/20210316204252.427806-8-mic@digikod.net
> [...]
> +	spin_lock(&sb->s_inode_list_lock);
> +	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
> +		struct landlock_object *object;
> +
> +		/* Only handles referenced inodes. */
> +		if (!atomic_read(&inode->i_count))
> +			continue;
> +
> +		/*
> +		 * Checks I_FREEING and I_WILL_FREE  to protect against a race
> +		 * condition when release_inode() just called iput(), which
> +		 * could lead to a NULL dereference of inode->security or a
> +		 * second call to iput() for the same Landlock object.  Also
> +		 * checks I_NEW because such inode cannot be tied to an object.
> +		 */
> +		spin_lock(&inode->i_lock);
> +		if (inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW)) {
> +			spin_unlock(&inode->i_lock);
> +			continue;
> +		}

This (and elsewhere here) seems like a lot of inode internals getting
exposed. Can any of this be repurposed into helpers? I see this test
scattered around the kernel a fair bit:

$ git grep I_FREEING | grep I_WILL_FREE | grep I_NEW | wc -l
9

> +static inline u32 get_mode_access(const umode_t mode)
> +{
> +	switch (mode & S_IFMT) {
> +	case S_IFLNK:
> +		return LANDLOCK_ACCESS_FS_MAKE_SYM;
> +	case 0:
> +		/* A zero mode translates to S_IFREG. */
> +	case S_IFREG:
> +		return LANDLOCK_ACCESS_FS_MAKE_REG;
> +	case S_IFDIR:
> +		return LANDLOCK_ACCESS_FS_MAKE_DIR;
> +	case S_IFCHR:
> +		return LANDLOCK_ACCESS_FS_MAKE_CHAR;
> +	case S_IFBLK:
> +		return LANDLOCK_ACCESS_FS_MAKE_BLOCK;
> +	case S_IFIFO:
> +		return LANDLOCK_ACCESS_FS_MAKE_FIFO;
> +	case S_IFSOCK:
> +		return LANDLOCK_ACCESS_FS_MAKE_SOCK;
> +	default:
> +		WARN_ON_ONCE(1);
> +		return 0;
> +	}

I'm assuming this won't be reachable from userspace.

> [...]
> index a5d6ef334991..f8e8e980454c 100644
> --- a/security/landlock/setup.c
> +++ b/security/landlock/setup.c
> @@ -11,17 +11,24 @@
>  
>  #include "common.h"
>  #include "cred.h"
> +#include "fs.h"
>  #include "ptrace.h"
>  #include "setup.h"
>  
> +bool landlock_initialized __lsm_ro_after_init = false;
> +
>  struct lsm_blob_sizes landlock_blob_sizes __lsm_ro_after_init = {
>  	.lbs_cred = sizeof(struct landlock_cred_security),
> +	.lbs_inode = sizeof(struct landlock_inode_security),
> +	.lbs_superblock = sizeof(struct landlock_superblock_security),
>  };
>  
>  static int __init landlock_init(void)
>  {
>  	landlock_add_cred_hooks();
>  	landlock_add_ptrace_hooks();
> +	landlock_add_fs_hooks();
> +	landlock_initialized = true;

I think this landlock_initialized is logically separate from the optional
DEFINE_LSM "enabled" variable, but I thought I'd double check. :)

It seems like it's used here to avoid releasing superblocks before
landlock_init() is called? What is the scenario where that happens?

>  	pr_info("Up and running.\n");
>  	return 0;
>  }
> diff --git a/security/landlock/setup.h b/security/landlock/setup.h
> index 9fdbf33fcc33..1daffab1ab4b 100644
> --- a/security/landlock/setup.h
> +++ b/security/landlock/setup.h
> @@ -11,6 +11,8 @@
>  
>  #include <linux/lsm_hooks.h>
>  
> +extern bool landlock_initialized;
> +
>  extern struct lsm_blob_sizes landlock_blob_sizes;
>  
>  #endif /* _SECURITY_LANDLOCK_SETUP_H */
> -- 
> 2.30.2
> 

The locking and inode semantics are pretty complex, but since, again,
it's got significant test and syzkaller coverage, it looks good to me.

With the inode helper cleanup:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

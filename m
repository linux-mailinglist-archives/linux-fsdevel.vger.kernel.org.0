Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F922A6EAD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 21:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731256AbgKDU12 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 15:27:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:54348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728305AbgKDU12 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 15:27:28 -0500
Received: from gmail.com (unknown [104.132.1.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FCBE20795;
        Wed,  4 Nov 2020 20:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604521645;
        bh=bjHv/p7EGpuFL4p2dh6jXKefzxqOwnHKH2goM2VzsAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QTsfFeRtTeIjbBBbwnqH4wdWfO206XIl1OpuVYwxgOdC6tZLPoVXLGERXe2UIusR3
         srJlBx2ltjVoyWkXrIo7P53/F8TI4ArFSiOCDTUmlD/B6nJNv3nd8PwOXePZJCrCo7
         MhnmUnCrQygZsTtYM4Kk+G5SH1S5r7wN2+kexOdo=
Date:   Wed, 4 Nov 2020 12:27:21 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Lokesh Gidra <lokeshgidra@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Daniel Colascione <dancol@dancol.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        KP Singh <kpsingh@google.com>,
        David Howells <dhowells@redhat.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Aaron Goidel <acgoide@tycho.nsa.gov>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Adrian Reber <areber@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        kaleshsingh@google.com, calin@google.com, surenb@google.com,
        nnk@google.com, jeffv@google.com, kernel-team@android.com,
        Daniel Colascione <dancol@google.com>
Subject: Re: [PATCH v10 1/3] Add a new LSM-supporting anonymous inode
 interface
Message-ID: <20201104202721.GB1796392@gmail.com>
References: <20201011082936.4131726-1-lokeshgidra@google.com>
 <20201011082936.4131726-2-lokeshgidra@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201011082936.4131726-2-lokeshgidra@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

At a high level this patch looks fine to me, but a few nits below.  Also as I
mentioned on the cover letter, it seems this should be split into two patches --
one for the fs changes and one for the security changes.

On Sun, Oct 11, 2020 at 01:29:34AM -0700, Lokesh Gidra wrote:
> +static struct inode *anon_inode_make_secure_inode(
> +	const char *name,
> +	const struct inode *context_inode)
>  {
> -	struct file *file;
> +	struct inode *inode;
> +	const struct qstr qname = QSTR_INIT(name, strlen(name));
> +	int error;
> +
> +	inode = alloc_anon_inode(anon_inode_mnt->mnt_sb);
> +	if (IS_ERR(inode))
> +		return inode;
> +	inode->i_flags &= ~S_PRIVATE;

The comment for alloc_anon_inode() still claims that it uses a single inode.
It would be helpful to fix that comment.

> +/**
> + * Like anon_inode_getfd() creates a new file, but by hooking it to a new anon
> + * inode, rather than to the same singleton inode. Also adds the @context_inode
> + * argument to allow security modules to control creation of the new file. Once
> + * the security module makes the decision, the context_inode is no longer needed
> + * and hence reference to it is not held.
> + */

The first sentence seems a bit off, gramatically.  Also, it seems there should
be a hint here as to why anyone would care whether the inode is singleton or
not.  Remember, people will be reading this code years down the line, and people
may not understand the exact problem you are trying to solve.

Would the following be accurate, or am I misunderstanding something?

/**
 * Like anon_inode_getfd(), but create a new !S_PRIVATE anon inode rather than
 * reuse the singleton anon inode, and call the init_security_anon() LSM hook.
 * This allows the inode to have its own security context and for a LSM to
 * reject creation of the inode.  An optional @context_inode argument is also
 * added to provide the logical "parent" of the new inode.  The LSM may use
 * @context_inode in init_security_anon(), but a reference to it is not held.
 */

> diff --git a/include/linux/anon_inodes.h b/include/linux/anon_inodes.h
> index d0d7d96261ad..6ab840ee93bc 100644
> --- a/include/linux/anon_inodes.h
> +++ b/include/linux/anon_inodes.h
> @@ -10,12 +10,20 @@
>  #define _LINUX_ANON_INODES_H
>  
>  struct file_operations;
> +struct inode;
>  
>  struct file *anon_inode_getfile(const char *name,
>  				const struct file_operations *fops,
>  				void *priv, int flags);
> +
> +int anon_inode_getfd_secure(const char *name,
> +			    const struct file_operations *fops,
> +			    void *priv, int flags,
> +			    const struct inode *context_inode);
> +
>  int anon_inode_getfd(const char *name, const struct file_operations *fops,
>  		     void *priv, int flags);
>  
> +

Unwanted whitespace change here.

> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 9e2e3e63719d..586186f1184b 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -233,6 +233,15 @@
>   *	Returns 0 if @name and @value have been successfully set,
>   *	-EOPNOTSUPP if no security attribute is needed, or
>   *	-ENOMEM on memory allocation failure.
> + * @inode_init_security_anon:
> + *      Set up the incore security field for the new anonymous inode
> + *      and return whether the inode creation is permitted by the security
> + *      module or not.
> + *      @inode contains the inode structure
> + *      @name name of the anonymous inode class
> + *      @context_inode optional related inode
> + *	Returns 0 on success, -EACCESS if the security module denies the
> + *	creation of this inode, or another -errno upon other errors.

EACCES, not EACCESS.  The spelling mistakes of decades past are still with us...

- Eric

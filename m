Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30ABB2A89AB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Nov 2020 23:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732570AbgKEWYY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Nov 2020 17:24:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:43082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732444AbgKEWYY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Nov 2020 17:24:24 -0500
Received: from gmail.com (unknown [104.132.1.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11550206D4;
        Thu,  5 Nov 2020 22:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604615063;
        bh=yYSuORKH7NpqL8BGPDIgYH99/kkDBKqNn3nu3SUcauE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kBwe89XsTmyaTEyvFcfwIZTNOli6U1zxRY/5QWYXCGDwZtOuGmZcq07VRERxWH+5d
         WvN6IGz2k7hrXPwcV5zcJQH4XIpuMNj5OHx8dmvpr9doBnEoBi//8wI899cLx2FEwU
         WTldm9wGl5A921wolh1hXaYNyH4QFWlTGm9uPdCE=
Date:   Thu, 5 Nov 2020 14:24:19 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Lokesh Gidra <lokeshgidra@google.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        hch@infradead.org, Daniel Colascione <dancol@google.com>
Subject: Re: [PATCH v11 2/4] fs: add LSM-supporting anon-inode interface
Message-ID: <20201105222419.GC2555324@gmail.com>
References: <20201105213324.3111570-1-lokeshgidra@google.com>
 <20201105213324.3111570-3-lokeshgidra@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105213324.3111570-3-lokeshgidra@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 05, 2020 at 01:33:22PM -0800, Lokesh Gidra wrote:
> +/**
> + * Like anon_inode_getfd(), but creates a new !S_PRIVATE anon inode rather than
> + * reuse the singleton anon inode, and call the init_security_anon() LSM hook.
> + * This allows the inode to have its own security context and for a LSM to
> + * reject creation of the inode.  An optional @context_inode argument is also
> + * added to provide the logical relationship with the new inode.  The LSM may use
> + * @context_inode in init_security_anon(), but a reference to it is not held.
> + */
> +int anon_inode_getfd_secure(const char *name, const struct file_operations *fops,
> +			    void *priv, int flags,
> +			    const struct inode *context_inode)
> +{
> +	return __anon_inode_getfd(name, fops, priv, flags, context_inode, true);
> +}
> +EXPORT_SYMBOL_GPL(anon_inode_getfd_secure);

inode_init_security_anon(), not init_security_anon().  Also please use a
consistent line width (preferably 80 characters).

> diff --git a/fs/libfs.c b/fs/libfs.c
> index fc34361c1489..5b12228ecc81 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -1213,9 +1213,9 @@ static int anon_set_page_dirty(struct page *page)
>  };
>  
>  /*
> - * A single inode exists for all anon_inode files. Contrary to pipes,
> - * anon_inode inodes have no associated per-instance data, so we need
> - * only allocate one of them.
> + * A single inode exists for all anon_inode files, except for the secure ones.
> + * Contrary to pipes and secure anon_inode inodes, ordinary anon_inode inodes
> + * have no associated per-instance data, so we need only allocate one of them.
>   */
>  struct inode *alloc_anon_inode(struct super_block *s)
>  {

This comment is still wrong, and the first sentence contradicts the second one.
There are a lot of callers of alloc_anon_inode() and none of them use the
singleton inode, since alloc_anon_inode() doesn't actually use it.  The
singleton inode is only used by anon_inode_getfile() and anon_inode_getfd(),
which already have comments describing how they use a singleton inode.

IMO, just deleting this comment would be much better than either the original
version or your proposed version.

> diff --git a/include/linux/anon_inodes.h b/include/linux/anon_inodes.h
> index d0d7d96261ad..6cf447cfceed 100644
> --- a/include/linux/anon_inodes.h
> +++ b/include/linux/anon_inodes.h
> @@ -10,10 +10,15 @@
>  #define _LINUX_ANON_INODES_H
>  
>  struct file_operations;
> +struct inode;
>  
>  struct file *anon_inode_getfile(const char *name,
>  				const struct file_operations *fops,
>  				void *priv, int flags);
> +int anon_inode_getfd_secure(const char *name,
> +			    const struct file_operations *fops,
> +			    void *priv, int flags,
> +			    const struct inode *context_inode);
>  int anon_inode_getfd(const char *name, const struct file_operations *fops,
>  		     void *priv, int flags);
>  

Keeping declarations in the same order as the definitions can be helpful.

- Eric

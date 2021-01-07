Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2386C2EC7F4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 03:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbhAGCKt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jan 2021 21:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbhAGCKs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jan 2021 21:10:48 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB29C0612F1
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Jan 2021 18:10:02 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id cm17so6268112edb.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Jan 2021 18:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oRYS35mQrlbPBmZbRi04L5UchKku0XQLiBg5o+NaYE4=;
        b=b0gYimu7iZSKLJTKB+JrcahEkiwt6EX9LvDZjZ91/THGJL0bd07pvRQ13s3H27Vd0l
         z65nyaHm9nuc0KySpztAxm3keuUPfCF4V0j/mhRd4H8IEZUvaZsPUGP0zLsnZPVM+RAB
         3E4nuwfsnWluISWJlamXbK1744ZjbPd69bMq4fcXeAG80M1dVzQiSwydx609mJjxjEk/
         PUC27A7G9wgq8MgPoqGUZJoqTQRlLUFW6ZX/CJ47BC/LAHWbZGbh3PYJC22Wh3/z0sWs
         k6GvQM3KFq9MO+apM7B+VKn9MPrwZNmi1BIBNkkFG4us8Nxsj0644Nlts7PeG68I8Sgw
         /nSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oRYS35mQrlbPBmZbRi04L5UchKku0XQLiBg5o+NaYE4=;
        b=VKzY40oIEjAnaMsXNiLX9+zqK7/JSIkqaYEjysydim9m2Yz9y76XI35GgOXWefgbaf
         kTwwh0g0NvPTZEWVBy8ocPt84xFxa+a7mj7KZuMWCzPNgjXyDzHTrcEhGL30MnzbHNJ1
         GeDZsx5Xu9a4o2CUxVYM1DfrhLOeH5PIs9N3gBxoaEaeeHyMkeY7DWWHIsU4QZJplFu4
         Y6glVTG7GDb/fxGY+gSVf/NFbbGoyacrZUt9muf3P5jkrSIJ6XqVTiUqkZmYLDbYrMhw
         +UmztU77WS+YhWlYypiSz3uOY61hKab9TWxQZoXnH8RegPGC7Dl3U7woKsgaYBoUws3S
         gd3g==
X-Gm-Message-State: AOAM531uL8LCELVg+PPa4rEuhEdbJDpUrWfICf4iQBUzlkJKRptirPCJ
        euD165yKcRN05kHK5qr05w3p3yhdsU4v+yQWYaSu
X-Google-Smtp-Source: ABdhPJyfaRO+pi3Mu6vIrrtezY3AcKe9zRTV31MiamgBrX6iD9QQcv/kD1arQqU8Nv0DicplPz9tWxRtz0XyfhgB9IQ=
X-Received: by 2002:a05:6402:ca1:: with SMTP id cn1mr5956047edb.128.1609985400522;
 Wed, 06 Jan 2021 18:10:00 -0800 (PST)
MIME-Version: 1.0
References: <20201112015359.1103333-1-lokeshgidra@google.com> <20201112015359.1103333-3-lokeshgidra@google.com>
In-Reply-To: <20201112015359.1103333-3-lokeshgidra@google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 6 Jan 2021 21:09:49 -0500
Message-ID: <CAHC9VhScpFVtxzU_nUDUc4zGT7+EZKFRpYAm+Ps5vd2AjKkaMQ@mail.gmail.com>
Subject: Re: [PATCH v13 2/4] fs: add LSM-supporting anon-inode interface
To:     Lokesh Gidra <lokeshgidra@google.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Eric Paris <eparis@parisplace.org>,
        Daniel Colascione <dancol@dancol.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        KP Singh <kpsingh@google.com>,
        David Howells <dhowells@redhat.com>,
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
        jeffv@google.com, kernel-team@android.com, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>, hch@infradead.org,
        Daniel Colascione <dancol@google.com>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 11, 2020 at 8:54 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
> From: Daniel Colascione <dancol@google.com>
>
> This change adds a new function, anon_inode_getfd_secure, that creates
> anonymous-node file with individual non-S_PRIVATE inode to which security
> modules can apply policy. Existing callers continue using the original
> singleton-inode kind of anonymous-inode file. We can transition anonymous
> inode users to the new kind of anonymous inode in individual patches for
> the sake of bisection and review.
>
> The new function accepts an optional context_inode parameter that callers
> can use to provide additional contextual information to security modules.
> For example, in case of userfaultfd, the created inode is a 'logical child'
> of the context_inode (userfaultfd inode of the parent process) in the sense
> that it provides the security context required during creation of the child
> process' userfaultfd inode.
>
> Signed-off-by: Daniel Colascione <dancol@google.com>
>
> [Delete obsolete comments to alloc_anon_inode()]
> [Add context_inode description in comments to anon_inode_getfd_secure()]
> [Remove definition of anon_inode_getfile_secure() as there are no callers]
> [Make __anon_inode_getfile() static]
> [Use correct error cast in __anon_inode_getfile()]
> [Fix error handling in __anon_inode_getfile()]

Lokesh, I'm assuming you made the changes in the brackets above?  If
so they should include your initials or some other means of
attributing them to you, e.g. "[LG: Fix error ...]".

> Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> Reviewed-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/anon_inodes.c            | 150 ++++++++++++++++++++++++++----------
>  fs/libfs.c                  |   5 --
>  include/linux/anon_inodes.h |   5 ++
>  3 files changed, 115 insertions(+), 45 deletions(-)
>
> diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
> index 89714308c25b..023337d65a03 100644
> --- a/fs/anon_inodes.c
> +++ b/fs/anon_inodes.c
> @@ -55,61 +55,79 @@ static struct file_system_type anon_inode_fs_type = {
>         .kill_sb        = kill_anon_super,
>  };
>
> -/**
> - * anon_inode_getfile - creates a new file instance by hooking it up to an
> - *                      anonymous inode, and a dentry that describe the "class"
> - *                      of the file
> - *
> - * @name:    [in]    name of the "class" of the new file
> - * @fops:    [in]    file operations for the new file
> - * @priv:    [in]    private data for the new file (will be file's private_data)
> - * @flags:   [in]    flags
> - *
> - * Creates a new file by hooking it on a single inode. This is useful for files
> - * that do not need to have a full-fledged inode in order to operate correctly.
> - * All the files created with anon_inode_getfile() will share a single inode,
> - * hence saving memory and avoiding code duplication for the file/inode/dentry
> - * setup.  Returns the newly created file* or an error pointer.
> - */
> -struct file *anon_inode_getfile(const char *name,
> -                               const struct file_operations *fops,
> -                               void *priv, int flags)
> +static struct inode *anon_inode_make_secure_inode(
> +       const char *name,
> +       const struct inode *context_inode)
>  {
> -       struct file *file;
> +       struct inode *inode;
> +       const struct qstr qname = QSTR_INIT(name, strlen(name));
> +       int error;
> +
> +       inode = alloc_anon_inode(anon_inode_mnt->mnt_sb);
> +       if (IS_ERR(inode))
> +               return inode;
> +       inode->i_flags &= ~S_PRIVATE;
> +       error = security_inode_init_security_anon(inode, &qname, context_inode);
> +       if (error) {
> +               iput(inode);
> +               return ERR_PTR(error);
> +       }
> +       return inode;
> +}
>
> -       if (IS_ERR(anon_inode_inode))
> -               return ERR_PTR(-ENODEV);
> +static struct file *__anon_inode_getfile(const char *name,
> +                                        const struct file_operations *fops,
> +                                        void *priv, int flags,
> +                                        const struct inode *context_inode,
> +                                        bool secure)

Is it necessary to pass both the context_inode pointer and the secure
boolean?  It seems like if context_inode is non-NULL then one could
assume that a secure anonymous inode was requested; is there ever
going to be a case where this is not true?

> +{
> +       struct inode *inode;
> +       struct file *file;
>
>         if (fops->owner && !try_module_get(fops->owner))
>                 return ERR_PTR(-ENOENT);
>
> -       /*
> -        * We know the anon_inode inode count is always greater than zero,
> -        * so ihold() is safe.
> -        */
> -       ihold(anon_inode_inode);
> -       file = alloc_file_pseudo(anon_inode_inode, anon_inode_mnt, name,
> +       if (secure) {
> +               inode = anon_inode_make_secure_inode(name, context_inode);
> +               if (IS_ERR(inode)) {
> +                       file = ERR_CAST(inode);
> +                       goto err;
> +               }
> +       } else {
> +               inode = anon_inode_inode;
> +               if (IS_ERR(inode)) {
> +                       file = ERR_PTR(-ENODEV);
> +                       goto err;
> +               }
> +               /*
> +                * We know the anon_inode inode count is always
> +                * greater than zero, so ihold() is safe.
> +                */
> +               ihold(inode);
> +       }
> +
> +       file = alloc_file_pseudo(inode, anon_inode_mnt, name,
>                                  flags & (O_ACCMODE | O_NONBLOCK), fops);
>         if (IS_ERR(file))
> -               goto err;
> +               goto err_iput;
>
> -       file->f_mapping = anon_inode_inode->i_mapping;
> +       file->f_mapping = inode->i_mapping;
>
>         file->private_data = priv;
>
>         return file;
>
> +err_iput:
> +       iput(inode);
>  err:
> -       iput(anon_inode_inode);
>         module_put(fops->owner);
>         return file;
>  }
> -EXPORT_SYMBOL_GPL(anon_inode_getfile);

--
paul moore
www.paul-moore.com

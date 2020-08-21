Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC99A24E291
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 23:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgHUVUo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 17:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgHUVUj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 17:20:39 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EAEC061575
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 14:20:38 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id g13so3107115ioo.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 14:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MqA3XuobnlSGzRs0Mz7TDIq9pF1JxVEkQTSIdtov2z8=;
        b=QXEtJ1aOC65TXhV8cXrKqq6LuD7WUxo4eG2H+p7w6rV7c2h256hsL+TE1Nrogdk6Tk
         kJbvdJ9HxBN/scIGB5OACV05H8Aa2t1yu9BIg3mZwkK0pqvbuFZqVXpoym7GNvTxtgdY
         jxkU3SNIOcPqhcvkQ2kFOvPmaFRj25pyf6P7BDDScDVARZAQViMneUUOhWzT3FJyb3Yr
         lPM2chUdzdZtYAbh5v1SAVJKugt4F69rnz3R1mzb7xsQvP8rno7TX643SUsOZUKv5gSZ
         67sYTXExBEzH/uCyATr5t7C15hN4UGSU9UXlwYFtSIBC/6Q7hbxmDfnVypI8AUB1nDT7
         lDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MqA3XuobnlSGzRs0Mz7TDIq9pF1JxVEkQTSIdtov2z8=;
        b=ex2YIYUaR2yPwA7Pp/T30VwxPOVvMtLVBn+gm0gQw1dzMNaQYWQbg2z8K//84ovx2m
         jtD9Fy9UcDJRzHST1AORnnt5X0+DOAkPxO9Xx4HFHWW4gEWjsHw9pcskjACrJVZS5Bj7
         +BWlb9aV9YEmFPs8UcQE7J+UDsQTT611knZokWPLIU8TdQ/DWA+p1JIDb75PP9PL/bXb
         oBX2E/w5TSQQTGNdLappRhmbTsWGub2kNTqCY9LnX8h9CuyPcSSKoqPiFTfUjokkA2wI
         iYoLdJED2vblNssTzGVX71CCT8iXqp0WjVLxzU2m6d1jTRQbGDcfoVgRNgAm6vP6TCyu
         J/eg==
X-Gm-Message-State: AOAM531br49XxgC/wMj8IOW+o4O93ch3GbUlMzyU6k3r41mI+MlRD0n0
        40sNRK7CngQXnqGcSnE00T3ZgsSvLA+lWLhKuGtqaA==
X-Google-Smtp-Source: ABdhPJxO8uKDSuY4S4m5ScbZtstX/BaLyQyxL0uWIgPoG8PkuvXUY3kTYyRpch2OAKf4SuIY1u62mSMbBlkJd4aZlLU=
X-Received: by 2002:a02:544a:: with SMTP id t71mr4208695jaa.144.1598044837357;
 Fri, 21 Aug 2020 14:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200821185645.801971-1-lokeshgidra@google.com> <20200821185645.801971-2-lokeshgidra@google.com>
In-Reply-To: <20200821185645.801971-2-lokeshgidra@google.com>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Fri, 21 Aug 2020 14:20:26 -0700
Message-ID: <CA+EESO6RZYmXuBgcMve1bRk8j6mpmhV6BRFP2ULbx7g42f_ZhQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] Add a new LSM-supporting anonymous inode interface
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
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
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Calin Juravle <calin@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Nick Kralevich <nnk@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 21, 2020 at 11:57 AM Lokesh Gidra <lokeshgidra@google.com> wrote:
>
> From: Daniel Colascione <dancol@google.com>
>
> This change adds a new function, anon_inode_getfd_secure, that creates
> anonymous-node file with individual non-S_PRIVATE inode to which security
> modules can apply policy. Existing callers continue using the original
> singleton-inode kind of anonymous-inode file. We can transition anonymous
> inode users to the new kind of anonymous inode in individual patches for
> the sake of bisection and review.
>
> The new function accepts an optional context_inode parameter that
> callers can use to provide additional contextual information to
> security modules for granting/denying permission to create an anon inode
> of the same type.
>
> For example, in case of userfaultfd, the created inode is a
> 'logical child' of the context_inode (userfaultfd inode of the
> parent process) in the sense that it provides the security context
> required during creation of the child process' userfaultfd inode.
>
> Signed-off-by: Daniel Colascione <dancol@google.com>
>
> [Fix comment documenting return values of inode_init_security_anon()]
> [Add context_inode description in comments to anon_inode_getfd_secure()]
> [Remove definition of anon_inode_getfile_secure() as there are no callers]
> [Make _anon_inode_getfile() static]
> [Use correct error cast in _anon_inode_getfile()]
>
> Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> ---
>  fs/anon_inodes.c              | 148 ++++++++++++++++++++++++----------
>  include/linux/anon_inodes.h   |  13 +++
>  include/linux/lsm_hook_defs.h |   2 +
>  include/linux/lsm_hooks.h     |   7 ++
>  include/linux/security.h      |   3 +
>  security/security.c           |   9 +++
>  6 files changed, 141 insertions(+), 41 deletions(-)
>
> diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
> index 89714308c25b..2aa8b57be895 100644
> --- a/fs/anon_inodes.c
> +++ b/fs/anon_inodes.c
> @@ -55,61 +55,78 @@ static struct file_system_type anon_inode_fs_type = {
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
> +{
> +       struct inode *inode;
> +       const struct qstr qname = QSTR_INIT(name, strlen(name));
> +       int error;
> +
> +       inode = alloc_anon_inode(anon_inode_mnt->mnt_sb);
> +       if (IS_ERR(inode))
> +               return inode;
> +       inode->i_flags &= ~S_PRIVATE;
> +       error = security_inode_init_security_anon(
> +               inode, &qname, context_inode);
> +       if (error) {
> +               iput(inode);
> +               return ERR_PTR(error);
> +       }
> +       return inode;
> +}
> +
> +static struct file *_anon_inode_getfile(const char *name,
> +                                       const struct file_operations *fops,
> +                                       void *priv, int flags,
> +                                       const struct inode *context_inode,
> +                                       bool secure)
>  {
> +       struct inode *inode;
>         struct file *file;
>
> -       if (IS_ERR(anon_inode_inode))
> -               return ERR_PTR(-ENODEV);
> +       if (secure) {
> +               inode = anon_inode_make_secure_inode(
> +                       name, context_inode);
> +               if (IS_ERR(inode))
> +                       return ERR_CAST(inode);
> +       } else {
> +               inode = anon_inode_inode;
> +               if (IS_ERR(inode))
> +                       return ERR_PTR(-ENODEV);
> +               /*
> +                * We know the anon_inode inode count is always
> +                * greater than zero, so ihold() is safe.
> +                */
> +               ihold(inode);
> +       }
>
> -       if (fops->owner && !try_module_get(fops->owner))
> -               return ERR_PTR(-ENOENT);
> +       if (fops->owner && !try_module_get(fops->owner)) {
> +               file = ERR_PTR(-ENOENT);
> +               goto err;
> +       }
>
> -       /*
> -        * We know the anon_inode inode count is always greater than zero,
> -        * so ihold() is safe.
> -        */
> -       ihold(anon_inode_inode);
> -       file = alloc_file_pseudo(anon_inode_inode, anon_inode_mnt, name,
> +       file = alloc_file_pseudo(inode, anon_inode_mnt, name,
>                                  flags & (O_ACCMODE | O_NONBLOCK), fops);
>         if (IS_ERR(file))
>                 goto err;
>
> -       file->f_mapping = anon_inode_inode->i_mapping;
> +       file->f_mapping = inode->i_mapping;
>
>         file->private_data = priv;
>
>         return file;
>
>  err:
> -       iput(anon_inode_inode);
> +       iput(inode);
>         module_put(fops->owner);
>         return file;
>  }
> -EXPORT_SYMBOL_GPL(anon_inode_getfile);
>
>  /**
> - * anon_inode_getfd - creates a new file instance by hooking it up to an
> - *                    anonymous inode, and a dentry that describe the "class"
> - *                    of the file
> + * anon_inode_getfile - creates a new file instance by hooking it up to an
> + *                      anonymous inode, and a dentry that describe the "class"
> + *                      of the file
>   *
>   * @name:    [in]    name of the "class" of the new file
>   * @fops:    [in]    file operations for the new file
> @@ -118,12 +135,23 @@ EXPORT_SYMBOL_GPL(anon_inode_getfile);
>   *
>   * Creates a new file by hooking it on a single inode. This is useful for files
>   * that do not need to have a full-fledged inode in order to operate correctly.
> - * All the files created with anon_inode_getfd() will share a single inode,
> + * All the files created with anon_inode_getfile() will share a single inode,
>   * hence saving memory and avoiding code duplication for the file/inode/dentry
> - * setup.  Returns new descriptor or an error code.
> + * setup.  Returns the newly created file* or an error pointer.
>   */
> -int anon_inode_getfd(const char *name, const struct file_operations *fops,
> -                    void *priv, int flags)
> +struct file *anon_inode_getfile(const char *name,
> +                               const struct file_operations *fops,
> +                               void *priv, int flags)
> +{
> +       return _anon_inode_getfile(name, fops, priv, flags, NULL, false);
> +}
> +EXPORT_SYMBOL_GPL(anon_inode_getfile);
> +
> +static int _anon_inode_getfd(const char *name,
> +                            const struct file_operations *fops,
> +                            void *priv, int flags,
> +                            const struct inode *context_inode,
> +                            bool secure)
>  {
>         int error, fd;
>         struct file *file;
> @@ -133,7 +161,8 @@ int anon_inode_getfd(const char *name, const struct file_operations *fops,
>                 return error;
>         fd = error;
>
> -       file = anon_inode_getfile(name, fops, priv, flags);
> +       file = _anon_inode_getfile(name, fops, priv, flags, context_inode,
> +                                  secure);
>         if (IS_ERR(file)) {
>                 error = PTR_ERR(file);
>                 goto err_put_unused_fd;
> @@ -146,8 +175,46 @@ int anon_inode_getfd(const char *name, const struct file_operations *fops,
>         put_unused_fd(fd);
>         return error;
>  }
> +
> +/**
> + * anon_inode_getfd - creates a new file instance by hooking it up to
> + *                    an anonymous inode and a dentry that describe
> + *                    the "class" of the file
> + *
> + * @name:    [in]    name of the "class" of the new file
> + * @fops:    [in]    file operations for the new file
> + * @priv:    [in]    private data for the new file (will be file's private_data)
> + * @flags:   [in]    flags
> + *
> + * Creates a new file by hooking it on a single inode. This is
> + * useful for files that do not need to have a full-fledged inode in
> + * order to operate correctly.  All the files created with
> + * anon_inode_getfile() will use the same singleton inode, reducing
> + * memory use and avoiding code duplication for the file/inode/dentry
> + * setup.  Returns a newly created file descriptor or an error code.
> + */
> +int anon_inode_getfd(const char *name, const struct file_operations *fops,
> +                    void *priv, int flags)
> +{
> +       return _anon_inode_getfd(name, fops, priv, flags, NULL, false);
> +}
>  EXPORT_SYMBOL_GPL(anon_inode_getfd);
>
> +/**
> + * Like anon_inode_getfd(), but adds the @context_inode argument to
> + * allow security modules to control creation of the new file. Once the
> + * security module makes the decision, this inode is no longer needed
> + * and hence reference to it is not held.
> + */
> +int anon_inode_getfd_secure(const char *name, const struct file_operations *fops,
> +                           void *priv, int flags,
> +                           const struct inode *context_inode)
> +{
> +       return _anon_inode_getfd(name, fops, priv, flags,
> +                                context_inode, true);
> +}
> +EXPORT_SYMBOL_GPL(anon_inode_getfd_secure);
> +
>  static int __init anon_inode_init(void)
>  {
>         anon_inode_mnt = kern_mount(&anon_inode_fs_type);
> @@ -162,4 +229,3 @@ static int __init anon_inode_init(void)
>  }
>
>  fs_initcall(anon_inode_init);
> -
> diff --git a/include/linux/anon_inodes.h b/include/linux/anon_inodes.h
> index d0d7d96261ad..67bd85d92dca 100644
> --- a/include/linux/anon_inodes.h
> +++ b/include/linux/anon_inodes.h
> @@ -10,12 +10,25 @@
>  #define _LINUX_ANON_INODES_H
>
>  struct file_operations;
> +struct inode;
> +
> +struct file *anon_inode_getfile_secure(const char *name,
> +                                      const struct file_operations *fops,
> +                                      void *priv, int flags,
> +                                      const struct inode *context_inode);
>
oops, I forgot to remove the function prototype. I'll fix it in the
next revision. Meanwhile please let me know if any other issues are
noticed.

>  struct file *anon_inode_getfile(const char *name,
>                                 const struct file_operations *fops,
>                                 void *priv, int flags);
> +
> +int anon_inode_getfd_secure(const char *name,
> +                           const struct file_operations *fops,
> +                           void *priv, int flags,
> +                           const struct inode *context_inode);
> +
>  int anon_inode_getfd(const char *name, const struct file_operations *fops,
>                      void *priv, int flags);
>
> +
>  #endif /* _LINUX_ANON_INODES_H */
>
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 2a8c74d99015..35ff75c43de4 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -113,6 +113,8 @@ LSM_HOOK(void, LSM_RET_VOID, inode_free_security, struct inode *inode)
>  LSM_HOOK(int, 0, inode_init_security, struct inode *inode,
>          struct inode *dir, const struct qstr *qstr, const char **name,
>          void **value, size_t *len)
> +LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
> +        const struct qstr *name, const struct inode *context_inode)
>  LSM_HOOK(int, 0, inode_create, struct inode *dir, struct dentry *dentry,
>          umode_t mode)
>  LSM_HOOK(int, 0, inode_link, struct dentry *old_dentry, struct inode *dir,
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 9e2e3e63719d..2d590d2689b9 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -233,6 +233,13 @@
>   *     Returns 0 if @name and @value have been successfully set,
>   *     -EOPNOTSUPP if no security attribute is needed, or
>   *     -ENOMEM on memory allocation failure.
> + * @inode_init_security_anon:
> + *      Set up a secure anonymous inode.
> + *      @inode contains the inode structure
> + *      @name name of the anonymous inode class
> + *      @context_inode optional related inode
> + *     Returns 0 on success, -EACCESS if the security module denies the
> + *     creation of this inode, or another -errno upon other errors.
>   * @inode_create:
>   *     Check permission to create a regular file.
>   *     @dir contains inode structure of the parent of the new file.
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 0a0a03b36a3b..95c133a8f8bb 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -322,6 +322,9 @@ void security_inode_free(struct inode *inode);
>  int security_inode_init_security(struct inode *inode, struct inode *dir,
>                                  const struct qstr *qstr,
>                                  initxattrs initxattrs, void *fs_data);
> +int security_inode_init_security_anon(struct inode *inode,
> +                                     const struct qstr *name,
> +                                     const struct inode *context_inode);
>  int security_old_inode_init_security(struct inode *inode, struct inode *dir,
>                                      const struct qstr *qstr, const char **name,
>                                      void **value, size_t *len);
> diff --git a/security/security.c b/security/security.c
> index 70a7ad357bc6..149b3f024e2d 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1057,6 +1057,15 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
>  }
>  EXPORT_SYMBOL(security_inode_init_security);
>
> +int
> +security_inode_init_security_anon(struct inode *inode,
> +                                 const struct qstr *name,
> +                                 const struct inode *context_inode)
> +{
> +       return call_int_hook(inode_init_security_anon, 0, inode, name,
> +                            context_inode);
> +}
> +
>  int security_old_inode_init_security(struct inode *inode, struct inode *dir,
>                                      const struct qstr *qstr, const char **name,
>                                      void **value, size_t *len)
> --
> 2.28.0.297.g1956fa8f8d-goog
>

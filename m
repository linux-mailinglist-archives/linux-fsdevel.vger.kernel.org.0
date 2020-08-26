Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5443C2524B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Aug 2020 02:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgHZAZt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Aug 2020 20:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgHZAZr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Aug 2020 20:25:47 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C90FC061756
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2020 17:25:47 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id c6so295058ilo.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2020 17:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K/dyzKl2KNDp/r+WfnPynkuztX4WyPxO01OxIzOPsJ4=;
        b=ib56OhRsrZHqLngBOX7WcYBi5OVWlsUTXEhNLYmH95tp2zLJU9SZi0F14WkOZEjSdB
         YL2vv1mZMvs631kK8DIkddhpnGpvHWXwJk0/SBy3PK4mFkBHOvSblRdP3JfRalaXmeEA
         4jLU442pDRP82Tk0CxZaZ1vz3Dtyngw09LHmYEsteHyGGxdUgG81gN1fRytCwmXFqjDQ
         YBb0+wUGqKkZJxxuVGUtFC1UQBso067BO/zLJGx/f9XL3tCZGgrDP0e0H+8rzrdaz1SQ
         2q/TdyDbZAOh/ErdLcMitEGi8Y74Qwl1jaWKm/GtYZ7PZj4Q5K+kqqUQdIESC6PttW5e
         YoAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K/dyzKl2KNDp/r+WfnPynkuztX4WyPxO01OxIzOPsJ4=;
        b=k71oqAtN57104po59bmh0bCG0VFxDreMJJB+olq4cwXfkyAvNvi6smi6MW96619LJc
         IiHqz4yNZlWKeQYwzOq/hzyf5DXZooaNw4UjO2G4Wcn84SC9t4AsIKOUxnPRcUvp6Sd8
         g9FonyxFmPrPQ0HloXWc3lJIQtKYvjM3ukB5ZEyczDDWXBazMDeXFI5RMKOqSaEUMTLI
         7gUk4S/ShMbyrbCtLCIqJQRbHZvEHDathStBOFfiyxVgTg+zigs/rULH/Ml1T2vXJEQo
         b9goOmUmPOUsZOkZc/I6GYFCltl9i4JbpNr8/OeOlAi7Iksm6VFaCcICei192iwVw82P
         /Zrg==
X-Gm-Message-State: AOAM533Apu6dDt0VbnItt7k4FDu8P9+6ivKHEUoJaVw6x5UIjlhrcH4c
        nDD2OnsfYPf36aj/VWLmwq1tjcXx9NeZYIiUewUj3g==
X-Google-Smtp-Source: ABdhPJyu1EJ1dRN4fAV7VA7O9vNx4XEDXtN9oKEprWXupCUNBnM8L5AfVi9mlfJPiFSlKmachtOfFp6J9htuuDjldAw=
X-Received: by 2002:a92:dc90:: with SMTP id c16mr11226649iln.202.1598401546414;
 Tue, 25 Aug 2020 17:25:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200821185645.801971-1-lokeshgidra@google.com>
 <20200821185645.801971-2-lokeshgidra@google.com> <20200825035036.GC810@sol.localdomain>
In-Reply-To: <20200825035036.GC810@sol.localdomain>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Tue, 25 Aug 2020 17:25:35 -0700
Message-ID: <CA+EESO7YG=9K7o=rjRm++n7HWPhhP1W8Xo7CF_4_pGBheExmqA@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] Add a new LSM-supporting anonymous inode interface
To:     Eric Biggers <ebiggers@kernel.org>
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
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Calin Juravle <calin@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Nick Kralevich <nnk@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        kernel-team@android.com, Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 24, 2020 at 8:50 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Fri, Aug 21, 2020 at 11:56:43AM -0700, Lokesh Gidra wrote:
> > From: Daniel Colascione <dancol@google.com>
> >
> > This change adds a new function, anon_inode_getfd_secure, that creates
> > anonymous-node file with individual non-S_PRIVATE inode to which security
> > modules can apply policy. Existing callers continue using the original
> > singleton-inode kind of anonymous-inode file. We can transition anonymous
> > inode users to the new kind of anonymous inode in individual patches for
> > the sake of bisection and review.
> >
> > The new function accepts an optional context_inode parameter that
> > callers can use to provide additional contextual information to
> > security modules for granting/denying permission to create an anon inode
> > of the same type.
> >
> > For example, in case of userfaultfd, the created inode is a
> > 'logical child' of the context_inode (userfaultfd inode of the
> > parent process) in the sense that it provides the security context
> > required during creation of the child process' userfaultfd inode.
> >
> > Signed-off-by: Daniel Colascione <dancol@google.com>
> >
> > [Fix comment documenting return values of inode_init_security_anon()]
> > [Add context_inode description in comments to anon_inode_getfd_secure()]
> > [Remove definition of anon_inode_getfile_secure() as there are no callers]
> > [Make _anon_inode_getfile() static]
> > [Use correct error cast in _anon_inode_getfile()]
> >
> > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > ---
> >  fs/anon_inodes.c              | 148 ++++++++++++++++++++++++----------
> >  include/linux/anon_inodes.h   |  13 +++
> >  include/linux/lsm_hook_defs.h |   2 +
> >  include/linux/lsm_hooks.h     |   7 ++
> >  include/linux/security.h      |   3 +
> >  security/security.c           |   9 +++
> >  6 files changed, 141 insertions(+), 41 deletions(-)
> >
> > diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
> > index 89714308c25b..2aa8b57be895 100644
> > --- a/fs/anon_inodes.c
> > +++ b/fs/anon_inodes.c
> > @@ -55,61 +55,78 @@ static struct file_system_type anon_inode_fs_type = {
> >       .kill_sb        = kill_anon_super,
> >  };
> >
> > -/**
> > - * anon_inode_getfile - creates a new file instance by hooking it up to an
> > - *                      anonymous inode, and a dentry that describe the "class"
> > - *                      of the file
> > - *
> > - * @name:    [in]    name of the "class" of the new file
> > - * @fops:    [in]    file operations for the new file
> > - * @priv:    [in]    private data for the new file (will be file's private_data)
> > - * @flags:   [in]    flags
> > - *
> > - * Creates a new file by hooking it on a single inode. This is useful for files
> > - * that do not need to have a full-fledged inode in order to operate correctly.
> > - * All the files created with anon_inode_getfile() will share a single inode,
> > - * hence saving memory and avoiding code duplication for the file/inode/dentry
> > - * setup.  Returns the newly created file* or an error pointer.
> > - */
> > -struct file *anon_inode_getfile(const char *name,
> > -                             const struct file_operations *fops,
> > -                             void *priv, int flags)
> > +static struct inode *anon_inode_make_secure_inode(
> > +     const char *name,
> > +     const struct inode *context_inode)
> > +{
> > +     struct inode *inode;
> > +     const struct qstr qname = QSTR_INIT(name, strlen(name));
> > +     int error;
> > +
> > +     inode = alloc_anon_inode(anon_inode_mnt->mnt_sb);
> > +     if (IS_ERR(inode))
> > +             return inode;
> > +     inode->i_flags &= ~S_PRIVATE;
> > +     error = security_inode_init_security_anon(
> > +             inode, &qname, context_inode);
>
> Weird indentation here.  The call to security_inode_init_security_anon() fits on
> one line.
>
> > +     if (error) {
> > +             iput(inode);
> > +             return ERR_PTR(error);
> > +     }
> > +     return inode;
> > +}
> > +
> > +static struct file *_anon_inode_getfile(const char *name,
> > +                                     const struct file_operations *fops,
> > +                                     void *priv, int flags,
> > +                                     const struct inode *context_inode,
> > +                                     bool secure)
> >  {
> > +     struct inode *inode;
> >       struct file *file;
> >
> > -     if (IS_ERR(anon_inode_inode))
> > -             return ERR_PTR(-ENODEV);
> > +     if (secure) {
> > +             inode = anon_inode_make_secure_inode(
> > +                     name, context_inode);
>
> Likewise here.  The call to anon_inode_make_secure_inode() fits on one line.
>
> > +             if (IS_ERR(inode))
> > +                     return ERR_CAST(inode);
> > +     } else {
> > +             inode = anon_inode_inode;
> > +             if (IS_ERR(inode))
> > +                     return ERR_PTR(-ENODEV);
> > +             /*
> > +              * We know the anon_inode inode count is always
> > +              * greater than zero, so ihold() is safe.
> > +              */
> > +             ihold(inode);
> > +     }
> >
> > -     if (fops->owner && !try_module_get(fops->owner))
> > -             return ERR_PTR(-ENOENT);
> > +     if (fops->owner && !try_module_get(fops->owner)) {
> > +             file = ERR_PTR(-ENOENT);
> > +             goto err;
> > +     }
>
> The error path here does module_put(fops->owner), even though a reference wasn't
> acquired.
>
> > +
> > +/**
> > + * anon_inode_getfd - creates a new file instance by hooking it up to
> > + *                    an anonymous inode and a dentry that describe
> > + *                    the "class" of the file
> > + *
> > + * @name:    [in]    name of the "class" of the new file
> > + * @fops:    [in]    file operations for the new file
> > + * @priv:    [in]    private data for the new file (will be file's private_data)
> > + * @flags:   [in]    flags
> > + *
> > + * Creates a new file by hooking it on a single inode. This is
> > + * useful for files that do not need to have a full-fledged inode in
> > + * order to operate correctly.  All the files created with
> > + * anon_inode_getfile() will use the same singleton inode, reducing
>
> This should say anon_inode_getfd(), not anon_inode_getfile().
>
> > +/**
> > + * Like anon_inode_getfd(), but adds the @context_inode argument to
> > + * allow security modules to control creation of the new file. Once the
> > + * security module makes the decision, this inode is no longer needed
> > + * and hence reference to it is not held.
> > + */
> > +int anon_inode_getfd_secure(const char *name, const struct file_operations *fops,
> > +                         void *priv, int flags,
> > +                         const struct inode *context_inode)
> > +{
> > +     return _anon_inode_getfd(name, fops, priv, flags,
> > +                              context_inode, true);
> > +}
>
> Weird indentation here again.  The call to _anon_inode_getfd() fits on one line.
>
> > @@ -162,4 +229,3 @@ static int __init anon_inode_init(void)
> >  }
> >
> >  fs_initcall(anon_inode_init);
> > -
>
> Unnecessary whitespace change.
>
> > diff --git a/include/linux/anon_inodes.h b/include/linux/anon_inodes.h
> > index d0d7d96261ad..67bd85d92dca 100644
> > --- a/include/linux/anon_inodes.h
> > +++ b/include/linux/anon_inodes.h
> > @@ -10,12 +10,25 @@
> >  #define _LINUX_ANON_INODES_H
> >
> >  struct file_operations;
> > +struct inode;
> > +
> > +struct file *anon_inode_getfile_secure(const char *name,
> > +                                    const struct file_operations *fops,
> > +                                    void *priv, int flags,
> > +                                    const struct inode *context_inode);
>
> This function isn't defined anywhere.
>
> > + * @inode_init_security_anon:
> > + *      Set up a secure anonymous inode.
> > + *      @inode contains the inode structure
> > + *      @name name of the anonymous inode class
> > + *      @context_inode optional related inode
> > + *   Returns 0 on success, -EACCESS if the security module denies the
> > + *   creation of this inode, or another -errno upon other errors.
>
> Is there a better name for this than "secure anonymous inode"?
> (What is meant by "secure"?)
>
> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index 0a0a03b36a3b..95c133a8f8bb 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -322,6 +322,9 @@ void security_inode_free(struct inode *inode);
> >  int security_inode_init_security(struct inode *inode, struct inode *dir,
> >                                const struct qstr *qstr,
> >                                initxattrs initxattrs, void *fs_data);
> > +int security_inode_init_security_anon(struct inode *inode,
> > +                                   const struct qstr *name,
> > +                                   const struct inode *context_inode);
> >  int security_old_inode_init_security(struct inode *inode, struct inode *dir,
> >                                    const struct qstr *qstr, const char **name,
> >                                    void **value, size_t *len);
>
> This patch doesn't compile when !CONFIG_SECURITY because this file is missing a
> !CONFIG_SECURITY stub for security_inode_init_security_anon().
>
> > diff --git a/security/security.c b/security/security.c
> > index 70a7ad357bc6..149b3f024e2d 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -1057,6 +1057,15 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
> >  }
> >  EXPORT_SYMBOL(security_inode_init_security);
> >
> > +int
> > +security_inode_init_security_anon(struct inode *inode,
> > +                               const struct qstr *name,
> > +                               const struct inode *context_inode)
> > +{
> > +     return call_int_hook(inode_init_security_anon, 0, inode, name,
> > +                          context_inode);
> > +}
>
> Nit: everything else in this file has 'int' on the same line as the function
> name.
>
Thanks a lot for reviewing. I'll send another version with all these fixed.

> - Eric

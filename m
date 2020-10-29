Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B07629E012
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 02:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404245AbgJ2BHc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 21:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404234AbgJ2BH1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 21:07:27 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD958C0613D5
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2020 18:07:26 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id x16so1313087ljh.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2020 18:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=br9kKS+gFA8BznJTzuPGoVM3iBvdwFO+Ql9r2LbNOMk=;
        b=S5U0imA/A2cSiMX+/z+0z/lz+LR0BfcHiU2uN8JFu023cQ7/C3g0A9ewEoemNmg9Gq
         lc0geXzLiz77TikTHXSfI1WkCExuZ6yFC8txlnUvmbho/a1wgCxu8ytSsOFxq+B9lgQc
         Ctomz1rh6DgZvWfQegQd/4BqnkGRFnOy1qCHakTETFAptS7rqdPTZ8kG9/XUll/1+44G
         f4W4wePPRnxGuoBJxzivBGZxNaYeBAi6ggUBEdeG56tZ6FnpQ9/DtGnQBfIPxCUR3Up0
         JDE3azPAl0sPGCQ8w6PJK9FyWzjgRq059MqgLg7K9hBsyVBZjqZyNg15OkMJLhFhn5IB
         mfFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=br9kKS+gFA8BznJTzuPGoVM3iBvdwFO+Ql9r2LbNOMk=;
        b=GQCM0gbgfIAeVCM4t+ryWt5SHb4KRxdzDxK1pejCi+I/dF/Rpf27rA9Tf5QytrBobb
         UO2pfNkG9KE5wWVsXHb550ZuWgZ4UtxVWnaVKAppMcJnuAXBJxp6bUBiVRA4eDrAmoiF
         wwZu4SrWIL38omm/lQGnlR+pdrQcspzdjqfjuIwert0ypfVu9HmOEYMsAtxv+wvlUqVw
         KwpVhl2wPhg8f88KZARPkpt2UFPT9sg8Wu69UpLdpsvsg31SPQoSOu6csvqvxSWmLAfT
         v2n/RtRwlXz4e/mjitgUZA5hsT8SJYCk0MLBF7e/901UK4u2+9aWPLsi4wOiaFKOl5BJ
         Mthg==
X-Gm-Message-State: AOAM5337GQIbhL8TGSVDlhEFjuqdBxZRdmCvb3lv9IevV6NZAp3vOoHt
        xcmcz+YhYpKZH0ToQdAmUuFe3871wTTgywuty6DwIg==
X-Google-Smtp-Source: ABdhPJzyVeStMQew4XabMc0NUvhBaLjb+ZFK+w6wLXdEwDI/BalwghYQUiGOdURfby5L62jSVPu7zskjTaVnRvUgjvE=
X-Received: by 2002:a2e:9a17:: with SMTP id o23mr816986lji.242.1603933645156;
 Wed, 28 Oct 2020 18:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20201027200358.557003-1-mic@digikod.net> <20201027200358.557003-9-mic@digikod.net>
In-Reply-To: <20201027200358.557003-9-mic@digikod.net>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 29 Oct 2020 02:06:58 +0100
Message-ID: <CAG48ez1San538w=+He309vHg4pBSCvAf7e5xeHdqeOHA6qwitw@mail.gmail.com>
Subject: Re: [PATCH v22 08/12] landlock: Add syscall implementations
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 27, 2020 at 9:04 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
> These 3 system calls are designed to be used by unprivileged processes
> to sandbox themselves:
> * landlock_create_ruleset(2): Creates a ruleset and returns its file
>   descriptor.
> * landlock_add_rule(2): Adds a rule (e.g. file hierarchy access) to a
>   ruleset, identified by the dedicated file descriptor.
> * landlock_enforce_ruleset_current(2): Enforces a ruleset on the current
>   thread and its future children (similar to seccomp).  This syscall has
>   the same usage restrictions as seccomp(2): the caller must have the
>   no_new_privs attribute set or have CAP_SYS_ADMIN in the current user
>   namespace.
[...]
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: James Morris <jmorris@namei.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
[...]
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.=
h
[...]
> +/**
> + * struct landlock_path_beneath_attr - Path hierarchy definition
> + *
> + * Argument of sys_landlock_add_rule().
> + */
> +struct landlock_path_beneath_attr {
> +       /**
> +        * @allowed_access: Bitmask of allowed actions for this file hier=
archy
> +        * (cf. `Filesystem flags`_).
> +        */
> +       __u64 allowed_access;
> +       /**
> +        * @parent_fd: File descriptor, open with ``O_PATH``, which ident=
ify

nit: "identifies"

> +        * the parent directory of a file hierarchy, or just a file.
> +        */
> +       __s32 parent_fd;
> +       /*
> +        * This struct is packed to avoid trailing reserved members.
> +        * Cf. security/landlock/syscall.c:build_check_abi()
> +        */
> +} __attribute__((packed));
[...]
> diff --git a/security/landlock/syscall.c b/security/landlock/syscall.c
[...]
> +static int copy_min_struct_from_user(void *const dst, const size_t ksize=
,
> +               const size_t ksize_min, const void __user *const src,
> +               const size_t usize)
> +{
> +       /* Checks buffer inconsistencies. */
> +       BUILD_BUG_ON(!dst);
> +       if (!src)
> +               return -EFAULT;
> +
> +       /* Checks size ranges. */
> +       BUILD_BUG_ON(ksize <=3D 0);
> +       BUILD_BUG_ON(ksize < ksize_min);

To make these checks work reliably, you should add __always_inline to
the function.

> +       if (usize < ksize_min)
> +               return -EINVAL;
> +       if (usize > PAGE_SIZE)
> +               return -E2BIG;
> +
> +       /* Copies user buffer and fills with zeros. */
> +       return copy_struct_from_user(dst, ksize, src, usize);
> +}
[...]
> +static int get_path_from_fd(const s32 fd, struct path *const path)
> +{
> +       struct fd f;
> +       int err =3D 0;
> +
> +       BUILD_BUG_ON(!__same_type(fd,
> +               ((struct landlock_path_beneath_attr *)NULL)->parent_fd));
> +
> +       /* Handles O_PATH. */
> +       f =3D fdget_raw(fd);
> +       if (!f.file)
> +               return -EBADF;
> +       /*
> +        * Only allows O_PATH file descriptor: enables to restrict ambien=
t
> +        * filesystem access without requiring to open and risk leaking o=
r
> +        * misusing a file descriptor.  Forbid internal filesystems (e.g.
> +        * nsfs), including pseudo filesystems that will never be mountab=
le
> +        * (e.g. sockfs, pipefs).
> +        */
> +       if (!(f.file->f_mode & FMODE_PATH) ||
> +                       (f.file->f_path.mnt->mnt_flags & MNT_INTERNAL) ||
> +                       (f.file->f_path.dentry->d_sb->s_flags & SB_NOUSER=
) ||
> +                       d_is_negative(f.file->f_path.dentry) ||
> +                       IS_PRIVATE(d_backing_inode(f.file->f_path.dentry)=
)) {
> +               err =3D -EBADFD;
> +               goto out_fdput;
> +       }
> +       path->mnt =3D f.file->f_path.mnt;
> +       path->dentry =3D f.file->f_path.dentry;

those two lines can be replaced with "*path =3D f.file->f_path"

> +       path_get(path);
> +
> +out_fdput:
> +       fdput(f);
> +       return err;
> +}
[...]
> +/**
> + * sys_landlock_enforce_ruleset_current - Enforce a ruleset on the curre=
nt task
> + *
> + * @ruleset_fd: File descriptor tied to the ruleset to merge with the ta=
rget.
> + * @flags: Must be 0.
> + *
> + * This system call enables to enforce a Landlock ruleset on the current
> + * thread.  Enforcing a ruleset requires that the task has CAP_SYS_ADMIN=
 in its
> + * namespace or be running with no_new_privs.  This avoids scenarios whe=
re

s/be/is/

> + * unprivileged tasks can affect the behavior of privileged children.
> + *
> + * Possible returned errors are:
> + *
> + * - EOPNOTSUPP: Landlock is supported by the kernel but disabled at boo=
t time;
> + * - EINVAL: @flags is not 0.
> + * - EBADF: @ruleset_fd is not a file descriptor for the current thread;
> + * - EBADFD: @ruleset_fd is not a ruleset file descriptor;
> + * - EPERM: @ruleset_fd has no read access to the underlying ruleset, or=
 the
> + *   current thread is not running with no_new_privs (or doesn't have
> + *   CAP_SYS_ADMIN in its namespace).
> + */
> +SYSCALL_DEFINE2(landlock_enforce_ruleset_current,
> +               const int, ruleset_fd, const __u32, flags)
> +{
> +       struct landlock_ruleset *new_dom, *ruleset;
> +       struct cred *new_cred;
> +       struct landlock_cred_security *new_llcred;
> +       int err;
> +
> +       if (!landlock_initialized)
> +               return -EOPNOTSUPP;
> +
> +       /* No flag for now. */
> +       if (flags)
> +               return -EINVAL;
> +
> +       /*
> +        * Similar checks as for seccomp(2), except that an -EPERM may be
> +        * returned.
> +        */
> +       if (!task_no_new_privs(current)) {
> +               err =3D security_capable(current_cred(), current_user_ns(=
),
> +                               CAP_SYS_ADMIN, CAP_OPT_NOAUDIT);

I think this should be ns_capable_noaudit(current_user_ns(), CAP_SYS_ADMIN)=
?

> +               if (err)
> +                       return err;
> +       }
> +
> +       /* Gets and checks the ruleset. */
> +       ruleset =3D get_ruleset_from_fd(ruleset_fd, FMODE_CAN_READ);
> +       if (IS_ERR(ruleset))
> +               return PTR_ERR(ruleset);
> +
> +       /* Prepares new credentials. */
> +       new_cred =3D prepare_creds();
> +       if (!new_cred) {
> +               err =3D -ENOMEM;
> +               goto out_put_ruleset;
> +       }
> +       new_llcred =3D landlock_cred(new_cred);
> +
> +       /*
> +        * There is no possible race condition while copying and manipula=
ting
> +        * the current credentials because they are dedicated per thread.
> +        */
> +       new_dom =3D landlock_merge_ruleset(new_llcred->domain, ruleset);
> +       if (IS_ERR(new_dom)) {
> +               err =3D PTR_ERR(new_dom);
> +               goto out_put_creds;
> +       }
> +
> +       /* Replaces the old (prepared) domain. */
> +       landlock_put_ruleset(new_llcred->domain);
> +       new_llcred->domain =3D new_dom;
> +
> +       landlock_put_ruleset(ruleset);
> +       return commit_creds(new_cred);
> +
> +out_put_creds:
> +       abort_creds(new_cred);
> +       return err;

I think this "return err" is wrong - don't we still have to put "ruleset" h=
ere?


> +out_put_ruleset:
> +       landlock_put_ruleset(ruleset);
> +       return err;
> +}
> --
> 2.28.0
>

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3FA79FB6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 08:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbjINGAe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 02:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjINGAd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 02:00:33 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C103E0;
        Wed, 13 Sep 2023 23:00:29 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-7a86d413095so255761241.2;
        Wed, 13 Sep 2023 23:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694671228; x=1695276028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RbnMjBlLEXC2WNQCpduhnZBtkFiBuGQGevWl+utPjjI=;
        b=h93Hfs8hN+zRRNl8SlWNEtgcnijkRb5rwsVNBUo27PGpLd29fMjuyispluar4tTddi
         oQpyYh3DXmynEOFzGpNxIr2UgugFLRCaYEddw5xH5zAcpumN0LSAwL70d/+VdWOaFTFJ
         i0cVarVwsT+sC7aGdSvgt7V6aOrtFFlOxtkTv4aUHBdgfbEOJPMLQZPvs+8y15jSrR5v
         7e8T956OXiyERF982P4Hq5e5c2KPgpr7XJI9PM80Xk6xbQzMf0DNBcAwvx4VmFNSqf67
         +43B2Xq2MypAojmzUqEvBJ0Xpc8+pG6mm2e6h+1v36uSaLZE3w9LBE1KWTTmE5ZsWZQ9
         XnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694671228; x=1695276028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RbnMjBlLEXC2WNQCpduhnZBtkFiBuGQGevWl+utPjjI=;
        b=xIZc92K6xbXhk789yT8ZALyv+gH72LfGVbI7XJIAYJNOvvp5CG/dvAu4SJ5oIqoN4w
         kcXghNfXwQiptntTyyuiht8dtRP8XfF8oxvaotINPH2lnPAwDR9Fz5iRyjzjjUVPRg2s
         d5/8dt3tZ6UH0kmtl20QLV0or6K3iyAsTE7Xp0h+TxDb7/Qn64bMtBkgwpf+8HdOlZBE
         6PH9810e1BtEQ0maHI2wXsQHP9e33/BWElKPid45HVxfCnAtKS48J7nM/xhLw8MyxU0k
         csVvsKkf6sO9QT2wDyJ2jpmszwxuX0Nvbwrct4PRB2z4fD9cwQRxfPjmBMcj7wChM+1v
         k4qA==
X-Gm-Message-State: AOJu0Yw44h75nHp/021jPijNGWNL5XJQMuLXFySC8E0W+uW3a3rknC7y
        fVoboGLVKFSChO0w5NED7WBQs3ilvV9fQGcko3U=
X-Google-Smtp-Source: AGHT+IEhFMJHhABM0OQ8YBK38cfJFLWiHdNV0YTj5ob1m75aMntIxsTT4GQI6iJHZRo+SWWWiJSYZfjhYvfjpW23kQ0=
X-Received: by 2002:a05:6122:198d:b0:493:5363:d1dc with SMTP id
 bv13-20020a056122198d00b004935363d1dcmr4995520vkb.12.1694671228135; Wed, 13
 Sep 2023 23:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230913152238.905247-1-mszeredi@redhat.com> <20230913152238.905247-4-mszeredi@redhat.com>
In-Reply-To: <20230913152238.905247-4-mszeredi@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 14 Sep 2023 09:00:17 +0300
Message-ID: <CAOQ4uxh4ETADj7cD56d=8+0t7L_DHaSQpoPGHmwHFqCreOQjdQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] add listmnt(2) syscall
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 13, 2023 at 6:22=E2=80=AFPM Miklos Szeredi <mszeredi@redhat.com=
> wrote:
>
> Add way to query the children of a particular mount.  This is a more
> flexible way to iterate the mount tree than having to parse the complete
> /proc/self/mountinfo.
>
> Lookup the mount by the old (32bit) or new (64bit) mount ID.  If a mount
> needs to be queried based on path, then statx(2) can be used to first que=
ry
> the mount ID belonging to the path.
>
> Return an array of new (64bit) mount ID's.  Without privileges only mount=
s
> are listed which are reachable from the task's root.
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  arch/x86/entry/syscalls/syscall_64.tbl |  1 +
>  fs/namespace.c                         | 51 ++++++++++++++++++++++++++
>  include/linux/syscalls.h               |  2 +
>  include/uapi/asm-generic/unistd.h      |  5 ++-
>  4 files changed, 58 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/sysc=
alls/syscall_64.tbl
> index 6d807c30cd16..0d9a47b0ce9b 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -376,6 +376,7 @@
>  452    common  fchmodat2               sys_fchmodat2
>  453    64      map_shadow_stack        sys_map_shadow_stack
>  454    common  statmnt                 sys_statmnt
> +455    common  listmnt                 sys_listmnt
>
>  #
>  # Due to a historical design error, certain syscalls are numbered differ=
ently
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 088a52043bba..5362b1ffb26f 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -4988,6 +4988,57 @@ SYSCALL_DEFINE5(statmnt, u64, mnt_id,
>         return err;
>  }
>
> +static long do_listmnt(struct vfsmount *mnt, u64 __user *buf, size_t buf=
size,
> +                     const struct path *root)
> +{
> +       struct mount *r, *m =3D real_mount(mnt);
> +       struct path rootmnt =3D { .mnt =3D root->mnt, .dentry =3D root->m=
nt->mnt_root };
> +       long ctr =3D 0;
> +
> +       if (!capable(CAP_SYS_ADMIN) &&
> +           !is_path_reachable(m, mnt->mnt_root, &rootmnt))
> +               return -EPERM;
> +
> +       list_for_each_entry(r, &m->mnt_mounts, mnt_child) {
> +               if (!capable(CAP_SYS_ADMIN) &&
> +                   !is_path_reachable(r, r->mnt.mnt_root, root))
> +                       continue;
> +
> +               if (ctr >=3D bufsize)
> +                       return -EOVERFLOW;
> +               if (put_user(r->mnt_id_unique, buf + ctr))
> +                       return -EFAULT;
> +               ctr++;
> +               if (ctr < 0)
> +                       return -ERANGE;

I think it'd be good for userspace to be able to query required
bufsize with NULL buf, listattr style, rather than having to
guess and re-guess on EOVERFLOW.

Thanks,
Amir.






> +       }
> +       return ctr;
> +}
> +
> +SYSCALL_DEFINE4(listmnt, u64, mnt_id, u64 __user *, buf, size_t, bufsize=
,
> +               unsigned int, flags)
> +{
> +       struct vfsmount *mnt;
> +       struct path root;
> +       long err;
> +
> +       if (flags)
> +               return -EINVAL;
> +
> +       down_read(&namespace_sem);
> +       mnt =3D lookup_mnt_in_ns(mnt_id, current->nsproxy->mnt_ns);
> +       err =3D -ENOENT;
> +       if (mnt) {
> +               get_fs_root(current->fs, &root);
> +               err =3D do_listmnt(mnt, buf, bufsize, &root);
> +               path_put(&root);
> +       }
> +       up_read(&namespace_sem);
> +
> +       return err;
> +}
> +
> +
>  static void __init init_mount_tree(void)
>  {
>         struct vfsmount *mnt;
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 1099bd307fa7..5d776cdb6f18 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -411,6 +411,8 @@ asmlinkage long sys_fstatfs64(unsigned int fd, size_t=
 sz,
>  asmlinkage long sys_statmnt(u64 mnt_id, u64 mask,
>                             struct statmnt __user *buf, size_t bufsize,
>                             unsigned int flags);
> +asmlinkage long sys_listmnt(u64 mnt_id, u64 __user *buf, size_t bufsize,
> +                           unsigned int flags);
>  asmlinkage long sys_truncate(const char __user *path, long length);
>  asmlinkage long sys_ftruncate(unsigned int fd, unsigned long length);
>  #if BITS_PER_LONG =3D=3D 32
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic=
/unistd.h
> index 640997231ff6..a2b41370f603 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -826,8 +826,11 @@ __SYSCALL(__NR_fchmodat2, sys_fchmodat2)
>  #define __NR_statmnt   454
>  __SYSCALL(__NR_statmnt, sys_statmnt)
>
> +#define __NR_listmnt   455
> +__SYSCALL(__NR_listmnt, sys_listmnt)
> +
>  #undef __NR_syscalls
> -#define __NR_syscalls 455
> +#define __NR_syscalls 456
>
>  /*
>   * 32 bit systems traditionally used different
> --
> 2.41.0
>

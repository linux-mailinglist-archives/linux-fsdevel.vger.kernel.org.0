Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DE07A3385
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Sep 2023 02:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjIQAys (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Sep 2023 20:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjIQAym (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Sep 2023 20:54:42 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C9F1BB;
        Sat, 16 Sep 2023 17:54:35 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d819b185e74so3961861276.0;
        Sat, 16 Sep 2023 17:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694912074; x=1695516874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8owqa21vXJkG1+oMpAuVFPRX6vxCaWjYAEUZ6DT+cy8=;
        b=C901flT7TxRd052Zffy8+3RAR1wl59ACacr3ct1cxKw3fe5C14CO5+Go9ypm9/FNYU
         dV5pGUT1ZAOjP2ReULet+UOHrQWlufGaJJSPz8YmmcFdF+uP3HKvew2dDE1mLFsKFN40
         qxFSj7vtV9Mh681+05vpIWu2XJt8B1XZT77cXEcBjLkvjiFhP3MJIhOIjEpIYt8c3MH9
         1G1xETh+zeVSi5wCPHWyPbRIGZAiJi/YKmPxxTAwpu6lu9c5/s4q3fOkPCLvu4LAqhDG
         0VDerzjkf9B1s9o+REHHhRVlDLhU0hZ0BjFBRDuF+VTVO/Z7QrS9szmbO0YqD8PFt+uL
         5CAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694912074; x=1695516874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8owqa21vXJkG1+oMpAuVFPRX6vxCaWjYAEUZ6DT+cy8=;
        b=ceVPyAyH5jSyhnPlWWwy/5VlhxzVvQKhv/VHPNbWS0CMRY5opUCVQJr5OAI0ufAwze
         ldopDyFDX9D9ETsmpGsZ6QcBz/d0k7pwTi221BJvJ/FDCPIQWxt1RBECSj7NxJ2bJNVq
         22/IzgXd5SuF0Amxijz2zZkMsCk+AYlfMoSft7uwxZl7OmkIMStVSMQF2skIee7TrGjw
         8WDMkzPUibhdurgnpzkpov49tR7euid4CzY+TU2Z4TXBCTijGPUazy+qnvIBOfZhKFyL
         7+V1hvPp44mG8iCSfCw7YLIB84CY3wKCTHe3vafAVkBrH8gzPT7K/t/d1lHudXlEURYT
         IQOg==
X-Gm-Message-State: AOJu0YxdeGO7Za1LC+r7EKO8vm39IpgpFxmWvJKFinim6RZD3SCboB3Y
        jHjxbSr2OZijfoZfCszFaeP1hjQAYtl68w==
X-Google-Smtp-Source: AGHT+IGRHaDDn4gVlzS3ArEh47DYqeTBKTvCFg6pthNM0e51NBQ13SL4jQ9C/wBfTbvTlwTaz2G60w==
X-Received: by 2002:a0d:e809:0:b0:583:7545:2f2e with SMTP id r9-20020a0de809000000b0058375452f2emr9027964ywe.7.1694912074523;
        Sat, 16 Sep 2023 17:54:34 -0700 (PDT)
Received: from firmament.. (h198-137-20-64.xnet.uga.edu. [198.137.20.64])
        by smtp.gmail.com with ESMTPSA id t143-20020a818395000000b0059beb468cb3sm1648052ywf.32.2023.09.16.17.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 17:54:34 -0700 (PDT)
From:   Matthew House <mattlloydhouse@gmail.com>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [RFC PATCH 3/3] add listmnt(2) syscall
Date:   Sat, 16 Sep 2023 20:54:16 -0400
Message-ID: <20230917005419.397938-1-mattlloydhouse@gmail.com>
In-Reply-To: <20230913152238.905247-4-mszeredi@redhat.com>
References: <20230913152238.905247-1-mszeredi@redhat.com> <20230913152238.905247-4-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 14, 2023 at 12:02 PM Miklos Szeredi <mszeredi@redhat.com> wrote:
> Add way to query the children of a particular mount.  This is a more
> flexible way to iterate the mount tree than having to parse the complete
> /proc/self/mountinfo.
>
> Lookup the mount by the old (32bit) or new (64bit) mount ID.  If a mount
> needs to be queried based on path, then statx(2) can be used to first que=
ry
> the mount ID belonging to the path.
>
> Return an array of new (64bit) mount ID's.  Without privileges only mounts
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

I'm not an expert on the kernel API, but to my eyes, it looks a bit weird
to silently include or exclude unreachable mounts from the list based on
the result of a capability check. I'd normally expect a more explicit
design, where (e.g.) the caller would set a flag to request unreachable
mounts, then get an -EPERM back if it didn't have the capability, as
opposed to this design, where the meaning of the output ("all mounts" vs.
"all reachable mounts") changes implicitly depending on the caller. Is
there any precedent for a design like this, where inaccessible results
are silently omitted from a returned list?

Thank you,
Matthew House

> +
> +               if (ctr >=3D bufsize)
> +                       return -EOVERFLOW;
> +               if (put_user(r->mnt_id_unique, buf + ctr))
> +                       return -EFAULT;
> +               ctr++;
> +               if (ctr < 0)
> +                       return -ERANGE;
> +       }
> +       return ctr;
> +}
> +
> +SYSCALL_DEFINE4(listmnt, u64, mnt_id, u64 __user *, buf, size_t, bufsize,
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

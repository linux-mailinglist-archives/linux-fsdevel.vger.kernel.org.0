Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD767B2AEF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 06:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjI2EZW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 00:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjI2EZW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 00:25:22 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64EC1A4;
        Thu, 28 Sep 2023 21:25:19 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-45281e0b1cbso6500967137.0;
        Thu, 28 Sep 2023 21:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695961519; x=1696566319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+vj5X8nE7DbE/uAkapC4WahStPO/laj7Q22MJ4hls5w=;
        b=IblRZSHKeSumPWHU4DXe52R2exOhsi+aSJe/ZazRxCKF9MmvcOIWUHULOG1w7ABMYZ
         eEkzqeQOn0np78gyRySdccGJ5258kY7Ji3ytYGp5WCfDi19xaxxMgwCHXPY9wrB6GI1O
         j0Zv2Gjagun/eq1thqujFPq0W3fNy/EG60TU7rl2pZNgjerJ7jpp0R4QQ3uGKXFhdllN
         030JZ39XlgcgZnlFJvdhX5RFZy6WWz3/Gs3/5PZszt6DbFwMMY6WJESU2U4z42RuYGFN
         NHWu3fFRxIlBmUBkZntioKgl0fGPvWLLILi4qiQ1HRShd2b/TtBH2CP3Ab7xYopciAp4
         hPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695961519; x=1696566319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+vj5X8nE7DbE/uAkapC4WahStPO/laj7Q22MJ4hls5w=;
        b=hSCTuSXEMx6ynA2cEBvJzXnuB0Eaq/ovfhkeoL6FWKn/LMqesoSuwK0Vo76Nm6XECP
         9BAtu2JoDk9YREtF3fkrt/O5i5hbRXZ3/3qS3gwkWEH7SnMuyCTwimGm16ue0TrqD6wI
         ygMyUclH5S+ISHJHDvSz4VBW2eYPCRhXkIU5X57cjH5cNBLAE9T3LIOYwxu/LqoszhgR
         Rw/aZwqjfEQSSQfiWQo9QXDm9Hbul7DCCgakYbMGWzqXoGkpoDi1vo4sBcwJ5C5qWX9r
         qOEQufjPE5BOqSYI1j1zfhcKSeNWxGf1cwhXVS8z2NVTHJPQk7372WKPQp7xVsXir07f
         Ehjg==
X-Gm-Message-State: AOJu0YxIiPRt17ZtR26HzW88z/fg4s/TqUudA8+Kc4O/oGjDZczr0Aui
        vaT9SE01mc/8aT4UVvzd7buBAEDIxbxFgBEP930=
X-Google-Smtp-Source: AGHT+IEQMRxZcxiALYhvgGpL1O816GhPBnwd3tyyPtITwnYKtjd92l9TrisAWCY572NOBXMIguV6lhFaz5xk45CLTNI=
X-Received: by 2002:a05:6102:118:b0:452:99e0:54e8 with SMTP id
 z24-20020a056102011800b0045299e054e8mr3156379vsq.16.1695961518941; Thu, 28
 Sep 2023 21:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000259bd8060596e33f@google.com> <bed99e92-cb7c-868d-94f3-ddf53e2b262a@linux.ibm.com>
 <8a65f5eb-2b59-9903-c6b8-84971f8765ae@linux.ibm.com> <ab7df5e93b5493de5fa379ccab48859fe953d7ae.camel@kernel.org>
 <b16550ac-f589-c5d7-e139-d585e8771cfd@linux.ibm.com> <00dbd1e7-dfc8-86bc-536f-264a929ebb35@linux.ibm.com>
 <94b4686a-fee8-c545-2692-b25285b9a152@schaufler-ca.com> <d59d40426c388789c195d94e7e72048ef45fec5e.camel@kernel.org>
 <7caa3aa06cc2d7f8d075306b92b259dab3e9bc21.camel@linux.ibm.com>
 <20230921-gedanken-salzwasser-40d25b921162@brauner> <28997978-0b41-9bf3-8f62-ce422425f672@linux.ibm.com>
In-Reply-To: <28997978-0b41-9bf3-8f62-ce422425f672@linux.ibm.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 29 Sep 2023 07:25:07 +0300
Message-ID: <CAOQ4uxie6xT5mmCcCwYtnEvra37eSeFftXfxaTULfdJnk1VcXQ@mail.gmail.com>
Subject: Re: [syzbot] [integrity] [overlayfs] general protection fault in d_path
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jeff Layton <jlayton@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        syzbot <syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Sep 29, 2023 at 3:02=E2=80=AFAM Stefan Berger <stefanb@linux.ibm.co=
m> wrote:
>
>
> On 9/21/23 07:48, Christian Brauner wrote:
> >
> > Imho, this is all very wild but I'm not judging.
> >
> > Two solutions imho:
> > (1) teach stacking filesystems like overlayfs and ecryptfs to use
> >      vfs_getattr_nosec() in their ->getattr() implementation when they
> >      are themselves called via vfs_getattr_nosec(). This will fix this =
by
> >      not triggering another LSM hook.
>
> This somewhat lengthy patch I think would be a solution for (1). I don't
> think the Fixes tag is correct but IMO it should propagate farther back,
> if possible.
>
>
>  From 01467f6e879c4cd757abb4d79cb18bf11150bed8 Mon Sep 17 00:00:00 2001
> From: Stefan Berger <stefanb@linux.ibm.com>
> Date: Thu, 28 Sep 2023 14:42:39 -0400
> Subject: [PATCH] fs: Enable GETATTR_NOSEC parameter for getattr interface
>   function
>
> When vfs_getattr_nosec() calls a filesystem's getattr interface function
> then the 'nosec' should propagate into this function so that
> vfs_getattr_nosec() can again be called from the filesystem's gettattr
> rather than vfs_getattr(). The latter would add unnecessary security
> checks that the initial vfs_getattr_nosec() call wanted to avoid.
> Therefore, introduce the getattr flag GETATTR_NOSEC and allow to pass
> with the new getattr_flags parameter to the getattr interface function.
> In overlayfs and ecryptfs use this flag to determine which one of the
> two functions to call.
>
> In a recent code change introduced to IMA vfs_getattr_nosec() ended up
> calling vfs_getattr() in overlayfs, which in turn called
> security_inode_getattr() on an exiting process that did not have
> current->fs set anymore, which then caused a kernel NULL pointer
> dereference. With this change the call to security_inode_getattr() can
> be avoided, thus avoiding the NULL pointer dereference.
>
> Reported-by: syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com
> Fixes: db1d1e8b9867 ("IMA: use vfs_getattr_nosec to get the i_version")
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>
> ---
>
> simple_getattr has been adjusted and all files returned by the following
> grep have been adjusted as well.
>
>   grep -rEI "^[[:space:]]+\.getattr" ./ | \
>     grep -v simple_getattr  | \
>     cut -d ":" -f1 | sort | uniq
> ---
>   fs/9p/vfs_inode.c             |  3 ++-
>   fs/9p/vfs_inode_dotl.c        |  3 ++-
>   fs/afs/inode.c                |  3 ++-
>   fs/afs/internal.h             |  2 +-
>   fs/bad_inode.c                |  3 ++-
>   fs/btrfs/inode.c              |  3 ++-
>   fs/ceph/inode.c               |  9 ++++++---
>   fs/ceph/super.h               |  3 ++-
>   fs/coda/coda_linux.h          |  2 +-
>   fs/coda/inode.c               |  3 ++-
>   fs/ecryptfs/inode.c           | 14 ++++++++++----
>   fs/erofs/inode.c              |  2 +-
>   fs/erofs/internal.h           |  2 +-
>   fs/exfat/exfat_fs.h           |  2 +-
>   fs/exfat/file.c               |  2 +-
>   fs/ext2/ext2.h                |  2 +-
>   fs/ext2/inode.c               |  3 ++-
>   fs/ext4/ext4.h                |  6 ++++--
>   fs/ext4/inode.c               |  9 ++++++---
>   fs/ext4/symlink.c             |  6 ++++--
>   fs/f2fs/f2fs.h                |  3 ++-
>   fs/f2fs/file.c                |  3 ++-
>   fs/f2fs/namei.c               |  6 ++++--
>   fs/fat/fat.h                  |  3 ++-
>   fs/fat/file.c                 |  3 ++-
>   fs/fuse/dir.c                 |  3 ++-
>   fs/gfs2/inode.c               |  4 +++-
>   fs/hfsplus/hfsplus_fs.h       |  2 +-
>   fs/hfsplus/inode.c            |  2 +-
>   fs/kernfs/inode.c             |  3 ++-
>   fs/kernfs/kernfs-internal.h   |  3 ++-
>   fs/libfs.c                    |  5 +++--
>   fs/minix/inode.c              |  3 ++-
>   fs/minix/minix.h              |  3 ++-
>   fs/nfs/inode.c                |  3 ++-
>   fs/nfs/namespace.c            |  5 +++--
>   fs/ntfs3/file.c               |  3 ++-
>   fs/ntfs3/ntfs_fs.h            |  3 ++-
>   fs/ocfs2/file.c               |  3 ++-
>   fs/ocfs2/file.h               |  3 ++-
>   fs/orangefs/inode.c           |  3 ++-
>   fs/orangefs/orangefs-kernel.h |  3 ++-
>   fs/overlayfs/inode.c          |  8 ++++++--
>   fs/overlayfs/overlayfs.h      |  3 ++-
>   fs/proc/base.c                |  6 ++++--
>   fs/proc/fd.c                  |  3 ++-
>   fs/proc/generic.c             |  3 ++-
>   fs/proc/internal.h            |  3 ++-
>   fs/proc/proc_net.c            |  3 ++-
>   fs/proc/proc_sysctl.c         |  3 ++-
>   fs/proc/root.c                |  3 ++-
>   fs/smb/client/cifsfs.h        |  3 ++-
>   fs/smb/client/inode.c         |  3 ++-
>   fs/stat.c                     |  3 ++-
>   fs/sysv/itree.c               |  3 ++-
>   fs/sysv/sysv.h                |  2 +-
>   fs/ubifs/dir.c                |  3 ++-
>   fs/ubifs/file.c               |  6 ++++--
>   fs/ubifs/ubifs.h              |  3 ++-
>   fs/udf/symlink.c              |  3 ++-
>   fs/vboxsf/utils.c             |  3 ++-
>   fs/vboxsf/vfsmod.h            |  2 +-
>   fs/xfs/xfs_iops.c             |  3 ++-
>   include/linux/fs.h            | 10 ++++++++--
>   include/linux/nfs_fs.h        |  2 +-
>   mm/shmem.c                    |  3 ++-
>   66 files changed, 159 insertions(+), 82 deletions(-)
>

You can avoid all this churn.
Just use the existing query_flags arg.
Nothing outside the AT_STATX_SYNC_TYPE query_flags is
passed into filesystems from userspace.

Mast out AT_STATX_SYNC_TYPE in vfs_getattr()
And allow kernel internal request_flags in vfs_getattr_nosec()

The AT_ flag namespace is already a challenge, but mixing user
flags and kernel-only flags in vfs interfaces has been done before.

...

> @@ -171,7 +172,10 @@ int ovl_getattr(struct mnt_idmap *idmap, const
> struct path *path,
>
>       type =3D ovl_path_real(dentry, &realpath);
>       old_cred =3D ovl_override_creds(dentry->d_sb);
> -    err =3D vfs_getattr(&realpath, stat, request_mask, flags);
> +    if (getattr_flags & GETATTR_NOSEC)
> +        err =3D vfs_getattr_nosec(&realpath, stat, request_mask, flags);
> +    else
> +        err =3D vfs_getattr(&realpath, stat, request_mask, flags);
>       if (err)
>           goto out;
>

There are two more vfs_getattr() calls in this function that you missed.

Please create ovl_do_getattr() inline wrapper in overlayfs.h next to all
the other ovl_do_ wrappers and use it here.

Thanks,
Amir.

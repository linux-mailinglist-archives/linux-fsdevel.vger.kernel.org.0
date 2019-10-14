Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5C3FD5975
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2019 04:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbfJNCEW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Oct 2019 22:04:22 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34792 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729659AbfJNCEW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Oct 2019 22:04:22 -0400
Received: by mail-io1-f67.google.com with SMTP id q1so34703303ion.1;
        Sun, 13 Oct 2019 19:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4iI1U5W50uucA2qCZykSDQfbSXg9H0XvV1EOgeR4Q54=;
        b=tBk0SJJ7vXrv8bZK7w+nNlpDHB494vAF4ne+9m8ExOnWuXkfeLnYz+mdG12PEACUbj
         SFcGM9jBX9hvLfLguE6FsLK0V4MhU/sc8ulSSqfeLLkiPq3Mh0E6SQCS64wpmen89qBX
         xR+fTG13xlvClUFWHUgh/9R/uJrUYaW3ldIGkENE5s/8LUH5VupvQNqWaaJ6FOR3QWpt
         PMFFWspQoS6ykMQV97xn544nghP/yXPEX6ZW2C8uPx2G9RALZ2wKzQ8lGx0nUrRYMPwa
         almlZDFSnEPbeZmm++oaNq94QpOlupUPYCc81yBjj7SFPofWyiwUtusb6D8QSVOQim25
         7wSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4iI1U5W50uucA2qCZykSDQfbSXg9H0XvV1EOgeR4Q54=;
        b=TKFqlyX9KX8l0r1d9Z0v8EgZnrp+a6s+61xWjLrkNinNdzaN+sfucuRz5meoUnEqEX
         XQsEZaEqdCSYMeFQ5sXm4cPB8ZeBTq7RrHSC4BXE1pga8AoGL2ZRJ4znsobZHh3YmjCA
         dV2HvIyRkoXqi9JJYgRnYGhIejmwtyjhvNLina089Haos84l8/8KAcRsxR6i5elT7bS5
         9WS8krsrN4XTPEt3PI+CT7IElVinGv04WHNvnRqARB6LzFanJyk484asyf8mhbL340Je
         qufXmLSucn6ptGz9EsXrfFpIFcfzk6toW/xU7jzH9Ev/hTdvf8rYWdsMxNzUoSP4RhnB
         KtHw==
X-Gm-Message-State: APjAAAUboveMKvbcZ1kvofSmckPPtbbAvPKNqraZWqHmoQdoAzj7uuQD
        zeLsPr2dsRVvQa8l/5G3aVBs9J0FQ0oUXeDVqtw=
X-Google-Smtp-Source: APXvYqzCL+ZPCbb78l+cke7wD6MMCX5ftpHaUnOQxRSRLfL/0r+wfuIheNygiPX0GUJ9icOdgpxHkZlYy9ghZuNpixk=
X-Received: by 2002:a02:bb0c:: with SMTP id y12mr22841824jan.96.1571018661298;
 Sun, 13 Oct 2019 19:04:21 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000805e5505945a234b@google.com> <20191009071850.258463-1-ebiggers@kernel.org>
In-Reply-To: <20191009071850.258463-1-ebiggers@kernel.org>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Sun, 13 Oct 2019 19:04:10 -0700
Message-ID: <CABeXuvomuEY7-8SJuRDh+MS+fSE9evMudFe6KEdP+y-0D89fJw@mail.gmail.com>
Subject: Re: [PATCH] fs/namespace.c: fix use-after-free of mount in mnt_warn_timestamp_expiry()
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jeff Layton <jlayton@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks for the fix.

Would it be better to move the check and warning to a place where the
access is still safe?

-Deepa

> On Oct 9, 2019, at 12:19 AM, Eric Biggers <ebiggers@kernel.org> wrote:
>
> =EF=BB=BFFrom: Eric Biggers <ebiggers@google.com>


On Wed, Oct 9, 2019 at 12:19 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> After do_add_mount() returns success, the caller doesn't hold a
> reference to the 'struct mount' anymore.  So it's invalid to access it
> in mnt_warn_timestamp_expiry().
>
> Fix it by instead passing the super_block and the mnt_flags.  It's safe
> to access the super_block because it's pinned by fs_context::root.
>
> Reported-by: syzbot+da4f525235510683d855@syzkaller.appspotmail.com
> Fixes: f8b92ba67c5d ("mount: Add mount warning for impending timestamp ex=
piry")
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/namespace.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index fe0e9e1410fe..7ef8edaaed69 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2466,12 +2466,11 @@ static void set_mount_attributes(struct mount *mn=
t, unsigned int mnt_flags)
>         unlock_mount_hash();
>  }
>
> -static void mnt_warn_timestamp_expiry(struct path *mountpoint, struct vf=
smount *mnt)
> +static void mnt_warn_timestamp_expiry(struct path *mountpoint,
> +                                     struct super_block *sb, int mnt_fla=
gs)
>  {
> -       struct super_block *sb =3D mnt->mnt_sb;
> -
> -       if (!__mnt_is_readonly(mnt) &&
> -          (ktime_get_real_seconds() + TIME_UPTIME_SEC_MAX > sb->s_time_m=
ax)) {
> +       if (!(mnt_flags & MNT_READONLY) && !sb_rdonly(sb) &&
> +           (ktime_get_real_seconds() + TIME_UPTIME_SEC_MAX > sb->s_time_=
max)) {
>                 char *buf =3D (char *)__get_free_page(GFP_KERNEL);
>                 char *mntpath =3D buf ? d_path(mountpoint, buf, PAGE_SIZE=
) : ERR_PTR(-ENOMEM);
>                 struct tm tm;
> @@ -2512,7 +2511,7 @@ static int do_reconfigure_mnt(struct path *path, un=
signed int mnt_flags)
>                 set_mount_attributes(mnt, mnt_flags);
>         up_write(&sb->s_umount);
>
> -       mnt_warn_timestamp_expiry(path, &mnt->mnt);
> +       mnt_warn_timestamp_expiry(path, sb, mnt_flags);
>
>         return ret;
>  }
> @@ -2555,7 +2554,7 @@ static int do_remount(struct path *path, int ms_fla=
gs, int sb_flags,
>                 up_write(&sb->s_umount);
>         }
>
> -       mnt_warn_timestamp_expiry(path, &mnt->mnt);
> +       mnt_warn_timestamp_expiry(path, sb, mnt_flags);
>
>         put_fs_context(fc);
>         return err;
> @@ -2770,7 +2769,7 @@ static int do_new_mount_fc(struct fs_context *fc, s=
truct path *mountpoint,
>                 return error;
>         }
>
> -       mnt_warn_timestamp_expiry(mountpoint, mnt);
> +       mnt_warn_timestamp_expiry(mountpoint, sb, mnt_flags);
>
>         return error;
>  }
> --
> 2.23.0
>

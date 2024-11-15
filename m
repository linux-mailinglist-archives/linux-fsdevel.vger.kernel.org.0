Return-Path: <linux-fsdevel+bounces-34954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2439CF0DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 17:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D697AB39477
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 16:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198E4184523;
	Fri, 15 Nov 2024 16:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqcHB7MM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE1F1D516F;
	Fri, 15 Nov 2024 16:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731686410; cv=none; b=ePbC9iXNSyXXee+7QiOFdSDZLvVX/sOX/jTd/z8n+VESLJq9avj/3Ke+wYlJLj7u1J/a0jIJtQR2mYi6Gjd1gOgoHsw1fVlh2BPcOc02/tkE2J2mrtWWJDhcBxKMQufXhWI5wOAsYuPLeXcwlWkBLeSwvfaeKy1ZkSpFZPilCx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731686410; c=relaxed/simple;
	bh=d60me//6fUCiJ+j+rB+jrDkVKTQSZE4GROltLuU3FXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CqGZB5IAOK25VerNz5LyvbbyQZExgwZjyhcj56J50TdrvfcGumY6OwACftsAD8UezwPQ6njFWedIxt9tgrJX92j2RcrSu7MdFfrdj8s/xx2pL7n+zDaBTROgcK+44t/bhPBaLJXlgqNkg1VgbX3CXJAEPX18r6ZrC8QCIu/z3bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HqcHB7MM; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9e71401844so109497266b.3;
        Fri, 15 Nov 2024 08:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731686407; x=1732291207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQTg092nV/nli9mWafZup54AbTt4EJwVfug160hVSro=;
        b=HqcHB7MMuubNUwJgp9+sJ1lO4LkbpR8aFweZjvmAqbaPKIWtq/K7+EHqUif9kZJZUU
         dISyJvWwMrAnPpDv7UGP4BPGpaRxVXjPBdS4yWeGPMHycvHXIWl0VlTb/6COlBWNTJv8
         1DkBmr2HOLdAAfVOF+MP81eCGe9y0D3Y3gwpUgE/yKBEcDlMt8epVdXbrR0o/TF9I8sg
         9u9x0HHPazeSbohq9O6hQlOWrN493GBP9hmqUy/fxDsnid/Jqc7oqb+ZhF5i6UoaNqxG
         +qDulaGQr2icopt8mrr6qg/HccoqtxVmV+5QVrezrvX8g4BzpfN1r/xVsHD7SJy/knZz
         0swg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731686407; x=1732291207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQTg092nV/nli9mWafZup54AbTt4EJwVfug160hVSro=;
        b=Mqm/Mn37JkVjjbrPLLR6qrrXg9+wpUOjcVwlAM+CUlwGWaYDe9y6P58i5DUoVpmTiH
         D5xlclb4xkHdc18z1A7NKCAbYVFJ4CKQLJRQA969odZXdy6hKzAjvlObZZkP+jhfmESo
         ptOUa0ZQ1aGcIdZEqC6gOUqmezcv6S4dcP7L4Na4KIuM0luHbbNlmR+wuUwWn2aJuxue
         9J9vl+AmiZsqxM30HskuU7u644WLs/fT0tf+37DsKzo2PAsVHtAZPmMwB3n22Fgo4MwE
         4wp55vlOhDtP2EmAYbrv+UIOofB711HMDx8umVBfOidlww9f9bNMkLknW4Xb2TSoOUQs
         dZgg==
X-Forwarded-Encrypted: i=1; AJvYcCU+m1G3azFvihQbNezmIXPLzfrm/GdIlBogIA9q2pNt01akKbA0EVXuR1jYA6rHs0NhemfKIU6QEOeusUUj+g==@vger.kernel.org, AJvYcCVcOOuLlNsiKUmeGU7GeOzWv1E/izMgwWjx/2nvVFmDatZECQw+zSu4EZh/3TIE8fxKvuoYvqYVBwMAHA==@vger.kernel.org, AJvYcCWO8AMt6aefR8rwhLGC7dScYhF9Tjm32Boxyw1NhCjv7QnEIFB+34M1VYr8Z+AmAz6JuZxiK/ACHN0zHA==@vger.kernel.org, AJvYcCXnmP67/B2Q88Z9fZ7peeXiQdmsAXfgIByMYgIxHQN4s7/gztq1pl/TDlYvJjCrhiyRZTmrBMLcv53P@vger.kernel.org
X-Gm-Message-State: AOJu0YwXS1CCf74hazd1Cg0Y9G8YE/cwakK++P6eNCkMAU26NYKZnXTU
	ewasju18kZRChLMq/p+zJyssmSAyB5RVBGsrq02tn2OEpDbNH5o+G++GvB2kFIONL4JgtM9CH5M
	geF0nHJp5XiPA/G8X+LAnFKwO93k=
X-Google-Smtp-Source: AGHT+IFkc9XByZYF5KJMTd1KEIU44FpOQRgPj6OoU3IacaF+bG0JSx+iOQAZKu2HAAEQm873FjTeMetbhlknnkMZr0w=
X-Received: by 2002:a17:907:6eaa:b0:a9a:1bb4:800c with SMTP id
 a640c23a62f3a-aa4833e9eb8mr266512266b.4.1731686406476; Fri, 15 Nov 2024
 08:00:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731684329.git.josef@toxicpanda.com> <b80986f8d5b860acea2c9a73c0acd93587be5fe4.1731684329.git.josef@toxicpanda.com>
In-Reply-To: <b80986f8d5b860acea2c9a73c0acd93587be5fe4.1731684329.git.josef@toxicpanda.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 15 Nov 2024 16:59:55 +0100
Message-ID: <CAOQ4uxizf2+E+hq5MM0AGPzAw8Mct7Tzb+kxCURwqBfGVkiE7Q@mail.gmail.com>
Subject: Re: [PATCH v8 10/19] fanotify: introduce FAN_PRE_ACCESS permission event
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	brauner@kernel.org, torvalds@linux-foundation.org, viro@zeniv.linux.org.uk, 
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 4:31=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> From: Amir Goldstein <amir73il@gmail.com>
>
> Similar to FAN_ACCESS_PERM permission event, but it is only allowed with
> class FAN_CLASS_PRE_CONTENT and only allowed on regular files and dirs.
>
> Unlike FAN_ACCESS_PERM, it is safe to write to the file being accessed
> in the context of the event handler.
>
> This pre-content event is meant to be used by hierarchical storage
> managers that want to fill the content of files on first read access.
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/notify/fanotify/fanotify.c      |  3 ++-
>  fs/notify/fanotify/fanotify_user.c | 22 +++++++++++++++++++---
>  include/linux/fanotify.h           | 14 ++++++++++----
>  include/uapi/linux/fanotify.h      |  2 ++
>  4 files changed, 33 insertions(+), 8 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.=
c
> index 2e6ba94ec405..da6c3c1c7edf 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -916,8 +916,9 @@ static int fanotify_handle_event(struct fsnotify_grou=
p *group, u32 mask,
>         BUILD_BUG_ON(FAN_OPEN_EXEC_PERM !=3D FS_OPEN_EXEC_PERM);
>         BUILD_BUG_ON(FAN_FS_ERROR !=3D FS_ERROR);
>         BUILD_BUG_ON(FAN_RENAME !=3D FS_RENAME);
> +       BUILD_BUG_ON(FAN_PRE_ACCESS !=3D FS_PRE_ACCESS);
>
> -       BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) !=3D 21);
> +       BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) !=3D 22);
>
>         mask =3D fanotify_group_event_mask(group, iter_info, &match_mask,
>                                          mask, data, data_type, dir);
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
> index 456cc3e92c88..5ea447e9e5a8 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1640,11 +1640,23 @@ static int fanotify_events_supported(struct fsnot=
ify_group *group,
>                                      unsigned int flags)
>  {
>         unsigned int mark_type =3D flags & FANOTIFY_MARK_TYPE_BITS;
> +       bool is_dir =3D d_is_dir(path->dentry);
>         /* Strict validation of events in non-dir inode mask with v5.17+ =
APIs */
>         bool strict_dir_events =3D FAN_GROUP_FLAG(group, FAN_REPORT_TARGE=
T_FID) ||
>                                  (mask & FAN_RENAME) ||
>                                  (flags & FAN_MARK_IGNORE);
>
> +       /*
> +        * Filesystems need to opt-into pre-content evnets (a.k.a HSM)
> +        * and they are only supported on regular files and directories.
> +        */
> +       if (mask & FANOTIFY_PRE_CONTENT_EVENTS) {
> +               if (!(path->mnt->mnt_sb->s_iflags & SB_I_ALLOW_HSM))
> +                       return -EINVAL;

You missed my latest push of this change.
no worries, for final version want:

                return -EOPNOTSUPP;

> +               if (!is_dir && !d_is_reg(path->dentry))
> +                       return -EINVAL;
> +       }
> +
>         /*
>          * Some filesystems such as 'proc' acquire unusual locks when ope=
ning
>          * files. For them fanotify permission events have high chances o=
f
> @@ -1677,7 +1689,7 @@ static int fanotify_events_supported(struct fsnotif=
y_group *group,
>          * but because we always allowed it, error only when using new AP=
Is.
>          */
>         if (strict_dir_events && mark_type =3D=3D FAN_MARK_INODE &&
> -           !d_is_dir(path->dentry) && (mask & FANOTIFY_DIRONLY_EVENT_BIT=
S))
> +           !is_dir && (mask & FANOTIFY_DIRONLY_EVENT_BITS))
>                 return -ENOTDIR;
>
>         return 0;
> @@ -1778,10 +1790,14 @@ static int do_fanotify_mark(int fanotify_fd, unsi=
gned int flags, __u64 mask,
>                 return -EPERM;
>
>         /*
> -        * Permission events require minimum priority FAN_CLASS_CONTENT.
> +        * Permission events are not allowed for FAN_CLASS_NOTIF.
> +        * Pre-content permission events are not allowed for FAN_CLASS_CO=
NTENT.
>          */
>         if (mask & FANOTIFY_PERM_EVENTS &&
> -           group->priority < FSNOTIFY_PRIO_CONTENT)
> +           group->priority =3D=3D FSNOTIFY_PRIO_NORMAL)
> +               return -EINVAL;
> +       else if (mask & FANOTIFY_PRE_CONTENT_EVENTS &&
> +                group->priority =3D=3D FSNOTIFY_PRIO_CONTENT)
>                 return -EINVAL;
>
>         if (mask & FAN_FS_ERROR &&
> diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> index 89ff45bd6f01..c747af064d2c 100644
> --- a/include/linux/fanotify.h
> +++ b/include/linux/fanotify.h
> @@ -89,6 +89,16 @@
>  #define FANOTIFY_DIRENT_EVENTS (FAN_MOVE | FAN_CREATE | FAN_DELETE | \
>                                  FAN_RENAME)
>
> +/* Content events can be used to inspect file content */
> +#define FANOTIFY_CONTENT_PERM_EVENTS (FAN_OPEN_PERM | FAN_OPEN_EXEC_PERM=
 | \
> +                                     FAN_ACCESS_PERM)
> +/* Pre-content events can be used to fill file content */
> +#define FANOTIFY_PRE_CONTENT_EVENTS  (FAN_PRE_ACCESS)
> +
> +/* Events that require a permission response from user */
> +#define FANOTIFY_PERM_EVENTS   (FANOTIFY_CONTENT_PERM_EVENTS | \
> +                                FANOTIFY_PRE_CONTENT_EVENTS)
> +
>  /* Events that can be reported with event->fd */
>  #define FANOTIFY_FD_EVENTS (FANOTIFY_PATH_EVENTS | FANOTIFY_PERM_EVENTS)
>
> @@ -104,10 +114,6 @@
>                                  FANOTIFY_INODE_EVENTS | \
>                                  FANOTIFY_ERROR_EVENTS)
>
> -/* Events that require a permission response from user */
> -#define FANOTIFY_PERM_EVENTS   (FAN_OPEN_PERM | FAN_ACCESS_PERM | \
> -                                FAN_OPEN_EXEC_PERM)
> -
>  /* Extra flags that may be reported with event or control handling of ev=
ents */
>  #define FANOTIFY_EVENT_FLAGS   (FAN_EVENT_ON_CHILD | FAN_ONDIR)
>
> diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.=
h
> index 79072b6894f2..7596168c80eb 100644
> --- a/include/uapi/linux/fanotify.h
> +++ b/include/uapi/linux/fanotify.h
> @@ -27,6 +27,8 @@
>  #define FAN_OPEN_EXEC_PERM     0x00040000      /* File open/exec in perm=
 check */
>  /* #define FAN_DIR_MODIFY      0x00080000 */   /* Deprecated (reserved) =
*/
>
> +#define FAN_PRE_ACCESS         0x00100000      /* Pre-content access hoo=
k */
> +
>  #define FAN_EVENT_ON_CHILD     0x08000000      /* Interested in child ev=
ents */
>
>  #define FAN_RENAME             0x10000000      /* File was renamed */
> --
> 2.43.0
>


Return-Path: <linux-fsdevel+bounces-4611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4712F801493
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 21:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B18F21F20FD7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 20:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37ECA584EF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 20:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bJCT61a8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DC710F4
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 11:51:29 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1f9efd5303cso541152fac.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 11:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701460289; x=1702065089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWkyQKSMPXuhnwWM9KIIG/qJZSF1nHdtj4fWIP4r6L8=;
        b=bJCT61a8oZrOLDE0M3mZvGdg7c9lxuBKzrrCsHlilXV8U5w/gEZUqXM4OAQUPpjSKb
         eIgDOXjyeT4AHGb32sbLNxzlclJbu6WohrlmmqAfSQUxAU5ATkV3vYRaGVrbQdrieUnk
         cl1rVxhgWdr+kz66STv4WJrBw6Y/weFHm46yM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701460289; x=1702065089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWkyQKSMPXuhnwWM9KIIG/qJZSF1nHdtj4fWIP4r6L8=;
        b=JxdLBRAtLfMgETqPvNP+ZJ12sipVeoiHmsyE/mBPjSyRBuS6nQFUa4tKatqaTSQSo5
         0nR9Z3Pf9xIdUHrMUM9qnUrfrwHiENrz7ZNhggeMv0mtZeg/6Yg6pm1xzPClQCQpD2km
         jmEtlW+PEbmAtVsYDUS0HUu+iiRPxoe+kElxQl4NP8UUkH4vj3J19KGKaMePiVls0czA
         bx+Prm8z/HG6Y0Pmv9lHA4udYWX/lVp7/SqHKDZzVTJ/BXO9v6ydBu4RxJxa0mX7/ZpJ
         wmJHY7PAnbGoR6kedIpSsKIIkEQsdy2c5l8MSUTc9hdMsVGDHW85eEZbVve3Qf0iMTV8
         wGMg==
X-Gm-Message-State: AOJu0Yxwjgu4Ckn0jiO11mwJEs6id/6zEGiE5oMPhHJAShrfdK3AywDl
	aYnMjvadTIWVzxXvtsD22HKM7qhhFtTIp4aMCbc1ww==
X-Google-Smtp-Source: AGHT+IHJiyDN53r3/TNMLrZy2j+9uLs1bznR9uq79i4PsvefjrqudynVH1dJZXLK0ZgEPzOWqcnvPX/c0GMoPFnMIn0=
X-Received: by 2002:a05:6871:8782:b0:1fa:fa0a:bb40 with SMTP id
 td2-20020a056871878200b001fafa0abb40mr37594oab.18.1701460288757; Fri, 01 Dec
 2023 11:51:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201143042.3276833-1-gnoack@google.com> <20231201143042.3276833-5-gnoack@google.com>
In-Reply-To: <20231201143042.3276833-5-gnoack@google.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 1 Dec 2023 11:51:16 -0800
Message-ID: <CABi2SkXvTdrygc4rNmKBSRT5DRv_FeoX+y26JruBbeX_MwwLTQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/9] landlock: Add IOCTL access right
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 6:40=E2=80=AFAM G=C3=BCnther Noack <gnoack@google.co=
m> wrote:
>
> Introduces the LANDLOCK_ACCESS_FS_IOCTL access right
> and increments the Landlock ABI version to 5.
>
> Like the truncate right, these rights are associated with a file
> descriptor at the time of open(2), and get respected even when the
> file descriptor is used outside of the thread which it was originally
> opened in.
>
> A newly enabled Landlock policy therefore does not apply to file
> descriptors which are already open.
>
> If the LANDLOCK_ACCESS_FS_IOCTL right is handled, only a small number
> of safe IOCTL commands will be permitted on newly opened files.  The
> permitted IOCTLs can be configured through the ruleset in limited ways
> now.  (See documentation for details.)
>
> Noteworthy scenarios which require special attention:
>
> TTY devices support IOCTLs like TIOCSTI and TIOCLINUX, which can be
> used to control shell processes on the same terminal which run at
> different privilege levels, which may make it possible to escape a
> sandbox.  Because stdin, stdout and stderr are normally inherited
> rather than newly opened, IOCTLs are usually permitted on them even
> after the Landlock policy is enforced.
>
> Some legitimate file system features, like setting up fscrypt, are
> exposed as IOCTL commands on regular files and directories -- users of
> Landlock are advised to double check that the sandboxed process does
> not need to invoke these IOCTLs.
>
> Known limitations:
>
> The LANDLOCK_ACCESS_FS_IOCTL access right is a coarse-grained control
> over IOCTL commands.  Future work will enable a more fine-grained
> access control for IOCTLs.
>
> In the meantime, Landlock users may use path-based restrictions in
> combination with their knowledge about the file system layout to
> control what IOCTLs can be done.  Mounting file systems with the nodev
> option can help to distinguish regular files and devices, and give
> guarantees about the affected files, which Landlock alone can not give
> yet.
>
> Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
> ---
>  include/uapi/linux/landlock.h                |  58 +++++-
>  security/landlock/fs.c                       | 176 ++++++++++++++++++-
>  security/landlock/fs.h                       |   2 +
>  security/landlock/limits.h                   |   5 +-
>  security/landlock/ruleset.h                  |   2 +-
>  security/landlock/syscalls.c                 |  19 +-
>  tools/testing/selftests/landlock/base_test.c |   2 +-
>  tools/testing/selftests/landlock/fs_test.c   |   5 +-
>  8 files changed, 247 insertions(+), 22 deletions(-)
>
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.=
h
> index 25c8d7677539..578f268b084b 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -128,7 +128,7 @@ struct landlock_net_port_attr {
>   * files and directories.  Files or directories opened before the sandbo=
xing
>   * are not subject to these restrictions.
>   *
> - * A file can only receive these access rights:
> + * The following access rights apply only to files:
>   *
>   * - %LANDLOCK_ACCESS_FS_EXECUTE: Execute a file.
>   * - %LANDLOCK_ACCESS_FS_WRITE_FILE: Open a file with write access. Note=
 that
> @@ -138,12 +138,13 @@ struct landlock_net_port_attr {
>   * - %LANDLOCK_ACCESS_FS_READ_FILE: Open a file with read access.
>   * - %LANDLOCK_ACCESS_FS_TRUNCATE: Truncate a file with :manpage:`trunca=
te(2)`,
>   *   :manpage:`ftruncate(2)`, :manpage:`creat(2)`, or :manpage:`open(2)`=
 with
> - *   ``O_TRUNC``. Whether an opened file can be truncated with
> - *   :manpage:`ftruncate(2)` is determined during :manpage:`open(2)`, in=
 the
> - *   same way as read and write permissions are checked during
> - *   :manpage:`open(2)` using %LANDLOCK_ACCESS_FS_READ_FILE and
> - *   %LANDLOCK_ACCESS_FS_WRITE_FILE. This access right is available sinc=
e the
> - *   third version of the Landlock ABI.
> + *   ``O_TRUNC``.  This access right is available since the third versio=
n of the
> + *   Landlock ABI.
> + *
> + * Whether an opened file can be truncated with :manpage:`ftruncate(2)` =
or used
> + * with `ioctl(2)` is determined during :manpage:`open(2)`, in the same =
way as
> + * read and write permissions are checked during :manpage:`open(2)` usin=
g
> + * %LANDLOCK_ACCESS_FS_READ_FILE and %LANDLOCK_ACCESS_FS_WRITE_FILE.
>   *
>   * A directory can receive access rights related to files or directories=
.  The
>   * following access right is applied to the directory itself, and the
> @@ -198,13 +199,53 @@ struct landlock_net_port_attr {
>   *   If multiple requirements are not met, the ``EACCES`` error code tak=
es
>   *   precedence over ``EXDEV``.
>   *
> + * The following access right applies both to files and directories:
> + *
> + * - %LANDLOCK_ACCESS_FS_IOCTL: Invoke :manpage:`ioctl(2)` commands on a=
n opened
> + *   file or directory.
> + *
> + *   This access right applies to all :manpage:`ioctl(2)` commands, exce=
pt of
> + *   ``FIOCLEX``, ``FIONCLEX``, ``FIONBIO`` and ``FIOASYNC``.  These com=
mands
> + *   continue to be invokable independent of the %LANDLOCK_ACCESS_FS_IOC=
TL
> + *   access right.
> + *
> + *   When certain other access rights are handled in the ruleset, in add=
ition to
> + *   %LANDLOCK_ACCESS_FS_IOCTL, granting these access rights will unlock=
 access
> + *   to additional groups of IOCTL commands, on the affected files:
> + *
> + *   * %LANDLOCK_ACCESS_FS_READ_FILE unlocks access to ``FIOQSIZE``,
> + *     ``FS_IOC_FIEMAP``, ``FIBMAP``, ``FIGETBSZ``, ``FIONREAD``,
> + *     ``FIDEDUPRANGE``.
> + *
> + *   * %LANDLOCK_ACCESS_FS_WRITE_FILE unlocks access to ``FIOQSIZE``,
> + *     ``FS_IOC_FIEMAP``, ``FIBMAP``, ``FIGETBSZ``, ``FICLONE``,
> + *     ``FICLONERANGE``, ``FS_IOC_RESVSP``, ``FS_IOC_RESVSP64``,
> + *     ``FS_IOC_UNRESVSP``, ``FS_IOC_UNRESVSP64``, ``FS_IOC_ZERO_RANGE``=
.
> + *
> + *   * %LANDLOCK_ACCESS_FS_READ_DIR unlocks access to ``FIOQSIZE``,
> + *     ``FS_IOC_FIEMAP``, ``FIBMAP``, ``FIGETBSZ``.
> + *
> + *   When these access rights are handled in the ruleset, the availabili=
ty of
> + *   the affected IOCTL commands is not governed by %LANDLOCK_ACCESS_FS_=
IOCTL
> + *   any more, but by the respective access right.
> + *
> + *   All other IOCTL commands are not handled specially, and are governe=
d by
> + *   %LANDLOCK_ACCESS_FS_IOCTL.  This includes %FS_IOC_GETFLAGS and
> + *   %FS_IOC_SETFLAGS for manipulating inode flags (:manpage:`ioctl_ifla=
gs(2)`),
> + *   %FS_IOC_FSFETXATTR and %FS_IOC_FSSETXATTR for manipulating extended
> + *   attributes, as well as %FIFREEZE and %FITHAW for freezing and thawi=
ng file
> + *   systems.
> + *
> + *   This access right is available since the fifth version of the Landl=
ock
> + *   ABI.
> + *
>   * .. warning::
>   *
>   *   It is currently not possible to restrict some file-related actions
>   *   accessible through these syscall families: :manpage:`chdir(2)`,
>   *   :manpage:`stat(2)`, :manpage:`flock(2)`, :manpage:`chmod(2)`,
>   *   :manpage:`chown(2)`, :manpage:`setxattr(2)`, :manpage:`utime(2)`,
> - *   :manpage:`ioctl(2)`, :manpage:`fcntl(2)`, :manpage:`access(2)`.
> + *   :manpage:`fcntl(2)`, :manpage:`access(2)`.
>   *   Future Landlock evolutions will enable to restrict them.
>   */
>  /* clang-format off */
> @@ -223,6 +264,7 @@ struct landlock_net_port_attr {
>  #define LANDLOCK_ACCESS_FS_MAKE_SYM                    (1ULL << 12)
>  #define LANDLOCK_ACCESS_FS_REFER                       (1ULL << 13)
>  #define LANDLOCK_ACCESS_FS_TRUNCATE                    (1ULL << 14)
> +#define LANDLOCK_ACCESS_FS_IOCTL                       (1ULL << 15)
>  /* clang-format on */
>
>  /**
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 9ba989ef46a5..81ce41e9e6db 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -7,12 +7,14 @@
>   * Copyright =C2=A9 2021-2022 Microsoft Corporation
>   */
>
> +#include <asm/ioctls.h>
>  #include <linux/atomic.h>
>  #include <linux/bitops.h>
>  #include <linux/bits.h>
>  #include <linux/compiler_types.h>
>  #include <linux/dcache.h>
>  #include <linux/err.h>
> +#include <linux/falloc.h>
>  #include <linux/fs.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> @@ -28,6 +30,7 @@
>  #include <linux/types.h>
>  #include <linux/wait_bit.h>
>  #include <linux/workqueue.h>
> +#include <uapi/linux/fiemap.h>
>  #include <uapi/linux/landlock.h>
>
>  #include "common.h"
> @@ -83,6 +86,145 @@ static const struct landlock_object_underops landlock=
_fs_underops =3D {
>         .release =3D release_inode
>  };
>
> +/* IOCTL helpers */
> +
> +/*
> + * These are synthetic access rights, which are only used within the ker=
nel, but
> + * not exposed to callers in userspace.  The mapping between these acces=
s rights
> + * and IOCTL commands is defined in the required_ioctl_access() helper f=
unction.
> + */
> +#define LANDLOCK_ACCESS_FS_IOCTL_GROUP1 (LANDLOCK_LAST_PUBLIC_ACCESS_FS =
<< 1)
> +#define LANDLOCK_ACCESS_FS_IOCTL_GROUP2 (LANDLOCK_LAST_PUBLIC_ACCESS_FS =
<< 2)
> +#define LANDLOCK_ACCESS_FS_IOCTL_GROUP3 (LANDLOCK_LAST_PUBLIC_ACCESS_FS =
<< 3)
> +#define LANDLOCK_ACCESS_FS_IOCTL_GROUP4 (LANDLOCK_LAST_PUBLIC_ACCESS_FS =
<< 4)
> +
> +/* ioctl_groups - all synthetic access rights for IOCTL command groups *=
/
> +/* clang-format off */
> +#define IOCTL_GROUPS (                   \
> +       LANDLOCK_ACCESS_FS_IOCTL_GROUP1 | \
> +       LANDLOCK_ACCESS_FS_IOCTL_GROUP2 | \
> +       LANDLOCK_ACCESS_FS_IOCTL_GROUP3 | \
> +       LANDLOCK_ACCESS_FS_IOCTL_GROUP4)
> +/* clang-format on */
> +
> +static_assert((IOCTL_GROUPS & LANDLOCK_MASK_ACCESS_FS) =3D=3D IOCTL_GROU=
PS);
> +
> +/**
> + * required_ioctl_access(): Determine required IOCTL access rights.
> + *
> + * @cmd: The IOCTL command that is supposed to be run.
> + *
> + * Returns: The access rights that must be granted on an opened file in =
order to
> + * use the given @cmd.
> + */
> +static access_mask_t required_ioctl_access(unsigned int cmd)
> +{
> +       switch (cmd) {
> +       case FIOCLEX:
> +       case FIONCLEX:
> +       case FIONBIO:
> +       case FIOASYNC:
> +               /*
> +                * FIOCLEX, FIONCLEX, FIONBIO and FIOASYNC manipulate the=
 FD's
> +                * close-on-exec and the file's buffered-IO and async fla=
gs.
> +                * These operations are also available through fcntl(2),
> +                * and are unconditionally permitted in Landlock.
> +                */
> +               return 0;
> +       case FIOQSIZE:
> +               return LANDLOCK_ACCESS_FS_IOCTL_GROUP1;
> +       case FS_IOC_FIEMAP:
> +       case FIBMAP:
> +       case FIGETBSZ:
> +               return LANDLOCK_ACCESS_FS_IOCTL_GROUP2;
> +       case FIONREAD:
> +       case FIDEDUPERANGE:
> +               return LANDLOCK_ACCESS_FS_IOCTL_GROUP3;
> +       case FICLONE:
> +       case FICLONERANGE:
> +       case FS_IOC_RESVSP:
> +       case FS_IOC_RESVSP64:
> +       case FS_IOC_UNRESVSP:
> +       case FS_IOC_UNRESVSP64:
> +       case FS_IOC_ZERO_RANGE:
> +               return LANDLOCK_ACCESS_FS_IOCTL_GROUP4;
> +       default:
> +               /*
> +                * Other commands are guarded by the catch-all access rig=
ht.
> +                */
> +               return LANDLOCK_ACCESS_FS_IOCTL;
> +       }
> +}
> +
> +/**
> + * expand_ioctl() - Return the dst flags from either the src flag or the
> + * %LANDLOCK_ACCESS_FS_IOCTL flag, depending on whether the
> + * %LANDLOCK_ACCESS_FS_IOCTL and src access rights are handled or not.
> + *
> + * @handled: Handled access rights.
> + * @access: The access mask to copy values from.
> + * @src: A single access right to copy from in @access.
> + * @dst: One or more access rights to copy to.
> + *
> + * Returns: @dst, or 0.
> + */
> +static access_mask_t expand_ioctl(const access_mask_t handled,
> +                                 const access_mask_t access,
> +                                 const access_mask_t src,
> +                                 const access_mask_t dst)
> +{
> +       access_mask_t copy_from;
> +
> +       if (!(handled & LANDLOCK_ACCESS_FS_IOCTL))
> +               return 0;
> +
> +       copy_from =3D (handled & src) ? src : LANDLOCK_ACCESS_FS_IOCTL;
> +       if (access & copy_from)
> +               return dst;
> +
> +       return 0;
> +}
> +
> +/**
> + * landlock_expand_access_fs() - Returns @access with the synthetic IOCT=
L group
> + * flags enabled if necessary.
> + *
> + * @handled: Handled FS access rights.
> + * @access: FS access rights to expand.
> + *
> + * Returns: @access expanded by the necessary flags for the synthetic IO=
CTL
> + * access rights.
> + */
> +static access_mask_t landlock_expand_access_fs(const access_mask_t handl=
ed,
> +                                              const access_mask_t access=
)
> +{
> +       return access |
> +              expand_ioctl(handled, access, LANDLOCK_ACCESS_FS_WRITE_FIL=
E,
> +                           LANDLOCK_ACCESS_FS_IOCTL_GROUP1 |
> +                                   LANDLOCK_ACCESS_FS_IOCTL_GROUP2 |
> +                                   LANDLOCK_ACCESS_FS_IOCTL_GROUP4) |
> +              expand_ioctl(handled, access, LANDLOCK_ACCESS_FS_READ_FILE=
,
> +                           LANDLOCK_ACCESS_FS_IOCTL_GROUP1 |
> +                                   LANDLOCK_ACCESS_FS_IOCTL_GROUP2 |
> +                                   LANDLOCK_ACCESS_FS_IOCTL_GROUP3) |
> +              expand_ioctl(handled, access, LANDLOCK_ACCESS_FS_READ_DIR,
> +                           LANDLOCK_ACCESS_FS_IOCTL_GROUP1);
> +}
> +
> +/**
> + * landlock_expand_handled_access_fs() - add synthetic IOCTL access righ=
ts to an
> + * access mask of handled accesses.
> + *
> + * @handled: The handled accesses of a ruleset that is being created.
> + *
> + * Returns: @handled, with the bits for the synthetic IOCTL access right=
s set,
> + * if %LANDLOCK_ACCESS_FS_IOCTL is handled.
> + */
> +access_mask_t landlock_expand_handled_access_fs(const access_mask_t hand=
led)
> +{
> +       return landlock_expand_access_fs(handled, handled);
> +}
> +
>  /* Ruleset management */
>
>  static struct landlock_object *get_inode_object(struct inode *const inod=
e)
> @@ -147,7 +289,8 @@ static struct landlock_object *get_inode_object(struc=
t inode *const inode)
>         LANDLOCK_ACCESS_FS_EXECUTE | \
>         LANDLOCK_ACCESS_FS_WRITE_FILE | \
>         LANDLOCK_ACCESS_FS_READ_FILE | \
> -       LANDLOCK_ACCESS_FS_TRUNCATE)
> +       LANDLOCK_ACCESS_FS_TRUNCATE | \
> +       LANDLOCK_ACCESS_FS_IOCTL)
>  /* clang-format on */
>
>  /*
> @@ -157,6 +300,7 @@ int landlock_append_fs_rule(struct landlock_ruleset *=
const ruleset,
>                             const struct path *const path,
>                             access_mask_t access_rights)
>  {
> +       access_mask_t handled;
>         int err;
>         struct landlock_id id =3D {
>                 .type =3D LANDLOCK_KEY_INODE,
> @@ -169,9 +313,11 @@ int landlock_append_fs_rule(struct landlock_ruleset =
*const ruleset,
>         if (WARN_ON_ONCE(ruleset->num_layers !=3D 1))
>                 return -EINVAL;
>
> +       handled =3D landlock_get_fs_access_mask(ruleset, 0);
> +       /* Expands the synthetic IOCTL groups. */
> +       access_rights |=3D landlock_expand_access_fs(handled, access_righ=
ts);
>         /* Transforms relative access rights to absolute ones. */
> -       access_rights |=3D LANDLOCK_MASK_ACCESS_FS &
> -                        ~landlock_get_fs_access_mask(ruleset, 0);
> +       access_rights |=3D LANDLOCK_MASK_ACCESS_FS & ~handled;
>         id.key.object =3D get_inode_object(d_backing_inode(path->dentry))=
;
>         if (IS_ERR(id.key.object))
>                 return PTR_ERR(id.key.object);
> @@ -1123,7 +1269,9 @@ static int hook_file_open(struct file *const file)
>  {
>         layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] =3D {};
>         access_mask_t open_access_request, full_access_request, allowed_a=
ccess;
> -       const access_mask_t optional_access =3D LANDLOCK_ACCESS_FS_TRUNCA=
TE;
> +       const access_mask_t optional_access =3D LANDLOCK_ACCESS_FS_TRUNCA=
TE |
> +                                             LANDLOCK_ACCESS_FS_IOCTL |
> +                                             IOCTL_GROUPS;
>         const struct landlock_ruleset *const dom =3D get_current_fs_domai=
n();
>
>         if (!dom)
> @@ -1196,6 +1344,25 @@ static int hook_file_truncate(struct file *const f=
ile)
>         return -EACCES;
>  }
>
> +static int hook_file_ioctl(struct file *file, unsigned int cmd,
> +                          unsigned long arg)
> +{
> +       const access_mask_t required_access =3D required_ioctl_access(cmd=
);
> +       const access_mask_t allowed_access =3D
> +               landlock_file(file)->allowed_access;
> +
> +       /*
> +        * It is the access rights at the time of opening the file which
> +        * determine whether IOCTL can be used on the opened file later.
> +        *
> +        * The access right is attached to the opened file in hook_file_o=
pen().
> +        */
> +       if ((allowed_access & required_access) =3D=3D required_access)
> +               return 0;
> +
> +       return -EACCES;
> +}
> +
>  static struct security_hook_list landlock_hooks[] __ro_after_init =3D {
>         LSM_HOOK_INIT(inode_free_security, hook_inode_free_security),
>
> @@ -1218,6 +1385,7 @@ static struct security_hook_list landlock_hooks[] _=
_ro_after_init =3D {
>         LSM_HOOK_INIT(file_alloc_security, hook_file_alloc_security),
>         LSM_HOOK_INIT(file_open, hook_file_open),
>         LSM_HOOK_INIT(file_truncate, hook_file_truncate),
> +       LSM_HOOK_INIT(file_ioctl, hook_file_ioctl),
>  };
>
>  __init void landlock_add_fs_hooks(void)
> diff --git a/security/landlock/fs.h b/security/landlock/fs.h
> index 488e4813680a..c88fe7bda37b 100644
> --- a/security/landlock/fs.h
> +++ b/security/landlock/fs.h
> @@ -92,4 +92,6 @@ int landlock_append_fs_rule(struct landlock_ruleset *co=
nst ruleset,
>                             const struct path *const path,
>                             access_mask_t access_hierarchy);
>
> +access_mask_t landlock_expand_handled_access_fs(const access_mask_t hand=
led);
> +
>  #endif /* _SECURITY_LANDLOCK_FS_H */
> diff --git a/security/landlock/limits.h b/security/landlock/limits.h
> index 93c9c6f91556..63b5aa0bd8fa 100644
> --- a/security/landlock/limits.h
> +++ b/security/landlock/limits.h
> @@ -18,7 +18,10 @@
>  #define LANDLOCK_MAX_NUM_LAYERS                16
>  #define LANDLOCK_MAX_NUM_RULES         U32_MAX
>
> -#define LANDLOCK_LAST_ACCESS_FS                LANDLOCK_ACCESS_FS_TRUNCA=
TE
> +#define LANDLOCK_LAST_PUBLIC_ACCESS_FS LANDLOCK_ACCESS_FS_IOCTL

iiuc, for the next feature, it only needs to update
LANDLOCK_LAST_PUBLIC_ACCESS_FS to the new LANDLOCK_ACCESS_FS_ABC here.
and keep below the same, right ?

> +#define LANDLOCK_MASK_PUBLIC_ACCESS_FS ((LANDLOCK_LAST_PUBLIC_ACCESS_FS =
<< 1) - 1)
> +
> +#define LANDLOCK_LAST_ACCESS_FS                (LANDLOCK_LAST_PUBLIC_ACC=
ESS_FS << 4)
maybe add a comment why "<<4" is used ?

>  #define LANDLOCK_MASK_ACCESS_FS                ((LANDLOCK_LAST_ACCESS_FS=
 << 1) - 1)
>  #define LANDLOCK_NUM_ACCESS_FS         __const_hweight64(LANDLOCK_MASK_A=
CCESS_FS)
>  #define LANDLOCK_SHIFT_ACCESS_FS       0
> diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
> index c7f1526784fd..5a28ea8e1c3d 100644
> --- a/security/landlock/ruleset.h
> +++ b/security/landlock/ruleset.h
> @@ -30,7 +30,7 @@
>         LANDLOCK_ACCESS_FS_REFER)
>  /* clang-format on */
>
> -typedef u16 access_mask_t;
> +typedef u32 access_mask_t;
>  /* Makes sure all filesystem access rights can be stored. */
>  static_assert(BITS_PER_TYPE(access_mask_t) >=3D LANDLOCK_NUM_ACCESS_FS);
>  /* Makes sure all network access rights can be stored. */
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index 898358f57fa0..f0bc50003b46 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -137,7 +137,7 @@ static const struct file_operations ruleset_fops =3D =
{
>         .write =3D fop_dummy_write,
>  };
>
> -#define LANDLOCK_ABI_VERSION 4
> +#define LANDLOCK_ABI_VERSION 5
>
>  /**
>   * sys_landlock_create_ruleset - Create a new ruleset
> @@ -192,8 +192,8 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
>                 return err;
>
>         /* Checks content (and 32-bits cast). */
> -       if ((ruleset_attr.handled_access_fs | LANDLOCK_MASK_ACCESS_FS) !=
=3D
> -           LANDLOCK_MASK_ACCESS_FS)
> +       if ((ruleset_attr.handled_access_fs | LANDLOCK_MASK_PUBLIC_ACCESS=
_FS) !=3D
> +           LANDLOCK_MASK_PUBLIC_ACCESS_FS)
>                 return -EINVAL;
>
>         /* Checks network content (and 32-bits cast). */
> @@ -201,6 +201,10 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
>             LANDLOCK_MASK_ACCESS_NET)
>                 return -EINVAL;
>
> +       /* Expands synthetic IOCTL groups. */
> +       ruleset_attr.handled_access_fs =3D landlock_expand_handled_access=
_fs(
> +               ruleset_attr.handled_access_fs);
> +
>         /* Checks arguments and transforms to kernel struct. */
>         ruleset =3D landlock_create_ruleset(ruleset_attr.handled_access_f=
s,
>                                           ruleset_attr.handled_access_net=
);
> @@ -309,8 +313,13 @@ static int add_rule_path_beneath(struct landlock_rul=
eset *const ruleset,
>         if (!path_beneath_attr.allowed_access)
>                 return -ENOMSG;
>
> -       /* Checks that allowed_access matches the @ruleset constraints. *=
/
> -       mask =3D landlock_get_raw_fs_access_mask(ruleset, 0);
> +       /*
> +        * Checks that allowed_access matches the @ruleset constraints an=
d only
> +        * consists of publicly visible access rights (as opposed to synt=
hetic
> +        * ones).
> +        */
> +       mask =3D landlock_get_raw_fs_access_mask(ruleset, 0) &
> +              LANDLOCK_MASK_PUBLIC_ACCESS_FS;
>         if ((path_beneath_attr.allowed_access | mask) !=3D mask)
>                 return -EINVAL;
>
> diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing=
/selftests/landlock/base_test.c
> index 646f778dfb1e..d292b419ccba 100644
> --- a/tools/testing/selftests/landlock/base_test.c
> +++ b/tools/testing/selftests/landlock/base_test.c
> @@ -75,7 +75,7 @@ TEST(abi_version)
>         const struct landlock_ruleset_attr ruleset_attr =3D {
>                 .handled_access_fs =3D LANDLOCK_ACCESS_FS_READ_FILE,
>         };
> -       ASSERT_EQ(4, landlock_create_ruleset(NULL, 0,
> +       ASSERT_EQ(5, landlock_create_ruleset(NULL, 0,
>                                              LANDLOCK_CREATE_RULESET_VERS=
ION));
>
>         ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/s=
elftests/landlock/fs_test.c
> index 50818904397c..192608c3e840 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -525,9 +525,10 @@ TEST_F_FORK(layout1, inval)
>         LANDLOCK_ACCESS_FS_EXECUTE | \
>         LANDLOCK_ACCESS_FS_WRITE_FILE | \
>         LANDLOCK_ACCESS_FS_READ_FILE | \
> -       LANDLOCK_ACCESS_FS_TRUNCATE)
> +       LANDLOCK_ACCESS_FS_TRUNCATE | \
> +       LANDLOCK_ACCESS_FS_IOCTL)
>
> -#define ACCESS_LAST LANDLOCK_ACCESS_FS_TRUNCATE
> +#define ACCESS_LAST LANDLOCK_ACCESS_FS_IOCTL
>
>  #define ACCESS_ALL ( \
>         ACCESS_FILE | \
> --
> 2.43.0.rc2.451.g8631bc7472-goog
>
>


Return-Path: <linux-fsdevel+bounces-42062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0DAA3BDB2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 13:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 256EE1897BC3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 11:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EE11DF265;
	Wed, 19 Feb 2025 11:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqP3SZUM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD4A1DE4F1;
	Wed, 19 Feb 2025 11:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739966343; cv=none; b=AscQ6BsNx+/INDLIQmSjKa84vf9tLKoGO09ieS+Um2JiZcdTu8+BA7n1/PTxYs2c19WcshdMWhplnVP1ARAYHhIf53EWfmPNyw8eR48UXomGjlWZ8GgYhXRZRLogjrY2pV35x4xuZ1H8OGVmTqVGVM7x1K/hTfjOU0GBCY2Xllo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739966343; c=relaxed/simple;
	bh=+8E+Tp3IJf4a/K04iCQAPxr+DuwdESTQYelrCyfd8QM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hhDYFgCGB0i3kaW10gNbuCAwTPulaqJ0QWtgbZof5c8D1pNHv8exn4JxlMyWXsv9IfsTiPXoJN3cEVokYQWzaN+i8Tqq5JP3euAlLyH0S+O9jUqtweolBjSzvNskHFE+EgZwbR3q1LOMTk6TWxeSWmw+/Qx4gncmU5ySCkJWx/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqP3SZUM; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e0505275b7so5986673a12.3;
        Wed, 19 Feb 2025 03:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739966340; x=1740571140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83jqep/4cCVQ82axkl9XjMreVK5wzoStksIYL/TaPVM=;
        b=AqP3SZUMuKYrIxMpG57u5EZJTMPj4RgbP2qO30I/5sOUPwbujFrCZSHP3wPwP8MBDM
         2LDxdUlOB21RtwDEtLWw/+pQWvcSjXMAKJmoULS0gIVjpF1PuNb5I6vN4/IJS94y4SvQ
         PJ3quuAM13nR48HO5hGfS0g2zuOvnR02Sd5bLWPb+36Qi9IHfdmXSLZDKwR7rLUZWYOC
         6mh6ftr9FlJMMOHxN7pbQn96F9eNBS0QIGyh+pmkulcYRJq3C3wsNgnbMqi0gX1d2uec
         8vnJxqkIehf6DYIViu/srbofK2RrzrXdP3LpbYV3VNoUig+qw8/Vel6/JcPH1g9AJyYC
         bG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739966340; x=1740571140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=83jqep/4cCVQ82axkl9XjMreVK5wzoStksIYL/TaPVM=;
        b=ZIRVS3UV/CGOPLW0OZ0POqUczdwKjy8n7Hfj59tZurZBLTUyNMqMrfCZNXxZ5Q6ais
         OWTt0szFxuTMHslPw384D6x3D15geplXOTbQvYJilAjXDLbKYMXvQa9vdbfVSyPKoHys
         C380U9piL/MorKPuT8PkfjOI8RTELj4uQ5vodvVQbv7qj5nDeWiFwG5/kvBwQLFTlWwi
         Dw9uJO/RYuilZsoQzFR+78hdgmGDeaN3gR2Tlf8s8mPoYiGvc/d7fGkPxT2zwmscwKjn
         A0PZ/cTsWYx/HdXNCMS25Np+pZT687oehDSbd6nzgIWHiLa8R1Vjso/i8je3kSRjWiuX
         vgmw==
X-Forwarded-Encrypted: i=1; AJvYcCUOwVa4hxca5ErSzxaYpfRmPaC2IHOsUgC6J4BkRW5HnmV0nWv1ExVywyxnOH/ZxwSm9/RIvx8QGot/+vKv/Q==@vger.kernel.org, AJvYcCXqg1UqKUKUQTfYhuIZoklYPRnb93T0b1W5Lg4292mtmVbcd/UUs2b8wc9MRCRGx47JshmvTNyBeuodGBRW@vger.kernel.org
X-Gm-Message-State: AOJu0YxyGsBAhOFNuZhSrNVZ9g3y6Jg3gho6jgd4vvHFW9IW6tRpxUsK
	NAcDPN7JwtbGLr1PhB7W+ZkC/sK2ppWdqM6/VKCVrHgFegUNlwNvfh0mtc81PUmoWKeehsKXrHw
	So8ZWR7JzSUqscDtQZ7hpsu/YX6o=
X-Gm-Gg: ASbGncsBraIHpPm4gK5T1W9ftxeQyu6wi0nlhmB8BEEMrW+gQ/CYNxHCmM+w12l2lNJ
	fmMx6DankgiO0lZAq5/YNvNgjLi9JX1Qs+o1Wg1188TWd1eB88MT4vpWuQRJLytZQrLTcCm3a
X-Google-Smtp-Source: AGHT+IGpSOMqup7l3ifK3V71zakqNsKCvo7XkXKcj92bgSmvAl4cU1cw35LiDCsiRdLq+qMUwa471jz6eTYFzBzMOuY=
X-Received: by 2002:a05:6402:50ca:b0:5e0:4a92:6b34 with SMTP id
 4fb4d7f45d1cf-5e089516998mr2970063a12.12.1739966339327; Wed, 19 Feb 2025
 03:58:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219-work-overlayfs-v3-0-46af55e4ceda@kernel.org> <20250219-work-overlayfs-v3-4-46af55e4ceda@kernel.org>
In-Reply-To: <20250219-work-overlayfs-v3-4-46af55e4ceda@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 19 Feb 2025 12:58:48 +0100
X-Gm-Features: AWEUYZkVobRRw6w9EW299HDHp8ljiu2E96Kg27ESwUqqgkjAiFtG5ARMgNEz5MM
Message-ID: <CAOQ4uxifdNi3Tg0XMjSoT5M-iwGHLBXELvRSnXO6dMm12kmgAA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] selftests/ovl: add third selftest for "override_creds"
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Seth Forshee <sforshee@kernel.org>, 
	Gopal Kakivaya <gopalk@microsoft.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 11:02=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> Add a simple test to verify that the new "override_creds" option works.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  .../filesystems/overlayfs/set_layers_via_fds.c     | 80 ++++++++++++++++=
++++++
>  tools/testing/selftests/filesystems/utils.c        | 27 ++++++++
>  tools/testing/selftests/filesystems/utils.h        |  1 +
>  3 files changed, 108 insertions(+)
>
> diff --git a/tools/testing/selftests/filesystems/overlayfs/set_layers_via=
_fds.c b/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
> index 6b65e3610578..fd1e5d7c13a3 100644
> --- a/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
> +++ b/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
> @@ -8,6 +8,7 @@
>  #include <string.h>
>  #include <sys/socket.h>
>  #include <sys/stat.h>
> +#include <sys/sysmacros.h>
>  #include <sys/mount.h>
>  #include <unistd.h>
>
> @@ -442,4 +443,83 @@ TEST_F(set_layers_via_fds, set_override_creds_invali=
d)
>         ASSERT_EQ(close(fd_userns2), 0);
>  }
>
> +TEST_F(set_layers_via_fds, set_override_creds_nomknod)
> +{
> +       int fd_context, fd_tmpfs, fd_overlay;
> +       int layer_fds[] =3D { [0 ... 3] =3D -EBADF };
> +       pid_t pid;
> +       int pidfd;
> +
> +       ASSERT_EQ(unshare(CLONE_NEWNS), 0);
> +       ASSERT_EQ(sys_mount(NULL, "/", NULL, MS_SLAVE | MS_REC, NULL), 0)=
;
> +
> +       fd_context =3D sys_fsopen("tmpfs", 0);
> +       ASSERT_GE(fd_context, 0);
> +
> +       ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_CMD_CREATE, NULL, NUL=
L, 0), 0);
> +       fd_tmpfs =3D sys_fsmount(fd_context, 0, 0);
> +       ASSERT_GE(fd_tmpfs, 0);
> +       ASSERT_EQ(close(fd_context), 0);
> +
> +       ASSERT_EQ(mkdirat(fd_tmpfs, "w", 0755), 0);
> +       ASSERT_EQ(mkdirat(fd_tmpfs, "u", 0755), 0);
> +       ASSERT_EQ(mkdirat(fd_tmpfs, "l1", 0755), 0);
> +       ASSERT_EQ(mkdirat(fd_tmpfs, "l2", 0755), 0);
> +
> +       layer_fds[0] =3D openat(fd_tmpfs, "w", O_DIRECTORY);
> +       ASSERT_GE(layer_fds[0], 0);
> +
> +       layer_fds[1] =3D openat(fd_tmpfs, "u", O_DIRECTORY);
> +       ASSERT_GE(layer_fds[1], 0);
> +
> +       layer_fds[2] =3D openat(fd_tmpfs, "l1", O_DIRECTORY);
> +       ASSERT_GE(layer_fds[2], 0);
> +
> +       layer_fds[3] =3D openat(fd_tmpfs, "l2", O_DIRECTORY);
> +       ASSERT_GE(layer_fds[3], 0);
> +
> +       ASSERT_EQ(sys_move_mount(fd_tmpfs, "", -EBADF, "/tmp", MOVE_MOUNT=
_F_EMPTY_PATH), 0);
> +       ASSERT_EQ(close(fd_tmpfs), 0);
> +
> +       fd_context =3D sys_fsopen("overlay", 0);
> +       ASSERT_GE(fd_context, 0);
> +
> +       ASSERT_NE(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir", N=
ULL, layer_fds[2]), 0);
> +
> +       ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "workdir",   =
NULL, layer_fds[0]), 0);
> +       ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "upperdir",  =
NULL, layer_fds[1]), 0);
> +       ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir+", =
NULL, layer_fds[2]), 0);
> +       ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir+", =
NULL, layer_fds[3]), 0);
> +       ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FLAG, "userxattr"=
, NULL, 0), 0);
> +
> +       pid =3D create_child(&pidfd, 0);
> +       ASSERT_GE(pid, 0);
> +       if (pid =3D=3D 0) {
> +               if (!cap_down(CAP_MKNOD))
> +                       _exit(EXIT_FAILURE);
> +
> +               if (!cap_down(CAP_SYS_ADMIN))
> +                       _exit(EXIT_FAILURE);
> +
> +               if (sys_fsconfig(fd_context, FSCONFIG_SET_FLAG, "override=
_creds", NULL, 0))
> +                       _exit(EXIT_FAILURE);
> +
> +               _exit(EXIT_SUCCESS);
> +       }
> +       ASSERT_EQ(sys_waitid(P_PID, pid, NULL, WEXITED), 0);
> +       ASSERT_GE(close(pidfd), 0);
> +
> +       ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_CMD_CREATE, NULL, NUL=
L, 0), 0);
> +
> +       fd_overlay =3D sys_fsmount(fd_context, 0, 0);
> +       ASSERT_GE(fd_overlay, 0);
> +
> +       ASSERT_EQ(sys_move_mount(fd_overlay, "", -EBADF, "/set_layers_via=
_fds", MOVE_MOUNT_F_EMPTY_PATH), 0);
> +       ASSERT_EQ(mknodat(fd_overlay, "dev-zero", S_IFCHR | 0644, makedev=
(1, 5)), -1);
> +       ASSERT_EQ(errno, EPERM);
> +
> +       ASSERT_EQ(close(fd_context), 0);
> +       ASSERT_EQ(close(fd_overlay), 0);
> +}
> +
>  TEST_HARNESS_MAIN
> diff --git a/tools/testing/selftests/filesystems/utils.c b/tools/testing/=
selftests/filesystems/utils.c
> index 0e8080bd0aea..e553c89c5b19 100644
> --- a/tools/testing/selftests/filesystems/utils.c
> +++ b/tools/testing/selftests/filesystems/utils.c
> @@ -472,3 +472,30 @@ int caps_down(void)
>         cap_free(caps);
>         return fret;
>  }
> +
> +/* cap_down - lower an effective cap */
> +int cap_down(cap_value_t down)
> +{
> +       bool fret =3D false;
> +       cap_t caps =3D NULL;
> +       cap_value_t cap =3D down;
> +       int ret =3D -1;
> +
> +       caps =3D cap_get_proc();
> +       if (!caps)
> +               goto out;
> +
> +       ret =3D cap_set_flag(caps, CAP_EFFECTIVE, 1, &cap, 0);
> +       if (ret)
> +               goto out;
> +
> +       ret =3D cap_set_proc(caps);
> +       if (ret)
> +               goto out;
> +
> +       fret =3D true;
> +
> +out:
> +       cap_free(caps);
> +       return fret;
> +}
> diff --git a/tools/testing/selftests/filesystems/utils.h b/tools/testing/=
selftests/filesystems/utils.h
> index f35001a75f99..7f1df2a3e94c 100644
> --- a/tools/testing/selftests/filesystems/utils.h
> +++ b/tools/testing/selftests/filesystems/utils.h
> @@ -24,6 +24,7 @@ extern int get_userns_fd(unsigned long nsid, unsigned l=
ong hostid,
>                          unsigned long range);
>
>  extern int caps_down(void);
> +extern int cap_down(cap_value_t down);
>
>  extern bool switch_ids(uid_t uid, gid_t gid);
>
>
> --
> 2.47.2
>


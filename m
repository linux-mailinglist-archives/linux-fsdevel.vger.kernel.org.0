Return-Path: <linux-fsdevel+bounces-41244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3DAA2CAD1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 19:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAF953A6F43
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 18:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F9819D881;
	Fri,  7 Feb 2025 18:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J76639AI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5906919CD1E;
	Fri,  7 Feb 2025 18:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738951682; cv=none; b=XuQs60+whlQgacOSHVQEqVod0tLA4/kC0jx1vb72sKvgZnd4HLGEhu4Vf0LzZsDiISkklA7U41bITG3FCX29X8RsGvUkOhU8VcBwDIT9+1dgSn3yanmPy+tHbPmEH1n5YUR7gNeNxDZbwMf2oIJ8w/CleCHrtNQYfbG9Buw6yZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738951682; c=relaxed/simple;
	bh=U1BPeQIzNxJUhy9oORjM6i0NjkNaDJlQQZNT2EoE5zU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rw6BUzMG2VfEbgKR0qEZwEFS71h21tyK6DqB4DB0UZg5GAopnXEQ1VsDUqWkVZk++qpJOKjDHybJmZpKzk1OA/grtG5I+63NIEuUgClxUBRD0og98Aje48gujVDx2QxiuPvaBLjBusQ24BY/HCSLXSzBxG4OqXKAPUPmP5yhI4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J76639AI; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5dcea5d8f16so4722568a12.2;
        Fri, 07 Feb 2025 10:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738951678; x=1739556478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vv7weFU2QXWqfTdRNSP5Vkoc26T7YCGu8HGiHydHgIs=;
        b=J76639AIAdDUnuzxKWsOMPxo+6dCNuHJOwRRa7kehKb6omSIOusSOIqv0JePbaFEu/
         GXa8aFfP89epvLD0tClHALKTqsukeHklmnVMFSFnfJ8fREKL+WCuu/vb8PqbZrXL6X31
         dkhMMHJg8Oau8nH4KQxMbKv3yMIjcIECqp9eyszRUtikuPU7kgvcPt+KBzOD5Zd0AICS
         9VHW4TrBxOM6if0g99wg8ylsRxamln8UR1RFpqVML8yEC/FiDKO7DipUoNygWzuyzenZ
         dpmeTXVz88yD2LDksk2C09wWBd0E/gInNzbsnhNHYO6nOPGT3bcYji+q0kQpVDRwaL/2
         ys4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738951679; x=1739556479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vv7weFU2QXWqfTdRNSP5Vkoc26T7YCGu8HGiHydHgIs=;
        b=h9uPGo0BpcrYoujHK9T54Z71crCWkh+ksf416qbt79wTNF3RvveFblx6KXMtHZtUC8
         wwz/jJKr8XkNaGtAYdRKBSxbtvk9shThQ2V27KKw9P8hOYjWq1ns5lqmOeBWtPtJ2fQO
         fDxxvFUgQJn/DWPtxeC34R7VDf8IkJ/pA8HMu/yOvdshdImiz9zVpLeoIMMgaB5/AxSl
         7Vk2suM141NCejPUGmuNUMNUtGmB4g1QU4JUOQxUysbdX9fUZj1a0AlIRnEld7Qmf/lJ
         l26nuakF6ooldQZ7LoiEZEp43D/qUO82x2LZrD93AnVV3yL1aEY9Fn0xV8r7t2xiKjfa
         2DNw==
X-Forwarded-Encrypted: i=1; AJvYcCXccIkgbn+Fmk9Pd/8DFugTk6JEQHw7FMO5pLhzNqETNqPu4Lf/JRqZ87SJxPbv3kC++EzL09pOmYTg8suW@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8D5R11m7WJRVogzPosDpT/YZzZ1OK8SmpttP83jQr0q/EuREQ
	IE3nFv4FZKpQd94wXTerNDV5D6NeWi4UreLxSCuH6MoscetshleKdAywfaUJPCRjTZ3aCmGld/P
	VqWD7GiKpE/wefwCV479/F7fbFKc=
X-Gm-Gg: ASbGncs6+6R84sdstPVrsiZp1GRr4utYMBkfHQsyknQxZ5NTwHS5IwV7sP3imkU9FM7
	2L4I7rxaUQboqpQo10HCoghYvkGe3n2pREfEzVijY+P2qH1hY93LK2oeheeLOBzv5xzN0x9Xe
X-Google-Smtp-Source: AGHT+IHfjuGi++HpcYBGuNlxjX4TPbulO5r7mTQv4PVlsroUTJEI1WTVM/upFOLM4agshlgkRCUrjppvAhCpqZoVORk=
X-Received: by 2002:a05:6402:254d:b0:5dc:91c6:8096 with SMTP id
 4fb4d7f45d1cf-5de450e21e8mr5068895a12.30.1738951678199; Fri, 07 Feb 2025
 10:07:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207-work-overlayfs-v1-0-611976e73373@kernel.org> <20250207-work-overlayfs-v1-2-611976e73373@kernel.org>
In-Reply-To: <20250207-work-overlayfs-v1-2-611976e73373@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 7 Feb 2025 19:07:45 +0100
X-Gm-Features: AWEUYZmwwcSENdn4qnd2Xz172ognCBGBsqfRar7-K6gL0oCYS7QT_iY84DP9Rko
Message-ID: <CAOQ4uxh2gxemgcEKzRSQcax12ccc3gzGQRQywU3OS+JcgwTVsQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests/overlayfs: test specifying layers as O_PATH
 file descriptors
To: Christian Brauner <brauner@kernel.org>
Cc: linux-unionfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, 
	Mike Baynton <mike@mbaynton.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 4:46=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> Verify that userspace can specify layers via O_PATH file descriptors.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  .../filesystems/overlayfs/set_layers_via_fds.c     | 65 ++++++++++++++++=
++++++
>  1 file changed, 65 insertions(+)
>
> diff --git a/tools/testing/selftests/filesystems/overlayfs/set_layers_via=
_fds.c b/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
> index 1d0ae785a667..e693e4102d22 100644
> --- a/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
> +++ b/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
> @@ -214,4 +214,69 @@ TEST_F(set_layers_via_fds, set_500_layers_via_fds)
>         ASSERT_EQ(close(fd_overlay), 0);
>  }
>
> +TEST_F(set_layers_via_fds, set_500_layers_via_opath_fds)
> +{
> +       int fd_context, fd_tmpfs, fd_overlay, fd_work, fd_upper, fd_lower=
;
> +       int layer_fds[500] =3D { [0 ... 499] =3D -EBADF };
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
> +       for (int i =3D 0; i < ARRAY_SIZE(layer_fds); i++) {
> +               char path[100];
> +
> +               sprintf(path, "l%d", i);
> +               ASSERT_EQ(mkdirat(fd_tmpfs, path, 0755), 0);
> +               layer_fds[i] =3D openat(fd_tmpfs, path, O_DIRECTORY | O_P=
ATH);
> +               ASSERT_GE(layer_fds[i], 0);
> +       }
> +
> +       ASSERT_EQ(mkdirat(fd_tmpfs, "w", 0755), 0);
> +       fd_work =3D openat(fd_tmpfs, "w", O_DIRECTORY | O_PATH);
> +       ASSERT_GE(fd_work, 0);
> +
> +       ASSERT_EQ(mkdirat(fd_tmpfs, "u", 0755), 0);
> +       fd_upper =3D openat(fd_tmpfs, "u", O_DIRECTORY | O_PATH);
> +       ASSERT_GE(fd_upper, 0);
> +
> +       ASSERT_EQ(mkdirat(fd_tmpfs, "l501", 0755), 0);
> +       fd_lower =3D openat(fd_tmpfs, "l501", O_DIRECTORY | O_PATH);
> +       ASSERT_GE(fd_lower, 0);
> +
> +       ASSERT_EQ(sys_move_mount(fd_tmpfs, "", -EBADF, "/tmp", MOVE_MOUNT=
_F_EMPTY_PATH), 0);
> +       ASSERT_EQ(close(fd_tmpfs), 0);
> +
> +       fd_context =3D sys_fsopen("overlay", 0);
> +       ASSERT_GE(fd_context, 0);
> +
> +       ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "workdir",   =
NULL, fd_work), 0);
> +       ASSERT_EQ(close(fd_work), 0);
> +
> +       ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "upperdir",  =
NULL, fd_upper), 0);
> +       ASSERT_EQ(close(fd_upper), 0);
> +
> +       for (int i =3D 0; i < ARRAY_SIZE(layer_fds); i++) {
> +               ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowe=
rdir+", NULL, layer_fds[i]), 0);
> +               ASSERT_EQ(close(layer_fds[i]), 0);
> +       }
> +
> +       ASSERT_NE(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir+", =
NULL, fd_lower), 0);
> +       ASSERT_EQ(close(fd_lower), 0);
> +
> +       ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_CMD_CREATE, NULL, NUL=
L, 0), 0);
> +
> +       fd_overlay =3D sys_fsmount(fd_context, 0, 0);
> +       ASSERT_GE(fd_overlay, 0);
> +       ASSERT_EQ(close(fd_context), 0);
> +       ASSERT_EQ(close(fd_overlay), 0);
> +}
> +
>  TEST_HARNESS_MAIN
>
> --
> 2.47.2
>


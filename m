Return-Path: <linux-fsdevel+bounces-31962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AA099E5E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 13:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 669F91C2374B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 11:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B13F1E8830;
	Tue, 15 Oct 2024 11:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtICUsQG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9A51D90CD;
	Tue, 15 Oct 2024 11:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992145; cv=none; b=Jaq39MHYIhBTj79zbDR4RATJ3L9qiSPADjgL99xW8xJ3YjHPMFGRm2V9BDHjZnAw3r5CxP1DdlIVxt7th7CNvSMygD7zVYQMtjT2+pDjejbmbUMYTDu+2OE960jJN9fuZi4qLj834JuiRfJD2FdOjQJJ1SnocqnA4KAFeFk13zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992145; c=relaxed/simple;
	bh=yQClUvpX31HB1D3Ob66AycwbF7hXynlDzMUS2lQmIn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0SKc2GBMOEunbEpzIUyGxEfvc+zy0rb57juLY612lN7BtO/WrloFpb8lEYhXduXNdaXsVS85vTSliL3rJOFl2T+Tq/9UZqbmtPxGqgAaLtVIoBQHsrzEgHZOt4kzO1wjpZiAUuuMXyDn3pg5MB+5y+7d72YduxggWjscb8mKRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtICUsQG; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e291cbbf05bso3870660276.2;
        Tue, 15 Oct 2024 04:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728992143; x=1729596943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cn7EPLcaVBPXG3fbrczXFpwB2QWiwv8RqqG4KGy0yx8=;
        b=dtICUsQGx+tkv2hP0uAEKboWc+QN3apYdMqMVTpq7Q7WZz1n8MgktDJc8VPL1Q51nq
         fOl9zaWJoI5ToL5r4wDUpb7kctq3igLNZjDs/OgvcugCQLEP784bwu5zkF2b576048tn
         ZTgQkByLlwKKwwZFOfTpW8kTF6fnyRAHe4UXYBIlqNnxE8pXx29TQUNOEayxt7tTjIyO
         mog4e/biSjNlZKL6UhOECxhPsUGarDX1EQvhLWQvYaJhHbPJH76OddGHJIdTCrfH85Zm
         mrGvPOSc2eftXJTtyAXcaEvM6EeC+77BEjqyllqjeHbTN/f6CuPNw+ywNBsMq/hzUps3
         LIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728992143; x=1729596943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cn7EPLcaVBPXG3fbrczXFpwB2QWiwv8RqqG4KGy0yx8=;
        b=c90ePpRwCENqpQwC7E9s7EHNBOxkJBf+zs7Jkh7pZ/eBuo5MZw8Zf3q5umbRDhji0f
         Iyy+mgsS00iO/+D4ODFwMnT2MeJndhSYBCDSPYmtsGl7DpFFFB68q0QYtiB9wvGVOgc3
         dWtMJfftKOb2kwhpw27Qif2HJcZ6yUEArmpkT3DVlGZMPSJWrk86neY9Zwe2cjhSk29M
         KGneBqIt25+ndrg5pkkptaJKS2Ni2iBHqbHrWPbU+ynm6yp1wiRQHBJLZmQaJ/bjp0EG
         XHE9UNnylaXm3SrJyp14f5jTNUUHhZ3T5xPQbtcVwdE5l/qzLffD2xL+2VIQTAOV4vU5
         c0tQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhUM6MMKBT343+8OjiWAJQ6QAgMNA6wbwhEvflUt8CuFM6rVJcbEni02lj2UPh4QqiHswwGe8R39ONpn2tUQ==@vger.kernel.org, AJvYcCWKlhMapKA8mKOlesEIrHB0Oz5zfSfzX0W6Eg+fiMZXbB2tt5JoX4XIMOLZ4iTSlpYNkRA/NiPxxb/LPpd3@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvcbak3M1xFjsOS3iTpCFhJG2sFcST95N9Z48XezKvAa/VDtfv
	RCpYjf3uEn3ScBZvjL0ABWp4sw57e3qQuZud6Y7dmQUxsR1G1rG5PM1/z56HmZRBuCJbiTRcx46
	LzF2wRPdHQQnK1cWj29hlGp3GA6g=
X-Google-Smtp-Source: AGHT+IEh5WGQ0QjMzN5bOe0qneEw8KAnxmw9oFVoRZ8sKLQqrryuyOA2SlsThdUxb00oIdMsVHVgFeTzB0ttyZZAXkM=
X-Received: by 2002:a05:6902:2213:b0:e29:e4f:edfd with SMTP id
 3f1490d57ef6-e2919fe5f42mr10315217276.42.1728992142807; Tue, 15 Oct 2024
 04:35:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015-leiht-filmabend-a86eed4ff304@brauner>
In-Reply-To: <20241015-leiht-filmabend-a86eed4ff304@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 15 Oct 2024 13:35:31 +0200
Message-ID: <CAOQ4uxi8=BKjBt04OQi8weFUDoXYA5+cWq51EMTocyjTf2Fx5A@mail.gmail.com>
Subject: Re: [PATCH] selftests: add test for specifying 500 lower layers
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 1:15=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Verify that we can actually specify 500 lower layers and fail at the
> 501st one.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
> Just noticed that we didn't have that and we'd already regressed that
> once and now that I've done new selftests already just add a selftest
> for this on top.

Thanks!

I guess this is going to be added to your vfs.ovl branch, so

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  .../overlayfs/set_layers_via_fds.c            | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>
> diff --git a/tools/testing/selftests/filesystems/overlayfs/set_layers_via=
_fds.c b/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
> index 301fb5c02852..1d0ae785a667 100644
> --- a/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
> +++ b/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
> @@ -149,4 +149,69 @@ TEST_F(set_layers_via_fds, set_layers_via_fds)
>         ASSERT_EQ(fclose(f_mountinfo), 0);
>  }
>
> +TEST_F(set_layers_via_fds, set_500_layers_via_fds)
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
> +               layer_fds[i] =3D openat(fd_tmpfs, path, O_DIRECTORY);
> +               ASSERT_GE(layer_fds[i], 0);
> +       }
> +
> +       ASSERT_EQ(mkdirat(fd_tmpfs, "w", 0755), 0);
> +       fd_work =3D openat(fd_tmpfs, "w", O_DIRECTORY);
> +       ASSERT_GE(fd_work, 0);
> +
> +       ASSERT_EQ(mkdirat(fd_tmpfs, "u", 0755), 0);
> +       fd_upper =3D openat(fd_tmpfs, "u", O_DIRECTORY);
> +       ASSERT_GE(fd_upper, 0);
> +
> +       ASSERT_EQ(mkdirat(fd_tmpfs, "l501", 0755), 0);
> +       fd_lower =3D openat(fd_tmpfs, "l501", O_DIRECTORY);
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
> --
> 2.45.2
>


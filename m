Return-Path: <linux-fsdevel+bounces-50239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BA7AC95E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 20:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C21327AC984
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 18:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9FB27781B;
	Fri, 30 May 2025 18:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyD9zVK7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DEA2868B;
	Fri, 30 May 2025 18:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748631335; cv=none; b=PR21g2510sTK8eiGHgl/7ZnvsBSgb7G4K4XLsTPPAIz2sIDbyELlVIRbwJf5O9ke68IToZv6R9aMOKWcYBp9LfRGBHgOhvah/0gfXcJLh+Jj3Vg0lG99IoHHYaK+WTnYJ1zn43nT+PzeAVqwbUgihtSjnwOxFyzgyKPvrn7Bq6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748631335; c=relaxed/simple;
	bh=kvv3x1lNNVSEY+68sceUtjgx2JI3k2NSjLn1DdT5yoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DdoYHyNC3Ps88xLHrGID2vZk9nZLm1bqNx1IwxdPyAz8PeCwNtZRQ0c/TKmUbqUDFWEVeiESX+Vgm+4NAsMwS0SeTVzwU+N3SrcTR+z+FAdr0GJxM928TPqajAG62FV0TGWKe9qsTIfV8tsaYe0mTD6Gp2OcSvbCDwHsx3Af8BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyD9zVK7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A8AC4CEF4;
	Fri, 30 May 2025 18:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748631334;
	bh=kvv3x1lNNVSEY+68sceUtjgx2JI3k2NSjLn1DdT5yoA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TyD9zVK7FHg00trE7I/Qq6mnMbFIljHvoETtHWh+S/dU5XFMEvP3kJIfa8mVOYqqE
	 UWqiQe9Cx8Ii+Qw1cHgaQS9X7026NSWrwUTLchH1mU7Y33HOmx73PCl7fdGtrgyzJs
	 q1a2sVMw5yZLuQjim0Efv/FzF8AfXbbnZrPHUHUQ+uCngLriAUZa7tsyPkoCWZL/39
	 MtanZ9xe8fT1Qg4tBiwkVJz0Mz5EvaHdc0kPPUJDilULKJtu78Ev8ULMa45j2Yw6Y+
	 q/REspEcICZg8PTwmJIxOrs6N4lVNtoi3knig4eWHBVoCFjn4lM5N6wzo7PyIeVN8U
	 ZkzFJGSVgVTOA==
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4766631a6a4so26063611cf.2;
        Fri, 30 May 2025 11:55:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUS5cV7AacNJwQHXXqpNTtiTwQAKlZ9BiUb6h6dPTSEBQakClMU9dWeoojvO1BDiG5qVzNZr1NFhaGqpUUo@vger.kernel.org, AJvYcCUrNPBasv82ACVhpLlqFpepPtzbMW1aBTYIgFT0FAUAUKBqUQ2zaktUaXvsKCcGD70QiTo=@vger.kernel.org, AJvYcCUsj7R5ZbR5R+p9DEW+xlOvYMaQ8mjhfVJgbfm8t8/62Y/+Iuh6RUTWMgU+AvizsTIrXaRUZ4cUJIxXZNnQpw==@vger.kernel.org, AJvYcCVj+3zLd+V4+dVm1aopgYuYT0XNAZaIwzyOFEt82yJB92vNMNygnv91XcyRtaj0KbW9wmKj+tyNGXJE17/RhmDCcH4Pdxi0@vger.kernel.org
X-Gm-Message-State: AOJu0Yw76xn/1sdJYDwKzuD5xRTCZKJ3DB38LJi2RK8NllT/Rp9jiSe/
	pClKnT0Xf5xzM+8NVBFuLlBikf8h62VHvPi6P+RrN1ayxv2ObALt7CLHLWCy6DSCF0LXPuTcaRm
	QpZcnB4BvgoFwuzkr44aC88UzDv7F7Ss=
X-Google-Smtp-Source: AGHT+IE92B2h8f//uqia8qbC4anK75ysiMFO/DZriOdDiGsrTgbvy+DMAG6ai12inpftbg+xMSCxr73ci5UUIzmmVBo=
X-Received: by 2002:a05:622a:229f:b0:476:980c:10a9 with SMTP id
 d75a77b69052e-4a44005d830mr68789201cf.21.1748631333504; Fri, 30 May 2025
 11:55:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250529173810.GJ2023217@ZenIV> <CAPhsuW5pAvH3E1dVa85Kx2QsUSheSLobEMg-b0mOdtyfm7s4ug@mail.gmail.com>
 <20250529183536.GL2023217@ZenIV> <CAPhsuW7LFP0ddFg_oqkDyO9s7DZX89GFQBOnX=4n5mV=VCP5oA@mail.gmail.com>
 <20250529201551.GN2023217@ZenIV> <CAPhsuW5DP1x_wyzT1aYjpj3hxUs4uB8vdK9iEp=+i46QLotiOg@mail.gmail.com>
 <20250529214544.GO2023217@ZenIV> <CAPhsuW5oXZVEaMwNpSF74O7wZ_f2Qr_44pu9L4_=LBwdW5T9=w@mail.gmail.com>
 <20250529231018.GP2023217@ZenIV> <CAPhsuW6-J+NUe=jX51wGVP=nMFjETu+1LUTsWZiBa1ckwq7b+w@mail.gmail.com>
 <20250530.euz5beesaSha@digikod.net>
In-Reply-To: <20250530.euz5beesaSha@digikod.net>
From: Song Liu <song@kernel.org>
Date: Fri, 30 May 2025 11:55:22 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5U-nPk4MFdZSeBNds0qEHjQZrC=c5q+AGNpsKiveC2wA@mail.gmail.com>
X-Gm-Features: AX0GCFspg5CtJJG-8uKPbI5Gb-Py8dbCVOZv9v2st4gS5y-i18U4FFZSxP8SBdk
Message-ID: <CAPhsuW5U-nPk4MFdZSeBNds0qEHjQZrC=c5q+AGNpsKiveC2wA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] bpf: Introduce path iterator
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, bpf@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com, 
	andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, brauner@kernel.org, kpsingh@kernel.org, 
	mattbobrowski@google.com, amir73il@gmail.com, repnop@google.com, 
	jlayton@kernel.org, josef@toxicpanda.com, gnoack@google.com, 
	Tingmao Wang <m@maowtm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 5:20=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
[...]
> >
> > If we update path_parent in this patchset with choose_mountpoint(),
> > and use it in Landlock, we will close this race condition, right?
>
> choose_mountpoint() is currently private, but if we add a new filesystem
> helper, I think the right approach would be to expose follow_dotdot(),
> updating its arguments with public types.  This way the intermediates
> mount points will not be exposed, RCU optimization will be leveraged,
> and usage of this new helper will be simplified.

I think it is easier to add a helper similar to follow_dotdot(), but not wi=
th
nameidata. follow_dotdot() touches so many things in nameidata, so it
is better to keep it as-is. I am having the following:

/**
 * path_parent - Find the parent of path
 * @path: input and output path.
 * @root: root of the path walk, do not go beyond this root. If @root is
 *        zero'ed, walk all the way to real root.
 *
 * Given a path, find the parent path. Replace @path with the parent path.
 * If we were already at the real root or a disconnected root, @path is
 * not changed.
 *
 * Returns:
 *  true  - if @path is updated to its parent.
 *  false - if @path is already the root (real root or @root).
 */
bool path_parent(struct path *path, const struct path *root)
{
        struct dentry *parent;

        if (path_equal(path, root))
                return false;

        if (unlikely(path->dentry =3D=3D path->mnt->mnt_root)) {
                struct path p;

                if (!choose_mountpoint(real_mount(path->mnt), root, &p))
                        return false;
                path_put(path);
                *path =3D p;
                return true;
        }

        if (unlikely(IS_ROOT(path->dentry)))
                return false;

        parent =3D dget_parent(path->dentry);
        if (unlikely(!path_connected(path->mnt, parent))) {
                dput(parent);
                return false;
        }
        dput(path->dentry);
        path->dentry =3D parent;
        return true;
}
EXPORT_SYMBOL_GPL(path_parent);

And for Landlock, it is simply:

                if (path_parent(&walker_path, &root))
                        continue;

                if (unlikely(IS_ROOT(walker_path.dentry))) {
                        /*
                         * Stops at disconnected or real root directories.
                         * Only allows access to internal filesystems
                         * (e.g. nsfs, which is reachable through
                         * /proc/<pid>/ns/<namespace>).
                         */
                        if (walker_path.mnt->mnt_flags & MNT_INTERNAL) {
                                allowed_parent1 =3D true;
                                allowed_parent2 =3D true;
                        }
                        break;
                }

Does this look right?

Thanks,
Song


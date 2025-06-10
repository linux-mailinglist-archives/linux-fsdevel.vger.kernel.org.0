Return-Path: <linux-fsdevel+bounces-51207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B848AD467C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 01:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 197AE3A3863
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 23:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11D52D541C;
	Tue, 10 Jun 2025 23:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmmtZeb2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3552D5403;
	Tue, 10 Jun 2025 23:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749596901; cv=none; b=GXrJvOInJqXcegEKcPxNK/LqSASSrlLNFnvaTQnwTPaqrwCBtrfNlnNrIji945MxLmo52OI7olt7mjKPZaHcNO4eQx2ZYydZX2gZstblVdPGuz6ZBOZ7DSpm86r7qM74W4kz6IaD6s5O8Yfos6pSoDjixlDCk8SroX7SjUl6U+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749596901; c=relaxed/simple;
	bh=vOAAvEx4E+8UjppT46gHSojDmxrWyNLo9cdzD7FA+rc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tiUBMoxRdmiWlrbACaDuEKcdPN+KBhgseA3C1MzQsXMk+6yGCWMminrTzS784aid2+gZX3s9qBRfl0uzbbL1NW+Cs+bh0oHPKRoZUGLDme32AIARjMEPblUUE9BwLt3Ea6Znjl/MTltpJBZazJVB82XSOurnYy5BpZqQZmTIAbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmmtZeb2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4E4C4CEF3;
	Tue, 10 Jun 2025 23:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749596900;
	bh=vOAAvEx4E+8UjppT46gHSojDmxrWyNLo9cdzD7FA+rc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VmmtZeb2utDRFMCLcnI+EFjIb/ePZ95my4a6Yj5o8dvzSu8CKzuCsIsjsyYKCSzP4
	 C/yPlvqqAqgpMqdOxWr3yOw/WxE5b2nbVKtJ8kiMNQiV+u6HfOultf1pxoGJgvPunu
	 E1nQ+y2fg/SZtPcq/v6IPFppzZa+oQhimwTGRgnHXxp3ddZjPrgtdPTI/Cg1wvyTFH
	 EUO9u9o6HrdExqGY0WBoAHzJwEL+ponltPd49UHDAohzv7l0P1BDeGptO8LSag9eOV
	 h1mNbgQTvX0fEUymrmrHmhFqHpGgUwiiCYhUq4+B1MLTe6puTI+PWOj9T7v5stQ1l0
	 RK9s/BSzdEnjw==
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6facba680a1so64133896d6.3;
        Tue, 10 Jun 2025 16:08:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVpK65AR5lENARFbWAXWK7hiOhF6o5swPnQ4U3J1EP8dbKX3OjlOA+Olp5fj4fuHqnRCi7G50hjTEC91BZKyQ==@vger.kernel.org, AJvYcCWV49yNcfMcMh1uB1g5r1tIn0aUmiTKX0ifofTQr1s6Hg4jQYUVrtEtlIQNx5YdFY9quuWCb3CRo/i9NCoUdRfZLoOYNQst@vger.kernel.org, AJvYcCXCH0yCfFA2EkQfhoLI41CoONXY3UdOglvB6OdIum+p80dSr3FvxHylvj2c1r0jEweWEQw=@vger.kernel.org, AJvYcCXSryMujoKhPsA+1XGUZlO7xJ9prgliFRnO76Vsyb/NKH5ugCw8N5bQ6LbW3XMeeykmzQN4fMQxzcIkz6yS@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt04GyBK6gMse60zDorxJwKHm65144fmk0tX6g3nWklzedvnnG
	4REJFlDAafXHlLXgOna+zauMGEnANS/vwdS4YbPDzigVZHH/bKpxO8EDcMBynAzM9wN29Ha/ZgY
	+vYOUAkKQWnl8w4SDeh+r7i7laUqiWb0=
X-Google-Smtp-Source: AGHT+IGQwb7bLPJ7uaxum7qOUIy/8C94KF54pMNu1cwD2A2emExMuBIuVS0BNScxi1yUGqW5hw93a0PxpKiAZS9jT/k=
X-Received: by 2002:ad4:5d46:0:b0:6fa:bb09:43d0 with SMTP id
 6a1803df08f44-6fb2c3723bbmr22557596d6.32.1749596899582; Tue, 10 Jun 2025
 16:08:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606213015.255134-1-song@kernel.org> <20250606213015.255134-2-song@kernel.org>
 <20250610.rox7aeGhi7zi@digikod.net> <CAPhsuW5G0Th+9dRSmxDjo5E7CxV1E9N8AiKjw3cKyEhOBVWJFw@mail.gmail.com>
 <d7d755ea-5942-440b-8154-21198cb6a0f1@maowtm.org>
In-Reply-To: <d7d755ea-5942-440b-8154-21198cb6a0f1@maowtm.org>
From: Song Liu <song@kernel.org>
Date: Tue, 10 Jun 2025 16:08:08 -0700
X-Gmail-Original-Message-ID: <CAPhsuW75h3efyXmCcYE_UEmZGXR5KMSEw8h-_vrZH82BYU=WVw@mail.gmail.com>
X-Gm-Features: AX0GCFvLr6ZpvpJJmf_Db7fELs42Mf-Bt8O_6VwLs3YNEtG0tanEPc7gL84uHg8
Message-ID: <CAPhsuW75h3efyXmCcYE_UEmZGXR5KMSEw8h-_vrZH82BYU=WVw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/5] namei: Introduce new helper function path_walk_parent()
To: Tingmao Wang <m@maowtm.org>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, kpsingh@kernel.org, 
	mattbobrowski@google.com, amir73il@gmail.com, repnop@google.com, 
	jlayton@kernel.org, josef@toxicpanda.com, gnoack@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 3:26=E2=80=AFPM Tingmao Wang <m@maowtm.org> wrote:
[..]
> >
> >                 if (!choose_mountpoint(real_mount(path->mnt), root, &p)=
)
> >                         return false;
> >                 path_put(path);
> >                 *path =3D p;
> >                 ret =3D true;
> >         }
> >
> >         if (unlikely(IS_ROOT(path->dentry)))
> >                 return ret;
>
> Returning true here would be the wrong semantic right?  This whole thing
> is only possible when some mount shadows "/".  Say if you have a landlock
> rule on the old "/", but then we mount a new "/" and chroot into it (via
> "/.."), the landlock rule on the old "/" should not apply, but if we
> change *path and return true here then this will "expose" that old "/" to
> landlock.

Could you please provide more specific information about this case?

Thanks,
Song

> A quick suggestion although I haven't tested anything - maybe we should d=
o
> a special case check for IS_ROOT inside the
>     if (unlikely(path->dentry =3D=3D path->mnt->mnt_root))
> ? Before "path_put(path);", if IS_ROOT(p.dentry) then we just path_get(p)
> and return false.
>
> >
> >         parent =3D dget_parent(path->dentry);
> >         dput(path->dentry);
> >         path->dentry =3D parent;
> >         return true;
> > }
> >
> > Thanks,
> > Song
>


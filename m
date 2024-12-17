Return-Path: <linux-fsdevel+bounces-37650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 248309F5164
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 17:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F24C4168740
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 16:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2711F758D;
	Tue, 17 Dec 2024 16:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKv4rlX0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861F913D891;
	Tue, 17 Dec 2024 16:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734454256; cv=none; b=J99NV+KA6J+uSovzT+mLFPdAZJMTF4VYaKIj7NuoHFASqEiHDWYGWKacoNiD8nR4E4W1Q5TeM+hmKiR96VtDXRzoh3AWXImux8imZoHXemeNlD8nQHG9qbC17jdezv4/KpxaUYa7wgOiU73UH5nlupbDaQq2UJQxsXRjG4sEmk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734454256; c=relaxed/simple;
	bh=QT0HaOZrrcuBLx3iwbHEd5ESKMtyIbJp3/b0ZBxIPHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o29P9N/cQ+JDmpu6jExFU4wemDxHAc2br91IjkZtatp8+hLEzNC00RRBBd65dFgsgBXfwPQpwSnFk5h2Jv7fj5MYvJ1wXIckB0fWjW67C942TRnrVJW3hE+018rdpTn6UH5seJVJQFzulHptlkK5bqjdFkTf0BnPuaL7tqtSdEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKv4rlX0; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43622354a3eso39033625e9.1;
        Tue, 17 Dec 2024 08:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734454253; x=1735059053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqGkGl4I3oQGsHn9CPQ+WaBIxXpdHiccXhn42DSrZyQ=;
        b=XKv4rlX0hgc7THNF/gSISbgityOI3Vx0K+6KHtkIyueN2vby406miW9EvtI1+zdCaK
         hjQ1BK31gu/DEnWgjBqpVp8q1jQWY90MeSFc+eJOcMhc6lUEZ4ZRtt462hVi4YgZpg3h
         i60icPGn9gk3oSfhGQg1UyhOGIA0CprU+ko4udNp9GW4BWecNDLa7Av0xAAK9CzcWNT0
         bywNlF7GL3YM3lw9NWUF2G/Xgprw2nG6uED4YvbkB+FSPI0pGhx2gviu3whkqbefANfA
         xTvzQ24okOwoHs5sFdA2hcnTipalGS/lsLxN49OgYc/UghzdXmnkg1YAy6dYVa+JEur1
         lSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734454253; x=1735059053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aqGkGl4I3oQGsHn9CPQ+WaBIxXpdHiccXhn42DSrZyQ=;
        b=smHqrhfey6McKu2vD8XpzLxIm8SgJIfZz7FEe16ZOjOy3R/I9EcbDAnw4glZ0+BERr
         LjSCsxc/+qA99um95sdICtxefd5bFjDyDEsH8mprD8LgVEh9pqDhyPTkTIuMsAR1S/LJ
         w4fcgwCn6RCUN+nMcGkIG98K7mwvTsIxtRqO98+DPnOlLoVNwJk4Ue5V0MSWzO/UCNne
         Htsr8wpgKN1ryb3Os3ryEvhnxbPfvZLQ/IhKDSqzjHjcLvYIah7RimwhMpJfmGm0TvhS
         1Oaxlu2Rv6ljyao3AWS8/lm7UYUK/rzKyMZPyg/hyaEj4lsSR8u6fIbahOmROrugD2PC
         Nq1A==
X-Forwarded-Encrypted: i=1; AJvYcCUkRC58iq/CGyJzA5X/gP+Khw3X5+qJge3yX0rxe0zGLZRILVyGVncpgnG3OX9RXEQOzkbtb3MDkOxWOPSGEMmuplPrkw3a@vger.kernel.org, AJvYcCWVjqfZMrYOSRa3TEcTC0yaXGPplu8wBBf2QBLky3jfJdy3qU1EX9c/jbnrkLo6ly++8Dl7Xk8TeomoxLUy@vger.kernel.org, AJvYcCXIhiGt5XnR6h/z2UBUCRstq2X6TvOqwocF4lhgWtllw3OT6OmjdZ7JWtn+3uqe0h/UY3RlDHs8D2ajZ4E3@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcv6VLviHEVpWAS5u9bErOM9wCxiECSzKDaDOTjTfFFbQs0fB8
	Nqg6An1LyImK/ttbWVJvOEqxj007v7W9e1xwENpxI9ia77iImJxbID+ws74QsYKnlnRtLD+Ob/g
	nzUxsKz3KG+2po+gBqGFhu45C7qM=
X-Gm-Gg: ASbGnctWwDl6Zv4iV/CKUynNbjFpxILPjBcC1pvN5Hy/QmqNQ1hRA9TdfXIa3aU6Fyn
	i6QWS1CasGwkvfpGjAcagnCstu+l6X64XP7bMNnVASrbq4pR1/7G52t4s63bj3/SnccHFyw==
X-Google-Smtp-Source: AGHT+IFta1pUoEC2GeCCBT+bI1Kau5R4Yd6VxG9WsjVSoHf92aA2eehdKxv+Ln8Y3iPfj0PqgNrr9XaYokZyA+MO/jo=
X-Received: by 2002:a05:600c:3552:b0:434:f335:855 with SMTP id
 5b1f17b1804b1-4362aab472dmr131678885e9.28.1734454252591; Tue, 17 Dec 2024
 08:50:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217063821.482857-1-song@kernel.org> <20241217063821.482857-5-song@kernel.org>
In-Reply-To: <20241217063821.482857-5-song@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 17 Dec 2024 08:50:40 -0800
Message-ID: <CAADnVQKnscWKZHbWt9cgTm7NZ4ZWQkHQ+41Hz=NWoEhUjCAbaw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 4/6] bpf: fs/xattr: Add BPF kfuncs to set and
 remove xattrs
To: Song Liu <song@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, liamwisehart@meta.com, shankaran@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 10:38=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> Add the following kfuncs to set and remove xattrs from BPF programs:
>
>   bpf_set_dentry_xattr
>   bpf_remove_dentry_xattr
>   bpf_set_dentry_xattr_locked
>   bpf_remove_dentry_xattr_locked
>
> The _locked version of these kfuncs are called from hooks where
> dentry->d_inode is already locked.

...

> + *
> + * Setting and removing xattr requires exclusive lock on dentry->d_inode=
.
> + * Some hooks already locked d_inode, while some hooks have not locked
> + * d_inode. Therefore, we need different kfuncs for different hooks.
> + * Specifically, hooks in the following list (d_inode_locked_hooks)
> + * should call bpf_[set|remove]_dentry_xattr_locked; while other hooks
> + * should call bpf_[set|remove]_dentry_xattr.
> + */

the inode locking rules might change, so let's hide this
implementation detail from the bpf progs by making kfunc polymorphic.

To struct bpf_prog_aux add:
bool use_locked_kfunc:1;
and set it in bpf_check_attach_target() if it's attaching
to one of d_inode_locked_hooks

Then in fixup_kfunc_call() call some helper that
if (prog->aux->use_locked_kfunc &&
    insn->imm =3D=3D special_kfunc_list[KF_bpf_remove_dentry_xattr])
     insn->imm =3D special_kfunc_list[KF_bpf_remove_dentry_xattr_locked];

The progs will be simpler and will suffer less churn
when the kernel side changes.


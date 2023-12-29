Return-Path: <linux-fsdevel+bounces-7013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C6A81FD22
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Dec 2023 06:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C3B8284C78
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Dec 2023 05:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD3863C6;
	Fri, 29 Dec 2023 05:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SV4s2Vtd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166325CB9;
	Fri, 29 Dec 2023 05:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-67fe0264dd2so33825916d6.0;
        Thu, 28 Dec 2023 21:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703828826; x=1704433626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7WSWnpWy6E40n+7yW9kRJZUQO4PwNI/k8Lg4U5aQ1Mw=;
        b=SV4s2Vtd1AFjgPf597yxM991oivvzWe+UyvFu3O3DL3Jn8Vcmnpu/UYAefB8jXeW3M
         NO/s9zMXDQHmUFOaKVDMPOdx/HKwV41HJ3irjFHFRMroHCCOsO6LgGkyWVXI0MW57hnK
         7ofRgR40FHGxwdiJhEjNGNiOuPXIK+iGWwFAbKAL+49ck5f8CM6qkxP0JJYWmzs6Tl1e
         jMcgaLe3s3EwynoxloDgG21G2VzyXQnBKsD2VvQF4BqinGUA65s2YGE7dOr9nEf3HOea
         orFed7bEXYAj4KDJ+ZvNDhbqdazHsNwxfWbm+mkmF3EPILw4d95FgGugDoNQ0b8Js2ZP
         9MsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703828826; x=1704433626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7WSWnpWy6E40n+7yW9kRJZUQO4PwNI/k8Lg4U5aQ1Mw=;
        b=BKEsPTroyReGSN1b6dlvHsQRrVsdUA9avXNyQOjWW1e1IHUTa4V+0ElDoHwyO9r5Ex
         9vECLCRlugqO99fJDndsY2B9zx8jckvE1dc1xENvaSLWRxJv10ze01fkdn0aSGlQiMOE
         4+91K6WSwMC4F+G531OR8ZBGMc2PhQDQTKVCUkWQuJ/SfhJYq0bvz3ph6CUszQX1Hn2h
         41853J7/8zKmwQI2/94xC092mG7MNgmfE/jUmrskImftclrbA1WbqtxxvBdwKoq9JXNz
         GMOg9ifWazUFfbfIGIHNP7NQcHt4gBkbSeMSoUSsFIjt4uYOKRj9CK+XndsSZh7G+T6O
         0/VA==
X-Gm-Message-State: AOJu0YxVfN3Iu0bZgb1MLLFVIGnCxutipAmc+xeNI768hCSp1fFG3F06
	UwqC12WE5aWqEylZASX5YiHARj+c6YrOuY8arQ0=
X-Google-Smtp-Source: AGHT+IH5AdnV2iCk8gv97cgKNFXJsPgyR5oazZVw57Cd5WbS100UUIa/ifDHHILUZNEpcn374Qm7+h2Cc79IeHloZ8U=
X-Received: by 2002:a05:6214:d0a:b0:67a:be9a:e9df with SMTP id
 10-20020a0562140d0a00b0067abe9ae9dfmr18972871qvh.17.1703828825828; Thu, 28
 Dec 2023 21:47:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228201510.985235-1-trondmy@kernel.org>
In-Reply-To: <20231228201510.985235-1-trondmy@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 29 Dec 2023 07:46:54 +0200
Message-ID: <CAOQ4uxiCf=FWtZWw2uLRmfPvgSxsnmqZC6A+FQgQs=MBQwA30w@mail.gmail.com>
Subject: Re: [PATCH] knfsd: fix the fallback implementation of the get_name
 export operation
To: trondmy@kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[CC: fsdevel, viro]

On Thu, Dec 28, 2023 at 10:22=E2=80=AFPM <trondmy@kernel.org> wrote:
>
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> The fallback implementation for the get_name export operation uses
> readdir() to try to match the inode number to a filename. That filename
> is then used together with lookup_one() to produce a dentry.
> A problem arises when we match the '.' or '..' entries, since that
> causes lookup_one() to fail. This has sometimes been seen to occur for
> filesystems that violate POSIX requirements around uniqueness of inode
> numbers, something that is common for snapshot directories.

Ouch. Nasty.

Looks to me like the root cause is "filesystems that violate POSIX
requirements around uniqueness of inode numbers".
This violation can cause any of the parent's children to wrongly match
get_name() not only '.' and '..' and fail the d_inode sanity check after
lookup_one().

I understand why this would be common with parent of snapshot dir,
but the only fs that support snapshots that I know of (btrfs, bcachefs)
do implement ->get_name(), so which filesystem did you encounter
this behavior with? can it be fixed by implementing a snapshot
aware ->get_name()?

>
> This patch just ensures that we skip '.' and '..' rather than allowing a
> match.

I agree that skipping '.' and '..' makes sense, but...

>
> Fixes: 21d8a15ac333 ("lookup_one_len: don't accept . and ..")

...This Fixes is a bit odd to me.
Does the problem go away if the Fixes patch is reverted?
I don't think so, I think you would just hit the d_inode sanity check
after lookup_one() succeeds.
Maybe I did not understand the problem then.

> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/exportfs/expfs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
> index 3ae0154c5680..84af58eaf2ca 100644
> --- a/fs/exportfs/expfs.c
> +++ b/fs/exportfs/expfs.c
> @@ -255,7 +255,9 @@ static bool filldir_one(struct dir_context *ctx, cons=
t char *name, int len,
>                 container_of(ctx, struct getdents_callback, ctx);
>
>         buf->sequence++;
> -       if (buf->ino =3D=3D ino && len <=3D NAME_MAX) {
> +       /* Ignore the '.' and '..' entries */
> +       if ((len > 2 || name[0] !=3D '.' || (len =3D=3D 2 && name[1] !=3D=
 '.')) &&

I wish I did not have to review that this condition is correct.
I wish there was a common helper is_dot_or_dotdot() that would be
used here as !is_dot_dotdot(name, len).
I found 3 copies of is_dot_dotdot().
I didn't even try to find how many places have open coded this.

Thanks,
Amir.


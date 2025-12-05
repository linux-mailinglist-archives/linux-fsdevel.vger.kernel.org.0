Return-Path: <linux-fsdevel+bounces-70820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9331FCA7BA2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 14:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC5AA327CBB9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 13:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF2A3148C8;
	Fri,  5 Dec 2025 13:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jANnTY5C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BA62FD693
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Dec 2025 13:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764940240; cv=none; b=Uy1OeOswT++iUOg5GCJz7kZActFumOS5rFnxGX6ez+gttqZmL2HrNEqnhHCP94HJY6k6epgWaP24FFfPMrN8XjbjV2jwNkL5zZoh2EBvGdCK9V8kIjS6BAN3c20aZMaxt3/IDi298cLnZ+hwe77gIDBljsNRMOGiXSli0XENE2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764940240; c=relaxed/simple;
	bh=4xT4/pFJO58+sUQqy+VKD18mXqMmuLjv58AdpSWrsqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KQUPSqRI5ZKi1eyTay9v2m3WcDAzb9edtemX14KO3QhSokBkekXSzdcLlkWcF38LQ9TDPkbxF0QFq4vwMcwlqj0X+fd3+BmI4IHudlimE2OxIYlNeKCOihxzP0RZoJLOBdrcfXyBB2cVidZqNIWSSBwDPWzlAMzA2roVaezUmXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jANnTY5C; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-640a3317b89so2678213a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Dec 2025 05:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764940232; x=1765545032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BcX4laLHRubdDtehon4atANvt8XPKg8C/L9HFHj0XXM=;
        b=jANnTY5CKI/iWOxZj4Gux9ylngOhasqpEi7Y2aPgB49Ej4PZXGQ15SMJcCHVeUoOvr
         pGZr5drc4iyc5013evVuE+vNh2HyHJ3KneaTHkjbzaAyBrk5R5F/aMrcLS3coTPsResl
         GflWxCOAx/qv28K9JIaAUYXQPge4vFeg3bbgYq5BpNDbUz7OaepXCyWVbR3Rk1PJg0yn
         +nTTl7B/1Pe5FSW3VWCJPDthkembivvx07s58kMo/vMFMlP8Yysm1mKc1em/o8MNmR25
         efaeko1falL8SAcMhD3seEES/V6IeWoQ5QRbCCf0H0rfFAF3QE8XfPVNiryinxKq/5Y0
         FDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764940232; x=1765545032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BcX4laLHRubdDtehon4atANvt8XPKg8C/L9HFHj0XXM=;
        b=DGHIoi3iHEV3SJMqkQlvZJE8exQ9sQ5FbmDOjKD5BvVQRA6VziSi4QkocKsCummnSX
         P8N0K5O7f3pwPTyVdmco+rfAJ9Vm44UhLKNHL5ls+WGc3/0CbZhjft0aUFjROj5CTjb6
         QTyJpiRl3tvpvEWW9GBbSYOX/X4ylWbjTzx4B1Gasj6wbbcWS7z1fCwKfT6QjulRh+SM
         MfAy8BuLJyjTEBnxR1GRjXl4yXSJrRbtE3HZ19PPgE6owj2OTClQvNrPfIQ1icbUqW1g
         6O+0qqjgsn3R2iHTtaxI3/4ggV4nM0bSUFbJ5QL1N9IxitTpkPhO8MvcaswpM1EQcS2D
         +RmA==
X-Forwarded-Encrypted: i=1; AJvYcCVYv1nJY3lyeBSRAYeq2gobNBDdK3tsziQ2pVaKz4Db3tDhO8GZ2XsVfNlLZ3Z7lYXdHNzYENfU8ogMK6aS@vger.kernel.org
X-Gm-Message-State: AOJu0YyGtyGBX0Dl/roM8ta/caghy5sNUnL3FbBL2mEMUtuJyW6Zg98h
	W5uV4EAFixz40TN1y9+gPnLhbpsmB/Vz8nMYSgyozdgTWrNckiJqDE5MWmXPeQS75w3cyD0qCeQ
	R2oNCXRqKK9RyDPlNvQllSKbDRj4Bqz4=
X-Gm-Gg: ASbGnctu2M2xroH4EAWIfzvHruOz4UTfvP78j2R2I6Y4+Q5TwfTZ7fcRC48sRUEcGea
	U6wMK8PaefUBPdSZTrNVXYFhewBQ0jHMdj5q5X/dcnPqNfcktlRoI7pUJPDqWQVX16zyd0Eo1fh
	8ASDv6gZr9y4iE4LAJuB/mK5EPzTGcaQy10nDaQSuHMgrB3X15vqMNcTYH6x2oQv0RKBLmeStPe
	N4vMmyFTuTOcov5+qv3wQZql0OJZL1FLBduMpNIbkuOt2o54Y+SD5xIJqLwbEqXXWpoRxKjWsa5
	MSCW5r/tWNHX9gXWhXpmvvfqgZEAGw==
X-Google-Smtp-Source: AGHT+IH+bjqgyF4OybLZ1CaPOMTtMUxyQI+oBWVuVFxhRMeYZbs+FAfFHkppRjihAVO8Xel8hzJQI9GT1FDKtcuBEeM=
X-Received: by 2002:a17:907:3d89:b0:b73:5e4d:fae0 with SMTP id
 a640c23a62f3a-b79ec472670mr615900466b.23.1764940232062; Fri, 05 Dec 2025
 05:10:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205-tortur-amtieren-1273b2eef469@brauner>
In-Reply-To: <20251205-tortur-amtieren-1273b2eef469@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 5 Dec 2025 14:10:20 +0100
X-Gm-Features: AQt7F2o5_v64pqrTjhaGm5Wj_Gk-rT48H5Sc9ihWo997QO_hAZaF5Fa4k5_WQKw
Message-ID: <CAOQ4uxjxcNW174cdJzjPErPkKarpM=zyXhexXWc3YRJLB1mSHg@mail.gmail.com>
Subject: Re: [PATCH] ovl: pass original credentials, not mounter credentials
 during create
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org, 
	Linux FS Devel <linux-fsdevel@vger.kernel.org>, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 1:11=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> When creating new files the security layer expects the original
> credentials to be passed. When cleaning up the code this was accidently
> changed to pass the mounter's credentials by relying on current->cred
> which is already overriden at this point. Pass the original credentials
> directly.
>
> Reported-by: Ondrej Mosnacek <omosnace@redhat.com>
> Reported-by: Paul Moore <paul@paul-moore.com>
> Fixes: e566bff96322 ("ovl: port ovl_create_or_link() to new ovl_override_=
creator_creds")
> Link: https://lore.kernel.org/CAFqZXNvL1ciLXMhHrnoyBmQu1PAApH41LkSWEhrcvz=
AAbFij8Q@mail.gmail.com
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks sane
Thanks,

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/dir.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 06b860b9ded6..ff3dbd1ca61f 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -581,7 +581,8 @@ static int ovl_create_over_whiteout(struct dentry *de=
ntry, struct inode *inode,
>         goto out_dput;
>  }
>
> -static const struct cred *ovl_override_creator_creds(struct dentry *dent=
ry, struct inode *inode, umode_t mode)
> +static const struct cred *ovl_override_creator_creds(const struct cred *=
original_creds,
> +                                                    struct dentry *dentr=
y, struct inode *inode, umode_t mode)
>  {
>         int err;
>
> @@ -596,7 +597,7 @@ static const struct cred *ovl_override_creator_creds(=
struct dentry *dentry, stru
>         override_cred->fsgid =3D inode->i_gid;
>
>         err =3D security_dentry_create_files_as(dentry, mode, &dentry->d_=
name,
> -                                             current->cred, override_cre=
d);
> +                                             original_creds, override_cr=
ed);
>         if (err)
>                 return ERR_PTR(err);
>
> @@ -614,8 +615,11 @@ static void ovl_revert_creator_creds(const struct cr=
ed *old_cred)
>  DEFINE_CLASS(ovl_override_creator_creds,
>              const struct cred *,
>              if (!IS_ERR_OR_NULL(_T)) ovl_revert_creator_creds(_T),
> -            ovl_override_creator_creds(dentry, inode, mode),
> -            struct dentry *dentry, struct inode *inode, umode_t mode)
> +            ovl_override_creator_creds(original_creds, dentry, inode, mo=
de),
> +            const struct cred *original_creds,
> +            struct dentry *dentry,
> +            struct inode *inode,
> +            umode_t mode)
>
>  static int ovl_create_handle_whiteouts(struct dentry *dentry,
>                                        struct inode *inode,
> @@ -633,7 +637,7 @@ static int ovl_create_or_link(struct dentry *dentry, =
struct inode *inode,
>         int err;
>         struct dentry *parent =3D dentry->d_parent;
>
> -       with_ovl_creds(dentry->d_sb) {
> +       scoped_class(override_creds_ovl, original_creds, dentry->d_sb) {
>                 /*
>                  * When linking a file with copy up origin into a new par=
ent, mark the
>                  * new parent dir "impure".
> @@ -661,7 +665,7 @@ static int ovl_create_or_link(struct dentry *dentry, =
struct inode *inode,
>                 if (attr->hardlink)
>                         return ovl_create_handle_whiteouts(dentry, inode,=
 attr);
>
> -               scoped_class(ovl_override_creator_creds, cred, dentry, in=
ode, attr->mode) {
> +               scoped_class(ovl_override_creator_creds, cred, original_c=
reds, dentry, inode, attr->mode) {
>                         if (IS_ERR(cred))
>                                 return PTR_ERR(cred);
>                         return ovl_create_handle_whiteouts(dentry, inode,=
 attr);
> @@ -1364,8 +1368,8 @@ static int ovl_create_tmpfile(struct file *file, st=
ruct dentry *dentry,
>         int flags =3D file->f_flags | OVL_OPEN_FLAGS;
>         int err;
>
> -       with_ovl_creds(dentry->d_sb) {
> -               scoped_class(ovl_override_creator_creds, cred, dentry, in=
ode, mode) {
> +       scoped_class(override_creds_ovl, original_creds, dentry->d_sb) {
> +               scoped_class(ovl_override_creator_creds, cred, original_c=
reds, dentry, inode, mode) {
>                         if (IS_ERR(cred))
>                                 return PTR_ERR(cred);
>
> --
> 2.47.3
>


Return-Path: <linux-fsdevel+bounces-68429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE14C5BE69
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 09:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 05DFC347CC6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 08:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916792F691F;
	Fri, 14 Nov 2025 08:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="JapMT2ri"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BFD275AE4
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 08:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763107925; cv=none; b=n1VkQ+vXDZbYecioaY1fnQ8CgBf+XFXUxg8Iil4oTuvOK+9jus47Pw+EJcNARLoXLWdof3goH0852pxsh1GdxLHN6FclToR2wbc6dSHH8qdo1JOLq3rI2knvbKsLmc0TcvwW2Vv+GgqcCbtzQc0UBlPgvJ+SQvelFnZy6/7hz2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763107925; c=relaxed/simple;
	bh=2Nn/O+GZJ8UWH7JXYzyAxSsE/VBZL5uhOgeHLPsrSJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pqG+opJDOmQf7pHcIvdUN8yIqsjlKciCofJ+klppAiiyptOXOGEVx8K7fx5xkbB6SFsMfyuVXjLyYPuZ2LG42OAMLrn7Xqsn00ofR+x/3ZWrbCpAzKqZeqmiI0V8IJM+XGLcJqP7vY3njYX+XNuBkkqe2FDklgg4IIN51wbXHlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=JapMT2ri; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4eda057f3c0so17660201cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 00:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1763107922; x=1763712722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLfVcDpI3RAusEuEjFESKY20VJ4qiWxE+QiJxYfv3Ak=;
        b=JapMT2ribPIROP7WfJcXYJ22ItfTSnvPLpVuyqfS3gN15UKuc7OHDazwv01fgmjG00
         4yyk0yZUW8bM+bWuSwAwqDu6gG2UBG9Iz0DO6ZltkyM5VtdazgUh/kfS1VRn/aDmSXEh
         6itWE1cA24DQi7m6xrocRSa0IJdJOqcuNb/uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763107922; x=1763712722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YLfVcDpI3RAusEuEjFESKY20VJ4qiWxE+QiJxYfv3Ak=;
        b=g2Z6qoT5Oc93QuG383YLOy9Rdn+sNswqP60qWI7Hr/+1MTi19faHpjK/FLjB8XJMhy
         4GunUvafqycrvo1dV74JiOtPiG6LUFtRku/kAF3fENd9Xzt8Kc/sHm8Mp/gw96/M3IdX
         O5fFxzjgVDZ54L/iJb3Uq5ECS3nCTQ+5gVN+5Hv0dlSsozHXVv2Mwb44t2sweS5NIqfV
         EQG7G+2dPcfQEUH+EXjVQ9nrJSi3lNpG6gOL8ppIJ8qmPBc20tqh+x0S5EI5BQRjfWa/
         OUWlsaSwGIsEaTJ86c0/GKuKiibuzwsz2IwHowfMT/F4HtBlRszYzxkQnfGK7IShUKQq
         76pw==
X-Forwarded-Encrypted: i=1; AJvYcCUjJOJcicQVqFh+SpxMOpZnCA+tNhvT7u3HbDyhhl+uLfxQqz5iKcH3rUddPsVXBiNMKST5P71SbW1qPzR8@vger.kernel.org
X-Gm-Message-State: AOJu0YzcqKIYyeodQhIR9GcWoXzApOt2WZdp2utB0nsKd9T2pZh2/55H
	VDoHjagdJ3eVejbstBoaQpT2OCzytNveykG6cUi+2HpACaV4TyDB1QkdwdS5sFmo+ZBGwk0LP98
	TdSZMX9XmJbHSfemeDKNsySmjX9Bn6VOUfIUejPq0Zw==
X-Gm-Gg: ASbGnct6BXjlaztfHr/hg4FH+mmJfm+B5L760qg5BGDQwjMTduv0xcRkp0J5rcJgmA2
	dfyESBSRxHx0aeAwiSmW0w4XXlTt1IB74TEhYkVwqnt2ZA+6Go8kSYDtkrtLMBhlOJDTxCDquxO
	8kvgr1mHspp1RLhGbCQXSMo8V6zjXPJXrb4UvniPvkOsFuizNGIbaHGTSg2Uu31f10fFIMoGE+C
	plZn72SQenIyj+nLz5DJ5ZBLMYJOkTp2oaJlqWPIHT63Cw18FHUNRoF61/n63M7AnOnjbQgG2Qy
	rRZCibew8AJoxODDu9hngoLlRAPx
X-Google-Smtp-Source: AGHT+IEOOLPA2Vz2a8o6ePEs13VnvFpU+d4CJUKkLnlVnfKTf5HEFL/JokcFdJIUBaveIyTl86u8Ryz1YZG91FRmGzk=
X-Received: by 2002:ac8:5d08:0:b0:4ed:b6aa:ee13 with SMTP id
 d75a77b69052e-4edf2048517mr27830481cf.13.1763107921940; Fri, 14 Nov 2025
 00:12:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org> <20251113-work-ovl-cred-guard-v3-24-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-24-b35ec983efc1@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 14 Nov 2025 09:11:50 +0100
X-Gm-Features: AWmQ_blmlrX7aK71yUPHFTI6Pz3X49d6a6ZAw8kI-vVkPe14egOcQPWSJ9rtF7c
Message-ID: <CAJfpegtrXoywfudc+x7tP_riDeSM2AGFwgGwWjdUa3UqQ85ndA@mail.gmail.com>
Subject: Re: [PATCH v3 24/42] ovl: don't override credentials for ovl_check_whiteouts()
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Nov 2025 at 22:32, Christian Brauner <brauner@kernel.org> wrote:
>
> The function is only called when rdd->dentry is non-NULL:
>
> if (!err && rdd->first_maybe_whiteout && rdd->dentry)
>     err =3D ovl_check_whiteouts(realpath, rdd);
>
> | Caller                        | Sets rdd->dentry? | Can call ovl_check_=
whiteouts()? |
> |-------------------------------|-------------------|--------------------=
-------------|
> | ovl_dir_read_merged()         | =E2=9C=93 Yes (line 430)  | =E2=9C=93 Y=
ES                           |
> | ovl_dir_read_impure()         | =E2=9C=97 No              | =E2=9C=97 N=
O                            |
> | ovl_check_d_type_supported()  | =E2=9C=97 No              | =E2=9C=97 N=
O                            |
> | ovl_workdir_cleanup_recurse() | =E2=9C=97 No              | =E2=9C=97 N=
O                            |
> | ovl_indexdir_cleanup()        | =E2=9C=97 No              | =E2=9C=97 N=
O                            |
>
> VFS layer (.iterate_shared file operation)
>   =E2=86=92 ovl_iterate()
>       [CRED OVERRIDE]
>       =E2=86=92 ovl_cache_get()
>           =E2=86=92 ovl_dir_read_merged()
>               =E2=86=92 ovl_dir_read()
>                   =E2=86=92 ovl_check_whiteouts()
>       [CRED REVERT]
>
> ovl_unlink()
>   =E2=86=92 ovl_do_remove()
>       =E2=86=92 ovl_check_empty_dir()
>           [CRED OVERRIDE]
>           =E2=86=92 ovl_dir_read_merged()
>               =E2=86=92 ovl_dir_read()
>                   =E2=86=92 ovl_check_whiteouts()
>           [CRED REVERT]
>
> ovl_rename()
>   =E2=86=92 ovl_check_empty_dir()
>       [CRED OVERRIDE]
>       =E2=86=92 ovl_dir_read_merged()
>           =E2=86=92 ovl_dir_read()
>               =E2=86=92 ovl_check_whiteouts()
>       [CRED REVERT]
>
> All valid callchains already override credentials so drop the override.
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/overlayfs/readdir.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index 1e9792cc557b..12f0bb1480d7 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -348,11 +348,7 @@ static bool ovl_fill_merge(struct dir_context *ctx, =
const char *name,
>
>  static int ovl_check_whiteouts(const struct path *path, struct ovl_readd=
ir_data *rdd)
>  {
> -       int err =3D 0;
>         struct dentry *dentry, *dir =3D path->dentry;
> -       const struct cred *old_cred;
> -
> -       old_cred =3D ovl_override_creds(rdd->dentry->d_sb);

Myabe ovl_assert_override_creds()?


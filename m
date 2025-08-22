Return-Path: <linux-fsdevel+bounces-58753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5653B31395
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 11:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75CA4B030BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 09:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08EC2FE56C;
	Fri, 22 Aug 2025 09:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzmtH7sl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D082FDC45;
	Fri, 22 Aug 2025 09:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855032; cv=none; b=syPTQHHtg0uFVdr8cxmTdpz4eF2D4Z/LfyfgsEHL/WrsukuPstXiSCIA/ccqo8c1VyCgzM92BlqdGIqnAZvxNAb2wllKs7NZQLLMl/Bd5l5HD3MzwfXqcV37uDnzcGgHrRtkTSaVnWqq1UmREi27cvyXcmuIqES8pCI6B7+bpzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855032; c=relaxed/simple;
	bh=AmRI0+n40n0XBbEDIk0Yz7g74l6q6EXrVnNBDvSy+qQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Plu7oAG2r7T01tWtcVr2f8S9E9GWC+GvceViWfUZFgK0+A55uZzK+KN2fDrYdtoAATwlruV3pcq3KVcExmxPBBWGW6/hcL2TA7yhYKGaT1QbTG62tCGH+MvH1mbb3l0f2jebusBo3z1DhAxEamh62A/a6dFA01ko+3uDy3J6Lbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzmtH7sl; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6188b5ad4f0so2728457a12.0;
        Fri, 22 Aug 2025 02:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755855029; x=1756459829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QA11vh0vytRcgWuvXCyfPl/I98dGtmkbOJTfVhMA26s=;
        b=RzmtH7sls8HuXxkHGFV4WyQKNKl3XY+TQDC+83reXwww3R12MFy57fP/wToipFtt6A
         wRTV7axJmj6yyq68bVu4nYQfWAMdB2m9TY4+lWBSCCf+Ns2X3QXZ3XsT74i9hsexoBF+
         I6JCWulEGapGHwCYFnC5qxcZticYPIPMUlhlp7hdMerrw09jRNO4qd81G55QG7bg3bCL
         qQM8xXh/KR75oESpge4DGZkIyHaoY75fcN1/zw19VfVq96+QwLHGhRYx5mrXPMDV3KCi
         e7Y5DHl+RBcsL3EaRPhKRQWAIisOJusOopq9SUvMHmFT3tiH+cHZjtXsfLL/xPUhWUJj
         3Z2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755855029; x=1756459829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QA11vh0vytRcgWuvXCyfPl/I98dGtmkbOJTfVhMA26s=;
        b=cFSTYu8BgsjeFMggHGPSOsTmz/8UYVcqyUt3a0IDp6P4yBtu0DFuElTeRjJAPs8BEv
         DmaaoPG6rJ91x0n/ugaOGDEBwXEGB61DvIoOK5Nycgh1p+PFvN5zI9ie3oMJeaiikPjU
         P5f6J6a3sRv4P29v6Zo1gVM/vh35bgz3nw1BoBSW+BVHomTN3Jd5EKER0H4WZo+lSkDm
         oh2O4lbpDSLNFXN3Ja6IJZY7gUJN6oOLHNRWbDjBsDS6M1kSStbciQCocvms5tkikjs+
         oFGKBhQXsyZ0+VKMqJO+tvTGKzsbKD+ISmxFYDtmfUDerrLaE9agfK2FKWIRSjZbRnub
         EcUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNkJeFi0S0/MM1/5m0KbwvBDaNAA3lEpgxfPvVGJ96TeFYKVr+YshrmIr76qtm2ajanzdfqS/icdEGPmLL@vger.kernel.org, AJvYcCVNkX7ivCguk2HnIGqwJT62An7NOTlfFsJBkPT/jQEPjUUBUORD8dXt601DnRMVW6U87VBpGbOfuvP+fxbt@vger.kernel.org
X-Gm-Message-State: AOJu0YzStv/QIj1Nwrny/pPJtFGP6g5RrtqB+B0tihymfFCWObuIVdAQ
	JTrP41SJUnYd3JV3+LKvBNSr6BdE7wOY4nbeYqeetr1Mn4Uc3IeaERZ99/FhGbn5RHcTu5fM6jt
	13pgcvvRGLkgReedeUIpjkYcv9XQTbOE=
X-Gm-Gg: ASbGncucCiqfYks1JKiaijTjw3g5tMIlLll9VCJwJvcExDdg+lxP4tSYfvS2w7MACUr
	qu+kUVLVG5v6yGBNpA6ndSvk35EsH0vKGjdNbPHPQv/zb0XVx3h7/hmrfDA0ejiQR1TTnYjx19n
	3Yk9FH3jougdEdoWdh8EEUkUmXJ5KzA+OguQ7n0WfIDPM74sXWl8e0H069zFWMbQOj4s1EfoUFn
	uoQ7a0=
X-Google-Smtp-Source: AGHT+IF42KkZ2c0sI4b9Dq+zLsMgfB67YMP8ZCw2mWLwKxZ00wxQHbBagdfyv/4Eo0By453jWgy8EGcritB0Mpv9/TE=
X-Received: by 2002:a17:907:1c1a:b0:afd:e6df:3d4f with SMTP id
 a640c23a62f3a-afe28fea97dmr200343966b.5.1755855028421; Fri, 22 Aug 2025
 02:30:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822000818.1086550-1-neil@brown.name> <20250822000818.1086550-8-neil@brown.name>
In-Reply-To: <20250822000818.1086550-8-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 22 Aug 2025 11:30:15 +0200
X-Gm-Features: Ac12FXyhOIFCzZv3P0etaYzEGIILa_RfGf74HnMQksOoAHIt4QBZGVkYhr2T5cU
Message-ID: <CAOQ4uxj37GYrg=wfPRSr-7meK_QOpRbefJ_sShuVpzVfb2iisQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/16] VFS: introduce end_dirop() and end_dirop_mkdir()
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 2:39=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> end_dirop() is the partner of start_dirop().  It drops the lock and

If they are partners I think it is better to introduce them together
in the same patch.

This goes for all the pairs that your series introduces.

It simply makes sense from review POV to be able to
verify that all callers have been properly converted.

> releases the reference on the dentry.
> It *is* exported and can be used by all callers.
>
> As vfs_mkdir() drops the dentry on error we cannot use end_dirop() as
> that won't unlock when the dentry IS_ERR().  For those cases we have
> end_dirop_mkdir().
>
> end_dirop() can always be called on the result of start_dirop(), but not
> after vfs_mkdir().
> end_dirop_mkdir() can only be called on the result of start_dirop() if
> that was not an error, and can also be called on the result of
> vfs_mkdir().

These are very confusing semantics.
I doubt these can hold for a long time,
but I guess if this is temporary then maybe...

>
> We can change vfs_mkdir() to drop the lock when it drops the dentry,
> end_dirop_mkdir() can be discarded.

Fixed some typos above ^

>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/namei.c            | 50 +++++++++++++++++++++++++++++++++++--------
>  include/linux/namei.h |  3 +++
>  2 files changed, 44 insertions(+), 9 deletions(-)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 4f1eddaff63f..8121550f20aa 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2778,6 +2778,43 @@ static struct dentry *start_dirop(struct dentry *p=
arent, struct qstr *name,
>         return dentry;
>  }
>
> +/**
> + * end_dirop - signal completion of a dirop
> + * @de - the dentry which was returned by start_dirop or similar.
> + *
> + * If the de is an error, nothing happens. Otherwise any lock taken to
> + * protect the dentry is dropped and the dentry itself is release (dput(=
)).
> + */
> +void end_dirop(struct dentry *de)
> +{
> +       if (!IS_ERR(de)) {
> +               inode_unlock(de->d_parent->d_inode);
> +               dput(de);
> +       }
> +}
> +EXPORT_SYMBOL(end_dirop);
> +
> +/**
> + * end_dirop_mkdir - signal completion of a dirop which could have been =
vfs_mkdir
> + * @de - the dentry which was returned by start_dirop or similar.
> + * @parent - the parent in which the mkdir happened.
> + *
> + * Because vfs_mkdir() dput()s the dentry on failure, end_dirop() cannot=
 be
> + * used with it.  Instead this function must be used, and it must not be=
 caller
> + * if the original lookup failed.
> + *
> + * If de is an error the parent is unlocked, else this behaves the same =
as
> + * end_dirop().
> + */
> +void end_dirop_mkdir(struct dentry *de, struct dentry *parent)
> +{
> +       if (IS_ERR(de))
> +               inode_unlock(parent->d_inode);
> +       else
> +               end_dirop(de);
> +}
> +EXPORT_SYMBOL(end_dirop_mkdir);
> +
>  /* does lookup, returns the object with parent locked */
>  static struct dentry *__kern_path_locked(int dfd, struct filename *name,=
 struct path *path)
>  {
> @@ -4174,9 +4211,8 @@ static struct dentry *filename_create(int dfd, stru=
ct filename *name,
>
>         return dentry;
>  fail:
> -       dput(dentry);
> +       end_dirop(dentry);
>         dentry =3D ERR_PTR(error);
> -       inode_unlock(path->dentry->d_inode);
>  out_drop_write:
>         if (!error)
>                 mnt_drop_write(path->mnt);
> @@ -4198,9 +4234,7 @@ EXPORT_SYMBOL(kern_path_create);
>
>  void done_path_create(struct path *path, struct dentry *dentry)
>  {
> -       if (!IS_ERR(dentry))
> -               dput(dentry);
> -       inode_unlock(path->dentry->d_inode);
> +       end_dirop_mkdir(dentry, path->dentry);

Like here we have end_dirop_mkdir() after operations that
are certainly not mkdir.

It's setting developers to fail IMO.

Thanks,
Amir.


Return-Path: <linux-fsdevel+bounces-60445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB829B46AB6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 11:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F1C07C6CF2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 09:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294BC2E370E;
	Sat,  6 Sep 2025 09:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfAabT3O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9AB315D4A
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Sep 2025 09:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757151891; cv=none; b=hyW3loCYYmFXuP53+8WszckPqjqx682Y4pwXgqR931X/h5t362/UQpQ0JxVqoN4nqfBueHHsXv8e8xSmvwCwU9ngE3FHY5NJMjJcrEqArSrYib68nbqi3yvWaZ4sqcUdlCzmSk11G0XXxrYHQ+boclCc7JsHfJMjzKKmhUMBlwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757151891; c=relaxed/simple;
	bh=IT8z/FpqK+9CYiX1QVL/UoRh0f49LifUqFbSRH/R3g8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EdLVRkfea1bcNTkuSMvXpJrXQ86QnAoUhqSp4tink6FmGoFEGw/EKpM2GhcVVPUCSdr+I+UkL5JqJKuLyWkhwYyDLX4HOBlmf7SnrUjL/hiKy+ElEYkv3jkakm49wHXxH4/gGkpLYJ7E/5hfdlnX6Uj03ezxL7EC2mJeKY8TfH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfAabT3O; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6188b5ad4f0so4546059a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 Sep 2025 02:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757151886; x=1757756686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=caDOoccUW9DoCSI9qqsvwsdWLcUVHcR7HtVzxD8QcNk=;
        b=UfAabT3OCGghQt3KrC36iK3sG3AYQSMENKMgYHqV7Mr1L2D4tZV/bClTMyIeIPRtcr
         W5IQPqU5MZFVAtlvGaYcW3UN3y23BquUZItmyL3Ybt1OcBgGkby/prP3404wVY94XLcQ
         4UZiq8PwtAs+Yxov2NMz54SzT8TsNeMftrcplnVAfAvHAA7Uwlt2zGyr1c2n6RLFeKUg
         jq9aZ+dwvoJRkwxZoYGwJ4NjDhQJ9JyzUOB8oregN62iFUUpJFRuAAm3tyXyqL+py311
         nl+gSjVTabkmK2Z+sgGAf/ZUHqfq7AZz4D26rYm7nmmf3+L7FEcPj3vN9+vUkEIQfOSy
         JraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757151886; x=1757756686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=caDOoccUW9DoCSI9qqsvwsdWLcUVHcR7HtVzxD8QcNk=;
        b=E7gud7IjzL39ajwguoBAefjSFLQk3iWGUvHUhY70WDwxRrWsRIB4eymcTT7al/rmL8
         Hid3Q/CPhICdJiaKRXRbEU2xmEBtUUvY+lopNeSJ3/szmM8HLGPdx6ZEf8Kxp3AMVuSi
         IFitBtCCF6phQ4GzjkzNAhOg6aJEG70pOTy3uwfWctBkS3skYrsE5x9S3Cjovxit6OYf
         mrjbunX3ZQXR7g9SdsnK9JgbzWxbsjKlJhmWi0QIj09RbJEP3hs1w0GXvrVXf4Bmd8ec
         UZQ9msqf+RQUEAzU/Pzm3vgA8XaECdwI/5Q+VYvYLK1nZZai+D16bAR99g09JPZmiKTB
         tuQg==
X-Forwarded-Encrypted: i=1; AJvYcCVBgPm4kTA0jWOxai+Ac9YOhZxukZqTZ1O1GieIDWJqroa91yYHlubRp2p0f2W1AFXV9AQncEzA0+2F9RFe@vger.kernel.org
X-Gm-Message-State: AOJu0YzbkVp5sD1DTKIkojjTphEgPHzoCtmhhhZpLVSlcNhWLH4WH48e
	89sZgHrFX6Fq3OavrLtrZ7GM9fQC0PJeSvfnjcU8L6qbIIRYndNNZzH0WZL0qvH5yK+NFPzeLm6
	9+4hCBW60vlkN9qYjrf1Y4bB9Ml4mFuZDUxts1jk=
X-Gm-Gg: ASbGnctymQFc1xg0x2e6irVJdm9kgqI8bs6r66y1Um+CBu70Ve0UgIZM0R8RKL1K7z6
	D5L2R6f4KDXIs86PGOSRgchfgnR9xcLlmGFeA8MEfLbzcSw/ELzGkaOVLmDOCYfXZIhMJ0WCBsq
	EzgzOYaHDRur9qk+wKYwtYyzJPg9C4qsibRAhtf4xz9E+QaaUxd8UVdS2YovBeAoHZkoaSec+Bj
	8wOUFh6MlyWYK2RLQ==
X-Google-Smtp-Source: AGHT+IHdoavQCR6qA20gHKK4lKBLo0EOIFErgtJWALqqrujT9BtGYJYyavbNVMMCp2M2Pwd50+Vt0m48mPc/AVtvU/s=
X-Received: by 2002:a05:6402:2355:b0:61e:d25a:784b with SMTP id
 4fb4d7f45d1cf-6237abddc60mr1684671a12.7.1757151885873; Sat, 06 Sep 2025
 02:44:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250906050015.3158851-1-neilb@ownmail.net> <20250906050015.3158851-3-neilb@ownmail.net>
In-Reply-To: <20250906050015.3158851-3-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 6 Sep 2025 11:44:34 +0200
X-Gm-Features: Ac12FXzvvXzb4ssbDXfDO0l_KQF2fOpMy0mD0KDB0lE-De62Fj3IjcAsBpJ85eI
Message-ID: <CAOQ4uxhnvYeJiZ9Bd73kwu3y4VCeeJCvNN1K+GExxF4koA+bxA@mail.gmail.com>
Subject: Re: [PATCH 2/6] VFS/ovl: add lookup_one_positive_killable()
To: NeilBrown <neilb@ownmail.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 6, 2025 at 7:00=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
>
> From: NeilBrown <neil@brown.name>
>
> ovl wants a lookup which won't block on a fatal signal.
> It currently uses down_write_killable() and then repeated
> calls to lookup_one()
>
> The lock may not be needed if the name is already in the dcache and it
> aid proposed future changes if the locking is kept internal to namei.c
>
> So this patch adds lookup_one_positive_killable() which is like
> lookup_one_positive() but will abort in the face of a fatal signal.
> overlayfs is changed to use this.
>
> Signed-off-by: NeilBrown <neil@brown.name>

I think the commit should mention that this changes from
inode_lock_killable() to inode_lock_shared_killable() on the
underlying dir inode which is a good thing for this scope.

BTW I was reading the git history that led to down_write_killable()
in this code and I had noticed that commit 3e32715496707
("vfs: get rid of old '->iterate' directory operation") has made
the ovl directory iteration non-killable when promoting the read
lock on the ovl directory to write lock.

In any case, you may add:
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/namei.c             | 54 ++++++++++++++++++++++++++++++++++++++++++
>  fs/overlayfs/readdir.c | 28 +++++++++++-----------
>  include/linux/namei.h  |  3 +++
>  3 files changed, 71 insertions(+), 14 deletions(-)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index cd43ff89fbaa..b1bc298b9d7c 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1827,6 +1827,19 @@ static struct dentry *lookup_slow(const struct qst=
r *name,
>         return res;
>  }
>
> +static struct dentry *lookup_slow_killable(const struct qstr *name,
> +                                          struct dentry *dir,
> +                                          unsigned int flags)
> +{
> +       struct inode *inode =3D dir->d_inode;
> +       struct dentry *res;
> +       if (inode_lock_shared_killable(inode))
> +               return ERR_PTR(-EINTR);
> +       res =3D __lookup_slow(name, dir, flags);
> +       inode_unlock_shared(inode);
> +       return res;
> +}
> +
>  static inline int may_lookup(struct mnt_idmap *idmap,
>                              struct nameidata *restrict nd)
>  {
> @@ -3010,6 +3023,47 @@ struct dentry *lookup_one_unlocked(struct mnt_idma=
p *idmap, struct qstr *name,
>  }
>  EXPORT_SYMBOL(lookup_one_unlocked);
>
> +/**
> + * lookup_one_positive_killable - lookup single pathname component
> + * @idmap:     idmap of the mount the lookup is performed from
> + * @name:      qstr olding pathname component to lookup
> + * @base:      base directory to lookup from
> + *
> + * This helper will yield ERR_PTR(-ENOENT) on negatives. The helper retu=
rns
> + * known positive or ERR_PTR(). This is what most of the users want.
> + *
> + * Note that pinned negative with unlocked parent _can_ become positive =
at any
> + * time, so callers of lookup_one_unlocked() need to be very careful; pi=
nned
> + * positives have >d_inode stable, so this one avoids such problems.
> + *
> + * This can be used for in-kernel filesystem clients such as file server=
s.
> + *
> + * Ut should be called without the parent i_rwsem held, and will take

Typo: ^^ It

Thanks,
Amir.


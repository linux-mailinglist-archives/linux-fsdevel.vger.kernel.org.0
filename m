Return-Path: <linux-fsdevel+bounces-37712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D39D9F612D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 10:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27591188DBDB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 09:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A111991AF;
	Wed, 18 Dec 2024 09:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQa+zb8W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE7919885F
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2024 09:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734513320; cv=none; b=qC7dW7ODcZCaW5uHhJ1rPg9O+2+8AOsquTt2fonDrR155pBQ7wa0SOcPY9s/DUtEkp0+PLDRJq1FM8693U7lkLws84zyxGlF75QhY/Si3UEDZcylpc7ysTb8J9Igw6TitYpGJVDmm+oleVsBRetkEDd9i4WafkUQ1DEZCwme8H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734513320; c=relaxed/simple;
	bh=JktWVxl+2h5d2LggqFbD4JRF4M9mzR27cq362xXJ4xw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VDqCy6veq02lZoUtOtOnxHD+hj/BXEYTbKHa6MY3Xb3feDSuZpFU8qq8cfdYDjcGVlWPSpYY8bo1v2mkHsoycH4zvS3FEqYXYyJBW7en+Vuv2XUgFFYuazoLFUkLq9+2R5iqbamwPEbA0yaErKDRj3a77jy7QRWMvQcvSsPQeWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQa+zb8W; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6eeca49d8baso5347747b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2024 01:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734513317; x=1735118117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQBxCGJW96yXX72WABDRKpr97cAX5kqZrzMAzGwxwRA=;
        b=cQa+zb8W47zSTixqyLe1BOABoLG9ZqqLAsMCPK4ihPr+xUecmOCE0RJLo34D5Odgy7
         qaBWeGtY27fNfinMAli4c2tkHYNLdiz+M8obGHlMpEUf9oLxRXBPx4MK1kvM9zY8WTur
         1aob11SchXyP0NbXH+ZrDauBfIWcaDZEd/QeeCyQ/vvygP6WTE+4J/thB/TOzfWX8Cl/
         k4o35ByMO4sFwzw6niuyhBYcQkxLHLcq6L8w9xa0tWt6s1L9Rhvxkvo+6rS92puwDI/X
         IqAN50QghjxljhVrVwNy0kPjC8bQAeGnSVsYPPj7m7yuYdZPs1WP8BqeDvKqrQfFP7hM
         GdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734513317; x=1735118117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQBxCGJW96yXX72WABDRKpr97cAX5kqZrzMAzGwxwRA=;
        b=Ram6N2RRCwXY8WMI0r6EmNWFzB0/nj5rJbE2DNoZa8kxYM3OykjVAu49ZFuB6wfLV9
         4c7Y1l4TatbiZcmp/c3kC+8zpc0E6SSNtj45cu3L9zEUHhkDVIgcGD+63R6fJZW+7SQO
         99bAV/dNGRh91rSai9b+ug8o4tAMfC/ZGuYM4Ib7Eg+5jlakteIm+jKetrVZS8d8UadR
         RzI3vTU0vhG1zKh7TPaMEmAgGlxsvbRxoFqWvuLm4f+TubPEsGB8uJXhj07EvL0zbFSu
         17G7XQr/s0OTz+ZbpMISc5yuIe26obpjvM97LRwYtB7YYtSbpuEJJUEa5ReiQJxM8snl
         Mmjg==
X-Forwarded-Encrypted: i=1; AJvYcCU5kPEXccC3z6QZp9zBO+AkymMJEvVbUFxWMjcwH08zitBQpKGu5vahouWob9yNkdFPOQBoNKrHoPnr/tKj@vger.kernel.org
X-Gm-Message-State: AOJu0Yw09lhZ2ZGuFjnDVNVWN1Z8IW34trDZSfjkX3iVZBf8IpCm3R4/
	9CTLsIT2N1do0zcYdksubixhl4BIVhQmb618n1qui60ARKZd2JcPi1QPxfdV+TDuI2/jcbMOz+x
	6Y0WKqJ0RXBGk39JA9xVBnbSFZKk=
X-Gm-Gg: ASbGnctgA9D80ACl0DIu7fafX8/ofUcO6kIA96XPevmlpiS7lhXVoell8EDNRaYo6zh
	DPaE3ZU/fswaygsTctMpzgdp+Gx3eNBTc1gmXxy83OwoFGUvhCWw3IuOYE2SmoTVyBqY=
X-Google-Smtp-Source: AGHT+IHs5aOQZUaaAeECjQ9sfp053EKUzIxvyHCW0W7xUoMZ1pi2vvomRLsXfkDSD5YQwK5y1h4WbnXQ4PzXZh7TYGc=
X-Received: by 2002:a05:690c:9b03:b0:6ee:8515:6730 with SMTP id
 00721157ae682-6f3b590ba5bmr14061277b3.17.1734513317469; Wed, 18 Dec 2024
 01:15:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216-fuse_name_max-limit-6-13-v3-0-b4b04966ecea@ddn.com> <20241216-fuse_name_max-limit-6-13-v3-2-b4b04966ecea@ddn.com>
In-Reply-To: <20241216-fuse_name_max-limit-6-13-v3-2-b4b04966ecea@ddn.com>
From: Shachar Sharon <synarete@gmail.com>
Date: Wed, 18 Dec 2024 11:15:06 +0200
Message-ID: <CAL_uBtcXdULyu7AK6T0+GKn5mbY2tLtE=uUG0P3CwM9YHyjOmg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] fuse: Increase FUSE_NAME_MAX to PATH_MAX
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	Jingbo Xu <jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 11:14=E2=80=AFPM Bernd Schubert <bschubert@ddn.com>=
 wrote:
>
> Our file system has a translation capability for S3-to-posix.
> The current value of 1kiB is enough to cover S3 keys, but
> does not allow encoding of %xx escape characters.
> The limit is increased to (PATH_MAX - 1), as we need
> 3 x 1024 and that is close to PATH_MAX (4kB) already.
> -1 is used as the terminating null is not included in the
> length calculation.
>
> Testing large file names was hard with libfuse/example file systems,
> so I created a new memfs that does not have a 255 file name length
> limitation.
> https://github.com/libfuse/libfuse/pull/1077
>
> The connection is initialized with FUSE_NAME_LOW_MAX, which
> is set to the previous value of FUSE_NAME_MAX of 1024. With
> FUSE_MIN_READ_BUFFER of 8192 that is enough for two file names
> + fuse headers.
> When FUSE_INIT reply sets max_pages to a value > 1 we know
> that fuse daemon supports request buffers of at least 2 pages
> (+ header) and can therefore hold 2 x PATH_MAX file names - operations
> like rename or link that need two file names are no issue then.
>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/fuse/dev.c    |  4 ++--
>  fs/fuse/dir.c    |  2 +-
>  fs/fuse/fuse_i.h | 11 +++++++++--
>  fs/fuse/inode.c  |  8 ++++++++
>  4 files changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index c979ce93685f8338301a094ac513c607f44ba572..3b4bdff84e534be8b1ce4a970=
e841b6a362ef176 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1538,7 +1538,7 @@ static int fuse_notify_inval_entry(struct fuse_conn=
 *fc, unsigned int size,
>                 goto err;
>
>         err =3D -ENAMETOOLONG;
> -       if (outarg.namelen > FUSE_NAME_MAX)
> +       if (outarg.namelen > fc->name_max)
>                 goto err;
>
>         err =3D -EINVAL;
> @@ -1587,7 +1587,7 @@ static int fuse_notify_delete(struct fuse_conn *fc,=
 unsigned int size,
>                 goto err;
>
>         err =3D -ENAMETOOLONG;
> -       if (outarg.namelen > FUSE_NAME_MAX)
> +       if (outarg.namelen > fc->name_max)
>                 goto err;
>
>         err =3D -EINVAL;
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 494ac372ace07ab4ea06c13a404ecc1d2ccb4f23..42db112e052f0c26d1ba9973b=
033b1c7cd822359 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -371,7 +371,7 @@ int fuse_lookup_name(struct super_block *sb, u64 node=
id, const struct qstr *name
>
>         *inode =3D NULL;
>         err =3D -ENAMETOOLONG;
> -       if (name->len > FUSE_NAME_MAX)
> +       if (name->len > fm->fc->name_max)
>                 goto out;
>
>
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 74744c6f286003251564d1235f4d2ca8654d661b..5ce19bc6871291eeaa4c4af4e=
a935d4de80e8a00 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -38,8 +38,12 @@
>  /** Bias for fi->writectr, meaning new writepages must not be sent */
>  #define FUSE_NOWRITE INT_MIN
>
> -/** It could be as large as PATH_MAX, but would that have any uses? */
> -#define FUSE_NAME_MAX 1024
> +/** Maximum length of a filename, not including terminating null */
> +
> +/* maximum, small enough for FUSE_MIN_READ_BUFFER*/
> +#define FUSE_NAME_LOW_MAX 1024
> +/* maximum, but needs a request buffer > FUSE_MIN_READ_BUFFER */
> +#define FUSE_NAME_MAX (PATH_MAX - 1)
>
>  /** Number of dentries for each connection in the control filesystem */
>  #define FUSE_CTL_NUM_DENTRIES 5
> @@ -893,6 +897,9 @@ struct fuse_conn {
>         /** Version counter for evict inode */
>         atomic64_t evict_ctr;
>
> +       /* maximum file name length */
> +       u32 name_max;
> +
>         /** Called on final put */
>         void (*release)(struct fuse_conn *);
>
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 3ce4f4e81d09e867c3a7db7b1dbb819f88ed34ef..4d61dacedf6a1684eb5dc39a6=
f56ded0ca4c1fe4 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -978,6 +978,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse=
_mount *fm,
>         fc->user_ns =3D get_user_ns(user_ns);
>         fc->max_pages =3D FUSE_DEFAULT_MAX_PAGES_PER_REQ;
>         fc->max_pages_limit =3D fuse_max_pages_limit;
> +       fc->name_max =3D FUSE_NAME_LOW_MAX;
>
>         if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
>                 fuse_backing_files_init(fc);
> @@ -1335,6 +1336,13 @@ static void process_init_reply(struct fuse_mount *=
fm, struct fuse_args *args,
>                                 fc->max_pages =3D
>                                         min_t(unsigned int, fc->max_pages=
_limit,
>                                         max_t(unsigned int, arg->max_page=
s, 1));
> +
> +                               /*
> +                                * PATH_MAX file names might need two pag=
es for
> +                                * ops like rename
> +                                */
> +                               if (fc->max_pages > 1)
> +                                       fc->name_max =3D FUSE_NAME_MAX;

For the case of FUSE_REANME (and FUSE_RENAME2, FUSE_SYMLINK) with
large file-names (4095) you would need 3 pages (PAGE_SIZE=3D4096):
fuse_in_header (40) + fuse_rename_in (8) + names (2 * 4095).


>                         }
>                         if (IS_ENABLED(CONFIG_FUSE_DAX)) {
>                                 if (flags & FUSE_MAP_ALIGNMENT &&
>
> --
> 2.43.0
>


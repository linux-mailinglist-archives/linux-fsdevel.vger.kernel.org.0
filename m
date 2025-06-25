Return-Path: <linux-fsdevel+bounces-52964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90469AE8C95
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 20:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B2EB1893391
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 18:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694C82D5C8B;
	Wed, 25 Jun 2025 18:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAPzyQRE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAC71519B9;
	Wed, 25 Jun 2025 18:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750876519; cv=none; b=VbR4o4YLybrJ8GiRSfibl37y9wpG2w/UubhkQasmowJ4+XbE7RTAALbM3xcmHgY/aE43yt0OUThIUb51FZsImaUfPjN6jLxqiCqDxBCZ7+p5o1ZE+zI98oOWauIYUwwlMK6woZeWX84MRzy4yUQCt/iMB/SLPY4pMRDjHGjMLIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750876519; c=relaxed/simple;
	bh=XpW+zg8DoS8tmoildQM8rsexKGxVRWXVlhbMemKlqvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fi9aIKgyG+4JmK/TLFJNfwnzHsNSqJ5MLokExypLr1cWnUVoL3MX0KAmHWuC/FdWB8C5GnWuwEeZl8u/OEvuJXCurzpP7OhBMNGO7hR8ppZWmj5UJtY3jiGxaH4OS47T+mhAMKwXDHD4v/BPe0L2WZF6irmNfh2iHqhCjN0AqEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAPzyQRE; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60789b450ceso226054a12.2;
        Wed, 25 Jun 2025 11:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750876514; x=1751481314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gW0MqGHfo5snumPwRolRzaKUEVFlVYjWOyIrpkw/VWM=;
        b=BAPzyQREwzap6ae4wxDqiRqFI28F7587JnuvA8JPf6pXGrsroA+9M/WLf+4m6L9/uw
         ujFgBk7Hv1638v0r4++He3iSJaZvc+ya1pcWtTkT/WtP0izFeuHygYTrJDr1VzyJOAJm
         sF0FeSFkbB+aiMKBv3dbRh2wGZKYxfoabYckuO4b+XmqnmGeU6C5kYKR98wTGGSdF5au
         IxbAD5qFIj1LCnUgxYHp0pb1ZwCU+5yss07Hn6AnNL/Z2sm9IsZikUfd5xCdMEhNjrGy
         9ufGwwDP90uYv/milDmS0PWtaxPsookTNuEWRMamqJTdY9f3f8dOZSg3i1FTrH0Ufm5x
         scjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750876514; x=1751481314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gW0MqGHfo5snumPwRolRzaKUEVFlVYjWOyIrpkw/VWM=;
        b=PVe4uYLWFxQNb+Ty4MKQGqoGQVSLTaPJvr1k8kHmqkutuAlrX/g+qsYH7KgXP3Uo6X
         i8Lx9SlT5O2lh7WmJ6NVx0hOf7FUwkt0Co8K77gFDs0SFwlIkC+u26iQubEbyX168Ath
         nAlX919Js2R/W20Gg6/d5GZp5cnLK9I6f387zkQLoCvBmwyZH7O9h7QY89Wv1xUo0s3W
         O+UK3/cBQ2l/JEDTNtRaRXK5lZ9Gx8bYQSWQranMlyykPFwPtOME8iAoN4J9ZZ0PLPHY
         hXBh73S3VKxSUwM5dPhuz+52pXfU9t0Pvvgl/c6j7rUqwAzc27+dmYN2bzU+YOjVmHs2
         Diiw==
X-Forwarded-Encrypted: i=1; AJvYcCVrFUa8nylQVEM+HmqDn9ve86zIkMWMt33c2PA0uMQSfPvu3uEjOfLNBYXEiaWjuR5eM593AFgZ0zNZNgZy@vger.kernel.org, AJvYcCXqZuzSbJX7A8d0CNn/UrecLRoAuTi5jvzGsfjg31MghI6ODBy1nBFzyBQ6B5xHsgLWtjxydWy5WHdoslmjTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YysM5gcvtcWDh4b1YMhA13eRsRUCvlf6Bti1yId3MlcbXSHuyN6
	kGajF7+4J3Y7ZIkZU0OH1+FRzR8xZrgaJECGl0k+m28MZjUTLAb9UwqydJga/I0F8a8snBbYvr3
	CqljNVffauMRVTUEVaKHRfEz6UwQvmqtJVgGlf1M=
X-Gm-Gg: ASbGncvpITq/lrXYh+OxJtIxmxtgix57FGea7fZiX0OveIos0Fe6SuGqqmRCA7F+Kf1
	k+RYF5975G4Cft6b2iMhRJQeFydAfDmO0vwapnqpCC7T2kK5x602A4fv2hN7b3y+Jn4I49aLxUT
	ddN7+AAjx+hxVu/C5FiuLY1O7DL1/E3Zkwk7RLb8EcM0WKB65YgDJX6g==
X-Google-Smtp-Source: AGHT+IHUdaG51/FEQIAI+cRGAESMG8tC21AZEk1kOz0LI4qX2ue5gan3tjdk+LjomMhWPP3njGSwulZpAcAl/zQFe9g=
X-Received: by 2002:a17:906:7953:b0:ad8:9257:5724 with SMTP id
 a640c23a62f3a-ae0be86cdcbmr414182166b.24.1750876514077; Wed, 25 Jun 2025
 11:35:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624230636.3233059-1-neil@brown.name> <20250624230636.3233059-9-neil@brown.name>
In-Reply-To: <20250624230636.3233059-9-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 25 Jun 2025 20:35:02 +0200
X-Gm-Features: Ac12FXwrUopJt8aGfCCMcGif2t8l-RBn9tBa2s22kJd197r2u4dMmKvnf_18gSU
Message-ID: <CAOQ4uxjEop6Fk5iF9HgurjYWo99hkAZz_Xf-CmmsJT565=eO=w@mail.gmail.com>
Subject: Re: [PATCH 08/12] ovl: narrow locking in ovl_cleanup_whiteouts()
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 1:07=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> Rather than lock the directory for the whole operation, use
> ovl_lookup_upper_unlocked() and ovl_cleanup_unlocked() to take the lock
> only when needed.
>
> This makes way for future changes where locks are taken on individual
> dentries rather than the whole directory.
>
> Signed-off-by: NeilBrown <neil@brown.name>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/readdir.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index 68cca52ae2ac..2a222b8185a3 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -1034,14 +1034,13 @@ void ovl_cleanup_whiteouts(struct ovl_fs *ofs, st=
ruct dentry *upper,
>  {
>         struct ovl_cache_entry *p;
>
> -       inode_lock_nested(upper->d_inode, I_MUTEX_CHILD);
>         list_for_each_entry(p, list, l_node) {
>                 struct dentry *dentry;
>
>                 if (WARN_ON(!p->is_whiteout || !p->is_upper))
>                         continue;
>
> -               dentry =3D ovl_lookup_upper(ofs, p->name, upper, p->len);
> +               dentry =3D ovl_lookup_upper_unlocked(ofs, p->name, upper,=
 p->len);
>                 if (IS_ERR(dentry)) {
>                         pr_err("lookup '%s/%.*s' failed (%i)\n",
>                                upper->d_name.name, p->len, p->name,
> @@ -1049,10 +1048,9 @@ void ovl_cleanup_whiteouts(struct ovl_fs *ofs, str=
uct dentry *upper,
>                         continue;
>                 }
>                 if (dentry->d_inode)
> -                       ovl_cleanup(ofs, upper->d_inode, dentry);
> +                       ovl_cleanup_unlocked(ofs, upper, dentry);
>                 dput(dentry);
>         }
> -       inode_unlock(upper->d_inode);
>  }
>
>  static bool ovl_check_d_type(struct dir_context *ctx, const char *name,
> --
> 2.49.0
>


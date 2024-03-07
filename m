Return-Path: <linux-fsdevel+bounces-13882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A03874FB1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 14:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E01F1C221C9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 13:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C9712BE84;
	Thu,  7 Mar 2024 13:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkD2Jnr8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E9C12BEA5;
	Thu,  7 Mar 2024 13:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709817113; cv=none; b=mQeBHIgWJD5E9SYtHXbOy7AwqVcpkqH8rVvMD4S2gthooL8J1puCWWdbe13c/5fPxlp8J8t7NhkUqMLXWHn9u9yvO5vz0vtNob30t0KQcO1nBSM9U2PJUEyacnrnOVPXqM3Y5GZF+0w+w4LfQLhi7gI5WqtQCW/CaNc+XQW3qsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709817113; c=relaxed/simple;
	bh=Lq1QaYjyQtipQGGnO5MJnsz0Xw6OzrlQXM57+bjinhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cPKmaxiVTbUHrX8ByFRP2TckRKcRWwC76/o3QvNKEMf4iKK1kxDa0Nu0B0pnu+CWYzeHgCF2V9QSg9KWwY4zSTghymoCPe5nRzX64T1FWfT4U8FWlJydifBxlJt2yNLmBkhpO81K2PSg2RxnBRBTBU1AwzakNrPuMlOgqCGxk1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PkD2Jnr8; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c1f582673bso357125b6e.2;
        Thu, 07 Mar 2024 05:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709817111; x=1710421911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPhcYqdeJXp1pNyTSDJFlxDv04tur97y6OKdkVUZ8O0=;
        b=PkD2Jnr88AqYKiG4flKAXlKOJJR4az0MFD/cnfs6bhE0T1k7DzHfoos5T23DfFCytD
         ob5GUKElucEPHkjTWHRBZQKr7qKXrGE06ljxxIz/M3IALkd/+tJLm4wfKTPPUWse2V21
         20kx5qUAmkEWHjWiX/8FpkbDFEAGvbtmQoj8r5kK2Sf5kLh2cz3QGAkFNac44DFcgz1M
         qRhkFbh3bk2iWVPN05uicWg38sZrwnpibPcsfJdakPtF13TGel7nfTJPJSChdh6vTUDf
         gxndYWodzsgaYu8FlJrSzY8iNFkW1omna1ibeHF4zIFb57XjgR2TBbSVSxi48Tx5cQ2v
         /fEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709817111; x=1710421911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPhcYqdeJXp1pNyTSDJFlxDv04tur97y6OKdkVUZ8O0=;
        b=HutAHpfa4gmyHSsueJdjOJynYkyJ68XUGCDIURXAsO8eps5SfQD6zpnUELflLYtk6E
         sKlT2kGeg9ygpvdzlvpP5f6Qfq81ODuumGEhjOPMwLy1+yZEKhAPUx8zmp7ZLcGZwuHi
         Qf2vg2fty36YFaPeiLrI+g59+piv3aw1yQWYUcjPIN3pWItxp514c4YzrPydYC2PLK6j
         x6XCNY5eYdsBeAA1JSQlHgJjapE1rp1WedVYlUZ1zPhZMhGLMTnhl66KBo6OCtuRgFul
         Pp4qFPbe7U7PkjELHWVPyXrdpm9bjVGdW7+fy1i60so2Ok76IiqbOAvyqzFgo+0BHbjx
         1b5A==
X-Forwarded-Encrypted: i=1; AJvYcCXRubQiJnOI2Hmh0LlA0/JpRWIHAoFS4q2RP5yVSjq7wyGIils+OYaKwPSVh+OYQG8WcdEpQEsWysfDAtXmbIkZMdEFlbk+PGler9QUZw==
X-Gm-Message-State: AOJu0YzJUphWhsdv6rtjRvnLqf7tlMA8OQW7LLNweDAl2qet9f2oH/wI
	52g2FIFG7AYsUK9haE4OGT8bdczAT45zOlIH1zBgQXR4OYitW/AJnFFmEAHWPY1Qibx2hXlOSHY
	XA0IMjovEDykn6P4GzLvvIUTCrnw=
X-Google-Smtp-Source: AGHT+IH3sl/BuWLYIAK5yZS7lup1zcZ94HRzH2euqnSOcUy8Xg/EOg/31r1J0NsdITTuUtbDUEfRIJTZlqJ3v0PnwME=
X-Received: by 2002:a05:6870:b9c7:b0:21e:8b52:8d77 with SMTP id
 iv7-20020a056870b9c700b0021e8b528d77mr7779833oab.20.1709817110790; Thu, 07
 Mar 2024 05:11:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307110217.203064-1-mszeredi@redhat.com> <20240307110217.203064-3-mszeredi@redhat.com>
In-Reply-To: <20240307110217.203064-3-mszeredi@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 7 Mar 2024 15:11:39 +0200
Message-ID: <CAOQ4uxh9sKB0XyKwzDt74MtaVcBGbZhVJMLZ3fyDTY-TUQo7VA@mail.gmail.com>
Subject: Re: [PATCH 3/4] ovl: only lock readdir for accessing the cache
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 1:02=E2=80=AFPM Miklos Szeredi <mszeredi@redhat.com>=
 wrote:
>
> The only reason parallel readdirs cannot run on the same inode is shared
> access to the readdir cache.

I did not see a cover letter, so I am assuming that the reason for this cha=
nge
is to improve concurrent readdir.

If I am reading this correctly users can only iterate pure real dirs in par=
allel
but not merged and impure dirs. Right?

Is there a reason why a specific cached readdir version cannot be iterated
in parallel?

>
> Move lock/unlock to only protect the cache.  Exception is the refcount
> which now uses atomic ops.
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/overlayfs/readdir.c | 34 ++++++++++++++++++++--------------
>  1 file changed, 20 insertions(+), 14 deletions(-)
>
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index edee9f86f469..b98e0d17f40e 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -245,8 +245,10 @@ static void ovl_cache_put(struct ovl_dir_file *od, s=
truct inode *inode)
>         struct ovl_dir_cache *cache =3D od->cache;
>
>         if (refcount_dec_and_test(&cache->refcount)) {

What is stopping ovl_cache_get() to be called now, find a valid cache
and increment its refcount and use it while it is being freed?

Do we need refcount_inc_not_zero() in ovl_cache_get()?

> +               ovl_inode_lock(inode);
>                 if (ovl_dir_cache(inode) =3D=3D cache)
>                         ovl_set_dir_cache(inode, NULL);
> +               ovl_inode_unlock(inode);
>
>                 ovl_cache_free(&cache->entries);
>                 kfree(cache);

P.S. A guard for ovl_inode_lock() would have been useful in this patch set,
but it's up to you if you want to define one and use it.

Thanks,
Amir.


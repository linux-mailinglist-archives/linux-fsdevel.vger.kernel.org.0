Return-Path: <linux-fsdevel+bounces-51362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC88AAD607B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 23:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1815E3AA1C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 20:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7752BD586;
	Wed, 11 Jun 2025 20:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YL6nwlJW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDC219C560
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 20:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749675599; cv=none; b=HeX5+LtbDVzMb0gMTsQBgZOWi2w/Rog5fMaYcKxjnro6ewXX9SXNPl/lqa3wkZ95l9X/cnmXGJ7m/dvNi+J/w3jsO4e4hSClZrShGtWhlaxw2VcD/Gli9acEPslpqYBrNbz0ckZxI3+k35JhRU4MgEutd5ymOCpZsceRKqMpZCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749675599; c=relaxed/simple;
	bh=nATuHHUdXGwJIbec5/ITuY/3NpZYod4aFqLrAL1TCAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o1NhjHtNVVLL783/xnSETfS1QwkehKPeQPx6ZTOBZAU7roKzZ3fKXtcI991ReUMMLaZwDV0XV7zaem47Vwre+ooc98GEUwR45MWFMO0lZ3FBQzQCpq6EyMhYbWAjgr4tPX9TykvjpWyJaSZGPaNAh+X+hL6iPdT/rAMUZZJ5odY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YL6nwlJW; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-607c5715ef2so553285a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 13:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749675595; x=1750280395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BeAADMlrn5CH5UXUU5Y8bij4uMfdXwUjkzAYWoJq0Bs=;
        b=YL6nwlJWPvORH3UvVX8cd6bNIbqp3pLvg3C8YsySQycMFgVN+CvlDO24rkhHUMs4fw
         yvPZrmlQpgqAC2WAX+Uza6XP5e0vIfNjO4GgmGdW9Ebo5Fqtgw/OGbHpSf6BxwjaUGdO
         bpF3p539Brx5YN6cGHh4TD+qPqa2kynGKcBzaGMjF/dgd3/NFj/Y+5TlIFyyprxYRqTE
         sC6lxqaz5nThANRNA7k36Z0vqJ+KlNh161imYpv+X9kgr36e5shJk5OuOUZw0RYGeMZO
         TUbHtSX3yuVh9EXnZIDgDrzLwBm6TaKJHTEfGM54LA6Iv5/u/TwkZI28KELXWD+9yNu/
         iubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749675595; x=1750280395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BeAADMlrn5CH5UXUU5Y8bij4uMfdXwUjkzAYWoJq0Bs=;
        b=rRHmQPnO3qSao1TPgkuRCSgP9GhcUg08zRUuXInHOATFKhyaQlG9SDwa/hqMx5PiAY
         ruJCkZ6tize2CLp17fRlBPZ1hQa7UmPZ1/4x0bKIv6z1xxX8OMerVj8DcLC2sb44puAA
         4gxASwULKJIe/Lq82MrHHOEjIAjnFAbUjvzcUYp3JZHF1VDxKzSSaqzM9bKIjWV5/TnX
         VJPddMm9n8LxGJ7bOUIvqs0RMHbzvryxJ3321MjMCb6h4gplH6X6Mbt6m5ko6kjguRaW
         slhQSMzNp1fJRAGbJX5tAn94dksTrvlFTNe0KaIsmbRcjZuAUFva+aHuj2UuPuCpfO8E
         fpJw==
X-Forwarded-Encrypted: i=1; AJvYcCXWUgydOdr9YaQGEyaoYqnIXC1pOPNAg5XLoeAD4aw78tmI3ZaZRYbJfUCIsPG242/uEhBs+ZPG1KKv8PUC@vger.kernel.org
X-Gm-Message-State: AOJu0YxRMXVDKYAUxC7Gse97Gk3Mh/giKZN2QbSVcXHfpq6lwam6zzLI
	uOfCVXiEbIb5N9FmsIdlIF+YSFLjUMlh+/6uBYKDFbzQByzDOErDHyYD73tdl9r1LKNEtGx15Ah
	9UKWkIxRPj+KwRHbBTz36yQRyyfHAUcwIDeuu
X-Gm-Gg: ASbGncsdTwTXH1TYMX3CWbfgI+U45PyhVE3PT3gy5TO6uzY1ccf1bGV3jdyBUefKp9/
	J0J1CffGaTAAhbc+PJWPvDh4S36PCI0XZ3p25Dk8FT1q5kIh4CpFeTLQSxpxRqMMqjwOTEEidDc
	OPnlDbnjscAnltVT2CEQ6sLheR9VEUWTC0evXvZ+DECpI=
X-Google-Smtp-Source: AGHT+IEhDfxbfn2DB4RWIkj6gzxrhlJByqZqh6sB0xKClzzdOQVmnrpn6n3GXsNHmejdvL8tXfQJB3lGD9BXxo5Yrqg=
X-Received: by 2002:a17:907:3e06:b0:ad8:89f8:3f51 with SMTP id
 a640c23a62f3a-adea92790admr53820866b.6.1749675583546; Wed, 11 Jun 2025
 13:59:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250607115304.2521155-1-amir73il@gmail.com> <20250607115304.2521155-2-amir73il@gmail.com>
 <20250611185725.GQ299672@ZenIV>
In-Reply-To: <20250611185725.GQ299672@ZenIV>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 11 Jun 2025 22:59:32 +0200
X-Gm-Features: AX0GCFvtmf2b9o5Oau4qlA8CriNb1mEeSG2SHTa9FaxcVyHc0mH2Z56ySD0WQKQ
Message-ID: <CAOQ4uxh6H6eo-t1Lx9qDHGc2cctdm2L-Kq23OPdmfs-uQYy2Bw@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs: constify file ptr in backing_file accessor helpers
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 8:57=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Sat, Jun 07, 2025 at 01:53:03PM +0200, Amir Goldstein wrote:
>
> > -struct path *backing_file_user_path(struct file *f)
> > +struct path *backing_file_user_path(const struct file *f)
> >  {
> >       return &backing_file(f)->user_path;
> >  }
> >  EXPORT_SYMBOL_GPL(backing_file_user_path);
>
> const struct path *, hopefully?  With separate backing_file_set_user_path=
()
> you shouldn't need to modify that struct path via that functions...

Doh! of course. overlooked.

Christian,

Could you please apply this (compile tested) change in your tree?

Thanks,
Amir.


diff --git a/fs/file_table.c b/fs/file_table.c
index f09d79a98111..b28bbfa07cb8 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -54,7 +54,7 @@ struct backing_file {

 #define backing_file(f) container_of(f, struct backing_file, file)

-struct path *backing_file_user_path(const struct file *f)
+const struct path *backing_file_user_path(const struct file *f)
 {
        return &backing_file(f)->user_path;
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index fbcd74ae2a50..7845d029a4c0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2864,7 +2864,7 @@ struct file *dentry_open_nonotify(const struct
path *path, int flags,
                                  const struct cred *cred);
 struct file *dentry_create(const struct path *path, int flags, umode_t mod=
e,
                           const struct cred *cred);
-struct path *backing_file_user_path(const struct file *f);
+const struct path *backing_file_user_path(const struct file *f);


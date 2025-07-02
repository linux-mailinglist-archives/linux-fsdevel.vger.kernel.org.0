Return-Path: <linux-fsdevel+bounces-53620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C21AF1117
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 12:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2C003B496D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 10:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E419247296;
	Wed,  2 Jul 2025 10:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXNZ0qjK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F432367A2;
	Wed,  2 Jul 2025 10:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751450699; cv=none; b=kxdRAEymKjUoD3zBevmXlwZ7S3wLNwWLmXlDYcp+1M6QKy++uEzxrMPWlNIGFfGQFiUc9/iSdSLl0BZJbgxv43tuZdI8izX+cNZkQszAZ9EqCuEUcqDSoefkItLKO3eopKy6MI5KBhlwFaKNs7bH9LGgTrZ/RRQB2N0/yt1szDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751450699; c=relaxed/simple;
	bh=6kCZBwhk60u3ug+toq3nG333rSQ1/QODDG17fY3YGq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDHWldO+h7l/n7YJnv44OJlNNu3wBhJiv5GTfJgf7hg1C8QoCbGA/jRSvAggYJwraYenEUGi6gJHlE/pPdtyUrP9CoOCqZCE86DWsegjGjfc5LTHmuwn2F+H1YyL2OXfF9k0YZqg5xkEXqVlRzWJy0qgsM3+EqTc9ujQcE2ny0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXNZ0qjK; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a57ae5cb17so2806579f8f.0;
        Wed, 02 Jul 2025 03:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751450696; x=1752055496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rT+vt3dVIWatNPzBqk/hDuAAi24lDFamWkXfyvyYy/E=;
        b=bXNZ0qjKrevcXdcVxgseXjnGNheM/qBCReEADXK+Yz8vjfBU4hxZuSziDSWbE01ybO
         a7AxAfQ5xRzcOGRVxPjAWuIyto57EfAgv3bDbrTvgfp1946IILZJ/AiuY0Omx5n2zqmz
         1/fADWO5+wuG2gpfNY8I3kKOyMmcxSIcKR+f+p78H9IjCjBZb36+mORTzEbWuPXElI8W
         dL4LTrjlP7L92hSnQIPqG9gkoeJcgwb1Y2tDyBC0U5W3WgRfwnWFpukt1M/tFXeElE/U
         qs8xP3mlRmXCrmxsUE2DX3skT/WKUHwIsDlFnYpJemG26okETMYsCfICqKztFoLy8sYv
         yl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751450696; x=1752055496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rT+vt3dVIWatNPzBqk/hDuAAi24lDFamWkXfyvyYy/E=;
        b=WlKxqgWzXUW5eCeAfw+xEGAUbvMTUAqo5hUIvt+lQdgsgpzPNY+hT5/N6j0sFsAg4L
         aZ5R5fQAwvlCtv470SmwXX0M+WXAG0TpWzfQm3YFxOAqYMXxEbhK/r3mxCz6ri+/24Oq
         /efc1aCHoby4+/I2oLj6Eqc4IZxWcwPwqpHnxxUXBEdm8Yr2GQ0QgxTO00r7CEnBsEVL
         FyIgidRvNYdoYGDpFsMjmq1QvGeZGkt5PXDgJZ+f9W6+9dGF+11QJdI90h54s4ST7elD
         /QZGswGcrhn+groO3YtsrL7LFk8V8LyaKd0pLWLGNcPuBv7O3r+hHwkyoIvloATLoawn
         PfJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyH0jGZ4VVHvEbRGegJFTaw+nwKPVv2zjL78k5r2jJqQ0+q2W9Qu4KOCzEktnU5oiXT306ldN9kSTcCo0rMg==@vger.kernel.org, AJvYcCXYXmMrJJ4gBZhs9vsqZTDdUCcv9hdI5I24Gtz4dn3OjOQuGeVaEgwTaDU2+rOlEgh8klWP1E/KGafTpA/X@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ZikTUUtxsvt0vPEXL6B3vXBXxB178uzOsv9qoLHBwNBqnm3u
	du7fwvQmmoH2O08hFYCEd3yar43WDE34EAzjtlRa+1O9+BstZAzOP5WtX77CTolPqY9aAAiS1za
	EWxijBNcYxva4XIF0Pe6FmzqG5wMkkgIFh5wa
X-Gm-Gg: ASbGnctl/lWPYK4oqzeA7vqXFCMV8LSxDnHyJtAvHvZuBo2HuEv3Mtz+IuEnBVquRQG
	u41hLkawbrZyrVfmnp85jvF5IOC75oIsRCSPRVJCEoYr8iSRzfV8MWuAHoASmiTnWlEvMrN3M3q
	s58lFCNhSkxSt0aepyaxXE8UjuhR8GBW0lj4nX3ndNJHY=
X-Google-Smtp-Source: AGHT+IFDIEVdZAm4XvXZIErQ6BSwpeHiciKwO5YM/vWUV3UaAbyDKz0A4Bgm6Y6mAl3iHT9EqzTbsdRgisXpprxWejM=
X-Received: by 2002:a05:6000:18ab:b0:3a4:ddde:13e4 with SMTP id
 ffacd0b85a97d-3b20253882cmr1621599f8f.58.1751450696026; Wed, 02 Jul 2025
 03:04:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxgbhgGHcW+x1F=9Fo5T6ALjADC9SJhzp_mSooqUb8_6sA@mail.gmail.com>
 <175142407307.565058.17313140186618695058@noble.neil.brown.name>
In-Reply-To: <175142407307.565058.17313140186618695058@noble.neil.brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 2 Jul 2025 12:04:44 +0200
X-Gm-Features: Ac12FXyUWE1PyerJ7uOmwRT6KDvw0Y0vGfJDxuVHPf3H0IFmQoAmQfDVgb2bzB0
Message-ID: <CAOQ4uxgF6eA3Pyudy05nLobByK1A7NE_3pBo6UfPj4YOyzi6Mg@mail.gmail.com>
Subject: Re: [PATCH 10/12] ovl: narrow locking in ovl_check_rename_whiteout()
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 4:41=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> On Thu, 26 Jun 2025, Amir Goldstein wrote:
> > On Wed, Jun 25, 2025 at 1:07=E2=80=AFAM NeilBrown <neil@brown.name> wro=
te:
> > >
> > > ovl_check_rename_whiteout() now only holds the directory lock when
> > > needed, and takes it again if necessary.
> > >
> > > This makes way for future changes where locks are taken on individual
> > > dentries rather than the whole directory.
> > >
> > > Signed-off-by: NeilBrown <neil@brown.name>
> > > ---
> > >  fs/overlayfs/super.c | 16 ++++++++--------
> > >  1 file changed, 8 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > > index 3583e359655f..8331667b8101 100644
> > > --- a/fs/overlayfs/super.c
> > > +++ b/fs/overlayfs/super.c
> > > @@ -554,7 +554,6 @@ static int ovl_get_upper(struct super_block *sb, =
struct ovl_fs *ofs,
> > >  static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
> > >  {
> > >         struct dentry *workdir =3D ofs->workdir;
> > > -       struct inode *dir =3D d_inode(workdir);
> > >         struct dentry *temp;
> > >         struct dentry *dest;
> > >         struct dentry *whiteout;
> > > @@ -571,19 +570,22 @@ static int ovl_check_rename_whiteout(struct ovl=
_fs *ofs)
> > >         err =3D PTR_ERR(dest);
> > >         if (IS_ERR(dest)) {
> > >                 dput(temp);
> > > -               goto out_unlock;
> > > +               unlock_rename(workdir, workdir);
> > > +               goto out;
> >
> > dont use unlock_rename hack please
>
> The lock was taken for the purpose of doing a rename.  So using
> lock_rename and unlock_rename documents that.  I can use the less
> informative "inode_lock" if you prefer.
>
> > and why not return err?
>
> Some people like to only have a single "return" in a function.  Some are
> comfortable with more.  I guess I wasn't sure where you stood.
>

Generally, I think we need to move toward more scoped variables and
less mult-goto-labels in ovl code, which are a common source of bugs,
but I will not require this work from you of course.

Thanks,
Amir.


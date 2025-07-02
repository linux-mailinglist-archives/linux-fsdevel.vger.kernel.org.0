Return-Path: <linux-fsdevel+bounces-53623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB15AF11BC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 12:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C014544341F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 10:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235E2253957;
	Wed,  2 Jul 2025 10:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PS3beibc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EC1248F5A;
	Wed,  2 Jul 2025 10:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751451800; cv=none; b=jU+XUx2AGSYBABpv4IlLZOvQYtqLFJ69nAAxHheYaTTGzRDOmZTjBjIIb9PfrQLtHOQoAX1vFY2VvgPKV2UEnVjxGU4X4/LNDCZBvbfb+uLMjIbRVgBseGZ5IStOaRkJ1xGiPO4XrpJ2pcwkFgLRp6s+x0i+dNXPjQEJTVsA3e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751451800; c=relaxed/simple;
	bh=ToTWXH/kSBi8YPaAlLozOWcXBRNmpoVIe36jcMrelqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UQLIZ+8461CgBGWo0K+NtA+RtQEQ91myugCXkLeB5HE32KOshfsKyvQYdr+eAJYswx5M0ISEbPASmEe5czaQk9ZC9j/qQzxzhpp1ri6Mo7zXaNxJ3dZ1inEL8yvej1mutVuLKHSaUeKT3C5puGH0cHsHUnVYo8PtCZttNKpzkpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PS3beibc; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a6cd1a6fecso7087318f8f.3;
        Wed, 02 Jul 2025 03:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751451797; x=1752056597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uj/0fi2wvV9tdrl0l4JDJuC2H4vJjClBMsiQ3eUhaP4=;
        b=PS3beibcu5ZVA5GBynyEZDDA64lMgqwr9gkEtPKECRz2XFmD20E9HljQ9a8lTH1F1W
         0ooYbxyLdoGbFSQTqRzJsbxOxC3E5QLepg+7VP0Lf3EbhL6ZFDtMUjl5Iy9bKARt3vdD
         ovfo6MMfk9QQpOyfZCdtrjFwtmQbijK3EuMTMiI8U4cMRYbTT8HhAOIcG16aelJzhVtO
         f4qujWuj/jR5VWEn90Hrr7CIBgAqOD/YnZtJfFxolZZFTVgnwN5kKXs+yG4EJh7e8Muv
         65gxuOfDwaH6kHOhnUm40kpeL5azJ8cxIxQzHB/6lakimc8/dCUqYKiUxvO4zui0Wo4m
         A5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751451797; x=1752056597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uj/0fi2wvV9tdrl0l4JDJuC2H4vJjClBMsiQ3eUhaP4=;
        b=WM4kqotV8hgTu+FJgKt+9O4iR8RJC6n9eASRkZrrIrKXi7QcHeutZ8ml19R5pP7SVd
         yRYwhOjbUdAQ5fwnSVpa34gxs+GG+WalCM1PgJhElmu2QwErePOZnxC3xx0Uz2viZdri
         a0RMqOKzvb4Gpo4oLJVXK+TjojLjps53wru9aGH6CW1Qd8FSYqjeRhhGhTChpcFcPopB
         UijyZcH2wY3Kfjqz3KgxIGkOOedYhJjMsTni3Pa4gI4DIKgX7JdHtt4HZ6kGx5n914DE
         tvfM4MajAM51eAieT0/mCqakt+xjiAKyQ6SNp6awu7Axbx6/CHjVPfOTxOZOTEs4C2qj
         cMZA==
X-Forwarded-Encrypted: i=1; AJvYcCVAtcnX8cMC+w3h50Sn4JH71U56omlXgDxcbtTg0UU6M9u0XZoR7gqbYkyc7bLL78yPbxA7OSNqlhe66XHv@vger.kernel.org, AJvYcCVY232UC/P6cvtQNyx54cP7OvYhAanvhKDr1BRHhs+1dsn2nutfPLQuhCgPpBrM9iC+CKfwr/dFdVxg2KF6Kg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3BWZqVYoKVpddcppz9Q9V1nA9nqXfNwA3PypJxxTRktGfzswA
	nIVIciva2VdOafSI7URS28s++Bba0CAqaI5HAAfoZbvbBGsll/1IS7YtJdgoI4fKlwH8dSXXi6o
	tR/BBAsP3z6Soki2SwKzkvA5J/ybzZBQ=
X-Gm-Gg: ASbGncsKBDwzN96daj1jeBFBcpiC6+4qc0hNlUpJSgdeOkivNMti/R9nA4uSEVXa9M0
	oUhlGyeioUoOdPEEaX1F2QhWgre3Vl/IwOzbvp3+W+udwe/IFBwcGg+6iD5/YDLA4DEk1TRJndE
	bzMlM9g71i6JOW3EvSKeuTk3L2Wpq+Namt2UyPtm8n9qI=
X-Google-Smtp-Source: AGHT+IGcbf/wbV9QTkPZPNDA96+Vg+/yex7SvPxeaVTdYG+1/91WIZOB1439rPi7TUq+dj2QaOvpF6HbUOg1Whgj69Q=
X-Received: by 2002:a05:6000:410a:b0:3a4:e56a:48c1 with SMTP id
 ffacd0b85a97d-3b2012f8d6dmr1679456f8f.55.1751451796966; Wed, 02 Jul 2025
 03:23:16 -0700 (PDT)
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
Date: Wed, 2 Jul 2025 12:23:04 +0200
X-Gm-Features: Ac12FXymiHiPlWup0QBaobZLTtYHdSMS7Y5zPTWPA1KDpRUU09CG53LP1bVpxyk
Message-ID: <CAOQ4uxijGyZt7QB1CAWCAoyVbwLFwS6fewL-A4e00jyXSC25Hw@mail.gmail.com>
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
> lock_rename and unlock_rename documents that.

IMO this is not a good excuse for using lock_rename() here

> I can use the less informative "inode_lock" if you prefer.
>

I meant that you should use the new helper that I proposed
in review of patch #2, lock_parent(workdir, temp)
instead of the weird looking lock_rename(workdir, workdir)

BTW, I see that lock_rename_child() effectively has
lock_parent() code in its first part, so maybe factor out this code
as lock_parent().

Thanks,
Amir.


Return-Path: <linux-fsdevel+bounces-52960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BF0AE8C25
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 20:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C0674A6079
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 18:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D092D541F;
	Wed, 25 Jun 2025 18:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZ00erM9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D2F4204E;
	Wed, 25 Jun 2025 18:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750875439; cv=none; b=OUYI5NO2ALWns/nPSR7aUJpLXou0yTKmVvZq1ivTvUJD5wNGK24Yq50hQ1etGcOvmJcZEId972qG4zgXFybiZM67Bsf+NP2WE7BE68of+I3WH5BC1PrTzUQhKcotMjEtcyku7ye6/F+oVOptx7OMSoI1+etgEHL28yeFQep5HNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750875439; c=relaxed/simple;
	bh=H6FckANt2OVbjwtgig5D+tXvfZIWT0Jdwc9PSVjo7LI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cf72kisyeCS2S27liPZNfTQDZFn3wucqHgDJ2193SoaHB9HDDVfzWbkSmwuMpnF3068rmrAFXozpAV1fOCckbMXahLrvIWv6DJspOoa8BdrbOANTxUubzLDrGPXuK+0o1LvtkIs9GxhXMIZkkcB9AbsGhDyuEZb00Ih+UNEHYqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZ00erM9; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-adb2e9fd208so36211766b.3;
        Wed, 25 Jun 2025 11:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750875435; x=1751480235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbX7Gp2dBa282U3GIWXNLYiB/wBJtP1+hWFU1CN+YNc=;
        b=PZ00erM90tnuHoVGCuVkQw/qTkgcBoevKE/05PzDMavM175VF0AAoQnO2+5coROua8
         OwRVfqf6Sqley6ExEbYYK4l0MHLrfNfLsKSIyatPlUUYmdL+BD3az/NIe124SIFUrwwt
         fhF7xyGbMX1cx5UzBK1nxobrs4nUSH5gwifN+KUFZo8clXJ8m5UYvH1NSSfP+rCZ/M0n
         7sjWqQfyIk2DBqs1QisQUdmeu7uqwrupz+6kqyUB4moEsHnVblhNTKZ+PvnQ8YMSSko0
         5hduqRHdwauwdRU+lRVInqrCWUyOhWtvQeQ13evh6mDSIyueqCHpG36DkW3UtY6i3Y+U
         lahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750875435; x=1751480235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mbX7Gp2dBa282U3GIWXNLYiB/wBJtP1+hWFU1CN+YNc=;
        b=fpyjzyKBSHjNT8UmyOvGMMFHMiTOzYo+Qsp2YCI3TYSNtnBoGtInDCCTtxGUAoDR5c
         WjAN52eRcBLiMhmB690DFK89YLpMzPOj+QdiKI0JXI35GmiNYJuWtvTDGjaSLz/9k8iZ
         j3u3ISuzOrSu3zA6l9/zCGvTAhyiDUcdLNKF9VWONcQ0o3aUv72V6ANZOaoPJfLFDH8A
         30hcdLlz+d/m+D59CPDXpPwUo2QJwAO18sq0Sgsyook9UQ5dnIV7q1M1AfymUyY2P3yU
         6EFLZjHQn9y5CHGpJf8MEjm2qttGLta1JwXrQgDtj1tPnvNC7ke8FRyPpLooiRlXlHai
         MtfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVDi152mclEkbxMRRPHa1jfzJZ0m3rAkWQHzUr8vlppl8oJ/5pp/WXCLBmOWUletD0LU9H3+LB/OFn9YAIPQ==@vger.kernel.org, AJvYcCX95PbrYBvknyERJk7q0kGbm07+SgPwHtLVwxQkjpsKLrFoeWhII25NvrMe6boZgHYUCUicG3sYUzur69Lq@vger.kernel.org
X-Gm-Message-State: AOJu0YzZo+IJPr3S/GzoajGqWYVP6YLMWvCw7NdqhfUyY9aSZRsryRyL
	sISjQGaO5FLeuhXlQ5YhMrFEkjclGpLinxkZtL1YYKpMcC6oT+7lg8oMMtBF7uI2u6fwIhHlhQr
	zC5uV9Q6k50rZh/tN03RHCcdLnNbWy2k=
X-Gm-Gg: ASbGncuYvX5nRnfRMZS7d4KIAE4efYKopb2AI455vhoEQqQqFJfVq8IkFKKid9PmB8m
	4LwsbYs1WESmNwo7p2vUsN5l2ih9qz8goh7PvfW2AOmvEOsXa/A1tijugwnqFh8D9mupogg/BXx
	Rz4nz8PzPWRWJZeOQkJLyhteODsAt6Y1lhZkXN020OVW0=
X-Google-Smtp-Source: AGHT+IF6Fx/66CWT6U3FTRXtsow5ebX01MZ1KXbTPjuJpz48EQnR81z+h3BDc4NMjw4yJwoGwqXSY5I+MGXr/tHuhz8=
X-Received: by 2002:a17:907:3f8b:b0:ae0:d019:dac7 with SMTP id
 a640c23a62f3a-ae0d0b835aamr99642466b.23.1750875434756; Wed, 25 Jun 2025
 11:17:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624230636.3233059-1-neil@brown.name> <20250624230636.3233059-5-neil@brown.name>
 <CAOQ4uxg5EQ+Zt_RLXv-f5DuJONFzrL=9-z1tg4rfL12c-u7uJw@mail.gmail.com>
In-Reply-To: <CAOQ4uxg5EQ+Zt_RLXv-f5DuJONFzrL=9-z1tg4rfL12c-u7uJw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 25 Jun 2025 20:17:02 +0200
X-Gm-Features: Ac12FXzszRX4zFfuPvMCeBnoEZ668ng4PG36MMlQmU-Tm4ON79-iqkGE2ASKaLI
Message-ID: <CAOQ4uxiP510uDGtyPfkW6KDpnZQtWQ91iZPhXQXdZDj+LQvSFg@mail.gmail.com>
Subject: Re: [PATCH 04/12] ovl: narrow locking in ovl_create_upper()
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 7:55=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Wed, Jun 25, 2025 at 1:07=E2=80=AFAM NeilBrown <neil@brown.name> wrote=
:
> >
> > Drop the directory lock immediately after the ovl_create_real() call an=
d
> > take a separate lock later for cleanup in ovl_cleanup_unlocked() - if
> > needed.
> >
> > This makes way for future changes where locks are taken on individual
> > dentries rather than the whole directory.
> >
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/overlayfs/dir.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > index a51a3dc02bf5..2d67704d641e 100644
> > --- a/fs/overlayfs/dir.c
> > +++ b/fs/overlayfs/dir.c
> > @@ -326,9 +326,10 @@ static int ovl_create_upper(struct dentry *dentry,=
 struct inode *inode,
> >                                     ovl_lookup_upper(ofs, dentry->d_nam=
e.name,
> >                                                      upperdir, dentry->=
d_name.len),
> >                                     attr);
> > +       inode_unlock(udir);
> >         err =3D PTR_ERR(newdentry);
> >         if (IS_ERR(newdentry))
> > -               goto out_unlock;
> > +               goto out;
> >
> >         if (ovl_type_merge(dentry->d_parent) && d_is_dir(newdentry) &&
> >             !ovl_allow_offline_changes(ofs)) {
> > @@ -340,14 +341,13 @@ static int ovl_create_upper(struct dentry *dentry=
, struct inode *inode,
>
> >        ovl_dir_modified(dentry->d_parent, false);
>
> inside ovl_dir_modified() =3D>ovl_dir_version_inc() there is:
>    WARN_ON(!inode_is_locked(inode));
>
> so why is this WARN_ON not triggered by this change?
> either there are more changes that fix it later,
> or your tests did not cover this (seems unlikely)
> or you did not look in dmesg and overlay fstests do not check for it?
> some other explanation?
>

The latter - the assertion is on the ovl dir inode lock and you dropped
the upper dir inode lock.

Feel free to add:
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.


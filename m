Return-Path: <linux-fsdevel+bounces-33003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B04F29B155F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 08:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A92828348C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 06:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631B2161326;
	Sat, 26 Oct 2024 06:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PG8DNDwO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2076217F2E;
	Sat, 26 Oct 2024 06:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729924268; cv=none; b=pr0yfQKj1siZyc0Wt45ADbQc3T6eeCJzz7VwnjVP+3GtTOTfeqRL1R/jbmKQmVjenZ4o7xE212rM86GPwBX6ECMawqxljwaBfjaDt6QHHAZmEnZg84/TlbiGChpqJYSieNEVPh/VnzJ98IBoHD9T9pgHH9sFLHYurusXlQZ/f+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729924268; c=relaxed/simple;
	bh=xcTymT/JUFrC8VS1y5EhXyMyTO4mXKDg9AHcymMek/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lsAPRET5agK+WYCMxdgnk/Ym0xjjpcwJMkuNjYgLB3E/+YtOe/w62kqivCsLd1acHybAH+7UFNXt5nzAgqsaTJWSDraj07zK9sdp3UiiI2bym6edUXMO1ddgkOl5AEdIz80snmvMftctM0S9BWgRvRlgky5laDDkQKS0Q4gULd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PG8DNDwO; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b152a23e9aso198869185a.0;
        Fri, 25 Oct 2024 23:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729924266; x=1730529066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWhF7+udgHjvUno0T8ZPjRtG1NqCAUnaMntb3giKxsk=;
        b=PG8DNDwOuHGfqBpn9q6gWQv2L56WeI1CyWSAoSbN+T176YOHzH3XtS5LboRthpjjH8
         rNLQiV/V+Za7wNF+LdkWY9cLHoABlqXeGpK/EhaJ+ghGwzJo4p879iU6W+cNNTDnl2Dz
         XDQjLQRzNIMftXDBRyKThlQHRkSa+lb7xclC1ziUopEggczZqk1xsuzuj8kSDe1VPLbB
         kTCH8DfDDv8vOKAKtf+mMEGxKa/StAWFGG1O+kg9KRodj43p4DIPmeTT7a6h8IRcdYTp
         HkGGdmwSxLtkp9dfrLjkvaBwPOqF9ZWx4EaujSdaKkVdQ6ouDC/kRXEH3jkhWa6DWzKG
         rMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729924266; x=1730529066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kWhF7+udgHjvUno0T8ZPjRtG1NqCAUnaMntb3giKxsk=;
        b=hk73cdmIG4bcwk+u+R4u/gsIgrfx/ibRMhJNdxhzgIb7tH1bjrw7dNlk8X8i40w12N
         UpDStnmiE7etDdHTDTo6FYJbcVt4l3HYidk0J91Xgihk/vW7aGL9NsPOVXyM6qCoIiuw
         m1sY9eeM/nHZLHz6ZOaof2qw2OpryfxYYx0k677EIVOYU4O+pVWQpc+PqbeFaFKRXxZf
         ExS2/+2rBuj22AegMztaud2bTevxumIkhcDEjbinEh7suYAmpmtxANUZs9PwNW075lsn
         bx/j4cALwAI7avCBj1oFkPLeavB0/Nv3b3HXkvPH3W2O4EjH573Z31gFEMmHdkMeaGJ2
         7lkg==
X-Forwarded-Encrypted: i=1; AJvYcCWSOs2k4VrAJIjtbm8SJVL9Voiv/uJK0KYarix1aG5DnwnbWud5u57AM0xMfg2CR3+Za7hctoUHrRDtRyEH@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq6m38PUVWblvKFcBTQQtLUY2aRIOVrUJudWCBxiwTLB1xXA4W
	fT4ivrWxo/MixioN34rKj6oeIUj6PpcN6rJxi85JNhDI71yvq9hcrHA3V1V9zJC1NYqwarlkANK
	cpRBuULxBcgY0m+qYNVQCqtb225c=
X-Google-Smtp-Source: AGHT+IELBz3L9rFQmNf+e9nPKPj7Dp5EnYVodk1BGctxCjxfZswtjTRPTCtmBl4XuGhOSi3aQO+ShxSH7BnEXQ+LL54=
X-Received: by 2002:a05:620a:4710:b0:7b1:4aa3:d3c9 with SMTP id
 af79cd13be357-7b193f706f5mr242303185a.61.1729924265728; Fri, 25 Oct 2024
 23:31:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025150154.879541-1-mszeredi@redhat.com>
In-Reply-To: <20241025150154.879541-1-mszeredi@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 26 Oct 2024 08:30:54 +0200
Message-ID: <CAOQ4uxhA-o_=4jE2DyNSAW8OWt3vOP1uaaua+t3W5aA-nV+34Q@mail.gmail.com>
Subject: Re: [PATCH v2] ovl: replace dget/dput with d_drop in ovl_cleanup()
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-unionfs@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 5:02=E2=80=AFPM Miklos Szeredi <mszeredi@redhat.com=
> wrote:
>
> The reason for the dget/dput pair was to force the upperdentry to be
> dropped from the cache instead of turning it negative and keeping it
> cached.
>
> Simpler and cleaner way to achieve the same effect is to just drop the
> dentry after unlink/rmdir if it was turned negative.
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

Looks sane.
Applied to overlayfs-next for testing.

Thanks,
Amir.

> ---
> v2:
>  - use d_drop()
>
>  fs/overlayfs/dir.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index ab65e98a1def..c7548c2bbc12 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -28,12 +28,14 @@ int ovl_cleanup(struct ovl_fs *ofs, struct inode *wdi=
r, struct dentry *wdentry)
>  {
>         int err;
>
> -       dget(wdentry);
>         if (d_is_dir(wdentry))
>                 err =3D ovl_do_rmdir(ofs, wdir, wdentry);
>         else
>                 err =3D ovl_do_unlink(ofs, wdir, wdentry);
> -       dput(wdentry);
> +
> +       /* A cached negative upper dentry is generally not useful, so dro=
p it. */
> +       if (d_is_negative(wdentry))
> +               d_drop(wdentry);
>
>         if (err) {
>                 pr_err("cleanup of '%pd2' failed (%i)\n",
> --
> 2.47.0
>


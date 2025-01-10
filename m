Return-Path: <linux-fsdevel+bounces-38906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E109A09BC4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 20:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B83193A7083
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 19:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EDA214A61;
	Fri, 10 Jan 2025 19:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Li/TB0NC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81DC24B248;
	Fri, 10 Jan 2025 19:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736536856; cv=none; b=qfDl3UsIy16eAoSVV8hELvNrfvoV/yGMxo37YlMywICnK12sAO6LG2oefBJIgy82C+Pg2dDXCp4SWbwOIGX1iniJ7fJQ90k8/3OBolH1kCtsEq0A5kgRRhlmLPMSxWNMcpXo5Cz3EJimS1o0h3915USuoSciTim4+ikYjyeeHAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736536856; c=relaxed/simple;
	bh=TsUacba3ZNHue/H4DtA4q8B1cm7VOIj72LZpEo+y4gs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gvucpWdnP+8eVhG3Kh28CufrIJAWe9eQb1ilLmwv6hZhaQamQ1rxfk4fpC46vYcE0/7+5wIxj7QXwL1DrAvrI64do+Dysf/om9dAQb0l63db4aeKDQyfwuEsl31Z6rciWBUoGSpZPsEnDjMW9IEP8qeJBg0fsVJHiz0kyQQP/sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Li/TB0NC; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53e384e3481so2235112e87.2;
        Fri, 10 Jan 2025 11:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736536852; x=1737141652; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w2ETi9XuLcb2bxyHKTfjjsalpH1+hdaYldvTRFOmiXQ=;
        b=Li/TB0NCm7TdyW9gNo8bFTz8C6Ntz9H9vug0BC/MV+AU54br5vlllQUTinBU6sRShb
         S07ePnjGS+fXOTyrAxF9Vjdlq3+xmOGSF2sGrG16LawA5p1iRkCH1yr8U8dpWtowS6y6
         AUh/d1OxSmG2GGFcckz6lOZJxjmErWq+IEW6vYhvOyO3tT0pIbGxKF5qELan3H77ZLh4
         W37oVYVYbtak68DPHW4LRAGY8ApS0+4XrtVBO6SgmNjJ52PMrV+5G2aHLrOJ/65mTCX4
         s9Qt02pEyDztCvjVOUHSwQcuMXkLT2tkXPTwlOEIfWV0Kq1/1xC9AdhAi2ZkxuhA0N6n
         Xe1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736536852; x=1737141652;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w2ETi9XuLcb2bxyHKTfjjsalpH1+hdaYldvTRFOmiXQ=;
        b=LkA3RO6H6m0hFAYl+BJfjEXaNixYRGrEGSQ9fMT/tr/0KB4yTnp2VZCtWAaTgaoc5s
         Jq53A7qjYAG73SEWIil8hq6nYZdE4JgNNu+A7MUoO+iR0/+8dMW+jWczBWKIJKGno/uy
         67thWbpytqxg/enSeeshG/fSiG20AzjB3aRiI1moo4cD/vHAbqEOsu3ZP8R7E8ME4z1o
         Wwm5Dba65cf8szeCR66CRrAE9i3EaVSA/vWi5dXFrMG/kGfdeYXneDH7k3xZAabmNzSk
         6l1/8NYbz56io2Y5Zt3Ksp7Z+y0YOo4AMcasvIeLxOOieOCilDurM9ZLQyxGPC41Tcrr
         Goag==
X-Forwarded-Encrypted: i=1; AJvYcCU78MROnwWv4Sp0I6U7CKrgjjH6cquqVsam+two+5P/eH/HpamDtWVCvQ7qnVHu4kZLNC0PqTmpZRu2@vger.kernel.org, AJvYcCWsBY3pRgLw6QGJwPkmTtAV+4zQW0ESciBKggssb+MOVKdSZg2X303t0aM6L/nrmHxhfPsQSetjOOai@vger.kernel.org
X-Gm-Message-State: AOJu0YyYwb7rSnn5u3gouhFPIGv1KRWw/2qjySlucOTuI/7F1jEJkxhF
	NFJuTyyTDuZvvjI6zzP8bfs6r/K3NGR/P94RXIZ8fUSIht1n315yW3H6yYAfc6dDxGTB/Xsd5ZK
	L3Y94y1PASscrKIM/Ij7C+u9D6o8=
X-Gm-Gg: ASbGncvRkFFMMn2t8by8v8EjgvxmMmmlG/mhIO0nP5OHh0IdxIhdD8hFodNzUYD90aw
	3zfE4vvrzeDZuVnPzh21BivI2hsxjztQbqEuR
X-Google-Smtp-Source: AGHT+IEAdYrk21bidDzR//LEYUeS/P2MwthakCw7I93640ZsXXLOWOiIkfaQ5wxzDoRvZrP/6PmRJGmbCrUYaeNsvBQ=
X-Received: by 2002:a05:6512:23aa:b0:540:358d:d9b5 with SMTP id
 2adb3069b0e04-542844ad98bmr4322449e87.0.1736536851587; Fri, 10 Jan 2025
 11:20:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110023854.GS1977892@ZenIV> <20250110024303.4157645-1-viro@zeniv.linux.org.uk>
 <20250110024303.4157645-15-viro@zeniv.linux.org.uk>
In-Reply-To: <20250110024303.4157645-15-viro@zeniv.linux.org.uk>
From: =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date: Fri, 10 Jan 2025 20:20:40 +0100
X-Gm-Features: AbW1kvbywTuwz72RGQtWElnGxGCJpZ-FnlbRCT77Q-5fBd30IjCjaa4HU5INQXg
Message-ID: <CAHpGcMLGujcBko5LeRgYCLzT4JCh16Jn97iXDZr8EZ4sMaKn_A@mail.gmail.com>
Subject: Re: [PATCH 15/20] gfs2_drevalidate(): use stable parent inode and
 name passed by caller
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, agruenba@redhat.com, amir73il@gmail.com, 
	brauner@kernel.org, ceph-devel@vger.kernel.org, dhowells@redhat.com, 
	hubcap@omnibond.com, jack@suse.cz, krisman@kernel.org, 
	linux-nfs@vger.kernel.org, miklos@szeredi.hu, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

Am Fr., 10. Jan. 2025 um 03:44 Uhr schrieb Al Viro <viro@zeniv.linux.org.uk>:
> No need to mess with dget_parent() for the former; for the latter we really should
> not rely upon ->d_name.name remaining stable.  Again, a UAF there.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/gfs2/dentry.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
>
> diff --git a/fs/gfs2/dentry.c b/fs/gfs2/dentry.c
> index 86c338901fab..95050e719233 100644
> --- a/fs/gfs2/dentry.c
> +++ b/fs/gfs2/dentry.c
> @@ -35,48 +35,40 @@
>  static int gfs2_drevalidate(struct inode *dir, const struct qstr *name,
>                             struct dentry *dentry, unsigned int flags)
>  {
> -       struct dentry *parent;
> -       struct gfs2_sbd *sdp;
> -       struct gfs2_inode *dip;
> +       struct gfs2_sbd *sdp = GFS2_SB(dir);
> +       struct gfs2_inode *dip = GFS2_I(dir);
>         struct inode *inode;
>         struct gfs2_holder d_gh;
>         struct gfs2_inode *ip = NULL;
> -       int error, valid = 0;
> +       int error, valid;
>         int had_lock = 0;
>
>         if (flags & LOOKUP_RCU)
>                 return -ECHILD;
>
> -       parent = dget_parent(dentry);
> -       sdp = GFS2_SB(d_inode(parent));
> -       dip = GFS2_I(d_inode(parent));
>         inode = d_inode(dentry);
>
>         if (inode) {
>                 if (is_bad_inode(inode))
> -                       goto out;
> +                       return 0;
>                 ip = GFS2_I(inode);
>         }
>
> -       if (sdp->sd_lockstruct.ls_ops->lm_mount == NULL) {
> -               valid = 1;
> -               goto out;
> -       }
> +       if (sdp->sd_lockstruct.ls_ops->lm_mount == NULL)
> +               return 1;
>
>         had_lock = (gfs2_glock_is_locked_by_me(dip->i_gl) != NULL);
>         if (!had_lock) {
>                 error = gfs2_glock_nq_init(dip->i_gl, LM_ST_SHARED, 0, &d_gh);
>                 if (error)
> -                       goto out;
> +                       return 0;
>         }
>
> -       error = gfs2_dir_check(d_inode(parent), &dentry->d_name, ip);
> +       error = gfs2_dir_check(dir, name, ip);
>         valid = inode ? !error : (error == -ENOENT);
>
>         if (!had_lock)
>                 gfs2_glock_dq_uninit(&d_gh);
> -out:
> -       dput(parent);
>         return valid;
>  }
>
> --
> 2.39.5

Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>

Thanks,
Andreas


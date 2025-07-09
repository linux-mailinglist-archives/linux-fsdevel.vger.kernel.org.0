Return-Path: <linux-fsdevel+bounces-54381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6591AFF047
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 19:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E2675C0B3C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 17:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0502248AC;
	Wed,  9 Jul 2025 17:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hedkkGGU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305B24A32
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Jul 2025 17:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752083744; cv=none; b=mkWD4s3hw8V2ir5fSaLXe+6wOiO6QDbE814rW3FVGpcAt9W2UGETgP4rCsQMY2RR5UplfIoZE8dxOwGT1bnwKdHbtcGRS5lqO6oD8LBDjL+2zpwRENGidav0AgQZUB0qh9CMM6K2coEVhZJ8GPad9pnO/MV0iZyTUqk39FiXSkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752083744; c=relaxed/simple;
	bh=ZTjMao/B1MIJvt0ACMQlhpX0mK5NgL+G7vwrOlXVNrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j8Ltz85OeqDtuICWQOvt/BZVi5ZEOAdcHZOpsRSLlktayf4RgVUbpKya467brM521nAdxcL5SUzOQa0Y//zoGI9vDf+9OzAaQSA8quXtX8r+/m2Rc0pnIMcTAAWtlnayXcf5dTBFnQQx2XdPfsYzLBkb+3VvaYIpsSgRD/miGes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hedkkGGU; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4a9e7c12decso2023351cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Jul 2025 10:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752083742; x=1752688542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHGVr/hPb2ZentKYG7i/GTy+Gkc+AO73iWzbyS7DjLg=;
        b=hedkkGGUajJkDxrxO460ysa49tAGwM+Kq1IYe1rWdaOuSLlR3eWniu0bGhpYZUV8vE
         pMqvAjXPxybQliTMtg3KXm8sW+BWoHssFxgq+6Mp21QljXiQkduHjfrzZB2fgnrrhMSo
         y04+lawFgBnauND5iijX//6Rgee1R3t4yxtxZTvKqB6GRX3crQgGpfmE2/P6FuIzDX0V
         FlgBtDBDGM9KfqabCmlD/4WJs9OzVPgDbB2Fjz5sQBTpHuuhEI3s5MQCUeLgu3UNmbdV
         zfqWBsF5PwopXx2qFMhfbx1oazzVNB1SsCk1GnKmnbVl8n6ZFt3PK/DcaOw6Hu1KbvLq
         DqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752083742; x=1752688542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nHGVr/hPb2ZentKYG7i/GTy+Gkc+AO73iWzbyS7DjLg=;
        b=gEybHJEX2EHoqvQsUFpvTQ0PYZdWGZqTEmDy4y8knZ/Zd8cos1NhcAKisUbHH5Zzol
         CTc9SRzfdiLAbO0wyDnkYfibtghUDndwYDQcVYyEsMEAlhS7uld9h7T7h6vII5sbem5J
         U9mY9QacIqeS5XsSNJkAE2sCupEznmkU+KdJVZPFqFViqOAzfVwGXFF5xqnF7NLkb43O
         JaOm1KAKP8IQiWuM467dzuHZvwQREw7Gr5vY/TFyqGiL2boPcGC0xVzMA8RojfsIrCck
         mQXTcaWTRjsAZQRTjYto3B5iF2+n2QlBnykwuWwXO43xF6LNVTRN9wxiYLIuD763++WW
         F3YA==
X-Forwarded-Encrypted: i=1; AJvYcCUeHL0ygSnxUzZS/4IiXplHolnQCSGwB8WDczSwlCUDxiSaGQLdQOoE3Syy0FK++swb057YbUCV81QlNJD9@vger.kernel.org
X-Gm-Message-State: AOJu0YxzXrdWVOZ/F6N/XmF23qBtfihXfHY9BbvHtowLEhi3y7l4aF5o
	3XQcWSRgQnGJxUKohFlPK2ORF8mHO4YH+INo3NoE4t3+9t7mm/KAzJhVPVgGstalp+hh+clxku4
	9wWeU+Jz4mIcTPSmeV6oOXR5OIrM0zdymAfqS
X-Gm-Gg: ASbGnctotvlSsj2UoN+rYaQgLV/UbxFi/sUuHWw57vRPuekHyLWMgMhbBrfErUPQqfJ
	HDLN9m9OXer3KioW/jY+l0wV5AycW7Whd9r/jFBlvRYWbT0tCU1spVsg7zDROJ/BghT5juhaPTE
	QtlMnRU0fvcj1Otvkvm4cvgDBu38JBz59TS0q08xkwfCg=
X-Google-Smtp-Source: AGHT+IF3+7k2XqGybl0JzFsI1pfNP60nSLCOWwIhG08LKBED1q7esegMCtbCIloGinT8XKWs/URn8Y4zrZZfWnDOvLw=
X-Received: by 2002:a05:622a:2c9:b0:4a1:3c6c:cda2 with SMTP id
 d75a77b69052e-4a9dec1f6camr49455761cf.1.1752083741792; Wed, 09 Jul 2025
 10:55:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709020229.1425257-1-leo.lilong@huaweicloud.com> <b33a4493-1b77-42b5-aac9-b0af0833a131@bsbernd.com>
In-Reply-To: <b33a4493-1b77-42b5-aac9-b0af0833a131@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 9 Jul 2025 10:55:31 -0700
X-Gm-Features: Ac12FXw335fy_GszrNQqhd2M9LfOu_ApqJ-3LfUrw6__fLb6BVekIB1fL-rGZsw
Message-ID: <CAJnrk1a+a37BEj_RUASLok7dHyu4nBt7x=bFWA7M3XpCqtUxNA@mail.gmail.com>
Subject: Re: [PATCH] fuse: show io_uring mount option in /proc/mounts
To: Bernd Schubert <bernd@bsbernd.com>
Cc: leo.lilong@huaweicloud.com, miklos@szeredi.hu, leo.lilong@huawei.com, 
	linux-fsdevel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com, 
	lonuxli.64@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 4:24=E2=80=AFAM Bernd Schubert <bernd@bsbernd.com> w=
rote:
>
> On 7/9/25 04:02, leo.lilong@huaweicloud.com wrote:
> > From: Long Li <leo.lilong@huawei.com>
> >
> > When mounting a FUSE filesystem with io_uring option and using io_uring
> > for communication, this option was not shown in /proc/mounts or mount
> > command output. This made it difficult for users to verify whether
> > io_uring was being used for communication in their FUSE mounts.
> >
> > Add io_uring to the list of mount options displayed in fuse_show_option=
s()
> > when the fuse-over-io_uring feature is enabled and being used.
> >
> > Signed-off-by: Long Li <leo.lilong@huawei.com>
> > ---
> >  fs/fuse/inode.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index ecb869e895ab..a6a8cd84fdde 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -913,6 +913,8 @@ static int fuse_show_options(struct seq_file *m, st=
ruct dentry *root)
> >                       seq_puts(m, ",default_permissions");
> >               if (fc->allow_other)
> >                       seq_puts(m, ",allow_other");
> > +             if (fc->io_uring)
> > +                     seq_puts(m, ",io_uring");
> >               if (fc->max_read !=3D ~0)
> >                       seq_printf(m, ",max_read=3D%u", fc->max_read);
> >               if (sb->s_bdev && sb->s_blocksize !=3D FUSE_DEFAULT_BLKSI=
ZE)
>
> I agree with you that is impossible to see, but issue is that io_uring
> is not a mount option. Maybe we should add a sysfs file?
>

Libfuse knows so what about just relaying that information from libfuse?


Thanks,
Joanne

> Thanks,
> Bernd
>


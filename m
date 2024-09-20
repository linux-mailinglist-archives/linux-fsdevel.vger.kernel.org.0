Return-Path: <linux-fsdevel+bounces-29766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C36597D82F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 18:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352B91C228CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 16:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BD617E900;
	Fri, 20 Sep 2024 16:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nj64M9N3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CEC14900E;
	Fri, 20 Sep 2024 16:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726849035; cv=none; b=bdShM1NlAHQMXayx3VBjx3CqwmHu5dxnQsxm6Qf/2watr7QMJZTDf7NtNBndVogefIxnDg2Tzrd/ubrWL6foAMlgtvAAxTDHpATQ4VKIunJn3Q3fVQwQckq1lJEdR4tPHKFeV6oeqhHql3fSIfrWcE1rTP+O/Fea4hspQhEYaIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726849035; c=relaxed/simple;
	bh=HuuF0HTQ6WFY+mXiK4pXlbFhB5BaCKiY2zhgmUaNu9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nVCUQAQzPryOZ4d1Xp68fqMY+DwihZAWFnFSPF0sgmoNDATZU5xbP0eXApEKaGxgTNoCq0wgaIy29d1YrbYxmvRURkBaha8RlQQ4T6wJvQnYbM0HssqN/dkZ4A9Mul+oMtT7gCCe5RMEt+b2+PDx+CwemfRAYMXh6c5BKqJiLxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nj64M9N3; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f74e468baeso25709731fa.2;
        Fri, 20 Sep 2024 09:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726849032; x=1727453832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yus/AQyI3rsCXQIWU3lsDABmOqGllelGHD+9XPDtl5E=;
        b=Nj64M9N3Z8dhcU56U7nQkJQy3kHeowv/X9ouXOMatXyM1sQmFwJsbTgXRJlV0YA7sd
         3QsDek2bIVqk1yYUMLq+1EhFBeEQo95nL/5S5rDc3d+kWQLAAbC99nNZhi31t/5ARlqg
         3w5ZVx7RNwi7zkSEzNkxm+O7kPQY8cMLF+jIdin0fLvfI9DuSHtWdRP6lim+JF48X6aM
         BplcsyimKAChC0tQFMYxIYBMux7bJ/RJxXvzqzbItEP9LGnBEMlCh0U7qp0VWeXmtU+x
         1cGOjsbivnV6qVKowMA5DLPKi8wJ9CYSXZ3LakszMkHBuLzAq/+VlSTvo4WnyYIA+cZs
         K4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726849032; x=1727453832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yus/AQyI3rsCXQIWU3lsDABmOqGllelGHD+9XPDtl5E=;
        b=aB0K3yNz9CpDGLqVoceyNnGuWuYgCpx4PQHL6aaIYRPlRwxsfl1T0y+Y9cmBZ9vjP/
         15h4wT+vAOAgApAHMJqq29yi7vckEnwNxAPLCHeBOB1nuh8q5vZVCKGb5SjAzfpQVvMQ
         NV+PICe9txXxdioIBu05Tcc/MqrV/UoCvCoI5ZvEeYw+nCSo2GSeJpCuFJ7H5KgraLVK
         +/BGEtYauVA6RNiuo/mytfGAkNTlWR4JonG3eTtqd0pTWcExlNM4sKh1VdkTDEYH6+Sa
         zc9DgditwEQqKTi6tU5X+RRbDPBtqAzr/oTbOBhDOah1m/n3Ym1BpK6NgMzHyZ34l6ce
         2czw==
X-Forwarded-Encrypted: i=1; AJvYcCWrYVmm9iVZdxkUf7IYvyLcMjJt6vK5NIT/tEz9BSLPysIl5vx6lPFor/gab6BWs4cz+6jyv1eR@vger.kernel.org, AJvYcCXZcE+6M3JKzN/sqGZv36XYu50lcbMBthGD9e0mfPP++ln3J52q+2TdT5HDPNBbTfjuEupGx2q6zzg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq8JawW6LPt/S6vDTaRtkug4EzME0VteLPHvU4Wv5LRTcJhBZE
	k6dKxZRTqAUNiN2ZWQ8Dv72yk7yaelbcIlDIzJ7asbyxTj+NIsTPe3NH05yZT2BrRr5jZf37Cqc
	9trgqX6JMyhvdpzz/fHiMnHIhhjY=
X-Google-Smtp-Source: AGHT+IHo9BDi/pflKc3O3aaWxueD/163MygMaTuY1VPxsuWcW3rm/uyqrSfTPlmBoWGONGKWDf8+AHlcmIp3wpBErq0=
X-Received: by 2002:a05:651c:150b:b0:2f1:929b:af03 with SMTP id
 38308e7fff4ca-2f7cb329399mr23628841fa.30.1726849031286; Fri, 20 Sep 2024
 09:17:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240920122621.215397-1-sunjunchao2870@gmail.com> <Zu2FWuonuO97Q6V8@infradead.org>
In-Reply-To: <Zu2FWuonuO97Q6V8@infradead.org>
From: Julian Sun <sunjunchao2870@gmail.com>
Date: Sat, 21 Sep 2024 00:17:00 +0800
Message-ID: <CAHB1NagASLvnGiwB1kQwG4qEn+U_2SNxMfG+wnZ9C29d-Ov6Sg@mail.gmail.com>
Subject: Re: [PATCH 1/3] xfs: Do not unshare ranges beyond EOF
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	chandan.babu@oracle.com, djwong@kernel.org, stable@vger.kernel.org, 
	syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com, 
	Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christoph Hellwig <hch@infradead.org> =E4=BA=8E2024=E5=B9=B49=E6=9C=8820=E6=
=97=A5=E5=91=A8=E4=BA=94 22:23=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Sep 20, 2024 at 08:26:21PM +0800, Julian Sun wrote:
> > Attempting to unshare extents beyond EOF will trigger
> > the need zeroing case, which in turn triggers a warning.
> > Therefore, let's skip the unshare process if extents are
> > beyond EOF.
> >
> > Reported-and-tested-by: syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotma=
il.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D296b1c84b9cbf306e5a0
> > Fixes: 32a38a499104 ("iomap: use write_begin to read pages to unshare")
> > Inspired-by: Dave Chinner <david@fromorbit.com>
> > Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
> > ---
> >  fs/xfs/xfs_reflink.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
> > index 6fde6ec8092f..65509ff6aba0 100644
> > --- a/fs/xfs/xfs_reflink.c
> > +++ b/fs/xfs/xfs_reflink.c
> > @@ -3,6 +3,7 @@
> >   * Copyright (C) 2016 Oracle.  All Rights Reserved.
> >   * Author: Darrick J. Wong <darrick.wong@oracle.com>
> >   */
> > +#include "linux/fs.h"
>
> This really should not be needed (and is the wrong way to include
> non-local headers anyway).

Yes, it was added automatically by vscode... I will recheck the patch
before sending it.
>
> >  #include "xfs.h"
> >  #include "xfs_fs.h"
> >  #include "xfs_shared.h"
> > @@ -1669,6 +1670,9 @@ xfs_reflink_unshare(
> >
> >       if (!xfs_is_reflink_inode(ip))
> >               return 0;
> > +     /* don't try to unshare any ranges beyond EOF. */
> > +     if (offset + len > i_size_read(inode))
> > +             len =3D i_size_read(inode) - offset;
>
> So i_size is a byte granularity value, but later on iomap_file_unshare
> operates on blocks.  If you reduce the value like this here this means
> we can't ever unshare the last block of a file if the file size is
> not block aligned, which feels odd.

Got it, will fix it in patch v2. Thanks for your review and explantion.
>

Thanks,
--=20
Julian Sun <sunjunchao2870@gmail.com>


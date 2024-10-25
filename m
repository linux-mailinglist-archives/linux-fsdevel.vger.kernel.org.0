Return-Path: <linux-fsdevel+bounces-32857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C349AFB9B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 09:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4766D1C22766
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 07:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214BE1C07E4;
	Fri, 25 Oct 2024 07:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2Kfesot"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E4A1C07F9
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 07:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729842935; cv=none; b=fuLSclGI1m71hCY0VO+FmIEqSvn6j3MO8gRthxHNH5FsXzVSL8ZOeOWaQz3zP2z7DewT6FEJFDwClFF/snjHrBTzSmPprxddFISaW1cWutKuDACuuKLOPf0J3iifeRz8B2LnbqeeejpNh5qDlOB6/e0h2q3diK4PkAKsiVubkBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729842935; c=relaxed/simple;
	bh=9eS+0I8psvffJEuYPYXWSUVgmstg2vvCc+Pd0iOj7Xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MSF5vAWEftZh0jTtiSoqd/BkbFWOZ1B5B0VSV10FpBwGNq7G0xuXYGbslj/0/DQWQLrOe1I74Zwv331bVlMMSibOKYV4a28X7aZKUR/yjhfgeTBAUcZsy0km5lmu6WHUhgo8k8NByw8WhD84rUeJ3PLwMzK9neoorcDnzbJIvd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2Kfesot; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b157c9ad12so114677285a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 00:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729842932; x=1730447732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70RXRbvzOR3EKSjUE905ZVrPOTiMWfL7BfF2flc1F/Q=;
        b=g2Kfesot2RIN1N4Lr53g2T5bNRUWIJoYULkkKPK1Okbeb8QWQkNpGanyCpox2qjnCM
         wq1cyGmfzwTQrOODFheHGjHnI16AKS0wN7RItvCigrbD+rlJEAbhP+bIf96hhn1oAmcf
         GaKwkqHl8P7JF60TdSb+N1gbjwNeiBGcatvJrNfZ4xTnQ4rQJou1hoQHHCwf5OPDB76n
         Jk5b+Nf9Ql+ZuS/uQHAme612XdaQ4Ckb2/8sUMvXMN4AHt8ftn1arlxwwMj+RtnBxTQ2
         jLecS77l6yk7dHOIbOeqUIneQZs9jkjm56TcqW9vkkk3xxUTwjQxribGGWSB4RV9Ke4u
         rIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729842932; x=1730447732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=70RXRbvzOR3EKSjUE905ZVrPOTiMWfL7BfF2flc1F/Q=;
        b=AgfHxhiLfQtTMwknfZBloKFJVhJ+vhY3fatxJsnob4GV5gLG3dXGMA34gPIweAne8x
         oVfcrdV7Xygp4UEwphO15FooEiKoKpNMv35J+YuYD7lpBJMRfuwAoNQXyYa3kZeScRA6
         0NIw5IknWivONhyUk++vSRyE/M0AGO73XUaphhilopExBeL/TtMqqBJ6qjQcXr+kfVsm
         hjfNnzv+kkob/yOO1IqEVgwZAgCPC+SE9ZupUdU1rdjx2ZbQ3BTwgSS/UlZE88z1H3KB
         UTDnMmEzCWXL5naJjRNO/cZeuK/6pc/eFIZ0QPCjPk57+M7bFT7cIq/n1DZRlHLguRkH
         7ueg==
X-Forwarded-Encrypted: i=1; AJvYcCUoAp+FPjczfphBga/gGtl1qYNdknonl5JhDUWDp0cA12INJGRZbET0DtdQs7RtCfGFR1G/Z2VcCsekAaop@vger.kernel.org
X-Gm-Message-State: AOJu0YzMKhIRUztjlff0ePJ1RhSSvU938DZjHrv4rPW4kAjt6uu95P7w
	jRYfABx4lOhkKuocE73wex0X8mFh07hAEFFnOr7noL9tLCDQ5lNCh56hXtpktGFyyddcQGTGI+M
	CR0h6S+kP7Tg8ybSkD3ZuFD0O9qY=
X-Google-Smtp-Source: AGHT+IExP6XR1UscjTIVMjnmlBBiocSAR3BodH6y5LD6T1oPo2Js7FpDcz3yljtNzYvw+YR3PO84nCYeTMW0xYIPgH8=
X-Received: by 2002:ac8:5a4b:0:b0:45d:56e4:1ffc with SMTP id
 d75a77b69052e-4612594979fmr55523441cf.51.1729842932251; Fri, 25 Oct 2024
 00:55:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1721931241.git.josef@toxicpanda.com> <a6010470b2d11f186cba89b9521940716fa66f3b.1721931241.git.josef@toxicpanda.com>
 <20240801163134.4rj7ogd5kthsnsps@quack3> <CAOQ4uxg83erL-Esw4qf6+p+gBTDspBRWcFyMM_0HC1oVCAzf4Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxg83erL-Esw4qf6+p+gBTDspBRWcFyMM_0HC1oVCAzf4Q@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 25 Oct 2024 09:55:21 +0200
Message-ID: <CAOQ4uxi6YR1ryiU34UtkSpe64jVaBBi3146e=oVuBvxsSMiCCA@mail.gmail.com>
Subject: Re: [PATCH 02/10] fsnotify: introduce pre-content permission event
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 3, 2024 at 6:52=E2=80=AFPM Amir Goldstein <amir73il@gmail.com> =
wrote:
>
> On Thu, Aug 1, 2024 at 6:31=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 25-07-24 14:19:39, Josef Bacik wrote:
> > > From: Amir Goldstein <amir73il@gmail.com>
> > >
> > > The new FS_PRE_ACCESS permission event is similar to FS_ACCESS_PERM,
> > > but it meant for a different use case of filling file content before
> > > access to a file range, so it has slightly different semantics.
> > >
> > > Generate FS_PRE_ACCESS/FS_ACCESS_PERM as two seperate events, same as
> > > we did for FS_OPEN_PERM/FS_OPEN_EXEC_PERM.
> > >
> > > FS_PRE_MODIFY is a new permission event, with similar semantics as
> > > FS_PRE_ACCESS, which is called before a file is modified.
> > >
> > > FS_ACCESS_PERM is reported also on blockdev and pipes, but the new
> > > pre-content events are only reported for regular files and dirs.
> > >
> > > The pre-content events are meant to be used by hierarchical storage
> > > managers that want to fill the content of files on first access.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >
> > The patch looks good. Just out of curiosity:
> >
> > > diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotif=
y_backend.h
> > > index 8be029bc50b1..21e72b837ec5 100644
> > > --- a/include/linux/fsnotify_backend.h
> > > +++ b/include/linux/fsnotify_backend.h
> > > @@ -56,6 +56,9 @@
> > >  #define FS_ACCESS_PERM               0x00020000      /* access event=
 in a permissions hook */
> > >  #define FS_OPEN_EXEC_PERM    0x00040000      /* open/exec event in a=
 permission hook */
> > >
> > > +#define FS_PRE_ACCESS                0x00100000      /* Pre-content =
access hook */
> > > +#define FS_PRE_MODIFY                0x00200000      /* Pre-content =
modify hook */
> >
> > Why is a hole left here in the flag space?
>
> Can't remember.
>
> Currently we have a draft design for two more events
> FS_PATH_ACCESS, FS_PATH_MODIFY
> https://github.com/amir73il/man-pages/commits/fan_pre_path
>
> So might have been a desire to keep the pre-events group on the nibble.

Funny story.

I straced a program with latest FS_PRE_ACCESS (0x00080000) and
see what I got:

fanotify_mark(3, FAN_MARK_ADD|FAN_MARK_MOUNT,
FAN_CLOSE_WRITE|FAN_OPEN_PERM|FAN_ACCESS_PERM|FAN_DIR_MODIFY|FAN_ONDIR,
AT_FDCWD, "/vdd") =3D 0

"FAN_DIR_MODIFY"! a blast from the past [1]

It would have been nice if we reserved 0x00080000 for FAN_PATH_MODIFY [2]
to be a bit less confusing for users with old strace.

WDYT?

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20200612093343.5669-18-amir73il@g=
mail.com/
[2] https://github.com/amir73il/man-pages/commits/fan_pre_path


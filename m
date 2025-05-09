Return-Path: <linux-fsdevel+bounces-48547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EE2AB0E65
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 11:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC6B41C23A54
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 09:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B002274FF2;
	Fri,  9 May 2025 09:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiEFRVrW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECA373477;
	Fri,  9 May 2025 09:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746782055; cv=none; b=nm2iFZBzPapEpejsshRlt6EHr/u3Hr+xVnaAemc+5fBYl/JNSrT/vO1IRmsA5WEdB6LysKbmzgMzugO3rCYcp5qnDvFjBElPeDLIo3EV8skGYR5HrqGNZpgGRzL+HTw/HzX8GHBIxF4GMAqMk9/ZPnd20vDk2iGCIx46w2JBPcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746782055; c=relaxed/simple;
	bh=vItGlJMuzbxOXtTTMJsjkJgBtkKmyb4sB1UNIvljBeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MZOZWLrlYcUvxlzRAADsidzDYRjvaAgvueop4kUm+ba6EonFwDxJMjporUFQVpIAQFlEYgcv5XzuHS+XbQhxB/YeTAPy/3K9I4s5Mh/+g5abRwblsPy8LCdgm6iKCCtFd5DYGNhyPtTFLuanm9cNW60NXN0oHsthUB94k9KSuh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aiEFRVrW; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e5e0caa151so3417986a12.0;
        Fri, 09 May 2025 02:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746782052; x=1747386852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhO0hsCpCTctc/RhbxA8mBatB8tQsLopxXqBz5ibW5U=;
        b=aiEFRVrWezfAnJphKVwc4oNrmx2dmK9wd/NWSX6VE2SR6SX256niI8cgCC3V0Sa3EM
         h8cmVOD/8STLarZ4wDnKGH19Ftba0Yl7ZcwpOBbDdjUFvrwtNW8RSyPttwSCYgPKUU56
         y9dC4r+VH0sPsAsD7pfcIFdzrHTA9jWr9RSfwzY86tAKcWbyLJ1/NwE/h+mIPxLnerwP
         dYUkI6wBgDUUKCN3eH6V5ZlvVeXOXtZq77UOpWbUVZeE2UQdfZXLddt5KISO/O1GD1Mt
         PiIyFhOsOr+06Co5TWhnExzAswE/fxrg0wrsmlXHsoRccFcDYpxlzP8T6RSdD0XEGTOD
         VtHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746782052; x=1747386852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fhO0hsCpCTctc/RhbxA8mBatB8tQsLopxXqBz5ibW5U=;
        b=cU244V7LaqXPFOgUJtBvtdYF5A/mJwO1u+V+LRnnnvHB6Ns6M165osefvkSI8AxOu2
         MNrtBcOm1yfrVYjrAY2k74YBOaZemSXferYK57Yrv5OLhMqVyS9Tv+RdoTIa7lTTAQFy
         NdEcJSb58UDMtXaAFRSajpbN1g1NESLzGdV7Bt9H6o6XOyeAPImW+XFLsbjI3qoDRrc+
         UHIwtVLO/pQr1qrkDNglsa2kENjyBu06gWiVM2dB2Ao3U7aIB7R15cmovYo+kDTAUPVY
         sCFUakEHRJnRycJNce1Pf5oREmjOGRStGb9sfb/QtnN9Z7O6Gcd5h0+Ks8H4Fgsrf8BT
         Z3eQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/r1ys8RP8dUmFVzlfNNsOlBFEwKC1inxvVkl+gL31D1TJv8RbcKIXa3Juwa1q4ktVr/7pRKOnXPbK979p@vger.kernel.org, AJvYcCXPepLjniQ8uTobVgA1X3whHZtNhmH9e/t/5hBJEArJq+USzpVvV+//7np8uMJsb4LTPUu2ak+x+A+hxeJe@vger.kernel.org
X-Gm-Message-State: AOJu0YyFT0JPeoqwy5y9B2tUtv0G6krostQ6KbQsgqJtghdHIkGxklcI
	NxeTXL5hLZfqwBUoZOb512y3yYgr4w4AyAv4rUqB43bny4sDUJap+5xtyuCgwSssOgZZgUAyDR+
	wXVacJQAY/BvylXs8e7YWufxkrPA=
X-Gm-Gg: ASbGncsX/Vl0NmwyvsfEXwa4JcS7HHje9RNyasxPwJeWrfWL6HuRSeTNLaldLhgUw6H
	WRnpMKCzGcK24UMjhBr6EMsOysNP64LFszEYIBSY/Q+a0CB9+/9isdZcDTYfIblJITXAAQ3jAHR
	c2ik4MbFAF+iaopriQAG1JQg==
X-Google-Smtp-Source: AGHT+IEVbDuDWTg+KNmf0HXjPEqDqTURkxFsPGThz0tbkN8+U9Hl7RtJUiTPZCOnSqF7ZOlEXdgCzgBUS6IW29pI/JE=
X-Received: by 2002:a17:907:940f:b0:acb:107c:7aed with SMTP id
 a640c23a62f3a-ad219291ef8mr278897066b.55.1746782051711; Fri, 09 May 2025
 02:14:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509-fusectl-backing-files-v3-0-393761f9b683@uniontech.com>
 <20250509-fusectl-backing-files-v3-2-393761f9b683@uniontech.com> <CAC1kPDM5cN9p-Ri1WUEWt6JNiTZukekJyihYRT=qTwawVT3bFA@mail.gmail.com>
In-Reply-To: <CAC1kPDM5cN9p-Ri1WUEWt6JNiTZukekJyihYRT=qTwawVT3bFA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 9 May 2025 11:14:00 +0200
X-Gm-Features: AX0GCFsZkfwnPNQXlghJCMRfEEC4aqhJqH0caqzt3Q4NG2pzyaumtwa_HZiA0XI
Message-ID: <CAOQ4uxhQu+Gr8Sn5HbZRyOhDd3MBqN5xKFxZru39LGgk5K-ACw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] fs: fuse: add backing_files control file
To: Chen Linxuan <chenlinxuan@uniontech.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 9:39=E2=80=AFAM Chen Linxuan <chenlinxuan@uniontech.=
com> wrote:
>
> On Fri, May 9, 2025 at 2:34=E2=80=AFPM Chen Linxuan via B4 Relay
> <devnull+chenlinxuan.uniontech.com@kernel.org> wrote:
> >
> > From: Chen Linxuan <chenlinxuan@uniontech.com>
> >
> > Add a new FUSE control file "/sys/fs/fuse/connections/*/backing_files"
> > that exposes the paths of all backing files currently being used in
> > FUSE mount points. This is particularly valuable for tracking and
> > debugging files used in FUSE passthrough mode.
> >
> > This approach is similar to how fixed files in io_uring expose their
> > status through fdinfo, providing administrators with visibility into
> > backing file usage. By making backing files visible through the FUSE
> > control filesystem, administrators can monitor which files are being
> > used for passthrough operations and can force-close them if needed by
> > aborting the connection.
> >
> > This exposure of backing files information is an important step towards
> > potentially relaxing CAP_SYS_ADMIN requirements for certain passthrough
> > operations in the future, allowing for better security analysis of
> > passthrough usage patterns.
> >
> > The control file is implemented using the seq_file interface for
> > efficient handling of potentially large numbers of backing files.
> > Access permissions are set to read-only (0400) as this is an
> > informational interface.
> >
> > FUSE_CTL_NUM_DENTRIES has been increased from 5 to 6 to accommodate the
> > additional control file.
> >
> > Some related discussions can be found at links below.
> >
> > Link: https://lore.kernel.org/all/4b64a41c-6167-4c02-8bae-3021270ca519@=
fastmail.fm/T/#mc73e04df56b8830b1d7b06b5d9f22e594fba423e
> > Link: https://lore.kernel.org/linux-fsdevel/CAOQ4uxhAY1m7ubJ3p-A3rSufw_=
53WuDRMT1Zqe_OC0bP_Fb3Zw@mail.gmail.com/
> > Cc: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
> > ---
> >  fs/fuse/control.c | 155 ++++++++++++++++++++++++++++++++++++++++++++++=
+++-----
> >  fs/fuse/fuse_i.h  |   2 +-
> >  2 files changed, 144 insertions(+), 13 deletions(-)
> >
> > diff --git a/fs/fuse/control.c b/fs/fuse/control.c
> > index f0874403b1f7c91571f38e4ae9f8cebe259f7dd1..6333fffec85bd562dc9e86b=
a7cbf88b8bc2d68ce 100644
> > --- a/fs/fuse/control.c
> > +++ b/fs/fuse/control.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/init.h>
> >  #include <linux/module.h>
> >  #include <linux/fs_context.h>
> > +#include <linux/seq_file.h>
> >
> >  #define FUSE_CTL_SUPER_MAGIC 0x65735543
> >
> > @@ -180,6 +181,135 @@ static ssize_t fuse_conn_congestion_threshold_wri=
te(struct file *file,
> >         return ret;
> >  }
> >
> > +struct fuse_backing_files_seq_state {
> > +       struct fuse_conn *fc;
> > +       int backing_id;
> > +};
>
> As mentioned in the previous v2 related discussion
> backing_id is maintained in state because
> show() of seq_file doesn't accept the pos parameter.
> But actually we can get the pos in the show() function
> via the index field of struct seq_file.
> The softnet_seq_show() function in net-procfs.c are doing this.
> I'm not really sure if it would be better to implement it this way.
>

For better clarity of the code and maintainability,
I think that storing backing_id in the state as you did is better.

> > +
> > +static void fuse_backing_files_seq_state_free(struct fuse_backing_file=
s_seq_state *state)
> > +{
> > +       fuse_conn_put(state->fc);
> > +       kvfree(state);
> > +}
> > +
> > +static void *fuse_backing_files_seq_start(struct seq_file *seq, loff_t=
 *pos)
> > +{
> > +       struct fuse_backing *fb;
> > +       struct fuse_backing_files_seq_state *state;
> > +       struct fuse_conn *fc;
> > +       int backing_id;
> > +       void *ret;
> > +
> > +       fc =3D fuse_ctl_file_conn_get(seq->file);
>
> I'm not sure if I should get fc in fuse_backing_files_seq_start here
> and handle fc as (part of) the seq_file iterator.
> Or should I get the fc in fuse_backing_files_seq_open
> and store the fc in the private field of the seq_file more appropriately.
> I guess the difference isn't that big?

The simpler the better.
I think what you did is fine. I see no reason to change it.

Thanks,
Amir.


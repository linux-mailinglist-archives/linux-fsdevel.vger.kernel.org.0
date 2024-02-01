Return-Path: <linux-fsdevel+bounces-9843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA3F8454FE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 11:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A3BC287258
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 10:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C868815B10F;
	Thu,  1 Feb 2024 10:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ih3n0nHm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A959215AABD
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 10:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706782586; cv=none; b=Z8nFUpgan8I/vbunPEAtGu/Dtb5VReER3gDD8CK3Vaqt2uLr4e/QwCl3Q899eJOleQuNYPOMtq5yElN+cK9+11gyLF0GNg9r9dcmRVranSAS6c6onPflAmd5ujnkumRmYf0ibCCjtX1MMDWj3K63ucEq3h7mWuMq8cZuKZeTZBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706782586; c=relaxed/simple;
	bh=CumFYjPB1AssdThUGsoHzrAaYq+xuSekicr2Ytsxfns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=paDve6mChv4TQs7T6KEVmo9qPW0+MtuL17zhwIRWMx9MJUqOPhbG/BrkS3P8l298e8KHglTGi+/ZM+E9SmUmaAQtLa8rFQlI/bHA/9UTZeCWbtlDm8Od7c89Fs0HVoCcuhjsahgj2ddz+c82A/a29Oa/08abUHmMmyDaEDdAnIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ih3n0nHm; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-783d4b3ad96so49277285a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Feb 2024 02:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706782583; x=1707387383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rj9tV/fypQEGx83DSjJbxmaPc6DJ9/sHFL/ErcWjMq0=;
        b=ih3n0nHmKDlxK5Eh50xCqYdzRxYFnZkEY3gFL5JZ6oRncLQuVlgnvRwa5ssGolWy7z
         qPGbu30qA8RIzX+jsMozMbS4I8eEGZiW+GoM6CjfxMKY3Os0FihMsDye6IRfJh3TfuVZ
         /sR92S53GdB+tJvE3o9xqMYrThKsSwddJJWIjrAtTjdAHzBvcHpZ8F3d3gb5/OwKrTkf
         iB29PzNutnSqINH5+1F3jipqIupiZhdN3yajYXAnxUPDzk4QfdLIMSUrYzGLAHdFwYbG
         FE+QJ7HL+PS9iIYQAI9w+108lIChe9pIVqC/xC7892RpQjLvyDOUd1wyb6Ux4w/G4msH
         nxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706782583; x=1707387383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rj9tV/fypQEGx83DSjJbxmaPc6DJ9/sHFL/ErcWjMq0=;
        b=XdgXc7TWqccqIzs1545EuydNKuxQcYUVok8o5O25xL6lOsxmPMxH1Pn4NQ2WqtqNPG
         GuYzX7v/7vFTMMXdVAa7r+1jnQkH4HBsnCp6+m8pGvhnj3Mh5Dx4bulQJWEHtdl0qBCw
         2L62d9EbiFPMzcDCD0MWzBGt6ckDu/LsMbKF7ZN9VFJgL7irpCb+Q9s9d0ROOulsMlxj
         rLJSNmmixkqnq4SQhLA7aJOS8Lo7EV1gCWBRPRTzcW1rnx2U9CF+ig7yV/sr1ev8pKkl
         Iv11jM2vVItfi9BJawDlQeQryLbZrE0g/GsHmRZca6ysGQGOLF6V+dIcHJKmzwb0DUnM
         wnjA==
X-Gm-Message-State: AOJu0Ywfe7VVA1YsAlzxriumdi4OFf77qntFAt4asT8lFciWo6WAP4Kf
	3W31G+bSyAjgtvKlGKGDLGfkin/1LXNtWFx+52nKpdwh/NV8zfh3yT17tJuONTDyaoQXrkEwtIV
	qGenfK07StaN4VDG75OJGu1ftgKhZsXqU1Dc=
X-Google-Smtp-Source: AGHT+IHsh3QN0wiIEGuMgDUQQseTQImZcTv9mrJ8ZNKcqp4RRbCK87Tc5RasMI1E3YBCGRO0B2j1xFLRagrLrlwWkiA=
X-Received: by 2002:ad4:5ca1:0:b0:686:90c3:374b with SMTP id
 q1-20020ad45ca1000000b0068690c3374bmr5474460qvh.31.1706782583590; Thu, 01 Feb
 2024 02:16:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131230827.207552-1-bschubert@ddn.com> <20240131230827.207552-5-bschubert@ddn.com>
 <CAJfpeguF0ENfGJHYH5Q5o4gMZu96jjB4Ax4Q2+78DEP3jBrxCQ@mail.gmail.com>
In-Reply-To: <CAJfpeguF0ENfGJHYH5Q5o4gMZu96jjB4Ax4Q2+78DEP3jBrxCQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 1 Feb 2024 12:16:12 +0200
Message-ID: <CAOQ4uxgv67njK9CvbUfdqF8WV_cFzrnaHdPB6-qiQuKNEDvvwA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] fuse: prepare for failing open response
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org, dsingh@ddn.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 11:23=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Thu, 1 Feb 2024 at 00:09, Bernd Schubert <bschubert@ddn.com> wrote:
> >
> > From: Amir Goldstein <amir73il@gmail.com>
> >
> > In preparation for inode io modes, a server open response could fail
> > due to conflicting inode io modes.
> >
> > Allow returning an error from fuse_finish_open() and handle the error i=
n
> > the callers. fuse_dir_open() can now call fuse_sync_release(), so handl=
e
> > the isdir case correctly.
>
> While that's true, it may be better to just decouple the dir/regular
> paths completely, since there isn't much sharing anyway and becoming
> even less.
>

I can look into it, but for now the fix to fuse_sync_release() is a simple
one liner, so I would rather limit the changes in this series.

> > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > index d19cbf34c634..d45d4a678351 100644
> > --- a/fs/fuse/dir.c
> > +++ b/fs/fuse/dir.c
> > @@ -692,13 +692,15 @@ static int fuse_create_open(struct inode *dir, st=
ruct dentry *entry,
> >         d_instantiate(entry, inode);
> >         fuse_change_entry_timeout(entry, &outentry);
> >         fuse_dir_changed(dir);
> > -       err =3D finish_open(file, entry, generic_file_open);
> > +       err =3D generic_file_open(inode, file);
> > +       if (!err) {
> > +               file->private_data =3D ff;
> > +               err =3D finish_open(file, entry, fuse_finish_open);
>
> Need to be careful with moving fuse_finish_open() call inside
> finish_open() since various fields will be different.
>
> In particular O_TRUNC in f_flags will not be cleared and in this case
> it looks undesirable.

Why? coming from fuse_open_common(), fuse_finish_open() is
called before clearing O_TRUNC.

Is fuse_finish_open() supposed to be called after clearing O_TRUNC
in fuse_create_open()?

I realize that this is what the code is doing in upstream, but it does not
look correct.

Probably, nobody could notice it, because server would probably have
truncated the file before the CREATE response anyway?

Am I missing something?

Thanks,
Amir.


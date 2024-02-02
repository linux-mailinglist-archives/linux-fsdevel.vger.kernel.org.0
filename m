Return-Path: <linux-fsdevel+bounces-10005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CAF846FBB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 13:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12FF8288F72
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 12:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170F013E22A;
	Fri,  2 Feb 2024 12:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hADevLd8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33D417C60
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 12:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706875439; cv=none; b=ceC1VSooeE2DAUsaw3dGxqZ9Qw1qmYmdZhqe+0pxbpVl5FqnGYBmViNa1wu1WvLuFkD75DpT+J9Uc2tHD9CdIGCtzTx5RS7KV+pgkoEsNhOUpH0uYyXYDnL5f1SAugzc11Znrh6MO0xRZAn+ne/tlX1Pwz07dnM+4PG/PpDVbew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706875439; c=relaxed/simple;
	bh=oRlb8kLrvumbX6tNIlnYx8YiRov44TlV8sDseEhIrCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lz9eGkPUUfNLMBGZz0c29yii9boi7xm4uL9GS5RQk/23poBdeC6D7y+1zxjK8x4/1u83B0VLfIaL4j/hvtQXtBmqWETIufwKGqf7wnA1ZarHImKVYrxbvx2DW/k+3sRq7cBt+W9WajNSFlA6aU4q7ahujWRzch6Eb5fjMDVM/7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hADevLd8; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-214c940145bso1101847fac.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 04:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706875437; x=1707480237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zs6aJUh5jEis10Uo3A13hOMzpnUIaN+M3EX1dIt2Pj8=;
        b=hADevLd8qfLsJuQtCGUYck9PVGNwYmuZ5xJjA/DQjoK3ZreIU703tGXYjxSx2mbQpd
         xwuTzgzWBExKK7gArMiqMKc6JBtHyuxQS4/v4La3ha42AhjSIWcC9KXjbaBuPG4gkQsU
         TjnHy+9SO7agT67+2atfUf9NA36CiO9amL1hNCBUfGuY+iCdeWWLx4/TisgVPHC4x7a3
         IR5XoxZUCSQ1AMhSi00FdCJ5fkaLY5vtFg6rIGPM0XnJwpaVaY5UzrhJ4SiU8FvWseKw
         GNE2JNLu9ac1M6nGfg3fIdt6e6Wv2jn5vKTSp/PPA+QMORSALXHKV7cgaA39JiMz1P0m
         IRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706875437; x=1707480237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zs6aJUh5jEis10Uo3A13hOMzpnUIaN+M3EX1dIt2Pj8=;
        b=GznQ2veUBnVv6cP6PK0XCPeCaLG8ONa37OoniOYUmthDKzZ3XANrBEIArYhTATg3MQ
         6sC9NIO+sMBmUkc6DtFlr7grcXzyD3i4nahKfKq5c5nBiBYId9oP377OB5PmDkjol7Rm
         M2A+kuT/In2uuCD4oH+AHwak+IYGcZ2Z0B/ZIOKKKqfpoIbkkgeB2tWL/1eNI4JYwBk6
         oIpe9RQazwy0RArEd9UoT7DOj6s2BLBxmMHtqrxQTV0eA5iYLQRSK/wFMSpXntFqshL+
         VEJxer8ivS/pueEte1h5E4+4htNv6a09NvwUB++DshF5PeK4ttlBw3eRfm7/zCsHdnUK
         7prQ==
X-Gm-Message-State: AOJu0Yz5G091U+YK0u3NUlpW17qLp/v6nvKtMy4R69CJLwoSZMtUvhWZ
	Jb7SxUrMuim9VZnkqDe0QWVDuh4E8QPBis64yjAlhQeA4JoqJA0Jl9qOw3Ohg8xZHBT7Vyror0k
	zMEnStUf84lHkTlJeMca9K9dB+Bz2AAHIHZs=
X-Google-Smtp-Source: AGHT+IFyRd7qc4l5rq3WowPuOYnCa2IM9NWwK/DmTtoft812trGEKflhQZ8z+pERqnR/lIlfIeHjDEtumEsZNQ84p0Y=
X-Received: by 2002:a05:6871:79a4:b0:218:4be8:3747 with SMTP id
 pb36-20020a05687179a400b002184be83747mr8772931oac.8.1706875436940; Fri, 02
 Feb 2024 04:03:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131230827.207552-1-bschubert@ddn.com> <20240131230827.207552-5-bschubert@ddn.com>
 <CAJfpeguF0ENfGJHYH5Q5o4gMZu96jjB4Ax4Q2+78DEP3jBrxCQ@mail.gmail.com>
 <CAOQ4uxgv67njK9CvbUfdqF8WV_cFzrnaHdPB6-qiQuKNEDvvwA@mail.gmail.com>
 <CAJfpegupKaeLX_-G-DqR0afC1JsT21Akm6TeMK9Ugi6MBh3fMA@mail.gmail.com>
 <CAOQ4uxiXEc-p7JY03RH2hJg7d+R1EtwGdBowTkOuaT9Ps_On8Q@mail.gmail.com>
 <CAJfpegs4hQg93Dariy5hz4bsxiFKoRuLsB5aRO4S6iiu6_DAKw@mail.gmail.com> <CAOQ4uxhNS81=Fry+K6dF45ab==Y4ijpWUkUmvpf2E1hJrkzC3w@mail.gmail.com>
In-Reply-To: <CAOQ4uxhNS81=Fry+K6dF45ab==Y4ijpWUkUmvpf2E1hJrkzC3w@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 2 Feb 2024 14:03:45 +0200
Message-ID: <CAOQ4uxgrgoEZ34Deyg3RYJJM8+XuWVtDB9tzcXCiQvzcba8bhQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] fuse: prepare for failing open response
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org, dsingh@ddn.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 6:46=E2=80=AFPM Amir Goldstein <amir73il@gmail.com> =
wrote:
>
> On Thu, Feb 1, 2024 at 12:51=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu=
> wrote:
> >
> > On Thu, 1 Feb 2024 at 11:41, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > > I was considering splitting fuse_finish_open() to the first part that
> > > can fail and the "finally" part that deals with attributes, but seein=
g
> > > that this entire chunk of atomic_o_trunc code in fuse_finish_open()
> > > is never relevant to atomic_open(), I'd rather just move it out
> > > into fuse_open_common() which has loads of other code related to
> > > atomic_o_trunc anyway?
> >
> > Yep.
>
> FWIW, I pushed some cleanups to:
>
> https://github.com/amir73il/linux/commits/fuse_io_mode-wip/
>
> * e71b0c0356c8 - (github/fuse_io_mode-wip) fuse: introduce inode io modes
> * 081ddd63a9ff - fuse: prepare for failing open response
> * 437b84a47a8a - fuse: allocate ff->release_args only if release is neede=
d
> * e2df18f9a3d6 - fuse: factor out helper fuse_truncate_update_attr()
>
> e2df18f9a3d6 is the O_TRUNC change discussed above.
> 437b84a47a8a gets rid of the isdir argument to fuse_file_put(), so this
> one liner that you disliked is gone.
>
> I will see if I can also get the opendir separation cleanup done.
>

This is what I have in WIP branch - not sure if that is what you meant:

* 285a83f439d8 - (github/fuse_io_mode-wip) fuse: introduce inode io modes
* cf7e1707a319 - fuse: break up fuse_open_common()
* d8fcee9252ca - fuse: prepare for failing open response
* 5e4786da5d6e - fuse: allocate ff->release_args only if release is needed
* 64a6a415239c - fuse: factor out helper fuse_truncate_update_attr()

Thanks,
Amir.

commit cf7e1707a31990ed5df1294047909fce60cc3ec1
Author: Amir Goldstein <amir73il@gmail.com>
Date:   Fri Feb 2 13:30:30 2024 +0200

    fuse: break up fuse_open_common()

    fuse_open_common() has a lot of code relevant only for regular files an=
d
    O_TRUNC in particular.

    Copy the little bit of remaining code into fuse_dir_open() and stop usi=
ng
    this common helper for directory open.

    Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
    Signed-off-by: Amir Goldstein <amir73il@gmail.com>

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 27daf0bf84ad..3498255402fe 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1632,7 +1632,27 @@ static const char *fuse_get_link(struct dentry
*dentry, struct inode *inode,

 static int fuse_dir_open(struct inode *inode, struct file *file)
 {
-       return fuse_open_common(inode, file, true);
+       struct fuse_mount *fm =3D get_fuse_mount(inode);
+       struct fuse_inode *fi =3D get_fuse_inode(inode);
+       int err;
+
+       if (fuse_is_bad(inode))
+               return -EIO;
+
+       err =3D generic_file_open(inode, file);
+       if (err)
+               return err;
+
+       err =3D fuse_do_open(fm, get_node_id(inode), file, true);
+       if (!err) {
+               struct fuse_file *ff =3D file->private_data;
+
+               err =3D fuse_finish_open(inode, file);
+               if (err)
+                       fuse_sync_release(fi, ff, file->f_flags);
+       }
+
+       return err;
 }

 static int fuse_dir_release(struct inode *inode, struct file *file)
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 891bfa8a6724..1d6b3499c069 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -229,7 +229,7 @@ static void fuse_truncate_update_attr(struct inode
*inode, struct file *file)
        fuse_invalidate_attr_mask(inode, FUSE_STATX_MODSIZE);
 }

-int fuse_open_common(struct inode *inode, struct file *file, bool isdir)
+int fuse_open(struct inode *inode, struct file *file)
 {
        struct fuse_mount *fm =3D get_fuse_mount(inode);
        struct fuse_inode *fi =3D get_fuse_inode(inode);
@@ -260,7 +260,7 @@ int fuse_open_common(struct inode *inode, struct
file *file, bool isdir)
        if (is_wb_truncate || dax_truncate)
                fuse_set_nowrite(inode);

-       err =3D fuse_do_open(fm, get_node_id(inode), file, isdir);
+       err =3D fuse_do_open(fm, get_node_id(inode), file, false);
        if (!err) {
                ff =3D file->private_data;
                err =3D fuse_finish_open(inode, file);
@@ -359,11 +359,6 @@ void fuse_release_common(struct file *file, bool isdir=
)
                          (fl_owner_t) file, isdir);
 }

-static int fuse_open(struct inode *inode, struct file *file)
-{
-       return fuse_open_common(inode, file, false);
-}
-
 static int fuse_release(struct inode *inode, struct file *file)
 {
        struct fuse_conn *fc =3D get_fuse_conn(inode);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 536b4515c2c8..9ad5f882bd0a 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1034,8 +1034,6 @@ void fuse_read_args_fill(struct fuse_io_args
*ia, struct file *file, loff_t pos,
 /**
  * Send OPEN or OPENDIR request
  */
-int fuse_open_common(struct inode *inode, struct file *file, bool isdir);
-
 struct fuse_file *fuse_file_alloc(struct fuse_mount *fm, bool release);
 void fuse_file_free(struct fuse_file *ff);
 int fuse_finish_open(struct inode *inode, struct file *file);
--


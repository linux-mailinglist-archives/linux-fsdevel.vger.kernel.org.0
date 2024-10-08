Return-Path: <linux-fsdevel+bounces-31366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2302995804
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 22:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDD7B1C20F53
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 20:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29196213EC3;
	Tue,  8 Oct 2024 20:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bj+ZTwuZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D1138DD6;
	Tue,  8 Oct 2024 20:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728417722; cv=none; b=H4NJsp4YtGptkEk5kPPVwEeMbJytThlaLCufLyzYnxw7xRJc2VVPGshnMH825DRw30fQvdQSb6uZKD2jtZDkRDXjntqNXrjpiVm6zGImSnW459o3m6gYl+YBZHAO554UMCBOfM8L5mDxmHHAhK6vfV+eqOwfyTHXLO9OtAa5TGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728417722; c=relaxed/simple;
	bh=WGd9g5a26LnA2sQFvVRyax6rWLhj6mUJ4IYmz4nZwUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lSipNTqUn9/wNnE37dQCDHG+eJsUCnu/8jqMNX4vY9RiRiafUUYOCNS/ADRAns/oVz4svI0AEKA2PPEWjDyrWakvEDadfq00kPyPD3I0pcTHjp2Y0pk8tvELalqd16r7LOJNsg/RigZpQp18vxBtATyNxF/+GxQfK+U7P32I0F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bj+ZTwuZ; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a9ad15d11bso518768285a.0;
        Tue, 08 Oct 2024 13:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728417720; x=1729022520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xmMg7QRuIBmG8ezE4DD8gRmptC8Dq/dfgG2iyJ86Ag=;
        b=Bj+ZTwuZoaS/CWKU3CRLXlFrfIWUuZNYDGEzx63EPs57uTb0vtOfFw9etef3IK+x2e
         FhoXXinEseNHp+dvkeBstgeYZv48jHbflNmFS982Ikjqld6acVHrtLLZ99cgo8l2JSMY
         UOwq7Ksusi05qHHG1Eu49izRB+1rlqhuE6YHx5CjcA53KFjxDzn4l4PEJQCL9nHtJnv1
         e7KH2L0vkMHgUFbqXOHBewgKhdT7vAia1t4UGhT8euahM5KswQRlVWI+S5mUoOk9PO4d
         7fPfMPttFqW+nNbLUUN7jZq8MqYLSsuFXDhKC+CHSj+Nmj0bXT7yXUCCsOUDvmCi9dxg
         Omag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728417720; x=1729022520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xmMg7QRuIBmG8ezE4DD8gRmptC8Dq/dfgG2iyJ86Ag=;
        b=XpROO18++MlP5xMsXMq0Vd9oBnrFeVWfEVkFKieNSg3Y5teFQ1DFI071GZ7nWx1fIe
         i5oBoVt2d3v2XMW53Ho8BYbrSVD3XaVyz+J8orSM+CbtArQLFh35Us4F6QHZlqFvBv43
         Zx3FWmFqqcLUmEIBOVWpazROetLCK1FjHF9JzvB2u4z1xrcZiJM1u4GaLgocwFguM7pK
         lLONrrsVRK4frRxAVkb9oUt1+YHPNsKq6GbLcjtvzO1wmNWKK4NBlMUdb5xsxQUoYiPt
         vtGERfFQaxVKkUjP12tiv+FYi5FYzpynDmZGcDdGXOmBwjp3Jis1O02HmTrirnreQxSk
         mtPw==
X-Forwarded-Encrypted: i=1; AJvYcCWdJGGTqJMLnuuq3uJ5ABFofCDP4MDVGP/OTWSHBbWEqVtv+P7W2BJpXtnaxD8gwFkrvmaFYEqtgNXo@vger.kernel.org, AJvYcCWu0veQloGiITOwGXjgHx6MZFr2ONnR8lWBG3Px1tH9tyCgUVGRtbCNoXEenOyKDpHomHKAXy/BZ+T8atJJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3iGIucD5BzZxDJ8MpIcdwVBcv8WqFbXQa0NH83tDwg0CFdFZO
	Wrq3XOMudXx8oO5aGoZNRnbstxJFLTgcXnlp5m8qIX+ftwd5GWcfe05m+eDR58lPZyuxda7qPGB
	d4HJH5zD15SM0SiQqqVOAJVLuSO4=
X-Google-Smtp-Source: AGHT+IEEs++kjhiCk/dC57j/rtmpcG/QTaX/JPBrFL3o/JSAJHO/nIF4kBRL0ryw9ZHVN3IgJ4KnNNQ0mWkAs9IJ7AE=
X-Received: by 2002:a05:620a:31a1:b0:7a9:c3da:a806 with SMTP id
 af79cd13be357-7ae6f4a6916mr2848191885a.54.1728417719766; Tue, 08 Oct 2024
 13:01:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008152118.453724-1-amir73il@gmail.com> <20241008152118.453724-4-amir73il@gmail.com>
 <dda3f1f28bce2d155bcffce953dc331956df38f2.camel@kernel.org>
In-Reply-To: <dda3f1f28bce2d155bcffce953dc331956df38f2.camel@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 8 Oct 2024 22:01:47 +0200
Message-ID: <CAOQ4uxiaVtGsPUXZhRD-K3RgOuNMmv6H2g17LSjZ1faT+uyRDQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] fs: open_by_handle_at() support for decoding
 "explicit connectable" file handles
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Aleksa Sarai <cyphar@cyphar.com>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 8:37=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Tue, 2024-10-08 at 17:21 +0200, Amir Goldstein wrote:
> > Teach open_by_handle_at(2) about the type format of "explicit connectab=
le"
> > file handles that were created using the AT_HANDLE_CONNECTABLE flag to
> > name_to_handle_at(2).
> >
> > When decoding an "explicit connectable" file handles, name_to_handle_at=
(2)
> > should fail if it cannot open a "connected" fd with known path, which i=
s
> > accessible (to capable user) from mount fd path.
> >
> > Note that this does not check if the path is accessible to the calling
> > user, just that it is accessible wrt the mount namesapce, so if there
> > is no "connected" alias, or if parts of the path are hidden in the
> > mount namespace, open_by_handle_at(2) will return -ESTALE.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/fhandle.c             | 20 +++++++++++++++++++-
> >  include/linux/exportfs.h |  2 +-
> >  2 files changed, 20 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/fhandle.c b/fs/fhandle.c
> > index 7b4c8945efcb..6a5458c3c6c9 100644
> > --- a/fs/fhandle.c
> > +++ b/fs/fhandle.c
> > @@ -246,7 +246,13 @@ static int vfs_dentry_acceptable(void *context, st=
ruct dentry *dentry)
> >
> >       if (!(ctx->flags & HANDLE_CHECK_SUBTREE) || d =3D=3D root)
> >               retval =3D 1;
> > -     WARN_ON_ONCE(d !=3D root && d !=3D root->d_sb->s_root);
> > +     /*
> > +      * exportfs_decode_fh_raw() does not call acceptable() callback w=
ith
> > +      * a disconnected directory dentry, so we should have reached eit=
her
> > +      * mount fd directory or sb root.
> > +      */
> > +     if (ctx->fh_flags & EXPORT_FH_DIR_ONLY)
> > +             WARN_ON_ONCE(d !=3D root && d !=3D root->d_sb->s_root);
>
> I don't quite get the test for EXPORT_FH_DIR_ONLY here. Why does this
> change require that instead of just continuing to WARN unconditionally?
>

The reason is at the end of may_decode_fh(), you have:
       ctx->fh_flags =3D EXPORT_FH_DIR_ONLY;
       return true;

So until THIS patch, vfs_dentry_acceptable() was always called
with EXPORT_FH_DIR_ONLY.

THIS patch adds another use case where HANDLE_CHECK_SUBTREE
is being requested, but this time EXPORT_FH_DIR_ONLY is optional.

The comment above "exportfs_decode_fh_raw() does not call acceptable()..."
explains why the assertion is only true for directories.

Thanks,
Amir.


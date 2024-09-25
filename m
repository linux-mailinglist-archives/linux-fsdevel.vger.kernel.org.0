Return-Path: <linux-fsdevel+bounces-30056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9347985765
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 12:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65CC32847F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 10:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1762D15DBAE;
	Wed, 25 Sep 2024 10:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCB2VXdU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D557F77107
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 10:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727261513; cv=none; b=JAeK+0Z0S21pefpCB/AOSL7WrkToqLeoFilTi03ujhhWrfdPHXcSXuyhoOHcZ93m0sjC58selXlIoUYiGId0zQGIwa83Dz0cO/u1NJdn1oS9MVfFxNjV4/drOLjw6ZkGGz1Q/rEVDwHkjJ3zH2DNBlYWarePFLayyG6uBI3CXSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727261513; c=relaxed/simple;
	bh=H2J5Y5v62km63zTKlgAsuNML8wiQj25tmcncB/LKjtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I/eCoECyq/lEIisAPEMlNRAI4wiAMPOwAPge8ZFw0b8MYgIol4lpvwfWGgfadkpV5mLLkjObuFUdJAeBC5EsSDViyruCaPno27l/ibHzSL8BHPF3JS/0C4NwBz0SOYLdDQOJohoHjKSAz7NJTSb0vs+De2fSukg/HiPwtj4U3xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCB2VXdU; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6cb259e2eafso2189106d6.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 03:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727261511; x=1727866311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DyDMghNbMpXYpH6JPESBzs160dDoR0mGLIEhOZx1OCI=;
        b=MCB2VXdUaKoNePf24P8++jfACpObppjCHQuIG184Gb9MiDe2GyZvEVS8rEvNaMorPk
         X2oSizSTeJWUQF7Un4ViTaXrcmHRu7C8VSvBBYUozDDVLNb+z5IvH8m6HWfUeluOfNOL
         EhMLWuM7B+LNublozX0Gkf8S1P5NQ3NhuFE8WhzyPeZKYZJz2Fn5Fleue9meCvVCpzqr
         416V2Je/OaFcmJ/l8cxxuzxzoIG6FZtqzY2ewleSiC6OrJAw7x8nPKerIMEXeS0Q9+jP
         c3DxkAfcj0073xPJswxaYBG61/HNE1DSl2hOUYgeo3aLnBmk5SiyRWZnWq/8s6/ZSLXm
         TjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727261511; x=1727866311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DyDMghNbMpXYpH6JPESBzs160dDoR0mGLIEhOZx1OCI=;
        b=CR+MwFX06WclOWAgDPqlzwrzTrxTpKm4VLk0RT45o84ldVrckT81ZA/HchD4HZHy/L
         C7KgvM9Z4uMpMegJlZOU7xGOd2S7k4dNbY69D4AXz8D9ejwz2YEkWyZS7+k7jW7TTFtg
         ybvii3Tp+n1+IMcF2hKn1tjNK50ROHrqAIWC3GfNz4dEZwk555gpQkM+nOQnwhN38ole
         yuvx13QL+ZiDJrtwtORFTxQ9qBh2P7hprCNNENQnW5urcBy4UE0RrRP1EuiTYEw1ew6I
         ZiunZe/jIOyq7HJrqsGE6hgtPczP92Y/DprncfRdJvn7FaKABbcGcB6bCPySLZaQhbe8
         BNyQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7Yae/DjpKOktQtgpZlLnpWTQyVKtuOSfz387J1i9WeCggF9Sqh7/R5wfX1lraH8QjTbe/C714QHz5jfT1@vger.kernel.org
X-Gm-Message-State: AOJu0YyteAJG+OeOqtA5y/Yp9fFCgIPrUHuGiNXz4CeUjgxJjKebwcw+
	HEMf7mdxfpdU3CFiOHB5nD0Y9WWUMYaxWiJ0IkgZ/N9mMagSApnMCWlK2FYBJSz6JAR7wt+jiMX
	EkZ70WKFDJJTPaGE8uYOfTkmNkz8=
X-Google-Smtp-Source: AGHT+IHor01mHc1jv0lqnhlGb4rKdd5EVVuGnLoJyoqNQmitt2l9MOlUF4uzTE0mgx8Ebac0OSmgN4Xnwa6i6lvdxb4=
X-Received: by 2002:a05:6214:4497:b0:6c5:1452:2b47 with SMTP id
 6a1803df08f44-6cb1dc22895mr33608336d6.18.1727261510560; Wed, 25 Sep 2024
 03:51:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SI2P153MB07182F3424619EDDD1F393EED46D2@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxiuPn4g1EBAq70XU-_5tYOXh4HqO5WF6O2YsfF9kM=qPw@mail.gmail.com>
 <SI2P153MB07187CEE4DFF8CDD925D6812D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxjd2pf-KHiXdHWDZ10um=_Joy9y5_1VC34gm6Yqb-JYog@mail.gmail.com>
 <SI2P153MB0718D1D7D2F39F48E6D870C1D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <SI2P153MB07187B0BE417F6662A991584D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <20240925081146.5gpfxo5mfmlcg4dr@quack3> <20240925081808.lzu6ukr6pr2553tf@quack3>
In-Reply-To: <20240925081808.lzu6ukr6pr2553tf@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 25 Sep 2024 12:51:38 +0200
Message-ID: <CAOQ4uxji2ENLXB2CeUmt72YhKv_wV8=L=JhnfYTh0RTunyTQXw@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: Git clone fails in p9 file system marked with FANOTIFY
To: Jan Kara <jack@suse.cz>
Cc: Krishna Vivek Vitta <kvitta@microsoft.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 10:18=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 25-09-24 10:11:46, Jan Kara wrote:
> > On Tue 24-09-24 12:07:51, Krishna Vivek Vitta wrote:
> > > Please ignore the last line.
> > > Git clone operation is failing with fanotify example code as well.
> > >
> > > root@MININT-S244RA7:/mnt/c/Users/kvitta/Desktop/MDE binaries/GitClone=
Issue# ./fanotify_ex /mnt/c
> > > Press enter key to terminate.
> > > root@MININT-S244RA7:/mnt/c/Users/kvitta/Desktop/MDE binaries/GitClone=
Issue# ./fanotify_ex /mnt/c
> > > Press enter key to terminate.
> > > Listening for events.
> > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/info/exclude
> > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/info/exclude
> > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-applypat=
ch.sample
> > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-applyp=
atch.sample
> > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/applypatch-m=
sg.sample
> > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/applypatch=
-msg.sample
> > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/commit-msg.s=
ample
> > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/commit-msg=
.sample
> > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-push.sam=
ple
> > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-push.s=
ample
> > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-merge-co=
mmit.sample
> > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-merge-=
commit.sample
> > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-commit.s=
ample
> > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-commit=
.sample
> > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/post-update.=
sample
> > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/post-updat=
e.sample
> > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/push-to-chec=
kout.sample
> > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/push-to-ch=
eckout.sample
> > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/fsmonitor-wa=
tchman.sample
> > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/fsmonitor-=
watchman.sample
> > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/update.sampl=
e
> > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/update.sam=
ple
> > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-rebase.s=
ample
> > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-rebase=
.sample
> > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-receive.=
sample
> > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-receiv=
e.sample
> > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/prepare-comm=
it-msg.sample
> > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/prepare-co=
mmit-msg.sample
> > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/description
> > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/description
> > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/HEAD.lock
> > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/HEAD.lock
> > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config.lock
> > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/config.lock
> > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config.lock
> > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config
> > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config
> > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/config
> > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config.lock
> > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config
> > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config
> > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/config
> > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config.lock
> > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config
> > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config
> > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/config
> > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/tNbqjiA
> > > read: No such file or directory
> > > root@MININT-S244RA7:/mnt/c/Users/kvitta/Desktop/MDE binaries/GitClone=
Issue#
> >
> > OK, so it appears that dentry_open() is failing with ENOENT when we try=
 to
> > open the file descriptor to return with the event. This is indeed
> > unexpected from the filesystem.

How did you conclude that is what is happening?
Were you able to reproduce, because I did not.

> > On the other hand we already do silently
> > fixup similar EOPENSTALE error that can come from NFS so perhaps we sho=
uld
> > be fixing ENOENT similarly? What do you thing Amir?
>

But we never return this error to the caller for a non-permission event,
so what am I missing?

> But what is still unclear to me is how this failure to generate fanotify
> event relates to git clone failing. Perhaps the dentry references fanotif=
y
> holds in the notification queue confuse 9p and it returns those ENOENT
> errors?

My guess is that ENOENT for openat(2)/newfstatat(2) is from this code
in fid_out label in:
v9fs_vfs_getattr() =3D> v9fs_fid_lookup() =3D>
v9fs_fid_lookup_with_uid()

                if (d_unhashed(dentry)) {
                        spin_unlock(&dentry->d_lock);
                        p9_fid_put(fid);
                        fid =3D ERR_PTR(-ENOENT);
                } else {
                        __add_fid(dentry, fid);

So fanotify contributes a deferred reference on the dentry,
and that can somehow lead to operating on a stale unhashed dentry?
Not exactly sure how to piece that all together.

This seems like a problem that requires p9 developers to look at it.
fanotify mark has an indirect effect on this use case IMO.

Thanks,
Amir.


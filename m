Return-Path: <linux-fsdevel+bounces-33002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9689B155E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 08:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24CFF2830CE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 06:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCA613C918;
	Sat, 26 Oct 2024 06:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zqle5bdE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CE8217F2E;
	Sat, 26 Oct 2024 06:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729924202; cv=none; b=g2jzzfC/4YpUzUJJZy4kX3CsNxOkit1vLXTbXPpKiu7dtAcBKehHABWQUdosHaDS0ba6KsL9mlxMEMoawegnNSY20c9CyYt1m0kyrqlYknTOlKL9A1jnBHexGRWKNnJ/LVmN2rRvyKkNv6yjADhvHaJ/ewGlBCHvMPCt1gA+o8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729924202; c=relaxed/simple;
	bh=kDwba7q52GRwCKutg4kAEdqrSexnQZXqnAjJw1nyepU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ThyilCqOtA4HRaafoxFWDeq0b/Y7brbgox5ufwe2PNOpS7oGPwBVZNwGEzuoelgXvwzfiRHqGrCrvKEc8rZ9MhToZ4jewYLTsy2AOM0aanaTYsohJsX0ohwB9iaaDuJ5FV1k+NUez5HXTWiVo6wKoesh65VNjouMCFMnYS/VCJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zqle5bdE; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-46096aadaf0so18017801cf.2;
        Fri, 25 Oct 2024 23:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729924199; x=1730528999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21FroNniHwijAqeqi68fHRmnoW4Fq93FrDCRxx7T1K0=;
        b=Zqle5bdEw8lfhsHNM/US2iEC2GG70bUbNB9LPntdU06e29xhJ7ofjJY55I9D+2f93K
         a/QdyDyZT/O/URcmU6EZGe2WRbnJUUe0lvXAOVzYlEr7frVajwgaHNXJdMJaySrCat11
         YNGjbPfVP/j8SAawhS/vCZKkULCpf++W87fw0ZZ2Xf7/vS3DsyRGZhSBQpqou5M7DG2S
         u9oIIn5LH1LqO4TkOPwgkal9QYwpi6sOWiNc+7YfLv72og8+gI9fCKvQKmX0YTCTKgMv
         2QsuMnGw7fGDGaoR+gRsBBXN+IoF4jBlUMEX0Ul/qsfZejsxXSnIFZvuBOOPsc68Vt2l
         Ws5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729924199; x=1730528999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21FroNniHwijAqeqi68fHRmnoW4Fq93FrDCRxx7T1K0=;
        b=p6elxaMNk9wnd+mR8CPfUp2g1TJE8NoPennZP8ROyezHOOvBzjMZvF3nkhRJnVFhhD
         26S/utzGVUD0h6OnUED8Bpsw91IsoUEGx13munvQGAcJPs4VW3Es1psilpQCYFvJGRDb
         tkOXcxQpZvLBESvzAbq4AxcdaaWwB0dco9+/qf9ablWKaLaBOog+BoshElLYX3VntCy9
         FqcSX0lZZvMMQQ6q0gAL3pBlGnNDfOCymX/56OTTfiHYPCUkox+6XUEnzNBxqAZzv0bE
         jX/7EISIqnqtZGVtMQ2Bs5rpeL7ZI3S2/IhVnwVB+DD+l6ZGcnc7NTRGCRlAv0lJuL9s
         33LA==
X-Forwarded-Encrypted: i=1; AJvYcCWN+aGK1fLntxNjvlrtcs4hkCKIpv4ENCIiAqwlRW2GOjP2tH8mgQMc3kh2bWC9h01axKz54o5/oQUbJnMD@vger.kernel.org, AJvYcCWwhQpAae0ZzByGX+RsTkkBaArWqBEx4DSbFDKGdhCnf9hjSoiiG3DF6QwCgI7KPkryKv1tKRy+VUt3dzTgFA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn8zPB3S3KnZT+ked0auCCXMVqcRzJirEk+5b99iHx2d1qhpnr
	392TtNqbvSRQatImKqXm2VQL++9Y/jMXISN2lFQBlvett9TGjUY+aFKQUYcXoApvO6QtZr7oBpJ
	q21ResG/ZYhehHlug1J38Gu41sEsohYLa
X-Google-Smtp-Source: AGHT+IGcDQUXIiENqiUt7O/hLqogXfITvCbZ9E3artb48LsEMgwMrIFXQ9EPn/U5O9pTCgu7nTNg2QbDYKuV1MxMhOw=
X-Received: by 2002:a05:622a:134a:b0:460:ae04:9f9e with SMTP id
 d75a77b69052e-4613c1a3ef8mr26704431cf.48.1729924199078; Fri, 25 Oct 2024
 23:29:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021103340.260731-1-mszeredi@redhat.com> <CAOQ4uxgUaKJXinPyEa0W=7+qK2fJx90G3qXO428G9D=AZuL2fQ@mail.gmail.com>
 <20241021-zuliebe-bildhaft-08cfda736f11@brauner> <CAOQ4uxi-mXSXVvyL4JbfrBCJKnsbV9GeN_jP46SMhs6s7WKNgQ@mail.gmail.com>
 <CAJfpegsYanxpkYt9oHdqBuCkxe4p5usSU=u+3rNZZ=T=HmpJug@mail.gmail.com>
In-Reply-To: <CAJfpegsYanxpkYt9oHdqBuCkxe4p5usSU=u+3rNZZ=T=HmpJug@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 26 Oct 2024 08:29:47 +0200
Message-ID: <CAOQ4uxgb90-Nf0yKc==xy3Ts=oeTYiho4VZu+ZAVVwqTx0M5-g@mail.gmail.com>
Subject: Re: [PATCH v2] backing-file: clean up the API
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <mszeredi@redhat.com>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 9:02=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Tue, 22 Oct 2024 at 20:57, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Mon, Oct 21, 2024 at 2:22=E2=80=AFPM Christian Brauner <brauner@kern=
el.org> wrote:
> > >
> > > On Mon, Oct 21, 2024 at 01:58:16PM +0200, Amir Goldstein wrote:
> > > > On Mon, Oct 21, 2024 at 12:33=E2=80=AFPM Miklos Szeredi <mszeredi@r=
edhat.com> wrote:
> > > > >
> > > > >  - Pass iocb to ctx->end_write() instead of file + pos
> > > > >
> > > > >  - Get rid of ctx->user_file, which is redundant most of the time
> > > > >
> > > > >  - Instead pass iocb to backing_file_splice_read and
> > > > >    backing_file_splice_write
> > > > >
> > > > > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > > > > ---
> > > > > v2:
> > > > >     Pass ioctb to backing_file_splice_{read|write}()
> > > > >
> > > > > Applies on fuse.git#for-next.
> > > >
> > > > This looks good to me.
> > > > you may add
> > > > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> > > >
> > > > However, this conflicts with ovl_real_file() changes on overlayfs-n=
ext
> > > > AND on the fixes in fuse.git#for-next, so we will need to collabora=
te.
> > > >
> > > > Were you planning to send the fuse fixes for the 6.12 cycle?
> > > > If so, I could rebase overlayfs-next over 6.12-rcX after fuse fixes
> > > > are merged and then apply your patch to overlayfs-next and resolve =
conflicts.
> > >
> > > Wouldn't you be able to use a shared branch?
> > >
> > > If you're able to factor out the backing file changes I could e.g.,
> > > provide you with a base branch that I'll merge into vfs.file, you can
> > > use either as base to overlayfs and fuse or merge into overlayfs and
> > > fuse and fix any potential conflicts. Both works and my PRs all go ou=
t
> > > earlier than yours anyway.
> >
> > Yes, but the question remains, whether Miklos wants to send the fuse
> > fixes to 6.12-rcX or to 6.13.
> > I was under the impression that he was going to send them to 6.12-rcX
> > and this patch depends on them.
>
> Yes, the head of the fuse#for-next queue should go to 6.12-rc, the
> cleanup should wait for the next merge window.
>
> So after the fixes are in linus tree, both the overlay and fuse trees
> can be rebased on top of the shared branch containing the cleanup,
> right?

Right. I see that fuse fixes are merged, so I will rebase
overlayfs-next and apply this patch there.

I don't think you will have any fuse passthrough changes for v6.13,
so we should not have any conflicts.

Thanks,
Amir.


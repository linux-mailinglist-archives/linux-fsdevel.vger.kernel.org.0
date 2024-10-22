Return-Path: <linux-fsdevel+bounces-32612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4169AB659
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 20:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7B13B23D65
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 18:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2461CB50E;
	Tue, 22 Oct 2024 18:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6r4Bqw7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D73419DF9E;
	Tue, 22 Oct 2024 18:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729623317; cv=none; b=nCMBu2BT8gtBd56H6QN+CRmd36/6s28rotIofaTnVg5umENo2P+B4OOQABRhVywkTOLLIPVW1ySS7joiIJzu8y9m39HK4mu+RQbbOj7LNeZpA/+3qFKPgAN9JBD29Ju8lfk292PxTyXHIlvKslHDki1iuQiQ5L76JsFhGO3t8Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729623317; c=relaxed/simple;
	bh=hWWqRkfyyrZm7qXspd5uhVBPDRGaALM6ul+QgSjlc/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=otzDWoNLvRB6fzO95QvJHozOGR+yAVP9/ASBZ6bRhCphfJ+mcX2vuzwVJUXPqO7nE9nPaM1uF2/0wtzz2WpqNNvhK/cnmSPOJv2J2efgAHmkeSpvei1fKgoo0eUdpk/KdIWIMG93ySY3OqpsCTFwiBEYLKyY+R765BDYgR9e4DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6r4Bqw7; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b12a02596aso394058485a.2;
        Tue, 22 Oct 2024 11:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729623315; x=1730228115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Inereob7JwAQ36iYEwx7BQG2WhKjudzG9viDN1vwhRA=;
        b=l6r4Bqw7xmTPAxDlroKbqQJswrxjA4LLL6aGtLg117KyBO1RYZPCuRxpDtEs1xWJDS
         K98fb4Tr0yDLHpSFztyXzRyhL8qD2tlYi+mKhduA1v2lGvi3/ErdVrLsvjetWV9kBUmi
         FDTi8KDBysOXrhkYG8Jsi7YMSLwEbUeIoJDlC23XFuX5eW3lcsOO0XsoguDdilel6fC2
         8gv5P+YSsHSE1fFQL7ZkB0TDLJ2TOWL2jk0YH+P4td8pr9LecFRxW65ecnvgkvNBNG0l
         K+KWzWH56NrHvaraHqLmOfZVi2obe+tUOzcstmrAO7Th6TePp3h5FrZ3HtwctC1O7fvW
         b6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729623315; x=1730228115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Inereob7JwAQ36iYEwx7BQG2WhKjudzG9viDN1vwhRA=;
        b=UxEG0bJ32vG4UTM4X1P5HG1HGiiDGH7vEHaCfZbSbut7ZI1WmWic/o4D4MhcAjHfjJ
         6GQAt5qD9Lk3++ZiwQZlf8YOuvBUTYbCaQReEVYXXQEi8fUF6lunLx2AefyOgEO5raFq
         sgycIjGM2KNgtH7R438VpEChnQH36hyJ+y1igEs8rsDLvClGV70e4qmaCA5s98iRObH3
         OmuiE+dpaOu1ZgTg7qxWoqaVUpjrR8haL8VHtIr2kAqd5Egm7GPwFDnVBUP5YZtAe2aP
         k72LqGHkT6A5hb6thSwP8EpL0SECAyIzCGLVscOOuT3W1TmlhaQyG2rV0xkDMPW6Edbw
         jJwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWs9+YnfSWkCrJaK0R0woGQc0eHytCiz63ECKXMSjtP/6MxAi1dcbRYyYI8GL5wWwWJWsUJgDbIaJ91+JDZ@vger.kernel.org, AJvYcCXfD2MAIP4+yPYB2bzCYxMWKDwNZHNhdc1LO73NTnQW8BIcXqkLdEhfEmky2pSwxfns/5lJZVefHIDGHejHFg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yya8BGSql67QQzlqfBRH/mjWXX3dia8WQfaZbHzvhT+//7LTkMF
	Tq2olUcCJakW+K+mKTEt45gjNfPn0m03ulXrPgTPX7MxuiMOWhy306k51SwOy0pIClo66FT/RcG
	lRVvuC28BHCGpHTHkKl73pV2aztq8C4W6CtM=
X-Google-Smtp-Source: AGHT+IFF0iOdbWKjpWjKmE0Urpsx2SzR46H9huiRTyDvrc+5Lk6OEVAdWk/GkNKtgJcUB9jPW6f+Blnla9sRlSGG+0w=
X-Received: by 2002:a05:622a:14d4:b0:460:e7e3:b072 with SMTP id
 d75a77b69052e-460e7e3b1c9mr114585541cf.57.1729623315161; Tue, 22 Oct 2024
 11:55:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021103340.260731-1-mszeredi@redhat.com> <CAOQ4uxgUaKJXinPyEa0W=7+qK2fJx90G3qXO428G9D=AZuL2fQ@mail.gmail.com>
 <20241021-zuliebe-bildhaft-08cfda736f11@brauner>
In-Reply-To: <20241021-zuliebe-bildhaft-08cfda736f11@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 22 Oct 2024 20:55:03 +0200
Message-ID: <CAOQ4uxi-mXSXVvyL4JbfrBCJKnsbV9GeN_jP46SMhs6s7WKNgQ@mail.gmail.com>
Subject: Re: [PATCH v2] backing-file: clean up the API
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 2:22=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Mon, Oct 21, 2024 at 01:58:16PM +0200, Amir Goldstein wrote:
> > On Mon, Oct 21, 2024 at 12:33=E2=80=AFPM Miklos Szeredi <mszeredi@redha=
t.com> wrote:
> > >
> > >  - Pass iocb to ctx->end_write() instead of file + pos
> > >
> > >  - Get rid of ctx->user_file, which is redundant most of the time
> > >
> > >  - Instead pass iocb to backing_file_splice_read and
> > >    backing_file_splice_write
> > >
> > > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > > ---
> > > v2:
> > >     Pass ioctb to backing_file_splice_{read|write}()
> > >
> > > Applies on fuse.git#for-next.
> >
> > This looks good to me.
> > you may add
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> >
> > However, this conflicts with ovl_real_file() changes on overlayfs-next
> > AND on the fixes in fuse.git#for-next, so we will need to collaborate.
> >
> > Were you planning to send the fuse fixes for the 6.12 cycle?
> > If so, I could rebase overlayfs-next over 6.12-rcX after fuse fixes
> > are merged and then apply your patch to overlayfs-next and resolve conf=
licts.
>
> Wouldn't you be able to use a shared branch?
>
> If you're able to factor out the backing file changes I could e.g.,
> provide you with a base branch that I'll merge into vfs.file, you can
> use either as base to overlayfs and fuse or merge into overlayfs and
> fuse and fix any potential conflicts. Both works and my PRs all go out
> earlier than yours anyway.

Yes, but the question remains, whether Miklos wants to send the fuse
fixes to 6.12-rcX or to 6.13.
I was under the impression that he was going to send them to 6.12-rcX
and this patch depends on them.

I suggested to Miklos to squash this cleanup patch with the API change
for the fuse passthrough fix, which is a stable backport candidate, but
he preferred to not include this cleanup in the backport candidate patch.

Thanks,
Amir.


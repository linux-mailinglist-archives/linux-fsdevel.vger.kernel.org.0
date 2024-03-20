Return-Path: <linux-fsdevel+bounces-14864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBA6880D23
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 09:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DA461C22D51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 08:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AFB33CCC;
	Wed, 20 Mar 2024 08:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZG+UNEhk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF05282F7
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Mar 2024 08:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710923699; cv=none; b=Bzuj4ObUTr88ajhQ+jGRYJkQ4pxCpkYiBiDIZ4GM9qXkfMCtWbhOgW498LgnNXwFy5KzTgf/bREuYsTOtHmm6T3Bti50UQIyteeJa/QxhfVqHIbUFkesIhaxjaFOMoLsZ9I1SWLL9m3MmCRxmKNUvT1sV/WM83vFg32EygbtEw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710923699; c=relaxed/simple;
	bh=lZfi3soJWW45p2+5JTBOoyhheU1RBD21/myX7TAv0jM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BntLn2HpMLtAdYNVbB/wmcrULFMJOT2kLVmFd3hJ+r9E1oXDyk+z6bqN3Rno4JazvpBZOHEH+VekYm09fIj1Pua/z2Ti6ISuX8bntMc8yWfH0wgLCgmmvrwYmd9RP+0XZIG1PXBAaU9ddvM7SdrSr0GcBKx+xXzNS+CaGHWOfKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZG+UNEhk; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-690ae5ce241so28712666d6.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Mar 2024 01:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710923696; x=1711528496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3hhUij9dW6asoZCW3kDXnPlYbJDu7wSUzBeZxugqsDE=;
        b=ZG+UNEhkevYaZAI2l/HcjWwFDsw0Z45eMCRF0weZMPihCVXYbp1nIgtdNkNkUSo0Op
         d+G8h44taRLIyVY5Av+LVjfveC+VnkeA90ReoY6seKE4LTMaT8DmBfl3RFbMy0eTDUgt
         oeHePJg+c0Dwe5mIZliT9Trj285o0mxNqCbNQWe54YsMFwCfasZLxGsyGK18OccSXCGy
         jN5z0NEAxCUPlrBgXq4rFbrm3jgPiTytB7ylSvUE69gxycAR94GJDWKAX92ptAyjNTSJ
         vTYdM2AvH1RKxfnn6ItYikoau9vk/MNK+g/XxGI4xFGQ6nTzGEvKixIToRKq9xtQG/vw
         WU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710923696; x=1711528496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3hhUij9dW6asoZCW3kDXnPlYbJDu7wSUzBeZxugqsDE=;
        b=E1TR81g3f43qRG7tFjH6pGizLklMTu42e/F4lIbigGbAM9TRoN+yptjzsobxb0aGMR
         +hn4AU5tSHGvrFufV6vpCmC8uQ6e6+bgbMKZwSbCPfICfI95Spfu++j0dBproYNjnMAu
         v6FOgLGFTWujBDj6f8oyfj/G/iSroWR270ggbYDheYshCI1M3pLwjZ/kzg5VcMrreOMM
         2zUFIZ43iO2JjYsOkrD++jZaYl3e8mIESgxWbcH/p00iJv9NoCQfSA4JE0KgchtCluYC
         n34bZBI9PqrJ58cEj9cI5oVMIjDp1yqieiuhBRsG8MB1Yzt3il7oioGcKIhyzuPdY7gf
         feCA==
X-Forwarded-Encrypted: i=1; AJvYcCXTQi9R44lRToQCkYm+DT9I4HZhXL68pFGmBpnlkFk7DieA7hTWVi+IS6d4B33q5Jfnj6HCZk8EvVvW1qYAhTJjjQ1LQb/R39fohi6mEg==
X-Gm-Message-State: AOJu0YyTnEA3EXm+9GdSr37y4xiB4Mg0xxPqqCxdi06JRiB8J4VJos53
	Du1OmIZcsXHZaMsNTcPR+8zLcbVRnD8Ua9A4vHNoj6M9yt1FI1g9oXN8Uk2kDOcqGyEl8RzUcet
	ZMQjOj8pwBJojLee6oYlgIU4exBCH1P3V
X-Google-Smtp-Source: AGHT+IF4fSNC0G66crzzMVXbjy7X/RtdnHV4+CV8ThAqv0DO/7RSiA+rSzn1a13uK2bKq9wD/wF58ywMku7E1xRIX+s=
X-Received: by 2002:a05:6214:5144:b0:690:e2b5:9219 with SMTP id
 kh4-20020a056214514400b00690e2b59219mr1369894qvb.22.1710923696508; Wed, 20
 Mar 2024 01:34:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240317184154.1200192-1-amir73il@gmail.com> <20240317184154.1200192-3-amir73il@gmail.com>
 <20240320-versorgen-furios-aba1d9706de3@brauner>
In-Reply-To: <20240320-versorgen-furios-aba1d9706de3@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 20 Mar 2024 10:34:45 +0200
Message-ID: <CAOQ4uxi+uPePQKeqGiOLbqCvCyWKMsH4AJjZ7NXEH+SD7CQvbw@mail.gmail.com>
Subject: Re: [PATCH 02/10] fsnotify: create helpers to get sb and connp from object
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 10:29=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Sun, Mar 17, 2024 at 08:41:46PM +0200, Amir Goldstein wrote:
> > In preparation to passing an object pointer to add/remove/find mark
> > helpers, create helpers to get sb and connp by object type.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/notify/fsnotify.h | 14 ++++++++++++++
> >  fs/notify/mark.c     | 14 ++++++++++++++
> >  2 files changed, 28 insertions(+)
> >
> > diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
> > index fde74eb333cc..87456ce40364 100644
> > --- a/fs/notify/fsnotify.h
> > +++ b/fs/notify/fsnotify.h
> > @@ -27,6 +27,20 @@ static inline struct super_block *fsnotify_conn_sb(
> >       return container_of(conn->obj, struct super_block, s_fsnotify_mar=
ks);
> >  }
> >
> > +static inline struct super_block *fsnotify_object_sb(void *obj, int ob=
j_type)
>
> If I read correctly, then in some places you use unsigned int obj_type
> and here you use int obj_type. The best option would likely be to just
> introduce an enum fsnotify_obj_type either in this series or in a
> follow-up series.

Good point.

There is an enum already but we do not use it.
Jan, WDYT?

Thanks,
Amir.


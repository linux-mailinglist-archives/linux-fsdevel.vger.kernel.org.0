Return-Path: <linux-fsdevel+bounces-8244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C59CB831A99
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 14:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C2ED1F225DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 13:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB922555A;
	Thu, 18 Jan 2024 13:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgdWuqL3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EE224A0C;
	Thu, 18 Jan 2024 13:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705584664; cv=none; b=kZJrg/efGegpuI1LlSvxJcu5VQdDVAX3Cy1Wpe+5TgIrcchvQK8fCYz94/tfPq4bYSi+BbYVHx/uPXoKffGhuPt1tF8DRm17K+OGLaaS8yMq3AQSCAIboDfJl18zt193zBBIqQ4Yu3BaIaFJC2A0idO085RNcseKhm7UVLxmZqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705584664; c=relaxed/simple;
	bh=S6IKGjBr0anylaVLj4AUB6rmm67gcCQL9sQKmbVJiGQ=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=Iux2TuWKbKESNX9HifC7evtxtBMawALA8ngLewyCsH6/RzCK73R2vQd5SN+oEfxLyzuQf/oo/rG8OXh/+se90b+VL47KS6abLesU/v+llqWjRKqp0qPkRsNJk+uc9ATOO/v1eTUFEoXLw12Eq1lc7pIY/JKKlIafwwTjRw1Dlyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgdWuqL3; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6817505b188so17093256d6.3;
        Thu, 18 Jan 2024 05:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705584662; x=1706189462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OiLgZqM8424D2bY2ed4KovAb0P+COGDlfoFeZdV6VHw=;
        b=fgdWuqL3AwfKe75+U1r3pXd2zkPT4eh8Dl6FLBxNSeFA3e4wQ4gIUqV2N4jaXbmHZ+
         so+cQFukyj+aifz/XhAsrpecZ6J3qK0e7mLOApdgig1mhTDUtR5jyQtIjo9bCwz4XhqB
         ru2/Hjez8ssabPaJEbw7cYFZt5JK3GQFk57+UNKHfnEHnGesaMuNtFbG28kyMiwMaTYL
         G2onAXn6odyQvO6pfbIQScFnvWsuxRT0AP2umCAeondnkXSxPEqnLwbgl759vsnQlx2h
         BcnF11oVF+dqk8B749cErcm6f65yaZ37j3467+hcU2wCh6SzVz7XZsKp9+FHUO54bU5s
         dleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705584662; x=1706189462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OiLgZqM8424D2bY2ed4KovAb0P+COGDlfoFeZdV6VHw=;
        b=IYXZ8WNXalnyMXs3dYEiJL5G8BlEvmdgjb7p2mRP8dIQw1NY1kAMLfyJ6oFwmQOrCs
         O5XH6CFx4E5N+V0LobC2Alm+3sQ5Swb/8Z6g2Ms4jKqxYGsFTBlEEkzmKmnyNdHeJ4HG
         1IiY04AyZA4aPHZF4f8eGunt+N+1FhIt0wBoJmZKZfQf9AWIE04YMJVNdU8fzB1RsKbY
         33cGaCR15I0eHw20mFS0VZUqY4fI3pvF75Haw9RfY7ebpeoJ4NYMg0pmsOe9HL69ImxE
         gYngiQfiQXARlfrCnoaYotkhPifnZR9cD53EiTVDr0H61h6mzGF04JZGrbKmpz0nZKR3
         UGTg==
X-Gm-Message-State: AOJu0YzQS6EC46TOkEfXXWhLHhQ29WKLwz4xHPTfHzrf2egl+knKLyDi
	RMQVvHIuvva+RqaGasxEWPBd+xDH5WTci4QM66rwifyMvfYZn2olm6BSZ5X3eNZtyaq9j7zMiq9
	u5R6rBFG2C9YdUH+sy8FxE0+FcqR3admgVPA=
X-Google-Smtp-Source: AGHT+IF8gjTz5nfWp3ZOOAC8PSw88fN1JQZl1r9njdQ53kJnTvI+0kkDAPo6TyQTRsrE3qu2Oysw/vMVM39hEla9DJo=
X-Received: by 2002:a05:6214:1312:b0:681:89ec:9789 with SMTP id
 pn18-20020a056214131200b0068189ec9789mr842575qvb.128.1705584661734; Thu, 18
 Jan 2024 05:31:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118104144.465158-1-mszeredi@redhat.com> <CAOQ4uxgB3qhqtTGsvgLQ6x4taZ4m-V0MD9rXJ_zacTPrCR+bow@mail.gmail.com>
 <CAJfpegvhWwmHXzo3dd5VYLrCjUhxAesNAha-dOB+PCP8M2rM2g@mail.gmail.com> <157a90d9b3a5469a003bc5981b0fdee17a55bc18.camel@redhat.com>
In-Reply-To: <157a90d9b3a5469a003bc5981b0fdee17a55bc18.camel@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 18 Jan 2024 15:30:49 +0200
Message-ID: <CAOQ4uxiJwXftzVUBRnOHC_Q65HNsYfpt3TKnfsCaxssyDRAc1g@mail.gmail.com>
Subject: Re: [PATCH] ovl: require xwhiteout feature flag on layer roots
To: Alexander Larsson <alexl@redhat.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Miklos Szeredi <mszeredi@redhat.com>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 2:08=E2=80=AFPM Alexander Larsson <alexl@redhat.com=
> wrote:
>
> Resending with plan text.
>
> On Thu, 2024-01-18 at 12:39 +0100, Miklos Szeredi wrote:
> > On Thu, 18 Jan 2024 at 12:22, Amir Goldstein <amir73il@gmail.com>
> > wrote:
> > >
> > > On Thu, Jan 18, 2024 at 12:41=E2=80=AFPM Miklos Szeredi
> > > <mszeredi@redhat.com> wrote:
> > > >
> > > > Add a check on each layer for the xwhiteout feature.  This
> > > > prevents
> > > > unnecessary checking the overlay.whiteouts xattr when reading a
> > > > directory if this feature is not enabled, i.e. most of the time.
> > >
> > > Does it really have a significant cost or do you just not like the
> > > unneeded check?
> >
> > It's probably insignificant.   But I don't know and it would be hard
> > to prove.
> >
> > > IIRC, we anyway check for ORIGIN xattr and IMPURE xattr on
> > > readdir.
> >
> > We check those on lookup, not at readdir.  Might make sense to check
> > XWHITEOUTS at lookup regardless of this patch, just for consistency.
> >
> > > > --- a/fs/overlayfs/overlayfs.h
> > > > +++ b/fs/overlayfs/overlayfs.h
> > > > @@ -51,6 +51,7 @@ enum ovl_xattr {
> > > >         OVL_XATTR_PROTATTR,
> > > >         OVL_XATTR_XWHITEOUT,
> > > >         OVL_XATTR_XWHITEOUTS,
> > > > +       OVL_XATTR_FEATURE_XWHITEOUT,
> > >
> > > Can we not add a new OVL_XATTR_FEATURE_XWHITEOUT xattr.
> > >
> > > Setting OVL_XATTR_XWHITEOUTS on directories with xwhiteouts is
> > > anyway the responsibility of the layer composer.
> > >
> > > Let's just require the layer composer to set OVL_XATTR_XWHITEOUTS
> > > on the layer root even if it does not have any immediate xwhiteout
> > > children as "layer may have xwhiteouts" indication. ok?
> >
> > Okay.
> > >
>
> This will cause readdir() on the root dir to always look for whiteouts
> even though there are none, but that is probably fine.
>
> It does mean we don't have to change xfstests, but I still have to
> change mkcomposefs.
>
>
> > > > @@ -1414,6 +1414,17 @@ int ovl_fill_super(struct super_block *sb,
> > > > struct fs_context *fc)
> > > >         if (err)
> > > >                 goto out_free_oe;
> > > >
> > > > +       for (i =3D 0; i < ofs->numlayer; i++) {
> > > > +               struct path path =3D { .mnt =3D layers[i].mnt };
> > > > +
> > > > +               if (path.mnt) {
> > > > +                       path.dentry =3D path.mnt->mnt_root;
> > > > +                       err =3D ovl_path_getxattr(ofs, &path,
> > > > OVL_XATTR_FEATURE_XWHITEOUT, NULL, 0);
> > > > +                       if (err >=3D 0)
> > > > +                               layers[i].feature_xwhiteout =3D
> > > > true;
> > >
> > >
> > > Any reason not to do this in ovl_get_layers() when adding the
> > > layer?
> >
> > Well, ovl_get_layers() is called form ovl_get_lowerstack() implying
> > that it's part of the lower layer setup.
> >
> > Otherwise I don't see why it could not be in ovl_get_layers().
> > Maybe
> > some renaming can help.
> >
>
> In the version I was preparing
> (https://github.com/alexlarsson/linux/tree/ovl-xattr-whiteouts-feature)
> it does the setup in ovl_get_layers(). The one difference this makes is
> that it doesn't apply feature_xwhiteout on the upperdir layer. I don't
> think we want to do xwhiteouts on the upperdir, but if we do it needs
> to be initialized in ovl_get_upper() too.
>

If there is no use case for xwhiteouts support in upper then
maybe we should not support it?

Anyway, I am fine with Miklos' version or with checking xwhiteouts in
ovl_get_upper() and ovl_get_layers() or with not supporting
xwhiteouts on upper.

Thanks,
Amir.


Return-Path: <linux-fsdevel+bounces-58707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8168B309FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 01:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B1651699B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 23:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E92325BEF2;
	Thu, 21 Aug 2025 23:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRIfshqd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F7C224B1B
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 23:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755819086; cv=none; b=DmbkcYqs3I58NX/iASRgjhTEMpyIrYUhbK4mn2+Q3den1h7LvwCJs7KY3d7qzmcJIOX6GmmNXHX9fCrk5+3d7dwBLuE8WcyxTm7HadhIRNgHBq7KiOfyxy+jgfHVSorms9NGLJfUQRg/nQ+LD1ohD3nbG88Mza0zwvcTAJC6zTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755819086; c=relaxed/simple;
	bh=5Z4YlPXGYEb33lPBuy78aml6dEBg9bMc1Q+EbW7hNB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WogZ7Eq/uwH5g0hvGHUEggy0ZiqaXZrxzTbQXKUZRU9YfIHaJeGIZw9p20z47Gqd/9+dPOSNh6mBdFBFC601fsFn5nP1BEf46JYiS9T4UUTI02aN3mmtvfn1g0dPV/JT1HI7JuqMfz6uPCEUm//RsY+3X/1OwIeyW6shYbZyHVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRIfshqd; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b134a96ea9so13014821cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 16:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755819084; x=1756423884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ci7HE+a2e1cAte+GIRwZczA4T8h5QAfqjnj8Km7sG3w=;
        b=QRIfshqdcVZ+d9w8aULTUM5Xkb3YmWBmJmJKGPKFuDshV36DeBFzeLBXcVL6isxR7f
         CRWcStwijGlq86EEYRs8FyO8wTu/iE+TQBWSbKsZMDGXKNfbOGAa77jjRhcv+o44919V
         TnOl56RvTV78vxWzJkI+kdHzSyriX1FbuwPzs9PMaAypd5KQSTho4ScYCAPwPm37HYKf
         TW36I4j7uHC6UAZcG3p+P+CJ4c+7N6P/rT69Y/+JPUVstXUuJaW37IUKoHpTg9o9ElYX
         plmukTCFH3COn+9WPhrav19SGyvTlpoFwzSR7xjg6TMQgbmk788KYiSZySz5aTiTOMu+
         Dnlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755819084; x=1756423884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ci7HE+a2e1cAte+GIRwZczA4T8h5QAfqjnj8Km7sG3w=;
        b=VYr5sGBQ/zsEtxvvOCBs+dfYjl5pEC6ugnSylJ3v76b5kQ+cu4NWEmEdZqxM2sJGBm
         lWgIHeYFxgAQK6z/d6rpY9mlT3XIIM9DkSwUKo1aO/8YzzU8j4RW3yPL2/HRrvD6T5P7
         C3auBPa+/BVqlQjmjvH5dCZSLkozpB+ogIVClqz5cBj8uxqgZZtxLRxHvLfjp+VbTjV5
         wsJd8Yb4LPli5jzxoBFDn/gVTlkJBQU9UzW3biOkn0BcZEY7IwUkuJlA035CJ/AUheD1
         S7J+u8Pzqq+bdWxotZzGyotUCdlvFYnsC7Hh7PTONb2LSQEmpsksEKuvC1pfWSy1kYNQ
         Fxcg==
X-Forwarded-Encrypted: i=1; AJvYcCU5xF5g9momQeL0aSSWQtTLYC/6hMO/QWm7TpluUR7do4MFOGxYG7gsjxwoENk1japXZ16M9d3yBJ8Oue9V@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf8X0AqaBzQ8v9BDBvTS8dupPT/HuZ5Pmn83eFnlBTy6AInbfZ
	9V4MAme+qoP4pzzEW2ojDaCz+JvSju2gyD6uNp4A9glI6+STTx3+p2y8Nd7x8OJGxOM7ETva578
	MgNxEdYMKdGj2afSJvmpvHziNAz889ww=
X-Gm-Gg: ASbGncuj2DY4qOWpEWNRiITBM6PA6SKjwPuhEMtTwXyi5yMzer7BDgWXMmxJDD79i4V
	NB0Epqxgq3sdl3el1UAxFstvNkEp7WArpNicbRQSLmoKVVD0Ksgmk2egr3ddA8DI6+jKUoL9m4S
	fZ4q/txx3c8ROEIgd6DVZNNsvJn7vYsI+ML8cHbw8s+Oa/vZ4mUyh3/lex696E2U6tU1AOjqWmv
	TrrORlT
X-Google-Smtp-Source: AGHT+IHaX95RDR8jnxoLEsPvPCwYy+QCoRVgRp0pIzcYBs9kFgg4duDixVj3eBeqJGUJIuAaA6bSxEuLrtIkl/KAX3I=
X-Received: by 2002:a05:622a:28d:b0:4b2:998c:c48a with SMTP id
 d75a77b69052e-4b2aab3a30bmr14192851cf.46.1755819083990; Thu, 21 Aug 2025
 16:31:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
 <175573708692.15537.2841393845132319610.stgit@frogsfrogsfrogs>
 <CAJnrk1Z3JpJM-hO7Hw9_KUN26PHLnoYdiw1BBNMTfwPGJKFiZQ@mail.gmail.com>
 <20250821222811.GQ7981@frogsfrogsfrogs> <851a012d-3f92-4f9d-8fa5-a57ce0ff9acc@bsbernd.com>
In-Reply-To: <851a012d-3f92-4f9d-8fa5-a57ce0ff9acc@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 21 Aug 2025 16:31:13 -0700
X-Gm-Features: Ac12FXwvFWqsL3MC_UPK134A3nGaOr04X-qsyLzPcFu4TN45SVmVZZzs9JA9Ibc
Message-ID: <CAJnrk1ZdrgBwAYwWyoP1Kmm9yn5XxHqFwKVfamEzS8w4YCQ8RA@mail.gmail.com>
Subject: Re: [PATCH 7/7] fuse: enable FUSE_SYNCFS for all servers
To: Bernd Schubert <bernd@bsbernd.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, miklos@szeredi.hu, neal@gompa.dev, John@groves.net, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 3:54=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com> =
wrote:
> On 8/22/25 00:28, Darrick J. Wong wrote:
> > On Thu, Aug 21, 2025 at 03:18:11PM -0700, Joanne Koong wrote:
> >> On Wed, Aug 20, 2025 at 5:52=E2=80=AFPM Darrick J. Wong <djwong@kernel=
.org> wrote:
> >>>
> >>> From: Darrick J. Wong <djwong@kernel.org>
> >>>
> >>> Turn on syncfs for all fuse servers so that the ones in the know can
> >>> flush cached intermediate data and logs to disk.
> >>>
> >>> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> >>> ---
> >>>  fs/fuse/inode.c |    1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>>
> >>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> >>> index 463879830ecf34..b05510799f93e1 100644
> >>> --- a/fs/fuse/inode.c
> >>> +++ b/fs/fuse/inode.c
> >>> @@ -1814,6 +1814,7 @@ int fuse_fill_super_common(struct super_block *=
sb, struct fuse_fs_context *ctx)
> >>>                 if (!sb_set_blocksize(sb, ctx->blksize))
> >>>                         goto err;
> >>>  #endif
> >>> +               fc->sync_fs =3D 1;
> >>
> >> AFAICT, this enables syncfs only for fuseblk servers. Is this what you
> >> intended?
> >
> > I meant to say for all fuseblk servers, but TBH I can't see why you
> > wouldn't want to enable it for non-fuseblk servers too?
> >
> > (Maybe I was being overly cautious ;))
>
> Just checked, the initial commit message has
>
>
> <quote 2d82ab251ef0f6e7716279b04e9b5a01a86ca530>
> Note that such an operation allows the file server to DoS sync(). Since a
> typical FUSE file server is an untrusted piece of software running in
> userspace, this is disabled by default. Only enable it with virtiofs for
> now since virtiofsd is supposedly trusted by the guest kernel.
> </quote>
>
>
> With that we could at least enable for all privileged servers? And for
> non-privileged this could be an async?

This sounds reasonable to me.

Thanks,
Joanne
>
>
> Thanks,
> Bernd
>
>


Return-Path: <linux-fsdevel+bounces-13906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 673F8875537
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 18:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98FAC1C215D2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 17:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D39131E29;
	Thu,  7 Mar 2024 17:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0yhX9H3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E4C131729;
	Thu,  7 Mar 2024 17:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709832709; cv=none; b=JW7QaboIOvq28mFA++L1LA8TkkAG17WAfShPOcQGRyIXTE5VAHC1rmUmedN19ZUKy0OHlJEhG14ahbmDv04YcefapFa6aM9WbMsJCH7TqCz/VDWmZORAQwcITf90SgqAhIFrcNlOk5R3JywhuBpAhUNYFtHaDmtK9+cK2plCUUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709832709; c=relaxed/simple;
	bh=JG672GZmcOfqvWk4OcsE1n4GlL0ZB0TUsXrmHdWQmJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EiKcM1E2hoUL7Ej7S/YCAtxsUbEbSShll/fAzJpLi69uQ8LTWgEK/7Oyre33BIls9euOEk7v95QFt+yiP99MGc4Vd2RwuoL8+Xzj0TqfkCAdZrj1NwZL6qGhfa0sofwtAD9N9x1Ru1fVti9V00Xnm2ZD9X7GC+jZz+tcaRlgI94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0yhX9H3; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-42efa84f7b5so17553151cf.1;
        Thu, 07 Mar 2024 09:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709832706; x=1710437506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JG672GZmcOfqvWk4OcsE1n4GlL0ZB0TUsXrmHdWQmJg=;
        b=d0yhX9H3VRXeS8OSShL3f6eeGZC6cGnHyOU9sDK1OBt2QsqVRkPmd2BwHWHbTeperu
         aSw2w/lLIZkzB67RO6ricGZ8QDK4S+WhlF7mpNNZhMbNEMcwab4jBFjTGWoDk7RLHJRQ
         kYLY4b/q+DVXofTVbYseVuqYWTz1aYs2RM3vgjJyvHFA7u1wMGoRbx6DhzIwQaI329JB
         jX6/h6zbjK8ODuUTTalxJZPKX7YPLm7LDFznAHlrPk7M6NG/WQiCgZiNsVRkvND2Gx2I
         YUvuccV/vFoATcpZJF1ORlC9vOA6HauiCAHbi8s4KGTifEB1Yh45f9c9sjpdC0+vlweY
         f2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709832706; x=1710437506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JG672GZmcOfqvWk4OcsE1n4GlL0ZB0TUsXrmHdWQmJg=;
        b=PUC+rLttI+0uShZgKmx1Z4JCT4/NzYklTcwhtj2HHmSNaaSDeZxGjccPFhMaeo+whG
         TBY3MGUYgqL2O6mplkw/lGwL8cj4btzlcNdCwKAf8QbLDbaxjXYc+ruaPtA1px3LesZe
         VE7DzwLVaOOt866cdEfOpftlHwMGld4jOc+8NR1Is5P2bM7fsI9zCasHASnrdO+bjEFR
         B6/RAkyROr8+v+AzjPsNYJjQq6N7MHnUoEndXRWDufMxbeI9KvRR2fGYSiHt/Chcq+6l
         kQmkbUnRUQPpXV1379Hm4IqGsAmUf89/kBOotNFWjVkdA3+PvzW6FuIUEVkNv+Xb1Qpb
         043g==
X-Forwarded-Encrypted: i=1; AJvYcCUdHSI4t5qAPkUkSt/NAoOjLEC48MIyPprZiW8cajI8xfBKMzTQaRCdxdtiTMkeOiE+uAZy98hnVZG+Y0qC4Cfs9/5f8WQxycxeO2yfX2TeSIW31AJnzdj8G60J7LbI61FXbMT5U2WlyHsXoPs=
X-Gm-Message-State: AOJu0Yz9/cVo7p5ZZ6LaHENfr60o3dyDC4NJ+jphVCZtcChNkaJ0WB5m
	HzxxXqfpyjgfyS8mXavRyB1UYKwa6RD4TCkr18VpduLGgk6P4kdzLwkH9p1uWAJJM6rWNtSt80n
	kjSDvFHuylKCZ4HW4b6z6Mh224AY5P5narOI=
X-Google-Smtp-Source: AGHT+IFM75Q0UYOfkt/JWWJr5xbaRnUqXhELyh/yVh5b9WH/gScbqBHprTokVyTXg+Vo+LGlfs2XxuitCEBnJNd6Mzs=
X-Received: by 2002:a05:622a:44f:b0:42e:fa5e:be22 with SMTP id
 o15-20020a05622a044f00b0042efa5ebe22mr2586175qtx.6.1709832706616; Thu, 07 Mar
 2024 09:31:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307110217.203064-1-mszeredi@redhat.com> <20240307110217.203064-3-mszeredi@redhat.com>
 <CAOQ4uxh9sKB0XyKwzDt74MtaVcBGbZhVJMLZ3fyDTY-TUQo7VA@mail.gmail.com>
 <CAJfpegsQrwuG7Cm=1WaMChUg_ZtBE9eK-jK1m_69THZEG3JkBQ@mail.gmail.com> <CAJfpegv8RyP_FaCWGZPkhQoEV2_WcM0_z5gwb=mVELNcExY5zQ@mail.gmail.com>
In-Reply-To: <CAJfpegv8RyP_FaCWGZPkhQoEV2_WcM0_z5gwb=mVELNcExY5zQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 7 Mar 2024 19:31:35 +0200
Message-ID: <CAOQ4uxj9=FRnN-qiXdt5PFp15Nx9Jfqx3+8_eSSGy_xgHQ0tHA@mail.gmail.com>
Subject: Re: [PATCH 3/4] ovl: only lock readdir for accessing the cache
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 6:13=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Thu, 7 Mar 2024 at 15:09, Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Thu, 7 Mar 2024 at 14:11, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > > P.S. A guard for ovl_inode_lock() would have been useful in this patc=
h set,
> > > but it's up to you if you want to define one and use it.
>
> I like the concept of guards, though documentation and examples are
> lacking and the API is not trivial to understand at first sight.
>
> For overlayfs I'd start with ovl_override_creds(), since that is used
> much more extensively than ovl_inode_lock().
>

OK. let's wait for this to land first:
https://lore.kernel.org/linux-unionfs/20240216051640.197378-1-vinicius.gome=
s@intel.com/

As I wrote in the review of v2,
I'd rather that Christian will review and pick up the non-overlayfs bits,
which head suggested and only after that will I review the overlayfs
patch.

Thanks,
Amir.


Return-Path: <linux-fsdevel+bounces-56794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8545B1BB7F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 22:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9782918A54CF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 20:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0242723CEF8;
	Tue,  5 Aug 2025 20:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duTgxzWR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7577205513
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Aug 2025 20:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754426422; cv=none; b=fwGJVOU96vYOG29wdbYYhxMSCUFcnImOEKhILJMZJEvwOgmDRFMpprldZjMPKipzjn41nEFLeFuXG/28QVE9LkU2Sz6sIO8fDgDTdVowaVuYMqjCIIbOxf3I7QE2yH/Ga1RwcslKm/TbjO7RPhth8BbZfREEucqWb+Ox+ilkJ9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754426422; c=relaxed/simple;
	bh=MzsBbAuZA2184Y0iHgUjknnCoD7xub2N3uEQ11rs11A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KX4j0mZZSmkGRQ7yFTCn3hx5qSjHTQMZ4xf5woPDUgCkaIFtQva4oXMUSTFEPPf9TPddigHCJxD5IB7CLpvEi77meHCW2NTIsRXtwo1US9KZZEWNBE/s/vITo96LGcTUlrNL7TWJT0s9O0IEz4gnIjfayGybucCUoBSXaTxOZws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duTgxzWR; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b07d2136c0so17629471cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Aug 2025 13:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754426418; x=1755031218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RK6bTW81ML7Zv386ymigwbnfEBJk3wOa9YfMAjAhqwc=;
        b=duTgxzWRzvbtJIGUy4s5XwV4SXV4HLYfPw/A++ehWtzBG4EZ27mcz+j07B3VH7AToC
         FynBrn3Q/D+Qoa2de2l480zhC4vWrCgsNMr9pievFFX7YiSvAPvQn2o9omjjHswxJ7Gu
         hapOVU5TvYpssXbJ6XhpB0QarXM+2Ig2dZK44mpM9wMdHs6U34VNKW9p6XWNVq3/F7JW
         U4w8MfZ3XP4YU+mMUh2cSKLP/sGaLWe3qpB5hbYeb5qLFm4KZvhWCf1qSQmq+JDuUGg0
         KlnWu83psYzgsHd1xANy9yoeOc59lrHCJ596rxhenieXJhW86lj0akgJ1QH2tTL5gC4k
         HTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754426418; x=1755031218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RK6bTW81ML7Zv386ymigwbnfEBJk3wOa9YfMAjAhqwc=;
        b=ZsMA3KfuIPvnf+Yb1v050ydDJGgHuCnvIs2BTyMsTgKb2lt5QWUjWRd9ZZim5iIfRD
         1Cs2ESh7theOBaD1LtiGRdQig+IAoLOCtVqMjd7OxfYxClnxnUmM/rODmM3eGhbpRmCP
         s2MycTfg3PWVSarDXucfMkKnnaBc1Iehmz4FBHASnKzkvjoXIcCGQPPFDSr/iXHMoE1h
         00SG4JtQ4CGl0PrN6Lgp6ZrC/sXvQy++0tG1LZKJ4QZJ3vMMEKKBmDt3Ixxbrt/kfYir
         XVTH+/kbAsemtz/+9zoK9jBdGsuiO/47LHkf1CuXs47Fu4/BeV7gc87+A8LwSGncfsCO
         vv1A==
X-Forwarded-Encrypted: i=1; AJvYcCV7ZZ/ua/ZuYEMk9AuRAZeG7fzFRw/nlU4+JPULj8pvrWgTH+4AGf2jTvXCP/lMFgUh3Kn9mC5Q7bfX4j7F@vger.kernel.org
X-Gm-Message-State: AOJu0YxdAc1i90yyQmPZexNYnmdZklVl2Lf4rMdxPOu3iXoPRdgg912q
	Nzq7M3vcvIts9a/SOnmfGzpBCHKu857pdTRi3mW2fmuJY/NO+jdKbqItWLPm4rmabNJY8W1pXq7
	6RS9NaNjt8CA/29d3rjo6nu+KfQOlB8g=
X-Gm-Gg: ASbGncvVmfh4a+5hpqjjWfi50EbMyYSL4Q4uh65QvPa9EBQD4QpwmyfGCf9Tc1wwraz
	bM34AQdjgmXHAv/oMexaXH88lqAgp7E8TDW8tJ6oNbB556Q2M6zh6t5p5SSI540l7Adtj1DXXo5
	H8F2MqVf9JvGnH1ntcOeGwgW42d29A7C2Hw2EvEWlwatYtbOzbzNu7fYkhG9Q7emYXPWkmgbA26
	zpz+NHsvx0K6AwGRw==
X-Google-Smtp-Source: AGHT+IGIRh/dmwq4GP6YWoQfDWeVVN8Ym/rZ2XcHbJ8aNxR8JgHiZTv/H9uLertiUFx4c5OKDLq0ZpIkFLS3Mch3Viw=
X-Received: by 2002:a05:622a:5817:b0:4b0:89c2:68fe with SMTP id
 d75a77b69052e-4b0915a068fmr5063271cf.52.1754426418417; Tue, 05 Aug 2025
 13:40:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804210743.1239373-1-joannelkoong@gmail.com>
 <20250804210743.1239373-2-joannelkoong@gmail.com> <CAJfpegsH6TEQO_Cbj5Tc7z_dYTfnE42rpi13HrfA0WbRmWs-=A@mail.gmail.com>
In-Reply-To: <CAJfpegsH6TEQO_Cbj5Tc7z_dYTfnE42rpi13HrfA0WbRmWs-=A@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 5 Aug 2025 13:40:07 -0700
X-Gm-Features: Ac12FXxDAyLJV25dGL53zDTyuzJ5vPn02hD4qBM3QRzIrMisx8foMECoiNReNRY
Message-ID: <CAJnrk1behiRy1fx-5XOgRROyomSuR5goFU92VYekDcJdi6Actw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] fuse: disallow dynamic inode blksize changes
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: djwong@kernel.org, willy@infradead.org, linux-fsdevel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 10:11=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Mon, 4 Aug 2025 at 23:10, Joanne Koong <joannelkoong@gmail.com> wrote:
> >
> > With fuse using iomap, which relies on inode->i_blkbits for its interna=
l
> > bitmap tracking, disallow fuse servers from dynamically changing the
> > inode blocksize.
> >
> > "attr->blksize =3D sx->blksize;" is retained in fuse_statx_to_attr() so
> > that any attempts by the server to change the blksize through the statx
> > reply is surfaced to dmesg.
>
> I expect no big breakage, but I'm quite sure that message will scare
> some people for no good reason.  I'd just keep a copy of attr->blksize
> in fuse_inode and present that in stx_blksize, while keeping the
> internal i_blkbits consistent.
>
> Thoughts?

That sounds great and will make things simpler. We don't need the 2nd
patch then, I'll drop that in v2.

Thanks,
Joanne
>
> Thanks,
> Miklos


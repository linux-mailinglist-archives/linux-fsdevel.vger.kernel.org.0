Return-Path: <linux-fsdevel+bounces-42165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DAAA3D926
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 12:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B26316E4B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 11:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B641F3BBE;
	Thu, 20 Feb 2025 11:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="YKSvO71W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14AA1C5D46
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 11:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740052082; cv=none; b=Ol6i6JlZQ/F4uEGRQDC5Ox6nfjMTXhcCUk83k35euJoUnWdydgNaXDOTI2kHfegELz2osSRwYLcaZx8Kz/lHUaG+FYUKhF8cvAz/BtRCHgk/HSK/SgErC9aENPEFdR/zRTVRQvF7NSFAZ/zJC22D6GnLlUPGI2CEtvYHLE9/POE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740052082; c=relaxed/simple;
	bh=WXq+Jj8SEtR0/DLSCI6IOQR/O+eIDl3d4ZbRZYyyIoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYxEEyCHf1m11Xim2jHtUmWgRs2Q6AC5AW3PfxM4J1NxK4ou7cYdc7s61tBgC7Pzh+JWdas8tww3nBMLUjOMHuyTAFuNH7mr91/rumHS52Avf4JA7NHV85ZvGi5bSwvpRSkVeG4Q+lmEm3+K1/Aj/9wE9IVjotVoSg6R/R8biB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=YKSvO71W; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-47200236004so7910041cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 03:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1740052079; x=1740656879; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AGyW4+IGybtOjBy9S4JymfuhxILTLfbP5BoEcQmGNgs=;
        b=YKSvO71WOieiXS00AhRHh7AZpSmyvx6iYQFZWeR0/RI+PhlZ5NZYnR4qgQNjhen1PD
         dFeICHZh9vtqmmDMRiuUPm+50uZaz6ZYi20+nut7ozV2/VLv1WU4lqH9a/fOcDiaG73S
         Xn84LlyCmui83l1Wnl6Yjx59KUrW21NfsSVuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740052079; x=1740656879;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AGyW4+IGybtOjBy9S4JymfuhxILTLfbP5BoEcQmGNgs=;
        b=lZdUuZ/ZXemPfaLBjWbHSfYnefX5l2n9Ll92JDTR70/uSXiTu3hS5t/k84sWk5ldYJ
         wW2e3yOPK/B6ipJclXF09I9OZcUfpo7PhkxVR0ee0SnYgVprUblNnAstj6tOp360QSuK
         Z++G2DzbWWCHheQxpjdNFmqhRmOq3RyxHwoSgw1rzOrKlBoOYUQJG2NDa8++PmTFySXz
         FBQMsAtRclUZtpbyK0aXKO3KfU7tyAXSEfDmwqs2D7uGVimpNxiQxeeu6y6b+y60EU/5
         a/OdFP6yrvR6gRsjMz2obYwbWgPE7dvyyDC+mDEvb3LNJGnV4PrgwKjm1T428cRQ7pt3
         jgWg==
X-Forwarded-Encrypted: i=1; AJvYcCUtdieje6UoSUiU3FZnDNI41+meC8zPdIl1x6MBBoO+vEQEywCJhVIIcfCyKJ2qUP6T/mYKufYTHl7s8Hzc@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgkgq5liN7TUxoxgI63WLcfF/Y4YFGdBKsGPWH4yUrC8Zs6KBa
	Y1xPHDMRKoqsFIu7SUNGOQbcc3YXSHJ7tOkN2HXtUTjYvxOwLygJhB131SuD90aVqCorj5ISNpQ
	Ylqp5mAb0ihqrKNwhjR6x1bs1kk3lkMperU2Yhw==
X-Gm-Gg: ASbGncvwMypnr3Ll7Ba1T4dkLWrQNYUJsn91VGUX+Bazu6CLaSmwI5hz3wkfUJB0246
	VUrOxvWSuVktngp8deEMV43PmLHdBoF0RiGFwT/pOl8pYEQsrGHO31iLa0NNIbpQUnTjZNFI=
X-Google-Smtp-Source: AGHT+IEEUN4R9fKWBZymDt8UNj6qukJfOYSMz+MWNK6wyLIoEDu9qoqn5XEjm4J60jfT1MUo6VNbj2K4NvRsP0wu+Ew=
X-Received: by 2002:ac8:5907:0:b0:471:d7ca:fdea with SMTP id
 d75a77b69052e-4720824f542mr82027751cf.17.1740052079613; Thu, 20 Feb 2025
 03:47:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210194512.417339-1-mszeredi@redhat.com> <20250210194512.417339-3-mszeredi@redhat.com>
 <CAOQ4uxiqis6kawuv4pa6jxHYgpQPc18izFP8e0TORfA_mVu_-w@mail.gmail.com>
 <CAJfpegt=PWs8ZDF11p3nOCWHbWescE5nwVtUt82f=B6B+S0Miw@mail.gmail.com>
 <CAOQ4uxiQQV_O1MJgTksKycBjJ6Bneqc=CQbUoghvXc=8KEEsMg@mail.gmail.com>
 <CAJfpegsuN+C4YiA9PAuY3+-BJ959aSAaXTYBwKNCjEnhXVw0pg@mail.gmail.com>
 <CAOQ4uxjkBQP=x6+2YPYw4pCfaNy0=x48McLCMPJdEJYEb85f-A@mail.gmail.com>
 <CAJfpegvUdaCeBcPPc_Qe6vK4ELz7NXWCxuDcVHLpbzZJazXsqA@mail.gmail.com>
 <87a5ahdjrd.fsf@redhat.com> <CAJfpeguv2+bRiatynX2wzJTjWpUYY5AS897-Tc4EBZZXq976qQ@mail.gmail.com>
 <875xl4etgk.fsf@redhat.com>
In-Reply-To: <875xl4etgk.fsf@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 20 Feb 2025 12:47:48 +0100
X-Gm-Features: AWEUYZljegu2r6Cq-vMZ4L0kpfGY77npnhmceWtF4ejmKjccQxNm9UyMG-vC4mM
Message-ID: <CAJfpeguhVYAp5aKeKDXDwip-Z0hc=3W4t=TMLr+-cbEUODf2vA@mail.gmail.com>
Subject: Re: [PATCH 3/5] ovl: make redirect/metacopy rejection consistent
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <mszeredi@redhat.com>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Larsson <alexl@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Feb 2025 at 12:39, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> writes:
>
> > On Thu, 20 Feb 2025 at 10:54, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
> >>
> >> Miklos Szeredi <miklos@szeredi.hu> writes:
> >>
> >> > On Tue, 11 Feb 2025 at 16:52, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> >> >> The short version - for lazy data lookup we store the lowerdata
> >> >> redirect absolute path in the ovl entry stack, but we do not store
> >> >> the verity digest, we just store OVL_HAS_DIGEST inode flag if there
> >> >> is a digest in metacopy xattr.
> >> >>
> >> >> If we store the digest from lookup time in ovl entry stack, your changes
> >> >> may be easier.
> >> >
> >> > Sorry, I can't wrap my head around this issue.  Cc-ing Giuseppe.
> >
> > Giuseppe, can you describe what should happen when verity is enabled
> > and a file on a composefs setup is copied up?
>
> we don't care much about this case since the composefs metadata is in
> the EROFS file system.  Once copied up it is fine to discard this
> information.  Adding Alex to the discussion as he might have a different
> opinion/use case in mind.

Okay.

Amir, do I understand correctly that your worry is that after copy-up
verity digest is still being used?  If that's the case, we just need
to make sure that OVL_HAS_DIGEST is cleared on copy-up?

Or am I still misunderstanding this completely?

> >> >> Right. So I guess we only need to disallow uppermetacopy from
> >> >> index when metacoy=off.
> >>
> >> is that be safe from a user namespace?
> >
> > You mean disallowing uppermetacopy?  It's obviously safer than allowing it, no?
>
> sorry I read th "only need" as "loosening the conditions when
> uppermetacopy is allowed"; so I was asking if there are cases when
> uppermetacopy is considered safe in a user namespace (if there are any).
> If that is not the case, please ignore my question.

Yeah, that "only" was referring to my stupid idea, I guess.

Thanks,
Miklos


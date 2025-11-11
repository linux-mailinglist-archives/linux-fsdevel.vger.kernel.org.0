Return-Path: <linux-fsdevel+bounces-67975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7736C4F5A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 19:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43D4418C2B50
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 18:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB463A5E9C;
	Tue, 11 Nov 2025 18:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5/KQwCr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CC227703E
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 18:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762884015; cv=none; b=TyGubgQboxaicXlxASryMvLl149xEi5GZOV+AFUcvMD2OxJG6PHhmguEPIsyeHgJpgwyAh38xDKBYja4cp7EsPpEyeHfKRIFqIn3RsWhsdZjfnl75ZipufrprzA+37+zCuxsbBmgU8O9vTGgmpeaMnQ9DGvI2DFE7NAZgDanGUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762884015; c=relaxed/simple;
	bh=dXCcz2L4q31xz9e5q2d/z2JUmJTdawzaCmsByQjKrds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RKjbKIgfer8zVzwVFEa2PUglW3oollwrzH4utzshkrbzAWdNzaLoopfWezwTfuppfQm0EBtf/AAXjopxnHOI4wM2epe/coL+f5BwBjRKLGCi+/HR6huLbEPZViaAMD4VBLnSACYJq6FEIFgtCd9/maZIxVBi8Y4RNNQjHch5AQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5/KQwCr; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8b272a4ca78so6739085a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 10:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762884013; x=1763488813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4KxRP4BPLYg7Tcb5XFgRONVcpYRfVdnfnI154y4Yq/E=;
        b=E5/KQwCrp+LobwJ4940nqDSGyrkMndrBIKCUM0t1AbNW2tj0mECnWzQNj14vSAE297
         jv+8dTLD7KM0oGZDwQQex4fq/Hxp7a7JdQEGvp73XwRdnzqBBo62PImvDMMq703K3OP8
         uux0vJIs8Vkh8UtyRZ4QiMCXXh8pjUfkp33t59HVKbWyCGe0YA3ywHW9jM5tSdrJAIXQ
         zFc8Dpw8Ofbdayzp4sCvqLfY2y1p/FRUhw+VP77xrv1A22ikPAEHoR89buVcDlLH+MvM
         4Sdaiw/dewUDp3gWSHzKMbey6vpcqXjgFFSmIHgF9RpqtlHuYFqBLm5H40QRgGsXm/PQ
         Xb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762884013; x=1763488813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4KxRP4BPLYg7Tcb5XFgRONVcpYRfVdnfnI154y4Yq/E=;
        b=cLYYYBHUGELhdyyiv4sC1GXflZJLuHwc2446whNrXEWgyzXok5k8FS3lS+ZZjtENCZ
         J8O6A16c0avbMCz4Ugks5VMgF2J64beJ6pm4GkdsrLRvGJxjuFzjCxUNQoOMMwG1aTfs
         KjQCwkApTfaGhnKWs/LAsUzh1HPVWI34jZEu7OA+jAfRvIa5p7PyEOZ6yzSr6NJ51mHQ
         JWiwtLHy9FZYb/Flgu8ejIjp8zUAu7l4kvTZwSrVGPA+VKwpS0F0bdp1y1r2Sp+hVhpI
         fwCeEW2X6daLwySmr6zBF8QemczpqJkZXZIiWp+T4aFkz6JDZVWdbRpMZsbFtAfw0Myj
         saxg==
X-Gm-Message-State: AOJu0YxigdqG+zwoT9v66/KB+G5E+jvuPsFxvYYxi/5rgm4MZlRCCmrB
	kTtlZBSjb/RKrHag9qqlGW+7MxyRywpkIwDdqGtwxHulfXpRKzqX9lnv4YyG80C6HcxgW6IFrVJ
	FsoqMS8JjhBbBGHIMXMk+NRj9WN5OWMk=
X-Gm-Gg: ASbGncubk9eSXLHd24LQQqByFg2L0ZuvSTE15785PeAMhkYBW1poYc9KE8tb3A7VZMW
	GtdmdKkgBjKmoLomBrouJa+qMQWgYqJRCUZnFZNQELCYtBVgLef+S2+u8mxjGzfc14d3aB4gT0q
	ip15M+e/mmwANCWxl1dlhyLm3urTqhhverwe1CyeD12zwZJN+N1n80+N4AnMSibY4cI0JxUAjoe
	r6e9K7hFtWTQqSEVUeqJIQrdbUPQsfh4pKhf1aTe7+jY7DUIPJCd7sjjsDZ9Q3XuaKb8WDwsq5j
	NgKZjsi7Rx47iSzrxNtcRsyTeg==
X-Google-Smtp-Source: AGHT+IFLq0Lki7jHlkNoIxYgbT6xqtNZap/JJ68GL0AjhoJshZE9QMAIwE01KqPdAocx5GY5AONDAufa+H/OPmUsVJs=
X-Received: by 2002:a05:620a:4693:b0:8a2:e35f:90 with SMTP id
 af79cd13be357-8b29b7687damr16285185a.30.1762884012467; Tue, 11 Nov 2025
 10:00:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010220738.3674538-1-joannelkoong@gmail.com>
 <20251010220738.3674538-2-joannelkoong@gmail.com> <CAJfpegtCiEGxnnvQE=6K_otzhCkB4+SVLV74_nP4Oj4S_yeKPw@mail.gmail.com>
In-Reply-To: <CAJfpegtCiEGxnnvQE=6K_otzhCkB4+SVLV74_nP4Oj4S_yeKPw@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 11 Nov 2025 10:00:01 -0800
X-Gm-Features: AWmQ_blP5IEHZXanvkZ8IXnlaNvJ9844PhLdQ0zdI5WqxQKyJUCDIsWPG6XziKw
Message-ID: <CAJnrk1Z859dq=Yx_Q2PLTcemNJrDCgV9h=4hFEde793jDwA3Sw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] fuse: fix readahead reclaim deadlock
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, osandov@fb.com, 
	hsiangkao@linux.alibaba.com, kernel-team@meta.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 7:08=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Sat, 11 Oct 2025 at 00:08, Joanne Koong <joannelkoong@gmail.com> wrote=
:
>
> > @@ -110,7 +110,9 @@ static void fuse_file_put(struct fuse_file *ff, boo=
l sync)
> >                         fuse_file_io_release(ff, ra->inode);
> >
> >                 if (!args) {
> > -                       /* Do nothing when server does not implement 'o=
pen' */
> > +                       /* Do nothing when server does not implement 'o=
pendir' */
> > +               } else if (!isdir && ff->fm->fc->no_open) {
>
> How about (args->opcode =3D=3D FUSE_RELEASE && ff->fm->fc->no_open) inste=
ad?
>
> I think it's more readable here and also removes the need for multiple
> bool args, which can confusing.
>
> No need to resend if you agree, I'll apply with this change.

That's a great idea. I agree, using args->opcode =3D=3D FUSE_RELEASE is
much better.

Thanks,
Joanne
>
> Thanks,
> Miklos


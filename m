Return-Path: <linux-fsdevel+bounces-51784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 558F6ADB4CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 17:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 474D33A1172
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 15:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E4D1EA7E1;
	Mon, 16 Jun 2025 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l15Dv5pG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2354E8488;
	Mon, 16 Jun 2025 15:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750086130; cv=none; b=Ar9X/CTsQQhuDx1n28nZx+2rQ9tSdLXm7lC+KCqac3DPEpvE2P7ed2G6c7zV/opdL7feVMA9i5/r1+WHJin/4Nrx/pezNroTWQj/OHZ0BVt2ciyNq2S3uZ8mbtw1oo5j7HG7p/a8hmrBoI66LuEywN5bcdta25OLAzGlz4lG38w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750086130; c=relaxed/simple;
	bh=4lgjXfDP77fyC+bN07w7nhIhbJAVycmtLYGq17iMks4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eGSzXJfiX83vrDcrkIq75M/s3zjXqjC6pN6ZINnrtcFNcSTtpVfKxA57XJjevbc9mxZviynuTDn80hc+asVB3m/5IPkXOt9VZZB0hMICaJh+O89kvPkxAuUL6kLKShlZzB3mg561+Gq76kk2IxInopDN+B4F3sBKmaycd9wj/qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l15Dv5pG; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ad88d77314bso1025187166b.1;
        Mon, 16 Jun 2025 08:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750086127; x=1750690927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4lgjXfDP77fyC+bN07w7nhIhbJAVycmtLYGq17iMks4=;
        b=l15Dv5pGGrsgoBzjupigRz0UF8rpoH9twcnedB4/9bhM8PRM9A2U3ParL7eJ2H8KqR
         qqw6wQv60j4x607JoZTkXEE4WHPoC/f/VwPxHjYxx+/Fs5ELsd/LMJB3qCo1owJ9BLl3
         u/VA7svYeyZLEm3jSwJ8rneRmKeCXEyGIt/lfcsszIwsLadoQbUQ5vel3Sv2VxF0INgT
         MQTWw1Hc5/F+upgDXRQohjHl/5ibR0aVzBdNo+W7jGQaiGc0grwszp82r4gDv2WcqTwk
         pU8d4uum/XrNTeVTCEXPGlocVrxrTVYZttKiC5UjSct19lsi8cHovj1rJao3j9/SpvVg
         sUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750086127; x=1750690927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4lgjXfDP77fyC+bN07w7nhIhbJAVycmtLYGq17iMks4=;
        b=iZaoump0+62LivHf0sCTGULTPqNDTwK2V+SuiIL1RbDU4UzFSgdX/9fU1+2zbIh3xv
         luweFZ0cVZ6Z4c0obQvnYxpSQKdd0cpe2wDHmIQrGIo01jz29XMpe7HuqGP47g7epklq
         S2kkI6aDIGc0fhlOGn5xUjf1BKojMm0rHDQqV0IdRM5troGkogYLb1SMcp6wGHgE9rlv
         +5TRAExIXf+lZymzkJ/XBGYy8a1TlfCXNVxb38++bwacdcxqQ/6g0GsuubS18rZ00F6c
         BhEH2D30SQR4ZR7NEWv2CEGYH2zNyJy3ab7LU15lqfMaZj1dAtfiM/bK/jvbRmsVN0Mi
         pYuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTtQGNt7wmfvczcNrptDljYawdXHR5gvZPWtyd4h1Ie8GKANc+JbPBcVoJgVax2xf8T1uCvVEW8ZFtrQNXWQ==@vger.kernel.org, AJvYcCVyhp6q+epH3RY7ngoQfgZv5PdPIHWJCOddhQMGf6CUTPIFyzt4mJiEpX91ykW4blTbwc6+jFTFqnBr9xJw@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3zI618dbFlzMJ6O5riD9qGtY25Szoja/ZLrL1FKa9gwMoTTOA
	2l+9HJmutet3HoqpDGF09HbTAuKyFD7kQjTb7iOzgjHFuKS/p5NfzRjBJLCwz4We5XaaDVDUZjC
	uUEkvTy5vRcoAsA1YVWujWPeg//epdlgoUiBYs30=
X-Gm-Gg: ASbGnctepoLHH8EnR1+BBYEefxEsBMetHBxkJFjbMKIMSRGqT9ZzZ3f/c90IN7iblnZ
	U146DowYcc2Si8VLciXvULAE+6TaDhb+myvnGewcOHXywBfEP33iRuqyC/W9Ha+UuuQEKOTtat3
	29BTQjm0CI6HmQ1Wu/FKCbWv1WqzQQvEmNIGUbEpKSNT0=
X-Google-Smtp-Source: AGHT+IGUva/HWdOi901kFKzbrfQFMCLT6Oq3dDq2eUZY8/wv86Yk4iG+J9oZrubJ3+kEuTjx/JmAlsZb0SSYN1mG1+M=
X-Received: by 2002:a17:907:9809:b0:ad8:a4a8:102c with SMTP id
 a640c23a62f3a-adfad368010mr890476066b.11.1750086126038; Mon, 16 Jun 2025
 08:02:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602171702.1941891-1-amir73il@gmail.com> <oxmvu3v6a3r4ca26b4dhsx45vuulltbke742zna3rrinxc7qxb@kinu65dlrv3f>
 <CAOQ4uxicRiha+EV+Fv9iAbWqBJzqarZhCa3OjuTr93NpT+wW-Q@mail.gmail.com>
 <bc6tvlur6wdeseynuk3wqjlcuv6fwirr4xezofmjlcptk24fhp@w4lzoxf4embt>
 <CAOQ4uxiYU_a_rmS9DBOaMizSFVsbiDQBRcf4-f=8hmL-TGbwxQ@mail.gmail.com> <4lxkp7nfw3dvql7ouqnsfj7hbvzpp32wezamt5b4b56keatc2g@butdqkurvmif>
In-Reply-To: <4lxkp7nfw3dvql7ouqnsfj7hbvzpp32wezamt5b4b56keatc2g@butdqkurvmif>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 16 Jun 2025 17:01:54 +0200
X-Gm-Features: AX0GCFuoHLwz52HeOoAT3F4-ksrcM-fXZJxfbG0Vh2Jtx-XWUe-PXYvex2saeKE
Message-ID: <CAOQ4uxgvOXYyUZXn9s-AtGeQmJm=6eAwFGW4kxyDpDUr4uPUhw@mail.gmail.com>
Subject: Re: [PATCH v3] ovl: support layers on case-folding capable filesystems
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 2:54=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Mon, Jun 16, 2025 at 02:36:35PM +0200, Amir Goldstein wrote:
> > On Mon, Jun 16, 2025 at 2:28=E2=80=AFPM Kent Overstreet
> > <kent.overstreet@linux.dev> wrote:
> > >
> > > On Mon, Jun 16, 2025 at 10:06:32AM +0200, Amir Goldstein wrote:
> > > > On Sun, Jun 15, 2025 at 9:20=E2=80=AFPM Kent Overstreet
> > > > <kent.overstreet@linux.dev> wrote:
> > > > > Where are we at with getting this in? I've got users who keep ask=
ing, so
> > > > > hoping we can get it backported to 6.15
> > > >
> > > > I'm planning to queue this for 6.17, but hoping to get an ACK from =
Miklos first.
> > >
> > > This is a regression for bcachefs users, why isn't it being considere=
d for
> > > 6.16?
> >
> > This is an ovl behavior change on fs like ext4 regardless of bcachefs.
> > This change of behavior, which is desired for your users, could expose =
other
> > users to other regressions.
>
> Regressions, like?
>
> The behavioral change is only for casess that were an error before, so
> we should only be concerned about regressions if we think there might be
> a bug in your patch,

Exactly my concern.
Before the change, it was not possible to have a casefolded dentry
in the overlay stack.
Now it is very much possible.
We detect it and report an error in some lookup cases, but not in all of th=
em.
For example in ovl_lower_positive().
Does it matter? Can it cause harm? I hope not, but not sure.

> and I think it's simple enough that we don't need to be concerned about t=
hat.

Yes. famous last words.
I will let Miklos be the judge of that.

Thanks,
Amir.


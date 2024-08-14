Return-Path: <linux-fsdevel+bounces-25879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A91F19513EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 07:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F6E91F250EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 05:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508F554720;
	Wed, 14 Aug 2024 05:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9k59Uqs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B0E10953;
	Wed, 14 Aug 2024 05:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723613686; cv=none; b=n/0kdUrGManPdOeM7id6j1QpuU22udnH1z/1otfX0v7oy1+q7zEGaUo0tjoPWHWIR3xtkzb08mGW2QjmN/ueGjwwgQIkU1bp4KSYX65c0OCpVulyln1MYZIfK7M0HORb04Z3Sk0LKrgc4DIoJNBzmgW7KB7K1QSbrKu4q8GA2nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723613686; c=relaxed/simple;
	bh=a+oH29lRdI7crXE0cpk9MRBl+dxUEEErbE4XgjMV8HE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WUAULKySyOUTtgJCZHXDA/S5UDDZPL43++fBmbrgkF3f0kMt2K3Ca37tCGWDHYnddlWOJk9yupEsRXkZqFOUnlhUXQe8D/7UsiNWTJoZW7s5ikN2erZiLlD543Z9HY2TxJ2Q4whAI/rGtMdtI5YFeM2XaJu4YafaU0qX35wTyac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9k59Uqs; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7a9a7af0d0so699325166b.3;
        Tue, 13 Aug 2024 22:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723613683; x=1724218483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+oH29lRdI7crXE0cpk9MRBl+dxUEEErbE4XgjMV8HE=;
        b=V9k59Uqs4uuVQB7VvJFll3Sg3aLr5K2+bxRPoEEMtODYG67Uy/TP+8c9Lg+kzWcHJP
         B5C3MeoNVDcAWdO1dy6yr19RDwkRhuv2lIeglHmxgaxLmwji+yAWuItgD87tWCsc3bgc
         NXiLm1YZnZqMdHh2c/2XftUJT8d4SI6hcyfVAI4bw0vtVKc/mlBNFyf2X2q6W5jJmnkI
         WI9Oueq9QfOz53mKGLPGwwkbn0gHEsSTWizhf4CKmN28iAiwwwlWGSQd+O+rQKVfR2QP
         p2SNMKEzRmGQssFxOskljSJ3+mh8omAYQdjc+/ZYuCX8WP8VwpASpCWQhJyKiGJX8QCW
         SQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723613683; x=1724218483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+oH29lRdI7crXE0cpk9MRBl+dxUEEErbE4XgjMV8HE=;
        b=CbVVLq091IilWCj691gD/QOA61Z2FoGtkwGexqVqO0eyeklpWlPuTPvgIRmL8I6y2d
         Gj935+/lIh3Vjn0k9aMpb1EMaZHE55oCnX6UVvKCvAId2ar/sBi9kDGHDQPTFFSI06RF
         yIAlMTqOZAdXnSmHHuasbRmkEfqMJl7ZqbIDUpTYcFjajBzhd3PpmWXZOIeQlKIa2mXY
         7uGRJ0Wt16qU2JOsvYvfdmtRg93zC2Pbjx3GYgSGDBMYItP5o83gVhtrg5iFYSdowB16
         QxKUCKWdn4PTUB1LDm1bsYJz/XHa2aMsv7AV0K8FVfHmmxQDe/2b1RuT/r3XXXnj27gs
         unPA==
X-Forwarded-Encrypted: i=1; AJvYcCX+9UScgoZpmQPtm6Cto6c6GvfxfBtPPeLwIYAVXoR6cwkrbJVSnS/EREH+zUKZN3W8tD6ktjUW5H257q1UMzoh4UjxqWUCemOcDUfDQ/xhmLLe+VwFkH3j21g+DaRY4q1BGzARayhgkPpKqg==
X-Gm-Message-State: AOJu0YyyY1jj02I+AEq9I30z9SypYE1bhmjD1RwWKxXPriTf9dv+G3n0
	26bif4FwReaqKh9vuqqV6GhXKpX3jCmwOOEyiR5jCvG/rOcecp6sFhtMh4ttYB3JAF6DQ/fXLRw
	GX9uGPp/Ho1tT8RqBgYpSkoXfvKjIzoY8apU=
X-Google-Smtp-Source: AGHT+IH3VgdXYh6HVn/9fML6mBkauVagXt6paXq+xRbc4b+/BF5+dluodYQxmL5DjtINS5R3yWB+IHuUlcb8BIW+m+o=
X-Received: by 2002:a17:907:d2d3:b0:a7a:bd5a:1ec0 with SMTP id
 a640c23a62f3a-a8366d46ccamr101427666b.29.1723613682778; Tue, 13 Aug 2024
 22:34:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812064427.240190-3-viro@zeniv.linux.org.uk>
 <20240812075659.1399447-1-mjguzik@gmail.com> <20240814052420.GQ13701@ZenIV>
In-Reply-To: <20240814052420.GQ13701@ZenIV>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 14 Aug 2024 07:34:30 +0200
Message-ID: <CAGudoHHwzzL-hVrbKV05wkFedY8eWHsZToEHFu_odfysz21gWg@mail.gmail.com>
Subject: Re: [PATCH] close_files(): reimplement based on do_close_on_exec()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 7:24=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Mon, Aug 12, 2024 at 09:56:58AM +0200, Mateusz Guzik wrote:
> > While here take more advantage of the fact nobody should be messing wit=
h
> > the table anymore and don't clear the fd slot.
> >
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > ---
> >
> > how about this instead, I think it's a nicer clean up.
>
> > It's literally do_close_on_exec except locking and put fd are deleted.
>
> TBH, I don't see much benefit that way - if anything, you are doing
> a bunch of extra READ_ONCE() of the same thing (files->fdt), for no
> visible reason...

I claim the stock code avoidably implements traversal differently from
do_close_on_exec.

The fdt reload can be trivially lifted out of the loop, does not
affect what I was going for.

But now that you mention this can also be done in the do_close_on_exec
case -- the thread calling it is supposed to be the only consumer, so
fdt can't change.

that's my $0,03 here, I'm not going to further argue about it
--=20
Mateusz Guzik <mjguzik gmail.com>


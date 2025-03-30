Return-Path: <linux-fsdevel+bounces-45309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AF9A75C03
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 21:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41E963A93A5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 19:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCCB1DA0E0;
	Sun, 30 Mar 2025 19:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7vmFdOh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46488322E;
	Sun, 30 Mar 2025 19:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743364488; cv=none; b=sSjJgfkh2SUpVi1qpoUmBbxcKYLbjgDhlDLJnMoVW5zWIk4QRzwd/IG+ZYlAPcvnbftKNoZZmQYStc53kDfandB3MD5k5ZPdxq9nJR5vwfSoktVnqeDirzB4b6Ek1ag7E3pmdBDLgt/BJEIELg17ZU5/2DUDhgYm0w/FMoLyTkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743364488; c=relaxed/simple;
	bh=KObNXp8zdMOaTEjj8QkSztxvvIzXlSXmQcogYg/Vtug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iOZyrd8WvIs9zXAaTUmgYRJ74Ez0lGkN1ngk6V3ctjRRvZoGCDZbqCtcdz91HUprUzO2mognq8fjAfodQjRrEG4Z1SYUm5qGCR3CcWaNCojNOplsygfb6+2GmxA/zX6DNEZ2aLYZUSiAkWrUv9V2xNdPbY0BLrHNah0yP9iNxP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7vmFdOh; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac2a089fbbdso686321866b.1;
        Sun, 30 Mar 2025 12:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743364484; x=1743969284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qj/vhOVV+q0LP2RBtTT/ts00uxivKciEoZbRNV8Hpk=;
        b=V7vmFdOhvDlFe2M2K7nLRdJpNqr1Qz6wSVDTwGpS0W1LM8xt1N56tDnJeDgKaelphA
         yzQfxxfatZUkSX9tDKASW/FRXnBF4lHnU1tW+U0aVRme9h8x4Gf+H933mFgp4vVF0wcm
         bISEYg5MQUPmJ1Jwlh3UdS7dqiyZr12wZ3JsavFkrkQNHdSvJp3PaS7aag7OvSVsy0q2
         6vGRlro+CIZkOGeBrQB20h385SXgOVm1qD01leREByNkLz3EDzt2WAABZyHAo3/8i1at
         Sg7bvMTBADHiG458Lu6OU4S4eNYDdoIQ/H5uOfhzU33Yyc7BcmdSdli/DViXgJl/oB3E
         PPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743364484; x=1743969284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qj/vhOVV+q0LP2RBtTT/ts00uxivKciEoZbRNV8Hpk=;
        b=vUQJRnbuDp2I7kYKTg9Zes7gaaRCmY7X/zBEhiQyHfgqFKZ2ZzzPLbAJnqlIMF/UQe
         RoylV6T+/MsgApO7P/vc0HYxUW79a9jpnYqfrZuTsPCjdzO+4bDUsA3Ud6Jq/622IM5y
         tYbCsjs/JJxlpyPaUFRHIGkzB244bgvj8OCyKiOpccfqF5c5XWuPBQXonTBITf+ss61v
         1keSHDwPSIDvoFyYGggr2GxcjLmDKc420Se6oxyhVLw2bW/IFdYFXplPWGszg/lKlBmR
         KfvpmggvdMvlxltwpTdIopU5MckxPwY113c5sWpjXsebW9WnwkLHlUABUBO7dg0HcBn7
         kScA==
X-Forwarded-Encrypted: i=1; AJvYcCWznQxI0H0RaLQxA+fDvAhVxUBHXQ3BgQDKSUyqEC6uFr+/TUzfPzvW9J54w4fh/jxccn7MKLyNGibM@vger.kernel.org, AJvYcCXC+eeM5UFBR7B7rbphiexUsRwi4OabIhoNbQ/BkR4L4QyqYFzLhKbsnOl6HhjCbpE8hFQWIUJ7uMnXrDxb@vger.kernel.org
X-Gm-Message-State: AOJu0YzEOpFjaobhaRGvcxCnlEYVnQpfT5isWzTgSzw1i8YyJUmYGsMn
	w4JO6tGHzEEdxBSZEcAL8K2wryJg40RgIbFEfj88Gu2cHY+zcCz8hbzqJD9DAHYkNYuOwJYGdCU
	D9anJUy4opQOTIBHiihuV5VDJmo0=
X-Gm-Gg: ASbGnctOmysw7LZI+Bpp01EH6lRZB+Khio9SadGUCLHKH9svUatF2GQW/cxdFX3rnuF
	N6bRfzzEgSjaxZ/oE1amysdrlIU2NNgZoTupgzRGpB0EpuWiI0MGuFM7z47omThUq+5le/C/4BT
	q5uRDD2PDau1l7/QG7ZO1PNdPo8w==
X-Google-Smtp-Source: AGHT+IEnfP16myENWEhUHBYQqkLeNKhMDMWwfUWZYkZo0pWMJcibVI5VCXsFBA05x+d+cKavLbvdR97xaZ/+lJk3I+8=
X-Received: by 2002:a17:907:3daa:b0:ac3:b50c:c94d with SMTP id
 a640c23a62f3a-ac7369c0370mr561335666b.28.1743364484163; Sun, 30 Mar 2025
 12:54:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250330163502.1415011-1-amir73il@gmail.com> <mu6nhfyv77ptgvsvr6n23dc5if3sr6ymjmv3bq7bfnvcas66nu@b7nrofzezhil>
 <CAOQ4uxj48SHB+8m0r50YhdqYZB2964+aK=BxdoW_yuWzZUgzGw@mail.gmail.com> <esepirxum5w6k3au4fapm6sksjy6bl5ypapvy5rflmqw2g3cjv@iij2nzq7i3uk>
In-Reply-To: <esepirxum5w6k3au4fapm6sksjy6bl5ypapvy5rflmqw2g3cjv@iij2nzq7i3uk>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 30 Mar 2025 21:54:33 +0200
X-Gm-Features: AQ5f1JqxYMzLLqtm238rxGd3PAkukYPUIUt6CGV3GZypcQS5xkZtsmKz0xIu5BU
Message-ID: <CAOQ4uxiL0qUnvLT_J2PaSOwrgLaSDX8Qc2ASmQwpnJQT-gtYTw@mail.gmail.com>
Subject: Re: [PATCH v2] name_to_handle_at.2: Document the AT_HANDLE_CONNECTABLE
 flag
To: Alejandro Colomar <alx@kernel.org>
Cc: Alejandro Colomar <alx.manpages@gmail.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@poochiereds.net>, 
	Aleksa Sarai <cyphar@cyphar.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 30, 2025 at 9:21=E2=80=AFPM Alejandro Colomar <alx@kernel.org> =
wrote:
>
> Hi Amir,
>
> On Sun, Mar 30, 2025 at 09:17:51PM +0200, Amir Goldstein wrote:
> > On Sun, Mar 30, 2025 at 7:56=E2=80=AFPM Alejandro Colomar <alx@kernel.o=
rg> wrote:
> > >
> > > Hi Amir,
> > >
> > > On Sun, Mar 30, 2025 at 06:35:02PM +0200, Amir Goldstein wrote:
> > > > A flag since v6.13 to indicate that the requested file_handle is
> > > > intended to be used for open_by_handle_at(2) to obtain an open file
> > > > with a known path.
> > > >
> > > > Cc: Chuck Lever <chuck.lever@oracle.com>
> > > > Cc: Jeff Layton <jlayton@poochiereds.net>
> > > > Cc: Christian Brauner <brauner@kernel.org>
> > > > Cc: Jan Kara <jack@suse.cz>
> > > > Cc: Aleksa Sarai <cyphar@cyphar.com>
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > ---
> > > >
> > > > Alejandro,
> > > >
> > > > Addressed your comments from v1 and added missing documentation for
> > > > AT_HANDLE_MNT_ID_UNIQUE from v6.12.
> > >
> > > Please split AT_HANDLE_MNT_ID_UNIQUE into a separate patch, possibly =
in
> > > the same patch set.  Other than that, it LGTM.  Thanks!
> > >
> >
> > I pushed the separate patches to
> > https://github.com/amir73il/man-pages/commits/connectable-fh/
> >
> > Do you mind taking them from there?
> >
> > Most of the reviewers that I CC-ed would care about the text
> > of the man page and less about formatting and patch separation,
> > and I would rather not spam the reviewers more than have to,
> > but if you insist, I can post the patches.
>
> Could you please send with git-send-email(1) --suppress-cc=3Dall?
>
>

no problem.

Thanks,
Amir.


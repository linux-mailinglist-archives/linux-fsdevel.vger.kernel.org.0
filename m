Return-Path: <linux-fsdevel+bounces-58849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA25FB32174
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 19:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59BF91D62F79
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 17:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52704280A29;
	Fri, 22 Aug 2025 17:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dloSzF+R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0601F1A0BE0;
	Fri, 22 Aug 2025 17:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755883310; cv=none; b=t55ki9UT7Un6Sl1Ilftu7210micwXGa2bDJF4JuJFjY6iDsDmU9C9rTLxUTMNz2wtSwNEvjMp+/qFwBOuYPgoaGYcAhvUBf5QDHWx/BaIY7DJiHFr9ZN78iSTBhJa/asL1r/X6vTeQ7B1rN1+G9D9gVA8Od+pwgNQvDP4q0nG3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755883310; c=relaxed/simple;
	bh=UQVmH+W2b3VdbyYnjMav2xV0xKXp+0QKEtY33NRm3pM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GXxMFaIy9yRmsYHa1qvieGQfXd9FUK6L5A8jrE8WbijTdg2qvbS6Q3Rt23pQsONTqe7h4GAimN49erIfvyF1BlzHA5oM7JaOERC1Zkjujw6KFCl8Fp/FIVL4aneirpb4ms/fUGTPg7dFM6/B3ths/i3c/7pjj4C5uDBJtJyEjJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dloSzF+R; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb7af30a5so386172866b.3;
        Fri, 22 Aug 2025 10:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755883307; x=1756488107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgDuTNLynSXNTkQgfpkIz1Ab0tGbrgPIhu41LDy/Qgs=;
        b=dloSzF+RYkFReJw1TSBBfhxjvVzzl+JclxGwHkSCd55O128vbCwwhM+xH+9Zuf1ZF1
         1ji2SohYJWicV4I5kEvZithGYHviHBFIMvrCgUEcFBgHLJNN4fsHQ6MeiXIJcr2beNOR
         FPYHpSMq5AiMo5xz6dD3APDKTy0gPCrLHsv0uI41oet74H7sSOWF0vyhNO0GOGAmRmj2
         stmimSrrttJtMOe/SDtXupjhH6uXqwZV0j7tBN8sW/pJD8tBNWBVDGeR6QmyfEq+AnWp
         JljlIIpplkVZ24QoDFQar5CpMyNp9klK7p1EZ8kBNRZa1auAcn0j9QA31pJxVtBWjalf
         MYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755883307; x=1756488107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NgDuTNLynSXNTkQgfpkIz1Ab0tGbrgPIhu41LDy/Qgs=;
        b=ef8kPagSkIpU+wnnB+nqr+4iM6q8tJxvQhbKWHQ0zjU/QEoP0AsQ01ucMLEwtZSWZQ
         xHfiRX9eMTMLwGSBxmUZrWISFhZXtpHnk1S1MgusKW0bKfRH43qizDZYihfuI31VVnd1
         zmbiLmxxS70v1Ajy0iQi1cbNvAuF26squKZRKpxe9JwEerywjuboJU0j18hiaGYc7jqB
         F0ZqL6Ny0FORrxf8cakF1C0BfJ6tGV0j0EQhiiBCq39QAgb2LFpRXB0EcI21UBdYGiDn
         yJ6JzRNfNu7/Vkf5iOAF8zcPECrb3Bpi3mO8FvOp5eJjZerhM/MsQaxvEiCXxb8OlhHV
         l8ng==
X-Forwarded-Encrypted: i=1; AJvYcCUQuy5mF/kbESSVA/3cHSeuwAFs7sMtOtc/NsL04bhTGhh5QS7oJ0rgblGffht9rtbqfaJC+TxqepFhbqWP9Q==@vger.kernel.org, AJvYcCUmXHEwQDaTi6IxLYmJH1tnNh250hL5+A5PH97DhIFjYo+zi7nKsn/u02DnbjJIdW0s1nTs8icPhj63so3l@vger.kernel.org, AJvYcCXs53Ms3FTXZiKuFquR2OLhphnlkjP5z1j2sXpPOcnr8R9n+wjKk5Q3tqkeK3TOhgqRk0lmvXKc+412ZM42@vger.kernel.org
X-Gm-Message-State: AOJu0YzfOn4iKgWsijbDsJP6ptN503bU9Tcg1s63ZHc3Wxl/TSOup4ef
	VQHTtf54hieXUOZ0AQIRzi2QON3Lhsa4pQCkBozzYRqfdehrlPkmupxKCvV6NE+ZPDG2NX/VL6o
	JYAbLpUrGPERQOVVw4048zvyfZFC4LSuV1id0nq4=
X-Gm-Gg: ASbGncueu6T8hL13btYcEG0V24RHciGo4jvEn+XWXK7lWunMHU011X/x3cG04LUSpnI
	fii7gmNRv0RMUm5v2zi2DqNnA7fQOdIqeAx/SXM8txoddxO9Vk9ZoZO1Ply5stKbvxsi63b3oBi
	yK9zJaOGL3YdZg5wUDgK/dJrS+Sbm+kDNnfgo0FlQV6aItR9DNkR6onuMChi6CLnkdJdgpG0V4p
	O7ddJQ=
X-Google-Smtp-Source: AGHT+IFIPX+o5BtzIBMWnGiIi3/9pweFKAEQNA/aM2RgKA/e/9JlzGrNSwMeGUPGXgMjqLDzgsWPGJrm6bpifoek04w=
X-Received: by 2002:a17:907:3f29:b0:af9:3ed3:eda2 with SMTP id
 a640c23a62f3a-afe2963b02cmr333013866b.60.1755883307128; Fri, 22 Aug 2025
 10:21:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814-tonyk-overlayfs-v5-0-c5b80a909cbd@igalia.com>
 <cffb248a-87ce-434e-bd64-2c8112872a18@igalia.com> <CAOQ4uxiVFubhiC9Ftwt3kG=RoGSK7rBpPv5Z0GdZfk17dBO6YQ@mail.gmail.com>
 <e2238a17-3d0a-4c30-bc81-65c8c4da98e6@igalia.com> <CAOQ4uxgfKcey301gZRBHf=2YfWmNg5zkj7Bh+DwVwpztMR1uOg@mail.gmail.com>
 <CAOQ4uxjf6S7xX+LiMaxoz7Rg03jU1-4A4o3FZ_Hi8z6EyEc7PQ@mail.gmail.com> <5da6b0f4-2730-4783-9c57-c46c2d13e848@igalia.com>
In-Reply-To: <5da6b0f4-2730-4783-9c57-c46c2d13e848@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 22 Aug 2025 19:21:36 +0200
X-Gm-Features: Ac12FXzjdRE-FW95dgJeQZId-J94AmwhsO1uTKTsNjV-vzA_p72a4t3oR2NACBM
Message-ID: <CAOQ4uxiOYFf_qUZAwCZ2DO0qemUdAbOWyUD2+oqewVPGn2+0cw@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] ovl: Enable support for casefold layers
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	kernel-dev@igalia.com, Gabriel Krisman Bertazi <krisman@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 4:16=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@iga=
lia.com> wrote:
>
> Em 17/08/2025 12:03, Amir Goldstein escreveu:
> > On Fri, Aug 15, 2025 at 3:50=E2=80=AFPM Amir Goldstein <amir73il@gmail.=
com> wrote:
> >>
> >> On Fri, Aug 15, 2025 at 3:34=E2=80=AFPM Andr=C3=A9 Almeida <andrealmei=
d@igalia.com> wrote:
> >>>
> >>> Hi Amir,
> >>>
> >>> On 8/14/25 21:06, Amir Goldstein wrote:
> >>>> On Thu, Aug 14, 2025 at 7:30=E2=80=AFPM Andr=C3=A9 Almeida <andrealm=
eid@igalia.com> wrote:
> >>>>> Em 14/08/2025 14:22, Andr=C3=A9 Almeida escreveu:
> >>>>>> Hi all,
> >>>>>>
> >>>>>> We would like to support the usage of casefold layers with overlay=
fs to
> >>>>>> be used with container tools. This use case requires a simple setu=
p,
> >>>>>> where every layer will have the same encoding setting (i.e. Unicod=
e
> >>>>>> version and flags), using one upper and one lower layer.
> >>>>>>
> >>>>> Amir,
> >>>>>
> >>>>> I tried to run your xfstest for casefolded ovl[1] but I can see tha=
t it
> >>>>> still requires some work. I tried to fix some of the TODO's but I d=
idn't
> >>>>> managed to mkfs the base fs with casefold enabled...
> >>>> When you write mkfs the base fs, I suspect that you are running
> >>>> check -overlay or something.
> >>>>
> >>>> This is not how this test should be run.
> >>>> It should run as a normal test on ext4 or any other fs  that support=
s casefold.
> >>>>
> >>>> When you run check -g casefold, the generic test generic/556 will
> >>>> be run if the test fs supports casefold (e.g. ext4).
> >>>>
> >>>> The new added test belongs to the same group and should run
> >>>> if you run check -g casefold if the test fs supports casefold (e.g. =
ext4).
> >>>>
> >>> I see, I used `check -overlay` indeed, thanks!
> >>>
> >>
> >> Yeh that's a bit confusing I'll admit.
> >> It's an overlayfs test that "does not run on overlayfs"
> >> but requires extra overlayfs:
> >>
> >> _exclude_fs overlay
> >> _require_extra_fs overlay
> >>
> >> Because it does the overlayfs mount itself.
> >> That's the easiest way to test features (e.g. casefold) in basefs
> >>
> >
> > I tried to run the new test, which is able to mount an overlayfs
> > with layers with disabled casefolding with kernel 6.17-rc1.
> >
> > It does not even succeed in passing this simple test with
> > your patches, so something is clearly off.
>
> Apart from the other changes I had done for v6, I also had to change the
> test itself. The directories need to be empty to set the +F attribute,
> so I had to do this change:

Nice, so I suppose this test is passing with v6. I will try it.
Can you help to complete the TODO:

# TODO: test non-casefold subdir and casefold disabled after mount
The test now ends with the ofs->casefold =3D=3D true mount,
but we need to test the error conditions same as the test cases
for ofs->casefold =3D=3D false:

1. Casefold disabled after mount
2. Casefold disabled lower subdir

Those test cases are designed to trigger the "wrong parent casefold"
and "wrong child casefold" lookup warnings.

If you have an idea how to trigger the "wrong inherited casefold"
warning that would be nice.

Technically, test can delete the whiteout file inside $workdir/work
and remove casefold from $workdir/work and then trigger a copy up.
It may work. I am not sure if deleting the whietout file from work dir
is going to break something though.

Thanks,
Amir.


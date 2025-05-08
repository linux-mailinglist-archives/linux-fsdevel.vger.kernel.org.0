Return-Path: <linux-fsdevel+bounces-48471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC06AAF8ED
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 13:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38EFA9E1A12
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 11:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CF8221FD5;
	Thu,  8 May 2025 11:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1kiN93f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBE52153CE
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 11:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746704668; cv=none; b=OGe1hN34J+c4WQFBEIVrHszfAOR+SbnldG45QrP2VR0bhzm++mYXhliwH4hrPFNUa5NeQ+s1i+8tc85AYy5l5TIGqCqBQIJYs69Ov5MdNbOVEnVJuC8FXjn5gxfxvHK8pkGVSLxW7s+nm7f/aKql7teHA3ZpAbeCNiQSwE9o8fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746704668; c=relaxed/simple;
	bh=Z83rk8fy7JowVLkyMcWKPqTeMOaGKXcFB+7zIdLih3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cJQtnoDOGINgMVtVcLmZNMDPN4lEQxzMXtTkEdodbSKDYC5wcrOvIJoZwYPch4plhpRq8N7O/C+3H2ozMaKDV+RKajc9IJ5WdVpSOFdtk3I3jXwlZVkmb0TRLz2vWv21cRZ2ndRGWW+or7hkJRzIBKzRmtniclElJRF3LD0YsTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1kiN93f; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5fbf534f8dbso1235020a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 May 2025 04:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746704665; x=1747309465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1J85J1ktlvQwUMEPud6Cltiv2VFBOSu8a+MMoUCtEU=;
        b=E1kiN93fjLT8kdnVnHvNCaBA2jAWHhMZ/jXKisfApC2FvRuwaLregBldeXlPsNx5lu
         oaoUHi+0Et+VMqaISq2hkk+/CIg/VB2hcWqAliX7YVWYkEZ+oLZ26RwbHREQzM6NKUiC
         DCQ7pONZJDEjpK1LXPWxk+3dnpxqlAa1Ym4l0LWrgKf+GAlnrC118YCkexuRD2hkftwI
         hkndxe2ZEyEj3+Ao6Sx9GNibk6Hs5wd9k2uGMWxMowcM/pS92obZYJL3YyQCOoongxWA
         cHG2Y8IQNIk7hJCDIx8WDfivlVoSlMz4DNh40V96fbm4lppS/JJBtWPtAKIohHSvCHwl
         Cc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746704665; x=1747309465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1J85J1ktlvQwUMEPud6Cltiv2VFBOSu8a+MMoUCtEU=;
        b=pYwFmyVqcyNYLPOFDlnyeFJQEH2q8NMRyHzaOfbnZQEidYNxT7ZJ9g9j/RoOJjWN1F
         +RYoZJApQD204kB20s3iIkVwM1lwGfVgY72QVSzCI4cKFNm/jwtFOcAuzYuGXBpOKopu
         d4OaiHxQtjyFRg6oJKLIOJrHTcKD5mdhtFsItnPH2futCzFtsvVsB3u0zmZ6hPEl2CMe
         tO+hCXFDSM3VpxZrf70/3X5uBaS/YRSSRpnzuLFumAuhMuc4insAfJ/9QyDLGy5jhJdA
         gPPgk7XEvGGaUkn6RqP1d13LEvrFgwr1GTYrdlBPQbtdNk1Z/5qovU4TT2kG7kPFc/6m
         1ipw==
X-Forwarded-Encrypted: i=1; AJvYcCUfWBTjKkoBgQJ7IcgKLSx1QMpWohP7P/CtIP38Op4gU5vJeys3n1abjCTR03jdWctVJ7AyRs9Rodd1LWGL@vger.kernel.org
X-Gm-Message-State: AOJu0YxZDqmd2Au5WuGWwoiukM/9uyeLofZstSPJcBHsPqRhjWbeyLAr
	FgCGbZ18S9i4IJW0mlGl38Z9wHKPJArcjIPqPcmQ7QjE/WYXx0uc9DkKc2+JtxNx0m977nvvLc2
	RJHh0P1tg66HHGqLZnidVZv+39xc=
X-Gm-Gg: ASbGncvwOZaM+NUu99TXDtmgi+l58Q9nDaw4BtnBChIVNCVUOUhkB3viN4eWLawIhZT
	M0e98hTJ7A/PZFzDiCC1d2H4btmc9Zh6B1m06pELjrKbVIqytRVcQoM/6/Lj0nsa9fdtXPqRLfF
	WknVSojYM6OrgFjmGRQXu0cwTYuCu9+sft
X-Google-Smtp-Source: AGHT+IEnIyOPdt8MTjBpbCI/nMLHTRdumVyxAuZrWPTFJyChToHI5ML7/+Gx6P0DdyqDUxzNqEdMCcaOxG8Q2JDQ1jY=
X-Received: by 2002:a17:907:6d1c:b0:abf:749f:f719 with SMTP id
 a640c23a62f3a-ad1e8bc2a8cmr700852366b.7.1746704664524; Thu, 08 May 2025
 04:44:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507204302.460913-1-amir73il@gmail.com> <20250507204302.460913-5-amir73il@gmail.com>
 <3d19e405-314d-4a8f-9e89-e62b071c3778@nvidia.com>
In-Reply-To: <3d19e405-314d-4a8f-9e89-e62b071c3778@nvidia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 8 May 2025 13:44:13 +0200
X-Gm-Features: ATxdqUE4YkajifMVTSEA6mPlujZGw1-nvhd1CSaM4fX0Y1Sieit8T33I40USZ0c
Message-ID: <CAOQ4uxidUg+C=+_zTx+E58V4KH9-sDchsWKrMJn-g2WeoXV0wg@mail.gmail.com>
Subject: Re: [PATCH 4/5] selftests/filesystems: create get_unique_mnt_id() helper
To: John Hubbard <jhubbard@nvidia.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 9:43=E2=80=AFAM John Hubbard <jhubbard@nvidia.com> w=
rote:
>
> On 5/7/25 1:43 PM, Amir Goldstein wrote:
> > Add helper to utils and use it in mount-notify and statmount tests.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >   .../filesystems/mount-notify/Makefile         |  3 ++
> >   .../mount-notify/mount-notify_test.c          | 13 ++-------
> >   .../selftests/filesystems/statmount/Makefile  |  3 ++
> >   .../filesystems/statmount/statmount_test_ns.c | 28 +++---------------=
-
> >   tools/testing/selftests/filesystems/utils.c   | 20 +++++++++++++
> >   tools/testing/selftests/filesystems/utils.h   |  2 ++
> >   6 files changed, 34 insertions(+), 35 deletions(-)
> >
> > diff --git a/tools/testing/selftests/filesystems/mount-notify/Makefile =
b/tools/testing/selftests/filesystems/mount-notify/Makefile
> > index 41ebfe558a0a..55a2e5399e8a 100644
> > --- a/tools/testing/selftests/filesystems/mount-notify/Makefile
> > +++ b/tools/testing/selftests/filesystems/mount-notify/Makefile
> > @@ -1,7 +1,10 @@
> >   # SPDX-License-Identifier: GPL-2.0-or-later
> >
> >   CFLAGS +=3D -Wall -O2 -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
> > +LDLIBS +=3D -lcap
>
> This addition of -lcap goes completely unmentioned in the commit log.
> I'm guessing you are fixing things up to build, so this definitely
> deserves an explanation there.
>

This is needed because we are linking with utils.c code.
See below.
I guess we could have built a filesystems selftests utils library,
but that seems like an operkill?

> >
> >   TEST_GEN_PROGS :=3D mount-notify_test
> >
> >   include ../../lib.mk
> > +
> > +$(OUTPUT)/mount-notify_test: ../utils.c
> > diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-not=
ify_test.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_=
test.c
> > index 4f0f325379b5..63ce708d93ed 100644
> > --- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_tes=
t.c
> > +++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_tes=
t.c
> > @@ -13,6 +13,7 @@
> >
> >   #include "../../kselftest_harness.h"
> >   #include "../statmount/statmount.h"
> > +#include "../utils.h"
> >
> >   // Needed for linux/fanotify.h
> >   #ifndef __kernel_fsid_t
> > @@ -23,16 +24,6 @@ typedef struct {
> >
> >   #include <sys/fanotify.h>
> >
> > -static uint64_t get_mnt_id(struct __test_metadata *const _metadata,
> > -                        const char *path)
> > -{
> > -     struct statx sx;
> > -
> > -     ASSERT_EQ(statx(AT_FDCWD, path, 0, STATX_MNT_ID_UNIQUE, &sx), 0);
> > -     ASSERT_TRUE(!!(sx.stx_mask & STATX_MNT_ID_UNIQUE));
> > -     return sx.stx_mnt_id;
> > -}
> > -
> >   static const char root_mntpoint_templ[] =3D "/tmp/mount-notify_test_r=
oot.XXXXXX";
> >
> >   static const int mark_cmds[] =3D {
> > @@ -81,7 +72,7 @@ FIXTURE_SETUP(fanotify)
> >
> >       ASSERT_EQ(mkdir("b", 0700), 0);
> >
> > -     self->root_id =3D get_mnt_id(_metadata, "/");
> > +     self->root_id =3D get_unique_mnt_id("/");
> >       ASSERT_NE(self->root_id, 0);
> >
> >       for (i =3D 0; i < NUM_FAN_FDS; i++) {
> > diff --git a/tools/testing/selftests/filesystems/statmount/Makefile b/t=
ools/testing/selftests/filesystems/statmount/Makefile
> > index 19adebfc2620..8e354fe99b44 100644
> > --- a/tools/testing/selftests/filesystems/statmount/Makefile
> > +++ b/tools/testing/selftests/filesystems/statmount/Makefile
> > @@ -1,7 +1,10 @@
> >   # SPDX-License-Identifier: GPL-2.0-or-later
> >
> >   CFLAGS +=3D -Wall -O2 -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
> > +LDLIBS +=3D -lcap
>
> And here.
>
> >
> >   TEST_GEN_PROGS :=3D statmount_test statmount_test_ns listmount_test
> >
> >   include ../../lib.mk
> > +
> > +$(OUTPUT)/statmount_test_ns: ../utils.c
>
> This is surprising: a new Makefile target, without removing an old one.
> And it's still listed in TEST_GEN_PROGS...
>
> Why did you feel the need to add this target?

I am not a makefile expert, but this states that statmount_test_ns
needs to link with utils.c code.

I copied it from overlayfs/Makefile.

Is there a different way to express this build dependency?

Thanks,
Amir.


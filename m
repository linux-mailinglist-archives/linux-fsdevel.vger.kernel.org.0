Return-Path: <linux-fsdevel+bounces-57644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B20B241BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 08:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15A5A3B5D6E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 06:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524122D1F61;
	Wed, 13 Aug 2025 06:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGLeTws4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12A92D0C6E;
	Wed, 13 Aug 2025 06:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755067212; cv=none; b=Z+bDjCFj2230vVeWaRz8mzt0+iC03VlBA2RE/NEt54WU/xlZIMNiwCtzVhRu7OUsmqsSfRP6LTRxIx9wrSP2SgCtqG5GfWGW1uLs57vFC1M9tMEvssncxoRMtKSGAgeLf0cKgr48hFYP6WyIseDV+fra5BlbS6KwrhQm2AMqj0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755067212; c=relaxed/simple;
	bh=5BvG7TLfJ8iuSqZ7FTN6hKQa9IId382nRM+tCTRJdvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aon2BOH1ZLBOJ7xSyPSHOwHwuQK1Lr/csenV15TtZVM2wXYMs3bQAxdFbEc28CaMBJxcxovxDPxpMaU53lZK83zXS9vm5yps1C3MpXyGaRx2x1Ys38xw9J8lMdIVjyLvcu5j9qxKBn/ltyjVM80h9C9yqcX8+IDxU5ENbiBDBTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGLeTws4; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-af9842df867so1101869666b.1;
        Tue, 12 Aug 2025 23:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755067209; x=1755672009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CS1EFK3T+XTqUFbqX/u+OP7CHyuVknuwqvCazTFt8Ns=;
        b=BGLeTws4FOx58qrqzr99ePzqH0kG8hSImIBL4snRJ/VY1f99BWMp9tGCcTGfRLNeN6
         41E4XCZjvleFCmIT1lvKEw9zqBwdIZbkf1BF5ApskbYolNLo7JM9ZAYicD2sCVfJsACB
         VELMJWEkWQGH2DR+H85U2jQ5cTCLBTijY/aD6808u+PETUIkxcEJJdWDPvVu6lgEpwIf
         fSjJrE3Vy/Kj9f9OAKaTxEr1kuQq1j3QVh93K8Yq/YXHQnbZ2feulmq3pGmiiDvT6a+b
         2T2X4w7fwNMm1tN7tCEV091LG/WSZtZrXO5etIUaAmv//QX96hIeKORBxpPNmJBRhoKV
         qFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755067209; x=1755672009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CS1EFK3T+XTqUFbqX/u+OP7CHyuVknuwqvCazTFt8Ns=;
        b=AUVAxT3rjBNvD79M0wTLtLq7kVQUdT6OVHJ2my4WKd1yQhOq6UZO8LCOaFExSLUQXR
         vQmoR8jcnumhJsUL9tyN7un4KyHRCkoIPBys/dbwgntpDQtqX2PCAF+2BmZIQMaovyQI
         kUxriMCKUlY9L/y+ZYu0VZsDaiS5DYT/OpduXMZnPMqk2W70WkHEeSt7Lc3/jPj/qOWj
         IdlDJOZLlOCIS+3D/fzccg1t4NKKHUTF/p2WBzCIOwfKOgpKal9tM1vouP5Yu4K9cjf8
         USzfqkwtbjZ8nEkvmBsRRFZ5iB8ZM/PlXIUI42oVY2agRJdJBpxTNY2xxj6f2aWPXAuQ
         j/ZA==
X-Forwarded-Encrypted: i=1; AJvYcCUcl2lda7lUyRA9XXnB2ou5gSbrc3BA2Wv+3wpUg1rB1L2kXMfIkZJYB3MIff9imlhDbVp7CnT4//2TDR6l@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8CcTsqPZqDJCy6Zh9KigOdrD6hTKt0//c4P0fuBX1oM9H5uWy
	XVkMkkn3KqT4i9go04j6dAqmKqGibT9GXisrzevlvsB/Mhf1R4/WfKLQmZVKvrY/AyKDnofKIyq
	Nqg5gPXvpFz9w1c+FS0pYfEoOdO9hb+k=
X-Gm-Gg: ASbGncvf4ot03N7mSYpA/H/PdNgimIP4/D9tF2tTmrOEwN79rCQUVLqGItelPKtgPNR
	bA0OdSYl6qUvlykj/Z7PKjSugpJ/xPo37pZ59LfSDKnXYbRtmWAheFyx8JbsVdNIYcfpkdOf/un
	Kvudxky+ZtiVW+z+oYa5wJfVKQRrdph1pfa4D8KDzwT5wM2W5HnS/Ep5qWne54pdBXEdkGiYwXc
	T0hdj0qLqyyPeezlw==
X-Google-Smtp-Source: AGHT+IEg8eiuQgi8N/UxodFjhpFiZEEdB6fWZ2YPVe56UkNDsZ/q6MylhYStMbaZ8T7FuipZTIIjx6toVt6Y48mr3bw=
X-Received: by 2002:a17:907:3f1b:b0:af9:7c1c:b4ce with SMTP id
 a640c23a62f3a-afca4e470ffmr192926666b.39.1755067209125; Tue, 12 Aug 2025
 23:40:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813031647.96411-1-higuoxing@gmail.com> <CAOQ4uxg0OvDW5yJiseEOHBB2sH6Nw1iWo+CvvZ0COTGo=oYmfg@mail.gmail.com>
In-Reply-To: <CAOQ4uxg0OvDW5yJiseEOHBB2sH6Nw1iWo+CvvZ0COTGo=oYmfg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 13 Aug 2025 08:39:58 +0200
X-Gm-Features: Ac12FXz4Qw46Vm-HPpPdvbK7bMIl0lwvEtSF_-usOP5jmzth9G2LxTWdW4QSknU
Message-ID: <CAOQ4uxjJHscMEcAahVpbUDcDet7D8xa=X2rLr33femZsCy6t0A@mail.gmail.com>
Subject: Re: [PATCH] selftests/fs/mount-notify: Fix compilation failure.
To: Xing Guo <higuoxing@gmail.com>
Cc: linux-kselftest@vger.kernel.org, shuah@kernel.org, jhubbard@nvidia.com, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 8:36=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Wed, Aug 13, 2025 at 5:17=E2=80=AFAM Xing Guo <higuoxing@gmail.com> wr=
ote:
> >
> > Commit c6d9775c2066 ("selftests/fs/mount-notify: build with tools inclu=
de
> > dir") introduces the struct __kernel_fsid_t to decouple dependency with
> > headers_install.  The commit forgets to define a macro for __kernel_fsi=
d_t
> > and it will cause type re-definition issue.
> >
> > Signed-off-by: Xing Guo <higuoxing@gmail.com>
>
> Thank you for fixing this!
>
> Acked-by: Amir Goldstein <amir73il@gmail.com>
>

You should probably also add:

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202508110628.65069d92-lkp@intel.com

Thanks,
Amir,

> > ---
> >  .../mount-notify/mount-notify_test.c           | 17 ++++++++---------
> >  .../mount-notify/mount-notify_test_ns.c        | 18 ++++++++----------
> >  2 files changed, 16 insertions(+), 19 deletions(-)
> >
> > diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-not=
ify_test.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_=
test.c
> > index 63ce708d93ed..e4b7c2b457ee 100644
> > --- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_tes=
t.c
> > +++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_tes=
t.c
> > @@ -2,6 +2,13 @@
> >  // Copyright (c) 2025 Miklos Szeredi <miklos@szeredi.hu>
> >
> >  #define _GNU_SOURCE
> > +
> > +// Needed for linux/fanotify.h
> > +typedef struct {
> > +       int     val[2];
> > +} __kernel_fsid_t;
> > +#define __kernel_fsid_t __kernel_fsid_t
> > +
> >  #include <fcntl.h>
> >  #include <sched.h>
> >  #include <stdio.h>
> > @@ -10,20 +17,12 @@
> >  #include <sys/mount.h>
> >  #include <unistd.h>
> >  #include <sys/syscall.h>
> > +#include <sys/fanotify.h>
> >
> >  #include "../../kselftest_harness.h"
> >  #include "../statmount/statmount.h"
> >  #include "../utils.h"
> >
> > -// Needed for linux/fanotify.h
> > -#ifndef __kernel_fsid_t
> > -typedef struct {
> > -       int     val[2];
> > -} __kernel_fsid_t;
> > -#endif
> > -
> > -#include <sys/fanotify.h>
> > -
> >  static const char root_mntpoint_templ[] =3D "/tmp/mount-notify_test_ro=
ot.XXXXXX";
> >
> >  static const int mark_cmds[] =3D {
> > diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-not=
ify_test_ns.c b/tools/testing/selftests/filesystems/mount-notify/mount-noti=
fy_test_ns.c
> > index 090a5ca65004..9f57ca46e3af 100644
> > --- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_tes=
t_ns.c
> > +++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_tes=
t_ns.c
> > @@ -2,6 +2,13 @@
> >  // Copyright (c) 2025 Miklos Szeredi <miklos@szeredi.hu>
> >
> >  #define _GNU_SOURCE
> > +
> > +// Needed for linux/fanotify.h
> > +typedef struct {
> > +       int     val[2];
> > +} __kernel_fsid_t;
> > +#define __kernel_fsid_t __kernel_fsid_t
> > +
> >  #include <fcntl.h>
> >  #include <sched.h>
> >  #include <stdio.h>
> > @@ -10,21 +17,12 @@
> >  #include <sys/mount.h>
> >  #include <unistd.h>
> >  #include <sys/syscall.h>
> > +#include <sys/fanotify.h>
> >
> >  #include "../../kselftest_harness.h"
> > -#include "../../pidfd/pidfd.h"
> >  #include "../statmount/statmount.h"
> >  #include "../utils.h"
> >
> > -// Needed for linux/fanotify.h
> > -#ifndef __kernel_fsid_t
> > -typedef struct {
> > -       int     val[2];
> > -} __kernel_fsid_t;
> > -#endif
> > -
> > -#include <sys/fanotify.h>
> > -
> >  static const char root_mntpoint_templ[] =3D "/tmp/mount-notify_test_ro=
ot.XXXXXX";
> >
> >  static const int mark_types[] =3D {
> > --
> > 2.50.1
> >


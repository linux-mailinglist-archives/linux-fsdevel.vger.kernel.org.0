Return-Path: <linux-fsdevel+bounces-48473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36809AAF957
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 14:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B43C1BC2FDC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 12:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0652223DD6;
	Thu,  8 May 2025 12:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjsapCB9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754A61CD2C
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 12:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746706112; cv=none; b=fCGtEJf7al22XvgUbnZL9jmxKP23NolJ9SzClNV+BCUx4styUieJd67CeRc+tO2nySinHPr2puxGslasX4y8cMFY6qozjbHl6nTJMfZw7+dYNd1p1SafZTMX/FGiA6K6R568dM2iWmgToEW/aDKyEQt0THnEXblV5yh3dDHncjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746706112; c=relaxed/simple;
	bh=rnFkhTv5+tA/8JUTv1WvESm3xGdCv8VtfIEwqqsfRMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ieHzX1EyeexPM7Ko+HR2EPJWz0m+HftaGTbytKC+WMAe+2VWlfRF/vc1PcgrXiyeLeDjwQyXJF675S5FyQxMMdNmsK6mR50v9PCAdEUJdRjBqMzMEjJh/yCbZdYmTzu6O1EleIkIDErY5S78Vt2MPSFxJSH5xrRd0d4S8itIx/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JjsapCB9; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ace333d5f7bso156279666b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 May 2025 05:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746706109; x=1747310909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IThNKgmEjYeycaUD8zcDnYRq0Np+Spg6BHQUasJjRT4=;
        b=JjsapCB9S9E41vaPGNkPQKaxhFDUbWowr0veCHq/3pdmWRPKe3yBNHQ90jl1eO8v6E
         5upOrvLlZzez/GQdwnKHvQHOP0n25XzAYxsnZ4OeOjLNGWLoh/5mK+4yAm+rwh8NbAv1
         rNkO0Ga9rCyKYdu2oHtxmPvdMO4UPA+BDksUdSadmGeSRdE8xZoD1pQtpWZ0pGz875Mg
         dIYWkqtDeK2M6T99AphoI3Sm6Y89XCueRERAav7X+lksBIu/MMBBSVczKJNo6sStOunP
         7NsC03pCFcatJfOYByAeG9e2Bd38iglO0ETPY81RnPmqYlH254S/c7K9BtjHnkWFhmMt
         H91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746706109; x=1747310909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IThNKgmEjYeycaUD8zcDnYRq0Np+Spg6BHQUasJjRT4=;
        b=muTfPtS6FAgCRqZ7im1nsB0cn/Zzokjw3jsA+edN7YZxg3EP0t5oEyfMSd8sRF/hyk
         wGcy99y10wAsAG5ABrZkReoLXe7zaOyjeW+YlemgMMtImvEs8hvNQQaF9F7nxK+CX419
         6ngD+JeoRjGvhHEBIwHWSjkXqeUYV3GK7UUMQFtHH0x7JMih36DDnzRC748dFuXgR6rh
         cdUgdqOXlhgBay4vTkNNQTcDn5KcfMA6wlsEKV6WC5yZn7OP6g6wloLYztIm77SFyCr9
         0NIM3rWeYiKrZH3aqSqtm9FTBPqvTV5hLnhdO2xZpKfa3SD4A9TW8CUWcnVSZrXVBwxc
         JDrw==
X-Forwarded-Encrypted: i=1; AJvYcCVzxViLbdU4egKf/dveBK4DiGWXvgESjLg8oLE4CqyU1snDxYFctPstkYA1wR81QRVyQBWBAbOr203Hc3Ia@vger.kernel.org
X-Gm-Message-State: AOJu0YztdW+9ZXOrB1pOWYeYUjPWEuOsvvsmV3Py5FhFEF7kuS3EW+sm
	iNn0sMmD22B7HKuF/DEK3bceveNWSDjWSaAAKBglQrLPLH/6YpHhBLSZ/uSUBDVKU6oIHgD/yKS
	NAlTAZyqndA5MubipciYwc7g14ns=
X-Gm-Gg: ASbGncvg16oqvzt7AFAoeyNZmqC8FLXLg6vBPIW1x2bUv0/ZLSU4J+wK6dEJP3TZuzx
	3YatcIvS53TQXGz2nhW1xT2koiAi3i0jFsu8qowfjdPowvUDzgF+b04TWcU9sMQULWOKWDX9BvR
	PRQXs9O/HKQX/kgIDftjK0fQ==
X-Google-Smtp-Source: AGHT+IEDh1iBYVILQKiLjysdjIWXfXCUzIVm7EiieT5MzZXTt4LsGx4r97e+QIU/Wp+4X1nvYINQtZ4VnsosPNV5v2k=
X-Received: by 2002:a17:906:d542:b0:ad1:a87d:3de8 with SMTP id
 a640c23a62f3a-ad1e8b9580emr755613766b.5.1746706108171; Thu, 08 May 2025
 05:08:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507204302.460913-1-amir73il@gmail.com> <20250507204302.460913-6-amir73il@gmail.com>
 <75a3cb6f-a9cc-441f-a43e-2f02fbfc49bf@nvidia.com>
In-Reply-To: <75a3cb6f-a9cc-441f-a43e-2f02fbfc49bf@nvidia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 8 May 2025 14:08:16 +0200
X-Gm-Features: ATxdqUGZI4ayKBK8R1pgtBDxLx6Tjj_9YjPi8Xq7mRLvMh0J8MlnCn6BYt6y6-c
Message-ID: <CAOQ4uxiPgh0Lrt-7YnBQLTBFe-6aSUpgYVraoE_N=k0DrP7BEA@mail.gmail.com>
Subject: Re: [PATCH 5/5] selftests/filesystems: create setup_userns() helper
To: John Hubbard <jhubbard@nvidia.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 9:52=E2=80=AFAM John Hubbard <jhubbard@nvidia.com> w=
rote:
>
> On 5/7/25 1:43 PM, Amir Goldstein wrote:
> > Add helper to utils and use it in statmount userns tests.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >   .../filesystems/statmount/statmount_test_ns.c | 60 +----------------
> >   tools/testing/selftests/filesystems/utils.c   | 65 ++++++++++++++++++=
+
> >   tools/testing/selftests/filesystems/utils.h   |  1 +
> >   3 files changed, 68 insertions(+), 58 deletions(-)
> >
> > diff --git a/tools/testing/selftests/filesystems/statmount/statmount_te=
st_ns.c b/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c
> > index 375a52101d08..3c5bc2e33821 100644
> > --- a/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c
> > +++ b/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c
> > @@ -79,66 +79,10 @@ static int get_mnt_ns_id(const char *mnt_ns, uint64=
_t *mnt_ns_id)
> >       return NSID_PASS;
> >   }
> >
> > -static int write_file(const char *path, const char *val)
> > -{
> > -     int fd =3D open(path, O_WRONLY);
> > -     size_t len =3D strlen(val);
> > -     int ret;
> > -
> > -     if (fd =3D=3D -1) {
> > -             ksft_print_msg("opening %s for write: %s\n", path, strerr=
or(errno));
> > -             return NSID_ERROR;
> > -     }
> > -
> > -     ret =3D write(fd, val, len);
> > -     if (ret =3D=3D -1) {
> > -             ksft_print_msg("writing to %s: %s\n", path, strerror(errn=
o));
> > -             return NSID_ERROR;
> > -     }
> > -     if (ret !=3D len) {
> > -             ksft_print_msg("short write to %s\n", path);
> > -             return NSID_ERROR;
> > -     }
> > -
> > -     ret =3D close(fd);
> > -     if (ret =3D=3D -1) {
> > -             ksft_print_msg("closing %s\n", path);
> > -             return NSID_ERROR;
> > -     }
> > -
> > -     return NSID_PASS;
> > -}
> > -
> >   static int setup_namespace(void)
> >   {
> > -     int ret;
> > -     char buf[32];
> > -     uid_t uid =3D getuid();
> > -     gid_t gid =3D getgid();
> > -
> > -     ret =3D unshare(CLONE_NEWNS|CLONE_NEWUSER|CLONE_NEWPID);
> > -     if (ret =3D=3D -1)
> > -             ksft_exit_fail_msg("unsharing mountns and userns: %s\n",
> > -                                strerror(errno));
> > -
> > -     sprintf(buf, "0 %d 1", uid);
> > -     ret =3D write_file("/proc/self/uid_map", buf);
> > -     if (ret !=3D NSID_PASS)
> > -             return ret;
> > -     ret =3D write_file("/proc/self/setgroups", "deny");
> > -     if (ret !=3D NSID_PASS)
> > -             return ret;
> > -     sprintf(buf, "0 %d 1", gid);
> > -     ret =3D write_file("/proc/self/gid_map", buf);
> > -     if (ret !=3D NSID_PASS)
> > -             return ret;
> > -
> > -     ret =3D mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL);
> > -     if (ret =3D=3D -1) {
> > -             ksft_print_msg("making mount tree private: %s\n",
> > -                            strerror(errno));
> > +     if (setup_userns() !=3D 0)
> >               return NSID_ERROR;
> > -     }
> >
> >       return NSID_PASS;
> >   }
> > @@ -200,7 +144,7 @@ static void test_statmount_mnt_ns_id(void)
> >               return;
> >       }
> >
> > -     ret =3D setup_namespace();
> > +     ret =3D setup_userns();
> >       if (ret !=3D NSID_PASS)
> >               exit(ret);
> >       ret =3D _test_statmount_mnt_ns_id();
> > diff --git a/tools/testing/selftests/filesystems/utils.c b/tools/testin=
g/selftests/filesystems/utils.c
> > index 9b5419e6f28d..9dab197ddd9c 100644
> > --- a/tools/testing/selftests/filesystems/utils.c
> > +++ b/tools/testing/selftests/filesystems/utils.c
> > @@ -18,6 +18,7 @@
> >   #include <sys/types.h>
> >   #include <sys/wait.h>
> >   #include <sys/xattr.h>
> > +#include <sys/mount.h>
> >
> >   #include "utils.h"
> >
> > @@ -447,6 +448,70 @@ static int create_userns_hierarchy(struct userns_h=
ierarchy *h)
> >       return fret;
> >   }
> >
> > +static int write_file(const char *path, const char *val)
> > +{
> > +     int fd =3D open(path, O_WRONLY);
> > +     size_t len =3D strlen(val);
> > +     int ret;
> > +
> > +     if (fd =3D=3D -1) {
> > +             syserror("opening %s for write: %s\n", path, strerror(err=
no));
>
> While I have no opinion about ksft_print_msg() vs. syserror(), I do
> think it's worth a mention in the commit log: there is some reason
> that you changed to syserror() throughout. Could you write down
> what that was?

Very good question.

I admit I did not put much thought into this. I was blindly following
Christian's lead in utils.c.
I will revert those syserror back to ksft_print_msg().

>
> In any case, it looks correct, so with an update commit message, please
> feel free to add:
>
>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
>

Thanks for the review!
Amir.


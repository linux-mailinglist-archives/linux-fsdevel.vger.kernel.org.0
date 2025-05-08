Return-Path: <linux-fsdevel+bounces-48472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 241C0AAF92F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 13:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 749681C20103
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 11:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19FF223702;
	Thu,  8 May 2025 11:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJuZ/E+M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FBB1DED57
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 11:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746705249; cv=none; b=QHYO23EFetKApSwcELhERk4FlZtkyFZ53USvp+g0uEgStYyIlwHnJ22seGbH5g83hfaYxFGvPDcJN4zIvZ3nEmk/MMRxv5gs7nknx98zZx2g5F5hEe9d4MnOG9JJSXWgnnzo1CmnMl8lGwVt115mjT7MaZ9alRGDGIIHQpPSaDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746705249; c=relaxed/simple;
	bh=uW+ouyOAUl6pdqSozeSCn5+qOvoE/1GjWdMbDoRt1Kk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uH24ZT7liqQwjYnWXb5aGsLQB5EmiDnQ8cGX28n9XmmGNgcSzKeTSd+m+/Sab7eYntMfHGB4/7WNLZ3YtNyZa/lyWNFuUNMrAAlaoypNWQo9SoWPZYU/gPIeLK0rnT79e+qgbD/ua/av4H9EiKDxC/QsVAbkn4C9xxYW/B/wY+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJuZ/E+M; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e5e22e6ed2so1370896a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 May 2025 04:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746705246; x=1747310046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EyQB7fOOADDDzgOKXIqy+CycT8HCqgAUpRmI3HQgHh4=;
        b=QJuZ/E+McHsZt/2/ZtVly0ikodvfp8CH4HXALpAINOOGoQ5rkI1zET3ZZQ5MAjVj3h
         CJd2uzY6mv04edLd5hcKK+KrVpqcUgoKGK2QYiu/onxKGRhn1/yN5FCfNsE0jHQDKViG
         wXsx/zgXj9W2V1J7YYas1gMA6Wp97rqaLhZoMcJZhyP0cAwzQiv9V4U7ynv/gbNxJRr1
         q6jX0fEJ2qjed+VaW0idSkJNPqdEXXMiDhzhQAly+LaS2tSH0A9rukRqX0UD/xmOQEpU
         OINHDNf8xBFUtpkJew7pX+WtCXeuHOCoiah8QcPSjT/1JgfJcV35kMXF8l5DgGDxyxfe
         EAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746705246; x=1747310046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EyQB7fOOADDDzgOKXIqy+CycT8HCqgAUpRmI3HQgHh4=;
        b=nrtm/ug9kf3sQkZVpmafAKJPuS3HzjwP4mvDZC7v15Nx1OAxt3CAvlaAZ6/fH8m8P/
         kUhxEEQINc1q6gBt1m+emJ6ru5a0/TigIh3IfTxzFJe31+mwsc8dJfVfkDlGH9TIpSrk
         SXJ9lDoywGNSO2K5YvLD4S7/r1mjobwy77Q2LGn8qAbx6DNKHzEAn5WLLLcAtSQcbnRl
         jJ3FYti0UM8SPeZaLC1QooSpFOZDrZ8+VMFIoRFiWjQFSqrr9yr1Sd1BLmYmyIlsDCj7
         16T6zu7ap9V/s9fOGmbCxVlYfNiuQgkFA08g9lw+b/JWAXUOfJd5y9qy8aD8xYO81WMJ
         Nc9w==
X-Forwarded-Encrypted: i=1; AJvYcCV6VZ82lLZrUukuh47bgW0QVwOrdqw5PC+6NcMZg8YHOOlvdxrcKoLwQ+ZDoqZzKB5qjZsnjrALM6noJX7k@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1sbuCzJTcycyiT5Fz+ls9kBgrMPZCMJYteT/JHNIplLKHN0mS
	h8DYLK3DmTKKwoW9Zr+DV1Xy9UNAXcpf+FYxlD43AhVhqeBwlWOIOLzuqUhvoNvN/bLpciT/u8u
	0Zs6Z1mRVVkcwi1W6LT56ZaRRkz0=
X-Gm-Gg: ASbGncvfMqTjqzaU+bUKCGXbBK5afi98wCFkcRTyk+7xWWZmtYbcD2n7Khr8gYQqbtt
	egcc4HYZe4W8pFAwd7Xf40lhR5zry42zSBO1AZAnJGLBCCN3RTqgpDImt3zR694S8M2xBU818bw
	bNNSpUONVm4MJh/lM83Onh9w==
X-Google-Smtp-Source: AGHT+IF5OFLIAvaI9uJS33y8+rk7KH89oJ9Rph2Ljf/sefw0mMKprEvZqWojMKAWqahcKC22wj8OCcaAkHgwcvuzEXo=
X-Received: by 2002:a17:907:7e82:b0:aca:95e7:9977 with SMTP id
 a640c23a62f3a-ad1fe7fc8c6mr290653866b.28.1746705245373; Thu, 08 May 2025
 04:54:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507204302.460913-1-amir73il@gmail.com> <20250507204302.460913-4-amir73il@gmail.com>
 <685d5423-5b6a-4a11-9bef-50224e479f44@nvidia.com>
In-Reply-To: <685d5423-5b6a-4a11-9bef-50224e479f44@nvidia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 8 May 2025 13:53:54 +0200
X-Gm-Features: ATxdqUG-kusR1BytgOhNXND46DOdXgvjnf4QbI-Eibr6-swnWApgiY5nqI5wUqw
Message-ID: <CAOQ4uxgrpidT0CnuUpnqFp058sLPKMhXQDXiP6u7icRfDt58Gw@mail.gmail.com>
Subject: Re: [PATCH 3/5] selftests/fs/mount-notify: build with tools include dir
To: John Hubbard <jhubbard@nvidia.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 9:38=E2=80=AFAM John Hubbard <jhubbard@nvidia.com> w=
rote:
>
> On 5/7/25 1:43 PM, Amir Goldstein wrote:
> > Copy the fanotify uapi header files to the tools include dir
> > and define __kernel_fsid_t to decouple dependency with headers_install
> > and then remove the redundant re-definitions of fanotify macros.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
...
> > diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-not=
ify_test.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_=
test.c
> > index 59a71f22fb11..4f0f325379b5 100644
> > --- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_tes=
t.c
> > +++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_tes=
t.c
> > @@ -8,33 +8,20 @@
> >   #include <string.h>
> >   #include <sys/stat.h>
> >   #include <sys/mount.h>
> > -#include <linux/fanotify.h>
> >   #include <unistd.h>
> > -#include <sys/fanotify.h>
> >   #include <sys/syscall.h>
> >
> >   #include "../../kselftest_harness.h"
> >   #include "../statmount/statmount.h"
> >
> > -#ifndef FAN_MNT_ATTACH
> > -struct fanotify_event_info_mnt {
> > -     struct fanotify_event_info_header hdr;
> > -     __u64 mnt_id;
> > -};
> > -#define FAN_MNT_ATTACH 0x01000000 /* Mount was attached */
> > -#endif
> > -
> > -#ifndef FAN_MNT_DETACH
> > -#define FAN_MNT_DETACH 0x02000000 /* Mount was detached */
> > +// Needed for linux/fanotify.h
>
> Is the comment accurate? Below, we are include sys/fanotify.h, not
> linux/fanotify.h
>

Yes, it is accurate.
sys/fanotify.h includes linux/fanotify.h
linux/fanotify.h needs __kernel_fsid_t
I considered copying posix_types.h, but it seemed wrong
and I think __kernel_fsid_t definition is the same on all archs anyway.

>
> > +#ifndef __kernel_fsid_t
> > +typedef struct {
> > +     int     val[2];
> > +} __kernel_fsid_t;
> >   #endif
> >
> > -#ifndef FAN_REPORT_MNT
> > -#define FAN_REPORT_MNT 0x00004000 /* Report mount events */
> > -#endif
> > -
> > -#ifndef FAN_MARK_MNTNS
> > -#define FAN_MARK_MNTNS 0x00000110
> > -#endif
> > +#include <sys/fanotify.h>
>
> Are you sure that you're including your newly added fanotify.h? Because
> it looks to me like you might be including your local installed version,
> instead. I don't see how it can include
>
>      tools/include/uapi/linux/fanotify.h
>
> ...with the above invocation.
>

Yes, it works.

My local installed linux/fanotify.h does not include FAN_MARK_MNTNS
it is only available in my source and tools include dirs.

Does the fact that sys/fanotify.h includes linux/fanotify.h explains what
didn't make sense to you?

Thanks,
Amir.


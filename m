Return-Path: <linux-fsdevel+bounces-40030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 626EAA1B260
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 10:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FB94188F575
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 09:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB911DB372;
	Fri, 24 Jan 2025 09:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4k3viE5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5E41D5AC6;
	Fri, 24 Jan 2025 09:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737709813; cv=none; b=ktZ2G4AXaH76j+Bix4ijLXZOk3Smhb3h0UIQDFm919kRk8MVq19IBrsJ+2bT2HWa3lnrMZVbz8xCzfHBXl3po6Ev08EshObhlyTl4F45q4Ct2/1mk5egmpicdjlEvH/6rXP80ZtD25zJjEqYRXaHjOCjurDvON3oqQkGSsyQ8+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737709813; c=relaxed/simple;
	bh=xk3kG0BCXcqkU0VbfYJ5fN8Nbwynu9/+rHAyME6dPeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gmQNv/5WcNiwFbhjuYYRChVGsfpnbX2ScRt9bznFSIhf+iVoMIA7y/nfYAqpvEUCo4xYDMh+H9Pe+gmc7KMmO5KJUV//nkKPKL5RNCnASwhr6lwxuZplJAgJP2/YEWYW92dgjo+xEoPTuepeZYSSRdeY515s75dg9MHuwDklKdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4k3viE5; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d3dce16a3dso3599914a12.1;
        Fri, 24 Jan 2025 01:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737709810; x=1738314610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PebFCz8wHywlT4G0ONoQK1ioBzzlxVw1mqYjoRgT2S4=;
        b=Q4k3viE5/+T5X6CZR2TtBX/ZVOzgJgHnXweDZimXYNlKzD4516R/Q/equ7IXbTvslu
         4W89bGP0XYoRfaSDwmc5NOpGgVsOGhA3mKr2BF86lnKugs74O9ZZo+EZmg4/O+diox08
         +QwshLltICq41BnFPjl+pruBtEsE2CQS/d5cNXMNFq4Fw2/CLrseDKqAhIsjftiVfGeH
         oSp1XDNC5pTRfqKH1kK+o6EdFMA0VtSipzUCRsZUOdqlhoyFEoqMvgJx4YBBU02iErdx
         3kAuFfOAXcZf0au5TPhsLcrPluY6T6/ZavtpzgVJQGRfs+ABvBgTHn/jpuaggwVHzIDf
         Nclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709810; x=1738314610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PebFCz8wHywlT4G0ONoQK1ioBzzlxVw1mqYjoRgT2S4=;
        b=MfegGQebc7Qd0/w7wv0VS2hpmvLoFpdKO+aciyoAjwOYbOeiK1FDXpMTdGZK72gZ9s
         9GAv+KgQ/nGk7ivDG/5oCPzC+StbLB4/c7js6INNny8TG44K8eaDqKY8cydmQrI2TqHb
         CIVECpZli5wHddapTkWksTaCrKSdAac7z+IEZ8rf1qLPETS3UkkyYbOiaDmSeZ1S/LY8
         19ESaiyda0L36GuLm4oeA7KLyEmHtjTktKIQIpiPQkHpAGj9qZVYwu6ttDIsYBTRSuJF
         XkvzP+OIuKWdFCXCbkMdmThr4yRupyj5zeA5hPGoj3c3BE6yBKay0bFJQgr2+r9C1Nnd
         2E8A==
X-Forwarded-Encrypted: i=1; AJvYcCXMJ73+rXbXNcHQE2fEYcSUbdYxvZudaYD02QVGfjU4wMuLUw+sqJoZGw7kFi/Z/fHPxWamEkZaQxdPVFJ2j+QwO5MNGLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4ZVM76ZHb+/eevVG4lxf3BjVQ66JtqY22NJi0tc0x4C9Z4gET
	nGrO9PhiLE7x3uA18dANc5GpRqn9fwOrmUXVtuG89gRnirndYf55eVstAJAwd+JmNk6oNVgMnlj
	wgewkr6KvJXEenHu8XKCwtA1sbYlKTaAqpfE=
X-Gm-Gg: ASbGnct6jCyqVQx4dYD8sd9+7e997it4fbjabfJ/Kp+OESeOkuKemm7RD0188s9lkzL
	f2Gl5cVPEjQ+OCRZ9nEzQsPNNbpKMph/YN7PrTDWmJ28n6diXjf447GHxyfP0nA==
X-Google-Smtp-Source: AGHT+IFrA7ABUjmPfjXLWyi0xqf+53fo9KMh4gxsb50I3VlPpKc6LfbT3fGBAeb3/9pKd6sRzjbrrmxv4fyFIjZyeps=
X-Received: by 2002:a05:6402:40c6:b0:5dc:6c5:69d5 with SMTP id
 4fb4d7f45d1cf-5dc17fed20cmr2451343a12.3.1737709809236; Fri, 24 Jan 2025
 01:10:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123194108.1025273-1-mszeredi@redhat.com> <20250123194108.1025273-5-mszeredi@redhat.com>
In-Reply-To: <20250123194108.1025273-5-mszeredi@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 24 Jan 2025 10:09:57 +0100
X-Gm-Features: AWEUYZlLUDlIG7daVyXQpAi5HxQSypgWDfM6ySPrJ_GWQXveV6CRHuRSyqGwdr0
Message-ID: <CAOQ4uxhmL5P2WVMPQLjNnMD8+jqvkJD7_QVBKU9GEArdGw-7nw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] vfs: add notifications for mount attribute change
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Jan Kara <jack@suse.cz>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-security-module@vger.kernel.org, 
	Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 8:41=E2=80=AFPM Miklos Szeredi <mszeredi@redhat.com=
> wrote:
>
> Notify when mount flags, propagation or idmap changes.
>
> Just like attach and detach, no details are given in the notification, on=
ly
> the mount ID.
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---

My only nit this time is that I prefer the fsnotify/fanotify bits here
to be in patches 1,2
which as you write, only add the infrastructure to be used later.

[...]

> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -471,7 +471,7 @@ static inline bool fanotify_is_error_event(u32 mask)
>
>  static inline bool fanotify_is_mnt_event(u32 mask)
>  {
> -       return mask & (FAN_MNT_ATTACH | FAN_MNT_DETACH);
> +       return mask & FANOTIFY_MOUNT_EVENTS;
>  }
>

This should have used the macro from the first use in patch 2.

[...]

> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_ba=
ckend.h
> index 6c3e3a4a7b10..54e01803e309 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -58,6 +58,8 @@
>
>  #define FS_MNT_ATTACH          0x01000000      /* Mount was attached */
>  #define FS_MNT_DETACH          0x02000000      /* Mount was detached */
> +#define FS_MNT_CHANGE          0x04000000      /* Mount was changed */
> +
>  #define FS_MNT_MOVE            (FS_MNT_ATTACH | FS_MNT_DETACH)
>
>  /*
> @@ -106,7 +108,8 @@
>                              FS_EVENTS_POSS_ON_CHILD | \
>                              FS_DELETE_SELF | FS_MOVE_SELF | \
>                              FS_UNMOUNT | FS_Q_OVERFLOW | FS_IN_IGNORED |=
 \
> -                            FS_ERROR | FS_MNT_ATTACH | FS_MNT_DETACH)
> +                            FS_ERROR | \
> +                            FS_MNT_ATTACH | FS_MNT_DETACH | FS_MNT_CHANG=
E )

Please add those bits as a group in patch 1:

@@ -80,6 +80,9 @@
  */
 #define ALL_FSNOTIFY_DIRENT_EVENTS (FS_CREATE | FS_DELETE | FS_MOVE |
FS_RENAME)

+/* Mount namespace events */
+#define FSNOTIFY_MNT_EVENTS (FS_MNT_ATTACH | FS_MNT_DETACH | FS_MNT_CHANGE=
)
+
 /* Content events can be used to inspect file content */
 #define FSNOTIFY_CONTENT_PERM_EVENTS (FS_OPEN_PERM | FS_OPEN_EXEC_PERM | \
                                      FS_ACCESS_PERM)
@@ -108,6 +111,7 @@

 /* Events that can be reported to backends */
 #define ALL_FSNOTIFY_EVENTS (ALL_FSNOTIFY_DIRENT_EVENTS | \
+                            FSNOTIFY_MNT_EVENTS | \
                             FS_EVENTS_POSS_ON_CHILD | \

I am aware of the inconsistency of the names ALL_FSNOTIFY_* and FSNOTIFY_*
but if you look at master as of last night you will find:

FSNOTIFY_CONTENT_PERM_EVENTS and FSNOTIFY_PRE_CONTENT_EVENTS

(please rebase)

One day we may cleanup ALL_FSNOTIFY_DIRENT_EVENTS and
ALL_FSNOTIFY_PERM_EVENTS to conform.

Thanks,
Amir.


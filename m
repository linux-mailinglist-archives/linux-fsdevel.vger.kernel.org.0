Return-Path: <linux-fsdevel+bounces-34686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8099C7B06
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 19:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E262E282D8D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 18:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30CF2036EE;
	Wed, 13 Nov 2024 18:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDdE52/T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC111FE0F8;
	Wed, 13 Nov 2024 18:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731522366; cv=none; b=uh1TMEJD2mvBRr5ECl8TlJiFnRkwUly5ZmfQvXKDpxjY9oaVj1xZnWuT600KRShyYIanWmWuDKRG6xmGYkXrhoEodFbkxmQ9cx923bh56bw7maV1wSdByESdAAFf1eaUBaoENzCG/R3Z2/aGSdj0HRantEY0ec6trbYQ2Ez1Ahw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731522366; c=relaxed/simple;
	bh=WA94T5jgN0zpdJt1zlpKvS9AQMF31zwZaCTaPC0MNPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WKpmoKlXXE9qW9BLJ3tVmGj4k7kDn+YqS3pOTZ6FPWv+756FR2uGM7oJASty+1TBNWh7KWvfdfNtxRDIDVVKbLTL+dRdzI1WkiQDSrO/j4WLM/pd0exOwfadm1m0gw8H8e1tv+qeh2z3FO5iqV+6chDOR3xlWndJxvWXg1utT5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDdE52/T; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6cbe700dcc3so49105026d6.3;
        Wed, 13 Nov 2024 10:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731522363; x=1732127163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0dcZ2I9Hai+ox/2ELeoGLFzko3gEU+akmOmMIKSkPo=;
        b=FDdE52/TP5mduXJrfQv3vxBtKszGy82yFZnaAWM1n5GI+lrLr2nK4nrugzaS7zBtrB
         dexI9lmPr+hy0Mm6S1elCPI3CbwJrdoLhwEKTADlEYpmM4SQPyv0z7PO2DBhMk+Kp0B1
         hWSUYGpvFhxmkuHwd1ZjcDbQDLRBN5JlXb1UXoldmLRlJV1oI4hoY9k5iN0gvSon4arL
         qqHm4MlHbrmBqyqUBCgKWyosI1m0+eckb60K7t90dvNg2BIiBkYA0VUZaX8dAgRpr0Iq
         wCGv1yHt5FEHpZkdmmc8H2F6mhyGFbrAGrhnMghzlyP2tpmlI4mCCMMprwnQHHqBYHtR
         ntHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731522363; x=1732127163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0dcZ2I9Hai+ox/2ELeoGLFzko3gEU+akmOmMIKSkPo=;
        b=URRyJw+VJTySuWAi1HrfAGkiBmjs/cZfhQmi7bidFOlBCRGIsT8GCRQ/8T7QZk/v52
         jEbUz0F21rnerFn4/K0r55umdf6nchgGkt0+mNbZHomHfY9ECX/bqSkbsLlTQ0umvy4K
         fWQy3RuECtANwTiqr7HdgirR4IDczHiLRxWFE6Z9jtKLyiG3Q/X5vujke9EBRG4Os9zi
         NHPgU2uYUZVJnVo26QFqz4KsNCefhK9hkYqGplPCt680U8MH0c3530dv6PZfhI9Xn+TX
         8xwtRnhquyrrTezk2DRaul/oo4ZLPJ/J7CgBafV4Sfp+4WJCfdZqg0LMIXFMw1tzAmei
         S6EA==
X-Forwarded-Encrypted: i=1; AJvYcCUgzLuGnSM0fp2CTydhUjGnxlY0VsRrm/IBrr86dFtXab9i6ACgM0vPnG6WjCFOqVNnSBLFt+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXJutotDyKqrtijydjoyWdeeosuPRGS4UTM9LYUmViaB21sMK/
	gqZAb0pr/F2PBNSQ6SZ5Vpghu0as/VheKCx1GlOt7aeHeY9gfkMDnSgaK9o848sdCTNCwfob0wq
	yPrmbxbvCI85J2jLZkWTRxC8bI/I4l33W
X-Google-Smtp-Source: AGHT+IEJfwePPlfVVrqJAjjQqzWY0AtFuykkyeKTnRFqInIcdvIW7MXWcJah7cB998HAbug4AfysU8STH08A8bbFcfQ=
X-Received: by 2002:a05:6214:428d:b0:6cb:f907:ae4b with SMTP id
 6a1803df08f44-6d39e17feabmr291203086d6.20.1731522363388; Wed, 13 Nov 2024
 10:26:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113155525.22856-1-jack@suse.cz>
In-Reply-To: <20241113155525.22856-1-jack@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 13 Nov 2024 19:25:52 +0100
Message-ID: <CAOQ4uxghXtO=f_1bPv=w3030XikY4BmmxuWpxhgRFfj1B5TMYg@mail.gmail.com>
Subject: Re: [PATCH v2] fsnotify: fix sending inotify event with unexpected filename
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 4:55=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> We got a report that adding a fanotify filsystem watch prevents tail -f
> from receiving events.
>
> Reproducer:
>
> 1. Create 3 windows / login sessions. Become root in each session.
> 2. Choose a mounted filesystem that is pretty quiet; I picked /boot.
> 3. In the first window, run: fsnotifywait -S -m /boot
> 4. In the second window, run: echo data >> /boot/foo
> 5. In the third window, run: tail -f /boot/foo
> 6. Go back to the second window and run: echo more data >> /boot/foo
> 7. Observe that the tail command doesn't show the new data.
> 8. In the first window, hit control-C to interrupt fsnotifywait.
> 9. In the second window, run: echo still more data >> /boot/foo
> 10. Observe that the tail command in the third window has now printed
> the missing data.
>
> When stracing tail, we observed that when fanotify filesystem mark is
> set, tail does get the inotify event, but the event is receieved with
> the filename:
>
> read(4, "\1\0\0\0\2\0\0\0\0\0\0\0\20\0\0\0foo\0\0\0\0\0\0\0\0\0\0\0\0\0",
> 50) =3D 32
>
> This is unexpected, because tail is watching the file itself and not its
> parent and is inconsistent with the inotify event received by tail when
> fanotify filesystem mark is not set:
>
> read(4, "\1\0\0\0\2\0\0\0\0\0\0\0\0\0\0\0", 50) =3D 16
>
> The inteference between different fsnotify groups was caused by the fact
> that the mark on the sb requires the filename, so the filename is passed
> to fsnotify().  Later on, fsnotify_handle_event() tries to take care of
> not passing the filename to groups (such as inotify) that are interested
> in the filename only when the parent is watching.
>
> But the logic was incorrect for the case that no group is watching the
> parent, some groups are watching the sb and some watching the inode.
>
> Reported-by: Miklos Szeredi <miklos@szeredi.hu>
> Fixes: 7372e79c9eb9 ("fanotify: fix logic of reporting name info with wat=
ched parent")
> Cc: stable@vger.kernel.org # 5.10+
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Looks good,

Thanks,
Amir.

>  fs/notify/fsnotify.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
>
> This is what I plan to merge into my tree.
>
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 82ae8254c068..f976949d2634 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -333,16 +333,19 @@ static int fsnotify_handle_event(struct fsnotify_gr=
oup *group, __u32 mask,
>         if (!inode_mark)
>                 return 0;
>
> -       if (mask & FS_EVENT_ON_CHILD) {
> -               /*
> -                * Some events can be sent on both parent dir and child m=
arks
> -                * (e.g. FS_ATTRIB).  If both parent dir and child are
> -                * watching, report the event once to parent dir with nam=
e (if
> -                * interested) and once to child without name (if interes=
ted).
> -                * The child watcher is expecting an event without a file=
 name
> -                * and without the FS_EVENT_ON_CHILD flag.
> -                */
> -               mask &=3D ~FS_EVENT_ON_CHILD;
> +       /*
> +        * Some events can be sent on both parent dir and child marks (e.=
g.
> +        * FS_ATTRIB).  If both parent dir and child are watching, report=
 the
> +        * event once to parent dir with name (if interested) and once to=
 child
> +        * without name (if interested).
> +        *
> +        * In any case regardless whether the parent is watching or not, =
the
> +        * child watcher is expecting an event without the FS_EVENT_ON_CH=
ILD
> +        * flag. The file name is expected if and only if this is a direc=
tory
> +        * event.
> +        */
> +       mask &=3D ~FS_EVENT_ON_CHILD;
> +       if (!(mask & ALL_FSNOTIFY_DIRENT_EVENTS)) {
>                 dir =3D NULL;
>                 name =3D NULL;
>         }
> --
> 2.35.3
>


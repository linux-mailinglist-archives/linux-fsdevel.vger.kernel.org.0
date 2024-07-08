Return-Path: <linux-fsdevel+bounces-23304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECA892A752
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 18:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40B9A1F213C9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 16:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC23146D7F;
	Mon,  8 Jul 2024 16:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6t6LQE8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286FF1465BD;
	Mon,  8 Jul 2024 16:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720456193; cv=none; b=bmNAIkur/hUmkatpJ0kHSxmTwHfvPaw//gIR2gTBE8hU7VdICvelDEdvLUvnO4EnL31vEgk3Y84jRxZfkGUt1ndL1rllun6rfIptgBcvsAeb3XM7C0rYghLqSYXWpP3sYCThNI53fwvyAoCRWqHUnRV6w6TuvyVI78MDgUsLC6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720456193; c=relaxed/simple;
	bh=P73h9CemVjlyMHE2D0gA6fo06QColbF4mSOfETqH1YA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D4mluizvlQmcFlA5/Mmb3IFK6tDFPbYdVRUiO9WsaPQSZjRG/bIFXXew52/mJiMChEvpw2CTi0GPkj8v5Mu8+qbf0+LqpexW3ofQnH0qLnsLY1J9DJVTiKVt16Tms2mwC+Q8xM0VvwZ96Fn8pf7KQYBijJe+5D/iXdzsa3aH5S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6t6LQE8; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-79f18509e76so17225385a.1;
        Mon, 08 Jul 2024 09:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720456191; x=1721060991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P73h9CemVjlyMHE2D0gA6fo06QColbF4mSOfETqH1YA=;
        b=L6t6LQE8oxBJzTphgyvJandROoKZqAKQEWA0y/yWwwqFvnK3PI3TiazmW7STrLF2mx
         vhUdia6iO1umq4VtCzKAWJHuNg2gf4wseWZlkYZ+YT450w+IcvQYPrdJ0W6SzkUE8B6X
         KDxvnwIDDKgfdRdn62ELGGRbCvHEGXe8AwIRWbvJt03aGlA21sFNWND1u39ZcthkC0KY
         Wdrcpe09IlxOlK5cTxLgLJkES2bArGuYfYxheDGtmkEm9zf7gho6L7UB6PVFUxmHYt+T
         xeM9JxfnyF62m4AoLt431wusskN6Z/dTjyMWMfYIwGhgsqra2oOusIMjGqD3HePqmRhb
         zLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720456191; x=1721060991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P73h9CemVjlyMHE2D0gA6fo06QColbF4mSOfETqH1YA=;
        b=To1rSgMpTBU+/AoGIqUGTiHFK8Q+stI6zuGJL3kAnDragYgV1fmJmAdum3q4AQN4Pm
         0oKi6Y9jCUvgRb7projrdWyJDpyrAR5tW9za8qOon9ykU9Lv93vwMPjQkmXu3SupGr2Q
         VjhhAiFsKG+0uFvtrPJ03dpL1Q03KiL5+d7Ifk9UZQYbZlPUEKURL6bVpgv1tCzSFWNr
         FGyoJMtYdbIJVDLIuOunQgwnHYMrr6nS9MyQxgaHzE/MYak0gGmL/u4TaewJi46iebH6
         T7RxkvxJ2UklIskY2CEC7iLgq0GeTTWrMCSm7ltvCQNjazf0juAbPVlxV7Fzhl8CRUdV
         ustw==
X-Forwarded-Encrypted: i=1; AJvYcCUBzUw0dfG5Ldbc6O7VES5h4LUoBXW1PAzaQbW1wUt+RlHAlc2zcCSzoZV+RpJ1m+4m3nA2UecW3rGR8PUQrYNBX7lOpppyRgnWp3FHAjRFC8JQVV6mcJ2j9zI3VpkcCOsf2NHw2Fv1W0fDLg==
X-Gm-Message-State: AOJu0YzIwgjexkLyI9B39hvFe2uDroZE9C7lsX91F2PnvkIP7tk7tUjY
	SSOxru04uZTXZtOJrqL7scsmN7CAWK+5aKlj0JQnlVqdNWV5q6p574DoYLPeMpP2boA57HrV8zT
	mMNgw0VONO4NYTP9JQMbV9lF7HuTDnPYPmR8=
X-Google-Smtp-Source: AGHT+IG7Jq8a98fw+LtxFa87ZaQNKdmuNiKhkrc4uJUd2mbcxpJolz8/k2rzGlmy0HHLQdIvXKUMsmmJaMgaInuHybo=
X-Received: by 2002:a05:620a:225:b0:79f:4d5:efca with SMTP id
 af79cd13be357-79f19a52608mr4956185a.44.1720456190968; Mon, 08 Jul 2024
 09:29:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708101257.3367614-1-lizhigang.1220@bytedance.com>
In-Reply-To: <20240708101257.3367614-1-lizhigang.1220@bytedance.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 8 Jul 2024 19:29:39 +0300
Message-ID: <CAOQ4uxg72R6Ho2f-HDyc7DsPBvw=8pkgSuGkwC17oNeKTu=_UA@mail.gmail.com>
Subject: Re: [PATCH] inotify: Added pid and uid information in inotify event.
To: lizhigang <lizhigang.1220@bytedance.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 1:13=E2=80=AFPM lizhigang <lizhigang.1220@bytedance.=
com> wrote:
>
> The inotify event only contains file name information. Sometimes we
> also want to know user or process information,such as who created
> or deleted a file. This patch adds information such as COMM, PID
> and UID to the end of filename, which allowing us to implement
> this function without modifying the current Inotify mechanism.
>
> This function is not enabled by default and is enabled through an IOCTL
>
> When enable this function, inotify_event->name will contain comm,
> pid and uid information, with the following specific format:
>
> filename____XXX,pid:YYY__uid:ZZZ
>
> Pseudo code to enable this function:
> int rc, bytes_to_read, inotify_fd;
>
> inotify_fd =3D inotify_init();
> ...
> // enable padding uid,pid information
> rc =3D ioctl( inotify_fd, TIOCLINUX, &bytes_to_read);
>
> Log example with this function:
> CREATE,ISDIR /home/peter/testdir____mkdir,pid:3626__uid:1000
> CREATE /home/peter/test.txt____bash,pid:3582__uid:1000
> OPEN /home/peter/test.txt____bash,pid:3582__uid:1000
> MODIFY /home/peter/test.txt____bash,pid:3582__uid:1000
> CLOSE_WRITE,CLOSE /home/peter/test.txt____bash,pid:3582__uid:1000
> OPEN,ISDIR /home/peter/testdir____rm,pid:3640__uid:1000
> ACCESS,ISDIR /home/peter/testdir____rm,pid:3640__uid:1000
> ACCESS,ISDIR /home/peter/testdir____rm,pid:3640__uid:1000
> CLOSE_NOWRITE,CLOSE,ISDIR /home/peter/testdir____rm,pid:3640__uid:1000
> DELETE,ISDIR /home/peter/testdir____rm,pid:3640__uid:1000
>

Please take a look at https://man7.org/linux/man-pages/man7/fanotify.7.html

It already reports pid and the event format already supports info extension=
s,
so adding uid would be easy (opt-in not via ioctl but via
fanotify_init() flags),
if you can justify the use case for this feature.

There are still some differences between inotify and fanotify that
could make people want to use inotify, but generally, I would not like
to extend inotify API like this.

Thanks,
Amir.


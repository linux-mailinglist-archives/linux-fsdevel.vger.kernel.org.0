Return-Path: <linux-fsdevel+bounces-37277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2D59F077E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 10:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF75C286268
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 09:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6C01ABEDC;
	Fri, 13 Dec 2024 09:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaH/Wl+G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725602A1BB
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 09:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734081447; cv=none; b=gLO73kATGHwLwwLKh26Uck/DTaQIaHWghQusZ4G04Wc52Pk/ObEx3WRQuzY3vssGpuQd9ErpKEp2qnUbGSQeW3XXsxTC52pRhhOQpGkH2YBgx29fBD/kaU1V/5cpTsdL3kLhFo/jn0/N/9cPEXFHTCeK5LlF+OsZQSSjVrrVHCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734081447; c=relaxed/simple;
	bh=2YLdsA7hgyf3x8PSzgNpXGJzrhdMFE4xI7h+Vk8j2/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NHrXCED2lzBlGmeEzqW3gIV4rH7/tzfccLn6/CZ71++gCQiEbfCzIUPNry9qQfMEZQMVkwOAdgI3Ofw1PPIgy+zK5DljVzDgBZnxChsJ+h69BH0dbr+Bk4KSDONrkm+T6MN37Sg3q7+OLDM3FpiST8Nh9IITk4++/j6BjMleG60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CaH/Wl+G; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e3983f8ff40so1027733276.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 01:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734081444; x=1734686244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dIO1OutBq4oMp2ctxuegtjDRTsSXpcaNetfjUQTBXys=;
        b=CaH/Wl+Gzt/jFKnh1A+EYU9LbYwgAhre5xwkBgtmiMYKdkipLD48PFkNMcN78G4bjo
         CPrYSeF8LqUHJ2Pv/GFTJmJdcNQ25q72yVH2JlOLV1zRM+Dy6fWlOvjg5QH8O+c4SBJR
         /0wKnIacTHdEPp6wIgbkzqxODJQHaUYAITr95s7Vu8dvjZ2xQ5shbZxvWR/GfET0sQU3
         rKnNHbkLxezdwC1LTrYJFgq5zrUoer5CtelxosQ+T3MBJJEyHg/ijHr26JhiSePPB/i1
         DvOq2x07/5fAjZDHk+9h+cqQAHS40wxuefd+UmRmywsOmlDgPy6a55PyblKaGMBZeg3X
         n1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734081444; x=1734686244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dIO1OutBq4oMp2ctxuegtjDRTsSXpcaNetfjUQTBXys=;
        b=nIsfoK7UYUdN2hiEjhnjj2QAun/U7vdhr3bzGtlWm48ox9PxWlX5YcgAzVDnQQLATB
         sQU18+RoG17hrZmkFs/4mdVdYXj+ls1KGwkUBF3mAsdheFGNk1771B9HVBrdGz6jUUXc
         e6z7Ukr6QXLwGGq8GMrvM3huVXwMVS72wy9lBE8ztG6YrFSMd+xpoQTjHnRkwxGEITYk
         ltKVrFEiFh3CEeHq+9eZl9ha11Ed6k2ev9NK5QcUyMZCa1SDpfBp06GNCHDyMB4wbTa3
         t63n+wUYlF9jMTRwwIgFqUlypKhnVdho2/UNK5AUTRE2GYYALvI9qfivKbimo5PWD5Ik
         JMaw==
X-Forwarded-Encrypted: i=1; AJvYcCU9Fn3NfzPC2oIFzUlHgGosHF04eIRS41Qci1D6jyGf1JGt/qqQiVDVjk1Y1yvMACn/I3W/+/CkIjbBkoRJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyXl62JX58wCFqTpw5QUGYNyRCdoGKqzmBr6yNoPwQG4VekrhLG
	KL8B7mQzX/QFlCuG4etST8Tm4bHXLTcYw3WKVFNr5k13pfJDCiT6mcETAj1tWpyV14nYuWxXXhP
	FQXWnrwgYv2d3GIu/UZJBRW+hTonPkWGP
X-Gm-Gg: ASbGncswF6lBQiVUJv5yXt9PvnQzkg1oMtOWQjXnZwQkb29vWF0CYmsXI8TX/6dreeL
	A+XQ3bOqcGwSZwq/X9zDTsw75i4PV5hxiRMqfhkDQV1ahX0pJIlf9ICEXC/BtGpovAog=
X-Google-Smtp-Source: AGHT+IGZi/LMI9blVzghzV5uiAoJudbMH0hyNJo4Of8XvjZAfvxg2DTUtK1zT4QsfFEEQfnoLn2WyM6X8snnG/1jS9U=
X-Received: by 2002:a25:884:0:b0:e44:82ef:396a with SMTP id
 3f1490d57ef6-e4482ef4029mr425917276.4.1734081444270; Fri, 13 Dec 2024
 01:17:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212-fuse_name_max-limit-6-13-v1-0-92be52f01eca@ddn.com> <20241212-fuse_name_max-limit-6-13-v1-2-92be52f01eca@ddn.com>
In-Reply-To: <20241212-fuse_name_max-limit-6-13-v1-2-92be52f01eca@ddn.com>
From: Shachar Sharon <synarete@gmail.com>
Date: Fri, 13 Dec 2024 11:17:13 +0200
Message-ID: <CAL_uBtdkKPyugSmE_axmNa-wv472vBUO5N12J9veKkxGuy2MYg@mail.gmail.com>
Subject: Re: [PATCH 2/2] fuse: Increase FUSE_NAME_MAX to PATH_MAX
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The <linux/limits.h> defines NAME_MAX as 255 (_not_ including nul) and
PATH_MAX as 4096 (including nul). It would be nice to keep this
convention also on the FUSE side; that is, define FUSE_NAME_MAX as
1023, or in your case (3 * 1024 - 1). I think this is the also
intention of the code in fuse_notify_inval_entry:

  err =3D -ENAMETOOLONG
  if (outarg.namelen > FUSE_NAME_MAX)
          goto err;

Otherwise, we should fix this check as well (outarg.namelen >=3D
FUSE_NAME_MAX). That said, keep in mind that using dir-entry names
larger then NAME_MAX would also cause ENAMETOOLONG by glibc=E2=80=99s
readdir[1]

- Shachar.

[1] https://github.com/bminor/glibc/blob/master/sysdeps/unix/sysv/linux/rea=
ddir_r.c#L52-L59


On Thu, Dec 12, 2024 at 11:51=E2=80=AFPM Bernd Schubert <bschubert@ddn.com>=
 wrote:
>
> Our file system has a translation capability for S3-to-posix.
> The current value of 1kiB is enough to cover S3 keys, but
> does not allow encoding of escape characters. The limit is
> increased by factor 3 to allow worst case encoding with %xx.
>
> Testing large file names was hard with libfuse/example file systems,
> so I created a new memfs that does not have a 255 file name length
> limitation.
> https://github.com/libfuse/libfuse/pull/1077
>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/fuse/fuse_i.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 74744c6f286003251564d1235f4d2ca8654d661b..91b4cdd60fd4fe4ca5c3b8f2c=
9e5999c69d40690 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -39,7 +39,7 @@
>  #define FUSE_NOWRITE INT_MIN
>
>  /** It could be as large as PATH_MAX, but would that have any uses? */
> -#define FUSE_NAME_MAX 1024
> +#define FUSE_NAME_MAX (3 * 1024)
>
>  /** Number of dentries for each connection in the control filesystem */
>  #define FUSE_CTL_NUM_DENTRIES 5
>
> --
> 2.43.0
>
>


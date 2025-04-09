Return-Path: <linux-fsdevel+bounces-46122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42584A82D73
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 19:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2280D444CD1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 17:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E762276021;
	Wed,  9 Apr 2025 17:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbjJ30Q8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D98F1D5160;
	Wed,  9 Apr 2025 17:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744219051; cv=none; b=fdaVF2APXG/JWTp2irEB6RGZ1a0hBn3rOEYpucBeqryGAT9HqJxGV0uI/985c6Cc1Gm5P9i2xoEo8foNvSrwss/VQpespF5dhrbu35e6Kl8RWNNfmsPGSfzrkSpOXc6CidXw/19WKy7vBBZNtqVaffg3ZPqsKKoGL1sc//gYP5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744219051; c=relaxed/simple;
	bh=oG1XpsnmZMgS6W1f2ESImGKuTZ1RSerPiAWqKD5r30k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T9x2tM25PD6GrLnawkVoD3isc1a+XPVpHYikJWeKywGNJnYmja9jwv5OHkqEDhee1OrcmqIymU6BxMKU8VoWPwuSpJ7f67qytRq61jXfER9w8gaGHHfaOMNUvjz0EDnNT+EXnwjsqMDfPkKfsuHNmIvo4pUwBXeYvNIPfCihfek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UbjJ30Q8; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e8be1bdb7bso11366179a12.0;
        Wed, 09 Apr 2025 10:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744219048; x=1744823848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcMr2WswXxqD9O8dPFeqV99p5x+vz6aKhmjsl5xuOwM=;
        b=UbjJ30Q8CerDxyYwD0ZSPrLLx/J+NGIIPXyN+5ceg8bs78LRAfn780Ho7BSIJ/ETd+
         XFUFA7J9Bmp/5oICbecVUugkaV0E61/bLlLtMWWTxEpe/n2ianFS41mgiFzCfWrR2fef
         QTW7oGXW6pURJof1MYKchzzy1VwYWWTqb4r4YlwtjmMNmsU1dKeLw/62v5C2wF2ovLqO
         HBgPMhfjtkKI/ro+GS1N3ieqJhA1UH9s1Ad1v6iLrKIz0fQz99pBBiDMf91iAfNhCIcF
         pzrmw1QNwnDOz5TIhHGP76wQ48PtXlVsw5F1Df7ct2ao/STawC5D8pu8HEAaTMEHELAh
         89Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744219048; x=1744823848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CcMr2WswXxqD9O8dPFeqV99p5x+vz6aKhmjsl5xuOwM=;
        b=YtR7YCOe/2wm8OFRB3SO6cZMkXr3tIzHYUNq1uqWuRUlKpd6sUPnlhaNfHj2qInp8N
         hfMSB7hFKiLXIXE58VcdAMciJyFoTgialRVA1reQco4iAXFPUfMTd1P+ZA3U6bLQ8mt/
         Q3Ci62uwmn3k+77anmf3W9QbaimMNIAhN4dklSYmybHZn0SpH8zF6XxPN87ZD2Vw2WDk
         pndvLvzfdKgSsellbPXdzhAIeWbuOrwt5/7pIex2qNUCJXxos1dzTL467ZNhkBdhIXu0
         6FowkVmydv0bPFT2i6+Is7OPoPYwuRANAKzdW1HicOte6+MqFSWJCW5+bkCNDbPvcZE4
         TP4w==
X-Forwarded-Encrypted: i=1; AJvYcCVq7vl7uqcKgWgs1bvl0L7bWXoBCYTQi8RlqFuhwlP3V+PnxpUMINXqlOAc9X5ONFUGITBkFgmTZQ65JokDbw==@vger.kernel.org, AJvYcCWO4+p+Yd41pBilytuiIS/CJpnCR6QbRQBXhLXf/QakohCtcZ3KPJJ6R0ht3oKO5Gm/rmh9RQIALDAd/iZ2@vger.kernel.org, AJvYcCWxv7NH9JOi1bI6VNk90TwwM0rx6U5YBs6xp2DDhT+fs4SHXkS3tHGv6JNFKpCF1xpQQLAcFK4ltvMK8rVV@vger.kernel.org
X-Gm-Message-State: AOJu0YzJAKFMitTeYoorYYb9vgQsca9WTF/q4fKTjDfjG88Pl2qoIwt3
	fVtnthcTRUR2DUCM8GPVAuybAg3hXVlwu/d9W/E09etlxC3TTXo7U1uQwlCVQLB/SbjCKd4MADq
	9W9U4mqNUBedKAVVYQQ9BwX7XFxQ=
X-Gm-Gg: ASbGnctxAUQ9zDypRZXpxgb9QaOB2rrEg59zowNO9ojtZ6TqFVjCbvIvMPGhSIP4p37
	+8IRNm/7u/EvJcgKIlc2hXY4QgIgX7jHDiY5o5UkN2lNwkXu0cieWpQosgO8jIDdNHml8Gebvii
	WacIHd8TJQos+kNHu43fDbCl8jkpfQFNI8
X-Google-Smtp-Source: AGHT+IF04PadMDXpfDEi4BXQjRN+FQazc2gzuE2WTQVFibWnjAGtbBhRfLN4Dn9al/wpkrcQIVDgiceCR7jghAjrsro=
X-Received: by 2002:a17:906:6a2a:b0:ac3:eb24:ab26 with SMTP id
 a640c23a62f3a-aca9b734e25mr343573766b.51.1744219047996; Wed, 09 Apr 2025
 10:17:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409-tonyk-overlayfs-v1-0-3991616fe9a3@igalia.com>
In-Reply-To: <20250409-tonyk-overlayfs-v1-0-3991616fe9a3@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 9 Apr 2025 19:17:15 +0200
X-Gm-Features: ATxdqUGAVRsl9nEX4oKdjlJpAAzfHJXhbwwPJiTK5spEdYhZ92SxGUtI2rXTogM
Message-ID: <CAOQ4uxiwv8F9p8L98BiX8fPBS-HSpNhJ_dtcZAkqM02RA0LuVQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] ovl: Enable support for casefold filesystems
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, 
	Gabriel Krisman Bertazi <krisman@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 5:01=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@igal=
ia.com> wrote:
>
> Hi all,
>
> We would like to support the usage of casefold filesystems with
> overlayfs. This patchset do some of the work needed for that, but I'm
> sure there are more places that need to be tweaked so please share your
> feedback for this work.
>
> * Implementation
>
> The most obvious place that required change was the strncmp() inside of
> ovl_cache_entry_find(), that I managed to convert to use d_same_name(),

That's a very niche part of overlayfs where comparison of names matter.

Please look very closely at ovl_lookup() and how an overlay entry stack is
composed from several layers including the option to redirect to different =
names
via redirect xattr, so there is really very much to deal with other
than readdir.

I suggest that you start with a design proposal of how you intend to tackle=
 this
task and what are your requirements?
Any combination of casefold supported layers?

Thanks,
Amir.

> that will then call the generic_ci_d_compare function if it's set for
> the dentry. There are more strncmp() around ovl, but I would rather hear
> feedback about this approach first than already implementing this around
> the code.
>
> * Testing
>
> I used tmpfs to create a small ovl like this:
>
> sudo mount -t tmpfs -o casefold tmpfs mnt/
> cd mnt/
> mkdir dir
> chattr +F dir
> cd dir/
> mkdir upper lower
> mkdir lower/A lower/b lower/c
> mkdir upper/a upper/b upper/d
> mkdir merged work
> sudo mount -t overlay overlay -olowerdir=3Dlower,upperdir=3Dupper,workdir=
=3Dwork, merged
> ls /tmp/mnt/dir/merged/
> a  b  c  d
>
> And ovl is respecting the equivalent names. `a` points to a merged dir
> between `A` and `a`, but giving that upperdir has a lowercase `a`, this
> is the name displayed here.
>
> Thanks,
>         Andr=C3=A9
>
> ---
> Andr=C3=A9 Almeida (3):
>       ovl: Make ovl_cache_entry_find support casefold
>       ovl: Make ovl_dentry_weird() accept casefold dentries
>       ovl: Enable support for casefold filesystems
>
>  fs/overlayfs/namei.c     | 11 ++++++-----
>  fs/overlayfs/overlayfs.h |  2 +-
>  fs/overlayfs/ovl_entry.h |  1 +
>  fs/overlayfs/params.c    |  5 +++--
>  fs/overlayfs/readdir.c   | 32 +++++++++++++++++++++-----------
>  fs/overlayfs/util.c      | 12 +++++++-----
>  6 files changed, 39 insertions(+), 24 deletions(-)
> ---
> base-commit: a24588245776dafc227243a01bfbeb8a59bafba9
> change-id: 20250409-tonyk-overlayfs-591f5e4d407a
>
> Best regards,
> --
> Andr=C3=A9 Almeida <andrealmeid@igalia.com>
>


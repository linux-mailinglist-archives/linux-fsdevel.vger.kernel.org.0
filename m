Return-Path: <linux-fsdevel+bounces-52490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 122B2AE36B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 09:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F7E4168286
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 07:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BDB1EFF9F;
	Mon, 23 Jun 2025 07:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6e56gzS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81821EF394
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 07:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750663481; cv=none; b=TLUIY3ZtEN470TX7PHo+KOW2oGZ+SPMBTG3eshLBK9DY20REpX/pcEAozfiyLkHWot7GFNKyKSTOlDzFwCCjU87711n0fTE5F5ny90lr4sthCfUHjLKaC1U4Y1BoM1JkhF9cTXvgOInbmJYI20iMcLPdE8tidYfjCYClmkmoDGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750663481; c=relaxed/simple;
	bh=aKY4yD28YYWDEjXY+G58AO1Bif5aQqKRzrKf55fISB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oGShlCmJACR2Bf7oU3ezzKUhYuvc+v3cOinc3AuIOk9yDhpHf5Rs+OQaPln85Ka0jWVWoW5CjsaTDO0693mGCueBMTAIEGa6ccQ+QwLKmLhZ2JAjE1vfcxuE8zEx1hEod6tSZYqaayXuz7mjJJRcvJhfxq41ua51YPHf+PVOcQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6e56gzS; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ade4679fba7so741527366b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 00:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750663476; x=1751268276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnSgO9Cld+q9sOUqcUD5sOdXYXrCthqgrIwLD/AZjfo=;
        b=d6e56gzSfv/NlD+dpiDtlxnaKPDpwzEQUJBn0Q7Iq1OhLJVorYexLRKn8z2D0yuVFY
         FAqtlsEEhfhMDrcjcOgc/exoGz7wqaZChg9pNQO9Vq3qmAiRV3wb01ett9CmGjVIY/Dr
         9S7DBXoOvF44D8rTXq9ffTjCxmvKNRHsCTs00OQFul0bfJ9+ajL1oVMipe3vjTQWmh1d
         qBkoxtDCILhzXiJcPXifXZ9BPz3xO6IPoAzO5pMeUKHlT6iyKarnvWYThce5d2sYf2pj
         DochJWPi85TgLKAjTvduCV/5dmcfQ8wCHHz1Pelt4cZwXfyXjpxxDZTIdouobPT5GeEd
         nBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750663476; x=1751268276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jnSgO9Cld+q9sOUqcUD5sOdXYXrCthqgrIwLD/AZjfo=;
        b=Nkb0wf6A/S/wAffE4wXRA10Jk5jjSGEhmKxlzXZi9LrobytuH//iHRlbd9VlXYGAan
         Pcdwpq02tE/LoqfT5S6vN9WDIpvcUvx+Z9SlL5kwC3edy6qfoztaLNuyOkJLIhyufzEx
         +McsyxL9+teBa1r29TJH05E9tPxjZUZcMvhcTuCKo2perG6Dpv0N3bY9UwwTkrRqZCHl
         KUVcCToA4xZwRMCO2iNc4ovvB/MI7BGybo8rcsRrkyV4QTvaFm4tGs5NpPMP7nfM1e2W
         Gahg5qNDuIIf72VqxUt6jO9zeHtm1OmnPi7wIGHRl6d581752aT4GiOxMzsXzv1c7rLg
         Oe3A==
X-Forwarded-Encrypted: i=1; AJvYcCUI8mNh0BltDVDnEaL4/qegrSC3YZVbgm4/vqSrylOVrFAGIA9Wm/Sc1KF5M1os0YW4iUVu2UGxD6de/4C0@vger.kernel.org
X-Gm-Message-State: AOJu0YxoqG/Zaq/IVFTY5KgPwnaaPQiaRPXRD003LX/xz3H0cNUqkGPZ
	S2yA9iEeDAZsiDAZ4vteEDlxbFBqHswcDFsPz7hr6P83frLBmnlEzyXMVc3ftbiaU7COuVVGmOO
	kBftbMamSKz7ghghXBLeyKsY7TAO4e7U=
X-Gm-Gg: ASbGncvg0EpIyVf6ogiPTtrbx6Lnij0yp9+hIm2rPFMOX+3fAnDnzlZW+PpirOHkc/G
	LYXV4kA57WAqb2to2TS96l9tsZb0X3NjRVfKw/fixYM8/xWVHflZNPh2WNcdwoiw6Jn27U+dp1a
	iZJkFo6z72oIjHeqKqnB3e5683pg7tNcEIxZt9FDIQBJA=
X-Google-Smtp-Source: AGHT+IFHySMxYGTnSvF1XOHqn7sUVXMSvr9YT6wbbBkdGFJZp/tsb5Fhr9kchbPtoG93tX8FCoD3VdeltW7atFZClFA=
X-Received: by 2002:a17:907:bacb:b0:adb:2f9c:34bb with SMTP id
 a640c23a62f3a-ae057b48d54mr1006541266b.49.1750663475632; Mon, 23 Jun 2025
 00:24:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250622215140.GX1880847@ZenIV>
In-Reply-To: <20250622215140.GX1880847@ZenIV>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 23 Jun 2025 09:24:22 +0200
X-Gm-Features: AX0GCFuFHgkwQWHNwiA3nArOxrXS2Ok-B3nI6YAvj3JxGejfwZRWtPizw2Yv2TM
Message-ID: <CAOQ4uxioVpa3u3MKwFBibs2X0TWiqwY=uGTZnjDoPSB01kk=yQ@mail.gmail.com>
Subject: Re: interesting breakage in ltp fanotify10
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Eric Biggers <ebiggers@google.com>, linux-fsdevel@vger.kernel.org, 
	LTP List <ltp@lists.linux.it>, Petr Vorel <pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 22, 2025 at 11:51=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
>
>         LTP 6763a3650734 "syscalls/fanotify10: Add test cases for evictab=
le
> ignore mark" has an interesting effect on boxen where FANOTIFY is not
> enabled.  The thing is, tst_brk() ends up calling ->cleanup().  See the
> problem?
>         SAFE_FILE_PRINTF(CACHE_PRESSURE_FILE, "%d", old_cache_pressure);
> is executed, even though
>         SAFE_FILE_SCANF(CACHE_PRESSURE_FILE, "%d", &old_cache_pressure);
>         /* Set high priority for evicting inodes */
>         SAFE_FILE_PRINTF(CACHE_PRESSURE_FILE, "500");
> hadn't been.
>
>         Result: fanotify10 on such kernel configs ends up zeroing
> /proc/sys/vm/vfs_cache_pressure.

oops.
strange enough, I cannot reproduce it as something is preventing
zeroing vfs_cache_pressure:

fanotify23.c:232: TCONF: fanotify not configured in kernel
fanotify23.c:249: TWARN: Failed to close FILE
'/proc/sys/vm/vfs_cache_pressure': EINVAL (22)

# cat /proc/sys/vm/vfs_cache_pressure
100

But I'll send a fix all the same.

Thanks,
Amir.


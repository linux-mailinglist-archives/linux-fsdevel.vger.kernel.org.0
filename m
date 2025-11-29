Return-Path: <linux-fsdevel+bounces-70262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C758AC945BC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 18:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8625D3473CB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 17:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E650B30FF2F;
	Sat, 29 Nov 2025 17:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBIQh5S2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2FC20B7ED
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Nov 2025 17:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764437618; cv=none; b=radKpkI/CHdZrrE+lve76f9JUguxHbPzzb8iHl0aw8eJryJA0laTCqItgitWRJUDZmpkeq4He9qFGrb//LwU+4SDCMmjAYRQ2+0wyNRpG+T/nKiZxE4iS6YgHTbwCqdevLWrEW3AdzNxz6AVcfR33RstZ06gIugPaV3WueDktu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764437618; c=relaxed/simple;
	bh=+lgN8J0IowAdNicv/d1NP7IzfMlJS8XCtDt0GRjHDXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DQNCPbIu7AX/Oo8/NVOHfQJiOXMhYVPShu13+7FeICud0Cxjpp7nKTdRjX6FWJ/2qbqmGDeQP2qX3xKfke6beW9uH/sBDFcuyajy20+Svve2GU1iUlMRbgm1EvEP8BWYcRGrYDthvc9c4yOPX53dnNZMqnwRO6EUeHlfF2ef2o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBIQh5S2; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b737cd03d46so422308466b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Nov 2025 09:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764437615; x=1765042415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqBHGbcsAsVVRiASRLwDbcSq7PIrgcMaytoi2qLw8ec=;
        b=cBIQh5S22M8W7nQha18KSIsIWPzTRaCbRI5sSO/+y2bwDuwhWZtyqruSKCsYmjmRLJ
         xfQKDzZZrOrZ6UsfwXxs29D5TS7Ob49q50+gUcBMVCuxirPP7vtZhSbOPjr8PdPchbAz
         zQaSH2gLKwAlYhO3VjKuZMCRydvPQlSKEOx+L+bQd9+8ZlYe02yuSvbBxcorQKHuh3ly
         HNHocYoXhoFSxsSSu8DsyggFt3SOTDCSkW5xsvzfiyu0GxIYIcBTKbu5o8gaVOvYUGFB
         cEfv7vGw2Yh2imYaTWPqLTBQiaOHXhPo0k7be8eRTExYYiMQgX3GcQUG//3gsJ8hGKtC
         3rTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764437615; x=1765042415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xqBHGbcsAsVVRiASRLwDbcSq7PIrgcMaytoi2qLw8ec=;
        b=MzAmz3u0HVKw0cKNCkEqSZijHxk16vPde8NDSAYyVlXg4dM5QsKkGBCUqLEBrqZyWg
         b/ipSM1o+ra0hT2W+XogyE0/6DYNwy4R5xP/rwPxEKvBs6FH51Ch14Adqdkh8Yy/d73A
         CpciET1vVVhBzk5EG/3ML1ps+e8uk3h7ZjoFmaJlOZWwT+uSfOx5dfPs5vKYrhL0qlup
         g8vRqmNeFWUpfi2z6SPpK44qVw9594X4lSiPCwj/v9WHs67eydBVsAR48cJEkwRXrXd6
         RklcW7UEKuj5bXaYPQ390nzEbdAFEqCDylLB75TQUQMusdX+BhJUKHuaiWwHdCNRlxM2
         /piA==
X-Gm-Message-State: AOJu0YzCVHMiCXB2+xgp8Yt9oxnLm51pDz25kUSdUhalVxqJ3QCzAqUq
	IKDnxcdwUGt1/tvT7SllXvTAL5L+6ubdAOciya8ZC+v8r28RimLqh4olExZb/PnjmfPGjdViXp7
	s+YUJ3kcv11+miTwuR4sMM8Zd46jzWGg=
X-Gm-Gg: ASbGnctJut5IwYS7ljfmzqXvuxL6VaNDZTeb/80CE/whzq2Sjc+s4ETUe/BJzeLzfdk
	QvsFb7s/HbYEDwA38vTrEbwvbauFt1CcvEB+ZfP+hKRLZOR43SrIHsFtQPJMqw08oT8gGJNX/3L
	agP9arnFcNI6Nc3/u40mItRhyLiq8uuBAvPdQ8ulYTo4+eWCfjYgX639a6po1+vshQ2txfdZW9l
	VRHHvVDJl1LtxlSSmkGX/ZbVnioo1MFTlziOexTchNn65fwP2SKMqgjVdmaRhBKNeOa7WkiRxFB
	4kEyaTzPUDdE32SVBEJcS1UBgw==
X-Google-Smtp-Source: AGHT+IGCyw0hgpfwbdp3a3E31TdyZ9pXIJL/jdDuy8vbFKa1VPNcT6NEqn4DspaZQIjyW4rDdWr2eMhKOKbCgdYDBbM=
X-Received: by 2002:a17:906:c14b:b0:b73:398c:c595 with SMTP id
 a640c23a62f3a-b767156556amr3928338466b.19.1764437614344; Sat, 29 Nov 2025
 09:33:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251129170142.150639-1-viro@zeniv.linux.org.uk> <20251129170142.150639-16-viro@zeniv.linux.org.uk>
In-Reply-To: <20251129170142.150639-16-viro@zeniv.linux.org.uk>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sat, 29 Nov 2025 18:33:22 +0100
X-Gm-Features: AWmQ_blvi087-G2CtHlEiHh6F6ijMslc1kpUveo4D1zCzMmn1FqYhm25LkTHXDE
Message-ID: <CAGudoHFjycOW1ROqsm1_8j47AGawjXC3kVctvWURFvSDvhq2jg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 15/18] struct filename: saner handling of long names
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, paul@paul-moore.com, axboe@kernel.dk, 
	audit@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 29, 2025 at 6:01=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>  void __init filename_init(void)
>  {
> -       names_cachep =3D kmem_cache_create_usercopy("names_cache", PATH_M=
AX, 0,
> -                       SLAB_HWCACHE_ALIGN|SLAB_PANIC, 0, PATH_MAX, NULL)=
;
> +       names_cachep =3D kmem_cache_create_usercopy("names_cache", sizeof=
(struct filename), 0,
> +                       SLAB_HWCACHE_ALIGN|SLAB_PANIC, offsetof(struct fi=
lename, iname),
> +                                               EMBEDDED_NAME_MAX, NULL);
>  }
>
[snip]
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 59c5c67985ab..0b01adcfa425 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2833,11 +2833,13 @@ extern struct kobject *fs_kobj;
>
>  /* fs/open.c */
>  struct audit_names;
> +
> +#define EMBEDDED_NAME_MAX      128
>  struct filename {
>         const char              *name;  /* pointer to actual string */
>         atomic_t                refcnt;
>         struct audit_names      *aname;
> -       const char              iname[];
> +       const char              iname[EMBEDDED_NAME_MAX];
>  };
>  static_assert(offsetof(struct filename, iname) % sizeof(long) =3D=3D 0);
>

This makes sizeof struct filename 152 bytes. At the same time because
of the SLAB_HWCACHE_ALIGN flag, the obj is going to take 192 bytes.

I don't know what would be the nice way to handle this in Linux, but
as is this is just failing to take advantage of memory which is going
to get allocated anyway.

Perhaps the macro could be bumped to 168 and the size checked with a
static assert on 64 bit platforms? Or some magic based on reported
cache line size.


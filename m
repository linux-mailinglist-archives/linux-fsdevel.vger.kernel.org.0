Return-Path: <linux-fsdevel+bounces-45547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F99A79516
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 20:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A2391894100
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 18:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011B61DE2DB;
	Wed,  2 Apr 2025 18:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Kv53//j7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2181C8605
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Apr 2025 18:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743618577; cv=none; b=jd0gUR61oi3kw3oOGGBnG2BTfOIIKc9c8xYJFYK8WvHzVadNQuic10a4NhwxGrCy4m4g31ifBb95mGyql7QBvntgz+DX9A0ASC86QhNCd0NkiEukON9sGEZnNYVL8CRJznFi3iTYxF3J4418HBqzkrILwUad1bT5BGBeYPJd2ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743618577; c=relaxed/simple;
	bh=xlSUNK20FSR3zCvbmrav2drXJwjAP9wSV+8W8p8NGjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tEIk9FPTzmgepPTsx+tKf1dsvokMs9LuEaYblT/102UYQFWqtU7194oRiP73eJ+q83ltZbGEeNBelR03f2q7Z/PL5zxKaQa4yMzW3x9a6gZXeNTh5+A1nAnexUipxl+BDXxR3MvyKqL8Wn3udkrgB0nEjOkQkC0O+cS8IA94EHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Kv53//j7; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-476a720e806so395051cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Apr 2025 11:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1743618573; x=1744223373; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xlSUNK20FSR3zCvbmrav2drXJwjAP9wSV+8W8p8NGjA=;
        b=Kv53//j7ehvlc/uxkW9BDZuYLRzSTsPG7brhlvfpvIr6f0FpN29qNFM43POz4z4hMI
         slkIdczDAZEmDJz7+7D1nfQWNgWod4yCjIOEWmERk43Bc4WEyq1Wr5kIjedh58IBiLmZ
         XPvel8bWK0M+nYoh1AQsuapfGtaKO8NS7TXP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743618573; x=1744223373;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xlSUNK20FSR3zCvbmrav2drXJwjAP9wSV+8W8p8NGjA=;
        b=XgRj7NBzAXFor2IEI6jfmtO2syxQU3Va5TP8+nnhi2DDYPLEv/ltTd1Weo/pdqQ0ml
         KLwmKD6KCaOOoF7/FOsDWvU9YBZxIWuzz4I34W5jAlkDCt3e274QE0+WG2a32zHRywzh
         tTtumpx2fIHOpen9ToGwMBH6drNcQOAGOikip8xZu0HGQMYNzDCMqdGkszrmkTrisc/W
         c7Muhj0i/O/F5gWTYf1SelltqjQzpTa7jCRNGVAa3TcZFZIgQPhuyhtoNIP6HCWIDIJs
         AuNlRXAw875TJ0EJDVBzzXvmme0fBxfPy4PtNGDN/Jl60xPwo9Ve2g8siPgTFXCqBW1n
         qJow==
X-Forwarded-Encrypted: i=1; AJvYcCVrzJUPxG0cn8mKoT0SD/oErP/+Gvn3QcMnSUwM6RYhHzTgAjnrpuBK9ikBuzhN+VwSE1Ao1JNK6KhwdQKj@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+9duMmG47kqWJq0TTMWk3bvgp+ETl+MVZzHugBYRCJrcqA+II
	4NuCF9Vkeg9d/WBlsisWRFn2H2UOj9i0PYsxyi4bJ6eO8CJqLOnkQ/xR7pRV6KkKDvcqHc+9/Oy
	R3zAyXdTS0qxEg7fbLqxyy17HUEwtZZY5W5dp5Q==
X-Gm-Gg: ASbGncugkMn4hsqYBAkPo6WyuVfGjCRi2Ol5lbHd6njFOg+XsB20NHoDinW3eKaYGk8
	jOe3nKIGGkmfn2tQWzLwzwSgvwwVwk4koZ5SNOTvUMDs90rJQtQsSvPpeV2FNL/LxYM5ogiuRVF
	CmGDS6I7Llm1hmN/FayodyziThpQ==
X-Google-Smtp-Source: AGHT+IEigQqBZaExWOSGzw2/DrDEGL7vUND7S4w9BeHY0KiD8Y8cB/pIzivykLVI/5tI4mwnbe2h3l8yGabaWZqxd6w=
X-Received: by 2002:a05:622a:164f:b0:476:7327:382b with SMTP id
 d75a77b69052e-478f6c7e3admr111133951cf.16.1743618572919; Wed, 02 Apr 2025
 11:29:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402-fuse-io-uring-trace-points-v1-0-11b0211fa658@ddn.com> <20250402-fuse-io-uring-trace-points-v1-1-11b0211fa658@ddn.com>
In-Reply-To: <20250402-fuse-io-uring-trace-points-v1-1-11b0211fa658@ddn.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 2 Apr 2025 20:29:21 +0200
X-Gm-Features: AQ5f1JpZyQblYqVuORU0-LSUyuRuhm_gXF8m4DXHH_oRKDWUEw2BcwaKBhlNP0Q
Message-ID: <CAJfpegsZmx2f8XVJDNLBYmGd+oAtiov9p9NjpGZ4f9-D_3q_PA@mail.gmail.com>
Subject: Re: [PATCH 1/4] fuse: Make the fuse_send_one request counter atomic
To: Bernd Schubert <bschubert@ddn.com>
Cc: Vivek Goyal <vgoyal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Apr 2025 at 19:41, Bernd Schubert <bschubert@ddn.com> wrote:
>
> No need to take lock, we can have that in atomic way.
> fuse-io-uring and virtiofs especially benefit from it
> as they don't need the fiq lock at all.

This is good.

It would be even better to have per-cpu counters, each initialized to
a cpuid * FUSE_REQ_ID_STEP and jumping by NR_CPU * FUSE_REQ_ID_STEP.

Hmm?

Thanks,
Miklos


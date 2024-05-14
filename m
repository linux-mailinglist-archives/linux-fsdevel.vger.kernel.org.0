Return-Path: <linux-fsdevel+bounces-19460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6078C59C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 18:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9068281B83
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 16:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1B2524BE;
	Tue, 14 May 2024 16:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vMkDV0cB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA7A6FC5
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2024 16:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715704427; cv=none; b=EWLMz1OP7913W7vhB1zoe1t/f4mlfv6xODou/3+3DqrxZDMmXl+f1MxGjeUkLMsKM2m7uw0eEMIOECb1Js/h6fDOXJ9af+f5phCOBuyVOLUbEwIyXh5Vfqh4/z+B+9MqxAOre5UqL0IY0a7BgDuYn94c7jxw6sfgK01JX2CsToM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715704427; c=relaxed/simple;
	bh=ZveMAhEpxPkTHD7VDMcwAi8X3FGU/ioBy7n4/jBydvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Si4V2H8RuW1f/cDSxxq9l6tw4SrmaSj5Ld1t7txd3k5DN+yVtDF38HmfMsHAeD7KlCGyAiNLCLu7i+ae8vC5SysftJCKYHV+IRSYbVffxU6XR7Ti860YIIMhOx/XPjiBd2vRtAHxbmBMSZsxroex0YGregF1YftgXTXeGKy8pos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vMkDV0cB; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-deb99fa47c3so6090379276.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2024 09:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715704425; x=1716309225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nv1f0KwnCkLw87/jdn7pXfBoRVPGPnbjvCSHZ433+XE=;
        b=vMkDV0cBF9yKDmN0CrkCDpwEvQboypA/hQX76774IlgU3XwqZqBbwUkX0bncGd8f7E
         n/+bLFE82J4CFRlKqRyuxH0iFpo+Ymb60JHw/dMMC69djcwaVf7wQMBNKXqD3CgAv5sA
         Uns0SQEckyDIthn+mY7PL5g01nRXvh5v0/ZLSe5w3/mRQESvHeMCb4y97W70um2IDLF/
         ut7MRdt22FMi5tRYTWKOjc0fqhbwti/qNQP2LgwPri3A62LGIqJuy3LWQvcFpcqKtR/X
         6vQHL4TWIQe/gc56i+YW5aDU3pcXULKD7BGJUT8IctwSQP58VpK8i1TIusTqaHafO+YC
         K0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715704425; x=1716309225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nv1f0KwnCkLw87/jdn7pXfBoRVPGPnbjvCSHZ433+XE=;
        b=czoEj8g266XtA2vZeQQtxA4VATMllhdYeJhWk+oq9WDbiZVO4979DG4LU3t/MV/x1F
         OiRaT9xgKOsR5iigm1GWqovYjvAmTBoSMr/bkxaJZb9eP0Scybwci2ehI5fpqoX6zohY
         te7ndf9MunbRAsjIAutdKWmUDJQqrk7LWZDjmNSQ2eJf3yQnlOijAbx5IXnk3hladSyv
         gD4bmYTg5TO+opMonAhaqS7rfar4BH7TUi8DRjOptU1yck118RoPjkfQvSSXDbGT1vBD
         GE20tFgEnnQpa9rg3TSqJFtn5gYwQrShLCnjf+uRN7n0R1FLhHnADfL6qLVkfSMGvWBD
         vBSA==
X-Forwarded-Encrypted: i=1; AJvYcCVCGd39TPYRk+tFyrcJacoNoFKz3rl6SFSyKe1hsK5xKlgok3LRqy2wERpXp1QYbzR1iw5zhN6qA5igD01k1eBqkn8eAPvj5aO9CDVx4A==
X-Gm-Message-State: AOJu0Yw0E9sPeD1N9SJpQS+gtnJtacXuVdvWW68V/Alc0EBZ0/3dxkda
	vXT8G/juM4/IvPkmcQFbZiC04TV5aqVXg/wIvjZscOoCkZtujZKbAT4EXLIV5x+ggkokGl0fUs4
	al1snkbuwDpEmNl3PphnkBRCT75lBvaD9hrPx
X-Google-Smtp-Source: AGHT+IFXAhCGaHN00zLb69EIyY6q0TTwNMCUOErAVF3O54yE63mv0vw48TLat8wi/llUL4sBRr0HPLAvGtQ1nDzkffU=
X-Received: by 2002:a25:b283:0:b0:dcb:b072:82d5 with SMTP id
 3f1490d57ef6-dee4f39c9bamr12638368276.64.1715704425109; Tue, 14 May 2024
 09:33:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514153532.3622371-1-surenb@google.com> <CA+CK2bCmy1PhDgDvEX2Pg=_HvLLD2msJmTV_rgMxifbd-y1wRA@mail.gmail.com>
In-Reply-To: <CA+CK2bCmy1PhDgDvEX2Pg=_HvLLD2msJmTV_rgMxifbd-y1wRA@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 14 May 2024 09:33:32 -0700
Message-ID: <CAJuCfpGfcY9NLM2ShxBaspwzOK5=B4WFrT0cGDRwTPJMkE+wWQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] lib: add version into /proc/allocinfo output
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, vbabka@suse.cz, 
	keescook@chromium.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 8:56=E2=80=AFAM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Tue, May 14, 2024 at 9:35=E2=80=AFAM Suren Baghdasaryan <surenb@google=
.com> wrote:
> >
> > Add version string at the beginning of /proc/allocinfo to allow later
> > format changes. Exampe output:
> >
> > > head /proc/allocinfo
> > allocinfo - version: 1.0
> >            0        0 init/main.c:1314 func:do_initcalls
> >            0        0 init/do_mounts.c:353 func:mount_nodev_root
> >            0        0 init/do_mounts.c:187 func:mount_root_generic
> >            0        0 init/do_mounts.c:158 func:do_mount_root
> >            0        0 init/initramfs.c:493 func:unpack_to_rootfs
> >            0        0 init/initramfs.c:492 func:unpack_to_rootfs
> >            0        0 init/initramfs.c:491 func:unpack_to_rootfs
> >          512        1 arch/x86/events/rapl.c:681 func:init_rapl_pmus
> >          128        1 arch/x86/events/rapl.c:571 func:rapl_cpu_online
>
> It would be also useful to add a header line:
>
> $ head /proc/allocinfo
> allocinfo - version: 1.0
> # <size> <calls> <tag>
>             0        0 init/main.c:1314 func:do_initcalls
>             0        0 init/do_mounts.c:353 func:mount_nodev_root
>             0        0 init/do_mounts.c:187 func:mount_root_generic
>             0        0 init/do_mounts.c:158 func:do_mount_root
> ...
>
> This would be the same as in /proc/slabinfo:
> $ sudo head /proc/slabinfo
> slabinfo - version: 2.1
> # name            <active_objs> <num_objs> <objsize> <objperslab>
> <pagesperslab> : tunables <limit> <batchcount> <sharedfactor> :
> slabdata <active_slabs> <num_slabs> <sharedavail>
> pid_3               2730   2730    192   42    2 : tunables    0    0
>   0 : slabdata     65     65      0
> ..

Thanks! Addressed in v2:
https://lore.kernel.org/all/20240514163128.3662251-1-surenb@google.com/

>
> Pasha


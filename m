Return-Path: <linux-fsdevel+bounces-13047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8623586A90E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 08:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C84E282E08
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 07:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E9225542;
	Wed, 28 Feb 2024 07:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="WIrHd9bW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614512377D
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 07:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709105845; cv=none; b=E504PzQqO4BgT+F+5e34v+gLIKJ2456MTIMegQy/etvjTcnSGOgFhefMJqKAe+XCaDFvo+SLob5rHfqmE2pV1xVHZBYSjrG8Cz+9AkhGAOqeSWIkg4vl5qUVbIstzUYyUz9sz+jXRCBzlfZYKwoTPzDxIHJmydxLwkHWDNHvPcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709105845; c=relaxed/simple;
	bh=/CEatFhajZaIrXQmG319mzOFBTaRIt71MhDwqBzf0N8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dEZJhT9iTLNZTrequN19ndUMeplGvbrgYeVqZ5eXplQt9m5v2/RuaLd/R2PVGMBerSRayNQvvoSVfr4AsVz8mwacbAuniRn/6STHm2h2oYiPGJ+O2G7NoXu6y83T8uZ/M880z5B5BcX/B4RY59PYGSB68eWrSoqUBAxLocX/Ekg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=WIrHd9bW; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5643eccad0bso7832036a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 23:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709105840; x=1709710640; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/CEatFhajZaIrXQmG319mzOFBTaRIt71MhDwqBzf0N8=;
        b=WIrHd9bWhDhQQDSbIbleHHdz7Teqdv8Ntpr2VMc0Hx/z0vbKawFNRPqw9S1ViyAGZF
         i86nQyXon4OsP8ayZmCUOkZXWYXWfYiNYIOU+q4nsX3tjcKjzAoRy4bAhENP/EdoJhbV
         vM4AtNmWaZxJ/O6Xg6sLx7PwlM4QTNwjXl9CY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709105840; x=1709710640;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/CEatFhajZaIrXQmG319mzOFBTaRIt71MhDwqBzf0N8=;
        b=CstN49tPxT4zg5fHQuisCquFkDKaBiGc93aTB8pY5Zhe9BSxgYKGQUBFxErbMzCNUP
         xgnA4unbl9zA/o5OM4lPncDyo4e7sfLhX91XMNDSX5Ypf+rjygdNX6fjWKJaTnrKUwDw
         34Pygu74T1tZgtQ7y57vEIcmpovsaB6FRtH4ltWchD6nVTMj+NKJWng4KpivVOFOkoKK
         eS128y+9fzQwHahlVhKiPrRfOClfKF/pwndKOqjFAkBceL31dCqam0JgLyVp8FWMoEZa
         VhqaK5r9RmmRJ1QqbdhtoWZlfNAR7rdlKN4Kpmlp7dKEuaejJND7V5v77DGMFLl5XmKv
         aPhw==
X-Forwarded-Encrypted: i=1; AJvYcCVrWu11bw8S260IhKbWy4iJWxtMbuNO9NWy4mCg5d8cnjJROhFRX8QBz8BaEHhlRTlPnD3vUIz3ibiumKBZB/O3dH7qu1UiO0Coln5+UA==
X-Gm-Message-State: AOJu0Yxw7zGolCZho5IsD+tpWGi1ELZGsvRta18KfuLl2fZLmhB/J8Sl
	u4MAYB5aKRWSckt/NtW08yxV/xEP1xGits5tgVYsuVzbFNLEoVzkbKvvYQ814e/Bj2LT0lzLTm/
	Z6hN79ioGOqPboXq0BcFNHPlrOFPPTjB0uozi6A==
X-Google-Smtp-Source: AGHT+IHAm2fBmrQhHV7d9pkXTo1TXF52TvZmasaotKHPoqJb1i0QzR+yphqcCbHgfWNJf0aQVhCvB7tHGxAWY2zM63Q=
X-Received: by 2002:a17:907:9953:b0:a3e:526b:1bc2 with SMTP id
 kl19-20020a170907995300b00a3e526b1bc2mr7332615ejc.40.1709105840265; Tue, 27
 Feb 2024 23:37:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227155756.420944-1-stefanha@redhat.com> <aa41ac4e-c29d-4025-b1c3-8cdc9830b5f7@infradead.org>
In-Reply-To: <aa41ac4e-c29d-4025-b1c3-8cdc9830b5f7@infradead.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 28 Feb 2024 08:37:08 +0100
Message-ID: <CAJfpegsjcZ-dnZYft3B5GBGCntmDR6R1n8PM5YCLmW9FJy1DEw@mail.gmail.com>
Subject: Re: [PATCH] virtiofs: drop __exit from virtio_fs_sysfs_exit()
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Feb 2024 at 23:31, Randy Dunlap <rdunlap@infradead.org> wrote:
>
>
>
> On 2/27/24 07:57, Stefan Hajnoczi wrote:
> > virtio_fs_sysfs_exit() is called by:
> > - static int __init virtio_fs_init(void)
> > - static void __exit virtio_fs_exit(void)
> >
> > Remove __exit from virtio_fs_sysfs_exit() since virtio_fs_init() is not
> > an __exit function.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202402270649.GYjNX0yw-lkp@intel.com/
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>
>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Applied, thanks.

Miklos


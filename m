Return-Path: <linux-fsdevel+bounces-63681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD1FBCA94B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 20:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCDF21A62FD6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 18:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9C823D7CF;
	Thu,  9 Oct 2025 18:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="no33XGEe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C72D1BFE00
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Oct 2025 18:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760035006; cv=none; b=H9k/iQHKT3G+eDSiISTYa+rxHtYeDcNeAyvUyIzNe1PGZwFRaRb71AKPnpZmhWjBaNELALT/QS+73EzpyFXMbDac6nRS+6ECVbUeZ5Gfl/JKwYCI5iKObaW1MBgPRUnqkVTP8AqtybMmf+Z8WV4PDaOb/lwbL6CAZ/Y8ydufU5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760035006; c=relaxed/simple;
	bh=KEsW2OJV/dTH4tWI637HzgVNLZLEix63iukExIPCxWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MsjGg9F4NlsvWcjOn6aZCAhdXxLc9//QS+Ph7wZw4FKRsB8J76CQT9bTZc3fH6RL6ZA2QoHWBhPThuUJ0SzmYBi1CtiDYZ64TfWEYVFRP998q9b50t8QNFqsCE796p8odNBmeq613TXPrNu7O/FZpQo6LmloqN6bxHcODYSMESw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=no33XGEe; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4e56cd8502aso15760811cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 11:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760035003; x=1760639803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=roR2v4xL1IPRVpYrhcGJDt6ekXM2vfs5Ijr/0y0mZ80=;
        b=no33XGEe6PCVPHlqNHxRuni0byl2O1J0cRvE3+FM0SEYVY0w7DHGBybR6I6ruvv+m7
         isMs02MzCby5wHY6/b08YSgZf5QzRU24AgcumCs7K0boHMkWRqv0yl4Hy+URW+sGucTf
         cKVJaG+0KMIGft76Fnb7o8fYb9EPRbgvcuiq9H3Cc3z2BNOnPQcJbfg3mDTSYB+fW/5N
         Yt5RKPOFKC9Wu4Qir/a2tbSWtXgYPpby3LXfp4b2ydsYoRupgVl7pVFay51YH7YEQ95+
         J1lorFYHAiaKHGEjtVWIK/O15lbMjPoK2cCjVh2m/08qmtuJjvO0No879kPMEUjq/o0b
         7UYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760035003; x=1760639803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=roR2v4xL1IPRVpYrhcGJDt6ekXM2vfs5Ijr/0y0mZ80=;
        b=fX+2Bv4z92HwmXfKB8VRVUZSBUH3hzes6Nyv7/GxPF7+qhLxj5RnBXywEFbCr0t4Cz
         6ZyZVZXSTzPhPRC2f1Er/CdFe2tjAJf5Kp2hVfDQPErvfLFSNjJMipewlFmbhvmAIZO5
         xqEAgpL+OQZ7e3g2OSbrJP5PTL6okgr6XAINi8Ov5uuZvT3iHhZGl/XjTm9aOahI1itj
         mJj+ms8hFM0EtbNeChk9Lo9Wzs3TZ3Hz+vPhgjgaCP+Hgp11F9qBSxj4ICn9putOvich
         1QTPLoOGROejOV5dyU9HN7l0Hq1mKmxpn2iyWNo0TGtTpKrDmhvZVpN207oh1iPtvUCI
         v8DA==
X-Gm-Message-State: AOJu0Yz7HM++sySVxXrZPLuh6cAQDFgdH4EiP5uN9T1hPNDjrJUX0T2Q
	Z2kIH5inEyZWqBjJQqyVGyTd6PbjdIpy/JsYKvUVduz4FPpQvlzbQYb8oPCRGw8a1Kwx1bM5aVa
	7xqxx+LbbJWF/mlbp26qPxqtIbJVOTMg=
X-Gm-Gg: ASbGncsogp+S7FigwBbOsW7MK6L3bNCFvnK7RC5BPS30413z0OTcliOxu/mUrlNwWt6
	9XF8LyS5aLy3C1oFsZpapc1EXAxoW3R1OVuA6z5xGKDneShPm8XsH+DRpBaFKzF1Ero0IgdR0Yt
	b4knFJrN43sGf+NcUhHhXKNJOc9FuhfXIkB7MV0HseOxUkA0aHBzKISoe9WbaON8DGtYExmLg5X
	9MXoS7lkCAox8dk42Mw6hLfPNZMvaBVxn3Cm0EWVRW4wjRo8hueGB0Yl83ijbk=
X-Google-Smtp-Source: AGHT+IE+PvtJ8PoZJKJ0PpvlrxsUGw17+YObZyG2vyj217qCZrqfIcse9r+dln8mijZwHMPPIfo31yKr/j4BJkfVd4c=
X-Received: by 2002:a05:622a:995:b0:4b4:9489:8ca9 with SMTP id
 d75a77b69052e-4e6ead5afc4mr106713561cf.54.1760035003252; Thu, 09 Oct 2025
 11:36:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008204133.2781356-1-joannelkoong@gmail.com> <CAJfpegsyHmSAYP04ot8neu_QtsCkTA2-qc2vvvLrsNLQt1aJCg@mail.gmail.com>
In-Reply-To: <CAJfpegsyHmSAYP04ot8neu_QtsCkTA2-qc2vvvLrsNLQt1aJCg@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 9 Oct 2025 11:36:30 -0700
X-Gm-Features: AS18NWAB3jqaKsS-Kxs761G7f0r9uOSOVG59yXLq7zZOuOy5H2I9XL9lepSXnz8
Message-ID: <CAJnrk1anOVeNyzEe37p5H-z5UoKeccVMGBCUL_4pqzc=e2J7Ug@mail.gmail.com>
Subject: Re: [PATCH] fuse: disable default bdi strictlimiting
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 7:17=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Wed, 8 Oct 2025 at 22:42, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> > Since fuse now uses proper writeback accounting without temporary pages=
,
> > strictlimiting is no longer needed. Additionally, for fuse large folio
> > buffered writes, strictlimiting is overly conservative and causes
> > suboptimal performance due to excessive IO throttling.
>
> I don't quite get this part.  Is this a fuse specific limitation of
> stritlimit vs. large folios?
>
> Or is it the case that other filesystems are also affected, but
> strictlimit is never used outside of fuse?

It's the combination of fuse doing strictlimiting and setting the bdi
max ratio to 1%.

I don't think this is fuse-specific. I ran the same fio job [1]
locally on xfs and with setting the bdi max ratio to 1%, saw
performance drops between strictlimiting off vs. on

[1] fio --name=3Dwrite --ioengine=3Dsync --rw=3Dwrite --bs=3D256K --size=3D=
1G
--numjobs=3D2 --ramp_time=3D30 --group_reporting=3D1
>
> > Administrators can still enable strictlimiting for specific fuse server=
s
> > via /sys/class/bdi/*/strict_limit. If needed in the future,
>
> What's the issue with doing the opposite: leaving strictlimit the
> default and disabling strictlimit for specific servers?

If we do that, then we can't enable large folios for servers that use
the writeback cache. I don't think we can just turn on large folios if
an admin later on disables strictlimiting for the server, because I
don't think mapping_set_folio_order_range() can be called after the
inode has been initialized (not 100% sure about this), which means
we'd also need to add some mount option for servers to disable
strictlimiting.

Thanks,
Joanne
>
> Thanks,
> Miklos


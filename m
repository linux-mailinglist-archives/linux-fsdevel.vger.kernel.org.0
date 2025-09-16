Return-Path: <linux-fsdevel+bounces-61837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50733B7D2D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1345524F4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 23:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6812D3752;
	Tue, 16 Sep 2025 23:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asyUZ+iC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A892C235A
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 23:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758065021; cv=none; b=gHe29+sFCaXPQ05LI/ZY5QrUoCl8G52cwqUpNtI1ca7owY4NAuqykoWv5I4x+gsK/xvY8gkwTg1WurkLLP0EGTeOwuC0elogrEoFoUqxXDEH5lOjq3hlT5QABDJE3Alt5mLLPMXqPGLgGn7AGT6WPMQbVaS96FsWBReffqrMdLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758065021; c=relaxed/simple;
	bh=giTIA+oN2GPG2AJcIuFo/Yqay6xFcr7uFNP4OUqU5dI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MuQD7QrmkTNTcCJh7w36/A5xtpwaITccE3VFBndY6uOsKM1nwWMeDUzrXjU46eWvaxyp/KkC9tLIeByOHDGPv8S3Ai9x/2dvWL2duEFQWNDYPf1RAjQK+zVegExXnyOYoySmnUk+uZal/tH+kf+ZslGiU0t2uHjFJvVozVLncZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asyUZ+iC; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b7a8ceace8so25727841cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 16:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758065018; x=1758669818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQ3YjBHZupiI/fSqsW54w4BEZGVyy/jiIbt6znTHb9g=;
        b=asyUZ+iCHTL//+nR5gSFuJOruC4HPynL2kaTddk7PctWZ9pBCFj1rLQuo1AHwy7TR1
         fRPl3uQNKVDDIgVty2+JobV21FKfGq1F9Vo9nZaN8FLPIV7BMB6ue5fNLgNN2yDrKFZb
         hBDWXJGnaNoy+EAjno5WK7YvdOvXf3+jVe0G9YbZRa9R5cLkNcke/d6dTGrfyPj4XavA
         jv+5Y6N5gGz4o5ZTbrvx4a/EOUQrw96Ni4xSC94Ryef14V7gFonveI61b87xn9ukf1F1
         gQChejVlUnt52ZtsFiJ9IQ3sRoC2TF+l1XDUolQpdP/wkHblopAY71s4WS/3hmLSuDBU
         3x5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758065018; x=1758669818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cQ3YjBHZupiI/fSqsW54w4BEZGVyy/jiIbt6znTHb9g=;
        b=W4a42hV50JoM3oJEv4L7B3cu182ju2VRDiM/MGf/6hDmZAQvklqIHBvC0/OhQASGiL
         1XtF/n/Z8he67MaPR1tcw83dUUxQmhkC9oRgEdgZsop1u5ggb43HrMmnohgXviB3JR4Z
         HQU8xScJtMMXSs/FE1HwmpMyZZOtNnYWPDdeI2sNwM2xaxD6GHtWxJ+Xa43byCQjjXB3
         b0HevIB4peivFMgUY9CiLtnNnn+jClX8HbIA46emmyaa/UAxkZ8kjXA+/Aa5bl5t8AWb
         OHfpcTATt0jvi8IwNiy4KJgzLUQxEj9QD1SlT3Pl3KyDIajy1s0ZOvIWBva+s5ulNI4V
         RPhg==
X-Forwarded-Encrypted: i=1; AJvYcCU9ylYsCagGO+YfwKq2oYPZ8JaffJNEzPgrDDCXi5Q8+0POuoxFf4GJ61EnaKUNk6Qmgm100B/n55to5V20@vger.kernel.org
X-Gm-Message-State: AOJu0Yydr4YK6p4SV6DSZjgzSNrZ44r3hPe5bg26bIcmLZ0hpvrBTPjL
	TEYwV4C+U16phPDgtuLNRVZBa27jLjbZHA3cOwbVaQD7PWcGx/00OfpPSg5yuej9TgicXk7S1mm
	u+IJM8u15jwIpOjNjsbgbKPbA+fauik0=
X-Gm-Gg: ASbGncsuTQ2q5tT6ysqQEuZywVFQZgr9Dahga01VHfpL/BWAq4VVfNrk6ZD0sdxl8ed
	ZmzAlIyX4mvGUhN//cci7mJyWqiZv+2ZZQM2opEjooLsTIt7Fkb5f/0lRd3uEfBfuR64YQJFS1V
	aGygiOQQ/dhoPifGU79kNJYsDrtTlm4t2q4s+ZU2GrrT07fme3lNxhXbjZwTSfvySYi65Tcdzt7
	NVutkRmNYQiJDzzVYSj9cnJEtsWOhtAWtsPHzj8yk5kt30Mtv4=
X-Google-Smtp-Source: AGHT+IGKNa7p053KroFdDHY8BCrv3xAn02NwZmDseFgEiIugEgF/oIBHgUVbXPtDWUz4HmAdeW9tnpZMVTofJgWdSvM=
X-Received: by 2002:ac8:7f4a:0:b0:4b3:f0d1:bc0e with SMTP id
 d75a77b69052e-4ba66e0cbfcmr3622001cf.25.1758065018571; Tue, 16 Sep 2025
 16:23:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-14-joannelkoong@gmail.com> <aMK2GuumUf93ep99@infradead.org>
In-Reply-To: <aMK2GuumUf93ep99@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 16 Sep 2025 16:23:27 -0700
X-Gm-Features: AS18NWBTxeNfj7HS1GZNQzeWa7wYyaeuCFdkWQy1IIWJ1KkRr7vB0nVtSJ8Auok
Message-ID: <CAJnrk1a6UYzY=t-RJtoifxfkXQe-bKMhOnKtnvoP-X1fkPvb6g@mail.gmail.com>
Subject: Re: [PATCH v2 13/16] iomap: move read/readahead logic out of
 CONFIG_BLOCK guard
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, miklos@szeredi.hu, djwong@kernel.org, 
	hsiangkao@linux.alibaba.com, linux-block@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 4:44=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Mon, Sep 08, 2025 at 11:51:19AM -0700, Joanne Koong wrote:
> > There is no longer a dependency on CONFIG_BLOCK in the iomap read and
> > readahead logic. Move this logic out of the CONFIG_BLOCK guard. This
> > allows non-block-based filesystems to use iomap for reads/readahead.
>
> Please move the bio code into a new file.  Example patch attached below
> that does just that without addressing any of the previous comments:
>
> diff --git a/fs/iomap/Makefile b/fs/iomap/Makefile
> index f7e1c8534c46..a572b8808524 100644
> --- a/fs/iomap/Makefile
> +++ b/fs/iomap/Makefile
> @@ -14,5 +14,6 @@ iomap-y                               +=3D trace.o \
>  iomap-$(CONFIG_BLOCK)          +=3D direct-io.o \
>                                    ioend.o \
>                                    fiemap.o \
> -                                  seek.o
> +                                  seek.o \
> +                                  bio.o
>  iomap-$(CONFIG_SWAP)           +=3D swapfile.o
...

The version of this for v3 is pretty much exactly what you wrote. i'll
add a signed-off-by attributing the patch to you when I send it out.

Thanks,
Joanne


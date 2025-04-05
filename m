Return-Path: <linux-fsdevel+bounces-45806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9E6A7C7BB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Apr 2025 07:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C22D7189F703
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Apr 2025 05:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214091BCA1C;
	Sat,  5 Apr 2025 05:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MR9ADKv4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFD81C27;
	Sat,  5 Apr 2025 05:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743830792; cv=none; b=LVkqsUz5oa6qzCL8Y3A0hfVx6Ilj1JEBQualf4ped2AlctHH7/gabi4UkRFjrU0EnQkI67WqIm6p2pF857FaKkGDthZmU2xsxXsSnDHugmzwaQPS2fQ52s6vK9x4rRWrhEClBeTbIFZT5pHq0tb+TIzu6/bHogKAwWGBRU3vxK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743830792; c=relaxed/simple;
	bh=uT9jWXKv70chjMwap0MJsCmNIlKaScHKfiBt94kEs7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MaMV7dlCYKWIpgpFcgG9ve83TOfJpH0vu2I33KlgsAtr5jD2utLvWg70ePVSwmMuxtToMpYe2eWpM3+6DMTA02W543GxdRuZG6vCgvFrm0OfWYUcIyBenHzRXadKyLvweYh8cZ/kOms///+VJcZ2m7xJfJO/6/QtX6tdCzvBVDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MR9ADKv4; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac2af2f15d1so366079966b.1;
        Fri, 04 Apr 2025 22:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743830789; x=1744435589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uT9jWXKv70chjMwap0MJsCmNIlKaScHKfiBt94kEs7w=;
        b=MR9ADKv4cMsbpJ9gHEsCC+mS/OrwSoyIZ9uvmSsinmLu7nFja4q3sLpFFRc9LtHdHb
         OsNF2jsjgB7ua5LoJnep6jKDIzE7nkSJ/LyOf4eEdJI3QgAOUzGEySYoGh8z23nPP35n
         KvuddD2gXsWqKN0TOVbEWJiN86b8fW3UgSEBfnVm37BN0OXCONEm5pIAWPD3erxZ3Xad
         oTqDXU2CCeYvUfAp99LBSJk+amQWN+VykEov1ymGEhg9wRp9EU4lUiVmjAnAidC69F1m
         rOcGoGxKJLC1jM+i1UBgkO5odWuHMi80u3MBZzXFPghO0ktc8nlZWhOS77b1hTYOlWII
         +jag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743830789; x=1744435589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uT9jWXKv70chjMwap0MJsCmNIlKaScHKfiBt94kEs7w=;
        b=hLy9Le2rsTfjq3gZHiq+5QX9gl4Lgb6woMJ2siOvld5CtiEG7J+ifK6Zn4Upc0ouQG
         45ZCr8c+1QUc6RzNwWvXKczz28w7hq3sjJdxkvn1W2er2r/8X/qNDUpXh/nkKxos76Tr
         pDpzD/OGS9S7eJIbtrHre8am8ccwvREp3YtPhHqY/n0mE8vJxrKEVg1Wq+h/oxFgurLc
         YYByDaORAE/rRaf7borhO9hWvnDs2RfxRZqOGpTyju53HoZ2M9RJcNljVuRd605bIK2d
         LfFQcEfhZL63NW1Qw0biQDYn/Qx8RE454b4OXbxhzixoanWxcA6tTFQI0VGFmNHCCk5i
         SBrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXAb5r/KRZUl1RAvFIuGTaB/4y0rbS9DmInEpJMdYdAYlYQIw/eAQuH8D9EfcdIKdpdtT9hvVlz70g8HY7@vger.kernel.org, AJvYcCXQS0RR0rbzXjdNjq3Gm4oroZTHl4/3tDx6athPnAIY6Y4VwNrmQQlWKBDophulgR/duj0vShfE1SArhA+w@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6xt0pb4cmRSNEMGaorY4F+1tNTpbsdY3yEi33HjwaVUMmTU6/
	cnngJv/vTA8Vj86A4MNekqpSbYDxEYBkc/rRxbR+dRla8xdP5L67Da4XNOk4fZRzmu1RjGR0elF
	7ivvCZnO00tJKBPMc67o124pevCU=
X-Gm-Gg: ASbGnctnZ2IFzarPcxPji5Iezt7lCwpEzCn/7/mZRxdcaCV7mQZmGGfvJz9aIDq8256
	ZZroKYuAnj0aVDvhOnVsTvt3rIMOHXmKx7Z/Ahh3YWT8YupJtTQlYOj1I3ompbkDwgoCESt0L7j
	Qob3QWNiGi97GhBgsJoHQeaAFhnA==
X-Google-Smtp-Source: AGHT+IEfZXaQ5R6Pmdx00IRZUwOLiyNOcAb73lX22HlFNH3NQjHgR0iT9wn5V5CjrSQ2v6yenCGBHFsifJ8hW8EvIIY=
X-Received: by 2002:a17:907:7faa:b0:ac7:cfce:cf1a with SMTP id
 a640c23a62f3a-ac7e77b2bc8mr142905466b.53.1743830788843; Fri, 04 Apr 2025
 22:26:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250329192821.822253-1-mjguzik@gmail.com> <20250329192821.822253-3-mjguzik@gmail.com>
 <87h63bpnib.fsf@igel.home> <Z--bN3WetGcsQmnx@infradead.org> <CAGudoHF2RbaEAUYcWBZCo=4KvRroEcotAjtZEnoTG1qTYA5+eg@mail.gmail.com>
In-Reply-To: <CAGudoHF2RbaEAUYcWBZCo=4KvRroEcotAjtZEnoTG1qTYA5+eg@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sat, 5 Apr 2025 07:26:16 +0200
X-Gm-Features: ATxdqUFtC9uH_zYHl4ZKR-qb4FikX2TMbTjRiETNPcVOethJIHxzRhhCmCoUJwY
Message-ID: <CAGudoHFfNuYPnMou1v2M1de9B-MPP=HtjY_MX07Gmx9R_rh4ZA@mail.gmail.com>
Subject: Re: [PATCH 2/2] fs: cache the string generated by reading /proc/filesystems
To: Christoph Hellwig <hch@infradead.org>
Cc: Andreas Schwab <schwab@linux-m68k.org>, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	jack@suse.cz, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 5, 2025 at 6:55=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> wr=
ote:
>
> On Fri, Apr 4, 2025 at 10:41=E2=80=AFAM Christoph Hellwig <hch@infradead.=
org> wrote:
> >
> > On Sat, Mar 29, 2025 at 09:53:16PM +0100, Andreas Schwab wrote:
> > > On M=C3=A4r 29 2025, Mateusz Guzik wrote:
> > >
> > > > It is being read surprisingly often (e.g., by mkdir, ls and even se=
d!).
> > >
> > > It is part of libselinux (selinuxfs_exits), called by its library
> > > initializer.
> >
> > Can we please fix libselinux instead of working around this really
> > broken behavior in the kernel?
> >
>
> That's a fair point, I'm going to ask them about it. If they fix it
> then I'll probably self-NAK the patch.
>

for interested parties: https://github.com/SELinuxProject/selinux/issues/46=
8

--=20
Mateusz Guzik <mjguzik gmail.com>


Return-Path: <linux-fsdevel+bounces-27390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 418B3961314
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 17:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB8661F24625
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 15:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101DA1C6F5E;
	Tue, 27 Aug 2024 15:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLoqYMKp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AE61C5788
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 15:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724773305; cv=none; b=iHd7h175EJRtRU5xppN57hIfk0rUDeTLSdSDU6gs9ICH0xydw546avM5LDsa3ll31yUArS43hj71MtSx0vfCpZJKo9DVJ4TXOSI8ok39e3elByxxSbeSRDgtnusQPdcdcwflxXqGirDpjZg8pBObhp88OUCALYEqUeebRRSBSVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724773305; c=relaxed/simple;
	bh=/l1hw/DmLl794HmOiuczWXV5W/HhEfG4Hr77769V9U4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I2P/zqPiP6FqT3BPQ8YW3cLPo+JEDmrIOo0wYym4tKv0NPGEKrng+x8jIKKYKBpA/7e6F5F+59MfPmXG7Pc6FboNVbKmf6iY8m5fXQmwQyXpstG6+LL6Q8fYTNT5j9LQKaTAxlYv2GqINQhENYIsXZwh0hWWvvTrpOTF9/zaWS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLoqYMKp; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-70b2421471aso3481356a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 08:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724773303; x=1725378103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25EAD/8DG+F4+n6Psk8Rztykwu2YA9RYX2iAuDLaK7E=;
        b=cLoqYMKpgF/dCNl1OqGr7bn2xmHG2TCnWrsjiLIFjgoWc34In1P6w5Myq1h3YQi2Bu
         02Fiy1Amg/My1FH79Z2lkxV+mE8sZvDStpsRDO30sXN7V7bfWRdI3l0omXtX+FeVMlQY
         c1iy3akfVCuES9OcAnW7Pyfe1IvR4bp9d6LhtWh4qzuP+0g3Sjjl/JOiu0dKCLpBWOIj
         +cAVYImLMkWq13zAj5eApAGHE3Ycf+siVul+AqgD3ecaYQ1u8x9P4MvP1yFfgz1ePvo9
         /lQD5tmGMtwcVR7VepbU8ONWR5x2KUEzLJFK8Re1nu6tJRFIHaYmEXVa/U3nwlsn0kZl
         lIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724773303; x=1725378103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=25EAD/8DG+F4+n6Psk8Rztykwu2YA9RYX2iAuDLaK7E=;
        b=vM+CziTNayLGjPhZT9ZyS3uTVBbxlO4JDdDxNK15mlcRjygr0TbPnjGbpV9sr5+hQq
         9UCJ1qCRAKW/NzLyk6qHzDrDwXg8ZIFt9pqPvZYmffNo78nCpzK0CVDPCeC6KEnzrWSC
         NrzpObO9XYcIcQZN6JH/lduIvdsHisBj9IHoVQzwmyfhCKAyDcYHjRLLfVUV9g6Ustps
         8SlCv3+xlG67yjLZbgOlf0hDu+j2ghJOOXaRENX8J4nl0DqV5B9nQmIH2I4kZkQuhnRU
         TPeyJ80zHyIPU3viJj4Psro+HPIMURF8xVTXdtiQSjDoE2pIwwl6Y7xQM2w5fayRL3hD
         GDqA==
X-Gm-Message-State: AOJu0YzH2OGZiwqaECGDn+7HtqjUjtGHYkmnsDZATY7sih/HKGbiWonX
	Kycz9UbAh2JFpgomy3d0v/qkVjPHKJSaOnlsGsyP8n0AU4msNSZcwoaNhZRp2Vq6iKAguRIndyM
	37vAO2ZqaRRM6CmhLrpdzMexjoi8=
X-Google-Smtp-Source: AGHT+IGBmn6t8n/VbAc72deqSD+cK1PrauyWvgwRAXgfCer3zpgctAqFT/A82FO/SymWX3wqcHsNohThMdIRBy9wgEU=
X-Received: by 2002:a17:90b:5211:b0:2cf:5e34:f1e4 with SMTP id
 98e67ed59e1d1-2d646bb6701mr15347666a91.13.1724773303092; Tue, 27 Aug 2024
 08:41:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOw_e7bB3C_zbpq6U+FdrjbwJAOKFJk1ZLLETrR+5xqRmv44SQ@mail.gmail.com>
 <CAOQ4uxi=9WpKFb24=Hha_mwj9=bsj9qxiv0f0Z-FMfuBRCvdJA@mail.gmail.com> <CAOw_e7bMbwXzv00YeGw2NjGDfUpasaQix40iXC2EcLHk=n2wTA@mail.gmail.com>
In-Reply-To: <CAOw_e7bMbwXzv00YeGw2NjGDfUpasaQix40iXC2EcLHk=n2wTA@mail.gmail.com>
From: Han-Wen Nienhuys <hanwenn@gmail.com>
Date: Tue, 27 Aug 2024 17:41:32 +0200
Message-ID: <CAOw_e7bCymG-HBLT+W6Wuucq7mLyC4wY5C-bjEGFiooK6+hDZg@mail.gmail.com>
Subject: Re: FUSE passthrough: fd lifetime?
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 5:32=E2=80=AFPM Han-Wen Nienhuys <hanwenn@gmail.com=
> wrote:

> Right now, the backing ID is in the OpenOut structure; how would you
> pass back the backing ID so it could be used for stat() ? IMO the most
> natural solution would be to extend the lookup response so you can
> directly insert a backing ID there.

Actually, scratch that: the primary use case for things I've built in
the past are lazily loading file systems, where you only want to fetch
the file if it is opened for reading/writing.  If you have to provide
the backing file before it is opened, it would negate the benefits of
using FUSE altogether.

--=20
Han-Wen Nienhuys - hanwenn@gmail.com - http://www.xs4all.nl/~hanwen


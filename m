Return-Path: <linux-fsdevel+bounces-71548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C60CC6F97
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 11:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40BD53022AB2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 10:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC8234B199;
	Wed, 17 Dec 2025 10:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="KH/4Hf74"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDFE2EB86C
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Dec 2025 10:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765966099; cv=none; b=skoZvkiEq9ee5t8seu8bNPzTbl0OcYonOQP3RjFqFKBoFXjAEK7Q3fFvF0GcTTPnbIYXCipl2iJwEaQVyldKidy5E/oelPEtH/stufQ78ai/ormTaP2JOFlQcIKW/UNIJHNq2coOMOZTAPSz7xFl1AcWOx3jExd5V2LZ46mJ+Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765966099; c=relaxed/simple;
	bh=+3nylnR+1dS70anYFBkg/oVtiGfIp0ODmVVKhr+0cnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VILs2/8LvOnXALVECIVFoRV0oZW2fG6t3IX3AbnNIbviQouAuMlaKoRo01/B3YfswvXbaeR2+mVI/Oqvk0p/TbiHrGtIl1a4sedp3rdJfZnr6TBwuBOzIMefzEyZCZ29gBkOsuxC7OPtJ7TmL8NSKdomBrghHvZcKjFTeQoVfvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=KH/4Hf74; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ed7024c8c5so45480291cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Dec 2025 02:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1765966096; x=1766570896; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5iOWOH87yTUjQrX+6lvY7Qje7Wqq4gmAE/Y8zWUAl60=;
        b=KH/4Hf748/eyXqTTaVjdRxtWwqJ+SyHmT9AfIQv5Xzzl/eQ55Nnhfrkn6PN8HBRNp+
         rPfQCQbncZwyG4gwqo2BlvP0uFXK6/Sah2I5yVwThzOZ92hkkjZQGt1XX+hCDK1MbixT
         CiL6YEe2ogjnJWBzGRTRqEbZ/uIFvCUf5ypLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765966096; x=1766570896;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5iOWOH87yTUjQrX+6lvY7Qje7Wqq4gmAE/Y8zWUAl60=;
        b=JYiMTNOGcYqq9CkN1lgzlVOfltCJYGVYo63JOuVHTd/Um79gFNHUnTyCgoaixLV4R4
         /VbjmELRrK1H357TlsdEPuVZm0XCKOwLF/euI6/nGGXvrwS/1EoXBs1iIqh//PLGfrdu
         h/Y3xXLE3Wggc/4apUhN7guemI+D9wtHOWfqwP7vDf4gc/NQviulaZrY27EFctIJM3/d
         5YVrgwv4UNolYJ93+yAJPqhnFk6ux9KeiBBP9X9z/d+taNqIwyNL6+Nd/2gOpAJvMVxV
         eMEQh3i40Y2vdLQo6KZvmKna8wp/THfiWzYfPTwwCVgti45q0pV4D2Jnn3wobmYne/SY
         x96A==
X-Forwarded-Encrypted: i=1; AJvYcCW7Yr/W0bFfcrEB5B4HgzLakhadCWIxinwGA1Fs770eqRr4c/XuO2mYZTyNTLurwy3g6thlHf3ktXAlWeXX@vger.kernel.org
X-Gm-Message-State: AOJu0YwSwvELBTCgliuhucA1TcpzHqrNT+sJ0guOvnkH4PJkn+ZHiEkK
	08NH5FNm+6S6/rBfgEu6xYn2wAWKBka48tsi5YwsAk9jbsNmm0ckkmIzhg2j7QtDw1nLy3M/rAg
	wrz/SnFZapWsYQXTh1d9VkguTZuW1kUJqAVGDjCTyaQ==
X-Gm-Gg: AY/fxX4XLFNAooLni0phbMVHpFD9jK/1tYNHXWGZ0cqS2krIG4Mq/w0d6oCUga5ILb8
	vbuqeSpbdYjwqeK3/gYVrNDnLebB1aUBQUWfxHftNNZu+it2YfJ53i+lV52T8W+9zCk2FW3ecBI
	lKewyG03x5lduZZwKN07uXVn69gYsXz+nxe9kM71rZwB9Wh3y4NzBMjdtrq1PXrsMaI18g/Qbre
	a6r0E5etYBVvNo7FukCBGjFhN1LfgHXZ+bkMdyXQEhyoGC3fDMq58Z3biB5wAPD7DcK
X-Google-Smtp-Source: AGHT+IENmyiffuhR1E85249uJOMBukjdN7IEdU+yZgj4tInjgk9NJQyQ6MT/4U5bfxSRkxD/WNEfOJ1et5Jld6U8DK8=
X-Received: by 2002:a05:622a:19a1:b0:4f1:b795:18bc with SMTP id
 d75a77b69052e-4f1d0629f75mr260633831cf.64.1765966096105; Wed, 17 Dec 2025
 02:08:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212181254.59365-1-luis@igalia.com> <20251212181254.59365-5-luis@igalia.com>
 <CAJnrk1aN4icSpL4XhVKAzySyVY+90xPG4cGfg7khQh-wXV+VaA@mail.gmail.com>
 <0427cbb9-f3f2-40e6-a03a-204c1798921d@ddn.com> <CAJnrk1a8nFhws6L61QSw21A4uR=67JSW+PyDF7jBH-YYFS8CEQ@mail.gmail.com>
 <20251217010046.GC7705@frogsfrogsfrogs> <CAJnrk1bVZDA9Q8u+9dpAySuaz+JDGdp9AcYyEMLe9zME35Y48g@mail.gmail.com>
 <87ike5xxbd.fsf@wotan.olymp>
In-Reply-To: <87ike5xxbd.fsf@wotan.olymp>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 17 Dec 2025 11:08:04 +0100
X-Gm-Features: AQt7F2r413xom3uHWk_AJkZrOPL8lUbHg9Y_OKsZVnSbaG1b7-VdU54GakePpJI
Message-ID: <CAJfpegsDL70SZVBKNcdUJcyuf+ifQGuMRy+p80ToUaQFL2aXag@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/6] fuse: implementation of the FUSE_LOOKUP_HANDLE operation
To: Luis Henriques <luis@igalia.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Bernd Schubert <bschubert@ddn.com>, Amir Goldstein <amir73il@gmail.com>, Kevin Chen <kchen@ddn.com>, 
	Horst Birthelmer <hbirthelmer@ddn.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matt Harvey <mharvey@jumptrading.com>, 
	"kernel-dev@igalia.com" <kernel-dev@igalia.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Dec 2025 at 10:38, Luis Henriques <luis@igalia.com> wrote:

> (A question that just appeared in my mind is whether the two lookup
> operations should be exclusive, i.e. if the kernel should explicitly avoid
> sending a LOOKUP to a server that implements LOOKUP_HANDLE and vice-versa.
> I _think_ the current implementation currently does this, but that was
> mostly by accident.)

Yes, I think LOOKUP_HANDLE should supersede LOOKUP.

Which begs the question: do we need nodeid and generation if file
handles are used by the server?

The generation is for guaranteeing uniqueness, and a file handle must
also provide that property, so it is clearly superfluous.

The nodeid is different.  It can be used as a temporary tag for easy
lookup of a cached object (e.g. cast to a pointer).  Since it's
temporary, it can't be embedded in the file handle.

The direct cache reference can be replaced with a hash table lookup
based on the file handle.  This would have an additional advantage,
namely that the lifetime of objects in the user cache are not strictly
synchronized with the kernel cache (FORGET completely omitted, or just
a hint).

Thanks,
Miklos


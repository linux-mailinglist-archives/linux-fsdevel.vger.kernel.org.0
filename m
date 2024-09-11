Return-Path: <linux-fsdevel+bounces-29086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E19974F41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 12:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21D7F1C220AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 10:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D369183CBB;
	Wed, 11 Sep 2024 10:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXxbHh2T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47B7155346
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Sep 2024 10:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726049270; cv=none; b=cSetGF7EefBByXL/MnkDyITg8Orzsch5K510z2WhP3V2WaYzUDhOMHSj2n5ZfHiYJQIonmVrjyuWjI3dEwEBPhOO4ekNchlQ839+tzGBVyD3bxTpEmro8srEjY1IdrZAUtAVDMRPfpA9/Ri7+Ih24BnlRC4UOeN4a2PYvDC0C+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726049270; c=relaxed/simple;
	bh=AeiyTSXg+ZT6WEvGKJlx93jiNG03zKUPMRzljOMkJxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NU5v5AnhHdhMfXkGKkDKum7nhcOdIw0t+1VU1DSO9IWorKsoHgD57uW5fxIpvcqyYyNDzyc7Byv5CpKCDHbB/EkAVarf5Llgar92NeWgSWsOMUtfOcz+p74W18dwIt2+HQP6YeywAXWhwdUTWl6ZE0xFyM3imE3BCdTjdpEBmSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXxbHh2T; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7163489149eso5418622a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Sep 2024 03:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726049268; x=1726654068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeiyTSXg+ZT6WEvGKJlx93jiNG03zKUPMRzljOMkJxg=;
        b=FXxbHh2TzSFhZHl3UHFCsNMs11vSldLEryPW2vV52hkTOf1bhzXJKIL7miTZeKzqu8
         LaNOqaRWSDQ7IZkLZABadGRTBjIKa/jK/eCJVc1CsJicg/ucNeeP59tdzHvDrsMxbjrp
         nfgS5psVKA3SjBP3CLrIT+Nsllw3vLQ29hWYl827ZBDbozk42U9ZKx2fuYok5G9k1+Af
         t4b7F9i6vqmTiahX0RocpzLAUTyUobY05NMy1GjSpVCePtM/kimpmF3B34cWXJjID+0t
         qT+0DRuzBGeZPZ0QcuUw8ndd+HGKm+5J9nteQXQi4Lu/gploTPMr6Y7cISVymS0xe6bX
         Acfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726049268; x=1726654068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AeiyTSXg+ZT6WEvGKJlx93jiNG03zKUPMRzljOMkJxg=;
        b=tu76TGFX2vI91RDnDtUU883gUID6c6FFZswt8Embrf9W5nSz61ET5tbp8iAgdsRgKg
         m7+fwEXfxoIzfHDjQGI/Chlnpl7wV1aZD9Rq5gI2BtEwtTh7UcFSud1TtBEPcMGpQxKu
         1rZ3X2MHUuK1eR9LW03wIlcqqw2ynBMDXka7VZyDzNCmGlTktflMIMZmny8m6TsDuUHP
         dj14gmhFvNL2dSIlL/5gdVQTCpqXQgHQTq2lKu0YqRi6k9QC1y0MjDi7oafZcJll2TH7
         AV/lre96FVkrLnqzq9E9YagRkLbYORstonY/6gtIjWpI3CzoUB4Icahl4X055AaXDLmf
         OXEA==
X-Forwarded-Encrypted: i=1; AJvYcCWhybzWxVw6D1AGulxjQ1DNTmy6l+YBLxB8zlC+un/KF7v0wRF+m1BLyi1lafeybas8zmhmTM4Crc+ciTm/@vger.kernel.org
X-Gm-Message-State: AOJu0YweBsJepyqtdHAatCVz/uUJTPNYpcv+yeV/SHzLaScMXr+HSVd5
	jOxb02Bzz1/btEG4cl9vxblvdwrfSR18+3koRNx0/54VNWsv77XDK+ImHSZeZb2mfz1ThHfBzTo
	1QzSjJlPB0Vazyhr4zcrP/4rnsQQ=
X-Google-Smtp-Source: AGHT+IHMCtUVxFz2/+fRpNEwfrwYiP1lQdVnsevqgn1Y5iFQNEHQkjy+E+APhwwlxr8STd3f1ciYXUrKv4yPWzir8ik=
X-Received: by 2002:a17:90b:4c4a:b0:2d3:bc5f:715f with SMTP id
 98e67ed59e1d1-2dad4df9581mr21904410a91.10.1726049267956; Wed, 11 Sep 2024
 03:07:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOw_e7bqrAkZtUcY=Q6ZSeh_bKo+jyQ=oNfuzKCJpRT=5s-Yqg@mail.gmail.com>
 <5012b62c-79f3-4ec4-af19-ace3f9b340e7@fastmail.fm> <CAOw_e7Yd7shq3oup-s3PVVQMyHE7rqFF8JNftnCU5Fyp8S5pYQ@mail.gmail.com>
 <CAJnrk1YxUqmV4uMJbokrsOajhtwuuXHRpB1T9r4DY-zoU7JZmQ@mail.gmail.com>
 <CAOw_e7YSyq8C+_Qu_dkxS2k4qEECcySGdmAtqPcyTXBtaeiQ7w@mail.gmail.com> <0a122714-8835-4658-b364-10f4709456e7@fastmail.fm>
In-Reply-To: <0a122714-8835-4658-b364-10f4709456e7@fastmail.fm>
From: Han-Wen Nienhuys <hanwenn@gmail.com>
Date: Wed, 11 Sep 2024 12:07:36 +0200
Message-ID: <CAOw_e7YvF5GVhR1Ozkw18w+kbe6s+Wf8EVCocEbVNh03b23THg@mail.gmail.com>
Subject: Re: Interrupt on readdirplus?
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 11:51=E2=80=AFAM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
> > If I don't ignore the offset, I have to implement a workaround on my
> > side which is expensive and clumsy (which is what the `mustSeek`
> > variable controls.)
> >
>
> That is the part I still do not understand - what is the issue if you do
> not ignore the offset? Is it maybe just the test suite that expects
> offset 25?

Not ignoring the offset means that I have to be prepared to support
some form of directory seeks.

Directory seeking is notoriously difficult to implement in general, so
few if any users have actually done this. If you don't have to support
directory seeks, a FS can just compile a list of entries on the
OPENDIR call, which the library can then return piecewise. This is not
correct enough to export the FS over NFS, but this works well enough
for almost any other application.

I can probably kludge up something if I remember what I sent in the
last readdirplus call, but then I would like to be really sure that I
only have to deal with the last READDIRPLUS call (or READDIR as well?
not sure.) having to be redone.

Besides being annoying to write, the kludge also takes up memory and
time on every call of readdirplus.

--=20
Han-Wen Nienhuys - hanwenn@gmail.com - http://www.xs4all.nl/~hanwen


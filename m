Return-Path: <linux-fsdevel+bounces-17243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D7F8A9873
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 13:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F343C1F22B20
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 11:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CFC15E5BC;
	Thu, 18 Apr 2024 11:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cT1b7SoD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA69D15B542
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Apr 2024 11:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713439452; cv=none; b=smeSzrO0MqRQB/2jalIUawZ8GkrPaKS9BbnDqHbSooiI2F8dlfCCFKMiWPOFEHALUilZOEGyH07Z5hOasxM9qlr3/i2o9oc0gLkSiy+JLX5tUlsrqUuwehV7KQRww2tINcg/VUz7I5kUHy9hoAWG8Uubrb/PRDxCTGcpeJ1f3a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713439452; c=relaxed/simple;
	bh=7p9II2+6mzGGxSqDcyqUxEIU+9mPe7JPFJ7NFBoK4iU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EmgCI/QoP5zK0w/oadOfdq6/DWPUwv0BVyJfijT+QpJV8mOmzGhcHUQPKV0wqPG0Ms/i0lyhugnKFLraOIurmcZbejwkAAfBUjYfPqp7qDCh4CRaNSSgAfJBj7jALTEDXB84eY5mCbpLVTbGKHVK9aXKeIYI7Pc5lCh2dZZYzCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cT1b7SoD; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-571bdbca3c8so81897a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Apr 2024 04:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713439448; x=1714044248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VNR1QUJOgk6ycIsrP5lacR4A2Q7qc4VgOEzVUu8VSYY=;
        b=cT1b7SoD9+79RGP2m9qZXo5NoFNxmnSUynr3+sD82BKNANm2GamHQgYbN/+I8mXgE+
         7jTL4oP5SbM5B489HPnJYNWPBU9duJzfi8bOmq8cArOr/lDYMgQEIOVqkCB9DMDp3qFC
         DLBW1m+TQwfmwPuobFHnvXmdOdpN+GHrmnngrUWCQuBhWnUkPWYsYU/mGQvUdMz3UxdO
         T/IDUeooakWfTM/sA56YV0mJ7s3/lbHRePclSG9LSu0MSUU2N6ZhfXaj2DrNxLA49k+h
         FmXlfhgUbDc2N89nwsxmt2BWE45tFciShpukw2ic+pguSixydC62K91zo95pFclWdah8
         bGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713439448; x=1714044248;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VNR1QUJOgk6ycIsrP5lacR4A2Q7qc4VgOEzVUu8VSYY=;
        b=G7yrzhzpaqr8xdg7mzrkJ0cVmZ4nLieHOZhxgnw8HTQ2eEySaHap+iRI+k6fvQaFVB
         l9T1WywFyp9dZ+4+1s+Eq4NsrVT5dzxCFt8B/KwIAfKpkbmjdAHYGFOpKSINmcMfgJj/
         Bjo1WNYaY9LdmywPZeKOiAMJtzaCXU/NqYzpgR+oCSQ45dkoLDEt1CmxJHio72wCwHNz
         PZFxWRTD9FecsTHqHLhLwfPxhjUkZTA61tmQcMABQSJzBqyt15imClCvbcqDggAm7ax8
         xSMXM0w1E9fXSzoC5ODOqq87v8qbZgWi+i7P/Crk71QHFmEGP2op2HMkz10F5cXYeWj4
         vJOA==
X-Forwarded-Encrypted: i=1; AJvYcCVLUzyfBzas70L2mS/cj2Flr2aLoxH5rRyC2b87SUtPMGdHk0DQubmsilk5GgVpSOcwbMLRws5WyOUejrScHsHec2cpcUt4KQvf8siwNg==
X-Gm-Message-State: AOJu0Yzk57/2UvFSqVg7rtsY24H3RFij/ny3RHLzEr7pC75BKzSbDFrD
	oYzuLThJZB+5p2cOQwHD89TmXy3BgtIfISPSmz5kQrtm/LnOJJfUBlpjAx0vpBRe6r/t1ifsk6+
	gNQ==
X-Google-Smtp-Source: AGHT+IFgB25PfeRTTxi+P20J+DJ77jyxs20V5UD9HuczYalCvPXrPLDinB0rPJRRjLyn+dlu+/szbDZiJoE=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:aa7:de01:0:b0:571:bd82:9c4c with SMTP id
 h1-20020aa7de01000000b00571bd829c4cmr1570edv.8.1713439447884; Thu, 18 Apr
 2024 04:24:07 -0700 (PDT)
Date: Thu, 18 Apr 2024 13:24:05 +0200
In-Reply-To: <20240412.IKoh6rius5ye@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405214040.101396-1-gnoack@google.com> <20240405214040.101396-8-gnoack@google.com>
 <20240412.IKoh6rius5ye@digikod.net>
Message-ID: <ZiEC1bbYezkX5POQ@google.com>
Subject: Re: [PATCH v14 07/12] selftests/landlock: Check IOCTL restrictions
 for named UNIX domain sockets
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 05:17:54PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> On Fri, Apr 05, 2024 at 09:40:35PM +0000, G=C3=BCnther Noack wrote:
>=20
> Please add a small patch description.  You can list the name of the
> test.

Done - I explained what the test checks for (that the access right should h=
ave
no effect on named UNIX domain sockets).

> > diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing=
/selftests/landlock/fs_test.c
> > index 215f0e8bcd69..10b29a288e9c 100644
> > --- a/tools/testing/selftests/landlock/fs_test.c
> > +++ b/tools/testing/selftests/landlock/fs_test.c

> > +	ASSERT_LE(0, (srv_fd =3D socket(AF_UNIX, SOCK_STREAM, 0)));
>=20
> I'd prefer not to have this kind of assignment and check at the same
> time.

Done.


> > +	ASSERT_LE(0, (cli_fd =3D socket(AF_UNIX, SOCK_STREAM, 0)));
>=20
> Same here.

Done.

=E2=80=94G=C3=BCnther


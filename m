Return-Path: <linux-fsdevel+bounces-73066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 322BED0B457
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 17:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9FD983073798
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 16:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B04363C66;
	Fri,  9 Jan 2026 16:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="VPDl9FM/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C75433C1B3
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jan 2026 16:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767976123; cv=none; b=Iw9mSbXf1wrubY2eIH4zHPQ0gKmjdfJH2AzScx/fovSyzY/5KxpqNjTvMxYvIEcZbGl3XZ83fMZna/8yu4IX+GhQMR4ScJpjfeR6Q97VJobJZka54WX5+cZhSaZ2wdEAEUrNE19mGRYe8WeRCgZqFa/1D3//9xZ7BDWl7TqlaLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767976123; c=relaxed/simple;
	bh=AOe0srFBRRLsR7c5kfwLTg1atEK1CAPwOrFzJBZH2sE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iRG8Zt2piinpIjra4EZAb607nMyufsA8oY0D5iUcii8584vL1Yqn1140j5gXCVEiv9Nj7907HfZtV06C5hpXySgaJdE37yJR0EecwTvhL2qzo93FXVQz27BqE6V1Xv0MgbOQyf/lt0Xd8CdV+qZpE8JdRtScQNLyYG6Eml5B/7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=VPDl9FM/; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4f1b147eaa9so35665521cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jan 2026 08:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1767976121; x=1768580921; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kv3RyFoJMLDWT31tvhclXPA19NwPQx4+mGuzW6gcNe8=;
        b=VPDl9FM/ETuvAw57OfKJEQ+VM+PQr1w8Clvk2feogkxjx+qTdi1aUtyTN2LVmcijeT
         c82gROSBjgu0Uddw7hIflL2q7stswV1uX+YZpBpSp3OgF/JXsSOnFbDYJ/bmEAcns72f
         05BKhp65Nne4oPPWXyWHQthlylm7KDXL6lPgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767976121; x=1768580921;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kv3RyFoJMLDWT31tvhclXPA19NwPQx4+mGuzW6gcNe8=;
        b=BbLoqLoSLVO0RUAbMPwnFeBo8+MMB/kQq7NPP5wIzqrQKQWJ66xcAUOD+WHmxVnW4E
         zEXXXDV3an+Ekps8wgQctf28xt592fQfO4bgjl7fZXHszyp887r2QEWl9eiS7YIriJwE
         aZXAtVwj7argYMrtTFuAiVBnq1So03uKQFAptMIWdjNwYDpU46MWLdCr0D8tLmH9tczB
         vdHoAAUUmClT84w97uNJFPKZhiEtjU5Zme+libdOX7dfVxzGgQIoWfl7erKisPzeBeuO
         nDAmUYAug+5JvmRLUv3CGONedBVzFxniKKm7OnqlnX3dAmKGdSf4vdX0K9Z3QFHVz1dO
         iJPg==
X-Forwarded-Encrypted: i=1; AJvYcCVG/6FuXcpK/EM0UY0KD4voerkMPLCHjLS/XPmay6hF9hQNJdq7wu1pauzXMz2pZcls9dMZ0AlTnRCBbzgH@vger.kernel.org
X-Gm-Message-State: AOJu0YyvIBAnAhOM3UGiobzKnD8E7wJPq0aTCM2eG4GYz/Dtvzi6OU2h
	ZUI5L9dtCmy9n0opKy46EiNLCWayImKN/b9jimM+Hf1/zbczWfdXAet+6VmmJmtyjFfia2uOfEd
	TVVaXKG3xPGVdX4H9VLGo04tUmALwZoMRYSJHdBck6g==
X-Gm-Gg: AY/fxX6F1f6zhzbQE0dctbBZ+j+pLKdjMgX634RntMw8SIrIgRv3sPqNLJJxD5ZZH0I
	kWk7xnecyr+G+XclaK/B5ISGM7P4xb6Hz01c1qDG1x5hG/ZhP8zqx474m6zjWG+Sh/DtezMtZfG
	gtT4KxmP+TJ18aRneuWoHdnYhSju2XhDTuxpN9L3v8n2I2xvkQEWoWTGg65ku6Dna24dNjc8qZR
	D102Enx15GbnpToGG9maBNjZE1JcEHo5mEoUncLPi8PZsWamytdo22FFjsrKw1jmrai
X-Google-Smtp-Source: AGHT+IEMUxmVnZUzM+3nB0BQsT0vLmNupAqHBaWEdLGTQXEXjM5mhbLt36UURp+cmEyTE8IlvTNxulghTpSdnVpq1S8=
X-Received: by 2002:a05:622a:588c:b0:4f3:5f7b:cc1d with SMTP id
 d75a77b69052e-4ffb499a2abmr153559631cf.34.1767976121326; Fri, 09 Jan 2026
 08:28:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212181254.59365-1-luis@igalia.com> <20251212181254.59365-5-luis@igalia.com>
 <CAJfpegszP+2XA=vADK4r09KU30BQd-r9sNu2Dog88yLG8iV7WQ@mail.gmail.com>
 <87zf6nov6c.fsf@wotan.olymp> <CAJfpegst6oha7-M+8v9cYpk7MR-9k_PZofJ3uzG39DnVoVXMkA@mail.gmail.com>
 <CAOQ4uxjXN0BNZaFmgs3U7g5jPmBOVV4HenJYgdfO_-6oV94ACw@mail.gmail.com>
 <CAJfpegsS1gijE=hoaQCiR+i7vmHHxxhkguGJvMf6aJ2Ez9r1dw@mail.gmail.com> <b2582658-c5e9-4cf8-b673-5ccc78fe0d75@ddn.com>
In-Reply-To: <b2582658-c5e9-4cf8-b673-5ccc78fe0d75@ddn.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 9 Jan 2026 17:28:30 +0100
X-Gm-Features: AQt7F2qLAZx0wYBHRdCdWQYamgB2RaN-W8h3Jcu8YCVf2uAdgcy9XdOdC4SmmqM
Message-ID: <CAJfpegvxLqpa0ttnEjY1W1Oqf5vpw3uKrrf8y5DdnuXcnQJzNg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/6] fuse: implementation of the FUSE_LOOKUP_HANDLE operation
To: Bernd Schubert <bschubert@ddn.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Luis Henriques <luis@igalia.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, 
	Horst Birthelmer <hbirthelmer@ddn.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Matt Harvey <mharvey@jumptrading.com>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Jan 2026 at 16:56, Bernd Schubert <bschubert@ddn.com> wrote:

> Feasible, but we should extend io-uring to FUSE_NOTIFY first, otherwise
> this will have a painful overhead.

We don't want to do the lock/add/unlock for individual dentries
anyway, so might as well make this FUSE_NOTIFY_ENTRIES.  That would
lock the directory, add a bunch of dentries, then unlock.

The fun part is that locking the directory must not be done from the
READDIR context, as rwsem read locks are apparently not nestable.
This would make the interface a pain to use.  We could work around
that by checking if a READDIR is currently in progress and then
synchronizing the two such that the entries are added with the
directory lock held.   It's a bit of complexity, but maybe worth it as
it's going to be the common usage.

Thanks,
Miklos


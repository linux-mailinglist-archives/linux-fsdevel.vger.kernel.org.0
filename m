Return-Path: <linux-fsdevel+bounces-62317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F0AB8CAA1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 16:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 290DA568033
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 14:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607CF2FF151;
	Sat, 20 Sep 2025 14:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cgbfwepd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552E0366
	for <linux-fsdevel@vger.kernel.org>; Sat, 20 Sep 2025 14:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758379554; cv=none; b=eQkbjyZ1PNH6N40wZM6P/v7ryxlSejeH09NP9KLDW48LSZXELClolFKl1vAftf8LSBdalFiocvEWKDR0ajSD6AoSpi7I+QBksvpqBNjQnmRm4fm3KulPvs09iWSRe1fLuGLrfCNJhst66xgtXTJ6xCuRCsVhMtg49CKxIJXyrOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758379554; c=relaxed/simple;
	bh=prBMWFMAjr7chjhq3P8rvyzynNtcsazQYroaTwzNLjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CBZNzefLX3v+r6yJCeEJiPwVwWh2Sw+h4qR/YNVdxLY0en0Qp9UWat0zLVFea1z6bNSsf+ksfDrU7BQmX74AzpW3KDptt99tCQrZsSOAu8EkwKc5yBM2m1j5bJR/IQY+VRg+kA+Gx3c3xSQroZfUi9t3lJvfZzRSWSkuBckKlbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cgbfwepd; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-62fce8b75a3so2444390a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Sep 2025 07:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758379549; x=1758984349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prBMWFMAjr7chjhq3P8rvyzynNtcsazQYroaTwzNLjk=;
        b=CgbfwepdIvIdG+kIvTHvZ3bhrU15DZeNDymrei7KGLcOTrunR1M1LSsArcR74N5qmN
         GSBJdQxqjxaPXKQiH8iO7CMrm9Yrp0jZAP99ptp7a9aG+3P/j0kcK9RCv5ebLmr6kjvL
         DkKjABbATudAZo8FNzhqOqvzTfezcUzooJ+2eAo/BhpYWw/OHgy/lqBEM6Ec77s0vlmY
         hOF+FU1Bb/ZJdUlyUgv5rijGV5dHoS2RU/UP7bkeve1BhaRyntJ6ttuYsAQp89mNSUSg
         Uyu2Q3s5ltbzR6Rf4EH1XitBCnRb2t3chjsOt8LxshlC6gHSy0RTn5/vgdjZ2+y8miZQ
         8Hgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758379549; x=1758984349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=prBMWFMAjr7chjhq3P8rvyzynNtcsazQYroaTwzNLjk=;
        b=Rc/jDuRBJ5M4blFqTE6xhx88rMYlOUsgVuL+Bi5CWvH7cMaV2pH314meeYJqnklijZ
         72u7ynRaaOGlPk6O2ouAZncbu9MzVT+6SZtj21SsH9F63hVjWYNLcKq9ZyvOzl9AhOlj
         HukMjLsprvl0FUjzCeOBK+bb52bfGJ1+OM4aSIvzP+FlbpNnpFiecpxBm8K5He20K011
         0acMywvj3ZWLRqfNs7SV4DwKlC/5HeImPjHWTvM7BSMxTymvH3ubi5wKUq1m7IdJAmGZ
         udzZw7cgVSloWmwV/daEEp0R/YKBLG4vkXSckRT4tA9erf+3VE7skUQpAD1iTCo7mqyL
         ulAg==
X-Forwarded-Encrypted: i=1; AJvYcCVNnhn2tZKNSPxFUTP5TlPuMymQLKhYWpsKZyvEjxoUswd9IikrN6zi0jb7MjavKpZa1X7Kg2IrYe0XLvad@vger.kernel.org
X-Gm-Message-State: AOJu0YxUqjYp18TfnHcpo4axHsbYT8BuesVtK/1KiabxCKq/37BWBhAi
	D521F7HiyHkb/HPXRarYgfoMPRFTCUHqk60+pHdDo2aaslbOIF5DMzHWXyzt4afNv6lbs0xehW3
	3X/RGOUHt740b/g79VVLqnx+tZvYmYbU=
X-Gm-Gg: ASbGncsXXD2rtEDEi/dnc3ZnMaAcz4tGPKXeasXPiYpaw0c+eV9pUDzt7IYlJ4yO2MR
	tzGWOAQwb14BtFvtCn5k86xwUnRKswOL5JhWfgPO5PltA9uwnT7NoophGrVKLMcmj7EynCyNtB1
	8sDt1tzUkwpcCr7U/9577Zfnnqvf4ZqiZmseXZ0VecitUkAfOFG8rcrXXXfHhXfqC/qCZmfrcfI
	2SpDlQ4wG4dhLcZ1gaSOBGNVXGCU0NaWi4mMA==
X-Google-Smtp-Source: AGHT+IHprf6sIuf8mcq+DmIUBFqEQvSlyTeJhORDOjRBm1D3ME0hm3yswxncK13S9OfrbZrNkgv0Ra//B/ErT5QPBuA=
X-Received: by 2002:a05:6402:3488:b0:62f:464a:58d8 with SMTP id
 4fb4d7f45d1cf-62fc090a920mr5609831a12.3.1758379548473; Sat, 20 Sep 2025
 07:45:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752824628.git.namcao@linutronix.de> <43d64ad765e2c47e958f01246320359b11379466.1752824628.git.namcao@linutronix.de>
 <aflo53gea7i6cyy22avn7mqxb3xboakgjwnmj4bqmjp6oafejj@owgv35lly7zq>
 <87zfat19i7.fsf@yellow.woof> <CAGudoHFLrkk_FBgFJ_ppr60ARSoJT7JLji4soLdKbrKBOxTR1Q@mail.gmail.com>
 <20250920154212.70138da8@pumpkin>
In-Reply-To: <20250920154212.70138da8@pumpkin>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sat, 20 Sep 2025 16:45:36 +0200
X-Gm-Features: AS18NWB9O-d4JEBCOZIFX72GOz0-xwuKTumjYGdgLUXXtHzgyf5FekADp6hUP4M
Message-ID: <CAGudoHG9hTwSoordwbMDci5CmnCKMhD330Z0BKfNJ+xUHYC9uA@mail.gmail.com>
Subject: Re: [PATCH 2/2] eventpoll: Fix epoll_wait() report false negative
To: David Laight <david.laight.linux@gmail.com>
Cc: Nam Cao <namcao@linutronix.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Khazhismel Kumykov <khazhy@google.com>, Willem de Bruijn <willemb@google.com>, 
	Eric Dumazet <edumazet@google.com>, Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 4:42=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Wed, 17 Sep 2025 18:05:45 +0200
> Mateusz Guzik <mjguzik@gmail.com> wrote:
> > I can agree the current state concerning ep_events_available() is
> > avoidably error prone and something(tm) should be done. fwiw the
> > refcount thing is almost free on amd64, I have no idea how this pans
> > out on arm64.
>
> Atomic operations are anything but free....
> They are likely to be a similar cost to an uncontested spinlock entry.
>

In this context it was supposed to be s/refcount/seqcount/ and on
amd64 that's loading the same var twice + a branch for the read thing.
Not *free* but not in the same galaxy comped to acquiring a spinlock
(even assuming it is uncontested).


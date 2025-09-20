Return-Path: <linux-fsdevel+bounces-62316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 446B1B8CA80
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 16:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB29D56781E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 14:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C0A2FF151;
	Sat, 20 Sep 2025 14:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBh26vfu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875A42FD7B3
	for <linux-fsdevel@vger.kernel.org>; Sat, 20 Sep 2025 14:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758379338; cv=none; b=uTYBaEOBxB2jgll5mJRINEZM2/TqLC+MmElGyaM3OGQrTu4//GHFLCxnxnH3DW4qGEHCrjl/pnnsTXKHN+F2P4OxaqhArMNroRIsFeIXDd8/izWhpEHgSxEE4SRxMm0as0yvjtkdJBOjnhGFvPa27VBTwSSyEWldnqrOb1+nkCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758379338; c=relaxed/simple;
	bh=Usj+C0PegNI69LjXkoxW4n3D3nNnaTN61TPyqGGREUg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dkS8yxzYF0WSTi508O6tg+yQJBLo6aYb8TlfGfzPCyGItI3BDCaedvfZfGj39G0amq9859OBYNawaUmRV336ae0GGnZpbjt+1dvdC1IcAiBtdOm6yvHNPhFI2kw/MQAMynJt9KcyNxRkcnqG3ZXhtCLvX6jq9uAWkzNgrdJdoKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBh26vfu; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3f2ae6fadb4so958664f8f.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Sep 2025 07:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758379335; x=1758984135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zEtvZFtGHRjuP+b5JrK4y2e0Le4iom+VLjgkoz3MMAI=;
        b=WBh26vfuPt1v7nUePPcsFH84PRSWsZRe01lfn30cpMtrepsl71yLYCLV+se2DVfnD2
         3kBlNEAQdErnoHHlmWYchDCqpeV1WrNmDizsfWReIMYSvZL7NicvIsUtpw96i8jQZ7qE
         o/Y70ZGKrM0vCd/Hlud7M84kweUA3x6dfKG6m5FMD0AfL0rlzsYCTvDBKdDdVNnPyM0f
         fw0h+/iH9LxW3p51Qaot0+K5noDp5q28cuEvXVRDIUTRTMoS8VzAB3kP2KtkbfjN8ZvS
         g31UsestdnSZAKkIgHcIIsi/mufkmwcLqPzkdj9jIGG2ChKnfylNm9TksgHuIlIhelig
         pOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758379335; x=1758984135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zEtvZFtGHRjuP+b5JrK4y2e0Le4iom+VLjgkoz3MMAI=;
        b=U1NZuY12lEFPKv8APyuFiVblQ/Uuy9zYIIq+zzbbgYWvyaKjwjI7bz20zeSAUjikKQ
         bwkBCm0zMxoEJahw0T77h8vaGlonXPBAKJvwe0bZupgpWI7IZEF1zo0MyCqDvBf9KasR
         z/7kWgoq1gi4lgehbXBvgQXYbcP2cZbCoiAGtXGUL8IxYuXmA3nhKtD07wBuoYVs32Dk
         B9zwNm5K603ZYtSAOlx0C4ZlBIsgCTftDtOTCtVVezSMf+Eozac+LpueWWiGnb45C5x7
         itOm22TWmYwwtDJy4CGINCcKceJL3b5ZkEKZGWP8amcJV14HDEzm8YWvi8sLzT78N2KS
         mfWA==
X-Forwarded-Encrypted: i=1; AJvYcCViLUTftK8CwcFlzCoEe7Jcru8zvQry1PYpgDkI93CWINlFS3TRLsSHLyfnw59ShgQ6NT7pLN77KH+FfZa+@vger.kernel.org
X-Gm-Message-State: AOJu0YzyEJ1Txw9biZiU0+54w8Lxn2rnu0uZ0VVmo0WaDLzoQWLGUFwJ
	P1JluDNBjkzzqrBSSIXZqaHVHHV2Jq1sMK+R6emb5CbtMCk4iz58h3qk
X-Gm-Gg: ASbGncs3q/m3m5ms/GU76JgLV+7Q/K2Ti/KlEUnp/EPpx2KwzCWF8gOs19Ae4JTFijG
	7Ayh3XV14BVfwcdogVs2Yo2VuIqazL01S1Rxv6VA0yU6mOlZFvsBpQ6ZF1vXZ/chsNRaKl8Gcb5
	zFK8ub7YRbwRdynlVtEHSQdBXR7wQqDf0hLxLa7LhEkP3Pg/hE1Er6cPanwHXN3AAUcn/KWCbvk
	coQDsn2tbqiezI5cR58RsLGrSxUdmB1r9pbBK2QS9ZF5/8LZ7TfpIbkyCmToN/cepa4S/DjB12R
	+9cL20pu3ut2O3YLePcNOMJ0CUoPpDodqFjvAvbmYILqeP+yMVtWEh1QjFug9C1gXcqIxlLs+Ss
	4fhVWisvB4BI1b7YuKu1VqoOa/I9N/vTZxYXL5E2Evn/7bp/ZTNbu0nV1fc+DKCDdO1M3c5g=
X-Google-Smtp-Source: AGHT+IE1XfrrZKs7jUn/HCTxExNiug3StteTdhLU8bG47WeeJj4XJHY17xNSaGVA8TgcYBm5il8CoA==
X-Received: by 2002:adf:8bc5:0:b0:3f0:9bf0:a37b with SMTP id ffacd0b85a97d-3f09bf0a4afmr3138635f8f.43.1758379334535;
        Sat, 20 Sep 2025 07:42:14 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f6695a9dsm132985055e9.24.2025.09.20.07.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 07:42:14 -0700 (PDT)
Date: Sat, 20 Sep 2025 15:42:12 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Nam Cao <namcao@linutronix.de>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, Davidlohr Bueso
 <dave@stgolabs.net>, Soheil Hassas Yeganeh <soheil@google.com>, Khazhismel
 Kumykov <khazhy@google.com>, Willem de Bruijn <willemb@google.com>, Eric
 Dumazet <edumazet@google.com>, Jens Axboe <axboe@kernel.dk>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] eventpoll: Fix epoll_wait() report false negative
Message-ID: <20250920154212.70138da8@pumpkin>
In-Reply-To: <CAGudoHFLrkk_FBgFJ_ppr60ARSoJT7JLji4soLdKbrKBOxTR1Q@mail.gmail.com>
References: <cover.1752824628.git.namcao@linutronix.de>
	<43d64ad765e2c47e958f01246320359b11379466.1752824628.git.namcao@linutronix.de>
	<aflo53gea7i6cyy22avn7mqxb3xboakgjwnmj4bqmjp6oafejj@owgv35lly7zq>
	<87zfat19i7.fsf@yellow.woof>
	<CAGudoHFLrkk_FBgFJ_ppr60ARSoJT7JLji4soLdKbrKBOxTR1Q@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Sep 2025 18:05:45 +0200
Mateusz Guzik <mjguzik@gmail.com> wrote:

> On Wed, Sep 17, 2025 at 3:41=E2=80=AFPM Nam Cao <namcao@linutronix.de> wr=
ote:
> > My question is whether the performance of epoll_wait() with zero
> > timeout is really that important that we have to complicate
> > things. If epoll_wait() with zero timeout is called repeatedly in a loop
> > but there is no event, I'm sure there will be measurabled performance
> > drop. But sane user would just use timeout in that case.
> >
> > epoll's data is protected by a lock. Therefore I think the most
> > straightforward solution is just taking the lock before reading the
> > data.
> > =20
>=20
> I have no idea what the original use case is. I see the author of the
> patch is cc'ed, so hopefully they will answer.
>=20
> > Lockless is hard to get right and may cause hard-to-debug problems. So
> > unless this performance drop somehow bothers someone, I would prefer
> > "keep it simple, stupid".
> > =20
>=20
> Well epoll is known to suffer from lock contention, so I would like to
> think the lockless games were motivated by a real-world need, but I'm
> not going peruse the history to find out.
>=20
> I can agree the current state concerning ep_events_available() is
> avoidably error prone and something(tm) should be done. fwiw the
> refcount thing is almost free on amd64, I have no idea how this pans
> out on arm64.

Atomic operations are anything but free....
They are likely to be a similar cost to an uncontested spinlock entry.

	David



Return-Path: <linux-fsdevel+bounces-36288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9889E0EE5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 23:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66366281BCC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 22:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07421DF981;
	Mon,  2 Dec 2024 22:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGso3U+l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DF51DED48;
	Mon,  2 Dec 2024 22:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733178378; cv=none; b=Lkou5aH/3ReuzMD5p7Xw+pobWyTgN7J8+nMrry+m4djihqtnFooVXBSXMOR5/jisDlcGdZgia04POKF4d4YEj1xNPR+QcYkOycd3hTy7K6iWGXm3kkR4hjtmDAUmlNF1p0povCZgymQBh6I8KVkaw7qjpfGlpe7ccHU5QxAakHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733178378; c=relaxed/simple;
	bh=xlGKDkBvh1HHJyZOraoR4DravMfrgq6etXDRDvcy4zk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YSIk0zb0x7v9r1pwh0V/xcsJNmqRozrZvXCA/euH7sWaPhBnAdeGnHk38/IovoU7umSKhCZMHluM+cUWRp/JWgzkxEHNrH8faHZwfs0yUfQq+K8NW58bqhLnviu7Tgd7iJ5dov+Bs7rvyJosm1xxhwFpGvSB9bi2xL4X15dT9+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGso3U+l; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e3988fdb580so2942080276.2;
        Mon, 02 Dec 2024 14:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733178376; x=1733783176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlGKDkBvh1HHJyZOraoR4DravMfrgq6etXDRDvcy4zk=;
        b=iGso3U+lsHHTZXv/r+xRkVYNWE91BB/S6SIYzqZC23yk+2vmnby1Ai+0wLVOoUsJOw
         aKUezCMSF9gSjDOX4D1zn/A/zBA1pxUc0rncKQSsy4NVTqYQU2+sKvHdRp6Oe1G2BGZ/
         c4VWfiBrleo1+f1Hn4WONtbuvsCAaSWQpNu+Vkhn7QlOM3yqj9U62Q8G7KoccqmDDCbJ
         DGosjFEcfm2nl3kS9uQr0/aSK7Qisoq1eCyE7MljCPKHJ0c3zAh4sVK4Ag2A0366v4iQ
         iGswjq6Yru6moQ97AGk1Zcbzkww4ofHfnqyM1EZluJvLCpG+Nk3BJbx+dAcRbkB/41J2
         iOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733178376; x=1733783176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlGKDkBvh1HHJyZOraoR4DravMfrgq6etXDRDvcy4zk=;
        b=XGE7WSkRwbAJ9/HrBpTxogzgM32A39pfbvoQ1lQKrJhAz2UqIGPDd0W8B/oKrtspg3
         zbyYikkvqUijikuUAmMNoWEdZ6KJH11mnzMR9Ui+/OgqqKlx+lyLsQxKG7JWNZScSccS
         jQfLHgdnhix67KUoF2Td02Kf1lZso3GkIAkPWgcmH/mCJk4KYpGRbowIdQlbK8QOaGkv
         GMvxnlD78Rde2fiXCQYdyNHNpGxtSuPKBnaid9eyOszORuJu32mFc2tHhmtfNbR7QY3P
         +P9DiowHDUhE2J1SWGR94l1TRs5Bv3PPJL84X0MhmkNafGFhoX35TXvhkn2z1+YH4bVT
         af6A==
X-Forwarded-Encrypted: i=1; AJvYcCV1M5+GzcEvZY4IKJmqXvvCxciUUB3qRFoxmmg7yeiGiCxIUd0KTt+c/PqFY4mnCRjkywK5Ygv7q0PmmCjn@vger.kernel.org, AJvYcCXJFHZ2cZXyA7TRWUlzBtRUXKStpa+TPwRRA/8+uAkYB7hH9x1fN9Yt/Rau4fRClPNs6Ppep2ckL3T5YTuX@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp4iAHqAZGsx8m6g0+FJU8uRFceqfw9MHtGb5jtDe/Y3ohEl8F
	8iMoCtWun7L2GGgAxzZvyRFWUjDtItIPOY7GJZTjpaaf/QlrkpA9+GyQHhQnQw3/fSSTv5ahjzS
	nNZLFJB7cx/o1BphQQZ2oMjo0uRaWq98y
X-Gm-Gg: ASbGnctYpRQSOjqpYu0bQMvlt6drYKFVeFOGDuxhcTKw/oRYhcyamgyDPIrHGjqBitL
	bH6WJsacQq+dq669HxsyCDvKz+xzwo6o/nBHzDugHvyCx5eA=
X-Google-Smtp-Source: AGHT+IFnbvTrrl1niJo6mXOE5ZV2XGcUATGCksc3CASCtxStmBkQ7var3lXdLeNG2XNGefTklysWi5FJ5TD0eGY4xGQ=
X-Received: by 2002:a05:6902:849:b0:e39:a8c0:a66f with SMTP id
 3f1490d57ef6-e39d43903b4mr90733276.44.1733178375982; Mon, 02 Dec 2024
 14:26:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241130065118.539620-1-niharchaithanya@gmail.com>
 <8806fcd7-8db3-4f9e-ae58-d9a2c7c55702@fastmail.fm> <CAJnrk1b1zM=Zyn+LiV2bLbShQoCj4z5b++W2H4h7zR0QbTdZjg@mail.gmail.com>
 <364da8c4-7559-4c6e-afc4-d1b59a297d51@fastmail.fm> <c2f05447-0f1b-4710-ad7f-d318b95ac7e3@fastmail.fm>
In-Reply-To: <c2f05447-0f1b-4710-ad7f-d318b95ac7e3@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 2 Dec 2024 14:26:05 -0800
Message-ID: <CAJnrk1a32utHmJV2_PyotfBdTkpKbBXGLgf0ZjHbCrGOufSNZg@mail.gmail.com>
Subject: Re: [PATCH] fuse: add a null-ptr check
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Nihar Chaithanya <niharchaithanya@gmail.com>, miklos@szeredi.hu, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, 
	syzbot+87b8e6ed25dbc41759f7@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 1:50=E2=80=AFPM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
> I think I found it, look into fuse_get_user_pages() in your patch - it
> returns nbytesp as coming in, without having added any pages.

Nice!! Just saw your submission here:
https://lore.kernel.org/linux-fsdevel/20241202-fix-fuse_get_user_pages-v1-1=
-8b5cccaf5bbe@ddn.com/T/#u
Will comment on that thread.

Thanks,
Joanne


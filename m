Return-Path: <linux-fsdevel+bounces-71377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AD4CC0972
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 03:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EC6E3019BB3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 02:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B6A2DEA8E;
	Tue, 16 Dec 2025 02:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bRDzwOHK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C282D8DDB
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 02:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765851511; cv=none; b=hldxGucUv/LEKMi7qhRtVjLL33foUazEKs2rgMF0W6QNBkouuPKD0JJ4j6cwz4v3NE4eSAdnLMvrIJGGhe/spf79kT/BxSCVN/VigeGDFJlt3QX6iIQITSOyX/E5jn44og6QfKjvEb2wcEU0/ccJlMThVEgOq3R8qEsJW4PhbeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765851511; c=relaxed/simple;
	bh=87IUC5B+EmxqpWOYohTUfn4MeP9hxTM96c9slLvqD+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jo0FlfGkEkuJT+BJQk6qePG9DDDIwDUNZXR6mrD70+R6Iba97AIut/90oxWIPtZD8PQLHckcXSWU5+ooFJrEJUjaA0i6tLrUM7NJ7fHPlB85TMDI7/FyZ2Iub6rfXk7qDA8bqfCK1zdounuzry+TBJTOJagBGRLZsmv+tdKU57s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bRDzwOHK; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7f89d0b37f0so745372b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 18:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1765851508; x=1766456308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRjpFIpOzRZ2BiN5IiVV5goUIm9mEGJRGqt04cQHEgw=;
        b=bRDzwOHKf+ddNhsIaSzQ+GVimdKudyYrZ6qE9F6bTCB6zCFsplK7eGPK8aPLqbGsBm
         qyBUCyBYT7CNuVtCISJbBZoJECVSkk9VcJ3FMicEfoG3NYs2ZgWoXgSR9KE3sF0+uoAn
         91+qMg0e1z/llL18hp634ePTGGivr/aT3drbwVJOKAxXE0+RBbQZxanYJf44YtBJRMaX
         1Gk55GB71x/bDfIkT7ZN+wWRPDEUmy04x2jovo99d1j9YNRYxqewExSj9xo/TRRn8jyM
         TicxeTNWsh5u5sTWZDC9w1BB8MaVJmUP6qKhVxXQlsykmiVJTJx3nZPvRpJbz34L8o3c
         YPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765851508; x=1766456308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gRjpFIpOzRZ2BiN5IiVV5goUIm9mEGJRGqt04cQHEgw=;
        b=uZEdEqWozCCh6g8BIlcDiy7o2onQTzGVosWipItqHpUz4rrk2RIWeixrzLTf88dqbP
         DZfIzKqpOEI1Qjol7vtnK5TZ6fjCswhwwCsvMnpCmW2zFtcPkCvSLO+Mxnkdxnjnv9qK
         yb6PUaCQ0q+pSNdUmiix8To8IHhltB0RzI8x5wijoNKLBNetZPbAduuOdDc05VysUo37
         9FAMvR5ByVOTn3hvYnfMvdOq7H76tgWl3xXkWIyn9j5ehHwik+6ffoXQrjiFbuz65gk2
         /whPisMkr09To7rg4XtZIU+hum4xtBLJTK8ZkcDob1aya9oHnHtCCyc4Xy0dY398RjKV
         /+pg==
X-Gm-Message-State: AOJu0Yzx/nZHRXX0D3yr8CCsESV0S4/F7IOclnxWX8Wfq0lNLRu43fgG
	5wD1Wqljqq0BF+59B32U0cuBFChaHeo1zHaPNsmoTBH+LDvthJSvC4vwXhuWV7przOQoab7h94q
	V9fW4lu+u2ZFlmGGXBTrNQVT/SQ36jVzxKmUgBgXS
X-Gm-Gg: AY/fxX60Z50wcAc8ZOmJNWrRU8qOWkO6UZ1IlZ0z6bfjtyqzYYwesIMT5NDGjrZys99
	37w7YvzgpboYEa98JAeQCbfuhd5LLeC55MWiKpRHV1NxAg8HCVuGtEIAwYGAAcEp3ZnIjqkl4Hh
	h824O1hf8ao7vLDOtv9C2vG5HeijrW0bDhwnZtqz9h11i9gzAW2Tfvdl7X1yinuo/f4FQSuKNvw
	wHRTiYg/ck4O0u8Ve08CAiqaBzrXGLsil+tfwr7+Sf+Y5QAWwFQoWPBEFjGW/T/wnKuVK0=
X-Google-Smtp-Source: AGHT+IFN0n0Z1ONhFG1K1mRun3mzBO+ovfpXWV0d4D3ZLmKRc7ZoVjis/NHaXg57M0CIY4CVmn7rWzSq94ROZvDyD9s=
X-Received: by 2002:a17:902:f786:b0:295:55f:8ebb with SMTP id
 d9443c01a7336-29f24e9fb9dmr117523255ad.21.1765851508255; Mon, 15 Dec 2025
 18:18:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251129170142.150639-1-viro@zeniv.linux.org.uk> <20251129170142.150639-19-viro@zeniv.linux.org.uk>
In-Reply-To: <20251129170142.150639-19-viro@zeniv.linux.org.uk>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 15 Dec 2025 21:18:16 -0500
X-Gm-Features: AQt7F2qp5TJTQsl_u69giqHIzesppxwKZN0S7rImDG0A9kbJZcYWwHrgoa-C3BU
Message-ID: <CAHC9VhQ4Mh=UYYFw83RYEG6VfcNpx9QSXdQbBgY0WG0Rb7a_9Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 18/18] struct filename ->refcnt doesn't need to be atomic
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, mjguzik@gmail.com, axboe@kernel.dk, 
	audit@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 29, 2025 at 12:01=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
>
> ... or visible outside of audit, really.  Note that references
> held in delayed_filename always have refcount 1, and from the
> moment of complete_getname() or equivalent point in getname...()
> there won't be any references to struct filename instance left
> in places visible to other threads.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/namei.c         | 10 +++++-----
>  include/linux/fs.h |  8 +-------
>  kernel/auditsc.c   |  6 ++++++
>  3 files changed, 12 insertions(+), 12 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com


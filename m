Return-Path: <linux-fsdevel+bounces-58362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F72B2D453
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 08:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10EF73BF1A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 06:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BC72D12F1;
	Wed, 20 Aug 2025 06:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ZVRWyZM+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6702C11DB
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Aug 2025 06:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755672770; cv=none; b=U2DGclxHiz62RE1+w53NLqqKLwkOfi+5SYCiBXkTx9bMAGlTHdXQuQhRBvbZIAVGk3xuWXIqliLZ2Q6+3TH01yG9GN00CY2kWmrE20UMVYBMfZro1lJGyC9cZCCLE3zw1f0S2CSivYhg3vP4o3UN+XnsTZfFK2Nex6EXLcgJMKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755672770; c=relaxed/simple;
	bh=8KpNSuplwGzUxo+pl/kaST7GJG3ijoRwu/q/QBQCOQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LO8u9UwQbogG+ET7ABT2t8R2v4CP6NzmK6g93SalRfFm0KCu2dHXQPxaLvGcLE6tJCQ5tCWp16CDDFFOaooKeZs+fyIjhyECcTjVlyGpEXanRXDG7GoUrhRqex3s7X0h7/4Mk7FQ8VXjWL4htNh/sPGWwe5Kh0ErtiNWUPb86T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ZVRWyZM+; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b10957f506so9194471cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 23:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1755672768; x=1756277568; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=50jwrZQGjSslyTyuIwE+ZuameHGuXlZuSBPYcNv7KGE=;
        b=ZVRWyZM+Bu0wsEu0yNCXSetYI+iD1L2DQAO0g2CrR+UQrKK/Y3iQnDtBMvLlPu3AKM
         6yCcontr7PhcI6qbkfRLciQtaBFBp4xy2mISvv5zJHH7qsAyBGf3tuf8ZIkTuc+twaRa
         JTHRpDfpLrij0ap5ioA1LZbxA+vnwXcCrWPsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755672768; x=1756277568;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=50jwrZQGjSslyTyuIwE+ZuameHGuXlZuSBPYcNv7KGE=;
        b=MkMbi5AIugpzHegC2XElOWlco1hY5DzzGJELqXP0DDoyOLFVuh3D2Pb9Q34TzjyYdV
         OqWztCInN5byFtzxQnxnN+KOTMaULdM8DWuEAE66dKl4PfJ2Qqr+JjssM9M8ubnQLZuM
         2oll6zxfOvjd6clLFjc/OUX+UuLf2lnXeyrVVxOoJJN4f73m+OsudnyK1k/5qNW6g/sW
         KlkV3t1pD8ln2Rs7OXGP7bYwq2CoFrLvxypJTUiDr0AcN8DzlbasbExzkG4UC8GIvuc3
         lRJvp+PhJLjorkn61pGloHWYeOaQllMFH91Ve4AaqQYrdMrQwIJM9/5QvU2+IOlkyEgr
         7MqA==
X-Forwarded-Encrypted: i=1; AJvYcCWaMtlEjOrcwv4kI3lTzO1sJPQOys3rrLJ7F9OYbE9sDihCjfBueqWZk0M4jCYicACPx2pyIg46SUMSKoWr@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ISnVJI6T9hfXwI+JmD1ZWXzv8CcLK29iHtPDvEwTCQBvJZ06
	CgeW95jB7U24xzFh4Us0oCZ+LLC1nmhl6IbyimBf1c6vUCDo0T/8lzLKvyhCEF758gx4KKQVlUV
	Tm6C84q6dGJmvAu/ohv4+jEIy9K99uOy4ZkoRBNS2mv/5dLfY1DIYx74=
X-Gm-Gg: ASbGncv8Lrh0/y0fwagSNqj7CpWRuj0zvN514SXknMeF1qVvGpnK/IsXUa24WuHi0aO
	Dm6Ua5N4LuFnYzBofCuUWKeycnuYV3UeLEI2S0oyv7RiF0yC7tNaPxKWFwHbU8g4hJgsEVQ7hsF
	UCGS7+DyqAtXpdqhaO27CI9FYw9vHPz7qRj5UTz+8Ai/HuOici6Fl6D4iQFXFY0r+TFPovDi//m
	Rwf+KZFGQ==
X-Google-Smtp-Source: AGHT+IHMMLFegyAHtkHM39XKsIT7CwuHtFQVVR0IPD+S1rOAm1yFvIpYjEgCtH8dZpenVWW8VUPUG0GfQjanDxMFd38=
X-Received: by 2002:a05:622a:146:b0:4b0:769e:42e8 with SMTP id
 d75a77b69052e-4b291245817mr17863531cf.29.1755672767783; Tue, 19 Aug 2025
 23:52:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegsz3fScMWh4BVuzax1ovVN5qEm1yr8g=XEU0DnsHbXCvQ@mail.gmail.com>
 <20250820021143.1069-1-luochunsheng@ustc.edu> <20250820052043.GJ7942@frogsfrogsfrogs>
In-Reply-To: <20250820052043.GJ7942@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 20 Aug 2025 08:52:35 +0200
X-Gm-Features: Ac12FXw2UXnjG3CcysEUnSzytZykEIInMtM4kPoHI69C9Q7SHuaQEOwDwiyPNBY
Message-ID: <CAJfpegtXUekKPaCxEG29SWAK0CTz-fdGvH=_1G5rcK9=eHt6wQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: clarify extending writes handling
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Chunsheng Luo <luochunsheng@ustc.edu>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Aug 2025 at 07:20, Darrick J. Wong <djwong@kernel.org> wrote:

> I don't understand the current behavior at all -- why do the callers of
> fuse_writeback_range pass an @end parameter when it ignores @end in
> favor of LLONG_MAX?  And why is it necessary to flush to EOF at all?
> fallocate and copy_file_range both take i_rwsem, so what could they be
> racing with?  Or am I missing something here?

commit 59bda8ecee2f ("fuse: flush extending writes")

The issue AFAICS is that if writes beyond the range end are not
flushed, then EOF on backing file could be below range end (if pending
writes create a hole), hence copy_file_range() will stop copying at
the start of that hole.

So this patch is incorrect, since not flushing copy_file_range input
file could result in a short copy.

Thanks,
Miklos


Return-Path: <linux-fsdevel+bounces-72616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCE8CFDDD2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 14:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 539AD30A7D9E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 13:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E453831B123;
	Wed,  7 Jan 2026 13:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E21x906k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4B131A552
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 13:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767791157; cv=none; b=DHX5642jBvxu/X0s4RpjU8ZEPNiT+z/IKODdkudtctvc13bSThrdCPk4zQDmE0HzG2a1hNNSHhuoGL2W2ebPz71mvHcT0ZQ4yLePA8zi+npzwOWHI39OWQVPQXUehZTDPoI8XI6pC/o7qtUUtrZemQ6ZyLpyGvuEPm2XIwuExnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767791157; c=relaxed/simple;
	bh=qzNG7uqiHdzI8ewoggig0HskK8lGgAMbdXIS/XZZpZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jvuyXcvOmTEBwjaaLCo3zsERBfvvWBfGh7Gwo8z0ZLzduz54PSnGZ2B6bk2e9lDEYcYkGldbgkNrIPVL+fUaKD3/tCgzNpItUNc2bfVHOrP8u8IiFczo+ccFfU6qJzXQ77h4luQzdNt48ToPJ9v5tmxHOjToZVxqPmQBpBnUPmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E21x906k; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5ecb1d9ac1dso495355137.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jan 2026 05:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767791154; x=1768395954; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qzNG7uqiHdzI8ewoggig0HskK8lGgAMbdXIS/XZZpZs=;
        b=E21x906kuGsNhZ1wa36jAIlR7OUU/a9MFGAvKJbXbC/Axd5IVZKcYh7noOIcP3T4jv
         cYhAI5SjzwtqmxgwAphwUQL+BK5rMQ90hBa0+SzE6EF0tMhl1TVb6XaRccgCCCl1S/jX
         uSYgAcbgeNAu5BysKvHyXY+5wRLUBSx5dTMNvitzmL7w5Mk18QTAMa65f7A5sioZq0H3
         HDZvm2MDpTvgsg6EZLrzrcbBTNO1jtbhDMoJCE9XXpmgSwFK3LdHYk1QJXHPStNCnuqv
         Mu8PDMoixIwANSbLiULnhOf8VbDZ39gBuIh5r2rgiujAG0Mi9WmYKwZOBHYIKqI81bAq
         WIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767791154; x=1768395954;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzNG7uqiHdzI8ewoggig0HskK8lGgAMbdXIS/XZZpZs=;
        b=BOwSXtlmvKZP0FSaIv13dOOJT3zLbjd8dnpDT8VTsUa7g+66aJ7YCZee6vEyRb0NOX
         O6t3ZgzL3CDXzljXI15Rnic4Xl2a3tXgRO+2zEjrWyrYbrO0O0HIau5V27yHZbCkXiPR
         0cxesxqGWzGR92BY41vfo4LX+az0mufrptcXn8hW9eI8aoymB7GodIkl3VlbMIKF9KCw
         z72r59hUVFPR0xamTJuq1h0djUtsaO13LO4WiY0fJDyrqPfTbW2sS204V0+eFvSl3QBw
         YYJvs7YLLFWXK+bVFBBYwtuZ+A5sHDK84FFEXbo/T7MuHAfoesq8EJGAZIBEguRwXdvG
         qw7A==
X-Forwarded-Encrypted: i=1; AJvYcCUqTEaS9oRBZnUZISDA5Boib4WSpCO83y08xTa8sJCj5BDU4lyKFZkQjbJCgeV4OSV9zc6GD5NWhkzIPBSS@vger.kernel.org
X-Gm-Message-State: AOJu0YxAmCiNgFnP1Q9agL2zHVwYZ3Jg35m1dnt6B/VIUE5MtfCutj3J
	Z/vP/oGEYkAcWowR1liDQLt4st+uEm3xeN7UJXT/b7qHJMfpHfeBqSij7eBlO/Ivn/gsrtsZezA
	krwpp3lAu34FMArqAar+fCKC/KzRL7G4KSYxd3Tg=
X-Gm-Gg: AY/fxX7IUsheT/octWLj8OOx7CtUApTrr7tRVMFiN7HwcEjIGTpFpmURs699wog7b84
	qIBzJFRuWQ/95jWpJg7AvFESLS9b22mY1+3tg/CNLR6qsk9eppCmHzpA2QQT+p2XjIF/M2cr9j/
	5tcxbshzCSrX2R8jpnK3arOw7aDCvnakShJMBqAjaWG1EsfmWqUwxo5njapHdhfcoHzUeWol+uT
	F7yfOc0dPrvWcAZPcDrslwu467GyeswPf+To3j2JgCF1yVthEI1UvE6sCbnOkAbiTdkmDdVAjOw
	/kmizIBfYEibO2gR5y19ywhXRy1X
X-Google-Smtp-Source: AGHT+IFnNlNo6WDhAIrQsE84p6Xjc9YulduAvY+W3lIyNrnjsdyAHz3l5KS7q1vQazIQ+gufafyHW/niyaYPbQ4u/j8=
X-Received: by 2002:a05:6102:3710:b0:5db:f5d1:5799 with SMTP id
 ada2fe7eead31-5ecb69056c8mr956926137.33.1767791153625; Wed, 07 Jan 2026
 05:05:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251224115312.27036-1-vitalifster@gmail.com> <cc83c3fa-1bee-48b0-bfda-3a807c0b46bd@oracle.com>
 <CAPqjcqqEAb9cUTU3QrmgZ7J-wc_b7Ai_8fi17q5OQAyRZ8RfwQ@mail.gmail.com>
 <492a0427-2b84-47aa-b70c-a4355a7566f2@oracle.com> <CAPqjcqpPQMhTOd3hHTsZxKuLwZB-QJdHqOyac2vyZ+AeDYWC6g@mail.gmail.com>
 <6cd50989-2cae-4535-9581-63b6a297d183@oracle.com> <CAPqjcqo=A45mK01h+o3avOUaSSSX6g_y3FfvCFLRoO7YEwUddw@mail.gmail.com>
 <58a89dc4-1bc9-4b38-a8cc-d0097ee74b29@oracle.com> <CAPqjcqq+DFc4TwAPDZodZ61b5pRrt4i+moy3K1dkzGhH9r-2Rw@mail.gmail.com>
 <704e5d2a-1b37-43c5-8ad6-bda47a4e7fc6@oracle.com>
In-Reply-To: <704e5d2a-1b37-43c5-8ad6-bda47a4e7fc6@oracle.com>
From: Vitaliy Filippov <vitalifster@gmail.com>
Date: Wed, 7 Jan 2026 16:05:42 +0300
X-Gm-Features: AQt7F2oYpr1KySfJY9yrBJPS500_11WcpTTT3dSzcpl_rsbFoDQJth87qlW7Iwo
Message-ID: <CAPqjcqqhFWz0eNGJRW-_PoJhdM7f-yxr=pWN2_AfGSP=-VpyMg@mail.gmail.com>
Subject: Re: [PATCH] fs: remove power of 2 and length boundary atomic write restrictions
To: John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> What is the actual usecase you are trying to solve? You mentioned "avoid
> journaling", which does not explain what you want to achieve.
>
> You could arrange your data so that it suits the rules.

I can't. My usecase is a distributed ceph-like SDS based on atomic
writes. Writes on a virtual block device have arbitrary length &
offset of course, nothing like 2^N, like on a regular block device.
Atomicity is implemented through journaling (double-write) on disks
without hardware atomic write support.

Then I found the new atomic write feature and SSDs with support for it
and implemented a new storage layer which can take advantage of it. My
new storage layer has write amplification about ~1.0 with atomic
writes (i.e. almost zero overhead). It's a huge improvement for me -
the old storage layer has WA from 3 to 4.

And everything was fine until I finally deployed it with enabled
RWF_ATOMIC (production setups should use safety features) and stumbled
upon the 2^N restriction... It was a big surprise, I never thought
that such a limitation could exist. It's absolutely irrational - the
device doesn't have that limitation and I'm just using the raw device.

It's normal and expected in the context of simple file systems like
ext4 and xfs. But for the raw device... I only discovered it after
several days of investigation with bpftrace and after reading the
kernel code. It's really unexpected. I think anyone expects the raw
NVMe disk to have the same requirements as it's described in the NVMe
spec.

> The atomic write API is based on:
> a. doing statx to find atomic write min and max limits.
> b. issuing a write with RWF_ATOMIC means that the write should be
> naturally aligned and fit within the size limits.
>
> That is the same for both raw block devices and regular FS files. And
> any atomic write boundary is not part of the API.

For raw block devices, you also have sysfs. You can look there and
determine actual restrictions. In fact I didn't even know about the
statx API when I was implementing atomic writes, and I don't use it.

And speaking of that API, why does it have to be like this? Currently
it looks like an API designed around existing internal restrictions of
the implementation - of two implementations more exactly: ext4 and
xfs, both of which are classic non-cow file systems. I suspect that if
it was primarily designed after zfs & btrfs then chances are the
restriction wouldn't exist.

Ok, it's already designed like this, but anyway, if the user is fine
with statx and with the 2^N restriction, then removing the restriction
for block devices also doesn't break anything for him. He'll send his
2^N aligned writes just like before. It's fine for databases like
mysql & postgresql because they always overwrite a whole fixed-size
page. But even speaking of databases, it's not guaranteed that **all**
databases will always have the same layout and that arbitrary atomic
write offsets will never be useful for them.

So again, can we please remove the restriction for raw block devices?
I can re-submit the patch :-)


Return-Path: <linux-fsdevel+bounces-38286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FABE9FEC8C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2024 04:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BE4F1882E96
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2024 03:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E9B13D52B;
	Tue, 31 Dec 2024 03:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MrKwzEXA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CFA2F2D
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Dec 2024 03:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735616176; cv=none; b=ujQbLfwGlQXjxK2iWiZANZaVRCso8W+lSChJu5T74lb11XZBMO55x4zJThDygHnEkwVFaWRAbfbcikGOQIKi342UOsfnCuPRCDBJFBSmdS1v5EyalQO55Z7dah6Lla0kZlUlzwUouPaEPil7nd2CWLbiYR4oEkD/YrjmLTMFWXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735616176; c=relaxed/simple;
	bh=PBwKw/68EmrjBHb+YWO5a0ihhlwpVK+ltktmPbkL4FY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i03LIKQ7Os8vjIUUBr8DA98JTlkZ8Tvm5/543aK55mKoNa8UGXYCYKixj8nEPefo1C5+E5UeDBQL4M5Ut9mdN14jfDjUoIx2ZF82yycMB2o0Y56JgZaFKRMUYUheIPhGzqDL5ySBero3pH+LrVm+w26LLxk8+HkHzjHITpbt7jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MrKwzEXA; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5162571e761so3025655e0c.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Dec 2024 19:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735616173; x=1736220973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81RGZnEJG5AVAVemyUVhgP1B19id/VoU1FVc4FqwyDA=;
        b=MrKwzEXAUpCzW0voy6ik0neoe5STdY9qHoUws9VunydroYw7Y5fOwuIq5u1Fe5MAnT
         /R6aL83Xl59+ahaYF1ECPViD9Y2/7iomZEb4NBzqDut+cWVu67q6wYkVO2O3KN68Aame
         5ZL+cxNBK+7FcfxzZV4lTJF9bkIVgOc5LLGDF0DreiTkve4bRKV1zOG4gtwUN++1JY9H
         D93pr4fxboL950R2L7JyQBc2zigATiTkDDyrhhFZK/hPOIdFEpmxaegSmOJiVvd+3vmG
         pIJaK9kfcfR3t9MeWYy9nTqADTnimqiwXVCL/MAnqsIqB1G2grKQmaD+SGc1LGrPTbJZ
         9CZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735616173; x=1736220973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81RGZnEJG5AVAVemyUVhgP1B19id/VoU1FVc4FqwyDA=;
        b=SSxSztug3dM+SJYmU24SsBPfxxtOb2rXlvb/LnENpJyqF5tMvZlNGe1jPLMiOoat10
         py4XBh08X9JPaGb7Ls5dWc1QJ9elrF2w0vJc46TO+xRHTw9YeV9zsqgsmozv1uZ5pKyf
         kbxnAiQc/E6cgjAT0uF/jzbbIXtc/TmxIfPMvAh3obOf5k3ze01RQLw9ZuHzPWhxqu4x
         sQ+LWkJpO3VwfWF9tHKXq90u3tjBHPhwSlXtSQzUxYUw+2Fgj/dApndw8Y2TIs6fB0QR
         5HeG6kdmX71ulrh2kHhEk+y0T9T1q4QDPvcLJNQBUB1p0Zzb8n+30DCcwvTKeglgOCV5
         p4Rg==
X-Gm-Message-State: AOJu0Yw4q3NYupe79c9s8P7fzb/NZ36CpxKOYS5Mxgh8RFgL9PvIpEEq
	S68EQtw+/eePWCLMW7EZWM4WmUDJhJyz3x0clcdBnpoxmRDl3dMiINKD3yoGT/eAujcgzaFas6b
	sTj+4X+kCaIzvt6nngTim1LYAe00waFMRcN1b
X-Gm-Gg: ASbGncv3Mtugv8pYTWdfkjp8UcuRXiLiKjjpaFcUvd5WLiUnMs5soTAderd56kDSyjO
	+tEtNyGfGeJXARxqeHzZKi8RSWW4v0tBCfqsJuSljSK5GBr/dYVKNPqxVbIyS9SEl7DxRPOLR
X-Google-Smtp-Source: AGHT+IGL9kfI3NDCwxZCKRpDe4JBQGrvgaInmhiiCH/OcAK/NiQZLY0ZXYs9ZdpI4+Z1EMMWYTtcVUYMES6ILwlej8s=
X-Received: by 2002:a05:6102:548d:b0:4b2:5ce4:2b4f with SMTP id
 ada2fe7eead31-4b2cc320d9bmr25660070137.2.1735616172705; Mon, 30 Dec 2024
 19:36:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEW=TRr7CYb4LtsvQPLj-zx5Y+EYBmGfM24SuzwyDoGVNoKm7w@mail.gmail.com>
 <3d7e9844-6f6e-493a-a93a-4d2407378395@bsbernd.com>
In-Reply-To: <3d7e9844-6f6e-493a-a93a-4d2407378395@bsbernd.com>
From: Prince Kumar <princer@google.com>
Date: Tue, 31 Dec 2024 09:06:01 +0530
X-Gm-Features: AbW1kvYAkHHZnq6eJq8M9QqwnVmuUR3NZcHJ2tgcflZOC07WuTSObtVKXLVvWg4
Message-ID: <CAEW=TRriHeY3TG-tep29ZnkRjU8Nfr5SHmuUmoc0oWRRy8fq3A@mail.gmail.com>
Subject: Re: Fuse: directory cache eviction stopped working in the linux 6.9.X
 and onwards
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org, Charith Chowdary <charithc@google.com>, 
	Mayuresh Pise <mpise@google.com>, Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Bernd for looking into this!

I think 6.9 added passthrough support. Are you using that?
> Not yet, but we have plans to try this out.

FOPEN_CACHE_DIR is default when there is no fuse-server open method
defined - does your implementation have an open/dir_open?
> Yes, here is the implementation in GCSFuse (internally uses jacobsa/fuse =
library) - https://github.com/GoogleCloudPlatform/gcsfuse/blob/b0ca9c5b2c0a=
35aeb8a48fe7a36120d7b33216aa/internal/fs/fs.go#L2328
Here, op.CacheDir maps to FOPEN_CACHE_DIR and op.KeepCache maps to
FOPEN_KEEP_CACHE.

I think the only user of FOPEN_CACHE_DIR is in fs/fuse/readdir.c and
that always checks if it is set - either the flag gets set or does not
come into role at all, because passthrough is used?
> Being honest, I don't have much idea of linux source code. As a user, to =
me the FOPEN_CACHE_DIR flag is working as expected.
The problem is with the FOPEN_KEEP_CACHE flags, setting this should
evict the dir cache, but it's not happening for linux 6.9.x and above.
Although I see  a line in fs/fuse/dir.c
(https://github.com/torvalds/linux/blob/ccb98ccef0e543c2bd4ef1a72270461957f=
3d8d0/fs/fuse/dir.c#L718)
which invalidates the inode pages if FOPEN_KEEP_CACHE is not set.

So my ultimate question would be:
(1) Do you see such recent changes in fs/fuse which explains the above
regression?
(2) If the changes are intentional, what should be the right way for
fuse-server to evict the dir-cache (other than auto eviction due to
change in dir-content, e.g., addition of new file inside a dir)?

Thanks,
Prince Kumar.


On Tue, Dec 31, 2024 at 5:11=E2=80=AFAM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
>
>
> On 12/30/24 05:41, Prince Kumar wrote:
> > Hello Team,
> >
> > I see a regression in the fuse-filesystem for the linux version 6.9.X
> > and onwards, where the FOPEN_KEEP_CACHE flag is not working as
> > intended. Just for background, I referred to this linux commit
> > (https://github.com/torvalds/linux/commit/6433b8998a21dc597002731c4ceb4=
144e856edc4)
> > to implement directory listing cache in jacobsa/fuse
> > (https://github.com/jacobsa/fuse/pull/162).
> >
> > Ideally, the kernel directory cache should be evicted if the
> > user-daemon doesn't set FOPEN_KEEP_CACHE bit as part of the OpenDir
> > response, but it's not getting evicted in the linux version 6.9.X and
> > onwards.
> >
> > Could you please help me in resolving this?
>
> I think 6.9 added passthrough support. Are you using that? Also,
> FOPEN_CACHE_DIR is default when there is no fuse-server open method
> defined - does your implementation have an open/dir_open?
>
> I think the only user of FOPEN_CACHE_DIR is in fs/fuse/readdir.c and
> that always checks if it is set - either the flag gets set or does not
> come into role at all, because passthrough is used?
>
>
> Thanks,
> Bernd


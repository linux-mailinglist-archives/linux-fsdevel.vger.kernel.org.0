Return-Path: <linux-fsdevel+bounces-49105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5522AB8132
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 10:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A93303B5670
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 08:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00AF276028;
	Thu, 15 May 2025 08:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="GHENDISz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8487A1ADFFE
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 08:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747298565; cv=none; b=i5wEOfEUX9Hdp3PVrjbclBoBHGLA8k3SXBuCaSwdwQDQnIRrqNLOjdEreWTUucm7eVuulFPG59RWHqtUhqntneBgYWzVvP3aTEzZ7Q0ModbX3PzQMscIG4aQof2xh2SeMv3aZ0GPtRjo6yVMmBED6vLUvcWxASYao9lG9rC84F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747298565; c=relaxed/simple;
	bh=lIl3TAR05UN95mf6gnY4qgpstbycN/VCJtwc0W4I5fE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cKFd0d3ZaDr7rCDzj6JPi0/89DX9tsZQYSWAK2R/m2//NPaIi2EcXoaiAh7R5QNtsQLPmu+/042+2sEpT4WM0PL2Jv9DDElyJzUxXLYQENWM5/RHKZiFfJvqtJNxd/GzhuNp255doQlK6sYVnzZp88FcFjyBkbAdsQii2Zd5q3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=GHENDISz; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4947635914aso7616371cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 01:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1747298561; x=1747903361; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lIl3TAR05UN95mf6gnY4qgpstbycN/VCJtwc0W4I5fE=;
        b=GHENDISzI6k/zKZkx+F42taPepCgceoe0Ud3Abjrp3pAuKuW5/kDLf0FmEM2YNSz4q
         +Ciq8DgZKceDhXxTwefMNUNLsMiyX6+4+uvhBqL3FWQaX8GPDD9qbvqiJGq2XpJqxaKi
         tiF+6jDqIxhTytDUF7gaBPlkCkLoJusrX3ZqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747298561; x=1747903361;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lIl3TAR05UN95mf6gnY4qgpstbycN/VCJtwc0W4I5fE=;
        b=HBp1s/TeGroNQqm0V5rFKvjwWTgmUGVFjfuNbsQ09YVam7/xnrP+nR7WPWjNXPenkI
         UOrU9W+vumJbzW4yFTpAuHtVqV7KG54xPpCbfK5FzFUIesU7XyaIqe18+8ffamNQpz0S
         hJf8Mlsncphc8p+Tjhh/j3+J80LSlnnYyH34FkITtqS031fjQITPN5xYsvLDYtfel8RD
         fBwrvPgLf4W/2Q2Sek/87GXtb7sDsFILPyUJNjzxR2GolbG0xSg3DXvhuUwFLWRO0C6W
         u3Jkt1QiBxpx2qEI+N9VhLyNeIORGGsgKRlLPGVVwrtQEsfAmWP3lAMHK/+YJ8YGdehO
         F+wQ==
X-Gm-Message-State: AOJu0YxyV1FkvduZYYazHSAsQ/874p/vo2wF6/9rQeVHGSjyCv/RCzUy
	uIyMrp7AiSsMHtaI+O7jTpBsy+J0peLy/D5eQUixSNTqBhD7ucV6Bn6apHepnPebIrDp/nUcCz7
	YCXKgV0kiqAys9LKLeLUqVnx4wo4x+KRpKqLje2DjXLd0LqRj
X-Gm-Gg: ASbGnctkIK62CE04uyw+ZCn4SzwUtBZloLxkXb+CEUej8VZ61Mx0HM0Sr67kksU0KF3
	F0F/+QBDyUr9Yf2RMUvuFxZhJTpdkk7N2EuGu1Ds9mNVKQ+KdHDY27zw3NtVHapgmsihhTMtgI1
	e94LxX9WCtzynDS3PjOXXZ/KNc8A1XgSE=
X-Google-Smtp-Source: AGHT+IEU7KPoYSGIgMPmDvvf+X5o1Uyi107954s5eKk8yyisW9J/HTgOd0hzWQX8jTwVJdmbrVtrne/AiM6N4sbPmOQ=
X-Received: by 2002:a05:622a:1c0d:b0:48e:1f6c:227b with SMTP id
 d75a77b69052e-49495cdb74emr98076581cf.26.1747298561391; Thu, 15 May 2025
 01:42:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegtdy7BYUpt795vGKFDHfRpyPVhqrL=gbQzauTvNawrZyw@mail.gmail.com>
 <20250514121415.2116216-1-allison.karlitskaya@redhat.com>
In-Reply-To: <20250514121415.2116216-1-allison.karlitskaya@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 15 May 2025 10:42:30 +0200
X-Gm-Features: AX0GCFu1PzjJ_L0ozzKHhTV5H9lCd-y4v7HQ27H_tcjIncSseH_FsIQ3PIqSmUA
Message-ID: <CAJfpegtS3HLCOywFYuJ7HLPVKaSu7i6pQv-GhKQ=PK3JAiz+JQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: add max_stack_depth to fuse_init_in
To: Allison Karlitskaya <allison.karlitskaya@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, lis@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 May 2025 at 14:14, Allison Karlitskaya
<allison.karlitskaya@redhat.com> wrote:
> Use one of the unused fields in fuse_init_in to add a max_stack_depth
> uint32_t (matching the max_stack_depth uint32_t in fuse_init_out).

This is not a fuse-only thing.

What about making it a read-only sysctl attribute? E.g.
/proc/sys/fs/max-stack-depth.

Thanks,
Miklos


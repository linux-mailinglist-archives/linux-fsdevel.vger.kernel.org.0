Return-Path: <linux-fsdevel+bounces-48298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4179DAACF58
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 23:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C841983CB9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 21:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A2319006B;
	Tue,  6 May 2025 21:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K97v1piy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AE4194A60;
	Tue,  6 May 2025 21:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746565701; cv=none; b=Jf/rRiWc7w+4ihj7wGtejhnBnR9+fFGNI4ZsVSe3sjAMH02vfnBj6AE5+6eVfOKq4PkAkbg6ENpjn88B5aHG6pe9j1GOB2XGkGC+ls1ug7LalCvdrG066DxHUd8NxdcOj1qBkCUo1k0mueubQheqM4IkXpaXMLv4NuTSUDSQPmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746565701; c=relaxed/simple;
	bh=kvU0M3Cv572otDuJ6BH+Gsl7s7e0YVi+e6/DEjMHlXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c31AhLHlL9UHcfdwWZJKPMUpq0U8MWzYgolcTMDrg9wSWAPd2ns/LFm0TAazMiH3N82ITVv++YTwK7XvjPo5or6RcDtOPC7zb8e79KlLsoYfnNpYJO26/OXZhvGka86IZlr02MuZoco5JH0Abrbf7YW98/+pm7Ku8SQdT0C80po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K97v1piy; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5fafcdac19aso4536250a12.0;
        Tue, 06 May 2025 14:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746565698; x=1747170498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2t5JRxFE+HQpTdAAeFVzf4Cz4oAsGT6YuCamH2R9TM=;
        b=K97v1piy6XKKi023vpv96KQECGNzyy8Y2QSdix3IrdFxHbss97pZHWl/0eYcvxGK2g
         jo8B0wMWA9TfEAKeDQGCPCKG/cRPFcqI0UZG6JKgz+V+zGq2+2TFf7PFAVtnA4c2Gd9t
         wCW3476odmDxhb1os+YWwNJP0mCevbPoO/elK914R100XKx6etypC084HW9Q2qjSdicR
         2I2VzehZZ7zhlJ0n5TBiUOGDL4aSsB5COngNv1K6YWMCG98L7jfWYoxzkDtmH4I9tdRC
         F+tvDXYL+RLRY4nV0QJZndJQ96QgDm1o7cbiiYx8nmifwys3gXXNk3m9kNB7lXUkv1OE
         2jjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746565698; x=1747170498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X2t5JRxFE+HQpTdAAeFVzf4Cz4oAsGT6YuCamH2R9TM=;
        b=Y87nlSvp0sVYFXMredt+ZbLiWGpBDXEMK5Ll1oApZ35dxHvh++W1/qLdtHBz6z/21i
         TmFvYg3lzIRREqlwxXLUebigdVACAD4NeTjlt448jMX5jAOMB3GR2k7TZ937Ls8xc11s
         82SJ9c+8fvk0b9OPK1kS8OLnnFqAsTcbvQSiT2mrE+KxloiWaEwPpssovR/WO68WcTey
         86mg7HjL7+8Sp2tYGUw/go2Dp0KlxULlG7wjlxV1AFuZTaMcWydUwe9jV7Fvkdb7dPnP
         RDAdsKbomEVrioXb4DCqzjl7AtQoOIUZok091AHGLIxxwkQoZX/BPNPOSZdEYhDTglXX
         33yw==
X-Forwarded-Encrypted: i=1; AJvYcCWXuAFSPjGwUxtgBOalPWHfsZYU8PAkVpfd5OcssQ+srkDHIWQ2Uu/6ufGOpWroFicpw8F/pZhup8SzBqphtA==@vger.kernel.org, AJvYcCXQQrYR2Y94og5v9+S2Fx/HzV8vBPyqTIUktFu2bTv0ty+aLIJHrld9NEIh4TyzkU4snV1VnEMa@vger.kernel.org
X-Gm-Message-State: AOJu0YwExzp0Ej5TeMa8mExzB+pYDxfuLN9TT4WNlNv09DXzZ3bON+WQ
	vnf2vJ1dIuuwk4Y3u16nn4+kI4iQkok6rv0t07wQVVIdm1HHazsoTp3CQHETIlrORNaNGZIZrCn
	W7AZZGPd3+vlgczkBQUEOKqs+o/o=
X-Gm-Gg: ASbGnctJLfUdcInBDdBxQqHDZIU+tXykNGBHJUdyO1eUiLDvKpEnGdWuYMdexVgEjYL
	NdTd3kG4sps4bnqLhryGdISJj2vrpoaLVkn0FseIVonYwSjtDV/I4itRlMJRAyG3PTKax7tf81f
	Cx/+84f3fOZAaL3ACiFHfV4Q==
X-Google-Smtp-Source: AGHT+IH9cDxb2sjnz/NCYfRkYAsRXJ1XuhBSw5BLmZmVO9GNO+nxVkdEUk0dplAzfjPlkXnx4JRFuPO+iEERSp3fYug=
X-Received: by 2002:a17:907:60cc:b0:ace:3ede:9d22 with SMTP id
 a640c23a62f3a-ad1e8c8fb2cmr91705566b.27.1746565697733; Tue, 06 May 2025
 14:08:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409115220.1911467-1-amir73il@gmail.com>
In-Reply-To: <20250409115220.1911467-1-amir73il@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 6 May 2025 23:08:04 +0200
X-Gm-Features: ATxdqUFNrsJ5wJ6mE5vEWGHggA_jj-u7slc8hb2fSOGUUbnNescwuKrmVaf51Qc
Message-ID: <CAOQ4uxgG_TfXW9p37oZ-SCYkjXcQ1LaRXFVr=p=btwUTqkoc6A@mail.gmail.com>
Subject: Re: [PATCH 0/2] Tests for AT_HANDLE_CONNECTABLE
To: Zorro Lang <zlang@redhat.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, fstests@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 1:52=E2=80=AFPM Amir Goldstein <amir73il@gmail.com> =
wrote:
>
> Hi Zorro,
>
> This is a test for new flag AT_HANDLE_CONNECTABLE from v6.13.
> I've had this test for a while, but apparently I forgot to post it.
> See man page update of this flag here [1].
>

Ping.

Zorro,

Can you take these patches which add one new test?

Thanks,
Amir.

>
> [1] https://lore.kernel.org/linux-fsdevel/20250330163502.1415011-1-amir73=
il@gmail.com/
>
> Amir Goldstein (2):
>   open_by_handle: add support for testing connectable file handles
>   open_by_handle: add a test for connectable file handles
>
>  common/rc             | 16 +++++++--
>  src/open_by_handle.c  | 44 +++++++++++++++++++-----
>  tests/generic/777     | 79 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/777.out | 15 ++++++++
>  4 files changed, 142 insertions(+), 12 deletions(-)
>  create mode 100755 tests/generic/777
>  create mode 100644 tests/generic/777.out
>
> --
> 2.34.1
>


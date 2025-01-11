Return-Path: <linux-fsdevel+bounces-38946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A56C5A0A2D0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jan 2025 11:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B7FF3AA414
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jan 2025 10:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22804191489;
	Sat, 11 Jan 2025 10:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAZlJk+r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73CB24B229;
	Sat, 11 Jan 2025 10:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736591613; cv=none; b=MIjtzEQLNrQIpvpXuTbFRric9pTMSni7NeMtJ2u3HPvmlfgu2ImR79U8yPkJA0il/rUNlmFJu9zrqS8JehuA7OTXEW5kDAI+JDgeYzop4DhMZfo2vrs7EOAYfhlmZVt7msNGNx9cwLT/m5cK10zEvN3udBXIhiTR1ahgqWVcDbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736591613; c=relaxed/simple;
	bh=+44fMNQLZujGybGNU9OLOAvGz6NoUNQ8Y+J6pnI1Jig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fus8SACZq0AsKzZdNBm1WSD+/s7EE4qLGXo8fLtCmAcyrFaH4FzwMlrebh4lbP/nn96bd0XxUwRPvUx896t8OaAuIHJKd8YsfIjISHS2ys2EA2VCZzyvSRe57T2yGYhvoYuXeooybQs7Fd6vx6Y8q3+cNv8IJn3+71BVQO2KXsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAZlJk+r; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d3cf094768so4914161a12.0;
        Sat, 11 Jan 2025 02:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736591609; x=1737196409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W32qY0/4Le8cLL/pnhpEJJYyJqJo4K3dmqNXFMZJ4ws=;
        b=TAZlJk+rtlE5eUq4J3Yy1ShB7IW1OHTWSLh1fSy/pDXZ3jZPyjzXtzWjP+WQ5I1OsL
         3tMrccPItjDnTjhpthn6eslfrLs2+B/HxmiJr0KYyOy8ISJcnRtvlxfYYx1DTMHOBnAP
         61w/WJM3zHhQKpb1+YVmkTRHNPJKAK6e9hICFg7tPWXJ9beuUSork/ZULJF2GwrU30mH
         DkgLWRyZk9iV5Z/uxi3QPDMG+8bqZ4a/VgWSjO0BwNP1VHkJM/DkE4oqucLTqqCZQr1U
         oXIKMPjrq8XCchcgtvnOVvDyMlbwGfb6zV0HxANEiOHVXBoHlJeC3p60qxav4/mYS2UT
         bZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736591609; x=1737196409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W32qY0/4Le8cLL/pnhpEJJYyJqJo4K3dmqNXFMZJ4ws=;
        b=XC6tHBirdUTpUu+fNpnxFH2KqEOzlOItol5lds3kCB3Xw9cxFezMjWTQLrtANanx/B
         m0U9rKwv+nH/nURecO2ECzparESW4ScxEMIuNuFk9NecVc4x5ixw40MdyTvmifYEtFza
         7ZXIc6VEh5kgEt9GcBImCr8+xVW8yojcRFwDh9/rvRxHx0fJcGThJAeQJPwnDEZBGOgn
         FHU9/MLmpbxtzI0Z0r4Ng/OvmNu0KArm0ERj3nHv7AZQwDzYWDx41UQhH7Xi4LqUgAX5
         MGOBmjheiEAOajNs9uMpfl3aKTelt97RE0URywdcvavSG1wsyeIIFvAFlcmXCCcMUZWG
         KU/g==
X-Forwarded-Encrypted: i=1; AJvYcCXjhzE9R+jIkK181jspfO63A2nYxcGND1cHhh2c73klrCXO9VUM7o/FyJcaLKaQ5MlsMgy93S6Ra/a0@vger.kernel.org, AJvYcCXyLrdgjCDeCyjOdE+eopKRz3Z3eVmuDFpkUBVQR3+jlm/ijD+ged/aLoWh9kW+/sGGDM9IZRB8IURTmYGf@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7kd7/hFKZMcIn0I54YqLK/Ter1JYxP5k4Fslzd5AiR2bnI1aU
	1/tsYBT18H/jL/SWGIEi5sHkn8D3m7ay9Y7ki05lm5VfiVOuE3y5vjfN32rDZdSS7VcHUcxV0FK
	ffrFZsvyfR4PBMvA0VpfntKNGpR5BtEk5
X-Gm-Gg: ASbGnctfXXZok4JHZDzoNCEG8nwIkFO4N5pdeUwfRCrgrDIY6LBROnr+btUQtBtgAwW
	k7DYDrv4SKMzRbrS/SpBRB7t1YUPmeFAfkLFWTw==
X-Google-Smtp-Source: AGHT+IEwHZwI+zAl6oBIMKOgDfa5fIg4UVWhCs0XRjRBTFyJvCP2F/JhoKYw5tU9GM6FfUwIac5IXyEC+ZcjMvE3ZfU=
X-Received: by 2002:a05:6402:26d2:b0:5d2:73b0:81ef with SMTP id
 4fb4d7f45d1cf-5d972e4cc04mr12407698a12.22.1736591609243; Sat, 11 Jan 2025
 02:33:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ba4f3df5-027b-405e-8e6e-a3630f7eef93@gmx.com>
In-Reply-To: <ba4f3df5-027b-405e-8e6e-a3630f7eef93@gmx.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 11 Jan 2025 11:33:18 +0100
X-Gm-Features: AbW1kvaw0h6MkSPJbyD4xISUkZtRHC50WlhlvMXvjMcF31YArRsD-KoZTnPTARY
Message-ID: <CAOQ4uxieqyB9oVAoEL+CG-J-LsWVN0GEke+J=pTad4+D+OrBxA@mail.gmail.com>
Subject: Re: Spooling large metadata updates / Proposal for a new API/feature
 in the Linux Kernel (VFS/Filesystems):
To: "Artem S. Tashkinov" <aros@gmx.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-xfs <linux-xfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 11, 2025 at 10:18=E2=80=AFAM Artem S. Tashkinov <aros@gmx.com> =
wrote:
>
> Hello,
>
> I had this idea on 2021-11-07, then I thought it was wrong/stupid, now
> I've asked AI and it said it was actually not bad, so I'm bringing it
> forward now:
>
> Imagine the following scenarios:
>
>   * You need to delete tens of thousands of files.
>   * You need to change the permissions, ownership, or security context
> (chmod, chown, chcon) for tens of thousands of files.
>   * You need to update timestamps for tens of thousands of files.
>
> All these operations are currently relatively slow because they are
> executed sequentially, generating significant I/O overhead.
>
> What if these operations could be spooled and performed as a single
> transaction? By bundling metadata updates into one atomic operation,

atomicity is not implied from the use case you described.
IOW, the use case should not care in how many sub-transactions
the changes are executed.

> such tasks could become near-instant or significantly faster. This would
> also reduce the number of writes, leading to less wear and tear on
> storage devices.
>
> Does this idea make sense? If it already exists, or if there=E2=80=99s a =
reason
> it wouldn=E2=80=99t work, please let me know.

Yes it is already how journaled filesystems work, but userspace can only re=
quest
to commit the current transaction (a.k.a fsync), so transactions can
be committed
too frequently or at inefficient manner for the workload (e.g. rm -rf).

There was a big effort IIRC around v6.1 to improve scalability of rm
-rf workload
in xfs which led to a long series of regressions and fixes cycles.

I think that an API for rm -rf is interesting because:
- It is a *very* common use case, which is often very inefficient
- filesystems already have "orphan" lists to deal with deferred work
on deleted inodes

What could be done in principle:
1. Filesystems could opt-in to implement unlink(path, AT_REMOVE_NONEMPTY_DI=
R)
2. This API will fail if the directory has subdirs (i_nlink !=3D 2)
3. If the directory has only files, it can be unlinked and its inode added =
to an
    "orphan" list as a special "batch delete" transaction
4. When executed, the "batch delete" transaction will iterate the
directory entries,
    decrement nlink of inodes, likely adding those inodes to the "orphan" l=
ist
5. rm -rf will iterate DFS, calling unlink(path, AT_REMOVE_NONEMPTY_DIR)
    on leaf directories whose nlink is 2

Among other complications, this API does not take into account permissions =
for
unlinking the child inodes, based on the child inode attributes such
as immutable
flag or LSM security policies.

This could be an interesting as TOPIC for LSFMM.

Thanks,
Amir.


Return-Path: <linux-fsdevel+bounces-48938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CFAAB65E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 10:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5583E4A4DCE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 08:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF1F21D583;
	Wed, 14 May 2025 08:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkSSflM0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B0F21D3F2
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 08:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747211146; cv=none; b=srTG7n54Oim5uhF7PNmU9xG15LBQvK4rcaYTFmiIb2TqFipgwQNrUs4WFllAlKA4VHHegpU7Hi9/0DyEHiJaANz/066a+mLmuc3tux7VXZncEUsxyZnSehc4BENanUGdQrfmX7E77MwGGZXcc5i2dIrFcXqAtTT2LpuoA/jZeIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747211146; c=relaxed/simple;
	bh=B6ft2+z3fX6nHfbfuJxc8bqwetnkH+Bg2Iixw9PEDhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MIJI+GUAoUJDm148XbS3iyHzy9hMBuziEQKr8imriOdJP7Bb5PF2RoWmUbNFk/GMyIo3gSsvpzOpb7eGT8D3/h8CkCjfwYIjYmk0gBpY/r18WNQG8I5ClIPjgWweluWWu5ZcKJqR9NftY1DPRHJMm63m6Ij8N3HYttar5qGQTLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IkSSflM0; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ad1a87d93f7so991178466b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 01:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747211142; x=1747815942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DayHDVZnihIM4i5VzrDocjd2dOFqOwt5zrlQwq21n9g=;
        b=IkSSflM0g1NujUzxJ/ERV/5yftK2qY5bK50k2lY6zsjGIPxM03CLx/phLdDUW8eRWU
         deuwnsFt150EOGJYm6wgM/lwYFe0p5QeMbv5An2kJ3tq0ko3hMsN19+8UC1ueQHoWwYc
         QNswIhB9KbjVKUVZZADwgf1srNShK+h9u3qRpxBpfEB3irE99wE+xCBwQKo2BUmYP/KG
         EAGvMAI7nfehtDYVM2qSap3NGYDmpEOx2R0RChjX6R1papa4B2/T85UO+EG+oqGgY5Y/
         tJASBa5Zlil3iKALRUH/VV5xHWMa3wOJddDJkxnQRtEUOiH6+Zh/FKWzQl8ZoFruDv7g
         BCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747211142; x=1747815942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DayHDVZnihIM4i5VzrDocjd2dOFqOwt5zrlQwq21n9g=;
        b=CMMBITTTMiBZi1WjVncrDeSWn/xJWMvelJb1FM0bYBKXdwdS6h4WxRINuLeX3F+aNv
         iB9uVtSSkGRDUn5LINj+Xi/YZ8vd+MHZFAaFKFTQetJgUZ5u2JdZudq2qUstb55F5Rf8
         npPUSS0pSsWCYoBcjYsf9q4py6W4a+vUd7DIqcryD2KMXc8nPi02/k6wbjVZCh2lmF47
         NuptKjEnPpboet6SdH9ZhTWxsp6K9MaXnmMV4ABiKDNh43fE1Ew/YTxtrGYlqDrTV2+K
         HyrC6i99K9PsyVVTHsthuRypRQ2kYongysaCc1c2gXVVMAi+q9l4A+zNT/VxE5H+X8mF
         DhtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqawWpXkg5l9YrL/36hVB/CRMJCREbvbW/XMnVuCWsiQH68dvT/KqOS0c1QPahDP/GdPZHF2zjwiEiFtn1@vger.kernel.org
X-Gm-Message-State: AOJu0YwtcSEHb6PW8bGlxD0HkDOS4ZORfl+WPYHWYBsD6FHH3nYytyBm
	Cok9ddAsvxzqFvn97sJ9YsGgmXDyeebMRZsZkIXnMpAj7aCfsKBHV64SpWmv1Qr2XzLbFDPh/1g
	uEvpfEFKdd91POAuqIylde5WLwp4=
X-Gm-Gg: ASbGncsUcwKc8ylJznznqFKb8UVX6h30zwr63dI4cRBOfa/DIxQlZsFGGedLtY0EHfb
	nYM8Hda2Wht2NjTA/httBL8hULorK+zolriTp1oSbolmCygQAMqDSzEH9ROV5s3xrorg6DS3Zh2
	1Jipk00MR9fVMn7jz3IUYcilqYODAf2nWV
X-Google-Smtp-Source: AGHT+IHykO1xnVddGlqHB6hThP5vnAugB599BVpLexOB/zwIviKCO6D79TgNWQSc1P9tOLdnD2+xrYwPcxf7pIoBhQM=
X-Received: by 2002:a17:907:c290:b0:ad2:3fa9:7511 with SMTP id
 a640c23a62f3a-ad4f726ee3fmr226682566b.41.1747211142172; Wed, 14 May 2025
 01:25:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509133240.529330-1-amir73il@gmail.com> <20250512-absaugen-stengel-a301f3dfc91c@brauner>
In-Reply-To: <20250512-absaugen-stengel-a301f3dfc91c@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 14 May 2025 10:25:31 +0200
X-Gm-Features: AX0GCFtIPRqdKlkNO4rbTwJLYxLRE_o65Cp0l2CIrfPCjgxWPg0kqzMYMpcIu0s
Message-ID: <CAOQ4uxhxvP6Cd_nNsc6VkCSjUnHVVFMToP2DqA_DwQCPmJ9XWw@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] filesystems selftests cleanups and fanotify test
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 11:40=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Fri, 09 May 2025 15:32:32 +0200, Amir Goldstein wrote:
> > Christian,
> >
> > This adds a test for fanotify mount ns notifications inside userns [1].
> >
> > While working on the test I ended up making lots of cleanups to reduce
> > build dependency on make headers_install.
> >
> > [...]
>
> Applied to the vfs-6.16.selftests branch of the vfs/vfs.git tree.
> Patches in the vfs-6.16.selftests branch should appear in linux-next soon=
.

Forgot to push the branch?

I do not see it in your tree nor in linux-next...

Thanks,
Amir.

>
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs-6.16.selftests
>
> [1/8] selftests/filesystems: move wrapper.h out of overlayfs subdir
>       https://git.kernel.org/vfs/vfs/c/0bd92b9fe538
> [2/8] selftests/fs/statmount: build with tools include dir
>       https://git.kernel.org/vfs/vfs/c/b13fb4ee4647
> [3/8] selftests/pidfd: move syscall definitions into wrappers.h
>       https://git.kernel.org/vfs/vfs/c/ef058fc1e5e9
> [4/8] selftests/mount_settattr: remove duplicate syscall definitions
>       https://git.kernel.org/vfs/vfs/c/ec050f2adf37
> [5/8] selftests/fs/mount-notify: build with tools include dir
>       https://git.kernel.org/vfs/vfs/c/c6d9775c2066
> [6/8] selftests/filesystems: create get_unique_mnt_id() helper
>       https://git.kernel.org/vfs/vfs/c/e897b9b1334b
> [7/8] selftests/filesystems: create setup_userns() helper
>       https://git.kernel.org/vfs/vfs/c/8199e6f7402c
> [8/8] selftests/fs/mount-notify: add a test variant running inside userns
>       https://git.kernel.org/vfs/vfs/c/781091f3f594


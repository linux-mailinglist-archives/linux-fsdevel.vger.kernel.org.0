Return-Path: <linux-fsdevel+bounces-40644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C01A26249
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 19:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 104A67A310C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 18:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D8220E6F3;
	Mon,  3 Feb 2025 18:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erzXPDeW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E163420E31D
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 18:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738607090; cv=none; b=qmNJljNGwu+mlpqiy8DGsMX4nwzxCf3RxaIsrmDTynOD9HYJHsa3WsNssryX21CsrpYgc89khefVOlc8hLvazylVk7Ln5VU8K5NZzO7N0rFwH5Rv+xn55k5LAMzKQDedHgSIKBmF7IxtU3S7BkhUVnX1HNpi4/OynIPTAZurAMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738607090; c=relaxed/simple;
	bh=Oj9xAlNRQQilJxMAaY9UyyM5lCMg9hxSabky37BcQrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NeC7Fb57SM4U/ViXTPRixh0ZpHzlItLGWHI7mm9bP1qZRMagHdjr7e7fxytIVBaOW2KTqJx/FtgN4auIQRl5yLsEJbl3I8TCjs/Jcp6tCXozyTEmDgcBhgQUqXXROeobG7NXA5mP4nGJTXvFMghMYMrDRQSpAlgaEa99xT7/J3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=erzXPDeW; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-46fd4bf03cbso60871171cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Feb 2025 10:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738607088; x=1739211888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jP33lDcHUXQ8D/C521CZgXMrhiNVnblmCkehGJAm3zc=;
        b=erzXPDeWwj5UUvrIqgVEHsoXlbWG8vt0gFAt6LL/g0yjLMHUNG65qQhQkHjzoLBhdp
         Non2EYw2yl4puRGxjUWQWTC0buSW7xUW1O2/tBTyVnpoyxcHQDRrSny27lUhVUQuzTs0
         U+dyQ3ASEmD+5A4W2q3z1zalRSQJcKpimyF966c9LNfBzd92yHNeHnB9sOPMgu0e0qha
         vsj7B75NISry8XKFNw7hsYHdCFvOd4I3WhuSoti6TOBB7dJHuT6cn1V1i/ias9FdkYMj
         cQpwNjjeZu0wx+wAqneq4ydbkAfaBRTgmTEsOfa7f1RLNGj3DjWiZQ6drhHyloXf6Wx+
         mZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738607088; x=1739211888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jP33lDcHUXQ8D/C521CZgXMrhiNVnblmCkehGJAm3zc=;
        b=TsrXLfglBZR3RTjobbAWyP1tU4Y4gu32pNPX4aXcW+lFArt3zfpP6hw4z2CxeRkBNq
         Ac8hHBZM1kmpE52SsCILbbIRcXgbYyQophz8K8qe0vfP/6f8wt2f73GCZPKA7omytS7v
         RxL3oRgfM5TKtmB553OUsnY0/odHxfSKJpV2I8H2/MxRDES81Pa2gvQiWSuaZsuG8xQq
         S1K7AqKE/mrdQpt+TzvIWQf9bQUVOqkk0GSyGqGUNTCXAawsF1v5GmZYyre4Gm2hMcDe
         Y7NRpFnyEna3hVb7t8s9ElllNTmLnp50NnEULOcIYfpG0JowmjSWcjHfN094KYhVlbGC
         MrHA==
X-Forwarded-Encrypted: i=1; AJvYcCWpuZ1CVu6vxeNszS1wB26+N64CXgmhxkULmtLV/Pd15+3G2BSOAMjla3FNA3Rk5pW8Vh50jO0269bDBbRi@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg9/KyHQgynEeZrtwntbdTbHG26q0SIQ88+VLzp3azkhnNkokk
	o457Qpp7fa233TR3Gb76fnJCP2MwY1Yyn4KhL9LE8WZcWKvJWHEQPptv1s67ooN0wkyMAq07mgb
	zl8CRUAtOnzJcHQatRWfM25S2TXB4QQ==
X-Gm-Gg: ASbGncuLC82QTRqyLPukCsWaMJUluXbuw1uvlBNR8+iUL3BNRwQ9uKLZYGkzqs7REHa
	9rfTp9KmBzAffscFYtaTkJlihN+x4FBFSeLf5SP+ocHAI2Px3RCPF/H/IJgrKYiH2VJ/W2MLArn
	2MxQACdnb24Fqe
X-Google-Smtp-Source: AGHT+IFb6bp3rXZIXccMiqKeTqqZ3aVzqs9ZuX6H4uK1nwHOokS1me73NCB0uWKDmH3ipDaCG0LxiuTwvuBYjrQaf94=
X-Received: by 2002:a05:622a:181b:b0:467:5384:50ed with SMTP id
 d75a77b69052e-46fd0a1d03cmr264451401cf.10.1738607087692; Mon, 03 Feb 2025
 10:24:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123012448.2479372-1-joannelkoong@gmail.com>
In-Reply-To: <20250123012448.2479372-1-joannelkoong@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 3 Feb 2025 10:24:37 -0800
X-Gm-Features: AWEUYZnh9mTp3j1Hth3tKA7efy3IAswev8gHFTI1c1wQv-u3zsVVFmwHBm1Ootg
Message-ID: <CAJnrk1Z=V0-7XE9i9jvbtrNhrLZ1krzuYmfvdoDaOESUZxes3w@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] fuse: support large folios
To: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com, bernd.schubert@fastmail.fm, willy@infradead.org, 
	jefflexu@linux.alibaba.com, shakeel.butt@linux.dev, jlayton@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 5:28=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> This patchset adds support for folios larger than one page size in FUSE.
> This does not yet enable large folios, as that requires one last piece, w=
hich
> is for writeback to support large folios. Large folios for writeback will=
 be
> done separately in a future patchset. Please see this [1] for more detail=
s, as
> well as benchmarks we can expect from enabling large folios.
>
> [1] https://lore.kernel.org/linux-fsdevel/CAJnrk1a8fP7JQRWNhq7uvM=3Dk=3DR=
bKrW+V9bOj1CQo=3Dv4ZoNGQ3w@mail.gmail.com/
>
> Changelog:
> v3:
> https://lore.kernel.org/linux-fsdevel/20241213221818.322371-1-joannelkoon=
g@gmail.com/
> v3 -> v4:
> * Add Jeff's reviewed-bys
> * Drop writeback large folios changes, drop turning large folios on. Thes=
e
>   will be part of a separate future patchset
>
> v2:
> https://lore.kernel.org/linux-fsdevel/20241125220537.3663725-1-joannelkoo=
ng@gmail.com/
> v2 -> v3:
> * Fix direct io parsing to check each extracted page instead of assuming =
all
>   pages in a large folio will be used (Matthew)
>
> v1:
> https://lore.kernel.org/linux-fsdevel/20241109001258.2216604-1-joannelkoo=
ng@gmail.com/
> v1 -> v2:
> * Change naming from "non-writeback write" to "writethrough write"
> * Fix deadlock for writethrough writes by calling fault_in_iov_iter_reada=
ble()
> * first
>   before __filemap_get_folio() (Josef)
> * For readahead, retain original folio_size() for descs.length (Josef)
> * Use folio_zero_range() api in fuse_copy_folio() (Josef)
> * Add Josef's reviewed-bys
>
> Joanne Koong (10):
>   fuse: support copying large folios
>   fuse: support large folios for retrieves
>   fuse: refactor fuse_fill_write_pages()
>   fuse: support large folios for writethrough writes
>   fuse: support large folios for folio reads
>   fuse: support large folios for symlinks
>   fuse: support large folios for stores
>   fuse: support large folios for queued writes
>   fuse: support large folios for readahead
>   fuse: optimize direct io large folios processing
>
>  fs/fuse/dev.c        | 126 +++++++++++++++++++++--------------------
>  fs/fuse/dir.c        |   8 +--
>  fs/fuse/file.c       | 130 +++++++++++++++++++++++++++++--------------
>  fs/fuse/fuse_dev_i.h |   2 +-
>  4 files changed, 156 insertions(+), 110 deletions(-)
>

Hi Miklos,

Does this patchset seem acceptable to you? This patchset sets up
everything except for writeback to support large folios. The writeback
piece and actually flipping the switch to turn on large folios will be
its own separate future patchset.

Thanks,
Joanne
> --
> 2.43.5
>


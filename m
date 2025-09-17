Return-Path: <linux-fsdevel+bounces-61889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E8CB7D0B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9051322865
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 08:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F3930AD1F;
	Wed, 17 Sep 2025 08:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Fz6P+5/5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C32D3090EF
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 08:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758098312; cv=none; b=Kcpwal8eD/zqyGqocVeRgDnqop5dPyYvzruDeTP2KtBiUmOkUO3mQb35GQIx8+DRokzYXLSvhljjjb4B2uSc0cFtiVgwBWnB7DtSTZzJA4RSWVOajAEnmEVj/B+bUqUpDpZ7SMexrcKr18vRA1VeXyrtoEpLoruK8dzP7mezE2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758098312; c=relaxed/simple;
	bh=KBHmJ3YGPWtw0TVBcuf6xQxYfSMlt+upAEuM25ZvfTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VZjAO/b8Knvd9UHaH9mSO5qFaGWzfjPSXzdr2dPl7loKaI2COVv0FCrhgFjRM0i3xBHH92liLPjkdsEO5Zh3bkouroEhrXqTRIrEzGT3k3mA17pAP8FFLcuvsHA+k+9ywkb+BpyTwl02Uvm7hIn46nKIko4CI17iaikBG5r1NcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Fz6P+5/5; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b0aaa7ea90fso375631966b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 01:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1758098308; x=1758703108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBHmJ3YGPWtw0TVBcuf6xQxYfSMlt+upAEuM25ZvfTw=;
        b=Fz6P+5/5S0HPbLu5ZcKN4CRqFhCXQkaQqzn3gvxAxrpqYi347vsVH+bSInBXXg3LZ1
         MJe0hJOWQ7H68bA3Fb86ikAAUgoN6NMw10SXlFpoHoZLTE27CIYSQNJdsyJpKhCsALqI
         u/PtC8JOjzZQEpl/sWXMvNl2n2F+HbgboaInG4YswfUpUlJI/i6umW5vIh+mfj3ux6yg
         v99K2p2iQ6pUa2Uj7wkyxgQYzLNcbmhElhtX3KcpcXyQyAo5n2Y/i6EOjcW+Vx3rMeBd
         g4OUTACl/hLc3vGseFlAD/S+EIGVE5q1SnJSaJCSUYpBEhbIwo7xAlV5jIyZe4op52Sg
         h6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758098308; x=1758703108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KBHmJ3YGPWtw0TVBcuf6xQxYfSMlt+upAEuM25ZvfTw=;
        b=hlhD4HCtjtV2YXisrPtiEUqg6GWg1nqlwTIrn4vBfCNTnTrvFdpyIuQBTCp0l/zU8X
         JIvbFVcXKHJoyoBFk+3iKINaT5sIfAau6hFLOiJAXffxMuyt9GRVxxXZEo8D7tibH+Xn
         dPyEF0ZQCbDI8i0ASr0HH0CemqQbaqBBFhgoYukt/7qiJjfaJ9Lm86DixJNBT6V5cTfH
         Tgr8/9pDRTlH9ZgVmJ6euM20bhU6IRyQZadSJygcsGi+7eA8ltWlX54Qqm5E3DyACsrs
         OD2JtqS8Uk+RaPyxC1zP5LYwJpLCZDOFvh17bI2nZEm08n8BJWk3C5rbJEmC9bOeRIlg
         QXvw==
X-Gm-Message-State: AOJu0Yx4NeQ9VvVtW3+z4TVA04W6ritmyqci3jjKERN7sVCq5ghkMizg
	YlSAJrKns2DZEP5/dntFdEU9GFenlo+z7QOGMuNvWjuAyekWkwohIQCVfF42KJYWYQf4qPzxEXP
	o38O5VKy1fy5GO9ZNhymRCl5aNdNRfY6M+5uIkgESOA==
X-Gm-Gg: ASbGnctvOZ1M0BI/vgHPPz/9OLlSLnVBMztRoMd5kgPPQdxPWP/BhLmEFgaTyVZgdH3
	pSiDM3zTfeWj2wmzw2KLzZE34SHS2EpheWc95NnkehsI/F2rOhyKP2Jc+s5fHu/QJXCNGV8CgHB
	H5q6e0wZ9j/T428KPBTQkAL6uTj3D/cIw2pG85hwFfyWN2DXydQuncn79jDFAiYYTYw74fkoEhq
	FmgO5WVCCmvY9kCuErckvNeLn8GOHwrpBJe
X-Google-Smtp-Source: AGHT+IEMhj2KG5qf8fnmY8YQ236Z2f/mZuBCacS/ZiY/DG7jAo8+3I46DBQR8FMyLwnPYtxjdsnW2tAHRfHmFvDQvtc=
X-Received: by 2002:a17:906:6a03:b0:b0f:7d24:589e with SMTP id
 a640c23a62f3a-b1bb2ef9ac7mr134196066b.24.1758098307607; Wed, 17 Sep 2025
 01:38:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+-QRTC_j15=Cc4YeU3TAcpQCrFWmBZcNxfnw1LndVzASg@mail.gmail.com>
 <4z3imll6zbzwqcyfl225xn3rc4mev6ppjnx5itmvznj2yormug@utk6twdablj3>
In-Reply-To: <4z3imll6zbzwqcyfl225xn3rc4mev6ppjnx5itmvznj2yormug@utk6twdablj3>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 17 Sep 2025 10:38:16 +0200
X-Gm-Features: AS18NWA-wrbT4q0S-rkaZcoEEdey-hG5hsxUREPMlCw6I5wTNJXSuzY62UoJVKM
Message-ID: <CAKPOu+--m8eppmF5+fofG=AKAMu5K_meF44UH4XiL8V3_X_rJg@mail.gmail.com>
Subject: Re: Need advice with iput() deadlock during writeback
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Linux Memory Management List <linux-mm@kvack.org>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 10:23=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> =
wrote:
> So that we are clear, this is a legally held ref by ceph and you are
> legally releasing it? It's not that the code assumes there is a ref
> because it came from writeback?

Porbably yes, but I'm not 100% sure - Ceph code looks weird to me. A
reference is released that was previously taken by
ceph_take_cap_refs(), but there's another condition that causes an
iput() call - if ceph_try_drop_cap_snap() returns true - but I don't
see where that reference was taken.

> One of the ways to stall inode teardown is to have writeback running. It
> does not need a reference because inode_wait_for_writeback() explicitly
> waits for it like in the very deadlock you encountered.

Ah, right. No UAF. But I wonder if that's the best way to do it - why
not let writeback hold its own reference, and eliminate
inode_wait_for_writeback()? (and its latency)

> However, assuming that's not avoidable, iput_async() or whatever could
> be added to sort this out in a similar way fput() is.
>
> As a temporary bandaid iput() itself could check if I_SYNC is set and if
> so roll with the iput_async() option.
>
> I can cook something up later.

My idea was something like iput_safe() and that function would defer
the actual iput() call if the reference counter is 1 (i.e. the caller
is holding the last reference).

That would avoid the other Ceph deadlock bug I found - because Ceph,
like all filesystems that are built on top netfs, uses
netfs_wait_for_outstanding_io() in the evict_inode callback. Because
guess what happens when the Ceph messenger worker that handles I/O
completion decides to call iput()...
Due to the evict_inode callback and the unknowns hidden behind it,
checking I_SYNC is not enough.

Almost all iput() calls are fine because they just do an atomic
decrement, but all kinds of scary stuff can happen if the last
reference is released. Callers that are not confident that this is
safe shall then use my new iput_safe() instead of iput().

I can write such a patch, but I wanted you experts to first confirm
that this is a good idea that would be acceptable for merging (or
maybe Ceph is just weird and there's a simpler way to avoid this).

Max


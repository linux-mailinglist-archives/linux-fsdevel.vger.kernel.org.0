Return-Path: <linux-fsdevel+bounces-52922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDF1AE87EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 17:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ECD51C25120
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 15:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD092BEFFC;
	Wed, 25 Jun 2025 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ac74SO+b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6B129C33C
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 15:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750864935; cv=none; b=oScXbCO7rnrUkY0kbX/HCaXAqdzMpfMCVqWBC9u4HJYvGDKtxSklkm0+BsmN3OBTdHuEAcT6SlO7uRvSlzbesZASaD7SwCzROQ/njAyrtbg4T396YiQeMG/lgFD+rZkHATmjKKpiNWxST2GcL6/yDhuvkIexdFpkN6IP3YP7E7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750864935; c=relaxed/simple;
	bh=CkP4Zii5yEFnjEpnjpmU8yomUCDwhFbpaCZV6rMyG4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eq1WBCi/+KLXa9XRIZCQrTyXc3EK9IDrN6cQ05Bf36V/JOMHTtyQiGVOp4FIpXMw7I8eWqhGTTs5upXjtrFA2ycMO62AEvdShcDu5zJIF4PhcnwWivizZ5QvX1Iuc3jmxTpU6HcFkmM6xFTKqJVCK9E/gGLcI2Nb3v8mds4wTms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ac74SO+b; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-47e9fea29easo431031cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 08:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750864932; x=1751469732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJ5P0u/6xcg1NtaqnGcLvqTOCLTnaVcDdgVW1OPXhxk=;
        b=ac74SO+bXQSpktt/NQgPXOw8n0qyYQEtL9Qu8SaqtLijnACeUk3QX0c4Gq3LLWwHvm
         873xAuPBg563ut2+95zgEXaL3KKzEkSyHZ5lTaCVLbjjRKfxjR3tmUe0Irm4cOV2cCDd
         YgRE/5pptYf23aV/5nHnJcvPg7LewX7ze+bYkygHMU0Wk+RqWB7KmJ6HPnURTXGxnLdw
         8Un0uUZ9cgAPOaRAhRkiVUpWiJc7VHhYwH5UT+qnmGBMGKAKsPIeMIYUP1vSzNTPpEu8
         ZKFrvfSTpFDTX0y2Bpn0Pc8jef0pWHerHaCbEsQS2Obg20aby8mMIWg/Jj/R5OAqpLpq
         zPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750864932; x=1751469732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJ5P0u/6xcg1NtaqnGcLvqTOCLTnaVcDdgVW1OPXhxk=;
        b=f6mJ6GtcenBN2iK6gU9H/SWwZiS5GpKffIdLKHtsaunGLLm3kz7G5ugP9MBaNWNxJ/
         jMJMq8O64S7dsbE2FYcvlz4FRpLTgOsoIABcX3IinuZKm/AlCO2RcYt/4xYOs1UhxFSL
         WMsBqn0FaxYIgPNl446HHrIg+BBmip+bOSKHmWQw/NGIOpwaZBWfaudSvhLO3InTqi5l
         PbpPnvBqE2UD7wWkuDiFinKA6KjTZW+Sis9mVipBSHWthvdvHnpeNVhopiRz6DPmHBCR
         gyG/Xcoln6Rkocd5nCGheGIPKCBoNxJCPz/VYxlUXWQPo51YbKfTTPq/Y1N+hMeIs9Ti
         1BUw==
X-Forwarded-Encrypted: i=1; AJvYcCWEBxGQVYgRVBcUGYvmHpt+oP0ZpB4xKSVDfviPU7yb1C972aH5U/ydgFyg8PKM8GHmdkyYzB/6UO/PQiH9@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5fCWIb2r7NPOaLP5iuqJ/QQ7znA8wbV4qYYZzOH0pNdEm1gz4
	8LvshuVl2G/gT3aWjKHqzZkqADnST+MKc1XC+Er2zmi1SFqM9KVtAZe2qpouQ6uprqkTXCzDmqO
	qT5Vb1ahvGaAval5FWoqUBzGpsNV59upRoS0HN2XU
X-Gm-Gg: ASbGncvXgAXPoB//ZLTwMgaNYtJHXvEjAaKCo8XPCQwvlpgJNVnTZ4s69sHk+1VYN8l
	Bm9BtlHngp9iBIw9fOQJ8h4NZ3YBQbfz5FBQPIwENS81xqp6LNOboOEN9558gVP0k8dLEWl33oV
	y47IgqWnk30lBrg57wkQ6XA4nq6PTPSsryU8PnJzxvvw==
X-Google-Smtp-Source: AGHT+IG8U6qG5KYMo+nkavpDTx/PPdha23r+RnimIC8ktx5xvsAvgguafO1U53hsdch5/27popiTWWkJKAGkT/NKfVc=
X-Received: by 2002:a05:622a:85:b0:4a6:f9d2:b547 with SMTP id
 d75a77b69052e-4a7c236b037mr3595081cf.20.1750864931337; Wed, 25 Jun 2025
 08:22:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624193359.3865351-1-surenb@google.com> <20250624193359.3865351-7-surenb@google.com>
 <fd305c41-b2a3-4f0c-a64d-6e2358859529@lucifer.local>
In-Reply-To: <fd305c41-b2a3-4f0c-a64d-6e2358859529@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 25 Jun 2025 08:22:00 -0700
X-Gm-Features: Ac12FXxttU6uD8NTsD-TnCGNT9pqqB3547DZqQ19Bc1hh7qCrrhXbmy4EDhP4xU
Message-ID: <CAJuCfpEpshf7L-Axt4MJf=onoz4F=Sw4nk5Z1yVwvwkzSYx9qA@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] mm/maps: read proc/pid/maps under per-vma lock
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, david@redhat.com, 
	vbabka@suse.cz, peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com, 
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, 
	andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	tjmercier@google.com, kaleshsingh@google.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 5:30=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> This patch results in some spam :) there's a stray mmap_assert_locked() i=
n
> anon_vma_name() that triggers constantly.

Ah, damn! This was triggered before and I completely forgot to fix it.
Thanks for reporting it!

>
> Andrew - I attach a fix-patch for this, could you apply as at least a tem=
porary
> fix? As mm-new is broken at the moment with this patch.

Yes please.Andrew, if you would prefer me to respin the series please
let me know.

>
> Suren - could you check and obviously suggest something more sensible if =
you
> feel this isn't right.

This is exactly what I was planning to do but it slipped from my mind.

>
> I'm not actually sure if we'd always have the VMA read lock here, maybe w=
e need
> an 'assert mmap lock or vma lock' predicate?

For now this is the only place that needs it. Maybe we can wait until
there is more demand for it?

>
> Worth auditing other mmap lock asserts that might have been missed with t=
his
> change also.

I'll go over it once more but this was the only reported issue with
the previous version.
Thanks,
Suren.

>
> Cheers, Lorenzo
>
> ----8<----
> From 1ed3bd12d43be1f8303fd6b7b714f5ef7e60728a Mon Sep 17 00:00:00 2001
> From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Date: Wed, 25 Jun 2025 13:28:36 +0100
> Subject: [PATCH] mm/madvise: fixup stray mmap lock assert in anon_vma_nam=
e()
>
> anon_vma_name() is being called under VMA lock, but is assert mmap lock w=
hich
> won't necessarily be held.
>
> This results in the kernel spamming warnings about this on startup.
>
> Replace this with an open-coded 'mmap or VMA lock' assert to resolve.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Acked-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/madvise.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index c467ee42596f..0530d033b3dd 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -108,7 +108,8 @@ void anon_vma_name_free(struct kref *kref)
>
>  struct anon_vma_name *anon_vma_name(struct vm_area_struct *vma)
>  {
> -       mmap_assert_locked(vma->vm_mm);
> +       if (!rwsem_is_locked(&vma->vm_mm->mmap_lock))
> +               vma_assert_locked(vma);
>
>         return vma->anon_name;
>  }
> --
> 2.50.0


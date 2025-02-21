Return-Path: <linux-fsdevel+bounces-42276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA5FA3FD0E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 18:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B54224258BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 17:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A1324E4B0;
	Fri, 21 Feb 2025 17:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZWCwY+GT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B8024C699
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2025 17:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740157857; cv=none; b=E9HEBXgYA6LXgoUiim9lVCQwoVCRLAsSZlwirQA17FlU2s3Kjv0UBl0xK0EIMoYzNXdq1zzzbPOPOSb548q0bzS5Vf4ga6DnSr+ag/uM8l4urxlCVP+ElmEpYI1aPeNE0+hgLVdR/JkztjwqrotiWAn/OYQLLBaMGGBCkfKeZ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740157857; c=relaxed/simple;
	bh=zLivjvSwcKhzlo3svCNKQUA1a6rIcuwqxFgzLbvteDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=miKDELnxUg/n0n43UObFXhRR/QNxKauB8vu0rwbVXkIkigOC5Ykw5Yg/LzbOjsn4Aqg1JyhpfqL6H4idvAFR/ymBeFl41HzkRf5b5yLw3NLnDYVLtUxYCBAOt+fqbx32jP6ZXX4XnQRuAspCRw1XoCD9eXpgbkeXfuZ8qZNRvZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZWCwY+GT; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22117c396baso183265ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2025 09:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740157854; x=1740762654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/06cutobvSL148SHg+rXF1/EKMBeC15diJi2NLvYxY=;
        b=ZWCwY+GTFO1iI+FQVPsHIwyBpRTmBQ7AxQKENZYhr1JVm/AArUyEyHaZatbtEJ4ZJk
         XaGGpLFyLhmmClseqZACnUYcxfghU/pK4dxF96CuHC7xVNQF5rBmM6hKmIJe+f0uYh0z
         VG8kiDRAiYyikaVcQpYy4OwWw4JoescXotRxPKgdqdb8rO6wcyF9IhiiW8Uer2iFripx
         aR6a+rRCu33U7ThjgnX6ri1cMtgiW4qDoLwcigOe9X58ywAq+XUfyvyBeLHEzYVr0EeB
         iwV3SIBdjEobm53uMmoG188zeGM5U0585Rrfm5qOQbcwz0Sj9VBDAde5c5CkJ++dy7sT
         +1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740157854; x=1740762654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v/06cutobvSL148SHg+rXF1/EKMBeC15diJi2NLvYxY=;
        b=NOG5rjdd/8+hGD0LQaXk2P1/HmWPNDqrqh2rTZYKBex2LGVkXiHPgawxt1Q7ofYp4/
         4QIVOgauH+nfQUH6yZ6iigZuhBAcWkNhDqUWLlMOqJLdRVMGo/B/tKA1iKZJCznUOJBJ
         kZpWWNXkfo6irr2Iz4m77cb6SA0otFdPtPU7QuLcZcq+d1vykMOzPAcO4+l3QUp6Zm3J
         dFNBL6QJ8gw2jFWKf7kr/F/d+GTnI83NhP/M1juNa8dhO6bjXoPbTRr6j8zq63HeeAOU
         DD2bR6b0/2WOlILIFtYlQ+dKKrkVcWbhsivDxlpM1yE+BrZFZ3O00n4uzywSkvT291Sx
         MM8A==
X-Forwarded-Encrypted: i=1; AJvYcCXzBb9SQrT8kd3eH0T0JvPfGhxIWPqmm82nnAF66buGYbDg+5/qYOtonyKoOmso0lizdyjG+CBgb5S+8tHL@vger.kernel.org
X-Gm-Message-State: AOJu0YwfTtN2uGQWSAdMJrPZhZo1P9gYekBCKX85qA6Ei7uL2VGVSQ5G
	ON63D2sHYX1kOvu0doNg1NLFbw0AFA2eOKZMM7tHV+Zj8ShQG5rb1iq8MRPMTTht8V3MtbUMo+V
	PtpGAIAWzrXoL3ukrhcAxmrslqPVdgEpUnsK4
X-Gm-Gg: ASbGncvLnV0B6+D0KC9ATqSCSvO269+oKdWkHdAXaykCSY9WRD4F034l0svwLyZwbEj
	ufkHX3OUxZ6p6hz8FcP7GHth+NCH+VJlf8Y1mf5Agfx9qTEfQwD1SFcbLJ62xrlzmSNEOJfuyId
	9+gJbFObLcLeU4tOHHOiPUyQOo8p2gIx3+2WSLclvI
X-Google-Smtp-Source: AGHT+IGldTX8YPxNiHq5GCgGriPX+2NeZhhwxRgXaqAzM2MGUPniBZmpaA4CLGFWvvlR3adETlTMpcRMFGLlc6gV27Q=
X-Received: by 2002:a17:902:e5c6:b0:215:8723:42d1 with SMTP id
 d9443c01a7336-221a0417e96mr2978475ad.10.1740157854187; Fri, 21 Feb 2025
 09:10:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740139449.git.lorenzo.stoakes@oracle.com> <521d99c08b975fb06a1e7201e971cc24d68196d1.1740139449.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <521d99c08b975fb06a1e7201e971cc24d68196d1.1740139449.git.lorenzo.stoakes@oracle.com>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Fri, 21 Feb 2025 09:10:42 -0800
X-Gm-Features: AWEUYZnbM5nA9kkqZnhzwGTEHPz7kvvIuks0mem2iJOt7iRv8etO859ySZMIHY4
Message-ID: <CAC_TJvf-R6MuSS9e0b4orhxLrFwXTnvZV-vf3sB+BnSbEqsprw@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/proc/task_mmu: add guard region bit to pagemap
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>, Juan Yescas <jyescas@google.com>, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 4:05=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> Currently there is no means by which users can determine whether a given
> page in memory is in fact a guard region, that is having had the
> MADV_GUARD_INSTALL madvise() flag applied to it.
>
> This is intentional, as to provide this information in VMA metadata would
> contradict the intent of the feature (providing a means to change fault
> behaviour at a page table level rather than a VMA level), and would requi=
re
> VMA metadata operations to scan page tables, which is unacceptable.
>
> In many cases, users have no need to reflect and determine what regions
> have been designated guard regions, as it is the user who has established
> them in the first place.
>
> But in some instances, such as monitoring software, or software that reli=
es
> upon being able to ascertain the nature of mappings within a remote proce=
ss
> for instance, it becomes useful to be able to determine which pages have
> the guard region marker applied.
>
> This patch makes use of an unused pagemap bit (58) to provide this
> information.
>
> This patch updates the documentation at the same time as making the chang=
e
> such that the implementation of the feature and the documentation of it a=
re
> tied together.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  Documentation/admin-guide/mm/pagemap.rst | 3 ++-
>  fs/proc/task_mmu.c                       | 6 +++++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/adm=
in-guide/mm/pagemap.rst
> index caba0f52dd36..a297e824f990 100644
> --- a/Documentation/admin-guide/mm/pagemap.rst
> +++ b/Documentation/admin-guide/mm/pagemap.rst
> @@ -21,7 +21,8 @@ There are four components to pagemap:
>      * Bit  56    page exclusively mapped (since 4.2)
>      * Bit  57    pte is uffd-wp write-protected (since 5.13) (see
>        Documentation/admin-guide/mm/userfaultfd.rst)
> -    * Bits 58-60 zero
> +    * Bit  58    pte is a guard region (since 6.15) (see madvise (2) man=
 page)

Should this be 6.14 ?

Other than that: Reviewed-by: Kalesh Singh <kaleshsingh@google.com>

Thanks,
Kalesh

> +    * Bits 59-60 zero
>      * Bit  61    page is file-page or shared-anon (since 3.5)
>      * Bit  62    page swapped
>      * Bit  63    page present
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index f02cd362309a..c17615e21a5d 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1632,6 +1632,7 @@ struct pagemapread {
>  #define PM_SOFT_DIRTY          BIT_ULL(55)
>  #define PM_MMAP_EXCLUSIVE      BIT_ULL(56)
>  #define PM_UFFD_WP             BIT_ULL(57)
> +#define PM_GUARD_REGION                BIT_ULL(58)
>  #define PM_FILE                        BIT_ULL(61)
>  #define PM_SWAP                        BIT_ULL(62)
>  #define PM_PRESENT             BIT_ULL(63)
> @@ -1732,6 +1733,8 @@ static pagemap_entry_t pte_to_pagemap_entry(struct =
pagemapread *pm,
>                         page =3D pfn_swap_entry_to_page(entry);
>                 if (pte_marker_entry_uffd_wp(entry))
>                         flags |=3D PM_UFFD_WP;
> +               if (is_guard_swp_entry(entry))
> +                       flags |=3D  PM_GUARD_REGION;
>         }
>
>         if (page) {
> @@ -1931,7 +1934,8 @@ static const struct mm_walk_ops pagemap_ops =3D {
>   * Bit  55    pte is soft-dirty (see Documentation/admin-guide/mm/soft-d=
irty.rst)
>   * Bit  56    page exclusively mapped
>   * Bit  57    pte is uffd-wp write-protected
> - * Bits 58-60 zero
> + * Bit  58    pte is a guard region
> + * Bits 59-60 zero
>   * Bit  61    page is file-page or shared-anon
>   * Bit  62    page swapped
>   * Bit  63    page present
> --
> 2.48.1
>


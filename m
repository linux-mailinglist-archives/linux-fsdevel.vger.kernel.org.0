Return-Path: <linux-fsdevel+bounces-44470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECE5A697E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 19:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D26F428375
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 18:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CA820C003;
	Wed, 19 Mar 2025 18:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPQUjgJD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885591DF271;
	Wed, 19 Mar 2025 18:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742408576; cv=none; b=PUoIdnr1v1Z1sj23j2SOULsb9IGZkgJrqv3nhMRbpQmn+ICMXmpsMlZ4/zlX3kDzALa33sQhngVCmrPx3pI/7Iq9rQ4AusveOKFBJXmQukq5mbN6KsJrqzs5q9sE5pHRb61c42bYfVqlDBIblbY+B5BdYtEQTED9m4eLm6SoIwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742408576; c=relaxed/simple;
	bh=EaxMpD9W8uZcvCwEnoAV9wzWk6ALOz5xdQZST97pXqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NmhYk3mmvL+TG7iq//hZhM6KExVVP4RH5dj0X2CdeOsV4vQSvjtGU61Aena0n3r4mUWpUkAyju5AHGKvZ6qelk4AL1djrMfzUtHtkipQwi1R5b2z/9xnTKWYwRN5YxOFTn/W6ry6M9vDqYdKbFtHfAF2PrxzIzQ+MyrdreNtxHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPQUjgJD; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30761be8fcfso74561fa.0;
        Wed, 19 Mar 2025 11:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742408573; x=1743013373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLkLWvkDX5FuoXTeYmRt1KErPEmtJ52plY5zQ5AVuCU=;
        b=VPQUjgJDNvirToTFuvDYSKNkWlaaXWhRms8DP0ZPnIiRXml2HPp9ENEii9LEUNS5QO
         ZGST7Va0W9+ZIIrqvS2pzNyw2ETMq4rmuoOjy6YrQ7cfCfpsWSgwEJZX71Y0o97/79LU
         KcA1FHQo6hQrpcXnXJ3Tp7miEjZcm4cE+SWSyR5ZhBcgojaasjzPDSDTGwHkAM9BvkZz
         17x0qM70/5B4KLxEZ2HiNBdLGqIsdTKVELGqEFUlZCsQ0VTfMRee+Mu9mmmLspiopuXS
         VUucg6Wu64czmAfzQhYSGVanD9G3P3Fp5Zcjd0A+05zkV6TjrNp/QO31+U4tPkIiGCqD
         kSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742408573; x=1743013373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VLkLWvkDX5FuoXTeYmRt1KErPEmtJ52plY5zQ5AVuCU=;
        b=PZFVRdxDyCJNGRo1zmd5DFNyCUHShiCK9mESv1/yDztq+cGV3rejeM4nVcJpoE1lfx
         M+OtOq6voSWJlsJu3Iyxxk46uEuqnqYnXy2s3eJbA4o/5NRhI8BX7Ie87Ylc8BfPqJ90
         7iYwGTbqa/JoYdXjv0foyAFtQ024+fn4RlZxvkwXfQaDOLEJ+TzW+w7UfazZIvIQFqaW
         FzbBgK35N6KghBOjkmCJMw0aVwxPq8nymjVRQvxq9gusykny0b38H0tgeLt5VWUAaeln
         +o7/zx9xxj31iN86NcbzbXVqJi8Nxhs0fSaMbz/WXZfylZN9ZcxPTA5x6wQI/akLJzxV
         EyHw==
X-Forwarded-Encrypted: i=1; AJvYcCUpPHDMhFsrG2PUkfYnw+g3+2NAkPwtOCrJHl43NIbetSmW9YFhFDuyTDkw7c/vjH13mPEr6VQdFqh9PcLfB5ID@vger.kernel.org, AJvYcCV6GmPEbtB/b8OaHafHza0NSp087PGAAOPC7NjEIEpz+rjSWZR4zRzJWczDyPdX4eGVaiTZpVE31FN5eVrC7Q==@vger.kernel.org, AJvYcCWGQSW9m0HZ17vjm75ix2DvxIUreD91r+/vASi36pZ2ijrobifeocOTQeKfC8fs3egvk82KaFHXke94@vger.kernel.org, AJvYcCWdOE2CttomIWTKs+C5CIsRVB61nmhZEk3q1hUGzbrb3RwaAjcdLQcYCLuJkp9ANxEP+WEIKb4yXupscOlW@vger.kernel.org, AJvYcCXhp25JXvTXL2nAKaVV/SqnOr/k4tdLI+84l2YqiXwwJcL+7ICPz+ttVr6ZGgRjHAK3KqGufrcTP0A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/x4nfCeQYCy20LiYUoBdg/skKDCCzHsJ+men2vGpxDPZa9i9D
	L7P1bn037LbasqBtOE+G035wOTO1u/tpOjwVtTTQiQpYdtV3DaJYfxb15Q9hJCCovYUv3HRHMl9
	OXbnyKsJ+uWAu6mhHG/1idxyzNVQ=
X-Gm-Gg: ASbGnct9C2+aDaZkQdw8nMiSItK50hoo8+4yB/0lHsp67d3ARS45gysDtckbyCJP3lI
	RVi+oaoBe+cutA2vIwS4ecyM9CJwO6yt3jnIkTVKO25bhjwutnf5dPu9QHuyZFLM+CfJ+lTMH7R
	r+JqV9l3MHW3ajiV974MlqFh7ia5s=
X-Google-Smtp-Source: AGHT+IHrb+0+RW//aqL4hayGxKMukUv5CQcq0S1hKrCwbb+4QWIXnDL8Nl4vyyrv12iknXkUgnUUPfeHuJytfA0aC3k=
X-Received: by 2002:a2e:8e86:0:b0:30b:f924:3554 with SMTP id
 38308e7fff4ca-30d6a40df68mr11816251fa.21.1742408572336; Wed, 19 Mar 2025
 11:22:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740139449.git.lorenzo.stoakes@oracle.com>
 <521d99c08b975fb06a1e7201e971cc24d68196d1.1740139449.git.lorenzo.stoakes@oracle.com>
 <857b2c3f-7be7-44e8-a825-82a7353665fb@redhat.com> <cd57ed04-c6b1-4df3-a5cb-a33078a08e74@lucifer.local>
 <09d7ca19-e6cc-4aa9-8474-8975373bdebd@redhat.com>
In-Reply-To: <09d7ca19-e6cc-4aa9-8474-8975373bdebd@redhat.com>
From: Andrei Vagin <avagin@gmail.com>
Date: Wed, 19 Mar 2025 11:22:40 -0700
X-Gm-Features: AQ5f1JruWAyKDTdp0dEzeU8snZGpGJb9hqdzmlckS-ryauSv8oXkKubpwnOYi4E
Message-ID: <CANaxB-yMBSFeYcTr-PaevooSeHUkCN9GWTUkLZUNW2vxKzm0sg@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/proc/task_mmu: add guard region bit to pagemap
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Matthew Wilcox <willy@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>, 
	Juan Yescas <jyescas@google.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org, 
	criu@lists.linux.dev, 
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, Pavel Tikhomirov <snorcht@gmail.com>, 
	Mike Rapoport <mike.rapoport@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 2:39=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 24.02.25 11:18, Lorenzo Stoakes wrote:
> > On Mon, Feb 24, 2025 at 10:27:28AM +0100, David Hildenbrand wrote:
> >> On 21.02.25 13:05, Lorenzo Stoakes wrote:
> >>> Currently there is no means by which users can determine whether a gi=
ven
> >>> page in memory is in fact a guard region, that is having had the
> >>> MADV_GUARD_INSTALL madvise() flag applied to it.
> >>>
> >>> This is intentional, as to provide this information in VMA metadata w=
ould
> >>> contradict the intent of the feature (providing a means to change fau=
lt
> >>> behaviour at a page table level rather than a VMA level), and would r=
equire
> >>> VMA metadata operations to scan page tables, which is unacceptable.
> >>>
> >>> In many cases, users have no need to reflect and determine what regio=
ns
> >>> have been designated guard regions, as it is the user who has establi=
shed
> >>> them in the first place.
> >>>
> >>> But in some instances, such as monitoring software, or software that =
relies
> >>> upon being able to ascertain the nature of mappings within a remote p=
rocess
> >>> for instance, it becomes useful to be able to determine which pages h=
ave
> >>> the guard region marker applied.
> >>>
> >>> This patch makes use of an unused pagemap bit (58) to provide this
> >>> information.
> >>>
> >>> This patch updates the documentation at the same time as making the c=
hange
> >>> such that the implementation of the feature and the documentation of =
it are
> >>> tied together.
> >>>
> >>> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >>> ---
> >>
> >>
> >> Acked-by: David Hildenbrand <david@redhat.com>
> >
> > Thanks! :)
> >>
> >> Something that might be interesting is also extending the PAGEMAP_SCAN
> >> ioctl.
> >
> > Yeah, funny you should mention that, I did see that, but on reading the=
 man
> > page it struck me that it requires the region to be uffd afaict? All th=
e
> > tests seem to establish uffd, and the man page implies it:
> >
> >         To start tracking the written state (flag) of a page or range o=
f
> >         memory, the UFFD_FEATURE_WP_ASYNC must be enabled by UFFDIO_API
> >         ioctl(2) on userfaultfd and memory range must be registered wit=
h
> >         UFFDIO_REGISTER ioctl(2) in UFFDIO_REGISTER_MODE_WP mode.
> >
> > It would be a bit of a weird edge case to add support there. I was exci=
ted
> > when I first saw this ioctl, then disappointed afterwards... but maybe =
I
> > got it wrong?

> >
>
> I never managed to review that fully, but I thing that
> UFFD_FEATURE_WP_ASYNC thingy is only required for PM_SCAN_CHECK_WPASYNC
> and PM_SCAN_WP_MATCHING.
>
> See pagemap_scan_test_walk().
>
> I do recall that it works on any VMA.
>
> Ah yes, tools/testing/selftests/mm/vm_util.c ends up using it for
> pagemap_is_swapped() and friends via page_entry_is() to sanity check
> that what pagemap gives us is consistent with what pagemap_scan gives us.
>
> So it should work independent of the uffd magic.
> I might be wrong, though ...


PAGEMAP_SCAN can work without the UFFD magic. CRIU utilizes PAGEMAP_SCAN
as a more efficient alternative to /proc/pid/pagemap:
https://github.com/checkpoint-restore/criu/blob/d18912fc88f3dc7bde5fdfa3575=
691977eb21753/criu/pagemap-cache.c#L178

For CRIU, obtaining information about guard regions is critical.
Without this functionality in the kernel, CRIU is broken. We probably shoul=
d
consider backporting these changes to the 6.13 and 6.14 stable branches.

>
> >>
> >>
> >> See do_pagemap_scan().
> >>
> >> The benefit here might be that one could effectively search/filter for=
 guard
> >> regions without copying 64bit per base-page to user space.
> >>
> >> But the idea would be to indicate something like PAGE_IS_GUARD_REGION =
as a
> >> category when we hit a guard region entry in pagemap_page_category().
> >>
> >> (the code is a bit complicated, and I am not sure why we indicate
> >> PAGE_IS_SWAPPED for non-swap entries, likely wrong ...)
> >
> > Yeah, I could go on here about how much I hate how uffd does a 'paralle=
l
> > implementation' of a ton of stuff and then chucks in if (uffd) { go do
> > something weird + wonderful } but I'll resist the urge :P :))
> >
> > Do you think, if it were uffd-specific, this would be useful?
>
> If it really is completely uffd-specific for now, I agree that we should
> rather leave it alone.
>
> >
> > At any rate, I'm not sure it's _hugely_ beneficial in this form as page=
map
> > is binary in any case so you're not having to deal with overhead of par=
sing
> > a text file at least!
>
> My thinking was, that if you have a large VMA, with ordinary pagemap you
> have to copy 8byte per entry (and have room for that somewhere in user
> space). In theory, with the scanning feature, you can leave that ...
> scanning to the kernel and don't have to do any copying/allocate space
> for it in user space etc.

PAGEMAP_SCAN doesn't have this issue and it was one of the reasons to
implement it.

Thanks,
Andrei


Return-Path: <linux-fsdevel+bounces-36624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFCF9E6D2D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 12:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9672216947A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 11:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19908200B91;
	Fri,  6 Dec 2024 11:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlK+b2Ys"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D298F1FC106;
	Fri,  6 Dec 2024 11:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733483784; cv=none; b=Qy3HZYxC4J1hGUBhG6yaXzQCchypmx4cDWBvHpGmJWzHnzvvXduSOjXx273S9uW7j/A1145e9AnNmaSiCGa6ag35MA6BXLDfmYCWPxUj/NcBUQthgRaSUUoBBGgItdahAG8cUG3QjwyGqavjOuSZ3gv9IsbcHGmrmV7ori01TAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733483784; c=relaxed/simple;
	bh=fskPcBqtOVolwEsuvzakiQ+6uWu/WS13IBpJFDOITQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kTCBOQ9Tt4C1VYFXqN0fPBGFdnyQ6zYBLV+I7Xwgo+UEk3bOjQoytVwp7UvkEht0ZO5UVjzMcqjGBvplhoYJxDWJXNtGA//tlL3lAtc+i/mzd7NWvi8yUzqk2duBiKIIPPmIdm6kFsBQAUWIOHMH4yQhCWVcXeVnOvGTNcUNAeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlK+b2Ys; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d87fffeb13so12359366d6.1;
        Fri, 06 Dec 2024 03:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733483782; x=1734088582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XvyPZyZiKHfml9ebU5hvb2t0OAsao3tiC9iqjsvXzGc=;
        b=IlK+b2YsFqtRzY1Gif39k0bI6s2DDzJo7TrlPdw2z4dcwVU6DdwHbnaama2igEzUsi
         1grvOikrtwvokCbxxstFjCGK4BaNjzYM2tzy20VO072F4kJShKvChlkxdEX8anCqXPD0
         2bxV3SxuAGfYfIvqzkkX+8Buz8OMQsdBPQzijU1RCCHNhhJDH92fOSnIxe7HaD8xVifL
         HfI/n/FrRYlsmWH6WkhJoWxYmPr5ielvbC1eShEN4mFKBSQcNISFQxsbhk4YmDqq5RF8
         SNnFGOY7oRX0Lc23qUrLwP0RoAeZZveCADVj6/nLsTeAlPIvyAqfry/9OzP+uycQVQ9e
         gj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733483782; x=1734088582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XvyPZyZiKHfml9ebU5hvb2t0OAsao3tiC9iqjsvXzGc=;
        b=I/b8cw4nA71IBVIr+7bg1fpXKZx0Rjaahk5JAnwKuaa1DEmAmjySL/uiResXqgRkal
         zSBwXe91nJ8B1p0V0fqyME057NfPcd0Uabyvduo+S0iuaxwY0mWBcRAUrwhJKkMYiZs2
         JeAOCiX8IMn6xIfJKqgRGc7jO7OpOx3lv1nJ+cDMlyQyuZ08qiHAIPsQrBO5CpHwpNTa
         fsehzItUy3+29VTv6hjv497Yw64zYguvUCig8Ol95NA1iaqpPpPN/iWcXvT3HCJr7lpO
         vlwtFspdse/XEnX3eXZYiYjbnVQWrqiOyNS087QeHxL5PEXM265MF7tPkVsA5mGkQP6O
         G/+w==
X-Forwarded-Encrypted: i=1; AJvYcCVbrrfi1NDUJGY1dUZKPAcPQyn/GrQwPotFg767B12JtKMgZg1W/vjzmhxwovY3i29sYqXf7FWqJb20beGf@vger.kernel.org, AJvYcCWuHZZUaSm9atzOqHRsW56RHfBAg+Gkra1/4LeMQUqZTN8QcLhRwVpzYrhAeUwzgiY7a0GxKqagKOsCYB/H@vger.kernel.org
X-Gm-Message-State: AOJu0YzrTJcQHeHzwnoDjUBtDeSB+pPcSUKO7N2QDYihjwgHLyYCKbH8
	nOVuQaSKWwx8fZ0By/dK6hKhXfVPCybu913v9a9AuIYk0VF+npoWtxNzBFi7A0ClqCsCMcxsgD0
	qvm7JLg73PZrzJjLkt5gKZKGSQIo=
X-Gm-Gg: ASbGncshE4yuHA9ffsbhcNIbInZJCriTCbPZofQ97ZyMNOKFcexxERHwKDlQDzJW79V
	NFOlpTZNzzBDrGCLBfEcpSr4YTesB03A2XQ==
X-Google-Smtp-Source: AGHT+IGsXVbNpFZBkJf2UfAWclnLN+x7aGDS6QbjUzZ5a5PpSl3Ynr76UxRsxeHnS0Ewh0aDWgn/CumvPOK9iWA45VE=
X-Received: by 2002:a05:6214:2484:b0:6d8:ab3c:5c8 with SMTP id
 6a1803df08f44-6d8e741e87fmr28324596d6.49.1733483781653; Fri, 06 Dec 2024
 03:16:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203134949.2588947-1-haowenchao22@gmail.com> <926c6f86-82c6-41bb-a24d-5418163d5c5e@redhat.com>
In-Reply-To: <926c6f86-82c6-41bb-a24d-5418163d5c5e@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Fri, 6 Dec 2024 19:16:10 +0800
Message-ID: <CABzRoyZOJJKWyx4Aj0CQ17Om3wZPixJYMgZ24VSVQ5BRh2EdJw@mail.gmail.com>
Subject: Re: [PATCH] smaps: count large pages smaller than PMD size to anonymous_thp
To: David Hildenbrand <david@redhat.com>
Cc: Wenchao Hao <haowenchao22@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Peter Xu <peterx@redhat.com>, Barry Song <21cnbao@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 10:17=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 03.12.24 14:49, Wenchao Hao wrote:
> > Currently, /proc/xxx/smaps reports the size of anonymous huge pages for
> > each VMA, but it does not include large pages smaller than PMD size.
> >
> > This patch adds the statistics of anonymous huge pages allocated by
> > mTHP which is smaller than PMD size to AnonHugePages field in smaps.
> >
> > Signed-off-by: Wenchao Hao <haowenchao22@gmail.com>
> > ---
> >   fs/proc/task_mmu.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index 38a5a3e9cba2..b655011627d8 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -717,6 +717,12 @@ static void smaps_account(struct mem_size_stats *m=
ss, struct page *page,
> >               if (!folio_test_swapbacked(folio) && !dirty &&
> >                   !folio_test_dirty(folio))
> >                       mss->lazyfree +=3D size;
> > +
> > +             /*
> > +              * Count large pages smaller than PMD size to anonymous_t=
hp
> > +              */
> > +             if (!compound && PageHead(page) && folio_order(folio))
> > +                     mss->anonymous_thp +=3D folio_size(folio);
> >       }
> >
> >       if (folio_test_ksm(folio))
>
>
> I think we decided to leave this (and /proc/meminfo) be one of the last
> interfaces where this is only concerned with PMD-sized ones:
>
> Documentation/admin-guide/mm/transhuge.rst:
>
> The number of PMD-sized anonymous transparent huge pages currently used b=
y the
> system is available by reading the AnonHugePages field in ``/proc/meminfo=
``.
> To identify what applications are using PMD-sized anonymous transparent h=
uge
> pages, it is necessary to read ``/proc/PID/smaps`` and count the AnonHuge=
Pages
> fields for each mapping. (Note that AnonHugePages only applies to traditi=
onal
> PMD-sized THP for historical reasons and should have been called
> AnonHugePmdMapped).

Yeah, I think we need to keep AnonHugePages unchanged within these interfac=
es
due to historical reasons ;)

Perhaps, there might be another way to count all THP allocated for each pro=
cess.

Thanks,
Lance


>
>
>
> --
> Cheers,
>
> David / dhildenb
>
>


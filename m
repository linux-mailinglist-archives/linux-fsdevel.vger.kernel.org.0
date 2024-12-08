Return-Path: <linux-fsdevel+bounces-36702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 457C69E83C2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2024 07:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00212281621
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2024 06:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9026B84D3E;
	Sun,  8 Dec 2024 06:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+xH1lBD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664226EB7C;
	Sun,  8 Dec 2024 06:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733638031; cv=none; b=oWsLREBRvpuR4XDdriFOV/wDsRWDYWv7hMqwrT6UkFMvtNSaysb9UMayCOvoJroiJlL284H1DOOvJNb6rgbyGSfl7JRomq3gRayKPjHpIT6XbxyRFLx4S+s9/LzgGtXrdjja5zJQAlqnI6qxrKPB2bFeaNAhzJAtDfkDZfiqzhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733638031; c=relaxed/simple;
	bh=7cijtxLpsvFEZq0aUHVwe+cC1Eo2C7mONGy/jm6Ss94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q2g1kEue0HolHWhL6eYFFnA+H5T5VsHK6gKuXD9zwV1GTKHWT9jz2iKnsw8Am6kemTj0LTOgYL3W9bXA14+Aj27Nlv+gJ9v+tcDV3uEEpbVYPgxR2z5qrCVa8cY3ntPU3ZmVgFU2dWXE8dQYC6Vey+p0o3NpcJiUqsb7SZx8FdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+xH1lBD; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5174f9c0e63so36592e0c.1;
        Sat, 07 Dec 2024 22:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733638028; x=1734242828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSPTXbUKfNMinNGM5rUhYOdHvCQ+TR4BofaMXjdRcsM=;
        b=R+xH1lBDC/DdN0P8TdVAa4Pd+hGOQUIyGcryfFFAQiTaNsmbcsIwyTclbAQPoEvA7R
         tu88ee6JGs3VOUB4y5bClVuJpvr64CYFiIXQA9//VKwn0aZiEIlq91SmPT2rWQNtS84V
         Q68fqayb2A/WL16JRR2Aa+mQDBdItxQp+zeXlYvbrg64X3Q5G9on5nqz+MGUpTDAvHFz
         sBSbQh6yoQFr8xaVD3/sq1MpISH5rasI9VCXsvHS64adtekqA6fqRDbF9wrSowcNHUns
         5bjjGIUll3oIH67z1VPa8xj3rzc/KKMPlNEmwVgJtyU2TXOEeXyiQVTsbWSfoPtLJk3u
         jqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733638028; x=1734242828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSPTXbUKfNMinNGM5rUhYOdHvCQ+TR4BofaMXjdRcsM=;
        b=MopQ35bntCqCSEYH0lSy/Nf0k6PlyKzYjex8L3eostaDma+yx5fa10N7lI8YA3rw1C
         QIXmhAj1JLevdQ2B5A2h/vn7IB6EVCaAaf3uohmH46nNOF33TFudlp+aasXeGDtTvXJW
         23HlI8RgMk8EZpfYB6rDYLZRo2hxYtNE+aoKQfpT/l+d3l1NlwYQWq7CosZ1CiikGa7s
         lbRxZXmZPJ+rEB6cokiFJwp6OgioJmYGi01hLclmKm8KGTx8BWsp+6+l2iDHnK3QwHgw
         CM9PJVjXfS9WSpMi4LB3+2xi1qavshrWOFOuBKebJd3rP9NKsLcUZ7MjIw2yQtkDWqpr
         9A/w==
X-Forwarded-Encrypted: i=1; AJvYcCUOPic+RUfrM12FI8G8M9bOZ5bCkSS31dCp1h/Ow8oyGM6CkDiHwRZlZVS043jIJjRJEz2dFLXwDp2t6kgr@vger.kernel.org, AJvYcCXQw10OWaMIbXlDM3/kb/P8YTQiBghhdBxVbv8Q9ieI4I9PS+c8Jv/DLWDFNkD7eKZUKZZvRWIdvcCtieom@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ3uLsWCu6BO/ZGrs1CMBaljtf8zgOIRFsw19N4iNfFoO5FeX0
	yGbEBXUAubMvXwX1oWHhw1cKTe4qbEkyuN5RtNVDl+UYw7rhmwtVsGXsXGDH0qVsPwSUMqAm3Yr
	dx0Si2qrw5Qm98/9J6XHsxYfAfZM=
X-Gm-Gg: ASbGncuYT8J2DSEKo9sdJWHAcWu/+KuSYy8mTwZoFf6nkMJ9esy99LPDaR3RWuMpr30
	AwOhg2vX7/dZXqaaCAFFigh9F3kvM0j+7DW6SeQyNnKw9IC1LJkFppQf7rluh2kIlKA==
X-Google-Smtp-Source: AGHT+IFaPx1ArJ8bw8oS0nlBiWKl9Rx/s/UMqsFt9vtSHnk58MZH85TiZg9/plcZYTWgcXJcRIVj0qn+rK9ooAje8HM=
X-Received: by 2002:a05:6122:829d:b0:516:1582:f72e with SMTP id
 71dfb90a1353d-5161582f8e1mr3615505e0c.2.1733638028187; Sat, 07 Dec 2024
 22:07:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203134949.2588947-1-haowenchao22@gmail.com>
 <926c6f86-82c6-41bb-a24d-5418163d5c5e@redhat.com> <CABzRoyZOJJKWyx4Aj0CQ17Om3wZPixJYMgZ24VSVQ5BRh2EdJw@mail.gmail.com>
In-Reply-To: <CABzRoyZOJJKWyx4Aj0CQ17Om3wZPixJYMgZ24VSVQ5BRh2EdJw@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sun, 8 Dec 2024 14:06:57 +0800
Message-ID: <CAGsJ_4z_nQXrnjWFODhhNPW4Q0KjeF+p+bXL5D0=CxskWo1_Jg@mail.gmail.com>
Subject: Re: [PATCH] smaps: count large pages smaller than PMD size to anonymous_thp
To: Lance Yang <ioworker0@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, Wenchao Hao <haowenchao22@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Oscar Salvador <osalvador@suse.de>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, Peter Xu <peterx@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 7:16=E2=80=AFPM Lance Yang <ioworker0@gmail.com> wro=
te:
>
> On Tue, Dec 3, 2024 at 10:17=E2=80=AFPM David Hildenbrand <david@redhat.c=
om> wrote:
> >
> > On 03.12.24 14:49, Wenchao Hao wrote:
> > > Currently, /proc/xxx/smaps reports the size of anonymous huge pages f=
or
> > > each VMA, but it does not include large pages smaller than PMD size.
> > >
> > > This patch adds the statistics of anonymous huge pages allocated by
> > > mTHP which is smaller than PMD size to AnonHugePages field in smaps.
> > >
> > > Signed-off-by: Wenchao Hao <haowenchao22@gmail.com>
> > > ---
> > >   fs/proc/task_mmu.c | 6 ++++++
> > >   1 file changed, 6 insertions(+)
> > >
> > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > index 38a5a3e9cba2..b655011627d8 100644
> > > --- a/fs/proc/task_mmu.c
> > > +++ b/fs/proc/task_mmu.c
> > > @@ -717,6 +717,12 @@ static void smaps_account(struct mem_size_stats =
*mss, struct page *page,
> > >               if (!folio_test_swapbacked(folio) && !dirty &&
> > >                   !folio_test_dirty(folio))
> > >                       mss->lazyfree +=3D size;
> > > +
> > > +             /*
> > > +              * Count large pages smaller than PMD size to anonymous=
_thp
> > > +              */
> > > +             if (!compound && PageHead(page) && folio_order(folio))
> > > +                     mss->anonymous_thp +=3D folio_size(folio);
> > >       }
> > >
> > >       if (folio_test_ksm(folio))
> >
> >
> > I think we decided to leave this (and /proc/meminfo) be one of the last
> > interfaces where this is only concerned with PMD-sized ones:
> >
> > Documentation/admin-guide/mm/transhuge.rst:
> >
> > The number of PMD-sized anonymous transparent huge pages currently used=
 by the
> > system is available by reading the AnonHugePages field in ``/proc/memin=
fo``.
> > To identify what applications are using PMD-sized anonymous transparent=
 huge
> > pages, it is necessary to read ``/proc/PID/smaps`` and count the AnonHu=
gePages
> > fields for each mapping. (Note that AnonHugePages only applies to tradi=
tional
> > PMD-sized THP for historical reasons and should have been called
> > AnonHugePmdMapped).
>
> Yeah, I think we need to keep AnonHugePages unchanged within these interf=
aces
> due to historical reasons ;)
>
> Perhaps, there might be another way to count all THP allocated for each p=
rocess.

My point is that counting the THP allocations per process doesn't seem
as important
when compared to the overall system's status. We already have
interfaces to track
the following:

* The number of mTHPs allocated or fallback events;
* The total number of anonymous mTHP folios in the system.
* The total number of partially unmapped mTHP folios in the system.

To me, knowing the details for each process doesn=E2=80=99t seem particular=
ly
critical for
profiling.  To be honest, I don't see a need for this at all, except perhap=
s for
debugging to verify if mTHP is present.

If feasible, we could explore converting Ryan's Python script into a native
C program. I believe this would be more than sufficient for embedded system=
s
and Android.

>
> Thanks,
> Lance
>
>
> >
> >
> >
> > --
> > Cheers,
> >
> > David / dhildenb

Thanks
Barry


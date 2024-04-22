Return-Path: <linux-fsdevel+bounces-17409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 650E48AD07D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 17:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E40511F21B3B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 15:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A488152E1F;
	Mon, 22 Apr 2024 15:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXSm9DE+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BE8152180;
	Mon, 22 Apr 2024 15:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799240; cv=none; b=L2/MRJ1PwwT1fAt3mrpwK3b+gGpx+OHbQUkaYm8ADrHEyftlCeUnj8BYqOv8gcA2vE2qFLU6CfBZfT2Kg+44vHC2O5p513d60RIVXgToW5ZAWilEuJeaLxHvrKj5oVwemGMDKfZqu6undKmfPaKgIhXsBZwYYk+jQxB9qu4jeps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799240; c=relaxed/simple;
	bh=Mwaw02jUeFGzhexemdEHDycW4vgz4Ywj3HSwss/wKGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OXgYMy4eSSPBjSUm+TIl75/u+rN4rG8xqmrJm9NrHxHS5BOgrpjhWfhzyXa8FYECBPqX4wH2QuqcIWA7y4fnDaiVjui3xseGnLm81ztDCafsiNrlwbXEwBVCu15MQ6YG0zFH/UFfYt/iBxlOv+wguWKtzKzb8n29/B7OGYDCkl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXSm9DE+; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2dde561f852so2800461fa.2;
        Mon, 22 Apr 2024 08:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713799236; x=1714404036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vuzvRER/eRgyRC6zF+Dn/+Ln6gq/IXAuegKQubeLgkk=;
        b=NXSm9DE+8j9PA5Kz40ujPfl8k10XRD4Sv9DuAKZRSKLtTvK/dYoxI27vyY38RK0gM9
         85R0j4AAvVi/UbwEFfFCd0I/Esy+EdTDPfuJK/YNOEyHOrueidKoUUCfCYfW6fD+l1SB
         elJCSp2g/p58ZxMrrp51DMtkBFb/pFloe0yXKUPir1+8COKQGfpA+Ym4YVgXcJrtsx8g
         vM+3WGj9iSij/h3iCqzBSUMmI0Bss+brXc0IXcVZZ7bmKd4OCDZ02PK7GzkDl57tqYNZ
         D3LcSB/8BIsyv6prffLdqfgWZrVeLkvXDhYTxjEybhXKERl1WzWPmllgJQsCmtHMzyFz
         fAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713799236; x=1714404036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vuzvRER/eRgyRC6zF+Dn/+Ln6gq/IXAuegKQubeLgkk=;
        b=hzBTB/72bEhBGfbY7Ovj74TYPbQSCZBt7YK/4tRP0ZFPXmLR17q9d8moNQIqEURG6X
         pQc7MkrGFOueGO8hTomsw4thH1mtK5PpmeJvN0sjCbiU2wswEecXTmHFE8eniQAGgdjb
         dQLDo78eIbeD8ynDrBGzHymjdZwpeAPLIpXRYToZgNo3SXG/ITxTJrII1wTfil87kmX6
         /2dG4RR6o6kZz7zi9G/mTvPHXPaze0QzML+XPXLzCPGuV8YLGdVEn0vqIFds9k2D8ejO
         63+wzHIDnI5Vdg53fgF2/a1gnUpsz+7E3fo7e06rvfY7JWZTggsS5+7Ar1H1GvTzxByT
         8oMg==
X-Forwarded-Encrypted: i=1; AJvYcCVyuFZu1SYn+VE4Qj2okfJVe4fcic+ctihOUx8T68PuvsELO8aYF3rcvMBeFoeNa7ZUCHln5EyO3sdSb8xznOQ3Dsc2xaoKX96xzI5fp3NDRMSZRlVDcTxLHbnnzndEmxQ2AtEjDVQSYEE3+g==
X-Gm-Message-State: AOJu0YxsUzRX9QCyQRD+tNNteFTu8WOIHY1H7Ng7WoI33DYcwC0zKfEW
	/Mb3zibvYnaS+7CEuEp2SFMeau5+OYP63RubEvbXpGSU7NR98xGk26/YDiHQNKrLNTLDykhi6cE
	H8cFD3G3bnWRJZz2fjt1z2Bf2PQs=
X-Google-Smtp-Source: AGHT+IGmn/mToNtPSu8NqpDUFrNYhzadt7vHWmwuQWYgdxJO4KVqIZ51GyywFjqOjpCMtpoxvPmrN5nQYIoT0qz/nL4=
X-Received: by 2002:a2e:97d4:0:b0:2d8:74c6:c44c with SMTP id
 m20-20020a2e97d4000000b002d874c6c44cmr6429232ljj.46.1713799236152; Mon, 22
 Apr 2024 08:20:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417160842.76665-1-ryncsn@gmail.com> <87zftlx25p.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87zftlx25p.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 22 Apr 2024 23:20:19 +0800
Message-ID: <CAMgjq7B1YTrvZOrnbtVYfVMVAmtMkkwiqcqc1AGup4=gvgxKhQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] mm/swap: optimize swap cache search space
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Barry Song <v-songbaohua@oppo.com>, Ryan Roberts <ryan.roberts@arm.com>, Neil Brown <neilb@suse.de>, 
	Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 3:56=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Hi, Kairui,
>
> Kairui Song <ryncsn@gmail.com> writes:
>
> > From: Kairui Song <kasong@tencent.com>
> >
> > Currently we use one swap_address_space for every 64M chunk to reduce l=
ock
> > contention, this is like having a set of smaller swap files inside one
> > big swap file. But when doing swap cache look up or insert, we are
> > still using the offset of the whole large swap file. This is OK for
> > correctness, as the offset (key) is unique.
> >
> > But Xarray is specially optimized for small indexes, it creates the
> > redix tree levels lazily to be just enough to fit the largest key
> > stored in one Xarray. So we are wasting tree nodes unnecessarily.
> >
> > For 64M chunk it should only take at most 3 level to contain everything=
.
> > But we are using the offset from the whole swap file, so the offset (ke=
y)
> > value will be way beyond 64M, and so will the tree level.
> >
> > Optimize this by reduce the swap cache search space into 64M scope.
>

Hi,

Thanks for the comments!

> In general, I think that it makes sense to reduce the depth of the
> xarray.
>
> One concern is that IIUC we make swap cache behaves like file cache if
> possible.  And your change makes swap cache and file cache diverge more.
> Is it possible for us to keep them similar?

So far in this series, I think there is no problem for that, the two
main helpers for retrieving file & cache offset: folio_index and
folio_file_pos will work fine and be compatible with current users.

And if we convert to share filemap_* functions for swap cache / page
cache, they are mostly already accepting index as an argument so no
trouble at all.

>
> For example,
>
> Is it possible to return the offset inside 64M range in
> __page_file_index() (maybe rename it)?

Not sure what you mean by this, __page_file_index will be gone as we
convert to folio.
And this series did delete / rename it (it might not be easy to see
this, the usage of these helpers is not very well organized before
this series so some clean up is involved).
It was previously only used through page_index (deleted) /
folio_index, and, now folio_index will be returning the offset inside
the 64M range.

I guess I just did what you wanted? :)

My cover letter and commit message might be not clear enough, I can update =
it.

>
> Is it possible to add "start_offset" support in xarray, so "index"
> will subtract "start_offset" before looking up / inserting?

xarray struct seems already very full, and this usage doesn't look
generic to me, might be better to fix this kind of issue case by case.

>
> Is it possible to use multiple range locks to protect one xarray to
> improve the lock scalability?  This is why we have multiple "struct
> address_space" for one swap device.  And, we may have same lock
> contention issue for large files too.

Good question, this series can improve the tree depth issue for swap
cache, but contention in address space is still a thing.

A more generic solution might involve changes of xarray API or use
some other data struct?

(BTW I think reducing the search space and resolving lock contention
is not necessarily related, reducing the search space by having a
large table of small trees should still perform better for swap
cache).


>
> I haven't look at the code in details.  So, my idea may not make sense
> at all.  If so, sorry about that.
>
> Hi, Matthew,
>
> Can you teach me on this too?
>
> --
> Best Regards,
> Huang, Ying


Return-Path: <linux-fsdevel+bounces-54317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9213AFDBBE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 01:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E59543D8C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 23:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083E12356BC;
	Tue,  8 Jul 2025 23:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZC38BcJS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABAF1E3769
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Jul 2025 23:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752016511; cv=none; b=UmGKmitvD1dha9m8GyTlsoHyu98tcAL4I2sSjEYvrRkOPQS1YwVKN/k/0XNHz+/vc6yPavdk0Qcr3I9dBruQdr+Gw+L6Iw9jlhsCdtbjTaZ2Hv/nCiemP908rSbnCnWL8eXWUpVPvO+mu+F67Smb+7xAWsUCMRsRq2s1otcCJ3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752016511; c=relaxed/simple;
	bh=6Eu40jmSSl87TzHXCV8fLZM4w3xyD6UMj4m0WWtFpf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oWCgPlLgXo07OSAB8Db7FdF940eaQR6OPjVSFRLC957GzOn1wl6knaxLZaTL6DM/LbvTbhnYbYmLRNjHrybtU+LAnuLS2lHDqmbkWc+JLOELt6/wRSjs9ecuSmQvfpO20hA2vr9Kzv3G5ooT9uxfXbIasBVuZx5LOA7W210tois=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZC38BcJS; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a7a8c2b7b9so69900211cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Jul 2025 16:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752016508; x=1752621308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eBx0owOYpwGOKh8OaySOaQMI1WoSyYvLwAVsqsUVC5w=;
        b=ZC38BcJS2yOwVRQys5qbTyykc1AfGZ6NBFO3kdd9zvUEGbsg8RMNWfQszYDU96KGu1
         PaSWssXvt4ngAAmKaxWHGjCYT1N4dRfiD4j917ldvktMFqIdT9l+I5PBbmsLJJREX0K1
         w/u93G3igewiCurJEaeF+Nk6Zr5Eog/ezxWzblxqvoWf1UAm4vrEOSZn9Sw1GyFcTnKz
         9hBEyUjunKDry6+t52vjxoeL8ptgNXF3KjjZHK8AJu/52YwYi5+1VFW5jQDK8N4+JFnB
         GrvVcc5xISTvavzQS3nNXmFfZG73sylYr6DqGpmfms4s6feo2HvKRgJGHSbNFwCja+fb
         jKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752016508; x=1752621308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eBx0owOYpwGOKh8OaySOaQMI1WoSyYvLwAVsqsUVC5w=;
        b=oQdAK8L6T5kt9GDYLHji54hQU9bnaRxo6d9/H7xjBSpAzFCxoqN6oyjaMCdiQQbuce
         9W73dVxsWMP/urlqembrgM0FZ3PpQuXB7EkyNK/FWrZjJn51X5qaNvxe3Wv4o7yWE75o
         H8RO6YTCrXC0H7HFPUpC/cY8xHltX5hSPbwkwNA+AzsBV0SXNT2uOq+ieNToJZ1Us2Ug
         LjZvBW3L52mV7W+VALryBSTh5SD7ex0OBjHDUVnL6YtC4n6RXoWS1RYF9bTTpY7DMzWS
         f7YQ0gzvst8ZnWhnDap06P/mZ9FA3o+0YmkN/nKW542DYWe9YECV1oMxjgXpjk5iHfuG
         X7Yw==
X-Forwarded-Encrypted: i=1; AJvYcCXxzHOi5tFsknwdhmJya21edCBk7CyF2O7boLNCvD8YMG7Payc4J9Hp5nAgC3fGNTuiP/n+aCMbq6Drf7Xo@vger.kernel.org
X-Gm-Message-State: AOJu0YzCf8cMca5+OXor9pDnSkMWP7mvuKeit2MF8hswFOSSoyFhoEFO
	J1MZqMvUf0KfT3yLbVB9E4OyxU3nuuQg/kPM/aYRrlP3DAVjkIpLcv7dpn/SkxblK+uYI5bDcqd
	URMyKe/b8W/u1EcGBoyB9Ni3w2HeIuRE=
X-Gm-Gg: ASbGncvIg8x0Rjd7VgOpS4cuQHTldOedoByX9WIglQWqoovGbJrrLSWYARNntnILI05
	hVcWRU+aUAXfdOACU/GEsEN9ZZB9eUqyNFycZnMTcVrC+stx4X+jG4F7ytdDhZFsj18HO/kdORo
	bWcgfY8JyH1HKcZtNEQAnXwremSyrE7oh7ZqTpRtU/TEg=
X-Google-Smtp-Source: AGHT+IFvc0gyRZl92jExTxWSYxXBA3Ze2NAhf79YPt/xxMJs7uYz1PUztrdw6QbRURCGhiRr2lQ4rJhGly07vVjC+Ik=
X-Received: by 2002:a05:622a:1492:b0:4a9:9695:63fc with SMTP id
 d75a77b69052e-4a9ded40747mr4382651cf.42.1752016508395; Tue, 08 Jul 2025
 16:15:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250426000828.3216220-1-joannelkoong@gmail.com>
 <20250426000828.3216220-11-joannelkoong@gmail.com> <6d9c08dd-c1d0-48bd-aacb-b4300f87d525@redhat.com>
 <CAJnrk1bTe88hy4XSkj1RSC4r+oA=VZ-=jKymt7uoB1q75KZCYg@mail.gmail.com> <9a9cea9e-82e7-4411-8927-8ac911b2eb06@redhat.com>
In-Reply-To: <9a9cea9e-82e7-4411-8927-8ac911b2eb06@redhat.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 8 Jul 2025 16:14:57 -0700
X-Gm-Features: Ac12FXyKPmKtcfjzTJXt8Kr5wiVk1ENmQcVl35VR--7sSKYk65-V4pU1XJXOB_M
Message-ID: <CAJnrk1Y+FYV+DWpgo_WsmDH2SzGmEzW+ParZGH5v2NOpqOP5tQ@mail.gmail.com>
Subject: Re: [PATCH v5 10/11] fuse: optimize direct io large folios processing
To: David Hildenbrand <david@redhat.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, jlayton@kernel.org, 
	jefflexu@linux.alibaba.com, josef@toxicpanda.com, bernd.schubert@fastmail.fm, 
	willy@infradead.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 9:05=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 08.07.25 01:27, Joanne Koong wrote:
> > On Fri, Jul 4, 2025 at 3:24=E2=80=AFAM David Hildenbrand <david@redhat.=
com> wrote:
> >>
> >> On 26.04.25 02:08, Joanne Koong wrote:
> >>> Optimize processing folios larger than one page size for the direct i=
o
> >>> case. If contiguous pages are part of the same folio, collate the
> >>> processing instead of processing each page in the folio separately.
> >>>
> >>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> >>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> >>> ---
> >>>    fs/fuse/file.c | 55 +++++++++++++++++++++++++++++++++++++---------=
----
> >>>    1 file changed, 41 insertions(+), 14 deletions(-)
> >>>
> >>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> >>> index 9a31f2a516b9..61eaec1c993b 100644
> >>> --- a/fs/fuse/file.c
> >>> +++ b/fs/fuse/file.c
> >>> @@ -1490,7 +1490,8 @@ static int fuse_get_user_pages(struct fuse_args=
_pages *ap, struct iov_iter *ii,
> >>>        }
> >>>
> >>>        while (nbytes < *nbytesp && nr_pages < max_pages) {
> >>> -             unsigned nfolios, i;
> >>> +             struct folio *prev_folio =3D NULL;
> >>> +             unsigned npages, i;
> >>>                size_t start;
> >>>
> >>>                ret =3D iov_iter_extract_pages(ii, &pages,
> >>> @@ -1502,23 +1503,49 @@ static int fuse_get_user_pages(struct fuse_ar=
gs_pages *ap, struct iov_iter *ii,
> >>>
> >>>                nbytes +=3D ret;
> >>>
> >>> -             nfolios =3D DIV_ROUND_UP(ret + start, PAGE_SIZE);
> >>> +             npages =3D DIV_ROUND_UP(ret + start, PAGE_SIZE);
> >>>
> >>> -             for (i =3D 0; i < nfolios; i++) {
> >>> -                     struct folio *folio =3D page_folio(pages[i]);
> >>> -                     unsigned int offset =3D start +
> >>> -                             (folio_page_idx(folio, pages[i]) << PAG=
E_SHIFT);
> >>> -                     unsigned int len =3D min_t(unsigned int, ret, P=
AGE_SIZE - start);
> >>> +             /*
> >>> +              * We must check each extracted page. We can't assume e=
very page
> >>> +              * in a large folio is used. For example, userspace may=
 mmap() a
> >>> +              * file PROT_WRITE, MAP_PRIVATE, and then store to the =
middle of
> >>> +              * a large folio, in which case the extracted pages cou=
ld be
> >>> +              *
> >>> +              * folio A page 0
> >>> +              * folio A page 1
> >>> +              * folio B page 0
> >>> +              * folio A page 3
> >>> +              *
> >>> +              * where folio A belongs to the file and folio B is an =
anonymous
> >>> +              * COW page.
> >>> +              */
> >>> +             for (i =3D 0; i < npages && ret; i++) {
> >>> +                     struct folio *folio;
> >>> +                     unsigned int offset;
> >>> +                     unsigned int len;
> >>> +
> >>> +                     WARN_ON(!pages[i]);
> >>> +                     folio =3D page_folio(pages[i]);
> >>> +
> >>> +                     len =3D min_t(unsigned int, ret, PAGE_SIZE - st=
art);
> >>> +
> >>> +                     if (folio =3D=3D prev_folio && pages[i] !=3D pa=
ges[i - 1]) {
> >>
> >> I don't really understand the "pages[i] !=3D pages[i - 1]" part.
> >>
> >> Why would you have to equal page pointers in there?
> >>
> >
> > The pages extracted are user pages from a userspace iovec. AFAICT,
> > there's the possibility, eg if userspace mmaps() the file with
> > copy-on-write, that the same physical page could back multiple
> > contiguous virtual addresses.
>
> Yes, I but I was rather curious why that would be a condition we are
> checking. It's quite the ... corner case :)
>

Agreed, definitely the corner case :)

In the fuse code, later on when the buffer gets copied to/from the
server, it'll use ap->descs[index].length as the number of bytes to
copy. If we don't check for this duplicate page corner case, then
it'll copy the wrong offsets in the folio, which may even lead to a
page fault if the folio is only one page. This buffer copying logic if
you're curious happens in fuse_copy_args() -> fuse_copy_folios() ->
fuse_copy_folio().

> >
> >>
> >> Something that might be simpler to understand and implement would be u=
sing
> >>
> >>          num_pages_contiguous()
> >>
> >> from
> >>
> >>          https://lore.kernel.org/all/20250704062602.33500-2-lizhe.67@b=
ytedance.com/T/#u
> >>
> >> and then just making sure that we don't exceed the current folio, if w=
e
> >> ever get contiguous pages that cross a folio.
> >
> > Thanks for the link. I think here it's common that the pages array
> > would hold pages from multiple different folios, so maybe a new helper
> > num_pages_contiguous_folio() would be useful to return back the number
> > of contiguous pages that are within the scope of the same folio.
>
> Yes, something like that can be useful.
>
> --
> Cheers,
>
> David / dhildenb
>
>


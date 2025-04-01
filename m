Return-Path: <linux-fsdevel+bounces-45415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51329A77520
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 09:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8D2D3A5AA0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 07:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23CD1E98F8;
	Tue,  1 Apr 2025 07:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1+dcLU2X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680681E832E
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Apr 2025 07:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743492003; cv=none; b=ktiF32m5c2pHrcfQAgMAc/r6ZI/TvyvQpJFU8gcyh/+FZaOw8uElR/r8rAS+jFCJyZXFbuByOaKdXXDJu071e7HDAwDFlbVegCKo5eWNsg1cfZB+nTuXdddnrW9rD7EWlMC4++wGK2kCxjFwglhib6Fm62Gw/9Athp8Qdb+ODqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743492003; c=relaxed/simple;
	bh=k/2TAvDo0gcJpXNztWOeZx7SFFzYikRx8NQ+o8K3F9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TYLV5qZFMdn6Z0PiSBlC9HJWxrKcgRH/063gQ225fgbZP1gOoX7qfel4uMdQ/tUJjPQVMWutuqdB2M0eFdV8IZAm8PhKYrBNKhQva5GO8Mas+HA0L98XKNa9HydZhcOCYv6I7/eazyromqXtL6c73x6LHARjN9tu1Py86rt5yY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1+dcLU2X; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2240aad70f2so149945ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Apr 2025 00:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743492000; x=1744096800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4nNzjFLlX0hgN8AxePGDE9S1lJ4kGFRD5jIQ7N2ASbw=;
        b=1+dcLU2X+4dcEYJPN91EFfZVmau8zJXAW5z/v7N+Ksih71rAQ84V2x7Zbsvmu7x5i7
         d2S6SvMF71ZkVZi6bf+M8HqQVrIMA8VTlkYDOBMnJV7e/l8VFpU3h2Lb1O8e3HVhPdKC
         IFoaMAcyCJ//Lqq5eg55vyVbbixgAEJHlPgunJD5bFzHlV7ku2hWbGzgZbBJQa5na8Fc
         QFw/ttga4wMs4ZRiemyv2WvTgV/rs+250V214P/tC9U3R/QVVSZawkN5Dpr36YtU3ySN
         jwjmbuTCdhDLvSQhjDAHs/cd74Mi8LkyrNUbCfcArsc9f5VMc8hjBBZGM9eVY6ARxEIE
         6dTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743492000; x=1744096800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4nNzjFLlX0hgN8AxePGDE9S1lJ4kGFRD5jIQ7N2ASbw=;
        b=D32Irg0/PbN5ovkDaoMI6L04ZyvXeHeMI8sYPw0zrEu7dXa3Mu0kcDIAW9jaDV5EdG
         pa9JLLuCIw0vaDQ7woA9edcJrZyvrKPhzISZX69aXxTZul6MWRP3rthc26JgEMqy5+66
         xodppfrtZcfgvwFVEN8GKW8oP2xjXJg8mZCCpJmT1MFCptukFR7hBwGRzg8aOpsQ9MeH
         iRryrnIBbpp8FeGfz3KsuqFYaiSwlsgTTdC4fJwKA3EAYUiGJXSVNRYjxXbE4i/gsimr
         FwNjFek+HUfsIvql8lAkbuGmGCP88amw7i/WcebKaEVg6KSWMztiElUWV1BkeCI5uC7S
         bC1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzlb0tAEpGF1WZ2oh1HB9LOxwI8eeqdpDTVv6qwRml0Y6ECiOcoKJs/DZyPoOGU/xAhIpEeUd/Pt9rYJKU@vger.kernel.org
X-Gm-Message-State: AOJu0YxFycr94GzGTzZF7hZYJW1xgF6WOOoT1mPCGbQQWbdguou7fxYT
	vqijX+LzUM+a4KOOwS7rvzUX832A+jXrX6LaUq+I6lM9D458s9JeNwxJSKB7JtkzY3HHDNF+QPd
	0dFILH97om1CmcJjGJ7ovtMQ6suShJxaiuPg/
X-Gm-Gg: ASbGncvJnMjEIYIKxYQDJI9i3j3keQVO2TlySsjHm9yq77p7CWrLp58AGgK3l0/OWMw
	rcKBItdyEyMM0GsAjtUHXTzIrtn9EfvSXhX+eceWHWh/U5qcaKotqO7Xw+LKywgZvgUcFsn7ovl
	jZaZy6+3atacxJeWPHWhraAUDFgwmy9P9RswBr6sMjgcNZLVutaU2TjatvSQ==
X-Google-Smtp-Source: AGHT+IEnyvd6es/zpWvt015PkcGKvZjgaAm/HA1x1p4f9qCEGneOY3x1NVAjuNd8D9r0AfQw3N5WD9kqvto64BkWnIM=
X-Received: by 2002:a17:902:d2c6:b0:21f:3e29:9cd1 with SMTP id
 d9443c01a7336-2295cfe6b1bmr1720245ad.1.1743492000201; Tue, 01 Apr 2025
 00:20:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327160700.1147155-1-ryan.roberts@arm.com>
 <Z-WAbWfZzG1GA-4n@casper.infradead.org> <5131c7ad-cc37-44fc-8672-5866ecbef65b@arm.com>
 <Z-b1FmZ5nHzh5huL@casper.infradead.org> <ee11907a-5bd7-44ec-844c-8f10ff406b46@arm.com>
In-Reply-To: <ee11907a-5bd7-44ec-844c-8f10ff406b46@arm.com>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Tue, 1 Apr 2025 00:19:48 -0700
X-Gm-Features: AQ5f1JrGGiC_D0IIoE2ouih3ARQNGmoqFS-gJpqf2fABIUInDzCxtOi5p0Pa9A4
Message-ID: <CAC_TJveU2v+EcokLKJVVZ8Xje2nYmmUg8bvCD8KO1oC5MgmWCA@mail.gmail.com>
Subject: Re: [PATCH v3] mm/filemap: Allow arch to request folio size for exec memory
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Dave Chinner <david@fromorbit.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 29, 2025 at 3:08=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 28/03/2025 15:14, Matthew Wilcox wrote:
> > On Thu, Mar 27, 2025 at 04:23:14PM -0400, Ryan Roberts wrote:
> >> + Kalesh
> >>
> >> On 27/03/2025 12:44, Matthew Wilcox wrote:
> >>> On Thu, Mar 27, 2025 at 04:06:58PM +0000, Ryan Roberts wrote:
> >>>> So let's special-case the read(ahead) logic for executable mappings.=
 The
> >>>> trade-off is performance improvement (due to more efficient storage =
of
> >>>> the translations in iTLB) vs potential read amplification (due to
> >>>> reading too much data around the fault which won't be used), and the
> >>>> latter is independent of base page size. I've chosen 64K folio size =
for
> >>>> arm64 which benefits both the 4K and 16K base page size configs and
> >>>> shouldn't lead to any read amplification in practice since the old
> >>>> read-around path was (usually) reading blocks of 128K. I don't
> >>>> anticipate any write amplification because text is always RO.
> >>>
> >>> Is there not also the potential for wasted memory due to ELF alignmen=
t?
> >>
> >> I think this is an orthogonal issue? My change isn't making that any w=
orse.
> >
> > To a certain extent, it is.  If readahead was doing order-2 allocations
> > before and is now doing order-4, you're tying up 0-12 extra pages which
> > happen to be filled with zeroes due to being used to cache the contents
> > of a hole.
>
> Well we would still have read them in before, nothing has changed there. =
But I
> guess your point is more about reclaim? Because those pages are now conta=
ined in
> a larger folio, if part of the folio is in use then all of it remains act=
ive.
> Whereas before, if the folio was fully contained in the pad area and neve=
r
> accessed, it would fall down the LRU quickly and get reclaimed.
>


Hi Ryan,

I agree this was happening before and we don't need to completely
address it here. Though with the patch it's more likely that the holes
will be cached. I'd like to minimize it if possible. Since this is for
EXEC mappings, a simple check we could use is to limit this to the
VM_EXEC vma.

+ if (vm_flags & VM_EXEC) {
+ int order =3D arch_exec_folio_order();
+
+ if (order >=3D 0 && ((end-address)*2) >=3D 1<<order) { /* Fault around ca=
se */

For reference I found below (coincidentally? similar) distributions on
my devices

=3D=3D x86 Workstation =3D=3D

Total unique exec segments:   906

Exec segments >=3D 16 KB:   663 ( 73.18%)
Exec segments >=3D 64 KB:   414 ( 45.70%)

=3D=3D arm64 Android Device =3D=3D

Total unique exec segments:   2171

Exec segments >=3D 16 KB:  1602 ( 73.79%)
Exec segments >=3D 64 KB:   988 ( 45.51%)

Result were using the below script:

cat /proc/*/maps | grep 'r-xp' | \
awk '
BEGIN { OFS =3D "\t" }
$NF ~ /^\// {
path =3D $NF;
split($1, addr, "-");
size =3D strtonum("0x" addr[2]) - strtonum("0x" addr[1]);
print size, path;
}' | \
sort -u | \
awk '
BEGIN {
FS =3D "\t";
total_segments =3D 0;
segs_ge_16k =3D 0;
segs_ge_64k =3D 0;
}
{
total_segments++;
size =3D $1;
if (size >=3D 16384) segs_ge_16k++;
if (size >=3D 65536) segs_ge_64k++;
}
END {
if (total_segments > 0) {
percent_gt_16k =3D (segs_ge_16k / total_segments) * 100;
percent_gt_64k =3D (segs_ge_64k / total_segments) * 100;

printf "Total unique exec segments: %d\n", total_segments;
printf "\n";
printf "Exec segments >=3D 16 KB: %5d (%6.2f%%)\n", segs_ge_16k, percent_gt=
_16k;
printf "Exec segments >=3D 64 KB: %5d (%6.2f%%)\n", segs_ge_64k, percent_gt=
_64k;
} else {
print "No executable segments found.";
}
}'

> >
> >>> Kalesh talked about it in the MM BOF at the same time that Ted and I
> >>> were discussing it in the FS BOF.  Some coordination required (like
> >>> maybe Kalesh could have mentioned it to me rathere than assuming I'd =
be
> >>> there?)
> >>
> >> I was at Kalesh's talk. David H suggested that a potential solution mi=
ght be for
> >> readahead to ask the fs where the next hole is and then truncate reada=
head to
> >> avoid reading the hole. Given it's padding, nothing should directly fa=
ult it in
> >> so it never ends up in the page cache. Not sure if you discussed anyth=
ing like
> >> that if you were talking in parallel?
> >
> > Ted said that he and Kalesh had talked about that solution.  I have a
> > more bold solution in mind which lifts the ext4 extent cache to the
> > VFS inode so that the readahead code can interrogate it.
> >

Sorry about the hiccup in coordination, Matthew. It was my bad for not
letting you know I planned to discuss it in the MM BoF. I'd like to
hear Ted and your ideas on this when possible.

Thanks,
Kalesh

> >> Anyway, I'm not sure if you're suggesting these changes need to be con=
sidered as
> >> one somehow or if you're just mentioning it given it is loosely relate=
d? My view
> >> is that this change is an improvement indepently and could go in much =
sooner.
> >
> > This is not a reason to delay this patch.  It's just a downside which
> > should be mentioned in the commit message.
>
> Fair point; I'll add a paragraph about the potential reclaim issue.
>
> >
> >>>> +static inline int arch_exec_folio_order(void)
> >>>> +{
> >>>> +  return -1;
> >>>> +}
> >>>
> >>> This feels a bit fragile.  I often expect to be able to store an orde=
r
> >>> in an unsigned int.  Why not return 0 instead?
> >>
> >> Well 0 is a valid order, no? I think we have had the "is order signed =
or
> >> unsigned" argument before. get_order() returns a signed int :)
> >
> > But why not always return a valid order?  I don't think we need a
> > sentinel.  The default value can be 0 to do what we do today.
> >
>
> But a single order-0 folio is not what we do today. Note that my change a=
s
> currently implemented requests to read a *single* folio of the specified =
order.
> And note that we only get the order we request to page_cache_ra_order() b=
ecause
> the size is limited to a single folio. If the size were bigger, that func=
tion
> would actually expand the requested order by 2. (although the parameter i=
s
> called "new_order", it's actually interpretted as "old_order").
>
> The current behavior is effectively to read 128K in order-2 folios (with =
smaller
> folios for boundary alignment).
>
> So I see a few options:
>
>   - Continue to allow non-opted in arches to use the existing behaviour; =
in this
> case we need a sentinel. This could be -1, UINT_MAX or 0. But in the latt=
er case
> you are preventing an opted-in arch from specifying that they want order-=
0 -
> it's meaning is overridden.
>
>   - Force all arches to use the new approach with a default folio order (=
and
> readahead size) of order-0. (The default can be overridden per-arch). Per=
sonally
> I'd be nervous about making this change.
>
>   - Decouple the read size from the folio order size; continue to use the=
 128K
> read size and only allow opting-in to a specific folio order. The default=
 order
> would be 2 (or 0). We would need to fix page_cache_async_ra() to call
> page_cache_ra_order() with "order + 2" (the new order) and fix
> page_cache_ra_order() to treat its order parameter as the *new* order.
>
> Perhaps we should do those fixes anyway (and then actually start with a f=
olio
> order of 0 - which I think you said in the past was your original intenti=
on?).
>
> Thanks,
> Ryan
>


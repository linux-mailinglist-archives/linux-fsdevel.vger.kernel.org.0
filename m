Return-Path: <linux-fsdevel+bounces-45472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B208A781BC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 19:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41D327A40DA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 17:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9869220C00D;
	Tue,  1 Apr 2025 17:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O+PyY+xP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECED1C5F11
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Apr 2025 17:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743530153; cv=none; b=jkSkgq74d8dml1kGbBzCmxdlj/fbclwXtmifhjkzASZ6RfkuNkSa2zJAg7bi8HWISaoak2Vt/U/0a5djCcYdYBJlIIRg8130K3Bki6YfpIFo4TlETn8//uXsFjdTCSrqXzam/o76r+VUifq+wSA0o8UKxE+nomQIcGwEoWBtQg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743530153; c=relaxed/simple;
	bh=7ZL45eO6oHpoyPVq90+nMlQSH41tVCESqt7gfL6dfBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R0TJ7ASsFpcNdJgHiCDNlZAGs3XgAHfHayHoPV9VPGVxBmaXcEzQfs4N/NGLpok2yMImqWaB09UuTMGTWyNYhOaR8byH4ObNwKpVS6Q16aP12DrmOcktEnKW0ruF4QwR8siVNbTFoEAiBg1SVeke8Z6eJ73h3RLXhx+3wvDRMJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O+PyY+xP; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2242ac37caeso15925ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Apr 2025 10:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743530151; x=1744134951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwhXc+3Mv33awoyK00ZHq4pdn0DYvpiatBKGbcRAOA4=;
        b=O+PyY+xPZ1DBJRTIMVw6IWWtb6gGQn9B7pjz7e2tmS0GVmnaUxZhIl3Kw+VdGgBBPE
         nFe/BpqFip7Ok4kZRb7uph3RU31A77xvYsW59b4uY/f24xXJRwVTyYRFfrBEJxCEzQwg
         7zUcTQW6jAR6c4zBzfyLDl5BqD9oa23CDogZzcMtGw14NSiZcdCEsUCSoPuww68tYebH
         ZQqg4cRKSvU8+1TeMyZsRhPjEUEuiMqCwnWkcwJrIbjSfE8/yLbwGofBq5RXLK5lchrm
         obI3DLQ/JGeB50GvSe9Z2uI+2iXRu5/XlH96N8XFgRhNSTVvook6ScgR5Gf4m5/9Uksz
         JOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743530151; x=1744134951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qwhXc+3Mv33awoyK00ZHq4pdn0DYvpiatBKGbcRAOA4=;
        b=c99OTgqZ07XgqdOA/8PCgT44iKWgZavX9cum8sx/WeLF0DO7u1txC16tJO/OiRH6eU
         FBDWomAsZ+taYQMndzM7y6qgkox9Y01immtWdNV4YTw4U0Bg6EWmjm78UctyorPcWF4b
         luHOHp9NYNWkY35SDtCgQpB5smPWQFCAf3WGK3g1OYo6ixN6BNqNeoHOWFDF7WvG//5A
         yQpWi/NedAb7T+AQkVoSYOW+3B7IsS4pYuntico/Mf/HXFWU6WLH+ysw9wx/qH0+O734
         3F+DTkh34oxWYF02D/EvOQDLI7SI9xv7HVsB0Mrd1/Yz/AgLArNIaNzlVkmkm6pO1pAi
         oJSw==
X-Forwarded-Encrypted: i=1; AJvYcCWYt+XpBSmPa7zFmDjrCLxkIJg2V2hciEg13RRvYyX0U9+fMOqy29H2Lyh+1ckWtLssOCt9W92veOvDgP+Z@vger.kernel.org
X-Gm-Message-State: AOJu0YxHA7Nt593dLY1JcS2lZrEVCfku1Rax8fa1BGv73vLO3xxLav88
	gpwOJwKLasqHqIqoVGz4XmXFHy3IQF0T4f6JmDg+1Ljvn4C1ZMmUSHfVZUse35ViuaKbbkirRFY
	xkDycfNcjyeEKmuDP1P0b/e86LTEaGGEJzb9q
X-Gm-Gg: ASbGnctPr64IIHxrcRLuOfuHe6Jl/mcWaMKDAMXgszN1PurNUqfyZg3RdyBnKE8Wuxt
	6jhTOzmhRVcBdM0yJNEuS7yGqfHhVyV4/OX+c8N2nU0HAcW3CVayk8Sm5PKn5aC4/j6FXUZZ3sf
	cM8tDXlp2F3PTZgJzIB17IlGjXNiM1F7tEf0b8zQst6sqRav5yVjwwE8Ae
X-Google-Smtp-Source: AGHT+IE7+lugkQoCFTK/A+4GPe77QGElu8c0EADC3mRhCAQpzpeh+IouIII0n0V1WBWVNUBlMFPnDVuVctKpkGKQbWQ=
X-Received: by 2002:a17:902:dace:b0:215:65f3:27ef with SMTP id
 d9443c01a7336-22969ddb1e2mr140565ad.12.1743530150219; Tue, 01 Apr 2025
 10:55:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327160700.1147155-1-ryan.roberts@arm.com>
 <Z-WAbWfZzG1GA-4n@casper.infradead.org> <5131c7ad-cc37-44fc-8672-5866ecbef65b@arm.com>
 <Z-b1FmZ5nHzh5huL@casper.infradead.org> <ee11907a-5bd7-44ec-844c-8f10ff406b46@arm.com>
 <CAC_TJveU2v+EcokLKJVVZ8Xje2nYmmUg8bvCD8KO1oC5MgmWCA@mail.gmail.com> <76f5ba9b-1a8c-4973-89ce-14f504819da1@arm.com>
In-Reply-To: <76f5ba9b-1a8c-4973-89ce-14f504819da1@arm.com>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Tue, 1 Apr 2025 10:55:38 -0700
X-Gm-Features: AQ5f1Jr2CcyeaoQIJQrpxG5gMN7Sj5YaqmW2gOSH6C-Z8_Xxr2eNEVByBPGBvFo
Message-ID: <CAC_TJvemG2XDky1HtA8g=SG0nv-sONOS-ssEchdymh-_xjBecw@mail.gmail.com>
Subject: Re: [PATCH v3] mm/filemap: Allow arch to request folio size for exec memory
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Dave Chinner <david@fromorbit.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 3:35=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 01/04/2025 03:19, Kalesh Singh wrote:
> > On Sat, Mar 29, 2025 at 3:08=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.=
com> wrote:
> >>
> >> On 28/03/2025 15:14, Matthew Wilcox wrote:
> >>> On Thu, Mar 27, 2025 at 04:23:14PM -0400, Ryan Roberts wrote:
> >>>> + Kalesh
> >>>>
> >>>> On 27/03/2025 12:44, Matthew Wilcox wrote:
> >>>>> On Thu, Mar 27, 2025 at 04:06:58PM +0000, Ryan Roberts wrote:
> >>>>>> So let's special-case the read(ahead) logic for executable mapping=
s. The
> >>>>>> trade-off is performance improvement (due to more efficient storag=
e of
> >>>>>> the translations in iTLB) vs potential read amplification (due to
> >>>>>> reading too much data around the fault which won't be used), and t=
he
> >>>>>> latter is independent of base page size. I've chosen 64K folio siz=
e for
> >>>>>> arm64 which benefits both the 4K and 16K base page size configs an=
d
> >>>>>> shouldn't lead to any read amplification in practice since the old
> >>>>>> read-around path was (usually) reading blocks of 128K. I don't
> >>>>>> anticipate any write amplification because text is always RO.
> >>>>>
> >>>>> Is there not also the potential for wasted memory due to ELF alignm=
ent?
> >>>>
> >>>> I think this is an orthogonal issue? My change isn't making that any=
 worse.
> >>>
> >>> To a certain extent, it is.  If readahead was doing order-2 allocatio=
ns
> >>> before and is now doing order-4, you're tying up 0-12 extra pages whi=
ch
> >>> happen to be filled with zeroes due to being used to cache the conten=
ts
> >>> of a hole.
> >>
> >> Well we would still have read them in before, nothing has changed ther=
e. But I
> >> guess your point is more about reclaim? Because those pages are now co=
ntained in
> >> a larger folio, if part of the folio is in use then all of it remains =
active.
> >> Whereas before, if the folio was fully contained in the pad area and n=
ever
> >> accessed, it would fall down the LRU quickly and get reclaimed.
> >>
> >
> >
> > Hi Ryan,
> >
> > I agree this was happening before and we don't need to completely
> > address it here. Though with the patch it's more likely that the holes
> > will be cached. I'd like to minimize it if possible. Since this is for
> > EXEC mappings, a simple check we could use is to limit this to the
> > VM_EXEC vma.
> >
> > + if (vm_flags & VM_EXEC) {
> > + int order =3D arch_exec_folio_order();
> > +
> > + if (order >=3D 0 && ((end-address)*2) >=3D 1<<order) { /* Fault aroun=
d case */
>
> I think the intent of this extra check is to ensure the folio will be ful=
ly
> contained within the exec vma? Assuming end is the VA of the end of the v=
ma and
> address is the VA of the fault, I don't think the maths are quite right? =
What's
> the "*2" for? And you probably mean PAGE_SIZE<<order ? But this also does=
n't
> account for alignment; the folio will be aligned down to a natural bounda=
ry in
> the file.

Hi Ryan,

Sorry for the pseudocode. You are right it should be PAGE_SIZE. *2 is
because I missed that this isn't centered around the faulting address
as the usual fault around logic.

>
> But more fundamentally, I thought I suggested reducing the VMA bounds to =
exclude
> padding pages the other day at LSF/MM and you said you didn't want to do =
that
> because you didn't want to end up with something else mapped in the gap? =
So
> doesn't that mean the padding pages are part of the VMA and this check wo=
n't help?

The intention was to check that we aren't reading past (more than we
do today) into other subsequent segments (and holes) if the exec
segment is small relative to 64K, in which case we fall back to the
conventional readahead heuristics.

>
> >
> > For reference I found below (coincidentally? similar) distributions on
> > my devices
> >
> > =3D=3D x86 Workstation =3D=3D
> >
> > Total unique exec segments:   906
> >
> > Exec segments >=3D 16 KB:   663 ( 73.18%)
> > Exec segments >=3D 64 KB:   414 ( 45.70%)
>
> What are those percentages? They don't add up to more than 100...

The percent of segments with size >=3D16KB/64KB of the total number of
exec mappings. "Exec segments >=3D 64 KB" is also a subset of "Exec
segments >=3D 16 KB" it's why they don't add up to 100.

>
> The numbers I included with the patch are caclulated based on actual mapp=
ings so
> if we end up with a partially mapped 64K folio (because it runs off the e=
nd of
> the VMA) it wouldn't have been counted as a 64K contiguous mapping. So I =
don't
> think this type of change would change my numbers at all.

I don't think it should affect the results much (probably only a small
benefit from the extra preread of other segments if we aren't under
much memory pressure).

Anyways I don't have a strong opinion, given that this shouldn't be an
issue once we work out Matthew and Ted's idea for the holes. So we can
keep it simple for now.

Thanks,
Kalesh

>
> >
> > =3D=3D arm64 Android Device =3D=3D
> >
> > Total unique exec segments:   2171
> >
> > Exec segments >=3D 16 KB:  1602 ( 73.79%)
> > Exec segments >=3D 64 KB:   988 ( 45.51%)
> >
> > Result were using the below script:
> >
> > cat /proc/*/maps | grep 'r-xp' | \
> > awk '
> > BEGIN { OFS =3D "\t" }
> > $NF ~ /^\// {
> > path =3D $NF;
> > split($1, addr, "-");
> > size =3D strtonum("0x" addr[2]) - strtonum("0x" addr[1]);
> > print size, path;
> > }' | \
> > sort -u | \
> > awk '
> > BEGIN {
> > FS =3D "\t";
> > total_segments =3D 0;
> > segs_ge_16k =3D 0;
> > segs_ge_64k =3D 0;
> > }
> > {
> > total_segments++;
> > size =3D $1;
> > if (size >=3D 16384) segs_ge_16k++;
> > if (size >=3D 65536) segs_ge_64k++;
> > }
> > END {
> > if (total_segments > 0) {
> > percent_gt_16k =3D (segs_ge_16k / total_segments) * 100;
> > percent_gt_64k =3D (segs_ge_64k / total_segments) * 100;
> >
> > printf "Total unique exec segments: %d\n", total_segments;
> > printf "\n";
> > printf "Exec segments >=3D 16 KB: %5d (%6.2f%%)\n", segs_ge_16k, percen=
t_gt_16k;
> > printf "Exec segments >=3D 64 KB: %5d (%6.2f%%)\n", segs_ge_64k, percen=
t_gt_64k;
> > } else {
> > print "No executable segments found.";
> > }
> > }'
> >
> >>>
> >>>>> Kalesh talked about it in the MM BOF at the same time that Ted and =
I
> >>>>> were discussing it in the FS BOF.  Some coordination required (like
> >>>>> maybe Kalesh could have mentioned it to me rathere than assuming I'=
d be
> >>>>> there?)
> >>>>
> >>>> I was at Kalesh's talk. David H suggested that a potential solution =
might be for
> >>>> readahead to ask the fs where the next hole is and then truncate rea=
dahead to
> >>>> avoid reading the hole. Given it's padding, nothing should directly =
fault it in
> >>>> so it never ends up in the page cache. Not sure if you discussed any=
thing like
> >>>> that if you were talking in parallel?
> >>>
> >>> Ted said that he and Kalesh had talked about that solution.  I have a
> >>> more bold solution in mind which lifts the ext4 extent cache to the
> >>> VFS inode so that the readahead code can interrogate it.
> >>>
> >
> > Sorry about the hiccup in coordination, Matthew. It was my bad for not
> > letting you know I planned to discuss it in the MM BoF. I'd like to
> > hear Ted and your ideas on this when possible.
> >
> > Thanks,
> > Kalesh
> >
> >>>> Anyway, I'm not sure if you're suggesting these changes need to be c=
onsidered as
> >>>> one somehow or if you're just mentioning it given it is loosely rela=
ted? My view
> >>>> is that this change is an improvement indepently and could go in muc=
h sooner.
> >>>
> >>> This is not a reason to delay this patch.  It's just a downside which
> >>> should be mentioned in the commit message.
> >>
> >> Fair point; I'll add a paragraph about the potential reclaim issue.
> >>
> >>>
> >>>>>> +static inline int arch_exec_folio_order(void)
> >>>>>> +{
> >>>>>> +  return -1;
> >>>>>> +}
> >>>>>
> >>>>> This feels a bit fragile.  I often expect to be able to store an or=
der
> >>>>> in an unsigned int.  Why not return 0 instead?
> >>>>
> >>>> Well 0 is a valid order, no? I think we have had the "is order signe=
d or
> >>>> unsigned" argument before. get_order() returns a signed int :)
> >>>
> >>> But why not always return a valid order?  I don't think we need a
> >>> sentinel.  The default value can be 0 to do what we do today.
> >>>
> >>
> >> But a single order-0 folio is not what we do today. Note that my chang=
e as
> >> currently implemented requests to read a *single* folio of the specifi=
ed order.
> >> And note that we only get the order we request to page_cache_ra_order(=
) because
> >> the size is limited to a single folio. If the size were bigger, that f=
unction
> >> would actually expand the requested order by 2. (although the paramete=
r is
> >> called "new_order", it's actually interpretted as "old_order").
> >>
> >> The current behavior is effectively to read 128K in order-2 folios (wi=
th smaller
> >> folios for boundary alignment).
> >>
> >> So I see a few options:
>
> Matthew,
>
> Did you have any thoughts on these options?
>
> Thanks,
> Ryan
>
> >>
> >>   - Continue to allow non-opted in arches to use the existing behaviou=
r; in this
> >> case we need a sentinel. This could be -1, UINT_MAX or 0. But in the l=
atter case
> >> you are preventing an opted-in arch from specifying that they want ord=
er-0 -
> >> it's meaning is overridden.
> >>
> >>   - Force all arches to use the new approach with a default folio orde=
r (and
> >> readahead size) of order-0. (The default can be overridden per-arch). =
Personally
> >> I'd be nervous about making this change.
> >>
> >>   - Decouple the read size from the folio order size; continue to use =
the 128K
> >> read size and only allow opting-in to a specific folio order. The defa=
ult order
> >> would be 2 (or 0). We would need to fix page_cache_async_ra() to call
> >> page_cache_ra_order() with "order + 2" (the new order) and fix
> >> page_cache_ra_order() to treat its order parameter as the *new* order.
> >>
> >> Perhaps we should do those fixes anyway (and then actually start with =
a folio
> >> order of 0 - which I think you said in the past was your original inte=
ntion?).
> >>
> >> Thanks,
> >> Ryan
> >>
>


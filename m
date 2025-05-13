Return-Path: <linux-fsdevel+bounces-48906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE37AB589E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 17:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A372518956DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 15:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2928238C2F;
	Tue, 13 May 2025 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RnNFnk9j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D76D383
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 15:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747150312; cv=none; b=T1DlHtPhBB5lnYqpIZMR/XIaNc/8rAM+21XZSKTXmUPEcLP7+GTmMFY3S3Mcp398y9+AQwb7IJZriPnCOXVlQYL6OkstzJlsibk3PT+oL6YOR8Fc+dxWLsu2P2msNZWEUVg2h2TL3FNlRIH1w0l0nLQBRDFFZR+7Gn20nZSjFRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747150312; c=relaxed/simple;
	bh=jPUMHM8PwQ5k8wy74SR71SAnBV8vuhW4yrX6wNZNtFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qXiefxqmu7YNqsRrgeIl8qwXR4MqhKlXNe2TuIJecghxqAz5RSOEWLZ3YNmMYPeb8FgRp1EzOBhbJzKgNXCwFNCEq1C4OLccaSFi+naT07PR9oAAng1ojLEN7KQ67MDm5e/DvE8K9zopALwuDhyV658t/Hpl7AelttxLeQCqx3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RnNFnk9j; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-47666573242so398161cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 08:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747150309; x=1747755109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/pcbAFEUe6CndbNveQVJGhzDrvXg2EyJ/NUFQzfb4yY=;
        b=RnNFnk9jnil0F8J6QXIzZwvD6eNaRZOlq3/KRcHj8WcHlXpIiEYqhgDwluhZAmmyko
         PGRjD6dcdPtlOlF0G2TQITANmBNQIUVznN9nlGYIxgBFdTuKfGCAljP8p3EztOtMU4XT
         ej1P+zqbegPujFDDBr1qzS9pgOt7H8IEZ3/KMtin9bdYikAzVHTp4AQBIi5upqyM6OTf
         snPwnW1LqV/gz7QwB+ox8c8zqzK2Tr6rIQ7nILlW7EOssPsGgwAKXemWEFbwmqD/4Pro
         LrxGGRCsLtivyMwUO/79PxcWH6z4IsofjPbWTLYaYzH9sa/NIEaR9XKl9pDZJvv9KUIZ
         /5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747150309; x=1747755109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/pcbAFEUe6CndbNveQVJGhzDrvXg2EyJ/NUFQzfb4yY=;
        b=PFEV5PwtabBBHs9uwVSjsx8Y9fzHBfedrAag76/t0R2qM4QbqzX8kZVwcdwvqPKVh/
         rzAfqKztiEsdCfjcihF+4TCwhMfr1swcZWhbpOWu0X1lTn5+8D8EWqth85iUzB0dWO9n
         F5SwZRfK9yJQgUm/3dWdsyDEM2WkidZ4njZynePJQ8ofUU8bANX6exL25o9otNi2cqLX
         9f2S+dtRNc4hUSKWIUN/ttMHdY02gJAdkLJvyumxjFnD2vAUejzKH/C1XegYVVUhVB/E
         UxKHp/Dopw0T/hsiurrLpqgujstLoqdfLmL9JwxdPctlPd68e+GtsDsp9QpJUp56e1AT
         en2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVX3cPfnpt8N9MsMFIKJ1iPskc+nmjLyqQyBesiBILczjJD+BWbGwL0mnbq6EL3+qhg1BcpAofcZGoD4Hry@vger.kernel.org
X-Gm-Message-State: AOJu0YywTBylURjv+cg5xfNPjNsFhdz8min1tIwIad4TIavBSqxtigTi
	RXYxNxsUnxpDwozpZ0Ro46lzdYKvzqgewh4Nl62/rMqp5It23uzz4OAg6l2ryFq2mnmeJ7gfZ6P
	cZIBBHwOrMuTMDWTFtP5JEyTsqdhHofVV32RDqDOa
X-Gm-Gg: ASbGnctPN8YwJIwRDji7EhV2g2NUXAwfKyCddPwSgqhRhYPi5wp/WFN6QUl0BKoQSFg
	LqS7Wd8Z+6xHO5J6+JxqWCDE8q6CcKmAgxEhgqtUhy+Myjf0GpLrIV575cmhfpy9CR+iow7zn4P
	l8H1MPVGpwkaCFnliLxd+ySUm2XyXqPSH12gvtY7mg/eMSQg3hYIFAySdu2a6z8aGX8UZ0/rk=
X-Google-Smtp-Source: AGHT+IEazOLSY/I5yGsaKVwi1YOFrm7Vx4mUNOPA4wc5ctfib+E7WUz0Gs1e/wYgWOti4hvr1qmtAH/BNX0+MWB6wSM=
X-Received: by 2002:a05:622a:202:b0:471:eab0:ef21 with SMTP id
 d75a77b69052e-494898efbb9mr4152841cf.13.1747150307319; Tue, 13 May 2025
 08:31:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1746792520.git.lorenzo.stoakes@oracle.com>
 <adb36a7c4affd7393b2fc4b54cc5cfe211e41f71.1746792520.git.lorenzo.stoakes@oracle.com>
 <cd003271-73fd-47f4-9c32-713e3c5a05fc@redhat.com> <c3da96c2-c9b5-40a7-b3ef-a8887fbb3f20@lucifer.local>
 <06e2e29d-20c7-4999-b36b-343cf083f766@redhat.com>
In-Reply-To: <06e2e29d-20c7-4999-b36b-343cf083f766@redhat.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 13 May 2025 08:31:35 -0700
X-Gm-Features: AX0GCFuAMnahTxKUQ5UF1UB4gu8J9u13u9DtXFbpl14HvEiDuGsfXLXRvl8vNz4
Message-ID: <CAJuCfpGqGMozrmoKB78htT-o44cj4rhKN3Q4ae_N1Uv1hJ1r5Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mm: introduce new .mmap_prepare() file callback
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 6:25=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 13.05.25 11:32, Lorenzo Stoakes wrote:
> > On Tue, May 13, 2025 at 11:01:41AM +0200, David Hildenbrand wrote:
> >> On 09.05.25 14:13, Lorenzo Stoakes wrote:
> >>> Provide a means by which drivers can specify which fields of those
> >>> permitted to be changed should be altered to prior to mmap()'ing a
> >>> range (which may either result from a merge or from mapping an entire=
ly new
> >>> VMA).
> >>>
> >>> Doing so is substantially safer than the existing .mmap() calback whi=
ch
> >>> provides unrestricted access to the part-constructed VMA and permits
> >>> drivers and file systems to do 'creative' things which makes it hard =
to
> >>> reason about the state of the VMA after the function returns.
> >>>
> >>> The existing .mmap() callback's freedom has caused a great deal of is=
sues,
> >>> especially in error handling, as unwinding the mmap() state has prove=
n to
> >>> be non-trivial and caused significant issues in the past, for instanc=
e
> >>> those addressed in commit 5de195060b2e ("mm: resolve faulty mmap_regi=
on()
> >>> error path behaviour").
> >>>
> >>> It also necessitates a second attempt at merge once the .mmap() callb=
ack
> >>> has completed, which has caused issues in the past, is awkward, adds
> >>> overhead and is difficult to reason about.
> >>>
> >>> The .mmap_prepare() callback eliminates this requirement, as we can u=
pdate
> >>> fields prior to even attempting the first merge. It is safer, as we h=
eavily
> >>> restrict what can actually be modified, and being invoked very early =
in the
> >>> mmap() process, error handling can be performed safely with very litt=
le
> >>> unwinding of state required.
> >>>
> >>> The .mmap_prepare() and deprecated .mmap() callbacks are mutually
> >>> exclusive, so we permit only one to be invoked at a time.
> >>>
> >>> Update vma userland test stubs to account for changes.
> >>>
> >>> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> >>> ---
> >>>    include/linux/fs.h               | 25 ++++++++++++
> >>>    include/linux/mm_types.h         | 24 +++++++++++
> >>>    mm/memory.c                      |  3 +-
> >>>    mm/mmap.c                        |  2 +-
> >>>    mm/vma.c                         | 68 ++++++++++++++++++++++++++++=
+++-
> >>>    tools/testing/vma/vma_internal.h | 66 ++++++++++++++++++++++++++++=
---
> >>>    6 files changed, 180 insertions(+), 8 deletions(-)
> >>>
> >>> diff --git a/include/linux/fs.h b/include/linux/fs.h
> >>> index 016b0fe1536e..e2721a1ff13d 100644
> >>> --- a/include/linux/fs.h
> >>> +++ b/include/linux/fs.h
> >>> @@ -2169,6 +2169,7 @@ struct file_operations {
> >>>     int (*uring_cmd)(struct io_uring_cmd *ioucmd, unsigned int issue_=
flags);
> >>>     int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_comp_bat=
ch *,
> >>>                             unsigned int poll_flags);
> >>> +   int (*mmap_prepare)(struct vm_area_desc *);
> >>>    } __randomize_layout;
> >>>    /* Supports async buffered reads */
> >>> @@ -2238,11 +2239,35 @@ struct inode_operations {
> >>>     struct offset_ctx *(*get_offset_ctx)(struct inode *inode);
> >>>    } ____cacheline_aligned;
> >>> +/* Did the driver provide valid mmap hook configuration? */
> >>> +static inline bool file_has_valid_mmap_hooks(struct file *file)
> >>> +{
> >>> +   bool has_mmap =3D file->f_op->mmap;
> >>> +   bool has_mmap_prepare =3D file->f_op->mmap_prepare;
> >>> +
> >>> +   /* Hooks are mutually exclusive. */
> >>> +   if (WARN_ON_ONCE(has_mmap && has_mmap_prepare))
> >>> +           return false;
> >>> +   if (WARN_ON_ONCE(!has_mmap && !has_mmap_prepare))
> >>> +           return false;
> >>> +
> >>> +   return true;
> >>> +}
> >>
> >> So, if neither is set, it's also an invalid setting, understood.
> >>
> >> So we want XOR.
> >>
> >>
> >>
> >> const bool has_mmap =3D file->f_op->mmap;
> >> const bool has_mmap_prepare =3D file->f_op->mmap_prepare;
> >> const bool mutual_exclusive =3D has_mmap ^ has_mmap_prepare;
> >>
> >> WARN_ON_ONCE(!mutual_exclusive)
> >> return mutual_exclusive;
> >
> > Yeah I did consider xor like this but I've always found it quite confus=
ing
> > in this kind of context, honestly.
>
> With the local variable I think it's quite helpful (no need for a
> comment :P ).
>
> >
> > In a way I think it's a bit easier spelt out as it is now. But happy to
> > change if you feel strongly about it? :)
>
> Certainly not strongly! :)
>
> --
> Cheers,
>
> David / dhildenb
>


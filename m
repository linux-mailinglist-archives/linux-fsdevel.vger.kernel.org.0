Return-Path: <linux-fsdevel+bounces-42552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6EBA43594
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 07:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F4BC3AB9D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 06:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD83F257AC1;
	Tue, 25 Feb 2025 06:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PmqkBDNt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F2364D
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2025 06:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740465927; cv=none; b=CPBTTSTUK88bQjkCCaZqe9Kq58zaFvJGPqWvNw/3sANqz9ZIBfsTntgLDbWr1/dvK/HhAomceIbSU26SKdXgjeijAlPLqyfgxAsFwJIMFAu1RBM2e0GuT64g8Feiz04shkqqJfN7QbZhU8v/Pi0OsAGw8LEGMzi4Pgkm7g5mS74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740465927; c=relaxed/simple;
	bh=84AFYY2ioOlimLroxenp7cLrCpuzSu4PZoqpxKUn2Wk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rXQDxX++GJ80YhEWgN1q3b2m7HRK6NfEVyKz++HLyaCfz0hw2vWnin6PA96YJ+IrpFvvx8qR/INDo3vAgXdVm1hDk8pNQgzvgHcE9UYtYqLPniluiqiS1LDeWt2PMToOyR5DGBy7SQHNHdrDJEP1egjQS6zpCDzvICaiBl9PmfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PmqkBDNt; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-221ac1f849fso74575ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 22:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740465925; x=1741070725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCIjwPddBZtZ98G5Kvpo03f+UnGFfP+BAS96DDKg3XY=;
        b=PmqkBDNtBVvNKIRjyy3JzHVoKzz2lOLUcSH7Sn9SlmbGB/GHj+0ijDzlFyr5mPGj7b
         1XWiK7yAODOkhqQ+GtEfD/f/lnMI3qowB5uK9/GgMO5x4robBSrfC+4O4M41IsJCEcIR
         Mys3cPcXtiOClnm4od0wQsJxfyjyTXfaJwQWEaIdNzfxUzYC/Ong+XU6mEoMrcy0aPZI
         uQ+39GKyBix85SEenEgNhhL+8HaemhNCjSaKFAOM1gGD9kdbTFqyFnC3go0Qb6L7odg7
         r5mcqgG8INm7VldPeMXIlsgAf9534/TBfwWbIfb9mbrA4ECyFupNdZJmNC0Gr0vyrSE4
         Te0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740465925; x=1741070725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pCIjwPddBZtZ98G5Kvpo03f+UnGFfP+BAS96DDKg3XY=;
        b=xQrJ77doXI0v7C3ZIG3cbf0TvIU4BB4GCQwBmYbnO2k6xS9wcy27PTm650MBoGeAki
         ZzaHEoCQA+aRCaSIrgNakDmJBeuQPN24XdkU7Nxy4EpK3l+l2RTfNRUkH1YO/RfKvEvX
         Hau8TN/FdvQY6rgYDzS6uFv7uWYIYwtOMEpf6t9vGORYXHF/ZYJMAsOuzq1qWNZ7jqdp
         rfyim2zOFcL13KGq8NzfjkxxIpv/M3CY7amjw+UhtoVK/Ks2WWcZTwVRz1RAbBZHmqGh
         yDT8aIL+qrHVOOmy9rg3jyb8ieXTm403AdS4Zfc4bHCszakdxlIWfRQYxua1R9I758kN
         iA9A==
X-Forwarded-Encrypted: i=1; AJvYcCVjFG71W0QYTpjrMAp8RrNko5lVVa4NIjbFMHtGW4ws7eraEbZ2Wbk8C7rPJttOhmIIoozpUVVgpLPSg+rb@vger.kernel.org
X-Gm-Message-State: AOJu0YypX7/uCnjSg4R6EllGE0pUCaVV/sxtYKZjA1noTsbuuD05E9MQ
	yfazdReGcSUV/ZbD+TPP4Sb9U7sanPqC/PzEO5Vm83eHkdZjIIovA1FizGDcghjkHL2csCy8auW
	+Ve0waSOiu+G2cysLCznUzM1dc9XJpcZnoGtW
X-Gm-Gg: ASbGncs5B4/Qb1SulJoGhU7aKzCcpSZAHYRz8tyfknBJOCps9nygW/4jdAnKC3gWopk
	BBP+3Npw26hvDjMcX/67AcxT/YXOhAj0uOqe/dGjE9pzunKdYgtry2EeDlISmKdkUsKCl6SnvS3
	BHqgiatMgUmocEuFS1WUd6WgZhgI934/FS+q8nuxsZ
X-Google-Smtp-Source: AGHT+IH8FAwlBuc4BTvCIoh7/sxCgvcbGAH3JFcLbj9b9AI6osK5eUCXs3hyV61fgxFQvevFmy3bLci+Tr2nNtbhFjM=
X-Received: by 2002:a17:903:2346:b0:21f:44eb:80f4 with SMTP id
 d9443c01a7336-22307a2e210mr2241375ad.4.1740465924751; Mon, 24 Feb 2025
 22:45:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAC_TJvfG8GcwG_2w1o6GOTZS8tfEx2h9A91qsenYfYsX8Te=Bg@mail.gmail.com>
 <hep2a5d6k2kwth5klatzhl3ejbc6g2opqu6tyxyiohbpdyhvwp@lkg2wbb4zhy3>
 <3bd275ed-7951-4a55-9331-560981770d30@lucifer.local> <ivnv2crd3et76p2nx7oszuqhzzah756oecn5yuykzqfkqzoygw@yvnlkhjjssoz>
 <82fbe53b-98c4-4e55-9eeb-5a013596c4c6@lucifer.local> <CAC_TJvcnD731xyudgapjHx=dvVHY+cxoO1--2us7oo9TqA9-_g@mail.gmail.com>
 <Z70HJWliB4wXE-DD@dread.disaster.area>
In-Reply-To: <Z70HJWliB4wXE-DD@dread.disaster.area>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Mon, 24 Feb 2025 22:45:12 -0800
X-Gm-Features: AWEUYZna92Ohm2ndCe_59qlckF0s1qouROgIVUdKUo4JCDeaGW4PzL-5UlPruj4
Message-ID: <CAC_TJvf3eWk-bmVcy9fP2hNbLU8haAEv4uVDx++TMDngsjhnwA@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Optimizing Page Cache Readahead Behavior
To: Dave Chinner <david@fromorbit.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jan Kara <jack@suse.cz>, 
	lsf-pc@lists.linux-foundation.org, 
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, David Hildenbrand <david@redhat.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Juan Yescas <jyescas@google.com>, 
	android-mm <android-mm@google.com>, Matthew Wilcox <willy@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, 
	"Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 3:56=E2=80=AFPM Dave Chinner <david@fromorbit.com> =
wrote:
>
> On Mon, Feb 24, 2025 at 01:36:50PM -0800, Kalesh Singh wrote:
> > Another possible way we can look at this: in the regressions shared
> > above by the ELF padding regions, we are able to make these regions
> > sparse (for *almost* all cases) -- solving the shared-zero page
> > problem for file mappings, would also eliminate much of this overhead.
> > So perhaps we should tackle this angle? If that's a more tangible
> > solution ?
> >
> > From the previous discussions that Matthew shared [7], it seems like
> > Dave proposed an alternative to moving the extents to the VFS layer to
> > invert the IO read path operations [8]. Maybe this is a move
> > approachable solution since there is precedence for the same in the
> > write path?
> >
> > [7] https://lore.kernel.org/linux-fsdevel/Zs97qHI-wA1a53Mm@casper.infra=
dead.org/
> > [8] https://lore.kernel.org/linux-fsdevel/ZtAPsMcc3IC1VaAF@dread.disast=
er.area/
>
> Yes, if we are going to optimise away redundant zeros being stored
> in the page cache over holes, we need to know where the holes in the
> file are before the page cache is populated.
>
> As for efficient hole tracking in the mapping tree, I suspect that
> we should be looking at using exceptional entries in the mapping
> tree for holes, not inserting mulitple references to the zero folio.
> i.e. the important information for data storage optimisation is that
> the region covers a hole, not that it contains zeros.
>
> For buffered reads, all that is required when such an exceptional
> entry is returned is a memset of the user buffer. For buffered
> writes, we simply treat it like a normal folio allocating write and
> replace the exceptional entry with the allocated (and zeroed) folio.
>
> For read page faults, the zero page gets mapped (and maybe
> accounted) via the vma rather than the mapping tree entry. For write
> faults, a folio gets allocated and the exception entry replaced
> before we call into ->page_mkwrite().
>
> Invalidation simply removes the exceptional entries.
>
> This largely gets rid of needing to care about the zero page outside
> of mmap() context where something needs to be mapped into the
> userspace mm context. Let the page fault/mm context substitute the
> zero page in the PTE mappings where necessary, but we don't need to
> use and/or track the zero page in the page cache itself....
>
> FWIW, this also lends itself to storing unwritten extent information
> in exceptional entries. One of the problems we have is unwritten
> extents can contain either zeros (been read) and data (been
> overwritten in memory, but not flushed to disk). This is the problem
> that SEEK_DATA has to navigate - it has to walk the page cache over
> unwritten extents to determine if there is data over the unwritten
> extent or not.
>
> In this case, an exceptional entry gets added on read, which is then
> replaced with an actual folio on write. Now SEEK_DATA can easily and
> safely determine where the data actually lies over the unwritten
> extent with a mapping tree walk instead of having to load and lock
> each folio to check it is dirty or not....

Thank you for the very detailed explanation Dave.

I think this approach with the exceptional entries and the allocation
decision happening at fault time would also allow us to introduce this
incrementally for MAP_PRIVATE  and MAP_SHARED, should there be any
unforeseen issues MAP_SHARED ...

and file_map_pages() would already correctly handle the exceptional
entries for fault around ...

--Kalesh

>
> -Dave.
> --
> Dave Chinner
> david@fromorbit.com


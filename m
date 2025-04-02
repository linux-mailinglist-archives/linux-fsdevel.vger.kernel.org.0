Return-Path: <linux-fsdevel+bounces-45481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE2DA78575
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 02:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BF1A16B797
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 00:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84A310E9;
	Wed,  2 Apr 2025 00:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RkI1lXIu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA968645
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Apr 2025 00:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743552851; cv=none; b=g3fh6HnITgKDhpDoB3p5ICn2Shg3QQpPjt54QCgUNfQ8TEChjx5ije/9efbP2cJAweJlvcGEbPcQgVcT4+TFlWnxoJ2FDIjcA1NLjHgk6Wnw7H34mp4gj+sIm1jja6xFBg5ZTKnOdmqyXJlmSz3GRN+PZuALf4Ye5pBlnImv5FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743552851; c=relaxed/simple;
	bh=E6VyDQVeM5NLuqygmeBKHcaRrVTzI570aCl7pK6xPTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N1SpfmF8TUUPtcaBrl4Bvjfthb4pBhqudJSS+ray0jZEylDoQa2ceDWC7/R/Y8YgveTZPb4EgM1cQawcrFb01BZCPhErPCyVTUBlrY3j8Oj/KAOV4TJFREmnOw7oSZsAT+32YfgqDN4klm8EHNTNUAaEkgLwAfbNOA4GE35HxbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RkI1lXIu; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2263428c8baso43305ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Apr 2025 17:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743552849; x=1744157649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWQ2ocRDk8UrD/kB4KvMYAJSx6KLCBvwU+MsxS/somw=;
        b=RkI1lXIuUbLi0mzTNniZa/E7ombHMVkbKB7/YMaYqFkQbf4dmb4tE+Lr2A59IC8f69
         p4tRQKqATio5zmJefLuCmx9o4rR4Z7ynmYv4sSxtnLDgq4YqKRkz1Y2lvvtdn4GpiFfW
         mfRIULncjfm1vdenDsvrBTIUmjzPrK7o71Fg/53Hvjtl3ZHQXLsAN+yG0dtf1lAVPIo5
         1E0+UIPiba2LbzIgzsFXVFQbAtm/bJXNa+5Far1SRk+x5MagRIqGndkytaFWG0XLJC28
         XO5PBsamYn0AJP+vO1EE4Eg/zoMUcriwIFC0VBrC5tw6pslwHhH7wOL8LqaD8n6hRBYM
         YJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743552849; x=1744157649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YWQ2ocRDk8UrD/kB4KvMYAJSx6KLCBvwU+MsxS/somw=;
        b=My1sra5tu1Vd5Gi4tT21zZt9NLaIiT7fwLO8ovH66LWzpounWheGn3KNLKn5NzlCFY
         rFNNdaaLsF4bJjC3T43hAPKzCAYTMU9BjBbVO3QH9S266ET9QM7e6XXT1QaVcGnRGmgd
         LA/m7sxTEWPneBYj1jE46Ddflb9r/ZviLg6lpfi9QJ/fUt6HRjTPTrRgxZsza3vCIIcc
         AYljsQnX0GAxYbX59nNT12S6e9FiS3ohBm6EKLaLxWyUPGLVGHwsP9iw8Maqx25Qe9OB
         tuTdzQl9X1kbARe+CEM3IO8W/CoKV35pD2pjhrdwD5DGtficeIeEmX8t3zRA83mbBHBD
         ymzg==
X-Forwarded-Encrypted: i=1; AJvYcCUt1UiI5LHUJBfaH6wXRIJykutJxonvt0BZEceCERB1TcXDs3uIngal4bayHRwct/ZxLUGNaf3IZAShRkll@vger.kernel.org
X-Gm-Message-State: AOJu0YzdKzDNi6+dTZIhPWPJf/U9jqFIo6u9sSC5uEOlXwB3Vmz1fy+Q
	3xN3c86SFUoKQJdAy15o6K5SNpkzQwYKXh6rpdxqGOUAJOVaxReUkLrn17DSQD7uZ/LMPQ2R50v
	s4UEg3RAULdHLzfQAWq5HlZBtPVwPJoa+VgQb
X-Gm-Gg: ASbGncs4+SDteB8jpXNqqwomnuHaCGooo+e/VVMwjwyMBy9PjIG4sQ7mrRkof/+wczV
	hFKAmUPBq0FPMlshadqZ7rz7bX/zlth3sXeHxdzuxhxqnrAekYD91HAslF/yj3bXOe4loz2FZtu
	8aARZTyILkNzMfykpIoX6LPUQD+dyRXjsht4vPyR4qCh9OA7iGtIWOZyte
X-Google-Smtp-Source: AGHT+IEUqL7Ad7UHvHVOv3GapJ3xChDN5disEmR7+cXyrIIUpmMtpqHpoY8RO6w1KCJS8RDCMRqp/5e+JG895uI72ow=
X-Received: by 2002:a17:902:d4c7:b0:21f:2ded:bfc5 with SMTP id
 d9443c01a7336-22969e8c805mr1141365ad.28.1743552848066; Tue, 01 Apr 2025
 17:14:08 -0700 (PDT)
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
 <Z70HJWliB4wXE-DD@dread.disaster.area> <Z8DjYmYPRDArpsqx@casper.infradead.org>
 <2dcaa0a6-c20d-4e57-80df-b288d2faa58d@redhat.com>
In-Reply-To: <2dcaa0a6-c20d-4e57-80df-b288d2faa58d@redhat.com>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Tue, 1 Apr 2025 17:13:56 -0700
X-Gm-Features: AQ5f1JoG3S88OyDppZMowOfF2yqfLMwf7guNr-qq6RU-u2QEU-UXuXyAW2GKDRs
Message-ID: <CAC_TJveXmMFBuMh_S3RQc3p9Z6eqK+r=1yYfcquD7soDsgkGXg@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Optimizing Page Cache Readahead Behavior
To: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, Dave Chinner <david@fromorbit.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jan Kara <jack@suse.cz>, 
	lsf-pc@lists.linux-foundation.org, 
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Juan Yescas <jyescas@google.com>, android-mm <android-mm@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, 
	"Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 1:07=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 27.02.25 23:12, Matthew Wilcox wrote:
> > On Tue, Feb 25, 2025 at 10:56:21AM +1100, Dave Chinner wrote:
> >>>  From the previous discussions that Matthew shared [7], it seems like
> >>> Dave proposed an alternative to moving the extents to the VFS layer t=
o
> >>> invert the IO read path operations [8]. Maybe this is a move
> >>> approachable solution since there is precedence for the same in the
> >>> write path?
> >>>
> >>> [7] https://lore.kernel.org/linux-fsdevel/Zs97qHI-wA1a53Mm@casper.inf=
radead.org/
> >>> [8] https://lore.kernel.org/linux-fsdevel/ZtAPsMcc3IC1VaAF@dread.disa=
ster.area/
> >>
> >> Yes, if we are going to optimise away redundant zeros being stored
> >> in the page cache over holes, we need to know where the holes in the
> >> file are before the page cache is populated.
> >
> > Well, you shot that down when I started trying to flesh it out:
> > https://lore.kernel.org/linux-fsdevel/Zs+2u3%2FUsoaUHuid@dread.disaster=
.area/
> >
> >> As for efficient hole tracking in the mapping tree, I suspect that
> >> we should be looking at using exceptional entries in the mapping
> >> tree for holes, not inserting mulitple references to the zero folio.
> >> i.e. the important information for data storage optimisation is that
> >> the region covers a hole, not that it contains zeros.
> >
> > The xarray is very much optimised for storing power-of-two sized &
> > aligned objects.  It makes no sense to try to track extents using the
> > mapping tree.  Now, if we abandon the radix tree for the maple tree, we
> > could talk about storing zero extents in the same data structure.
> > But that's a big change with potentially significant downsides.
> > It's something I want to play with, but I'm a little busy right now.
> >
> >> For buffered reads, all that is required when such an exceptional
> >> entry is returned is a memset of the user buffer. For buffered
> >> writes, we simply treat it like a normal folio allocating write and
> >> replace the exceptional entry with the allocated (and zeroed) folio.
> >
> > ... and unmap the zero page from any mappings.
> >
> >> For read page faults, the zero page gets mapped (and maybe
> >> accounted) via the vma rather than the mapping tree entry. For write
> >> faults, a folio gets allocated and the exception entry replaced
> >> before we call into ->page_mkwrite().
> >>
> >> Invalidation simply removes the exceptional entries.
> >
> > ... and unmap the zero page from any mappings.
> >
>
> I'll add one detail for future reference; not sure about the priority
> this should have, but it's one of these nasty corner cases that are not
> the obvious to spot when having the shared zeropage in MAP_SHARED mapping=
s:
>
> Currently, only FS-DAX makes use of the shared zeropage in "ordinary
> MAP_SHARED" mappings. It doesn't use it for "holes" but for "logically
> zero" pages, to avoid allocating disk blocks (-> translating to actual
> DAX memory) on read-only access.
>
> There is one issue between gup(FOLL_LONGTERM | FOLL_PIN) and the shared
> zeropage in MAP_SHARED mappings. It so far does not apply to fsdax,
> because ... we don't support FOLL_LONGTERM for fsdax at all.
>
> I spelled out part of the issue in fce831c92092 ("mm/memory: cleanly
> support zeropage in vm_insert_page*(), vm_map_pages*() and
> vmf_insert_mixed()").
>
> In general, the problem is that gup(FOLL_LONGTERM | FOLL_PIN) will have
> to decide if it is okay to longterm-pin the shared zeropage in a
> MAP_SHARED mapping (which might just be fine with a R/O file in some
> cases?), and if not, it would have to trigger FAULT_FLAG_UNSHARE similar
> to how we break COW in MAP_PRIVATE mappings (shared zeropage ->
> anonymous folio).
>
> If gup(FOLL_LONGTERM | FOLL_PIN) would just always longterm-pin the
> shared zeropage, and somebody else would end up triggering replacement
> of the shared zeropage in the pagecache (e.g., write() to the file
> offset, write access to the VMA that triggers a write fault etc.), you'd
> get a disconnect between what the GUP user sees and what the pagecache
> actually contains.
>
> The file system fault logic will have to be taught about
> FAULT_FLAG_UNSHARE and handle it accordingly (e.g., allocate fill file
> hole, allocate disk space, allocate an actual folio ...).
>
> Things like memfd_pin_folios() might require similar care -- that one in
> particular should likely never return the shared zeropage.
>
> Likely gup(FOLL_LONGTERM | FOLL_PIN) users like RDMA or VFIO will be
> able to trigger it.
>
>
> Not using the shared zeropage but instead some "hole" PTE marker could
> avoid this problem. Of course, not allowing for reading the shared
> zeropage there, but maybe that's not strictly required?
>

Link to slides for the talk:
https://drive.google.com/file/d/1MOJu5FZurV4XaCLrQhM9S5ubN7H_jEA8/view?usp=
=3Ddrive_link

Thanks,
Kalesh

> --
> Cheers,
>
> David / dhildenb
>


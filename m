Return-Path: <linux-fsdevel+bounces-8383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 065E48358E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 01:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FA001F224BC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 00:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB1863C;
	Mon, 22 Jan 2024 00:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="IbpenJg2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A911363
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jan 2024 00:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705882727; cv=none; b=ukriR25J+uSDgtmezw5K1p4wEXUdqPeNKldBIiKM2yl4FXcfrQK+QRs+NiwNAK35K21vGiqtXXASdRf9yafosCfiX2XwzD/UP8iFbjwQPIQLDidi0M28S8K+2RnhtQ9iKOEAnNr7Eo++E/JXi6T4uHhQqqBODD7F9gtKwmlLsyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705882727; c=relaxed/simple;
	bh=W/1x+TdeJYWgbMOU7ecXNAMiH1UftNucDIO6tqaUoUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gANEIMHv0E2Tix+bet/fkwlmI1aW43NKOnn2govBmo2/fv5rysh9c4pdNr2NS7Ft0ixG3Cnym4dEOIHO9O07/pkFZRsYHpBw7PjGA9JzcH0BdbisKvdgaVWA1MBPnP2ALwD02WizLS7qnFib/OsmS421oHdDNxqEoOFpDNwDRrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=IbpenJg2; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78376790dfbso282709885a.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jan 2024 16:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1705882725; x=1706487525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6loqEtr8W4/MnoN9hv9zyuRQ/zMGZggVt2HpZC6HiwE=;
        b=IbpenJg2fPEK2q6gnOZaEP5IZjGsgnWMy9orp4boyvc1mikrR0+6d2vh2TaI3HJb+j
         3yjdV+H9PNN5RrSrarhvwOoA5ZE2Qk91pB6Ww/X9vJX1l2RFfPs9kfxI5cygKiroRVC+
         cLI1ToTQsU/l5joDCDvMxrrL9axyHDIoV3VaHtcWfAvfCxwIIY5gUgFbngDPCICFSNT0
         Mb1oL7SXVlFBIYAX3fdaNw2lEG6b+r3rC/JWM9shhWcOVxFzAxXOpB1QjzR2xxaLS/I3
         P+3bId9067nIvQccpdCuJuRvZA+faJwHDI6QYyUvqHEEeOACxV25icmYN9jYsa9IVs8J
         U/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705882725; x=1706487525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6loqEtr8W4/MnoN9hv9zyuRQ/zMGZggVt2HpZC6HiwE=;
        b=U546dZYqSH6NCiPL7V3gB4xpxaVBZzY/eW/hluZSKbLn8v6i/UmJpX5hdOXOvdCIub
         VdUVNvjBajx9hHTCzNsa+XovSEX+OtozMkEo2Bvk44TqFxE1JnDuOjtmMEXARX+Mw6dB
         9KLZ0id0h5J5Pdi8NxnKaBruof2qjV32Me5zxPxZb9Cd9lxGmJ6Oj3E2sD7GF/h8HQzB
         FcV655ZhSdf3VE7eFv4xMlpGWVH48hP791lJ7yL/4eFQNXfsi4ck9r28Aa4VzGFTkCBA
         nKTYngjiglQbiHVdNG5zcq2CiHOqcGuVYpdNKgA5uVWQMsTAOEEgvLTrG5SwdKllFb+O
         4hmA==
X-Gm-Message-State: AOJu0YyXY1/awmyrYZLhCu8PqgemuRYquC6BbscCh/aG4CkU45novntL
	DhRrXnY3QLkdKpsVFbnjXJuIMyZsCGe4DloT8rXBKHGskFS9d0PYNdeiR8jBQ/XbIEC9m9Yv1eo
	R8e/ehzcO3sarywOa5yxXYtduUpAmkHpx9BicHA==
X-Google-Smtp-Source: AGHT+IG+gZyrTFmxZcL/YVdEWM1zZYi9bYnrK6V7OnM6bduS/ZZQ1bpPfQMbiOpqPxopthUR3Y+1vPXte763Qg5XT3M=
X-Received: by 2002:a05:620a:1035:b0:783:6e7a:c815 with SMTP id
 a21-20020a05620a103500b007836e7ac815mr6065985qkk.32.1705882725284; Sun, 21
 Jan 2024 16:18:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZaqiPSj1wMrTMdHa@casper.infradead.org> <b04b65df-b25f-4457-8952-018dd4479651@google.com>
 <Za2lS-jG1s-HCqbx@casper.infradead.org> <CA+CK2bCAPWhCd37X8syz9fHYSv_pQ0-k+khgXZc1uCPRBnFaWQ@mail.gmail.com>
 <Za2uq2L7_IU8RQWU@casper.infradead.org>
In-Reply-To: <Za2uq2L7_IU8RQWU@casper.infradead.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sun, 21 Jan 2024 19:18:09 -0500
Message-ID: <CA+CK2bC8-f2hWqnK4feRYBtuwqjdRoN8=sdaipJOiHFSNos=mg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] State Of The Page
To: Matthew Wilcox <willy@infradead.org>
Cc: David Rientjes <rientjes@google.com>, Pasha Tatashin <tatashin@google.com>, 
	Sourav Panda <souravpanda@google.com>, lsf-pc@lists.linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 21, 2024 at 6:54=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Sun, Jan 21, 2024 at 06:31:48PM -0500, Pasha Tatashin wrote:
> > On Sun, Jan 21, 2024 at 6:14=E2=80=AFPM Matthew Wilcox <willy@infradead=
.org> wrote:
> > > I can add a proposal for a topic on both the PCP and Buddy allocators
> > > (I have a series of Thoughts on how the PCP allocator works in a memd=
esc
> > > world that I haven't written down & sent out yet).
> >
> > Interesting, given that pcp are mostly allocated by kmalloc and use
> > vmalloc for large allocations, how memdesc can be different for them
> > compared to regular kmalloc allocations given that they are sub-page?
>
> Oh!  I don't mean the mm/percpu.c allocator.  I mean the pcp allocator
> in mm/page_alloc.c.

Nevermind, this makes perfect sense now :-)

> I don't have any Thoughts on mm/percpu.c at this time.  I'm vaguely
> aware that it exists ;-)
>
> > > Thee's so much work to be done!  And it's mostly parallelisable and a=
lmost
> > > trivial.  It's just largely on the filesystem-page cache interaction,=
 so
> > > it's not terribly interesting.  See, for example, the ext2, ext4, gfs=
2,
> > > nilfs2, ufs and ubifs patchsets I've done over the past few releases.
> > > I have about half of an ntfs3 patchset ready to send.
> >
> > > There's a bunch of work to be done in DRM to switch from pages to fol=
ios
> > > due to their use of shmem.  You can also grep for 'page->mapping' (be=
cause
> > > fortunately we aren't too imaginative when it comes to naming variabl=
es)
> > > and find 270 places that need to be changed.  Some are comments, but
> > > those still need to be updated!
> > >
> > > Anything using lock_page(), get_page(), set_page_dirty(), using
> > > &folio->page, any of the functions in mm/folio-compat.c needs auditin=
g.
> > > We can make the first three of those work, but they're good indicator=
s
> > > that the code needs to be looked at.
> > >
> > > There is some interesting work to be done, and one of the things I'm
> > > thinking hard about right now is how we're doing folio conversions
> > > that make sense with today's code, and stop making sense when we get
> > > to memdescs.  That doesn't apply to anything interacting with the pag=
e
> > > cache (because those are folios now and in the future), but it does a=
pply
> > > to one spot in ext4 where it allocates memory from slab and attaches =
a
> > > buffer_head to it ...
> >
> > There are many more drivers that would need the conversion. For
> > example, IOMMU page tables can occupy gigabytes of space, have
> > different implementations for AMD, X86, and several ARMs. Conversion
> > to memdesc and unifying the IO page table management implementation
> > for these platforms would be beneficial.
>
> Understood; there's a lot of code that can benefit from larger
> allocations.  I was listing the impediments to shrinking struct page
> rather than the places which would most benefit from switching to larger
> allocations.  They're complementary to a large extent; you can switch
> to compound allocations today and get the benefit later.  And unifying
> implementations is always a worthy project.


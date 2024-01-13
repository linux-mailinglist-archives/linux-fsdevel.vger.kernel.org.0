Return-Path: <linux-fsdevel+bounces-7896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F9582C836
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jan 2024 01:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03018287BF3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jan 2024 00:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90D337B;
	Sat, 13 Jan 2024 00:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIxIi4Qd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73B8364;
	Sat, 13 Jan 2024 00:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4b72e63821eso4454572e0c.1;
        Fri, 12 Jan 2024 16:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705104674; x=1705709474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHvhMGOuMxGpja9NIsPHvvd3EE5Jghfyp8WBP+aJvlM=;
        b=OIxIi4QdUiGgKXLhtTGyg9xzkzPnm4GKS12vlF5JkCf484eo4vxUUbp6TZ+rESJ1b5
         UNSJZsxlYrKsvbCbbV43fE7jrWCOJJCqoEZhkPR/TScALGDjXQWwpSiYTH0Bi5Vv+EvN
         mPBot7Rspga6UEdoJrBi39VeSHtEZbawJQnurAUZMVsyU8K/sFkNldtBXH22YYm0qBpF
         YA16hJYuAeg/iJLdSM6lIKPa8aD1swISbn2dQKeWuzXZ17bHBXOBXFq6w62siKPxR8Mr
         eucfqeKNbKu15v1cmTA4wqCb/JzQN+l7ROHngnipJXAyFdljz/mIUPUR7TeKV5NbRCXZ
         vBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705104674; x=1705709474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHvhMGOuMxGpja9NIsPHvvd3EE5Jghfyp8WBP+aJvlM=;
        b=s8HarCAb7wkiUfkAzPkQHVJoCcYgrAKzUCqIivZiXdqlgYGRba1vL4Uc1Hj6R/HTrW
         ebKNZkYgIagerm0SE8iLzJ9skAW3Pp+9cj9ZNURmgP+1FzKEAbCX+61YbrfBj+CR2aQH
         UQzLvPIOCt0xB6MkE1BspWEv2r4L78Mc5pidMmgmVrsBx0uRe7WxUeYfDUJFzRy7cR10
         5l3nyo+GFxSqoO+mIdW0cenYQGtilMn8/sPGabK1MKPqlz6VUQ2loW+FiUAHihteGvu/
         EDA9BqkNsy7EaDrMEpl4jE360Z3tj7h405b0ApNbfTh/insMi+FWqEb1U0GLWJ4enQE+
         Ea5g==
X-Gm-Message-State: AOJu0YyWyU68yc2YPh1V3m5AmRo+5WOoQQFcyouI3N4ak+gBB4VzXfre
	m70O6X2tGElJOuusZUYKmVefZIS/pyKiWrAXONQ=
X-Google-Smtp-Source: AGHT+IGTGdV1n31t1UQoN3GRkX3l9DchMb+zy5mxw5LKO1U3ELjDDBKRsqaGKvTfZyA+0Cwp3uYrS6neXlAyMtrlBrA=
X-Received: by 2002:a05:6122:1811:b0:4b2:c554:cd04 with SMTP id
 ay17-20020a056122181100b004b2c554cd04mr2466010vkb.16.1705104674548; Fri, 12
 Jan 2024 16:11:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111154106.3692206-1-ryan.roberts@arm.com>
 <CAGsJ_4xPgmgt57sw2c5==bPN+YL23zn=hZweu8u2ceWei7+q4g@mail.gmail.com>
 <654df189-e472-4a75-b2be-6faa8ba18a08@arm.com> <CAGsJ_4zyK4kSF4XYWwLTLN8816KL+u=p6WhyEsRu8PMnQTNRUg@mail.gmail.com>
 <CAGsJ_4y8ovLPp51NcrhTXTAE0DZvSPYTJs8nu6-ny_ierLx-pw@mail.gmail.com> <ZaHFbJ2Osd/tpPqN@casper.infradead.org>
In-Reply-To: <ZaHFbJ2Osd/tpPqN@casper.infradead.org>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 13 Jan 2024 13:11:03 +1300
Message-ID: <CAGsJ_4wZzjprAs42LMw8s8C_iz4v7m6fiO7-7nBS2BxkU9u8QA@mail.gmail.com>
Subject: Re: [RFC PATCH v1] mm/filemap: Allow arch to request folio size for
 exec memory
To: Matthew Wilcox <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	John Hubbard <jhubbard@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 13, 2024 at 12:04=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Sat, Jan 13, 2024 at 11:54:23AM +1300, Barry Song wrote:
> > > > Perhaps an alternative would be to double ra->size and set ra->asyn=
c_size to
> > > > (ra->size / 2)? That would ensure we always have 64K aligned blocks=
 but would
> > > > give us an async portion so readahead can still happen.
> > >
> > > this might be worth to try as PMD is exactly doing this because async
> > > can decrease
> > > the latency of subsequent page faults.
> > >
> > > #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > >         /* Use the readahead code, even if readahead is disabled */
> > >         if (vm_flags & VM_HUGEPAGE) {
> > >                 fpin =3D maybe_unlock_mmap_for_io(vmf, fpin);
> > >                 ractl._index &=3D ~((unsigned long)HPAGE_PMD_NR - 1);
> > >                 ra->size =3D HPAGE_PMD_NR;
> > >                 /*
> > >                  * Fetch two PMD folios, so we get the chance to actu=
ally
> > >                  * readahead, unless we've been told not to.
> > >                  */
> > >                 if (!(vm_flags & VM_RAND_READ))
> > >                         ra->size *=3D 2;
> > >                 ra->async_size =3D HPAGE_PMD_NR;
> > >                 page_cache_ra_order(&ractl, ra, HPAGE_PMD_ORDER);
> > >                 return fpin;
> > >         }
> > > #endif
> > >
> >
> > BTW, rather than simply always reading backwards,  we did something ver=
y
> > "ugly" to simulate "read-around" for CONT-PTE exec before[1]
> >
> > if page faults happen in the first half of cont-pte, we read this 64KiB
> > and its previous 64KiB. otherwise, we read it and its next 64KiB.
>
> I don't think that makes sense.  The CPU executes instructions forwards,
> not "around".  I honestly think we should treat text as "random access"
> because function A calls function B and functions A and B might well be
> very far apart from each other.  The only time I see you actually
> getting "readahead" hits is if a function is split across two pages (for
> whatever size of page), but that's a false hit!  The function is not,
> generally, 64kB long, so doing readahead is no more likely to bring in
> the next page of text that we want than reading any other random page.
>

it seems you are in favor of Ryan's modification even for filesystems
which don't support large mapping?

> Unless somebody finds the GNU Rope source code from 1998, or recreates it=
:
> https://lwn.net/1998/1029/als/rope.html
> Then we might actually have some locality.
>
> Did you actually benchmark what you did?  Is there really some locality
> between the code at offset 256-288kB in the file and then in the range
> 192kB-256kB?

I really didn't have benchmark data, at that point I was like,
instinctively didn=E2=80=99t
want to break the logic of read-around, so made the code just that.
The info your provide makes me re-think if the read-around code is necessar=
y,
thanks!

was using filesystems without large-mapping support but worked around
the problem by
1. preparing 16*n normals pages
2. insert normal pages into xa
3. let filesystem read 16 normal pages
4. after all IO completion, transform 16 pages into mTHP and reinsert
mTHP to xa

that was very painful and finally made no improvement probably because
of due to various sync overhead. so  ran away and didn't dig more data.

Thanks
Barry


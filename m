Return-Path: <linux-fsdevel+bounces-47790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3DCAA57F3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 00:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76BF93ABEB1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 22:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39822253A7;
	Wed, 30 Apr 2025 22:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="37EeOJmL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5812C34545
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 22:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746051867; cv=none; b=GtAk0yYASMR7i2lAEM5wYsegMc/qaWnig5eGVHbGGDX/4awOAraXDyr3etVaPARHSY0otK0y54KTMU5h6ivG0Ha5KJWMLfmKOMsqFYMLs1W/0ihHGxZZWZxdqeIserQzTUbccwmgfeHeui23/iyR4nDcOrPy3FCfQnfviSSg6/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746051867; c=relaxed/simple;
	bh=XUNiapQ3xbVcqbsb25qLtByac0s7+WQgBwW6DMvVUyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P8gHTxpL55OFpT60aLp/y9ewu5Vsi4bWQHS/qPqB942Mb3M/K+HxLLXIju21xjOqt4B79APX2S1vU9DewLt6xTtzkMu/ilZinJqKmV3bubi09TqigxzZ9aQNsXtjP6H2+vSZH9q39fn2qXUEcftRNwJvsq4tMFvVvQY5l/e4vjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=37EeOJmL; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5f88f236167so1552a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 15:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746051863; x=1746656663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XUNiapQ3xbVcqbsb25qLtByac0s7+WQgBwW6DMvVUyk=;
        b=37EeOJmLnnYZg8UsocxqQIuTdOohrn0EuYO9JThx6DdCAck+j6D0RTN4VCj+Vb6TJR
         a3OSRp6yQLBNUFvhj0yidHG4Qu+r9TlU+vQu3Bexm+LA7MOef8YStBhLxujQeiy98VXH
         J47x4vP14nRqfb6FhAi0UVml3wvBheCH9x1G06f2GZgOSET310y2JDgeHdV/6IkimnjK
         7NES2znqK89WFEryUrMRJ1lgNyl014oBXby1iMT7SqI1cEl0rgSe4ae2usAqxxY+l6ov
         82vq0PJ2Zy9A+/tPRQF46tnzE2E4An843mh3hdQdK4TrT5JlBc9nFC+wV/yilR3hH4hD
         BK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746051863; x=1746656663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XUNiapQ3xbVcqbsb25qLtByac0s7+WQgBwW6DMvVUyk=;
        b=dqoj6A2i9J8aQhc2yLbFx5X6HdLkVwk2JFFdhKNhiYqtz0aTPa5JVDhpYa2opD9uf/
         GbCg8AMRDDOMl6oopDbABCgiUC9Bs7vjU6dKk08Ay2QyNSzfckgxelTVogA1yAfXatMD
         DnHQcIrUdqyp6Eq7wWxSb8WQwCquvRJRNmiCI4QvduDbuzMB4pdn/0W/6sxDIoCEdN35
         dsSE7ghD7TAzN5Es3D1fWq6G/K7TQVSNcPxwqfbGAeSjox7JfTytApNxSO1qMQ95qlKX
         /MbzewYt19+ekLzxTJX1gg61FuuuNEjAWHQdWR0DSaGQDbqEi1AOQIl+8D7fPJ6l+YkR
         Py4g==
X-Forwarded-Encrypted: i=1; AJvYcCUPf3haIU+hlk+IB1CsZdvnbgb99GNHYYrOX3Kkpwk28PmCPUPZ2WbJgfUkJ5JWe/DnUGLFW/WNw6+QPCdx@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9YsxZddv5vpSLDJUpW7/nRZh7doA42Em58DWkzJB3+TYBNzUI
	YC7OZnJQ/PtyNwjCMGDb+vQHpr7mN7DlV69Rp2KnrVdsx4tDqvhWVAi01FuvPTZSLZPLmuc818x
	ybaf2xZaweOWLRqXodHqZtQkfQ4dmzBOcYYVx
X-Gm-Gg: ASbGncuG8arlFEkMYyvNR9fG52zwrhxnS2TQReMi7wNq1DkxgPsIKzI0MmInh/wUx5t
	uHTEDWC7ychmuGsHD2QZrT4J3bY6DloAH7/k0ZxrFyUhYYhb3yGibv9fxcG3QREZbkVNhVROcw6
	p9tlqp1yQV/s2Cbhc8gWHDSKyXQKDD8tg8D5jkIVu5LnKs2FZiQ6I=
X-Google-Smtp-Source: AGHT+IFVcSZqF3LSwjizhWIDIAGbMvuwlg83EEH88/bio2Bjc5ERIX+1GSG2WXLcYBnNvvC4Sn5lwOVMlFwInA3a9MA=
X-Received: by 2002:aa7:cc12:0:b0:5e4:9ee2:afe1 with SMTP id
 4fb4d7f45d1cf-5f9132eb267mr41793a12.2.1746051863339; Wed, 30 Apr 2025
 15:24:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aAZMe21Ic2sDIAtY@harry> <aAa-gCSHDFcNS3HS@dread.disaster.area>
 <aAttYSQsYc5y1AZO@harry> <CAG48ez3W8-JH4QJsR5AS1Z0bLtfuS3qz7sSVtOH39vc_y534DQ@mail.gmail.com>
 <aBIhen0HXGgQf_d5@harry>
In-Reply-To: <aBIhen0HXGgQf_d5@harry>
From: Jann Horn <jannh@google.com>
Date: Thu, 1 May 2025 00:23:47 +0200
X-Gm-Features: ATxdqUGBf-5tMzw_PZpBetjJLb-AbditMFVlki6zbVxQVlraj4l0hnwwuUfe3hc
Message-ID: <CAG48ez3z6YPo9f_m5ErYJQi9O7DGdibBWqF1BqxVGN9AfvpMgA@mail.gmail.com>
Subject: Re: [DISCUSSION] Revisiting Slab Movable Objects
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Dave Chinner <david@fromorbit.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, "Tobin C. Harding" <tobin@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Matthew Wilcox <willy@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Rik van Riel <riel@surriel.com>, 
	Andrea Arcangeli <aarcange@redhat.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@kernel.org>, 
	Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 3:11=E2=80=AFPM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
> On Mon, Apr 28, 2025 at 05:31:35PM +0200, Jann Horn wrote:
> > On Fri, Apr 25, 2025 at 1:09=E2=80=AFPM Harry Yoo <harry.yoo@oracle.com=
> wrote:
> > > On Tue, Apr 22, 2025 at 07:54:08AM +1000, Dave Chinner wrote:
> > > > On Mon, Apr 21, 2025 at 10:47:39PM +0900, Harry Yoo wrote:
> > > > > Hi folks,
> > > > >
> > > > > As a long term project, I'm starting to look into resurrecting
> > > > > Slab Movable Objects. The goal is to make certain types of slab m=
emory
> > > > > movable and thus enable targeted reclamation, migration, and
> > > > > defragmentation.
> > > > >
> > > > > The main purpose of this posting is to briefly review what's been=
 tried
> > > > > in the past, ask people why prior efforts have stalled (due to la=
ck of
> > > > > time or insufficient justification for additional complexity?),
> > > > > and discuss what's feasible today.
> > > > >
> > > > > Please add anyone I may have missed to Cc. :)
> > > >
> > > > Adding -fsdevel because dentry/inode cache discussion needs to be
> > > > visible to all the fs/VFS developers.
> > > >
> > > > I'm going to cut straight to the chase here, but I'll leave the res=
t
> > > > of the original email quoted below for -fsdevel readers.
> > > >
> > > > > Previous Work on Slab Movable Objects
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >
> > > > <snip>
> > > >
> > > > Without including any sort of viable proposal for dentry/inode
> > > > relocation (i.e. the showstopper for past attempts), what is the
> > > > point of trying to ressurect this?
> > >
> > > Migrating slabs still makes sense for other objects such as xarray / =
maple
> > > tree nodes, and VMAs.
> >
> > Do we have examples of how much memory is actually wasted on
> > sparsely-used slabs, and which slabs this happens in, from some real
> > workloads?
>
> Workloads that uses a large amount of reclaimable slab memory (inode,
> dentry, etc.) and triggers reclamation can observe this problem.
>
> On my laptop, I can reproduce the problem by running 'updatedb' command
> that touches many files and triggering reclamation by running programs
> that consume large amount of memory. As slab memory is reclaimed, it beco=
mes
> sparsely populated (as slab memory is not reclaimed folio by folio)
>
> During reclamation, the total slab memory utilization drops from 95% to 5=
0%.
> For very sparsely populated caches, the cache utilization is between
> 12% and 33%. (ext4_inode_cache, radix_tree_node, dentry, trace_event_file=
,
> and some kmalloc caches on my machine).
>
> At the time OOM-killer is invoked, there's about 50% slab memory wasted
> due to sparsely populated slabs, which is about 236 MiB on my laptop.
> I would say it's a sufficiently big problem to solve.
>
> I wonder how worse this problem would be on large file servers,
> but I don't run such servers :-)
>
> > If sparsely-used slabs are a sufficiently big problem, maybe another
> > big hammer we have is to use smaller slab pages, or something along
> > those lines? Though of course a straightforward implementation of that
> > would probably have negative effects on the performance of SLUB
> > fastpaths, and depending on object size it might waste more memory on
> > padding.
>
> So it'll be something like prefering low orders when in calculate_order()
> while keeping fractional waste reasonably.
>
> One problem could be making n->list_lock contention much worse
> on larger machines as you need to grab more slabs from the list?

Maybe. I imagine using batched operations could help, such that the
amount of managed memory that is transferred per locking operation
stays the same...

> > (An adventurous idea would be to try to align kmem_cache::size such
> > that objects start at some subpage boundaries of SLUB folios, and then
> > figure out a way to shatter SLUB folios into smaller folios at runtime
> > while they contain objects... but getting the SLUB locking right for
> > that without slowing down the fastpath for freeing an object would
> > probably be a large pain.)
>
> You can't make virt_to_slab() work if you shatter a slab folio
> into smaller ones?

Yeah, I think that would be hard. We could maybe avoid the
virt_to_slab() on the active-slab fastpath, and maybe there is some
kind of RCU-transition scheme that could be used on the path for
non-active slabs (a bit similarly to how percpu refcounts transition
to atomic mode, with a transition period where objects are allowed to
still go on the freelist of the former head page)...

> A more general question: will either shattering or allocating
> smaller slabs help free more memory anyway? It likely depends on
> the spatial pattern of how the objects are reclaimed and remain
> populated within a slab?

Probably, yeah.

As a crude thought experiment, if you (somewhat pessimistically?)
assume that the spatial pattern is "we first allocate a lot of
objects, then for each object we roll a random number and free it with
a 90% probability", and you have something like a kmalloc-512 slab
(normal order 2, which fits 32 objects), then the probability that an
entire order-2 page will be empty would be
pow(0.9, 32) ~=3D 3.4%
while the probability that an individual order-0 page is empty would be
pow(0.9, 8) ~=3D 43%
There could be patterns that are worse, like "we preserve exactly
every fourth object"; though SLUB's freelist randomization (if
CONFIG_SLAB_FREELIST_RANDOM is enabled) would probably transform that
into a different pattern, so that it's not actually a sequential
pattern where every fourth object is allocated.

In case you want to do more detailed experiments with this: FYI, I
have a branch "slub-binary-snapshot" at https://github.com/thejh/linux
with a draft patch that provides a debugfs API for getting a binary
dump of SLUB allocations (I wrote that patch for another project):
https://github.com/thejh/linux/commit/685944dc69fd21e92bf110713b491d5c05032=
8af
- maybe with some changes that would be useful for analyzing SLUB
fragmentation from userspace.

But IDK if that's a good way to experiment with this, or if it'd be
easier to directly analyze fragmentation in debugfs code in SLUB.


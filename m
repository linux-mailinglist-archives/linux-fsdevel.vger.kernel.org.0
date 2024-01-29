Return-Path: <linux-fsdevel+bounces-9284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11ADD83FC0D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 03:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 817D2B21C6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 02:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFC9EADC;
	Mon, 29 Jan 2024 02:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z2660nzf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD963DF46
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 02:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706494349; cv=none; b=aHoBgNeszZgFBspdK/RwI/qSd+qcfUiBiINL5wKgA726sYK63bh+YMHXdLJx4qbEl8+7cnJem/XbjAe1ix5emjbv7NUZewdb7aIO8OE8C3E5GE+NyTb7ykMlmtvzpXxPCmZuP7hoKF50o1H00iyCLgz6wOiNzrffZuNQtER2R0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706494349; c=relaxed/simple;
	bh=74AaJSvp1x+QsqfBEbwtqQ2LgJrbhXQeDnDXDWIVpDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KxoxQchTXDXJOhllIZIz+vMBmpR0wl8yoqPERk9H/HVvUjlSrJkzGIfZiZLLwrihjNSkSxMILv0fLsho39kIWp7ywTLSeVQLO84bciQk2ZLr7q7sYPjQFkkiaFqdJ6pDtFdYk3OpVapcpK3noPVDZrAW29q2+SzX9XlE98Q/zl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z2660nzf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706494346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xJWg2PYEamb3ZegCQzkfF2MUl1gzSlbA9B2qC4uBssM=;
	b=Z2660nzfDrNwqdokqTzDVjixNtqRSDMgB/DonFSLfar9DwEV5+wsrQ0MhPSsva/x56G/Y6
	Dc8rm+TeuTmy8V/HLRZOMsq+1CIZxDP1VvXyf+d69cJ9REvrOrID501WXROqJGkM3nQfSE
	qlJCKX0mPKDulnZA9aO3vFi26mNq+R0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-eK5Fvvo9NTeIElxwuT7q1Q-1; Sun, 28 Jan 2024 21:12:25 -0500
X-MC-Unique: eK5Fvvo9NTeIElxwuT7q1Q-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a2d1e1fa245so99866466b.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jan 2024 18:12:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706494344; x=1707099144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJWg2PYEamb3ZegCQzkfF2MUl1gzSlbA9B2qC4uBssM=;
        b=xJRWr3l4L6nOlpwAXDlLkwwSaNFnVEZP3ndt4as5K89jVU9RxJHx7bD7nGiqs58XiQ
         KFL5HH3HyVeNbFj7E2YGiOcWWLullp1jxoR85lEqzNYi7qTt6tKcDsWCAwN4+qpV19Nt
         M2OjNAjJsERASMNapJFQ0C9pK5EGFowRiHpit0KuHMz3ZgsVpgPzx3e2b4htNUX7AJlC
         +UAV8RIhbwXaGTtMh7OOfWnpZQ98zXwNYH0n8/QH1HjaLV8yQdtufXnhLpfd6CPverg8
         Pqk3rm/tBguVQrZpG7Vg5XCRn00IWF6DzgMtOrztK6IxUS9d+KSCQlQYF8L8LA4mW/kT
         3snQ==
X-Gm-Message-State: AOJu0YzRig1ix/Dy/0YbamxFGelFMJ5iHbyQwa+h4G5QELkYmr5Be8XO
	yUMvxVI7DM38QdGsrwJUP9TOmzbEvYmN5mb9FgMB517MqdBid14ncOIxoXastZXsA1aHdh5dsgh
	MemiSX8H60NtCS9RwkgZB6Jstc3qEs/+TVg3M36luDekoROayHESy6jdTewWKYUahG6V83Hpw4M
	PFujlBhpll79AzZLDWkZMgPJiP7YNgySEpBoZt
X-Received: by 2002:a17:906:c097:b0:a2d:2121:2a93 with SMTP id f23-20020a170906c09700b00a2d21212a93mr3453544ejz.70.1706494344274;
        Sun, 28 Jan 2024 18:12:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGiFbrJmKuoTg7NfZCeLeu7gfR1ponzl4sUsXEQJ6nN5S021D9wfOn3F8TWqMMqPdPoyRd2vp8/+YquOqRouIk=
X-Received: by 2002:a17:906:c097:b0:a2d:2121:2a93 with SMTP id
 f23-20020a170906c09700b00a2d21212a93mr3453534ejz.70.1706494343887; Sun, 28
 Jan 2024 18:12:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240128142522.1524741-1-ming.lei@redhat.com> <ZbbPCQZdazF7s0_b@casper.infradead.org>
 <ZbbfXVg9FpWRUVDn@redhat.com> <ZbbvfFxcVgkwbhFv@casper.infradead.org>
 <CAH6w=aw_46Ker0w8HmSA41vUUDKGDGC3gxBFWAhd326+kEtrNg@mail.gmail.com> <ZbcDvTkeDKttPfJ4@dread.disaster.area>
In-Reply-To: <ZbcDvTkeDKttPfJ4@dread.disaster.area>
From: Mike Snitzer <snitzer@redhat.com>
Date: Sun, 28 Jan 2024 21:12:12 -0500
Message-ID: <CAH6w=azbfYCbC6m-bh-yUt3HMUe-EnWPV71P+Z=jeNwMU5aHaQ@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/readahead: readahead aggressively if read drops in
 willneed range
To: Dave Chinner <david@fromorbit.com>
Cc: Mike Snitzer <snitzer@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Ming Lei <ming.lei@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Don Dutile <ddutile@redhat.com>, 
	Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2024 at 8:48=E2=80=AFPM Dave Chinner <david@fromorbit.com> =
wrote:
>
> On Sun, Jan 28, 2024 at 07:39:49PM -0500, Mike Snitzer wrote:
> > On Sun, Jan 28, 2024 at 7:22=E2=80=AFPM Matthew Wilcox <willy@infradead=
.org> wrote:
> > >
> > > On Sun, Jan 28, 2024 at 06:12:29PM -0500, Mike Snitzer wrote:
> > > > On Sun, Jan 28 2024 at  5:02P -0500,
> > > > Matthew Wilcox <willy@infradead.org> wrote:
> > > Understood.  But ... the application is asking for as much readahead =
as
> > > possible, and the sysadmin has said "Don't readahead more than 64kB a=
t
> > > a time".  So why will we not get a bug report in 1-15 years time sayi=
ng
> > > "I put a limit on readahead and the kernel is ignoring it"?  I think
> > > typically we allow the sysadmin to override application requests,
> > > don't we?
> >
> > The application isn't knowingly asking for readahead.  It is asking to
> > mmap the file (and reporter wants it done as quickly as possible..
> > like occurred before).
>
> .. which we do within the constraints of the given configuration.
>
> > This fix is comparable to Jens' commit 9491ae4aade6 ("mm: don't cap
> > request size based on read-ahead setting") -- same logic, just applied
> > to callchain that ends up using madvise(MADV_WILLNEED).
>
> Not really. There is a difference between performing a synchronous
> read IO here that we must complete, compared to optimistic
> asynchronous read-ahead which we can fail or toss away without the
> user ever seeing the data the IO returned.
>
> We want required IO to be done in as few, larger IOs as possible,
> and not be limited by constraints placed on background optimistic
> IOs.
>
> madvise(WILLNEED) is optimistic IO - there is no requirement that it
> complete the data reads successfully. If the data is actually
> required, we'll guarantee completion when the user accesses it, not
> when madvise() is called.  IOWs, madvise is async readahead, and so
> really should be constrained by readahead bounds and not user IO
> bounds.
>
> We could change this behaviour for madvise of large ranges that we
> force into the page cache by ignoring device readahead bounds, but
> I'm not sure we want to do this in general.
>
> Perhaps fadvise/madvise(willneed) can fiddle the file f_ra.ra_pages
> value in this situation to override the device limit for large
> ranges (for some definition of large - say 10x bdi->ra_pages) and
> restore it once the readahead operation is done. This would make it
> behave less like readahead and more like a user read from an IO
> perspective...

I'm not going to pretend like I'm an expert in this code or all the
distinctions that are in play.  BUT, if you look at the high-level
java reproducer: it is requesting mmap of a finite size, starting from
the beginning of the file:
FileChannel fc =3D new RandomAccessFile(new File(args[0]), "rw").getChannel=
();
MappedByteBuffer mem =3D fc.map(FileChannel.MapMode.READ_ONLY, 0, fc.size()=
);

Yet you're talking about the application like it is stabbingly
triggering unbounded async reads that can get dropped, etc, etc.  I
just want to make sure the subtlety of (ab)using madvise(WILLNEED)
like this app does isn't incorrectly attributed to something it isn't.
The app really is effectively requesting a user read of a particular
extent in terms of mmap, right?

BTW, your suggestion to have this app fiddle with ra_pages and then
reset it is pretty awful (that is a global setting, being tweaked for
a single use, and exposing random IO to excessive readahead should
there be a heavy mix of IO to the backing block device).  Seems the
app is providing plenty of context that it shouldn't be bounded in
terms of readahead limits, so much so that Ming's patch is conveying
the range the madvise(WILLNEED) is provided by the app so as to _know_
if the requested page(s) fall within the requested size; Linux just
happens to be fulfilling the syscall in terms of readahead.

FYI, here is the evolution of this use-case back from when it issued
larger IO back in 3.14, Ming documented it I'm just sharing in case it
helps:

3.14:
madvise_willneed() -> force_page_cache_readahead()
force_page_cache_readahead() will read all pages in the specified range

3.15:
madvise_willneed() -> vfs_fadvise() -> generic_fadvise() ->
  force_page_cache_readahead()

force_page_cache_readahead() only reads at most device max_sectors bytes,
and the remainder is read in filemap_fault()

Things start to change since:

1) 6d2be915e589 ("mm/readahead.c: fix readahead failure for memoryless
NUMA nodes
and limit readahead max_pages")
which limits at most 2Mbytes to be read in madvise_willneed()
so the remained bytes are read in filemap_fault() via normal readahead

2) 600e19afc5f8 ("mm: use only per-device readahead limit")
limits at most .ra_pages bytes to read in madvise_willneed()

3) 9491ae4aade6 ("mm: don't cap request size based on read-ahead setting")
relax the limit by reading at most max sectors bytes in madvise_willneed()



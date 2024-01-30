Return-Path: <linux-fsdevel+bounces-9479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B93841A49
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 04:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCC502838FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 03:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9114374F6;
	Tue, 30 Jan 2024 03:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bkCxXnGg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB0F37169
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jan 2024 03:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706584447; cv=none; b=W3P/EKS3zPRC/48nXRSgltRcfkJYYgvJ2vp/uLmt6YF72v8dzUPLWMDesCy/2mtrrLvE2+bzLV4BGoyoyZVojDSenrZzd0NOQ3SiwpFrMQYacF+OGskBQYN9okdMMiLsBoaqTYwbP6l6qPn4VjjPpchZvpOIxJOB8I7EtkDSag0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706584447; c=relaxed/simple;
	bh=Anlnndisu3bRGr1jkNZYWNrE2DXFkUmm2x7ykjyJC6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ofu6yBV93iYKsn7SYvMYAXBy1gl4XjrzPu6P0wQJCWcGv1EMRlyKLktYm9DZyN4w0cufzZR1Go/fZBYdwfMHWyYXx9DqWZSmuHvgZJTgwe3whqKge+QnyCLlpUoZHCvJ4ci9/v9DZEWQis6Zk/7z9gPocXJ2LC8WYaVUnvwhnrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bkCxXnGg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706584444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TVq1ppYllNcIlWc84EaU++Ss7ViF/DGHakMDrtuX2ZM=;
	b=bkCxXnGgtYnoDo3RmqzlScZrhT2t6WiIVCaFsAhhgozdr5oJjcbHzEA9UMqbaVZfEncFo5
	BDRw7GKbP4AIfd7ibCCaNbe5ohPi7udWkVkrdlUiedWtuWL/70hX3KlgK8uLsMLJTgMap0
	JXXfmG1ACnsJfv0C2bceZMNcSzteX5c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-x79AmTViNf6sV6skR12ArA-1; Mon, 29 Jan 2024 22:14:00 -0500
X-MC-Unique: x79AmTViNf6sV6skR12ArA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 140B883FC23;
	Tue, 30 Jan 2024 03:14:00 +0000 (UTC)
Received: from fedora (unknown [10.72.116.118])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 72727492BE2;
	Tue, 30 Jan 2024 03:13:54 +0000 (UTC)
Date: Tue, 30 Jan 2024 11:13:50 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Dave Chinner <david@fromorbit.com>
Cc: Mike Snitzer <snitzer@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Don Dutile <ddutile@redhat.com>,
	Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, linux-block@vger.kernel.org,
	ming.lei@redhat.com
Subject: Re: [RFC PATCH] mm/readahead: readahead aggressively if read drops
 in willneed range
Message-ID: <ZbhpbpeV6ChPD9NT@fedora>
References: <20240128142522.1524741-1-ming.lei@redhat.com>
 <ZbbPCQZdazF7s0_b@casper.infradead.org>
 <ZbbfXVg9FpWRUVDn@redhat.com>
 <ZbbvfFxcVgkwbhFv@casper.infradead.org>
 <CAH6w=aw_46Ker0w8HmSA41vUUDKGDGC3gxBFWAhd326+kEtrNg@mail.gmail.com>
 <ZbcDvTkeDKttPfJ4@dread.disaster.area>
 <ZbciOba1h3V9mmup@fedora>
 <Zbc0ZJceZPyt8m7q@dread.disaster.area>
 <ZbdhBaXkXm6xyqgC@fedora>
 <ZbghnK+Hs+if6vEz@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZbghnK+Hs+if6vEz@dread.disaster.area>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On Tue, Jan 30, 2024 at 09:07:24AM +1100, Dave Chinner wrote:
> On Mon, Jan 29, 2024 at 04:25:41PM +0800, Ming Lei wrote:
> > On Mon, Jan 29, 2024 at 04:15:16PM +1100, Dave Chinner wrote:
> > > On Mon, Jan 29, 2024 at 11:57:45AM +0800, Ming Lei wrote:
> > > > On Mon, Jan 29, 2024 at 12:47:41PM +1100, Dave Chinner wrote:
> > > > > On Sun, Jan 28, 2024 at 07:39:49PM -0500, Mike Snitzer wrote:
> > > > Follows the current report:
> > > > 
> > > > 1) usersapce call madvise(willneed, 1G)
> > > > 
> > > > 2) only the 1st part(size is from bdi->io_pages, suppose it is 2MB) is
> > > > readahead in madvise(willneed, 1G) since commit 6d2be915e589
> > > > 
> > > > 3) the other parts(2M ~ 1G) is readahead by unit of bdi->ra_pages which is
> > > > set as 64KB by userspace when userspace reads the mmaped buffer, then
> > > > the whole application becomes slower.
> > > 
> > > It gets limited by file->f_ra->ra_pages being initialised to
> > > bdi->ra_pages and then never changed as the advice for access
> > > methods to the file are changed.
> > > 
> > > But the problem here is *not the readahead code*. The problem is
> > > that the user has configured the device readahead window to be far
> > > smaller than is optimal for the storage. Hence readahead is slow.
> > > The fix for that is to either increase the device readahead windows,
> > > or to change the specific readahead window for the file that has
> > > sequential access patterns.
> > > 
> > > Indeed, we already have that - FADV_SEQUENTIAL will set
> > > file->f_ra.ra_pages to 2 * bdi->ra_pages so that readahead uses
> > > larger IOs for that access.
> > > 
> > > That's what should happen here - MADV_WILLNEED does not imply a
> > > specific access pattern so the application should be running
> > > MADV_SEQUENTIAL (triggers aggressive readahead) then MADV_WILLNEED
> > > to start the readahead, and then the rest of the on-demand readahead
> > > will get the higher readahead limits.
> > > 
> > > > This patch changes 3) to use bdi->io_pages as readahead unit.
> > > 
> > > I think it really should be changing MADV/FADV_SEQUENTIAL to set
> > > file->f_ra.ra_pages to bdi->io_pages, not bdi->ra_pages * 2, and the
> > > mem.load() implementation in the application converted to use
> > > MADV_SEQUENTIAL to properly indicate it's access pattern to the
> > > readahead algorithm.
> > 
> > Here the single .ra_pages may not work, that is why this patch stores
> > the willneed range in maple tree, please see the following words from
> > the original RH report:
> 
> > "
> > Increasing read ahead is not an option as it has a mixed I/O workload of
> > random I/O and sequential I/O, so that a large read ahead is very counterproductive
> > to the random I/O and is unacceptable.
> > "
> 
> Yes, I've read the bug. There's no triage that tells us what the
> root cause of the application perofrmance issue might be. Just an
> assertion that "this is how we did it 10 years ago, it's been
> unchanged for all this time, the new kernel we are upgrading
> to needs to behave exactly like pre-3.10 era kernels did.
> 
> And to be totally honest, my instincts tell me this is more likely a
> problem with a root cause in poor IO scheduling decisions than be a
> problem with the page cache readahead implementation. Readahead has
> been turned down to stop the bandwidth it uses via background async
> read IO from starving latency dependent foreground random IO
> operation, and then we're being asked to turn readahead back up
> in specific situations because it's actually needed for performance
> in certain access patterns. This is the sort of thing bfq is
> intended to solve.

Reading mmaped buffer in userspace is sync IO, and page fault just
readahead 64KB. I don't understand how block IO scheduler makes a
difference in this single 64KB readahead in case of cache miss.

> 
> 
> > Also almost all these advises(SEQUENTIA, WILLNEED, NORMAL, RANDOM)
> > ignore the passed range, and the behavior becomes all or nothing,
> > instead of something only for the specified range, which may not
> > match with man, please see 'man posix_fadvise':
> 
> The man page says:
> 
> 	The advice is not binding; it merely constitutes an
> 	expectation on behalf of the application.
> 
> > It is even worse for readahead() syscall:
> > 
> > 	``` DESCRIPTION readahead()  initiates readahead on a file
> > 	so that subsequent reads from that file will be satisfied
> > 	from the cache, and not block on disk I/O (assuming the
> > 	readahead was initiated early enough and that other activity
> > 	on the system did not in the meantime flush pages from the
> > 	cache).  ```
> 
> Yes, that's been "broken" for a long time (since the changes to cap
> force_page_cache_readahead() to ra_pages way back when), but the
> assumption documented about when readahead(2) will work goes to the
> heart of why we don't let user controlled readahead actually do much
> in the way of direct readahead. i.e. too much readahead is
> typically harmful to IO and system performance and very, very few
> applications actually need files preloaded entirely into memory.

It is true for normal readahead, but not sure if it is for
advise(willneed) or readahead().

> 
> ----
> 
> All said, I'm starting to think that there isn't an immediate
> upstream kernel change needed right now.  I just did a quick check
> through the madvise() man page to see if I'd missed anything, and I
> most definitely did miss what is a relatively new addition to it:
> 
> MADV_POPULATE_READ (since Linux 5.14)
>      "Populate (prefault) page tables readable, faulting in all
>      pages in the range just as if manually reading from each page;
>      however, avoid the actual memory access that would have been
>      performed after handling the fault.
> 
>      In contrast to MAP_POPULATE, MADV_POPULATE_READ does not hide
>      errors, can be applied to (parts of) existing mappings and will
>      al‐ ways  populate (prefault) page tables readable.  One
>      example use case is prefaulting a file mapping, reading all
>      file content from disk; however, pages won't be dirtied and
>      consequently won't have to be written back to disk when
>      evicting the pages from memory.
> 
> That's exactly what the application is apparently wanting
> MADV_WILLNEED to do.

Indeed, it works as expected(all mmapped pages are load in
madvise(MADV_POPULATE_READ)) in my test code except for 16 ra_pages, but
it is less important now.

Thanks for this idea!

> 
> Please read the commit message for commit 4ca9b3859dac ("mm/madvise:
> introduce MADV_POPULATE_(READ|WRITE) to prefault page tables"). It
> has some relevant commentary on why MADV_WILLNEED could not be
> modified to meet the pre-population requirements of the applications
> that required this pre-population behaviour from the kernel.
> 
> With this, I suspect that the application needs to be updated to
> use MADV_POPULATE_READ rather than MADV_WILLNEED, and then we can go
> back and do some analysis of the readahead behaviour of the
> application and the MADV_POPULATE_READ operation. We may need to
> tweak MADV_POPULATE_READ for large readahead IO, but that's OK
> because it's no longer "optimistic speculation" about whether the
> data is needed in cache - the operation being performed guarantees
> that or it fails with an error. IOWs, MADV_POPULATE_READ is
> effectively user data IO at this point, not advice about future
> access patterns...

BTW, in this report, MADV_WILLNEED is used by java library[1], and I
guess it could be difficult to update to MADV_POPULATE_READ.

[1] https://docs.oracle.com/javase/8/docs/api/java/nio/MappedByteBuffer.html



Thanks,
Ming



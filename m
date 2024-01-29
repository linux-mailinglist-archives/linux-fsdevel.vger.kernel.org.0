Return-Path: <linux-fsdevel+bounces-9329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08980840002
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 09:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68458B22F46
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 08:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E051B53E3D;
	Mon, 29 Jan 2024 08:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RFSjOxTM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C6552F9E
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 08:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706516759; cv=none; b=UBBfRocTUrkob0iKxY5Gfv/7LBF5niWfcN//o76kb3f4ET4LfKqQF3pqjl666SObtR47tZY1n5dTclg41sJzpbpX6V63FhcN4dP7YesHuljdm+3qHUz1x+EJUrOIBXEe0XYNBSfHbQLU23D8yOzrjsW+f3LAzDJFn8vIRqGkbEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706516759; c=relaxed/simple;
	bh=jMR3whdAdIw5gRYP3DqIFNffqCdwTzfKu98NcVeOH8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRoMjEBXRALg7qv8tmH2pco4NXrHsB/fwtx9CFK+IBQYK16fejkGJlRZVniBOHxbi+IgBmb3AZOTX7kAIGxqeKQNqIpmXQ4MLvYCtdaEItNmBIrkQ6P9rocmkfZ24Vyjbr7uReKuq+zgxm0xPEUJ86xUMTMejE7RLJEHbT8xWBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RFSjOxTM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706516756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vl5WFT1mb4nq6HAbxmLogsdFwcpzbMyLDtITeh8IDsY=;
	b=RFSjOxTMFQY/eT40Il1CVba3IgBtT7wm1tKaSCZWpuXEg9Y70J1zfMxn88QUf7tcQt2TEc
	7SPdjRp65ToE67AyZp73dlNScp+Gb3H4p3lSo/zVXWVjmAgYDeQsTK+9RBjQbZjrhmWhBK
	VppSsHbAOqiq+X6uBm9OSjQj3+c5fgM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-bc6dSSAvNieEZHYt5F9o5w-1; Mon,
 29 Jan 2024 03:25:51 -0500
X-MC-Unique: bc6dSSAvNieEZHYt5F9o5w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F75428B72E9;
	Mon, 29 Jan 2024 08:25:51 +0000 (UTC)
Received: from fedora (unknown [10.72.116.8])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 77965C2590E;
	Mon, 29 Jan 2024 08:25:45 +0000 (UTC)
Date: Mon, 29 Jan 2024 16:25:41 +0800
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
Message-ID: <ZbdhBaXkXm6xyqgC@fedora>
References: <20240128142522.1524741-1-ming.lei@redhat.com>
 <ZbbPCQZdazF7s0_b@casper.infradead.org>
 <ZbbfXVg9FpWRUVDn@redhat.com>
 <ZbbvfFxcVgkwbhFv@casper.infradead.org>
 <CAH6w=aw_46Ker0w8HmSA41vUUDKGDGC3gxBFWAhd326+kEtrNg@mail.gmail.com>
 <ZbcDvTkeDKttPfJ4@dread.disaster.area>
 <ZbciOba1h3V9mmup@fedora>
 <Zbc0ZJceZPyt8m7q@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zbc0ZJceZPyt8m7q@dread.disaster.area>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On Mon, Jan 29, 2024 at 04:15:16PM +1100, Dave Chinner wrote:
> On Mon, Jan 29, 2024 at 11:57:45AM +0800, Ming Lei wrote:
> > On Mon, Jan 29, 2024 at 12:47:41PM +1100, Dave Chinner wrote:
> > > On Sun, Jan 28, 2024 at 07:39:49PM -0500, Mike Snitzer wrote:
> > > > On Sun, Jan 28, 2024 at 7:22 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > > >
> > > > > On Sun, Jan 28, 2024 at 06:12:29PM -0500, Mike Snitzer wrote:
> > > > > > On Sun, Jan 28 2024 at  5:02P -0500,
> > > > > > Matthew Wilcox <willy@infradead.org> wrote:
> > > > > Understood.  But ... the application is asking for as much readahead as
> > > > > possible, and the sysadmin has said "Don't readahead more than 64kB at
> > > > > a time".  So why will we not get a bug report in 1-15 years time saying
> > > > > "I put a limit on readahead and the kernel is ignoring it"?  I think
> > > > > typically we allow the sysadmin to override application requests,
> > > > > don't we?
> > > > 
> > > > The application isn't knowingly asking for readahead.  It is asking to
> > > > mmap the file (and reporter wants it done as quickly as possible..
> > > > like occurred before).
> > > 
> > > ... which we do within the constraints of the given configuration.
> > > 
> > > > This fix is comparable to Jens' commit 9491ae4aade6 ("mm: don't cap
> > > > request size based on read-ahead setting") -- same logic, just applied
> > > > to callchain that ends up using madvise(MADV_WILLNEED).
> > > 
> > > Not really. There is a difference between performing a synchronous
> > > read IO here that we must complete, compared to optimistic
> > > asynchronous read-ahead which we can fail or toss away without the
> > > user ever seeing the data the IO returned.
> > 
> > Yeah, the big readahead in this patch happens when user starts to read
> > over mmaped buffer instead of madvise().
> 
> Yes, that's how it is intended to work :/
> 
> > > We want required IO to be done in as few, larger IOs as possible,
> > > and not be limited by constraints placed on background optimistic
> > > IOs.
> > > 
> > > madvise(WILLNEED) is optimistic IO - there is no requirement that it
> > > complete the data reads successfully. If the data is actually
> > > required, we'll guarantee completion when the user accesses it, not
> > > when madvise() is called.  IOWs, madvise is async readahead, and so
> > > really should be constrained by readahead bounds and not user IO
> > > bounds.
> > > 
> > > We could change this behaviour for madvise of large ranges that we
> > > force into the page cache by ignoring device readahead bounds, but
> > > I'm not sure we want to do this in general.
> > > 
> > > Perhaps fadvise/madvise(willneed) can fiddle the file f_ra.ra_pages
> > > value in this situation to override the device limit for large
> > > ranges (for some definition of large - say 10x bdi->ra_pages) and
> > > restore it once the readahead operation is done. This would make it
> > > behave less like readahead and more like a user read from an IO
> > > perspective...
> > 
> > ->ra_pages is just one hint, which is 128KB at default, and either
> > device or userspace can override it.
> > 
> > fadvise/madvise(willneed) already readahead bytes from bdi->io_pages which
> > is the max device sector size(often 10X of ->ra_pages), please see
> > force_page_cache_ra().
> 
> Yes, but if we also change vma->file->f_ra->ra_pages during the
> WILLNEED operation (as we do for FADV_SEQUENTIAL) then we get a
> larger readahead window for the demand-paged access portion of the
> WILLNEED access...
> 
> > 
> > Follows the current report:
> > 
> > 1) usersapce call madvise(willneed, 1G)
> > 
> > 2) only the 1st part(size is from bdi->io_pages, suppose it is 2MB) is
> > readahead in madvise(willneed, 1G) since commit 6d2be915e589
> > 
> > 3) the other parts(2M ~ 1G) is readahead by unit of bdi->ra_pages which is
> > set as 64KB by userspace when userspace reads the mmaped buffer, then
> > the whole application becomes slower.
> 
> It gets limited by file->f_ra->ra_pages being initialised to
> bdi->ra_pages and then never changed as the advice for access
> methods to the file are changed.
> 
> But the problem here is *not the readahead code*. The problem is
> that the user has configured the device readahead window to be far
> smaller than is optimal for the storage. Hence readahead is slow.
> The fix for that is to either increase the device readahead windows,
> or to change the specific readahead window for the file that has
> sequential access patterns.
> 
> Indeed, we already have that - FADV_SEQUENTIAL will set
> file->f_ra.ra_pages to 2 * bdi->ra_pages so that readahead uses
> larger IOs for that access.
> 
> That's what should happen here - MADV_WILLNEED does not imply a
> specific access pattern so the application should be running
> MADV_SEQUENTIAL (triggers aggressive readahead) then MADV_WILLNEED
> to start the readahead, and then the rest of the on-demand readahead
> will get the higher readahead limits.
> 
> > This patch changes 3) to use bdi->io_pages as readahead unit.
> 
> I think it really should be changing MADV/FADV_SEQUENTIAL to set
> file->f_ra.ra_pages to bdi->io_pages, not bdi->ra_pages * 2, and the
> mem.load() implementation in the application converted to use
> MADV_SEQUENTIAL to properly indicate it's access pattern to the
> readahead algorithm.

Here the single .ra_pages may not work, that is why this patch stores
the willneed range in maple tree, please see the following words from
the original RH report:

"
Increasing read ahead is not an option as it has a mixed I/O workload of
random I/O and sequential I/O, so that a large read ahead is very counterproductive
to the random I/O and is unacceptable.
"

Also almost all these advises(SEQUENTIA, WILLNEED, NORMAL, RANDOM)
ignore the passed range, and the behavior becomes all or nothing,
instead of something only for the specified range, which may not
match with man, please see 'man posix_fadvise':

	```
       POSIX_FADV_NORMAL
              Indicates that the application has no advice to give about its access
			  pattern for the specified data.  If no advice is given for an open file,
			  this is the default assumption.

       POSIX_FADV_SEQUENTIAL
              The application expects to access the specified data sequentially (with
			  lower offsets read before higher ones).

       POSIX_FADV_RANDOM
              The specified data will be accessed in random order.

       POSIX_FADV_NOREUSE
              The specified data will be accessed only once.

              In kernels before 2.6.18, POSIX_FADV_NOREUSE had the same semantics as
			  POSIX_FADV_WILLNEED.  This was probably a bug; since kernel 2.6.18, this
			  flag is a no-op.

       POSIX_FADV_WILLNEED
              The specified data will be accessed in the near future.
	```

It is even worse for readahead() syscall:

	```
	DESCRIPTION
	       readahead()  initiates readahead on a file so that subsequent reads from that
		   file will be satisfied from the cache, and not block on disk I/O (assuming the
		   readahead was initiated early enough and that other activity on the system did
		   not in the meantime flush pages from the cache).
	```


Thanks,
Ming



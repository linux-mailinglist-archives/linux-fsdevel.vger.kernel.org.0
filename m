Return-Path: <linux-fsdevel+bounces-9288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFDB83FCA8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 04:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 044BAB21222
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 03:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDBCFC0C;
	Mon, 29 Jan 2024 03:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GRMqTOOW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3DDF9DA
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 03:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706498439; cv=none; b=TWIrctP16NwT3P1FGPhN4lvwA2Mxq/nFakJ1fq7AUp9bx7Ant0DTS9bfcJvudgF3t6gPC/C57jTov1xPMWxI21LIFYlNhwZ92TqdRVBQvX0v+e7adWhJvL6QeTAndpIk5rk5DC25zh+VZAg3HHrKEM8ROOI7IM550KJUYFU1LXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706498439; c=relaxed/simple;
	bh=r/4Yclr74ahtXpXV+m5YFeBz0Y8jrHDZvJEmycRcYo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PseovqUszBcjBnrrqL8PBAm+6ShcHIkfBijpQULr7k4uTnzKJPeqTaLa9rQVPQkewx/+YnW/eb7H3C76ygRpPFRefEBIpzqe5UUL7abbwHqGGU5QgU+wT0w0X/NKy6uqsPE8G9OjpPl3loyiQy36bSuGYJYUjgABpgMR44RMaLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GRMqTOOW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706498436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7G+EdxBrZWtWfEsSXmLsfmBlcaKy+iy1nng6IU24Ic8=;
	b=GRMqTOOWpvnv+3U6IX5KHA8yhaXPFJziuz4tlQNvx0QDGBCO0ThpYDhWYM7RrOp6xdIggG
	mV9j9DMGWG9KTZpppHi8PZp7avvdXw6U2J9xiTk6qHcHsJNXnJ6jICftL3Cg1qD0uUoRhP
	MnIL4GmpzyIOdsc7yVz/EvtqErZCCFE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-163-n_431acuNtSus-asaD7sqQ-1; Sun,
 28 Jan 2024 22:20:34 -0500
X-MC-Unique: n_431acuNtSus-asaD7sqQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 212553C14942;
	Mon, 29 Jan 2024 03:20:34 +0000 (UTC)
Received: from fedora (unknown [10.72.116.135])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D6C94487;
	Mon, 29 Jan 2024 03:20:28 +0000 (UTC)
Date: Mon, 29 Jan 2024 11:20:24 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Mike Snitzer <snitzer@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Don Dutile <ddutile@redhat.com>,
	Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, ming.lei@redhat.com
Subject: Re: [RFC PATCH] mm/readahead: readahead aggressively if read drops
 in willneed range
Message-ID: <ZbcZeHHzzO7sPuYB@fedora>
References: <20240128142522.1524741-1-ming.lei@redhat.com>
 <ZbbPCQZdazF7s0_b@casper.infradead.org>
 <ZbbfXVg9FpWRUVDn@redhat.com>
 <ZbbvfFxcVgkwbhFv@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbbvfFxcVgkwbhFv@casper.infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Mon, Jan 29, 2024 at 12:21:16AM +0000, Matthew Wilcox wrote:
> On Sun, Jan 28, 2024 at 06:12:29PM -0500, Mike Snitzer wrote:
> > On Sun, Jan 28 2024 at  5:02P -0500,
> > Matthew Wilcox <willy@infradead.org> wrote:
> > 
> > > On Sun, Jan 28, 2024 at 10:25:22PM +0800, Ming Lei wrote:
> > > > Since commit 6d2be915e589 ("mm/readahead.c: fix readahead failure for
> > > > memoryless NUMA nodes and limit readahead max_pages"), ADV_WILLNEED
> > > > only tries to readahead 512 pages, and the remained part in the advised
> > > > range fallback on normal readahead.
> > > 
> > > Does the MAINTAINERS file mean nothing any more?
> > 
> > "Ming, please use scripts/get_maintainer.pl when submitting patches."
> 
> That's an appropriate response to a new contributor, sure.  Ming has
> been submitting patches since, what, 2008?  Surely they know how to
> submit patches by now.
> 
> > I agree this patch's header could've worked harder to establish the
> > problem that it fixes.  But I'll now take a crack at backfilling the
> > regression report that motivated this patch be developed:
> 
> Thank you.
> 
> > Linux 3.14 was the last kernel to allow madvise (MADV_WILLNEED)
> > allowed mmap'ing a file more optimally if read_ahead_kb < max_sectors_kb.
> > 
> > Ths regressed with commit 6d2be915e589 (so Linux 3.15) such that
> > mounting XFS on a device with read_ahead_kb=64 and max_sectors_kb=1024
> > and running this reproducer against a 2G file will take ~5x longer
> > (depending on the system's capabilities), mmap_load_test.java follows:
> > 
> > import java.nio.ByteBuffer;
> > import java.nio.ByteOrder;
> > import java.io.RandomAccessFile;
> > import java.nio.MappedByteBuffer;
> > import java.nio.channels.FileChannel;
> > import java.io.File;
> > import java.io.FileNotFoundException;
> > import java.io.IOException;
> > 
> > public class mmap_load_test {
> > 
> >         public static void main(String[] args) throws FileNotFoundException, IOException, InterruptedException {
> > 		if (args.length == 0) {
> > 			System.out.println("Please provide a file");
> > 			System.exit(0);
> > 		}
> > 		FileChannel fc = new RandomAccessFile(new File(args[0]), "rw").getChannel();
> > 		MappedByteBuffer mem = fc.map(FileChannel.MapMode.READ_ONLY, 0, fc.size());
> > 
> > 		System.out.println("Loading the file");
> > 
> > 		long startTime = System.currentTimeMillis();
> > 		mem.load();
> > 		long endTime = System.currentTimeMillis();
> > 		System.out.println("Done! Loading took " + (endTime-startTime) + " ms");
> > 		
> > 	}
> > }
> 
> It's good to have the original reproducer.  The unfortunate part is
> that being at such a high level, it doesn't really show what syscalls
> the library makes on behalf of the application.  I'll take your word
> for it that it calls madvise(MADV_WILLNEED).  An strace might not go
> amiss.

Yeah, it can be fadvise(WILLNEED)/readahead syscall too.

> 
> > reproduce with:
> > 
> > javac mmap_load_test.java
> > echo 64 > /sys/block/sda/queue/read_ahead_kb
> > echo 1024 > /sys/block/sda/queue/max_sectors_kb
> > mkfs.xfs /dev/sda
> > mount /dev/sda /mnt/test
> > dd if=/dev/zero of=/mnt/test/2G_file bs=1024k count=2000
> > 
> > echo 3 > /proc/sys/vm/drop_caches
> 
> (I prefer to unmount/mount /mnt/test; it drops the cache for
> /mnt/test/2G_file without affecting the rest of the system)
> 
> > java mmap_load_test /mnt/test/2G_file
> > 
> > Without a fix, like the patch Ming provided, iostat will show rareq-sz
> > is 64 rather than ~1024.
> 
> Understood.  But ... the application is asking for as much readahead as
> possible, and the sysadmin has said "Don't readahead more than 64kB at
> a time".  So why will we not get a bug report in 1-15 years time saying
> "I put a limit on readahead and the kernel is ignoring it"?  I think
> typically we allow the sysadmin to override application requests,
> don't we?

ra_pages is just one hint for readahead, the reality is that sysadmin
can't understand how much bytes is perfect for readahead.

But application often knows how much bytes it will need, so here
I think application requirement should have higher priority, especially
when application doesn't want kernel to readahead blindly.

And madvise/fadvise(WILLNEED) syscall already reads bdi->io_pages
first, and which is bigger than ra_pages.


Thanks, 
Ming



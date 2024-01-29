Return-Path: <linux-fsdevel+bounces-9276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0D983FB2E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 01:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47DD9B22A2C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 00:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA2D468E;
	Mon, 29 Jan 2024 00:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YrQM/5A1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454692106;
	Mon, 29 Jan 2024 00:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706487682; cv=none; b=kSjcqioHk6KS2u7QAYgg15hYBeB30OvUwi7LO3GvoZkuE116W0VmVxueoPkZnd/z3ZTwiFtXu5OxSXy9z0xCs6tTv6cjz0HseZfG18O8EWkd1oUokltEJKQynrqTgIT2GNHwz5PIl79AYp975NaoMpYU6DiK9sg7WRyLzKOlq6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706487682; c=relaxed/simple;
	bh=suxJoQ6Tx+wCWAmdF+akYk+1aZaESx8sHvpnaMX8/Jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VScdWBHk0jh0DSp94lMs8B5n3il7eLMtYfSM+4Nmll9gJ6JkrOW1VeghBFa0/5giBwqAc/2jtN3nvXroh7f428kf9WxpH1wHce8kNIr+9LWDXqGO87pwXVV70fpfuJEFAt2Ns+J+EXXbU1iykrGGFoezqwt9oQuhGOwFDoS+S4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YrQM/5A1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TtcvkfpjeeZrMMvO5FMe9b4Sy38+nE76hEUK8iZvFVU=; b=YrQM/5A1V/xN0zBHd0Tl1PDh5h
	fpS54DN4lYo/murXbdbzG5CGsZgqP4yal7mkBQxPIknYMVeUyrtxTrznzLT/PZ3SVlLnQC6UX9lQW
	7KiIIj+yhOrmb5ws5z+GPF0x3cG5hQoI2nJhRwl6e4K02a1shj9GKSqGE//taor2XTj2rDiMNuBS/
	IOtwCbsx2ofToRNyQZpz2/uMf3+rApIosBa8VWvFn17naRWtZz22PihuWw5NVf99FRUalUFwznIz8
	fb7uWzn/y8fp3f1/mXWfVTV9rJHZQRTY0CAk25yp1fHXFQPxK9JoLJI+psU6AhNq616ODzUDdHl68
	Zn5hctlA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUFOm-00000004ynq-1UyX;
	Mon, 29 Jan 2024 00:21:16 +0000
Date: Mon, 29 Jan 2024 00:21:16 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Don Dutile <ddutile@redhat.com>,
	Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC PATCH] mm/readahead: readahead aggressively if read drops
 in willneed range
Message-ID: <ZbbvfFxcVgkwbhFv@casper.infradead.org>
References: <20240128142522.1524741-1-ming.lei@redhat.com>
 <ZbbPCQZdazF7s0_b@casper.infradead.org>
 <ZbbfXVg9FpWRUVDn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbbfXVg9FpWRUVDn@redhat.com>

On Sun, Jan 28, 2024 at 06:12:29PM -0500, Mike Snitzer wrote:
> On Sun, Jan 28 2024 at  5:02P -0500,
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > On Sun, Jan 28, 2024 at 10:25:22PM +0800, Ming Lei wrote:
> > > Since commit 6d2be915e589 ("mm/readahead.c: fix readahead failure for
> > > memoryless NUMA nodes and limit readahead max_pages"), ADV_WILLNEED
> > > only tries to readahead 512 pages, and the remained part in the advised
> > > range fallback on normal readahead.
> > 
> > Does the MAINTAINERS file mean nothing any more?
> 
> "Ming, please use scripts/get_maintainer.pl when submitting patches."

That's an appropriate response to a new contributor, sure.  Ming has
been submitting patches since, what, 2008?  Surely they know how to
submit patches by now.

> I agree this patch's header could've worked harder to establish the
> problem that it fixes.  But I'll now take a crack at backfilling the
> regression report that motivated this patch be developed:

Thank you.

> Linux 3.14 was the last kernel to allow madvise (MADV_WILLNEED)
> allowed mmap'ing a file more optimally if read_ahead_kb < max_sectors_kb.
> 
> Ths regressed with commit 6d2be915e589 (so Linux 3.15) such that
> mounting XFS on a device with read_ahead_kb=64 and max_sectors_kb=1024
> and running this reproducer against a 2G file will take ~5x longer
> (depending on the system's capabilities), mmap_load_test.java follows:
> 
> import java.nio.ByteBuffer;
> import java.nio.ByteOrder;
> import java.io.RandomAccessFile;
> import java.nio.MappedByteBuffer;
> import java.nio.channels.FileChannel;
> import java.io.File;
> import java.io.FileNotFoundException;
> import java.io.IOException;
> 
> public class mmap_load_test {
> 
>         public static void main(String[] args) throws FileNotFoundException, IOException, InterruptedException {
> 		if (args.length == 0) {
> 			System.out.println("Please provide a file");
> 			System.exit(0);
> 		}
> 		FileChannel fc = new RandomAccessFile(new File(args[0]), "rw").getChannel();
> 		MappedByteBuffer mem = fc.map(FileChannel.MapMode.READ_ONLY, 0, fc.size());
> 
> 		System.out.println("Loading the file");
> 
> 		long startTime = System.currentTimeMillis();
> 		mem.load();
> 		long endTime = System.currentTimeMillis();
> 		System.out.println("Done! Loading took " + (endTime-startTime) + " ms");
> 		
> 	}
> }

It's good to have the original reproducer.  The unfortunate part is
that being at such a high level, it doesn't really show what syscalls
the library makes on behalf of the application.  I'll take your word
for it that it calls madvise(MADV_WILLNEED).  An strace might not go
amiss.

> reproduce with:
> 
> javac mmap_load_test.java
> echo 64 > /sys/block/sda/queue/read_ahead_kb
> echo 1024 > /sys/block/sda/queue/max_sectors_kb
> mkfs.xfs /dev/sda
> mount /dev/sda /mnt/test
> dd if=/dev/zero of=/mnt/test/2G_file bs=1024k count=2000
> 
> echo 3 > /proc/sys/vm/drop_caches

(I prefer to unmount/mount /mnt/test; it drops the cache for
/mnt/test/2G_file without affecting the rest of the system)

> java mmap_load_test /mnt/test/2G_file
> 
> Without a fix, like the patch Ming provided, iostat will show rareq-sz
> is 64 rather than ~1024.

Understood.  But ... the application is asking for as much readahead as
possible, and the sysadmin has said "Don't readahead more than 64kB at
a time".  So why will we not get a bug report in 1-15 years time saying
"I put a limit on readahead and the kernel is ignoring it"?  I think
typically we allow the sysadmin to override application requests,
don't we?

> > > @@ -972,6 +974,7 @@ struct file_ra_state {
> > >  	unsigned int ra_pages;
> > >  	unsigned int mmap_miss;
> > >  	loff_t prev_pos;
> > > +	struct maple_tree *need_mt;
> > 
> > No.  Embed the struct maple tree.  Don't allocate it.
> 
> Constructive feedback, thanks.
> 
> > What made you think this was the right approach?
> 
> But then you closed with an attack, rather than inform Ming and/or
> others why you feel so strongly, e.g.: Best to keep memory used for
> file_ra_state contiguous.

That's not an attack, it's a genuine question.  Is there somewhere else
doing it wrong that Ming copied from?  Does the documentation need to
be clearer?  I can't fix what I don't know.


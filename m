Return-Path: <linux-fsdevel+bounces-9523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00712842335
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 12:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247381C25BDD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 11:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279A4679F5;
	Tue, 30 Jan 2024 11:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a5ML3lA+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD75767728
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jan 2024 11:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706614518; cv=none; b=hftZuwvSOJd8pJAO9ATH/Ed0mT5IjLy9lrAKOC4ks4NMasbxTEHllritl3Pi63O5/DK0JYpU/7VijQWPN0lB9cpNogjB7UwPeWiwYbM4l91O4bRa2RQt3WK2n7PTonCo8vH+c+l1KT+tu87hjNoqzC+Har9E3sbwdWfTWiJ1Rpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706614518; c=relaxed/simple;
	bh=qqxjh81NRRMyKVrTNcIoz7Y+jhPc6WPwBiL26RCpQ8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1YGzTtx2Ep46JdcnwNNcO29U8UD+l5q4PxBHTEMsf+iCi7OwuYuOF2aKCDZ5d8eyUX2vnfr8LSb/rmnyaK29Zn9G8Xj4xyAiIQSVXnXUs8HYQMgQcnx+M18x8aDnLmgfEIMEK1tcW9LT8C0T2O9Ws63h9ZnfcYqKPBgWWZpy84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a5ML3lA+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706614515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kR0xiXlTgctwy0ZOXXh3w90idhtmWLxzB6iSAte8Lhs=;
	b=a5ML3lA+dhi2tBmqF9rvQVOVhDDhszhutvUIY9vpdmDeiWzRfD5DcSZ8aZGGL5Y9BNA08c
	9rHQ615vD/OUkBE6LhPimI6r9C4nBWTgYL5ItRklkJnhMPqfJkRiDzuA96Tn3o1UP7ZDbF
	MylLj8zgoW/0bbHkmclJ4BLqhphe6E8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-6-0lTcvCMgW8wdlU2BLhIA-1; Tue,
 30 Jan 2024 06:35:10 -0500
X-MC-Unique: 6-0lTcvCMgW8wdlU2BLhIA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C24A11C0513C;
	Tue, 30 Jan 2024 11:35:09 +0000 (UTC)
Received: from fedora (unknown [10.72.116.143])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E9CAF8B;
	Tue, 30 Jan 2024 11:35:03 +0000 (UTC)
Date: Tue, 30 Jan 2024 19:34:59 +0800
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
Message-ID: <Zbje4/789Zs1Ia1t@fedora>
References: <ZbbfXVg9FpWRUVDn@redhat.com>
 <ZbbvfFxcVgkwbhFv@casper.infradead.org>
 <CAH6w=aw_46Ker0w8HmSA41vUUDKGDGC3gxBFWAhd326+kEtrNg@mail.gmail.com>
 <ZbcDvTkeDKttPfJ4@dread.disaster.area>
 <ZbciOba1h3V9mmup@fedora>
 <Zbc0ZJceZPyt8m7q@dread.disaster.area>
 <ZbdhBaXkXm6xyqgC@fedora>
 <ZbghnK+Hs+if6vEz@dread.disaster.area>
 <ZbhpbpeV6ChPD9NT@fedora>
 <ZbiJP3Dhjkh6Dz4x@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbiJP3Dhjkh6Dz4x@dread.disaster.area>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On Tue, Jan 30, 2024 at 04:29:35PM +1100, Dave Chinner wrote:
> On Tue, Jan 30, 2024 at 11:13:50AM +0800, Ming Lei wrote:
> > On Tue, Jan 30, 2024 at 09:07:24AM +1100, Dave Chinner wrote:
> > > On Mon, Jan 29, 2024 at 04:25:41PM +0800, Ming Lei wrote:
> > > > On Mon, Jan 29, 2024 at 04:15:16PM +1100, Dave Chinner wrote:
> > > > > On Mon, Jan 29, 2024 at 11:57:45AM +0800, Ming Lei wrote:
> > > > > > On Mon, Jan 29, 2024 at 12:47:41PM +1100, Dave Chinner wrote:
> > > > > > > On Sun, Jan 28, 2024 at 07:39:49PM -0500, Mike Snitzer wrote:
> > > > > > Follows the current report:
> > > > > > 
> > > > > > 1) usersapce call madvise(willneed, 1G)
> > > > > > 
> > > > > > 2) only the 1st part(size is from bdi->io_pages, suppose it is 2MB) is
> > > > > > readahead in madvise(willneed, 1G) since commit 6d2be915e589
> > > > > > 
> > > > > > 3) the other parts(2M ~ 1G) is readahead by unit of bdi->ra_pages which is
> > > > > > set as 64KB by userspace when userspace reads the mmaped buffer, then
> > > > > > the whole application becomes slower.
> > > > > 
> > > > > It gets limited by file->f_ra->ra_pages being initialised to
> > > > > bdi->ra_pages and then never changed as the advice for access
> > > > > methods to the file are changed.
> > > > > 
> > > > > But the problem here is *not the readahead code*. The problem is
> > > > > that the user has configured the device readahead window to be far
> > > > > smaller than is optimal for the storage. Hence readahead is slow.
> > > > > The fix for that is to either increase the device readahead windows,
> > > > > or to change the specific readahead window for the file that has
> > > > > sequential access patterns.
> > > > > 
> > > > > Indeed, we already have that - FADV_SEQUENTIAL will set
> > > > > file->f_ra.ra_pages to 2 * bdi->ra_pages so that readahead uses
> > > > > larger IOs for that access.
> > > > > 
> > > > > That's what should happen here - MADV_WILLNEED does not imply a
> > > > > specific access pattern so the application should be running
> > > > > MADV_SEQUENTIAL (triggers aggressive readahead) then MADV_WILLNEED
> > > > > to start the readahead, and then the rest of the on-demand readahead
> > > > > will get the higher readahead limits.
> > > > > 
> > > > > > This patch changes 3) to use bdi->io_pages as readahead unit.
> > > > > 
> > > > > I think it really should be changing MADV/FADV_SEQUENTIAL to set
> > > > > file->f_ra.ra_pages to bdi->io_pages, not bdi->ra_pages * 2, and the
> > > > > mem.load() implementation in the application converted to use
> > > > > MADV_SEQUENTIAL to properly indicate it's access pattern to the
> > > > > readahead algorithm.
> > > > 
> > > > Here the single .ra_pages may not work, that is why this patch stores
> > > > the willneed range in maple tree, please see the following words from
> > > > the original RH report:
> > > 
> > > > "
> > > > Increasing read ahead is not an option as it has a mixed I/O workload of
> > > > random I/O and sequential I/O, so that a large read ahead is very counterproductive
> > > > to the random I/O and is unacceptable.
> > > > "
> > > 
> > > Yes, I've read the bug. There's no triage that tells us what the
> > > root cause of the application perofrmance issue might be. Just an
> > > assertion that "this is how we did it 10 years ago, it's been
> > > unchanged for all this time, the new kernel we are upgrading
> > > to needs to behave exactly like pre-3.10 era kernels did.
> > > 
> > > And to be totally honest, my instincts tell me this is more likely a
> > > problem with a root cause in poor IO scheduling decisions than be a
> > > problem with the page cache readahead implementation. Readahead has
> > > been turned down to stop the bandwidth it uses via background async
> > > read IO from starving latency dependent foreground random IO
> > > operation, and then we're being asked to turn readahead back up
> > > in specific situations because it's actually needed for performance
> > > in certain access patterns. This is the sort of thing bfq is
> > > intended to solve.
> > 
> > Reading mmaped buffer in userspace is sync IO, and page fault just
> > readahead 64KB. I don't understand how block IO scheduler makes a
> > difference in this single 64KB readahead in case of cache miss.
> 
> I think you've misunderstood what I said. I was refering to the
> original customer problem of "too much readahead IO causes problems
> for latency sensitive IO" issue that lead to the customer setting
> 64kB readahead device limits in the first place.

Looks we are not in same page, I never see words of "latency sensitive IO"
in this report(RHEL-22476).

> 
> That is, if reducing readahead for sequential IO suddenly makes
> synchronous random IO perform a whole lot better and the application
> goes faster, then it indicates the problem is IO dispatch
> prioritisation, not that there is too much readahead. Deprioritising
> readahead will educe it's impact on other IO, without having to
> reduce the readahead windows that provide decent sequential IO
> perofrmance...
> 
> I really think the customer needs to retune their application from
> first principles. Start with the defaults, measure where things are
> slow, address the worst issue by twiddling knobs. Repeat until
> performance is either good enough or they hit on actual problems
> that need code changes.

io priority is set in blkcg/process level, we even don't know if the random IO
and sequential IO are submitted from different process.

Also io priority is only applied when IOs with different priority are
submitted concurrently.

The main input from the report is that iostat shows that read IO request size is
reduced to 64K from 1MB, which isn't something io priority can deal with.

Here from my understanding the problem is that advise(ADV_RANDOM, ADV_SEQUENTIAL,
ADV_WILLNEED) are basically applied on file level instead of range level, even
though range is passed in from these syscalls.

So sequential and random advise are actually exclusively on the whole file.

That is why the customer don't want to set bigger ra_pages because they
are afraid(or have tested) that bigger ra_pages hurts performance of random
IO workload because unnecessary data may be readahead. But readahead
algorithm is supposed to be capable of dealing with it, maybe still not
well enough.

But yes, more details are needed for understand the issue further.

thanks, 
Ming



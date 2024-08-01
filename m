Return-Path: <linux-fsdevel+bounces-24733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F171A944237
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 06:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B8301F2317F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 04:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198D913DDD3;
	Thu,  1 Aug 2024 04:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QPiRkpEJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509F8EC2;
	Thu,  1 Aug 2024 04:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722486253; cv=none; b=HPNG/Td+9JtMyZHGaL9+lXINKZADoKKN3YYpSsjpIl48OCS7v8gbk09uz2MTIitfWUGnkXo/T22o4e3VsjuXm3EnfE7nsBQZfKTKldZ4Fsh64GOv1E848WRkOBCbcNK0/nvh1EZfz3Do2ytJC5KWqXZnIHyXFociRjM/5usXRqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722486253; c=relaxed/simple;
	bh=qMISye4HUQ81Vts4TwnCmWOyhtXUvcT9kdSDa8r2Kmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSuRJSR325qHI1zl/dU4z7YGxlWWrsBsETqZ22lRgxnNe4zzQScBLDVldiphTSYWHCUAits73SXG1TUIC3yeWMSYqxgvZeg/j7D/KdBJUcfvBBvVjLQngS5N2zl5fHnuwX0qYcaFMakYEIc0oNKwZNM33d8BQ4Ycf0cbDcnwtfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QPiRkpEJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=m/5znE2KSEkfSpmB+PNt+5v2Q6qYiKffEwJsCujQQnk=; b=QPiRkpEJfDGtYTsTEQIAqYIxqD
	hSm4SMukC1pka04nTbMO/+RGgpbz9p/HBFSlhY3Xo3JeYC6FmZnH5EXESdj6z0WpwnFAn3lAggsoe
	SzZ4kLEzxWSXkPidc5vdg9jrLBNOX9rZFgewmean5aLvbqZWfYW3ggqMdloJm0gjqwQicgXCPE5lR
	x8xZE5iMlMNlTWLinqmH5IV/b+fp16yxik/I0Bjxq6whCx7xnZpqSWKzy655MoKVv6suPXsKsoAfI
	1iWzDlW5WlGNuPmb1STJIXlQLecai9kTPO08lyEIX4+M2f9XhPcYJ6SVY15pyKaSVwr48YwdDq1m6
	gH0HI5PQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZNMF-0000000Gy0L-0HOL;
	Thu, 01 Aug 2024 04:24:07 +0000
Date: Thu, 1 Aug 2024 05:24:06 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
	brauner@kernel.org, david@fromorbit.com, jack@suse.cz,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 5/6] iomap: drop unnecessary state_lock when setting ifs
 uptodate bits
Message-ID: <ZqsN5ouQTEc1KAzV@casper.infradead.org>
References: <20240731091305.2896873-1-yi.zhang@huaweicloud.com>
 <20240731091305.2896873-6-yi.zhang@huaweicloud.com>
 <ZqprvNM5itMbanuH@casper.infradead.org>
 <995196b3-3571-b23f-eb5f-d3fee5d97593@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <995196b3-3571-b23f-eb5f-d3fee5d97593@huaweicloud.com>

On Thu, Aug 01, 2024 at 09:52:49AM +0800, Zhang Yi wrote:
> On 2024/8/1 0:52, Matthew Wilcox wrote:
> > On Wed, Jul 31, 2024 at 05:13:04PM +0800, Zhang Yi wrote:
> >> Commit '1cea335d1db1 ("iomap: fix sub-page uptodate handling")' fix a
> >> race issue when submitting multiple read bios for a page spans more than
> >> one file system block by adding a spinlock(which names state_lock now)
> >> to make the page uptodate synchronous. However, the race condition only
> >> happened between the read I/O submitting and completeing threads, it's
> >> sufficient to use page lock to protect other paths, e.g. buffered write
> >> path. After large folio is supported, the spinlock could affect more
> >> about the buffered write performance, so drop it could reduce some
> >> unnecessary locking overhead.
> > 
> > This patch doesn't work.  If we get two read completions at the same
> > time for blocks belonging to the same folio, they will both write to
> > the uptodate array at the same time.
> > 
> This patch just drop the state_lock in the buffered write path, doesn't
> affect the read path, the uptodate setting in the read completion path
> is still protected the state_lock, please see iomap_finish_folio_read().
> So I think this patch doesn't affect the case you mentioned, or am I
> missing something?

Oh, I see.  So the argument for locking correctness is that:

A. If ifs_set_range_uptodate() is called from iomap_finish_folio_read(),
   the state_lock is held.
B. If ifs_set_range_uptodate() is called from iomap_set_range_uptodate(),
   either we know:
B1. The caller of iomap_set_range_uptodate() holds the folio lock, and this
    is the only place that can call ifs_set_range_uptodate() for this folio
B2. The caller of iomap_set_range_uptodate() holds the state lock

But I think you've assigned iomap_read_inline_data() to case B1 when I
think it's B2.  erofs can certainly have a file which consists of various
blocks elsewhere in the file and then a tail that is stored inline.

__iomap_write_begin() is case B1 because it holds the folio lock, and
submits its read(s) sychronously.  Likewise __iomap_write_end() is
case B1.

But, um.  Why do we need to call iomap_set_range_uptodate() in both
write_begin() and write_end()?

And I think this is actively buggy:

               if (iomap_block_needs_zeroing(iter, block_start)) {
                        if (WARN_ON_ONCE(iter->flags & IOMAP_UNSHARE))
                                return -EIO;
                        folio_zero_segments(folio, poff, from, to, poff + plen);
...
                iomap_set_range_uptodate(folio, poff, plen);

because we zero from 'poff' to 'from', then from 'to' to 'poff+plen',
but mark the entire range as uptodate.  And once a range is marked
as uptodate, it can be read from.

So we can do this:

 - Get a write request for bytes 1-4094 over a hole
 - allocate single page folio
 - zero bytes 0 and 4095
 - mark 0-4095 as uptodate
 - take page fault while trying to access the user address
 - read() to bytes 0-4095 now succeeds even though we haven't written
   1-4094 yet

And that page fault can be uffd or a buffer that's in an mmap that's
out on disc.  Plenty of time to make this race happen, and we leak
4094/4096 bytes of the previous contents of that folio to userspace.

Or did I miss something?


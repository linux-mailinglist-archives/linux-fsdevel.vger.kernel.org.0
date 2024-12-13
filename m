Return-Path: <linux-fsdevel+bounces-37344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DB79F12BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 17:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28D2B16AB16
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 16:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF4D1EB9EF;
	Fri, 13 Dec 2024 16:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EsiplEy7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECFC1E47B7
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 16:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734108470; cv=none; b=HbIyCDydjwFlPsVlLjYdT1e+cWp9bPKVFl7/giyl9OAtpsNrn03a1N0JSjee9zoT8cXTCo89hPcgVtGRvvbFoNXWJ/0bDr0IDFJhtEXeL8vu8DIB4J8raB57fIfeFhOJ3kRbVpI562gKuG32zSE3Rgg5rD3x8CA6c2VD+kPsl4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734108470; c=relaxed/simple;
	bh=8Ztqm8jQeFwcJNXZSmEnGI4VLWCTSJ8GsmHsO24wx7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=moWvcWjipMURK++nwFKFu64QyvK28PTHKWK+ywWhPNSeiWLncxzmNofOk5QHjMXvjIcG4xyQUT7W7FkIrQqOswX9TRPdQz3M5prDJ5iMTAQ3YZcCPP7LShK9T5oxzKYyK9aJvFc3Z1LoTUntWiwPFzficZ/jYYrPVHRf0RKw/Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EsiplEy7; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 13 Dec 2024 08:47:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734108464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LKbanjR8vOBdA+hsZLiBqN3TO/TNUVm/rbUUnKN4CJU=;
	b=EsiplEy7RPANZWqFzt3WlFaXcQl1ND/87bm5CDu1XqRLANcT/h9VVEaG20RY17p3ac5v0/
	yHR1hP+rVuo1kWzfLwFQWbuLlmhg/Ixkc0XERtNU6tFxHnALH1zqv4g0eBFeRus4fNTwRO
	vt0cO/CY4qi612HFpDSa0MdrZ/8V3co=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Miklos Szeredi <miklos@szeredi.hu>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
	jefflexu@linux.alibaba.com, josef@toxicpanda.com, bernd.schubert@fastmail.fm, 
	linux-mm@kvack.org, kernel-team@meta.com
Subject: Re: [PATCH v6 0/5] fuse: remove temp page copies in writeback
Message-ID: <qbbwxtqrlxhdkesrruwgfnu3qyzi6b6jhahxhbvn56kpiw5i4v@dhvdhlslbhcc>
References: <20241122232359.429647-1-joannelkoong@gmail.com>
 <CAJfpegtSif7e=OrREJeVb_azg6+tRpuOPRQNMvQ9jLuXaTtxHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtSif7e=OrREJeVb_azg6+tRpuOPRQNMvQ9jLuXaTtxHw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

+Andrew

On Fri, Dec 13, 2024 at 12:52:44PM +0100, Miklos Szeredi wrote:
> On Sat, 23 Nov 2024 at 00:24, Joanne Koong <joannelkoong@gmail.com> wrote:
> >
> > The purpose of this patchset is to help make writeback-cache write
> > performance in FUSE filesystems as fast as possible.
> >
> > In the current FUSE writeback design (see commit 3be5a52b30aa
> > ("fuse: support writable mmap"))), a temp page is allocated for every dirty
> > page to be written back, the contents of the dirty page are copied over to the
> > temp page, and the temp page gets handed to the server to write back. This is
> > done so that writeback may be immediately cleared on the dirty page, and this
> > in turn is done for two reasons:
> > a) in order to mitigate the following deadlock scenario that may arise if
> > reclaim waits on writeback on the dirty page to complete (more details can be
> > found in this thread [1]):
> > * single-threaded FUSE server is in the middle of handling a request
> >   that needs a memory allocation
> > * memory allocation triggers direct reclaim
> > * direct reclaim waits on a folio under writeback
> > * the FUSE server can't write back the folio since it's stuck in
> >   direct reclaim
> > b) in order to unblock internal (eg sync, page compaction) waits on writeback
> > without needing the server to complete writing back to disk, which may take
> > an indeterminate amount of time.
> >
> > Allocating and copying dirty pages to temp pages is the biggest performance
> > bottleneck for FUSE writeback. This patchset aims to get rid of the temp page
> > altogether (which will also allow us to get rid of the internal FUSE rb tree
> > that is needed to keep track of writeback status on the temp pages).
> > Benchmarks show approximately a 20% improvement in throughput for 4k
> > block-size writes and a 45% improvement for 1M block-size writes.
> >
> > With removing the temp page, writeback state is now only cleared on the dirty
> > page after the server has written it back to disk. This may take an
> > indeterminate amount of time. As well, there is also the possibility of
> > malicious or well-intentioned but buggy servers where writeback may in the
> > worst case scenario, never complete. This means that any
> > folio_wait_writeback() on a dirty page belonging to a FUSE filesystem needs to
> > be carefully audited.
> >
> > In particular, these are the cases that need to be accounted for:
> > * potentially deadlocking in reclaim, as mentioned above
> > * potentially stalling sync(2)
> > * potentially stalling page migration / compaction
> >
> > This patchset adds a new mapping flag, AS_WRITEBACK_INDETERMINATE, which
> > filesystems may set on its inode mappings to indicate that writeback
> > operations may take an indeterminate amount of time to complete. FUSE will set
> > this flag on its mappings. This patchset adds checks to the critical parts of
> > reclaim, sync, and page migration logic where writeback may be waited on.
> >
> > Please note the following:
> > * For sync(2), waiting on writeback will be skipped for FUSE, but this has no
> >   effect on existing behavior. Dirty FUSE pages are already not guaranteed to
> >   be written to disk by the time sync(2) returns (eg writeback is cleared on
> >   the dirty page but the server may not have written out the temp page to disk
> >   yet). If the caller wishes to ensure the data has actually been synced to
> >   disk, they should use fsync(2)/fdatasync(2) instead.
> > * AS_WRITEBACK_INDETERMINATE does not indicate that the folios should never be
> >   waited on when in writeback. There are some cases where the wait is
> >   desirable. For example, for the sync_file_range() syscall, it is fine to
> >   wait on the writeback since the caller passes in a fd for the operation.
> 
> Looks good, thanks.
> 
> Acked-by: Miklos Szeredi <mszeredi@redhat.com>
> 
> I think this should go via the mm tree.

Andrew, can you please pick this series up or Joanne can send an updated
version with all Acks/Review tag collected? Let us know what you prefer.

Thanks,
Shakeel


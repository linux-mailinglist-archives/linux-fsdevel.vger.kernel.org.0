Return-Path: <linux-fsdevel+bounces-9287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 114BE83FC6D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 04:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2B4E1F23360
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 03:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3252FF9F7;
	Mon, 29 Jan 2024 03:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C2NeskAm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4B9F9DB
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 03:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706497250; cv=none; b=A9wRdN5HuQwhe15X0ZSCKuN77LVkbMLFkN5EEuJyItf/S/SkAikMRJzVZ4VCg6qX2U4l+uBzvVx4UYJsNGy4W8oJeklZgRdjRn3OGZVedFf4ku4ngOMgZ/9aBX6F1pEFVM6+KXXe5lFylGKxm9zpQSL/8fACPKsfVxbmnDKGQl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706497250; c=relaxed/simple;
	bh=/oGa5ABPhpXed7C0cgst3BJAf0CGV7fQ9TLfp798wPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmeGykiDQlYwLhj+ILP9bKA1L14+Ud1b1fkI2egH1ukTV2zuAom37NAfydb3FKhNPLPB5fkH6uIhMY07V7e82tX/JFx2vBuI7U1oado5gMdp2N/AHS8u35sXWlcxpjRupYCNZDBEUMx/dM/ry0hSNDJCtJY0VFBCgTIBq7WL2Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C2NeskAm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706497247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SH5JJA8B2/oLNz4ErgboH6AqTlVlU9RXl7tVsXTShf0=;
	b=C2NeskAmJGqcRs/knlZh+cWM+9MXlNfW+wcdmpRkf5tlAoiy+hgdAuukuMiPzVSpPEiqs9
	XF0HlZmh5BBUYlxErau3sCO+6c8z5XAL8tmh85ZxgMs0o5cV67G4bMeN70XKNeGYRi5tla
	swYSDs1hTvjLBxpKuw7MXn7HDk2Umfs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-GSvxAW-rMwWbug6hU-02LQ-1; Sun,
 28 Jan 2024 22:00:45 -0500
X-MC-Unique: GSvxAW-rMwWbug6hU-02LQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2077E29AC015;
	Mon, 29 Jan 2024 03:00:45 +0000 (UTC)
Received: from fedora (unknown [10.72.116.135])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C4D5B2026F95;
	Mon, 29 Jan 2024 03:00:40 +0000 (UTC)
Date: Mon, 29 Jan 2024 11:00:36 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
	Don Dutile <ddutile@redhat.com>,
	Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>,
	ming.lei@redhat.com
Subject: Re: [RFC PATCH] mm/readahead: readahead aggressively if read drops
 in willneed range
Message-ID: <ZbcU1PXACdxbtjWx@fedora>
References: <20240128142522.1524741-1-ming.lei@redhat.com>
 <ZbbPCQZdazF7s0_b@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbbPCQZdazF7s0_b@casper.infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On Sun, Jan 28, 2024 at 10:02:49PM +0000, Matthew Wilcox wrote:
> On Sun, Jan 28, 2024 at 10:25:22PM +0800, Ming Lei wrote:
> > Since commit 6d2be915e589 ("mm/readahead.c: fix readahead failure for
> > memoryless NUMA nodes and limit readahead max_pages"), ADV_WILLNEED
> > only tries to readahead 512 pages, and the remained part in the advised
> > range fallback on normal readahead.
> 
> Does the MAINTAINERS file mean nothing any more?

It is just miss to Cc you, sorry.

> 
> > If bdi->ra_pages is set as small, readahead will perform not efficient
> > enough. Increasing read ahead may not be an option since workload may
> > have mixed random and sequential I/O.
> 
> I thik there needs to be a lot more explanation than this about what's
> going on before we jump to "And therefore this patch is the right
> answer".

Both 6d2be915e589 and the commit log provids background about this
issue, let me explain it more:

1) before commit 6d2be915e589, madvise/fadvise(WILLNEED)/readahead
syscalls try to readahead in the specified range if memory is allowed,
and for each readahead in this range, the ra size is set as max sectors
of the block device, see force_page_cache_ra().

2) since commit 6d2be915e589, only 2MB bytes are load in these syscalls,
and the remained bytes fallback to future normal readahead when reads
from page cache or mmap buffer

3) this patch wires the advise(WILLNEED) range info to normal readahead for
both mmap fault and buffered read code path, so each readhead can use
max sectors of block size for the ra, basically takes the similar
approach before commit 6d2be915e589

> 
> > @@ -972,6 +974,7 @@ struct file_ra_state {
> >  	unsigned int ra_pages;
> >  	unsigned int mmap_miss;
> >  	loff_t prev_pos;
> > +	struct maple_tree *need_mt;
> 
> No.  Embed the struct maple tree.  Don't allocate it.  What made you
> think this was the right approach?

Can you explain why it has to be embedded? core-api/maple_tree.rst
mentioned it is fine to call "mt_init() for dynamically allocated ones".

maple tree provides one easy way to record the advised willneed range,
so readahead code path can apply this info for speedup readahead.


Thanks,
Ming



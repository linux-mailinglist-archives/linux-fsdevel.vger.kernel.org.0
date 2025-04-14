Return-Path: <linux-fsdevel+bounces-46421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9450DA88F7C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 00:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FF637AA18A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 22:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236AE2153D6;
	Mon, 14 Apr 2025 22:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JRl9IPp2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C121DEFE1
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 22:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744670841; cv=none; b=ByuLngfdHTQ10TUZeufj9KjtXU5F4wA/Z+2ZxYciWY/m+IQMWoGeoYgLP89P/Pfc91uY87R1EKHnYUukjFtZKnFNq0C3VQOJo6DaHl3QyXZYtS+o4frJu1U90Ma3RWR91AZ8fJ0lQM/7Rj09OjVqv5p84jAiF441NFJwzWYijlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744670841; c=relaxed/simple;
	bh=sCAjWvXXSn1IbMyA40TAEejqtgy+Qnu8JQlS8PEJfGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+LWpy5BboSQHQBV/lq9QeOPmv5Rhyp//D8HqmE0SvbOj2AtVLE4Tc/td9fa7qaxWkPUEOxuZRmgLMzmtFB14bvxD4Slz/QDrxfVXGQhqeKW3WpiZZnftwwS9Ik2KTHjuKVsk13OORPx3gDBTIvIKuGjeZub/byEGQn+UzJkgww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JRl9IPp2; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 14 Apr 2025 15:47:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744670835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uIIErBlG5wRoFqOpPjHx999YVfJm+/rYZBXFoFaIvT4=;
	b=JRl9IPp2jq0qLMiWcJnyAUjvI+Swn1kHwvThtHYD+G68ctLENM9P3d3Mvpb4ndvdiXgkBg
	jvLRiSDpB7XZBg8uXth0cYFLcnqtPlhHRYw0SLUEkDVXG5v8YXpbc4PWWj/Ww4HfoaV42L
	ujJZI+A42nG0ATXnJ++GH1z3hM/YkJY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, jefflexu@linux.alibaba.com, david@redhat.com, 
	bernd.schubert@fastmail.fm, ziy@nvidia.com, jlayton@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v8 0/2] fuse: remove temp page copies in writeback
Message-ID: <cvrrumc6uduvg43gyx24bw2llre3ihdq7pjj24l6yeon7antni@7e2bmd2bya5c>
References: <20250414222210.3995795-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414222210.3995795-1-joannelkoong@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Apr 14, 2025 at 03:22:08PM -0700, Joanne Koong wrote:
> The purpose of this patchset is to help make writeback in FUSE filesystems as
> fast as possible.
> 
> In the current FUSE writeback design (see commit 3be5a52b30aa
> ("fuse: support writable mmap"))), a temp page is allocated for every dirty
> page to be written back, the contents of the dirty page are copied over to the
> temp page, and the temp page gets handed to the server to write back. This is
> done so that writeback may be immediately cleared on the dirty page, and this 
> in turn is done in order to mitigate the following deadlock scenario that may
> arise if reclaim waits on writeback on the dirty page to complete (more
> details
> can be found in this thread [1]):
> * single-threaded FUSE server is in the middle of handling a request
>   that needs a memory allocation
> * memory allocation triggers direct reclaim
> * direct reclaim waits on a folio under writeback
> * the FUSE server can't write back the folio since it's stuck in
>   direct reclaim
> 
> Allocating and copying dirty pages to temp pages is the biggest performance
> bottleneck for FUSE writeback. This patchset aims to get rid of the temp page
> altogether (which will also allow us to get rid of the internal FUSE rb tree
> that is needed to keep track of writeback status on the temp pages).
> Benchmarks show approximately a 20% improvement in throughput for 4k
> block-size writes and a 45% improvement for 1M block-size writes.
> 
> In the current reclaim code, there is one scenario where writeback is waited
> on, which is the case where the system is running legacy cgroupv1 and reclaim
> encounters a folio that already has the reclaim flag set and the caller did
> not have __GFP_FS (or __GFP_IO if swap) set.
> 
> This patchset adds a new mapping flag, AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM,
> which filesystems may set on its inode mappings to indicate that reclaim
> should not wait on writeback. FUSE will set this flag on its mappings. Reclaim
> for the legacy cgroup v1 case described above will skip reclaim of folios with
> that flag set. With this flag set, now FUSE can remove temp pages altogether.
> 
> With this change, writeback state is now only cleared on the dirty page after
> the server has written it back to disk. If the server is deliberately
> malicious or well-intentioned but buggy, this may stall sync(2) and page
> migration, but for sync(2), a malicious server may already stall this by not
> replying to the FUSE_SYNCFS request and for page migration, there are already
> many easier ways to stall this by having FUSE permanently hold the folio lock.
> A fuller discussion on this can be found in [2]. Long-term, there needs to be
> a more comprehensive solution for addressing migration of FUSE pages that
> handles all scenarios where FUSE may permanently hold the lock, but that is
> outside the scope of this patchset and will be done as future work. Please
> also note that this change also now ensures that when sync(2) returns, FUSE
> filesystems will have persisted writeback changes.
> 
> For this patchset, it would be ideal if the first patch could be taken by
> Andrew to the mm tree and the second patch could be taken by Miklos into the
> fuse tree, as the fuse large folios patchset [3] depends on the second patch.

Why not take both patches through FUSE tree? Second patch has dependency
on first patch, so there is no need to keep them separate.


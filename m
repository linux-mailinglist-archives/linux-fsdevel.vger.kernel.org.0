Return-Path: <linux-fsdevel+bounces-46435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1612A8960C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 10:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E6FE17DCDF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 08:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C967279907;
	Tue, 15 Apr 2025 08:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UBvZB5ph"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2627C194C86
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 08:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744704513; cv=none; b=L3H8jsjVNsX2nS+V77I6VQkyG+iu05APoc+jxDPx17d/xguO09y/t+rEnDR5AJpIYwq1IZMnFOuV0hm10kkDNyFhwwi7OpnKZbMdZGfz/fDy+Y/dEd9xOKz+dGOPg8+z380ghss8D/dKAfgiQ/d3A51MYF62FZayfWfCx03bVcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744704513; c=relaxed/simple;
	bh=K0zuuUrP1GTMrfD0uK7cmrnkK2AaNl3C4GoifhMTB+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HoxnLsgvX+K4sYmmQp1Uuax7uzxF4rtz3q80M/N+icIacfo3Pqyt3cZi3maZS6LcIpLmLoaQF9hM3fBrRYUTRfWodvJAEEa0+QLI76IpnKaRhE6zoN7drTgdeMHKOdnTzdnTcyOSsjaq6CgwvdSW+u7x1Pt1SNc30V8gMhU5+No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UBvZB5ph; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1744704502; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=6uJ8JAW/CX0s14a5D8l/CfXdE901CGm9XOoEGCn47xE=;
	b=UBvZB5phvbW3jWbiSS14J4CcLeUkeaAOqVNy6OuD1RJAcr0fvBwqXR3FYvAQU/f1Fe5kHvaduIT1QEG7dvgU1H7kTpfrg5SOlav0GxHdTxCskud1v4dCedjcgFj1hUP8OL5RdVAh5b8wS9kCWRvhfBF4poxrxamrw4sIiiympSw=
Received: from 30.221.145.234(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WX42Ebp_1744704500 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Apr 2025 16:08:20 +0800
Message-ID: <d31b0b36-559f-4b09-a624-ed7c50a86b43@linux.alibaba.com>
Date: Tue, 15 Apr 2025 16:08:19 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/2] fuse: remove temp page copies in writeback
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc: shakeel.butt@linux.dev, david@redhat.com, bernd.schubert@fastmail.fm,
 ziy@nvidia.com, jlayton@kernel.org, kernel-team@meta.com
References: <20250414222210.3995795-1-joannelkoong@gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20250414222210.3995795-1-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/15/25 6:22 AM, Joanne Koong wrote:
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
> 
> Thanks,
> Joanne
> 
> [1]
> https://lore.kernel.org/linux-kernel/495d2400-1d96-4924-99d3-8b2952e05fc3@linux.alibaba.com/
> [2]
> https://lore.kernel.org/linux-fsdevel/20241122232359.429647-1-joannelkoong@gmail.com/
> [3] 
> https://lore.kernel.org/linux-fsdevel/20241213221818.322371-1-joannelkoong@gmail.com/
> 
> Changelog
> ---------
> v7:
> https://lore.kernel.org/linux-fsdevel/20250404181443.1363005-1-joannelkoong@gmail.com/
> Changes from v7 -> v8:
> * Rename from AS_WRITEBACK_INDETERMINATE to
>   AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM (David) and merge patch 1 + 2
> * Remove unnecessary fuse_sync_writes() call in fuse_flush() (Jingbo)
> 
> v6:
> https://lore.kernel.org/linux-fsdevel/20241122232359.429647-1-joannelkoong@gmail.com/
> Changes from v6 -> v7:
> * Drop migration and sync patches, as they are useless if a server is
>   determined to be malicious
> 
> v5:
> https://lore.kernel.org/linux-fsdevel/20241115224459.427610-1-joannelkoong@gmail.com/
> Changes from v5 -> v6:
> * Add Shakeel and Jingbo's reviewed-bys 
> * Move folio_end_writeback() to fuse_writepage_finish() (Jingbo)
> * Embed fuse_writepage_finish_stat() logic inline (Jingbo)
> * Remove node_stat NR_WRITEBACK inc/sub (Jingbo)
> 
> v4:
> https://lore.kernel.org/linux-fsdevel/20241107235614.3637221-1-joannelkoong@gmail.com/
> Changes from v4 -> v5:
> * AS_WRITEBACK_MAY_BLOCK -> AS_WRITEBACK_INDETERMINATE (Shakeel)
> * Drop memory hotplug patch (David and Shakeel)
> * Remove some more kunnecessary writeback waits in fuse code (Jingbo)
> * Make commit message for reclaim patch more concise - drop part about
>   deadlock and just focus on how it may stall waits
> 
> v3:
> https://lore.kernel.org/linux-fsdevel/20241107191618.2011146-1-joannelkoong@gmail.com/
> Changes from v3 -> v4:
> * Use filemap_fdatawait_range() instead of filemap_range_has_writeback() in
>   readahead
> 
> v2:
> https://lore.kernel.org/linux-fsdevel/20241014182228.1941246-1-joannelkoong@gmail.com/
> Changes from v2 -> v3:
> * Account for sync and page migration cases as well (Miklos)
> * Change AS_NO_WRITEBACK_RECLAIM to the more generic AS_WRITEBACK_MAY_BLOCK
> * For fuse inodes, set mapping_writeback_may_block only if fc->writeback_cache
>   is enabled
> 
> v1:
> https://lore.kernel.org/linux-fsdevel/20241011223434.1307300-1-joannelkoong@gmail.com/T/#t
> Changes from v1 -> v2:
> * Have flag in "enum mapping_flags" instead of creating asop_flags (Shakeel)
> * Set fuse inodes to use AS_NO_WRITEBACK_RECLAIM (Shakeel)
> 
> Joanne Koong (2):
>   mm: skip folio reclaim in legacy memcg contexts for deadlockable
>     mappings
>   fuse: remove tmp folio for writebacks and internal rb tree
> 
>  fs/fuse/file.c          | 364 ++++------------------------------------
>  fs/fuse/fuse_i.h        |   3 -
>  include/linux/pagemap.h |  11 ++
>  mm/vmscan.c             |  12 +-
>  4 files changed, 48 insertions(+), 342 deletions(-)
> 


LGTM.

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

-- 
Thanks,
Jingbo


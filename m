Return-Path: <linux-fsdevel+bounces-19206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4AE8C13F7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 19:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28257282E37
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 17:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B972D12E4E;
	Thu,  9 May 2024 17:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PVQeG805"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFB2C2ED
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 May 2024 17:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715275432; cv=none; b=m0KxWVCnaPHVqUDMkFOI/YkV/JKcdkgRYeUDga7003eZOE24pxYlVhHOJd9zOka19rJZElhOQtEn/pvEQ0hQ48CEzLpX7cWxqH8RrKffB2UI3u64jo2X3OqWSlFJflXU2Yf2Nh9eglstKzjb81eHcvWpraV9HNmY+ZKnvxAOGsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715275432; c=relaxed/simple;
	bh=0ugMAx4PhzHKyv40ZuZGgNyOkcOW1v642VlMhmrdgvY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jlcmm+3sR8VpXW+8CfvL2wWxtILjHF59xPMDUnuvGQ3Oek9vqiOIR3uCpBc5CUVYYKVHyEycqYq1vMty8WGCNZjTXHa0JAFiYc8NWa/FUTCrQ+YMRIx5VAl39Sy5xlExc642Od4VfuCcXUyfk5rCqAKJvPDXS4jjv0Ws0Oc5fQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PVQeG805; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715275427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q5NwpyR9OTSf8oGKU+ne7+xoirIi77/iJlT2WIV8ttY=;
	b=PVQeG805+z+rJd0kTIjdCzK2cBySgUA9thg2xKhNXMZcGZUpBLTZNP3FCARPpKo1Q2tRBR
	UpdM1F7kDC2VbJ+YFTS7gITG/HiZbizfrTU/PQ+bWzgYoS27DCpOdfcPGCm5AD68HNxTX8
	WTP771jM/gN3ebtg173XF8De52UvCBo=
From: Luis Henriques <luis.henriques@linux.dev>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Luis Henriques <luis.henriques@linux.dev>,  Zhang Yi
 <yi.zhang@huaweicloud.com>,  linux-ext4@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  adilger.kernel@dilger.ca,  jack@suse.cz,
  ritesh.list@gmail.com,  hch@infradead.org,  djwong@kernel.org,
  willy@infradead.org,  zokeefe@google.com,  yi.zhang@huawei.com,
  chengzhihao1@huawei.com,  yukuai3@huawei.com,  wangkefeng.wang@huawei.com
Subject: Re: [PATCH v3 03/26] ext4: correct the hole length returned by
 ext4_map_blocks()
In-Reply-To: <20240509163953.GI3620298@mit.edu> (Theodore Ts'o's message of
	"Thu, 9 May 2024 12:39:53 -0400")
References: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
	<20240127015825.1608160-4-yi.zhang@huaweicloud.com>
	<87zfszuib1.fsf@brahms.olymp> <20240509163953.GI3620298@mit.edu>
Date: Thu, 09 May 2024 18:23:44 +0100
Message-ID: <87h6f6vqzj.fsf@brahms.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

On Thu 09 May 2024 12:39:53 PM -04, Theodore Ts'o wrote;

> On Thu, May 09, 2024 at 04:16:34PM +0100, Luis Henriques wrote:
>> 
>> It's looks like it's easy to trigger an infinite loop here using fstest
>> generic/039.  If I understand it correctly (which doesn't happen as often
>> as I'd like), this is due to an integer overflow in the 'if' condition,
>> and should be fixed with the patch below.
>
> Thanks for the report.  However, I can't reproduce the failure, and
> looking at generic/039, I don't see how it could be relevant to the
> code path in question.  Generic/039 creates a test symlink with two
> hard links in the same directory, syncs the file system, and then
> removes one of the hard links, and then drops access to the block
> device using dmflakey.  So I don't see how the extent code would be
> involved at all.  Are you sure that you have the correct test listed?

Yep, I just retested and it's definitely generic/039.  I'm using a simple
test environment, with virtme-ng.

> Looking at the code in question in fs/ext4/extents.c:
>
> again:
> 	ext4_es_find_extent_range(inode, &ext4_es_is_delayed, hole_start,
> 				  hole_start + len - 1, &es);
> 	if (!es.es_len)
> 		goto insert_hole;
>
>   	 * There's a delalloc extent in the hole, handle it if the delalloc
>   	 * extent is in front of, behind and straddle the queried range.
>   	 */
>  -	if (lblk >= es.es_lblk + es.es_len) {
>  +	if (lblk >= ((__u64) es.es_lblk) + es.es_len) {
>   		/*
>   		 * The delalloc extent is in front of the queried range,
>   		 * find again from the queried start block.
> 		len -= lblk - hole_start;
> 		hole_start = lblk;
> 		goto again;
>
> lblk and es.es_lblk are both __u32.  So the infinite loop is
> presumably because es.es_lblk + es.es_len has overflowed.  This should
> never happen(tm), and in fact we have a test for this case which

If I instrument the code, I can see that es.es_len is definitely set to
EXT_MAX_BLOCKS, which will overflow.

> *should* have gotten tripped when ext4_es_find_extent_range() calls
> __es_tree_search() in fs/ext4/extents_status.c:
>
> static inline ext4_lblk_t ext4_es_end(struct extent_status *es)
> {
> 	BUG_ON(es->es_lblk + es->es_len < es->es_lblk);
> 	return es->es_lblk + es->es_len - 1;
> }
>
> So the patch is harmless, and I can see how it might fix what you were
> seeing --- but I'm a bit nervous that I can't reproduce it and the
> commit description claims that it reproduces easily; and we should
> have never allowed the entry to have gotten introduced into the
> extents status tree in the first place, and if it had been introduced,
> it should have been caught before it was returned by
> ext4_es_find_extent_range().
>
> Can you give more details about the reproducer; can you double check
> the test id, and how easily you can trigger the failure, and what is
> the hardware you used to run the test?

So, here's few more details that may clarify, and that I should have added
to the commit description:

When the test hangs, the test is blocked mounting the flakey device:

   mount -t ext4 -o acl,user_xattr /dev/mapper/flakey-test /mnt/scratch

which will eventually call into ext4_ext_map_blocks(), triggering the bug.

Also, some more code instrumentation shows that after the call to
ext4_ext_find_hole(), the 'hole_start' will be set to '1' and 'len' to
'0xfffffffe'.  This '0xfffffffe' value is a bit odd, but it comes from the
fact that, in ext4_ext_find_hole(), the call to
ext4_ext_next_allocated_block() will return EXT_MAX_BLOCKS and 'len' will
thus be set to 'EXT_MAX_BLOCKS - 1'.

Does this make sense?

Cheers,
-- 
Luis


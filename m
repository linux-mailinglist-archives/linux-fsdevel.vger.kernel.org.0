Return-Path: <linux-fsdevel+bounces-19255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5188C2134
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 11:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65231282253
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 09:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636E81635CD;
	Fri, 10 May 2024 09:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wjdczF31"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3B51635B5
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 May 2024 09:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715334114; cv=none; b=tuPpD8nijlouf7ywnALOUuulWOq0LjlnIFjGNVKFocVDDge3CVGkLLruPaEiR3j3JXnz/ZNPNoNHknrjNZTouC2tzN2KfdKFTh5AhTH0Fby3lKQhXNb7JILn9k7EovasWkgR67/Sf+A24IwF1F0HDvw7x7Jqkp5AYB2jTSArsdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715334114; c=relaxed/simple;
	bh=9UIZO+fMK0093XFA1cdCPdokYDtdUqkFjEBrjHtGLrQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ev1Uj7Tnjff+u7Mr1BZ0udzUWWht3DembgDWHwp/5Fr/NC4TYjqCXPDqWJ2iGHEG0M11e2vw2tFp7qGLeOMznLu5HYIMb08BaVZUqvJUboWC8WSO6yLQNRRx4tZzW9MO0hPl1rug9wJKBWx9XjIBNeCYoXxvIWMmrBMICNXwmNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wjdczF31; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715334110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jVrskhxBKxvv9z8KIVgQd5Lldn1b3J2MV9vWclbKXxw=;
	b=wjdczF31RF+qRp+6AWaFv5jmUHfu3EMgiww/OAXl2mQujL6olclJLVYnjVcNaimCCHjAGb
	lmD1GtIin78uuOReujW6fU/7VxHMSkQDXK5prD+whOMoDmBVzfL9tnRBif4oL2HHqEuIuD
	Xi87nFlgpTVI2CcJN359VVQNE1uH43A=
From: Luis Henriques <luis.henriques@linux.dev>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Theodore Ts'o <tytso@mit.edu>,  linux-ext4@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  adilger.kernel@dilger.ca,  jack@suse.cz,
  ritesh.list@gmail.com,  hch@infradead.org,  djwong@kernel.org,
  willy@infradead.org,  zokeefe@google.com,  yi.zhang@huawei.com,
  chengzhihao1@huawei.com,  yukuai3@huawei.com,  wangkefeng.wang@huawei.com
Subject: Re: [PATCH v3 03/26] ext4: correct the hole length returned by
 ext4_map_blocks()
In-Reply-To: <b9b93ad2-2253-6850-da38-afc42370303e@huaweicloud.com> (Zhang
	Yi's message of "Fri, 10 May 2024 11:39:48 +0800")
References: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
	<20240127015825.1608160-4-yi.zhang@huaweicloud.com>
	<87zfszuib1.fsf@brahms.olymp> <20240509163953.GI3620298@mit.edu>
	<87h6f6vqzj.fsf@brahms.olymp>
	<b9b93ad2-2253-6850-da38-afc42370303e@huaweicloud.com>
Date: Fri, 10 May 2024 10:41:45 +0100
Message-ID: <87seyquhpi.fsf@brahms.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

On Fri 10 May 2024 11:39:48 AM +08, Zhang Yi wrote;

> On 2024/5/10 1:23, Luis Henriques wrote:
>> On Thu 09 May 2024 12:39:53 PM -04, Theodore Ts'o wrote;
>> 
>>> On Thu, May 09, 2024 at 04:16:34PM +0100, Luis Henriques wrote:
>>>>
>>>> It's looks like it's easy to trigger an infinite loop here using fstest
>>>> generic/039.  If I understand it correctly (which doesn't happen as often
>>>> as I'd like), this is due to an integer overflow in the 'if' condition,
>>>> and should be fixed with the patch below.
>>>
>>> Thanks for the report.  However, I can't reproduce the failure, and
>>> looking at generic/039, I don't see how it could be relevant to the
>>> code path in question.  Generic/039 creates a test symlink with two
>>> hard links in the same directory, syncs the file system, and then
>>> removes one of the hard links, and then drops access to the block
>>> device using dmflakey.  So I don't see how the extent code would be
>>> involved at all.  Are you sure that you have the correct test listed?
>> 
>> Yep, I just retested and it's definitely generic/039.  I'm using a simple
>> test environment, with virtme-ng.
>> 
>>> Looking at the code in question in fs/ext4/extents.c:
>>>
>>> again:
>>> 	ext4_es_find_extent_range(inode, &ext4_es_is_delayed, hole_start,
>>> 				  hole_start + len - 1, &es);
>>> 	if (!es.es_len)
>>> 		goto insert_hole;
>>>
>>>   	 * There's a delalloc extent in the hole, handle it if the delalloc
>>>   	 * extent is in front of, behind and straddle the queried range.
>>>   	 */
>>>  -	if (lblk >= es.es_lblk + es.es_len) {
>>>  +	if (lblk >= ((__u64) es.es_lblk) + es.es_len) {
>>>   		/*
>>>   		 * The delalloc extent is in front of the queried range,
>>>   		 * find again from the queried start block.
>>> 		len -= lblk - hole_start;
>>> 		hole_start = lblk;
>>> 		goto again;
>>>
>>> lblk and es.es_lblk are both __u32.  So the infinite loop is
>>> presumably because es.es_lblk + es.es_len has overflowed.  This should
>>> never happen(tm), and in fact we have a test for this case which
>> 
>> If I instrument the code, I can see that es.es_len is definitely set to
>> EXT_MAX_BLOCKS, which will overflow.
>> 
>
> Thanks for the report. After looking at the code, I think the root
> cause of this issue is the variable es was not initialized on replaying
> fast commit. ext4_es_find_extent_range() will return directly when
> EXT4_FC_REPLAY flag is set, and then the es.len becomes stall.
>
> I can always reproduce this issue on generic/039 with
> MKFS_OPTIONS="-O fast_commit".
>
> This uninitialization problem originally existed in the old
> ext4_ext_put_gap_in_cache(), but it didn't trigger any real problem
> since we never check and use extent cache when replaying fast commit.
> So I suppose the correct fix would be to unconditionally initialize
> the es variable.

Oh, you're absolutely right -- the extent_status 'es' struct isn't being
initialized in that case.  I totally failed to see that.  And yes, I also
failed to mention I had 'fast_commit' feature enabled, sorry!

Thanks a lot for figuring this out, Yi.  I'm looking at this code and
trying to understand if it would be safe to call __es_find_extent_range()
when EXT4_FC_REPLAY is in progress.  Probably not, and probably better to
simply do:

	es->es_lblk = es->es_len = es->es_pblk = 0;

in that case.  I'll send out a patch later today.

Cheers,
-- 
Luis


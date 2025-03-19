Return-Path: <linux-fsdevel+bounces-44437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9C0A68C49
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 13:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06AE97A4AE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 12:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CA8255E44;
	Wed, 19 Mar 2025 12:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="M8XApqE3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E341255E23;
	Wed, 19 Mar 2025 12:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742385689; cv=none; b=tNNyogMbUjET7D++HyqzYXOABiNLsycSpjIhpbFvFrtEBeV9dL50aIANOwvDcYlSYtbXs59iNommzXSEPeMM4xtj58tjwJhpK0F/deAnKdnETHLvyyPycBwiWCiaJEZyOfREtQYF5gjTbzAMvmO1CdMMDt/GFg+QTbjYJXO+uZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742385689; c=relaxed/simple;
	bh=A8H1WorVwDo2oRC0Urta+axc7TUCB4Db7AdYINyC9NU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=purTM3GRsKeg40iV13BVxexFZhKGl3zXRkp7rywiC1H8HH4QP7mfE6dVzHwQBoQLQh4us9jlN9fY9+Zx7iU3Fr8De0ZqSc7HbQbHhf1yBRqRrF1/cPxPRnP0XfL8b4JXeRbRGE6923KnD7miPY73frbjMGr/dP/10nx8q8A/aAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=M8XApqE3; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1742385676; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=3bTztN10K28UyNMqDDdeWXLtebgPE/wrCTgmoZhdlWg=;
	b=M8XApqE35qaT9zwfXjOZOcx6EY6VyJQWKCHm3GZia1zSzhTVmAQNKBvZDCKZh6WOYpZ5gK+IBn2fXw/BvnWSCCPNX1HL4H3vsWR5MwwzDK63L4cbxhGe3S1Rut6gQ7XpJxWVT5LLeD0m8VE6Nq8TxfFHwHu11AI+EbPuyO6tRYg=
Received: from 30.134.66.95(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WS3NGrf_1742385675 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Mar 2025 20:01:16 +0800
Message-ID: <f595e8f6-04d1-4b0c-9d6d-9cdd31580287@linux.alibaba.com>
Date: Wed, 19 Mar 2025 20:01:15 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iomap: fix inline data on buffered read
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org,
 Bo Liu <liubo03@inspur.com>, Christoph Hellwig <hch@lst.de>,
 "Darrick J. Wong" <djwong@kernel.org>
References: <20250319085125.4039368-1-hsiangkao@linux.alibaba.com>
 <Z9qqSHlItlWJCPJz@bfoster>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <Z9qqSHlItlWJCPJz@bfoster>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Brian,

On 2025/3/19 19:28, Brian Foster wrote:
> On Wed, Mar 19, 2025 at 04:51:25PM +0800, Gao Xiang wrote:
>> Previously, iomap_readpage_iter() returning 0 would break out of the
>> loops of iomap_readahead_iter(), which is what iomap_read_inline_data()
>> relies on.
>>
>> However, commit d9dc477ff6a2 ("iomap: advance the iter directly on
>> buffered read") changes this behavior without calling
>> iomap_iter_advance(), which causes EROFS to get stuck in
>> iomap_readpage_iter().
>>
>> It seems iomap_iter_advance() cannot be called in
>> iomap_read_inline_data() because of the iomap_write_begin() path, so
>> handle this in iomap_readpage_iter() instead.
>>
>> Reported-and-tested-by: Bo Liu <liubo03@inspur.com>
>> Fixes: d9dc477ff6a2 ("iomap: advance the iter directly on buffered read")
>> Cc: Brian Foster <bfoster@redhat.com>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: "Darrick J. Wong" <djwong@kernel.org>
>> Cc: Christian Brauner <brauner@kernel.org>
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
> 
> Ugh. I'd hoped ext4 testing would have uncovered such an issue, but now
> that I think of it, IIRC ext4 isn't fully on iomap yet so wouldn't have
> provided this coverage. So apologies for the testing oversight on my
> part and thanks for the fix.
> 
> For future reference, do you guys have any documentation or whatever to
> run quick/smoke fstests against EROFS? (I assume this could be
> reproduced via fstests..?).

I don't think any existing testcase of fstests is
useful for readonly filesystems like EROFS since
EROFS only has read interface so all test cases
including regression tests will be integrated
into erofs-utils directly.

EROFS can be easily tested with its own testcases
in erofs-utils:

git clone git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git
cd erofs-utils
git checkout origin/experimental-tests	  # for now, I will integrate to main later.
./autogen.sh
./configure
make check

Without this patch, test cases will just hang.

> 

...

> 
> Reviewed-by: Brian Foster <bfoster@redhat.com>

Thanks.

Thanks,
Gao Xiang

> 
>>   
>>   	/* zero post-eof blocks as the page may be mapped */
>>   	ifs = ifs_alloc(iter->inode, folio, iter->flags);
>> -- 
>> 2.43.5
>>



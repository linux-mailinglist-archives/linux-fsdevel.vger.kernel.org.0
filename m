Return-Path: <linux-fsdevel+bounces-58069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF28B289AD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Aug 2025 03:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DDD11CC379D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Aug 2025 01:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AD43F9FB;
	Sat, 16 Aug 2025 01:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LE74p5T1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFC679F5
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Aug 2025 01:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755308749; cv=none; b=EyXpuSGRHnnOlQS9ilu18SG9EXmT/bN8AyYmWwPm6kbo4OnkYMDGdsHHhp18kn30yyzwEDtU3AwIYo+0xskUmGSWJliK4+u3M61ppe63P5OC3HgJf+OHEkf/GGCkmcE5rS9YpYYv9+pRzF4Lfm4BGRmr53IUKl3H6lox+oZ1tNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755308749; c=relaxed/simple;
	bh=zIz9WlhsJfmf+2lkbiNGo2GppYqimAl+RUWm+nRD8QM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sqgVlvqix3G+SICDLFRGdQ+B3+LpUYo8o0ahMrQnxbONcBlUbzyly6oaSK/jNfkMCXDp2T6Zwjex079dBtXnQXxBHG2ddMitRXZMZ11BMYnI99aIkPY57R9ZUXv+FCnN9ODHYd0KKAwR6IuiMnCP82C93V8+EVpH1qvBcCiWF8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LE74p5T1; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755308744; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=1UCZUTMIy+CHCW1VElQQc0/FnsUUu6qAGUvt8ZLreFI=;
	b=LE74p5T15hS8Nzuj8caSUR8b5hZrTJng+65ix8YIOagNQy8ospY868J6BTC+WFRVwm3SJ+a/L5a4AfYprWdp4fkVsw08s+b2zgra5r8VRCpn5jS6345Xtg3P1+rkeT7eEXn6rf4BYZSZzHrOHY4RBacGPNd5Wu0R4ClDqEmJkLk=
Received: from 30.221.144.75(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WlqC2ww_1755308743 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 16 Aug 2025 09:45:44 +0800
Message-ID: <7f04d454-8b80-4e44-ba5a-06a124a4ca66@linux.alibaba.com>
Date: Sat, 16 Aug 2025 09:45:43 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: enable large folios (if writeback cache is unused)
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 bernd.schubert@fastmail.fm, willy@infradead.org, kernel-team@meta.com
References: <20250811204008.3269665-1-joannelkoong@gmail.com>
 <6bd47f03-8638-4460-9349-deebd1184b45@linux.alibaba.com>
 <CAJnrk1b1twpme35YVgvzKj8Hq8E9DXpAi+Jb8=pQCpXQrkSaFA@mail.gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAJnrk1b1twpme35YVgvzKj8Hq8E9DXpAi+Jb8=pQCpXQrkSaFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/16/25 12:16 AM, Joanne Koong wrote:
> On Fri, Aug 15, 2025 at 4:01 AM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>
>>
>>
>> On 8/12/25 4:40 AM, Joanne Koong wrote:
>>> Large folios are only enabled if the writeback cache isn't on.
>>> (Strictlimiting needs to be turned off if the writeback cache is used in
>>> conjunction with large folios, else this tanks performance.)
>>>
>>> Benchmarks showed noticeable improvements for writes (both sequential
>>> and random). There were no performance differences seen for random reads
>>> or direct IO. For sequential reads, there was no performance difference
>>> seen for the first read (which populates the page cache) but subsequent
>>> sequential reads showed a huge speedup.
>>>
>>> Benchmarks were run using fio on the passthrough_hp fuse server:
>>> ~/libfuse/build/example/passthrough_hp ~/libfuse ~/fuse_mnt --nopassthrough --nocache
>>>
>>> run fio in ~/fuse_mnt:
>>> fio --name=test --ioengine=sync --rw=write --bs=1M --size=5G --numjobs=2 --ramp_time=30 --group_reporting=1
>>>
>>> Results (tested on bs=256K, 1M, 5M) showed roughly a 15-20% increase in
>>> write throughput and for sequential reads after the page cache has
>>> already been populated, there was a ~800% speedup seen.
>>>
>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>> ---
>>>  fs/fuse/file.c | 18 ++++++++++++++++--
>>>  1 file changed, 16 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>>> index adc4aa6810f5..2e7aae294c9e 100644
>>> --- a/fs/fuse/file.c
>>> +++ b/fs/fuse/file.c
>>> @@ -1167,9 +1167,10 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
>>>               pgoff_t index = pos >> PAGE_SHIFT;
>>>               unsigned int bytes;
>>>               unsigned int folio_offset;
>>> +             fgf_t fgp = FGP_WRITEBEGIN | fgf_set_order(num);
>>>
>>>   again:
>>> -             folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
>>> +             folio = __filemap_get_folio(mapping, index, fgp,
>>>                                           mapping_gfp_mask(mapping));
>>>               if (IS_ERR(folio)) {
>>>                       err = PTR_ERR(folio);
>>> @@ -3155,11 +3156,24 @@ void fuse_init_file_inode(struct inode *inode, unsigned int flags)
>>>  {
>>>       struct fuse_inode *fi = get_fuse_inode(inode);
>>>       struct fuse_conn *fc = get_fuse_conn(inode);
>>> +     unsigned int max_pages, max_order;
>>>
>>>       inode->i_fop = &fuse_file_operations;
>>>       inode->i_data.a_ops = &fuse_file_aops;
>>> -     if (fc->writeback_cache)
>>> +     if (fc->writeback_cache) {
>>>               mapping_set_writeback_may_deadlock_on_reclaim(&inode->i_data);
>>> +     } else {
>>> +             /*
>>> +              * Large folios are only enabled if the writeback cache isn't on.
>>> +              * If the writeback cache is on, large folios should only be
>>> +              * enabled in conjunction with strictlimiting turned off, else
>>> +              * performance tanks.
>>> +              */
>>> +             max_pages = min(min(fc->max_write, fc->max_read) >> PAGE_SHIFT,
>>> +                             fc->max_pages);
>>> +             max_order = ilog2(max_pages);
>>> +             mapping_set_folio_order_range(inode->i_mapping, 0, max_order);
>>> +     }
>>
>> JFYI fc->max_read shall also be honored when calculating max_order,
>> otherwise the following warning in fuse_readahead() may be triggered.
>>
> Hi Jingbo,
> 
> I think fc->max_read gets honored in the "min(fc->max_write,
> fc->max_read)" part of the max_pages calculation above.
> 

Opps, yeah.  My fault, sorry for the noise.


-- 
Thanks,
Jingbo



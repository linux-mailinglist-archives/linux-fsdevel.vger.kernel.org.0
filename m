Return-Path: <linux-fsdevel+bounces-60735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B46FB50CF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 07:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AA283A0770
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 05:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AA52BE63D;
	Wed, 10 Sep 2025 04:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fbM1aV9h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D57BEAC7;
	Wed, 10 Sep 2025 04:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757480395; cv=none; b=JYvLUlTehivQMaBsoYus7HT9qmLjoQpV9Hl77rO5majjIiSbuKYgMmKvrsldcaRWJB9C7NXxywj3ZXAAVSt5q52xJzMbdvvEq/lc20vtsoIRfJpE8Y+6WqBY41jTmO0u0O23PkMjlcsBWrf7/s7tFYzpStjzVZV0mvB1mX36TvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757480395; c=relaxed/simple;
	bh=lj5kD8P6093sAHvRDXOxI/tbWQdnAOy4Ybz98dwxlLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WTEQBtUWootuDzV0wyLKobT0XijYu3ze0QVaHxW2MwocLIjgKeSpbVNGJAZrFWCUbfwALCzDuoVg7zRg2tT81q6bQDXT4MLn8zqTVp5i44WkMcpU6SqUsFEyxUkVXkCCaBoCF2csRooiciyjURptsGo/oMXwBW3cl5NiWELi/i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fbM1aV9h; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757480384; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=nhxJhzMQKjnuR6FVjOzzTFISD7o26U38o9kESPDCcIc=;
	b=fbM1aV9hyw5e8BiEuSZibcFsYnCPoc4/YHDqD2FFARYycVnsy1MK+Rs5iTQU5e3RYgckPTE5uYPxFTagkPHqQH2jyiTfX+sfAQ5T5LT0fT07DNg9BSQQviEgq+4cvMZulkcvocgH6csDQbthIXRqH2WnIGxs9vnybVya+alD24M=
Received: from 30.221.131.126(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wngc.UD_1757480382 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 10 Sep 2025 12:59:43 +0800
Message-ID: <0b33ab17-2fc0-438f-95aa-56a1d20edb38@linux.alibaba.com>
Date: Wed, 10 Sep 2025 12:59:41 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/16] iomap: move read/readahead logic out of
 CONFIG_BLOCK guard
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org,
 djwong@kernel.org, linux-block@vger.kernel.org, gfs2@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
 linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-14-joannelkoong@gmail.com>
 <a1529c0f-1f1a-477a-aeeb-a4f108aab26b@linux.alibaba.com>
 <CAJnrk1aCCqoOAgcPUpr+Z09DhJ5BAYoSho5dveGQKB9zincYSQ@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAJnrk1aCCqoOAgcPUpr+Z09DhJ5BAYoSho5dveGQKB9zincYSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/9/9 23:33, Joanne Koong wrote:
> On Mon, Sep 8, 2025 at 10:14 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>> On 2025/9/9 02:51, Joanne Koong wrote:
>>> There is no longer a dependency on CONFIG_BLOCK in the iomap read and
>>> readahead logic. Move this logic out of the CONFIG_BLOCK guard. This
>>> allows non-block-based filesystems to use iomap for reads/readahead.
>>>
>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>> ---
>>>    fs/iomap/buffered-io.c | 151 +++++++++++++++++++++--------------------
>>>    1 file changed, 76 insertions(+), 75 deletions(-)
>>>
>>> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
>>> index f673e03f4ffb..c424e8c157dd 100644
>>> --- a/fs/iomap/buffered-io.c
>>> +++ b/fs/iomap/buffered-io.c
>>> @@ -358,81 +358,6 @@ void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
>>>    }
>>> +
>>> +/**
>>> + * Read in a folio range asynchronously through bios.
>>> + *
>>> + * This should only be used for read/readahead, not for buffered writes.
>>> + * Buffered writes must read in the folio synchronously.
>>> + */
>>> +static int iomap_read_folio_range_bio_async(const struct iomap_iter *iter,
>>> +             struct iomap_read_folio_ctx *ctx, loff_t pos, size_t plen)
>>> +{
>>> +     struct folio *folio = ctx->cur_folio;
>>> +     const struct iomap *iomap = &iter->iomap;
>>> +     size_t poff = offset_in_folio(folio, pos);
>>> +     loff_t length = iomap_length(iter);
>>> +     sector_t sector;
>>> +     struct bio *bio = ctx->private;
>>> +
>>> +     iomap_start_folio_read(folio, plen);
>>> +
>>> +     sector = iomap_sector(iomap, pos);
>>> +     if (!bio || bio_end_sector(bio) != sector ||
>>> +         !bio_add_folio(bio, folio, plen, poff)) {
>>> +             gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
>>> +             gfp_t orig_gfp = gfp;
>>> +             unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
>>> +
>>> +             if (bio)
>>> +                     submit_bio(bio);
>>> +
>>> +             if (ctx->rac) /* same as readahead_gfp_mask */
>>> +                     gfp |= __GFP_NORETRY | __GFP_NOWARN;
>>> +             bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
>>> +                                  REQ_OP_READ, gfp);
>>> +             /*
>>> +              * If the bio_alloc fails, try it again for a single page to
>>> +              * avoid having to deal with partial page reads.  This emulates
>>> +              * what do_mpage_read_folio does.
>>> +              */
>>> +             if (!bio)
>>> +                     bio = bio_alloc(iomap->bdev, 1, REQ_OP_READ, orig_gfp);
>>> +             if (ctx->rac)
>>> +                     bio->bi_opf |= REQ_RAHEAD;
>>> +             bio->bi_iter.bi_sector = sector;
>>> +             bio->bi_end_io = iomap_read_end_io;
>>> +             bio_add_folio_nofail(bio, folio, plen, poff);
>>> +             ctx->private = bio;
>>
>> Yes, I understand some way is needed to isolate bio from non-bio
>> based filesystems, and I also agree `bio` shouldn't be stashed
>> into `iter->private` since it's just an abuse usage as mentioned
>> in:
>> https://lore.kernel.org/r/20250903203031.GM1587915@frogsfrogsfrogs
>> https://lore.kernel.org/r/aLkskcgl3Z91oIVB@infradead.org
>>
>> However, the naming of `(struct iomap_read_folio_ctx)->private`
>> really makes me feel confused because the `private` name in
>> `read_folio_ctx` is much like a filesystem read context instead
>> of just be used as `bio` internally in iomap for block-based
>> filesystems.
>>
>> also the existing of `iter->private` makes the naming of
>> `ctx->private` more confusing at least in my view.
> 
> Do you think "ctx->data" would be better? Or is there something else
> you had in mind?

At least it sounds better on my side, but anyway it's just
my own overall thought.  If other folks have different idea,
I don't have strong opinion, I just need something for my own
as previous said.

Thanks,
Gao Xiang

> 
> Thanks,
> Joanne
>>
>> Thanks,
>> Gao Xiang



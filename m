Return-Path: <linux-fsdevel+bounces-24847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF348945674
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 04:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CD6CB22C32
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 02:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642161CAAF;
	Fri,  2 Aug 2024 02:57:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B547A13A;
	Fri,  2 Aug 2024 02:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722567470; cv=none; b=nT9PjiuhCjP+RF8T330ySLM+6Jq2GJ4vtu3/404QDp6Px0/ZMRXePk9g7GSmo34lNrl49cQ+JQcVYkiEM+aO4os4fWUcSozCkTaxVHoMI2omymROr3U8a2ALIdU2tYYTxOYrK81LSlOQhMpHCcugX1mBMb12dIwTugQZkUg33lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722567470; c=relaxed/simple;
	bh=Ky8NxVSblEJ2L86FKaPjuMhj1pzuGVaEyqERYdCcTOQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=bXRjT2M1Y0XaLyUwP7H+LAPiteZKvEy3SGZIpKEcTcdJcZyE3YpXeLYx/99khNt5kNA+y0/qYzjvI0sqjJVmzLpgeV3kysP+xgvNyc2UT71S1GohEJrqTjKtmsJ0hdEyq+JdKVL5czQxpC/aVr1eB0VsxjOc5QO+8DujCQUx7Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WZr9C0KM6z4f3jYx;
	Fri,  2 Aug 2024 10:57:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C69671A15D6;
	Fri,  2 Aug 2024 10:57:43 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgCXv4UlS6xmjwQZAg--.57908S3;
	Fri, 02 Aug 2024 10:57:43 +0800 (CST)
Subject: Re: [PATCH 5/6] iomap: drop unnecessary state_lock when setting ifs
 uptodate bits
To: Dave Chinner <david@fromorbit.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
 brauner@kernel.org, jack@suse.cz, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com
References: <20240731091305.2896873-1-yi.zhang@huaweicloud.com>
 <20240731091305.2896873-6-yi.zhang@huaweicloud.com>
 <Zqwi48H74g2EX56c@dread.disaster.area>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <b40a510d-37b3-da50-79db-d56ebd870bf0@huaweicloud.com>
Date: Fri, 2 Aug 2024 10:57:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zqwi48H74g2EX56c@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCXv4UlS6xmjwQZAg--.57908S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCF48Aw17Aw1kAF1xZr1DKFg_yoWrKrWxpF
	Z8Ka4DKr4ktFWxZwn7Xr1xXF1F9anrW3yrCFZ3K345AF98XF1SgF1I9ay5urW8Jws3Cr1F
	qr40v34kuFWUZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/8/2 8:05, Dave Chinner wrote:
> On Wed, Jul 31, 2024 at 05:13:04PM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Commit '1cea335d1db1 ("iomap: fix sub-page uptodate handling")' fix a
>> race issue when submitting multiple read bios for a page spans more than
>> one file system block by adding a spinlock(which names state_lock now)
>> to make the page uptodate synchronous. However, the race condition only
>> happened between the read I/O submitting and completeing threads,
> 
> when we do writeback on a folio that has multiple blocks on it we
> can submit multiple bios for that, too. Hence the write completions
> can race with each other and write submission, too.
> 
> Yes, write bio submission and completion only need to update ifs
> accounting using an atomic operation, but the same race condition
> exists even though the folio is fully locked at the point of bio
> submission.
> 
> 
>> it's
>> sufficient to use page lock to protect other paths, e.g. buffered write
>                     ^^^^ folio
>> path.
>>
>> After large folio is supported, the spinlock could affect more
>> about the buffered write performance, so drop it could reduce some
>> unnecessary locking overhead.
> 
> From the point of view of simple to understand and maintain code, I
> think this is a bad idea. The data structure is currently protected
> by the state lock in all situations, but this change now makes it
> protected by the state lock in one case and the folio lock in a
> different case.

Yeah, I agree that this is a side-effect of this change, after this patch,
we have to be careful to distinguish between below two cases B1 and B2 as
Willy mentioned.

B. If ifs_set_range_uptodate() is called from iomap_set_range_uptodate(),
   either we know:
B1. The caller of iomap_set_range_uptodate() holds the folio lock, and this
    is the only place that can call ifs_set_range_uptodate() for this folio
B2. The caller of iomap_set_range_uptodate() holds the state lock

> 
> Making this change also misses the elephant in the room: the
> buffered write path still needs the ifs->state_lock to update the
> dirty bitmap. Hence we're effectively changing the serialisation
> mechanism for only one of the two ifs state bitmaps that the
> buffered write path has to update.
> 
> Indeed, we can't get rid of the ifs->state_lock from the dirty range
> updates because iomap_dirty_folio() can be called without the folio
> being locked through folio_mark_dirty() calling the ->dirty_folio()
> aop.
> 

Sorry, I don't understand, why folio_mark_dirty() could be called without
folio lock (isn't this supposed to be a bug)? IIUC, all the file backed
folios must be locked before marking dirty. Are there any exceptions or am
I missing something?

> IOWs, getting rid of the state lock out of the uptodate range
> changes does not actually get rid of it from the buffered IO patch.
> we still have to take it to update the dirty range, and so there's
> an obvious way to optimise the state lock usage without changing any
> of the bitmap access serialisation behaviour. i.e.  We combine the
> uptodate and dirty range updates in __iomap_write_end() into a
> single lock context such as:
> 
> iomap_set_range_dirty_uptodate()
> {
> 	struct iomap_folio_state *ifs = folio->private;
> 	struct inode *inode:
>         unsigned int blks_per_folio;
>         unsigned int first_blk;
>         unsigned int last_blk;
>         unsigned int nr_blks;
> 	unsigned long flags;
> 
> 	if (!ifs)
> 		return;
> 
> 	inode = folio->mapping->host;
> 	blks_per_folio = i_blocks_per_folio(inode, folio);
> 	first_blk = (off >> inode->i_blkbits);
> 	last_blk = (off + len - 1) >> inode->i_blkbits;
> 	nr_blks = last_blk - first_blk + 1;
> 
> 	spin_lock_irqsave(&ifs->state_lock, flags);
> 	bitmap_set(ifs->state, first_blk, nr_blks);
> 	bitmap_set(ifs->state, first_blk + blks_per_folio, nr_blks);
> 	spin_unlock_irqrestore(&ifs->state_lock, flags);
> }
> 
> This means we calculate the bitmap offsets only once, we take the
> state lock only once, and we don't do anything if there is no
> sub-folio state.
> 
> If we then fix the __iomap_write_begin() code as Willy pointed out
> to elide the erroneous uptodate range update, then we end up only
> taking the state lock once per buffered write instead of 3 times per
> write.
> 
> This patch only reduces it to twice per buffered write, so doing the
> above should provide even better performance without needing to
> change the underlying serialisation mechanism at all.
> 

Thanks for the suggestion. I've thought about this solution too, but I
didn't think we need the state_lock when setting ifs dirty bit since the
folio lock should work, so I changed my mind and planed to drop all ifs
state_lock in the write path (please see the patch 6). Please let me
know if I'm wrong.

Thanks,
Yi.



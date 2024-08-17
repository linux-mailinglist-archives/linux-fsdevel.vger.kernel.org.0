Return-Path: <linux-fsdevel+bounces-26174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D48449555BE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 08:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88A271F22A04
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 06:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEFB139D07;
	Sat, 17 Aug 2024 06:16:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25283BA2D;
	Sat, 17 Aug 2024 06:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723875399; cv=none; b=ZOrwXBSDX2hra12XNxzXAC8HAmqowaDVqQThw1pfNa/Qo3xIwiS7WTKZmeyaqBZ44eagePFKNkzRUFoHvyfdke9E7QTrtb0ra5zeNVRQ5QGDm+8JEMTAZ9BpGLyZhKLdsZlYACLUi40XbEzKJ5xheeph8seaXVUpHqOKvlHNdhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723875399; c=relaxed/simple;
	bh=4IRGa72FdT2uVCvD1C6kgQEUqWo/gKm1kKoke0mBBZ8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=QUf67vEK8/UjLeb6Cp335kKnCkFHq39yBv/4ow4qjjvRKTf4RjhQwONvF0thtPWRQwZg4UggdmUDHRmZg4nuS8o86hd/L1AIBjjI9dPmfDlqXlppIEmmyUFXvpm1EeBLJQcYwbDvhPYJPGhNgAKxZPdbkUmbj32VyzGv+/NP/cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wm7sg0fgVz4f3jjk;
	Sat, 17 Aug 2024 14:16:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 899701A06D7;
	Sat, 17 Aug 2024 14:16:32 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgBXzII+QMBmzDWwBw--.2489S3;
	Sat, 17 Aug 2024 14:16:32 +0800 (CST)
Subject: Re: [PATCH v2 3/6] iomap: advance the ifs allocation if we have more
 than one blocks per folio
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 djwong@kernel.org, brauner@kernel.org, david@fromorbit.com, jack@suse.cz,
 yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
References: <20240812121159.3775074-1-yi.zhang@huaweicloud.com>
 <20240812121159.3775074-4-yi.zhang@huaweicloud.com>
 <ZrxBfKi_DpThYo94@infradead.org>
 <58d9c752-1b40-0af8-370c-cf03144c54c0@huaweicloud.com>
 <ZsAqG-Q527PYWYrz@casper.infradead.org>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <73a60117-79c2-fa69-2113-1932a644363f@huaweicloud.com>
Date: Sat, 17 Aug 2024 14:16:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZsAqG-Q527PYWYrz@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXzII+QMBmzDWwBw--.2489S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CF13tw1UZrWUtr4kWrWUCFg_yoW8KFy3pF
	9rKFyDGFW8Ga17Cr9293W7Zw1Fq347JFy5XF4aqw1akFn0q3W7K3W2ga4jkay7Gwn7Aw40
	q3y7XFZrWFy5A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/8/17 12:42, Matthew Wilcox wrote:
> On Sat, Aug 17, 2024 at 12:27:49PM +0800, Zhang Yi wrote:
>> On 2024/8/14 13:32, Christoph Hellwig wrote:
>>> On Mon, Aug 12, 2024 at 08:11:56PM +0800, Zhang Yi wrote:
>>>> From: Zhang Yi <yi.zhang@huawei.com>
>>>>
>>>> Now we allocate ifs if i_blocks_per_folio is larger than one when
>>>> writing back dirty folios in iomap_writepage_map(), so we don't attach
>>>> an ifs after buffer write to an entire folio until it starts writing
>>>> back, if we partial truncate that folio, iomap_invalidate_folio() can't
>>>> clear counterpart block's dirty bit as expected. Fix this by advance the
>>>> ifs allocation to __iomap_write_begin().
>>>
>>> Wouldn't it make more sense to only allocate the ifѕ in
>>> iomap_invalidate_folio when it actually is needed?
>>>
>>
>> I forget to mention that truncate_inode_partial_folio() call
>> folio_invalidate()->iomap_invalidate_folio() only when the folio has
>> private, if the folio doesn't has ifs, the iomap_invalidate_folio()
>> would nerver be called, hence allocate the ifs in
>> iomap_invalidate_folio() is useless.
>>
>> In my opinion, one solution is change to always call folio_invalidate()
>> in truncate_inode_partial_folio(), all callbacks should handle the no
>> private case. Another solution is add a magic (a fake ifs) to
>> folio->private and then convert it to a real one in
>> iomap_invalidate_folio(), any thoughts?
> 
> Why do we need iomap_invalidate_folio() to be called if there is no ifs?
> Even today, all it does is call ifs_free() if we're freeing the entire
> folio (which is done by truncate_cleanup_folio() and not by
> truncate_inode_partial_folio().
> 
Please see patch 2, if we truncate a partial folio (through punch hole or
truncate) on a filesystem with blocksize < folio size, it will left over
dirty bits of truncated/punched blocks, and this will lead to a hole with
dirty bit set but without any block allocated/reserved, this is not
correct.

Hence we also need to call iomap_invalidate_folio() by
truncate_inode_partial_folio() and clear partial folio of the counterpart
dirty bits. But now we don't allocate ifs in __iomap_write_begin() when
writing an entire folio, so it doesn't has ifs, but we still can
partial truncate this folio, we should allocate ifs for it and update
the dirty bits on it.

Thanks,
Yi.




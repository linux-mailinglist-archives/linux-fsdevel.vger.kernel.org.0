Return-Path: <linux-fsdevel+bounces-24743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2904944812
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 11:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65FF9288239
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 09:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A15194139;
	Thu,  1 Aug 2024 09:19:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFB416DEAF;
	Thu,  1 Aug 2024 09:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722503986; cv=none; b=LbNeXbd5Gu3EBjk4nSuUV2hfCJLyoZbKbWPN4Akrk/yqJYhMkSf8AplXp44H51CgO63WmgSlees5YoDczvfoeZXjmy0zfXOTXD6dX/+p0lny0C4pvREH98GJTxJwAYwI9kg3FbcwlUVx7PIZY62kGOiMDqzTUSbLA0tMEDyMnjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722503986; c=relaxed/simple;
	bh=oFM1Mp/ps7HP8DInldhst8KIxf1A+0ExOvFbzVJ5gr0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Ig4cLJd6+SSR1PkcGLUnJAvJuUFtbyJ9Bw5jjAXEFX1xVqoNENtb015ilZE20QRuZCIy39gQX49rpFnnVWPiP/OQ9gDMHH071qM13xTKhLcFxd/i0+SP9o7w6FjUz8t819H34QGoLGiWyjo8htrjgPLn0aiZlx6lU2dUOwmduao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WZNh90xkQz4f3jdc;
	Thu,  1 Aug 2024 17:19:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1A8051A07B6;
	Thu,  1 Aug 2024 17:19:34 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgAXPoQjU6tmXkjTAQ--.27228S3;
	Thu, 01 Aug 2024 17:19:33 +0800 (CST)
Subject: Re: [PATCH 5/6] iomap: drop unnecessary state_lock when setting ifs
 uptodate bits
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
 brauner@kernel.org, david@fromorbit.com, jack@suse.cz, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com
References: <20240731091305.2896873-1-yi.zhang@huaweicloud.com>
 <20240731091305.2896873-6-yi.zhang@huaweicloud.com>
 <ZqprvNM5itMbanuH@casper.infradead.org>
 <995196b3-3571-b23f-eb5f-d3fee5d97593@huaweicloud.com>
 <ZqsN5ouQTEc1KAzV@casper.infradead.org>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <bf4479d1-78d4-2bc0-9f8f-6434df8e6368@huaweicloud.com>
Date: Thu, 1 Aug 2024 17:19:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZqsN5ouQTEc1KAzV@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAXPoQjU6tmXkjTAQ--.27228S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXF1DCFW8Jr17Xr48Xr4xWFg_yoWrXF18pr
	yDKFyDKr4DJFWfZrn7tFn3Xr10v3yfA3yrWa9xtw1UAFn8CFyagFWI9ay5CrW8X3s3GrWa
	qF40q3s3Wa4UZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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

On 2024/8/1 12:24, Matthew Wilcox wrote:
> On Thu, Aug 01, 2024 at 09:52:49AM +0800, Zhang Yi wrote:
>> On 2024/8/1 0:52, Matthew Wilcox wrote:
>>> On Wed, Jul 31, 2024 at 05:13:04PM +0800, Zhang Yi wrote:
>>>> Commit '1cea335d1db1 ("iomap: fix sub-page uptodate handling")' fix a
>>>> race issue when submitting multiple read bios for a page spans more than
>>>> one file system block by adding a spinlock(which names state_lock now)
>>>> to make the page uptodate synchronous. However, the race condition only
>>>> happened between the read I/O submitting and completeing threads, it's
>>>> sufficient to use page lock to protect other paths, e.g. buffered write
>>>> path. After large folio is supported, the spinlock could affect more
>>>> about the buffered write performance, so drop it could reduce some
>>>> unnecessary locking overhead.
>>>
>>> This patch doesn't work.  If we get two read completions at the same
>>> time for blocks belonging to the same folio, they will both write to
>>> the uptodate array at the same time.
>>>
>> This patch just drop the state_lock in the buffered write path, doesn't
>> affect the read path, the uptodate setting in the read completion path
>> is still protected the state_lock, please see iomap_finish_folio_read().
>> So I think this patch doesn't affect the case you mentioned, or am I
>> missing something?
> 
> Oh, I see.  So the argument for locking correctness is that:
> 
> A. If ifs_set_range_uptodate() is called from iomap_finish_folio_read(),
>    the state_lock is held.
> B. If ifs_set_range_uptodate() is called from iomap_set_range_uptodate(),
>    either we know:
> B1. The caller of iomap_set_range_uptodate() holds the folio lock, and this
>     is the only place that can call ifs_set_range_uptodate() for this folio
> B2. The caller of iomap_set_range_uptodate() holds the state lock
> 
> But I think you've assigned iomap_read_inline_data() to case B1 when I
> think it's B2.  erofs can certainly have a file which consists of various
> blocks elsewhere in the file and then a tail that is stored inline.

Oh, you are right, thanks for pointing this out. I missed the case of
having both file blocks and inline data in one folio on erofs. So we
also need to hold state_lock in iomap_read_inline_data(), it looks like
we'd better to introduce a new common helper to do this job for B2.

> 
> __iomap_write_begin() is case B1 because it holds the folio lock, and
> submits its read(s) sychronously.  Likewise __iomap_write_end() is
> case B1.
> 
> But, um.  Why do we need to call iomap_set_range_uptodate() in both
> write_begin() and write_end()?
> 
> And I think this is actively buggy:
> 
>                if (iomap_block_needs_zeroing(iter, block_start)) {
>                         if (WARN_ON_ONCE(iter->flags & IOMAP_UNSHARE))
>                                 return -EIO;
>                         folio_zero_segments(folio, poff, from, to, poff + plen);
> ...
>                 iomap_set_range_uptodate(folio, poff, plen);
> 
> because we zero from 'poff' to 'from', then from 'to' to 'poff+plen',
> but mark the entire range as uptodate.  And once a range is marked
> as uptodate, it can be read from.
> 
> So we can do this:
> 
>  - Get a write request for bytes 1-4094 over a hole
>  - allocate single page folio
>  - zero bytes 0 and 4095
>  - mark 0-4095 as uptodate
>  - take page fault while trying to access the user address
>  - read() to bytes 0-4095 now succeeds even though we haven't written
>    1-4094 yet
> 
> And that page fault can be uffd or a buffer that's in an mmap that's
> out on disc.  Plenty of time to make this race happen, and we leak
> 4094/4096 bytes of the previous contents of that folio to userspace.
> 
> Or did I miss something?
> 

Indeed, this could happen on the filesystem without inode lock in the
buffered read path(I've checked it out on my ext4 buffered iomap
branch), and I guess it could also happen after a short copy happened
in the write path. We don't need iomap_set_range_uptodate() for the
zeroing case in __iomap_write_begin().

Thanks,
Yi.



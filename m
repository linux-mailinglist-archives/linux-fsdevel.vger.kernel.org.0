Return-Path: <linux-fsdevel+bounces-14265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2092487A333
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 08:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB7BB1F21E08
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 07:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61791642C;
	Wed, 13 Mar 2024 07:09:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0D614A8C;
	Wed, 13 Mar 2024 07:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710313764; cv=none; b=a1u4oHILG6eK+XCOBqMXzUhVwxpNKjT4wAGIwhvuZKpz33rPh+5RQFhupEG3wDR1SdiZlfzsOPuDk7fA5X/xnyQl8HfKm4uzZxYSK2Sy+Z2xVuL0Hj+I55/LQ7sTUT7rIQUsCiQ50aRt+JbE0v8ZyAY3KmofnYof2HM+9I8BGjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710313764; c=relaxed/simple;
	bh=DnVHKZQEGlZsUL1ra8rBA+RZSM3Wki43hGWrTwyDdKI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BeQfUgfxp/c39ZFBN6l4u63wq94jYNNPU7rdi3YTQg/nBLXaCEiWHJwmSwCTq0V3uZ3sLbbNFnfL7HulhIRBCBCLH2sJ1nJtUadUjUwhI3YGO0B6PLe+ShoTc0XJZOTBdbeSzxX7k4uTWwIQFRs35gXsxLG0ir49bvVdP1Yai90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TvhT66Bn7z4f3mWM;
	Wed, 13 Mar 2024 15:09:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 886931A0172;
	Wed, 13 Mar 2024 15:09:18 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBEdUfFlvR42Gw--.15382S3;
	Wed, 13 Mar 2024 15:09:18 +0800 (CST)
Subject: Re: [PATCH 3/4] iomap: don't increase i_size if it's not a write
 operation
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, hch@infradead.org, brauner@kernel.org,
 david@fromorbit.com, tytso@mit.edu, jack@suse.cz, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com
References: <20240311122255.2637311-1-yi.zhang@huaweicloud.com>
 <20240311122255.2637311-4-yi.zhang@huaweicloud.com>
 <20240311154829.GU1927156@frogsfrogsfrogs>
 <4a9e607e-36d1-4ea7-1754-c443906b3a1c@huaweicloud.com>
 <20240312162407.GC1927156@frogsfrogsfrogs>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <929f44c6-68e0-1a32-26fd-63b0e87f02fc@huaweicloud.com>
Date: Wed, 13 Mar 2024 15:09:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240312162407.GC1927156@frogsfrogsfrogs>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgBHGBEdUfFlvR42Gw--.15382S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WFW3XFy8Cr45Xw4DCw4xtFb_yoW8uF4rpr
	yIkayqk3WktF17ur1vqa45X3sayry5KrW7Jry7WF4fZr1qva1fKF1UGa45uF1kJ3sxAr43
	Xa1kA393WFZ8A37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IUbPEf5UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/3/13 0:24, Darrick J. Wong wrote:
> On Tue, Mar 12, 2024 at 08:59:15PM +0800, Zhang Yi wrote:
>> On 2024/3/11 23:48, Darrick J. Wong wrote:
>>> On Mon, Mar 11, 2024 at 08:22:54PM +0800, Zhang Yi wrote:
>>>> From: Zhang Yi <yi.zhang@huawei.com>
>>>>
[...]
>>>> @@ -927,6 +908,24 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>>>>  		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
>>>>  		status = iomap_write_end(iter, pos, bytes, copied, folio);
>>>>  
>>>> +		/*
>>>> +		 * Update the in-memory inode size after copying the data into
>>>> +		 * the page cache.  It's up to the file system to write the
>>>> +		 * updated size to disk, preferably after I/O completion so that
>>>> +		 * no stale data is exposed.
>>>> +		 */
>>>> +		old_size = iter->inode->i_size;
>>>> +		if (pos + status > old_size) {
>>>> +			i_size_write(iter->inode, pos + status);
>>>> +			iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
>>>> +		}
>>>> +		__iomap_put_folio(iter, pos, status, folio);
>>>
>>> Why is it necessary to hoist the __iomap_put_folio calls from
>>> iomap_write_end into iomap_write_iter, iomap_unshare_iter, and
>>> iomap_zero_iter?  None of those functions seem to use it, and it makes
>>> more sense to me that iomap_write_end releases the folio that
>>> iomap_write_begin returned.
>>>
>>
>> Because we have to update i_size before __iomap_put_folio() in
>> iomap_write_iter(). If not, once we unlock folio, it could be raced
>> by the backgroud write back which could start writing back and call
>> folio_zero_segment() (please see iomap_writepage_handle_eof()) to
>> zero out the valid data beyond the not updated i_size. So we
>> have to move out __iomap_put_folio() out together with the i_size
>> updating.
> 
> Ahah.  Please make a note of that in the comment for dunces like me.
> 
> 	/*
> 	 * Update the in-memory inode size after copying the data into
> 	 * the page cache.  It's up to the file system to write the
> 	 * updated size to disk, preferably after I/O completion so that
> 	 * no stale data is exposed.  Only once that's done can we
> 	 * unlock and release the folio.
> 	 */
> 

Sure.




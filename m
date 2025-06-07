Return-Path: <linux-fsdevel+bounces-50889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E11AD0B30
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 05:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D620F7A4D4A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 03:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D15258CE8;
	Sat,  7 Jun 2025 03:54:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAC71C4A0A;
	Sat,  7 Jun 2025 03:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749268465; cv=none; b=olO0sDyOA2AP0pINGtY8yHu8j3mNer6yLcWp5KBFTH004bZ+NITPyCTbASMttFXMWwfl52WODeAiZT3PdjLxkKlC64wAvHJgHZv1Ze7SnL2Y8SvTH2Ntp07VZ6zA+78u6Pgc+Tthp/lKcj9wmvxTKcbI7WkyNg1IE8e46IyhsY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749268465; c=relaxed/simple;
	bh=qbEiQkOsHUJ965c1iALiOT25uBXyJzl3QjH7l1SqTNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fNEWGe3RTK6CjfHdbERo9aYeLm7ISsDuiqS+siHwZKVLOQZ/MjUZZRwo1RmBABVbsp7OQtGu4e/hiadO6YYeV1+JeAnduUQM1rlXcRlPl3MCcBqwLBBj9UoNCPiQsjfprE8u6y47+T/H4RqwqnbseA2ewl3PzzmU5U6GeMoba34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bDkp30L7NzYQvXP;
	Sat,  7 Jun 2025 11:54:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 13AB51A0F22;
	Sat,  7 Jun 2025 11:54:18 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgBXvGDot0No5YoBOw--.1118S3;
	Sat, 07 Jun 2025 11:54:17 +0800 (CST)
Message-ID: <42dfc5f6-8574-4dbd-b067-b1a4e40ffe91@huaweicloud.com>
Date: Sat, 7 Jun 2025 11:54:16 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] ext4: restart handle if credits are insufficient
 during writepages
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 ojaswin@linux.ibm.com, yi.zhang@huawei.com, libaokun1@huawei.com,
 yukuai3@huawei.com, yangerkun@huawei.com
References: <20250530062858.458039-1-yi.zhang@huaweicloud.com>
 <20250530062858.458039-2-yi.zhang@huaweicloud.com>
 <byiax3ykefdvmu47xrgrndguxabwvakescnkanbhwwqoec7yky@dvzzkic5uzf3>
 <3aafd643-3655-420e-93fa-25d0d0ff4f32@huaweicloud.com>
 <uruplwi35qaajr3cqyozq7dpbwgqehuzstxpobx44retpek6cb@gplmkhlsaofk>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <uruplwi35qaajr3cqyozq7dpbwgqehuzstxpobx44retpek6cb@gplmkhlsaofk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBXvGDot0No5YoBOw--.1118S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWrWUJFW3AF1kXr1rXrWrXwb_yoWrKF4rpF
	ZF93Z8GF4kXa4Yvr12qa1UArnay345Ar43Ja13KFW3ZFn8u3Z7KF1ftayY9ayUur4xXa4I
	vr4jkr97GFy5ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/6/6 21:16, Jan Kara wrote:
> On Fri 06-06-25 14:54:21, Zhang Yi wrote:
>> On 2025/6/5 22:04, Jan Kara wrote:
>>>> +		/*
>>>> +		 * The credits for the current handle and transaction have
>>>> +		 * reached their upper limit, stop the handle and initiate a
>>>> +		 * new transaction. Note that some blocks in this folio may
>>>> +		 * have been allocated, and these allocated extents are
>>>> +		 * submitted through the current transaction, but the folio
>>>> +		 * itself is not submitted. To prevent stale data and
>>>> +		 * potential deadlock in ordered mode, only the
>>>> +		 * dioread_nolock mode supports this.
>>>> +		 */
>>>> +		if (err > 0) {
>>>> +			WARN_ON_ONCE(!ext4_should_dioread_nolock(inode));
>>>> +			mpd->continue_map = 1;
>>>> +			err = 0;
>>>> +			goto update_disksize;
>>>> +		}
>>>>  	} while (map->m_len);
>>>>  
>>>>  update_disksize:
>>>> @@ -2467,6 +2501,9 @@ static int mpage_map_and_submit_extent(handle_t *handle,
>>>>  		if (!err)
>>>>  			err = err2;
>>>>  	}
>>>> +	if (!err && mpd->continue_map)
>>>> +		ext4_get_io_end(io_end);
>>>> +
>>>
>>> IMHO it would be more logical to not call ext4_put_io_end[_deferred]() in
>>> ext4_do_writepages() if we see we need to continue doing mapping for the
>>> current io_end.
>>>
>>> That way it would be also more obvious that you've just reintroduced
>>> deadlock fixed by 646caa9c8e196 ("ext4: fix deadlock during page
>>> writeback"). This is actually a fundamental thing because for
>>> ext4_journal_stop() to complete, we may need IO on the folio to finish
>>> which means we need io_end to be processed. Even if we avoided the awkward
>>> case with sync handle described in 646caa9c8e196, to be able to start a new
>>> handle we may need to complete a previous transaction commit to be able to
>>> make space in the journal.
>>
>> Yeah, you are right, I missed the full folios that were attached to the
>> same io_end in the previous rounds. If we continue to use this solution,
>> I think we should split the io_end and submit the previous one which
>> includes those full folios before the previous transaction is
>> committed.
> 
> Yes, fully mapped folios definitely need to be submitted. But I think that
> should be handled by ext4_io_submit() call in ext4_do_writepages() loop?

Sorry, my previous description may not have been clear enough. The
deadlock issue in this solution should be:

1. In the latest round of ext4_do_writepages(),
   mpage_prepare_extent_to_map() may add some contiguous fully mapped
   folios and an unmapped folio(A) to the current processing io_end.
2. mpage_map_and_submit_extent() mapped some bhs in folio A and bail out
   due to the insufficient journal credits, it acquires one more
   refcount of io_end to prevent ext4_put_io_end() convert the extent
   written status of the newly allcoated extents, since we don't submit
   this partial folio now.
3. ext4_io_submit() in ext4_do_writepages() submits the fully mapped
   folios, but the endio process cannot be invoked properly since the
   above extra refcount, so the writeback state of the folio cannot be
   cleared.
4. Finally, it stops the current handle and waits for the transaction to
   be committed. However, the commit process also waits for those fully
   mapped folios to complete, which can lead to a deadlock.

Therefore, if the io_end contains both fully mapped folios and a partial
folio, we need to split the io_end, the first one contains those mapped
folios, and the second one only contain the partial folio. We only hold
the refcount of the second io_end, the first one can be finished properly,
this can break the deadlock.

However, the solution of submitting the partial folio sounds more simple
to me.

[..]

>>> Then once IO completes
>>> mpage_prepare_extent_to_map() is able to start working on the folio again.
>>> Since we cleared dirty bits in the buffers we should not be repeating the
>>> work we already did...
>>>
>>
>> Hmm, it looks like this solution should work. We should introduce a
>> partial folio version of mpage_submit_folio(), call it and redirty
>> the folio once we need to bail out of the loop since insufficient
>> space or journal credits. But ext4_bio_write_folio() will handle the
>> the logic of fscrypt case, I'm not familiar with fscrypt, so I'm not
>> sure it could handle the partial page properly. I'll give it a try.
> 
> As far as I can tell it should work fine. The logic in
> ext4_bio_write_folio() is already prepared for handling partial folio
> writeouts, redirtying of the page etc. (because it needs to handle writeout
> from transaction commit where we can writeout only parts of folios with
> underlying blocks allocated). We just need to teach mpage_submit_folio() to
> substract only written-out number of pages from nr_to_write.
> 

Yes, indeed. I will try this solution.

Thanks,
Yi.





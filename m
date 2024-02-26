Return-Path: <linux-fsdevel+bounces-12791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE538673DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 12:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 959C51C2854D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 11:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924B11EB27;
	Mon, 26 Feb 2024 11:50:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83CB1F604;
	Mon, 26 Feb 2024 11:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708948231; cv=none; b=ZKupTAgvjg68pTwP2tsz/zKVpl0bIyNz2FFW7AVvEHNg11PnLSUrTN3TR1/WepvTPZ9x5O5REwdXqQ5iu1DN/BcUS7Se9+WuYg4iYrk86IfP34UxyFeaA1odhquyPd58qPPfE+pwnbDjOH0RrakYuC4DE/M9s4hDlirqbLxzg5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708948231; c=relaxed/simple;
	bh=o2zP6qkBFJWPP/SsY/iJWKDrUYVt/AOBRXL4yt1J6yQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=WBavtv93b1jtIgb41XmiUuR/JkSz7htHpsaU3xN2UsM6FLuSrdqGeJi20iS3CrVMkfuf8NcAHbmsc59Wb7oTsOWX4+aXSesfQqweXQY7piYR9ylt/sPJOKqLIxLnn+Cc4Ncz2/tQRbjwPCI+4M+HJW4nYDDmHbVum+kOyBQ65Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TjzSn5ZSJz4f3lVm;
	Mon, 26 Feb 2024 19:50:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 138A11A0283;
	Mon, 26 Feb 2024 19:50:25 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP4 (Coremail) with SMTP id gCh0CgCHjG4Ae9xl5k8nFQ--.25370S2;
	Mon, 26 Feb 2024 19:50:25 +0800 (CST)
Subject: Re: [PATCH 5/7] fs/writeback: only calculate dirtied_before when b_io
 is empty
To: Jan Kara <jack@suse.cz>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240208172024.23625-1-shikemeng@huaweicloud.com>
 <20240208172024.23625-6-shikemeng@huaweicloud.com>
 <20240223135809.5bvyl7ex3zm6bnta@quack3>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <115755e5-9c4f-8aea-1bc0-41868926c527@huaweicloud.com>
Date: Mon, 26 Feb 2024 19:50:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240223135809.5bvyl7ex3zm6bnta@quack3>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCHjG4Ae9xl5k8nFQ--.25370S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrWrJw1kWFyfZFykZw1rXrb_yoW8Cry8pF
	93t3WfKr4jyw1IgrnrC3W7XF45Ww4xKF4UAw1xXFyrZrnxZF10gFyvq348Kw1kAw1xZryI
	vw4DJFWxC34jyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UWHqcUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 2/23/2024 9:58 PM, Jan Kara wrote:
> On Fri 09-02-24 01:20:22, Kemeng Shi wrote:
>> The dirtied_before is only used when b_io is not empty, so only calculate
>> when b_io is not empty.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>  fs/fs-writeback.c | 25 +++++++++++++------------
>>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> OK, but please wrap the comment at 80 columns as well.
Sorry for missing this as I rely too much on checkpatch.pl to report this
while the script didn't catch it. Will fix it in next version. Thanks for
review.
> 
> 								Honza
> 
>>
>> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
>> index b61bf2075931..e8868e814e0a 100644
>> --- a/fs/fs-writeback.c
>> +++ b/fs/fs-writeback.c
>> @@ -2118,20 +2118,21 @@ static long wb_writeback(struct bdi_writeback *wb,
>>  
>>  		spin_lock(&wb->list_lock);
>>  
>> -		/*
>> -		 * Kupdate and background works are special and we want to
>> -		 * include all inodes that need writing. Livelock avoidance is
>> -		 * handled by these works yielding to any other work so we are
>> -		 * safe.
>> -		 */
>> -		if (work->for_kupdate) {
>> -			dirtied_before = jiffies -
>> -				msecs_to_jiffies(dirty_expire_interval * 10);
>> -		} else if (work->for_background)
>> -			dirtied_before = jiffies;
>> -
>>  		trace_writeback_start(wb, work);
>>  		if (list_empty(&wb->b_io)) {
>> +			/*
>> +			 * Kupdate and background works are special and we want to
>> +			 * include all inodes that need writing. Livelock avoidance is
>> +			 * handled by these works yielding to any other work so we are
>> +			 * safe.
>> +			 */
>> +			if (work->for_kupdate) {
>> +				dirtied_before = jiffies -
>> +					msecs_to_jiffies(dirty_expire_interval *
>> +							 10);
>> +			} else if (work->for_background)
>> +				dirtied_before = jiffies;
>> +
>>  			queue_io(wb, work, dirtied_before);
>>  			queued = true;
>>  		}
>> -- 
>> 2.30.0
>>



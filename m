Return-Path: <linux-fsdevel+bounces-11938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CA3859425
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 03:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2D001F21CB3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 02:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B7B1848;
	Sun, 18 Feb 2024 02:37:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6A215C0;
	Sun, 18 Feb 2024 02:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708223861; cv=none; b=U9n7vjzhcVjQ23JcbftaQ12+jAEcbdCFziFaZqxXS6Jsv7IGBaA2clhu+yTsNypSZY4bYGGjFbFZC8BubiRe69cpDjTN5UeAfcCa5mc8hASDWof9eoDW/OQ34EqcoYFPC3mhzNi567+l6AmUutk9A7DF1fGbkYYPRvdjcHFS0jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708223861; c=relaxed/simple;
	bh=Ztap6kAvAVxgusqy5ttg8iaVD2qgr9e3SAAduCApCYU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=AMaBs0XFXBIKkXDXdQPsdYr+tHvt7oHJmK+Y3ojB6Zd+TBe3Yr+NKBtbxPuyykMIoLZe/QwQ5Dky8e+hrNUPBCreqrsl/3v4HD1zpY2HEbu1bQUv3gPwJ4gnH3JncVT8JDC2MO6BXEsIOIMz4tZnU3T9SAnaGJ2TfTZBrPv7rdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TcqZf0WkYz4f3lVs;
	Sun, 18 Feb 2024 10:37:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 179D71A0232;
	Sun, 18 Feb 2024 10:37:37 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP3 (Coremail) with SMTP id _Ch0CgBXZJxwbdFlePYeEQ--.23861S2;
	Sun, 18 Feb 2024 10:37:36 +0800 (CST)
Subject: Re: [PATCH 4/7] fs/writeback: remove unneeded check in
 writeback_single_inode
To: Dave Chinner <david@fromorbit.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240208172024.23625-1-shikemeng@huaweicloud.com>
 <20240208172024.23625-5-shikemeng@huaweicloud.com>
 <ZcbHTYLSO7mU0e9G@dread.disaster.area>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <3e3710d2-a716-ab9f-8c67-9771c4c27b5c@huaweicloud.com>
Date: Sun, 18 Feb 2024 10:37:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZcbHTYLSO7mU0e9G@dread.disaster.area>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgBXZJxwbdFlePYeEQ--.23861S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF15Kw1rCry3KF4DGryrCrg_yoW8GFWDpF
	yxtFy8Kr4SqF9xCF1IyF4aq34jg3yUXr43Cr13Zw4UK3sxJ34xtF90934rZFn8AanxG3yF
	vr4DCr95Awn3uaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL05UUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 2/10/2024 8:46 AM, Dave Chinner wrote:
> On Fri, Feb 09, 2024 at 01:20:21AM +0800, Kemeng Shi wrote:
>> I_DIRTY_ALL consists of I_DIRTY_TIME and I_DIRTY, so I_DIRTY_TIME must
>> be set when any bit of I_DIRTY_ALL is set but I_DIRTY is not set.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>  fs/fs-writeback.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
>> index 2619f74ced70..b61bf2075931 100644
>> --- a/fs/fs-writeback.c
>> +++ b/fs/fs-writeback.c
>> @@ -1788,7 +1788,7 @@ static int writeback_single_inode(struct inode *inode,
>>  		else if (!(inode->i_state & I_SYNC_QUEUED)) {
>>  			if ((inode->i_state & I_DIRTY))
>>  				redirty_tail_locked(inode, wb);
>> -			else if (inode->i_state & I_DIRTY_TIME) {
>> +			else {
>>  				inode->dirtied_when = jiffies;
>>  				inode_io_list_move_locked(inode,
>>  							  wb,
> 
> NAK.
> 
> The code is correct and the behaviour that is intended it obvious
> from the code as it stands.
> 
> It is -incorrect- to move any inode that does not have I_DIRTY_TIME
> to the wb->b_dirty_time list. By removing the I_DIRTY_TIME guard
> from this code, you are leaving a nasty, undocumented logic trap in
> the code that somebody is guaranteed to trip over into in the
> future. That's making the code worse, not better....
Sure, I will remove this one in next version. Thanks for the
explanation.
> 
> -Dave.
> 



Return-Path: <linux-fsdevel+bounces-11933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 581D68593EE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 03:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4E0DB21637
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 02:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1E615C0;
	Sun, 18 Feb 2024 02:02:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8ABA29;
	Sun, 18 Feb 2024 02:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708221730; cv=none; b=nlxInXPoU1a60lAGTyX2gChz7yMbACfRtrEhGsfB6f2wyVmmJrPt+zMj6G2p0ojVs1t7bXy5P/IKd2EAZIRGZcv0RJRTracJ6Ca4CRg6fv90dExLqGEharOUFXjhIdpkxaEYnWWuWvMlECV/5pXdNDYNrFmeyivoDSDq14c7CIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708221730; c=relaxed/simple;
	bh=4lXEcH1qeiznkTANiY2C31x6lg4OWCCcZv+EalwqFCs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nVy+X0PaYOLTZKmWikyLHKL6lNCcTYH0SI+qnV8OGBPlVIjfHBvjxPbrQ+fRlDhnaEkk/oc6q9mv9GeKgc3IqbMAIW3gzb6AohLtT73fepHDQxoQRa6T/0VoNwppWB0VvXVW15TGMk2h4tvyIAqOW8j4HIuV92ZT/oC28+0v1yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Tcpng0SkYz4f3jrp;
	Sun, 18 Feb 2024 10:01:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E1D311A0175;
	Sun, 18 Feb 2024 10:02:03 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP1 (Coremail) with SMTP id cCh0CgC3iBEGZdFluRRoEQ--.27970S2;
	Sun, 18 Feb 2024 10:01:58 +0800 (CST)
Subject: Re: [PATCH 1/7] fs/writeback: avoid to writeback non-expired inode in
 kupdate writeback
To: Tim Chen <tim.c.chen@linux.intel.com>, viro@zeniv.linux.org.uk,
 brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240208172024.23625-1-shikemeng@huaweicloud.com>
 <20240208172024.23625-2-shikemeng@huaweicloud.com>
 <ba75294dfb5bf4dd046d54de6c3e57698592dacc.camel@linux.intel.com>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <4364e9bc-2d29-120d-4837-7f5620585508@huaweicloud.com>
Date: Sun, 18 Feb 2024 10:01:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ba75294dfb5bf4dd046d54de6c3e57698592dacc.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgC3iBEGZdFluRRoEQ--.27970S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFyruryDtw4DZrW8GF4UJwb_yoW8XFyfpF
	WrKFyUtF48Za40gr4vy3W7ZrsIqF48Gr13J3WjkF17tas8ZFnagFy8WrWfG3W0yr4aqwsY
	va18J347Cw4UKaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 2/9/2024 2:29 AM, Tim Chen wrote:
> On Fri, 2024-02-09 at 01:20 +0800, Kemeng Shi wrote:
>>
>>  
>> +static void filter_expired_io(struct bdi_writeback *wb)
>> +{
>> +	struct inode *inode, *tmp;
>> +	unsigned long expired_jiffies = jiffies -
>> +		msecs_to_jiffies(dirty_expire_interval * 10);
> 
> We have kupdate trigger time hard coded with a factor of 10 to expire interval here.
> The kupdate trigger time "mssecs_to_jiffies(dirty_expire_interval * 10)" is
> also used in wb_writeback().  It will be better to have a macro or #define
> to encapsulate the trigger time so if for any reason we need
> to tune the trigger time, we just need to change it at one place.
Hi Tim. Sorry for the late reply, I was on vacation these days.
I agree it's better to have a macro and I will add it in next version.
Thanks!
> 
> Tim
> 
>> +
>> +	spin_lock(&wb->list_lock);
>> +	list_for_each_entry_safe(inode, tmp, &wb->b_io, i_io_list)
>> +		if (inode_dirtied_after(inode, expired_jiffies))
>> +			redirty_tail(inode, wb);
>> +
>> +	list_for_each_entry_safe(inode, tmp, &wb->b_more_io, i_io_list)
>> +		if (inode_dirtied_after(inode, expired_jiffies))
>> +			redirty_tail(inode, wb);
>> +	spin_unlock(&wb->list_lock);
>> +}
>> +
>>  /*
>>   * Explicit flushing or periodic writeback of "old" data.
>>   *
>> @@ -2070,6 +2087,9 @@ static long wb_writeback(struct bdi_writeback *wb,
>>  	long progress;
>>  	struct blk_plug plug;
>>  
>> +	if (work->for_kupdate)
>> +		filter_expired_io(wb);
>> +
>>  	blk_start_plug(&plug);
>>  	for (;;) {
>>  		/*
> 



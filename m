Return-Path: <linux-fsdevel+bounces-20788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 390EF8D7BCB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 08:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD5701F2256D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 06:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF43D8061B;
	Mon,  3 Jun 2024 06:40:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92F17F7EF;
	Mon,  3 Jun 2024 06:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717396803; cv=none; b=T5Mbu2UCxFpBHbI2S4dNi9/GPZvl1ERb2ZiUfcs4Jsz0aoUI0MClqx1SPK0lnu6n4aLOJxdh0NDyGhZZK9tPmHEdz2ALzWJbSmOZ5bJVE6Vf1nQv2BtcbR5y34TwbVzT8v9DrOVhJWkfM7XAv6x2WtfXuegSiakOFpoXATyxp0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717396803; c=relaxed/simple;
	bh=lets7R8QabYAyvZ/BA5K2o0vh78I6YznD7kMrzkB61s=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VlG1MVP24LrkCGn7rilBQeD6N6QSadJ2VXIlYD2FVx1WG0E9UqvZziaNHXr6HGMY4MnNMrlVhs2gZrjuRT3miTJqF4Z4syTP1w1gKw1QUJ3ffEVFDZtFh/ZHFPOoJx0ZjpfLvrKrZInjQO0FHB3cDubNbOizJblcIhw6U5/i4Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Vt3xH0P3hz4f3jrn;
	Mon,  3 Jun 2024 14:39:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 9AACF1A0189;
	Mon,  3 Jun 2024 14:39:56 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP1 (Coremail) with SMTP id cCh0CgAnQAk8ZV1mZHu+OQ--.43911S2;
	Mon, 03 Jun 2024 14:39:56 +0800 (CST)
Subject: Re: [PATCH v2 8/8] writeback: factor out balance_wb_limits to remove
 repeated code
To: Tejun Heo <tj@kernel.org>
Cc: willy@infradead.org, akpm@linux-foundation.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240514125254.142203-1-shikemeng@huaweicloud.com>
 <20240514125254.142203-9-shikemeng@huaweicloud.com>
 <ZljGiunxmVAlW6EE@slm.duckdns.org>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <cfbbcc80-7db1-8277-98ab-1f32c3a629ab@huaweicloud.com>
Date: Mon, 3 Jun 2024 14:39:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZljGiunxmVAlW6EE@slm.duckdns.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgAnQAk8ZV1mZHu+OQ--.43911S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ArWDJr1UtFy7KrW3AryfCrg_yoW8Jw1fpr
	WIyanFyF4DtF4Ig3ZxCayxZr9IqrsxZry3JryrJrs3tr1a9rn7KF9xZrWruFy7Cr1DGa15
	Zr4DKas7Gws5CFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL05UUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/


Hello,
on 5/31/2024 2:33 AM, Tejun Heo wrote:
> Hello,
> 
> On Tue, May 14, 2024 at 08:52:54PM +0800, Kemeng Shi wrote:
>> +static void balance_wb_limits(struct dirty_throttle_control *dtc,
>> +			      bool strictlimit)
>> +{
>> +	wb_dirty_freerun(dtc, strictlimit);
>> +	if (dtc->freerun)
>> +		return;
>> +
>> +	wb_dirty_exceeded(dtc, strictlimit);
>> +	wb_position_ratio(dtc);
>> +}
> ...
>> @@ -1869,12 +1880,9 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
>>  		 * Calculate global domain's pos_ratio and select the
>>  		 * global dtc by default.
>>  		 */
>> -		wb_dirty_freerun(gdtc, strictlimit);
>> +		balance_wb_limits(gdtc, strictlimit);
>>  		if (gdtc->freerun)
>>  			goto free_running;
>> -
>> -		wb_dirty_exceeded(gdtc, strictlimit);
>> -		wb_position_ratio(gdtc);
>>  		sdtc = gdtc;
> 
> Isn't this a bit nasty? The helper skips updating states because it knows
> the caller is not going to use them? I'm not sure the slight code reduction
> justifies the added subtlety.

It's a general rule that wb should not be limited if the wb is in freerun state.
So I think it's intuitive to obey the rule in both balance_wb_limits and it's
caller in which case balance_wb_limits and it's caller should stop to do anything
when freerun state of wb is first seen.
But no insistant on this...

Thanks.
> 
> Thanks.
> 



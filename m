Return-Path: <linux-fsdevel+bounces-18783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCA78BC577
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 03:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E3C3B21629
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 01:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBF53D387;
	Mon,  6 May 2024 01:32:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0557D2FB6;
	Mon,  6 May 2024 01:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714959168; cv=none; b=Yx2tXpAt8LyZKpRLza1YKodoMwUk9aBR6iUpjadV8IpjCXh0XFhT3rv1GFOcyhIRp3jPUtJwZQsvnsutHsBU0KNodjczliqNWjqb9g/4D+QsC896tR1RoNE3kRVmD/W3TPooBpJQpMeiIbM5ZzlcFlLaB5NqPG9TdZGAhnXvEdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714959168; c=relaxed/simple;
	bh=92joqj7g1Iv2mcTw28wf2tJKoXH6csvg7Rci/E/IKr8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ICU8JI1FiJm6u5eb7hmQmD7tQw3SPFrghHqEc/KSqOCSrMdxRiQ1l6wjawl71HXvrHwoIF2i9vCsC9jSt37ZjxwAt5AZ0DcypqUKCE/+cepgPZCS/Rzb/Z0zxppJrIQ3FEd2oIKwVYMrbnFzT8I2rN4Cvd5XVVz3UxXfeNK3Vic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VXkRh3VHxz4f3jLJ;
	Mon,  6 May 2024 09:32:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3B5D41A0179;
	Mon,  6 May 2024 09:32:42 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP4 (Coremail) with SMTP id gCh0CgB3fG45MzhmoWpmMA--.42545S2;
	Mon, 06 May 2024 09:32:42 +0800 (CST)
Subject: Re: [PATCH 02/10] writeback: add general function domain_dirty_avail
 to calculate dirty and avail of domain
To: Tejun Heo <tj@kernel.org>
Cc: willy@infradead.org, akpm@linux-foundation.org, jack@suse.cz,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240429034738.138609-1-shikemeng@huaweicloud.com>
 <20240429034738.138609-3-shikemeng@huaweicloud.com>
 <ZjJysTZO6IOpe4BT@slm.duckdns.org>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <d69093d9-0786-b16f-1ed9-7cc5e37791d9@huaweicloud.com>
Date: Mon, 6 May 2024 09:32:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZjJysTZO6IOpe4BT@slm.duckdns.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgB3fG45MzhmoWpmMA--.42545S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr4xXw13JFyUXrWUXF43ZFb_yoW8JF4kpF
	4UtanI9FWkta9rXr1fWr48W3yav3yfWFW5t34vk3sFvr4xuF4DGr93u34rCw1S9r4kJwna
	kFsrXw4FvF48CFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOyCJDUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 5/2/2024 12:49 AM, Tejun Heo wrote:
> Hello,
> 
> On Mon, Apr 29, 2024 at 11:47:30AM +0800, Kemeng Shi wrote:
>> +/*
>> + * Dirty background will ignore pages being written as we're trying to
>> + * decide whether to put more under writeback.
>> + */
>> +static void domain_dirty_avail(struct dirty_throttle_control *dtc, bool bg)
> 
> I wonder whether it'd be better if the bool arg is flipped to something like
> `bool include_writeback` so that it's clear what the difference is between
Sure, I rename 'bool bg' to 'bool include_writeback'.
> the two. Also, do global_domain_dirty_avail() and wb_domain_dirty_avail()
> have to be separate functions? They seem trivial enough to include into the
> body of domain_dirty_avail(). Are they used directly elsewhere?
I will fold global_domain_dirty_avail() and wb_domain_dirty_avail() and
just use domain_dirty_avail.
> 
>> +{
>> +	struct dirty_throttle_control *gdtc = mdtc_gdtc(dtc);
>> +
>> +	if (gdtc)
> 
> I know this test is used elsewhere but it isn't the most intuitive. Would it
> make sense to add dtc_is_global() (or dtc_is_gdtc()) helper instead?
Will add helper dtc_is_global().

Thanks.
Kemeng
> 
>> +		wb_domain_dirty_avail(dtc, bg);
>> +	else
>> +		global_domain_dirty_avail(dtc, bg);
>> +}
> 
> Thanks.
> 



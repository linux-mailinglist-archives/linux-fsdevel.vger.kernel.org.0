Return-Path: <linux-fsdevel+bounces-15330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D1E88C355
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 14:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5604F1C2BA4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 13:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6E874BF5;
	Tue, 26 Mar 2024 13:26:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4BD6D1CE;
	Tue, 26 Mar 2024 13:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711459610; cv=none; b=k4rMgQ6S+2lVqRr1qkJvyXjouNFLwrAvckywaGeR6DZ7tjDOdGuNEwwJBIP4NzBnHakxQbf5nTsBWwuC+EYMYdDwdVUA1UJEUVGBHST26MppSnTmFiAvWOILyzIKi269clHKAn/oJWxhwS+lh332XOCiERTs0WOHJr/9ZKXaBSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711459610; c=relaxed/simple;
	bh=e4cTCvKLicPrP/BBzqMrTnQ/mc0bQqdRpDQFbZlR8hw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Jx+hrZ8NF/nIKDknqbTOsscu9/q1mAR8NjQYWJfQ1860A1Dkt7boeLbXUGfvN9x/st4aOxCQxmae5I2/IGF1jd++Q51fYhI7kuU3+b1MFSEYfUDXI5Ej19qZz7UYs/Ss0Ao2aTy99ePBsBFuiPV2AiNBrHRsotsUn7RLcENypL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V3rDX08KNz4f3m78;
	Tue, 26 Mar 2024 21:26:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 1DA2B1A06D7;
	Tue, 26 Mar 2024 21:26:44 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP3 (Coremail) with SMTP id _Ch0CgA3RJwSzQJmvaESIA--.44448S2;
	Tue, 26 Mar 2024 21:26:43 +0800 (CST)
Subject: Re: [PATCH 2/6] writeback: support retrieving per group debug
 writeback stats of bdi
To: Jan Kara <jack@suse.cz>
Cc: akpm@linux-foundation.org, tj@kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 willy@infradead.org, bfoster@redhat.com, dsterba@suse.com,
 mjguzik@gmail.com, dhowells@redhat.com, peterz@infradead.org
References: <20240320110222.6564-1-shikemeng@huaweicloud.com>
 <20240320110222.6564-3-shikemeng@huaweicloud.com>
 <20240326122421.dofl35cdtgaojt26@quack3>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <206c3800-01ec-2d3b-fe89-cbb1b36158a3@huaweicloud.com>
Date: Tue, 26 Mar 2024 21:26:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240326122421.dofl35cdtgaojt26@quack3>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgA3RJwSzQJmvaESIA--.44448S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF1ftFW3Zr45CFWfXr1xuFg_yoW8GF4xpF
	WkAayYkF4jyrWqkr47Za4q9FW7t3y8GrW2q3yfGay3Xrn29rySgFyfur97uF1fCFyfGry5
	AFsIvr97W3WkCrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UGYL9UUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 3/26/2024 8:24 PM, Jan Kara wrote:
> On Wed 20-03-24 19:02:18, Kemeng Shi wrote:
>> Add /sys/kernel/debug/bdi/xxx/wb_stats to show per group writeback stats
>> of bdi.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> 
> ...
> 
>> +unsigned long wb_calc_cg_thresh(struct bdi_writeback *wb)
>> +{
>> +	struct dirty_throttle_control gdtc = { GDTC_INIT_NO_WB };
>> +	struct dirty_throttle_control mdtc = { MDTC_INIT(wb, &gdtc) };
>> +	unsigned long filepages, headroom, writeback;
>> +
>> +	gdtc.avail = global_dirtyable_memory();
>> +	gdtc.dirty = global_node_page_state(NR_FILE_DIRTY) +
>> +		     global_node_page_state(NR_WRITEBACK);
>> +
>> +	mem_cgroup_wb_stats(wb, &filepages, &headroom,
>> +			    &mdtc.dirty, &writeback);
>> +	mdtc.dirty += writeback;
>> +	mdtc_calc_avail(&mdtc, filepages, headroom);
>> +	domain_dirty_limits(&mdtc);
>> +
>> +	return __wb_calc_thresh(&mdtc, mdtc.thresh);
>> +}
> 
> I kind of wish we didn't replicate this logic from balance_dirty_pages()
> and wb_over_bg_thresh() into yet another place. But the refactoring would
> be kind of difficult. So OK.
Thanks for review the code.
I have considered about this. It's difficult and will introduce a lot
change to non-debug code which make this series uneasy to review.
I will submit another patch for refactoring if I could find a way to
clean the code.

Kemeng
> 
> 								Honza
> 



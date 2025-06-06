Return-Path: <linux-fsdevel+bounces-50799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2198ACFB41
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 04:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F85A171CF6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 02:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E80C1DDC33;
	Fri,  6 Jun 2025 02:29:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF07817548;
	Fri,  6 Jun 2025 02:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749176983; cv=none; b=HheCeq1ewQAchxPYOkBVsNsRuF+VBZiu5LAot3/LV1CNNLI3NIKxzYU8q9S7Ia5g3rNaBBalVufDZ4pm2n1M0OXxsPxbxmCvkZZ5pz1drmXAOhrgi4Wl+6dCw15cGeotJjaEKAqnM6CbEhMXw11tn+qCXUQEw90+aOtatYMHyAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749176983; c=relaxed/simple;
	bh=Vf3HhJvqoimMQTMohZTvE2A3QG8yH+pWFF0c7UUl3Qw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=XrBAKYtB0WMLdXZv2wnQ+zv1/zkWMkZaeO9Tx/84iQgxaWhsuBQR5H1hY+pHo7LnOJJLT/+X4rQ7uphtPFwP9PPAQbmpjBlpuWWSnOaCqWFCT4mCbt/T4VJgQsWBWCajKpJAHsimpsnnD1XGg/Cin+bTJZtNMCSCVfXC/bwpcAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bD4yq2SfVzYQvbb;
	Fri,  6 Jun 2025 10:29:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 611DF1A018D;
	Fri,  6 Jun 2025 10:29:38 +0800 (CST)
Received: from [10.174.99.169] (unknown [10.174.99.169])
	by APP2 (Coremail) with SMTP id Syh0CgAnMGOQUkJo1_4aOg--.17761S2;
	Fri, 06 Jun 2025 10:29:38 +0800 (CST)
Subject: Re: [PATCH 1/7] mm: shmem: correctly pass alloced parameter to
 shmem_recalc_inode() to avoid WARN_ON()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: hughd@google.com, baolin.wang@linux.alibaba.com, willy@infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20250605221037.7872-1-shikemeng@huaweicloud.com>
 <20250605221037.7872-2-shikemeng@huaweicloud.com>
 <20250605125724.d2e3db9c23af7627a53d8914@linux-foundation.org>
 <721923ac-4bb1-1b2b-fce5-9d957c535c97@huaweicloud.com>
 <20250605182802.ec8d869bc02583cbc9de9648@linux-foundation.org>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <ceba6bf2-e4cb-492f-ee28-f9808f617ec0@huaweicloud.com>
Date: Fri, 6 Jun 2025 10:29:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250605182802.ec8d869bc02583cbc9de9648@linux-foundation.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAnMGOQUkJo1_4aOg--.17761S2
X-Coremail-Antispam: 1UD129KBjvJXoWruw45Jr17GrWUKr45ur18AFb_yoW8JF1rpr
	WUua45Arn3Wryxtr1Ivwn7Wr1S9FZ7GFWUt3W5Ww13Kas8X3sFyF4kArW5u3W5CrykXw4a
	vFsruF9rXFW7ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwx
	hLUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 6/6/2025 9:28 AM, Andrew Morton wrote:
> On Fri, 6 Jun 2025 09:11:37 +0800 Kemeng Shi <shikemeng@huaweicloud.com> wrote:
> 
>>>> --- a/mm/shmem.c
>>>> +++ b/mm/shmem.c
>>>> @@ -2145,7 +2145,7 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
>>>>  	 * won't be 0 when inode is released and thus trigger WARN_ON(i_blocks)
>>>>  	 * in shmem_evict_inode().
>>>>  	 */
>>>> -	shmem_recalc_inode(inode, -nr_pages, -nr_pages);
>>>> +	shmem_recalc_inode(inode, 0, -nr_pages);
>>>>  	swap_free_nr(swap, nr_pages);
>>>>  }
>>>
>>> Huh, three years ago.  What do we think might be the userspace-visible
>>> runtime effects of this?
>> This could trigger WARN_ON(i_blocks) in shmem_evict_inode() as i_blocks
>> is supposed to be dropped in the quota free routine.
> 
> I don't believe we've seen such a report in those three years so perhaps
> no need to backport.  But it's a one-liner so let's backport ;) And
> possibly [2/7] and [3/7] should receive the same treatment.
> 
> I don't think any of these need to be fast-tracked into mm-hotfixes so
> please resend after a suitable review period and include the cc:stable
> on those which -stable needs.
> 
Sure, all issues are hard to trigger. I will resend this series later.
Thanks!



Return-Path: <linux-fsdevel+bounces-11937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C66859422
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 03:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06C7B1F21CFD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 02:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6688F4C9B;
	Sun, 18 Feb 2024 02:35:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472DF4C7C;
	Sun, 18 Feb 2024 02:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708223748; cv=none; b=gGTg9uhofP+4sTBFP11jkf0fgvVceudyAWbuzrNtDJlcyvbhcSP7sALyOJz6oCNwYNOVejrE52BsRLaflLS1mdvfrORcVkNaVA2DAtfvatvmjKZ2oLXKJl5nErMhRxGl4KgoyLWjbhjHorWwpOGwGyG5X5oRVZQwmcGk+hqf7iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708223748; c=relaxed/simple;
	bh=U9L4aGV0D3MMY9Yq/mo/vjMg+jG6LRUFi/24wI3N6OE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DS9mEZHQHTiGn8lXVNOnw+DBNVFCwW6+ALxaDE4xHwTaIB0iZqwqllB0K2YNtMWvambQ74gaOvKqHyIRdWjOfrYiF+MrRxfKWbHmkvlAB2Qvk8thwb6G1aeFXenTw3cliqzFj8wHyhLHbqMil8MQe/DPuLEqCyUe+Cy9Js050GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TcqXW6kwGz4f3k5n;
	Sun, 18 Feb 2024 10:35:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 06AAD1A0DB7;
	Sun, 18 Feb 2024 10:35:43 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP2 (Coremail) with SMTP id Syh0CgC32Qz9bNFlLhW5EQ--.38137S2;
	Sun, 18 Feb 2024 10:35:42 +0800 (CST)
Subject: Re: [PATCH 2/5] mm: correct calculation of cgroup wb's bg_thresh in
 wb_over_bg_thresh
To: Tejun Heo <tj@kernel.org>
Cc: willy@infradead.org, akpm@linux-foundation.org,
 hcochran@kernelspring.com, mszeredi@redhat.com, axboe@kernel.dk,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240123183332.876854-1-shikemeng@huaweicloud.com>
 <20240123183332.876854-3-shikemeng@huaweicloud.com>
 <ZbAk8HfnzHoSSFWC@slm.duckdns.org>
 <a747dc7d-f24a-08bd-d969-d3fb35e151b7@huaweicloud.com>
 <ZbgR5-yOn7f5MtcD@slm.duckdns.org>
 <ad794d74-5f58-2fed-5a04-2c50c8594723@huaweicloud.com>
 <ZcUsOb_fyvYr-zZ-@slm.duckdns.org>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <6505a0c5-5e22-3b25-65f5-2b44e885785d@huaweicloud.com>
Date: Sun, 18 Feb 2024 10:35:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZcUsOb_fyvYr-zZ-@slm.duckdns.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgC32Qz9bNFlLhW5EQ--.38137S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF17Zryftr1kJFW5ZFWDArb_yoW8XF43pF
	sxJwsxJrWkAF1jyw17Zwnavryavwn5X343J348K39rAw4DGF97tryfW3yY93W7XrZ3CFWj
	qr4DZFWkCF4UZa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 2/9/2024 3:32 AM, Tejun Heo wrote:
> Hello, Kemeng.
> 
> On Thu, Feb 08, 2024 at 05:26:10PM +0800, Kemeng Shi wrote:
>> Hi Tejun, sorry for the delay as I found there is a issue that keep triggering
>> writeback even the dirty page is under dirty background threshold. The issue
>> make it difficult to observe the expected improvment from this patch. I try to
>> fix it in [1] and test this patch based on the fix patches.
>> Run test as following:
> 
> Ah, that looks promising and thanks a lot for looking into this. It's great
> to have someone actually poring over the code and behavior. Understanding
> the wb and cgroup wb behaviors have always been challenging because the only
> thing we have is the tracepoints and it's really tedious and difficult to
> build an overall understanding from the trace outputs. Can I persuade you
> into writing a drgn monitoring script similar to e.g.
> tools/workqueues/wq_monitor.py? I think there's a pretty good chance the
> visibility can be improved substantially.
Hi Tejun, sorry for the late reply as I was on vacation these days.
I agree that visibility is poor so I have to add some printks to debug.
Actually, I have added per wb stats to improve the visibility as we
only have per bdi stats (/sys/kernel/debug/bdi/xxx:x/stats) now. And I
plan to submit it in a new series.
I'd like to add a script to improve visibility more but I can't ensure
the time to do it. I would submit the monitoring script with the per wb
stats if the time problem does not bother you.
Thanks.
> 
> Thanks.
> 



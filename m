Return-Path: <linux-fsdevel+bounces-18782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD478BC569
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 03:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 911911C21107
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 01:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C828B3CF6A;
	Mon,  6 May 2024 01:25:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979106FB2;
	Mon,  6 May 2024 01:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714958710; cv=none; b=b/4CXmHpMXYNxnLsZpq/gF3PZRxhlBpu4LSzSSP7Uik3YFJ9neFfyhP7rP5ebI2wEjec9F/awMB7s/31+iENLZ/fnzCaGi7qoOIt0o/T+Ac+7OyYGb1aiky7ppbo4KPOkH3jQTDItZbRosdahGK0hk/VSHnJ2hBCYM11QCDVdmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714958710; c=relaxed/simple;
	bh=yHHt4XFiBmrUD2THHdNuaVbruXG2YIA3ZcGwA7X9bwE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PmGQCJ2OBXMFg+eZKFjEikeqZmJqg6OWEp57W19Et61sx0M4t4PUz4zaOj9rLV/0fKp08rIp1gK8wQ3f0TIi4qoInVEze4H3P2coyyQzVKhRs5TrWrYBDxjFRf7LveorcFDZDZ5y5uLCQNLL1qkWTkFMIdjRqwUA76YtdCJ9dCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VXkGy3mZyz4f3kpX;
	Mon,  6 May 2024 09:24:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id BEC1E1A104F;
	Mon,  6 May 2024 09:25:03 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP1 (Coremail) with SMTP id cCh0CgDn_AVuMThmCHKBLw--.3757S2;
	Mon, 06 May 2024 09:25:03 +0800 (CST)
Subject: Re: [PATCH v2 0/4] Fix and cleanups to page-writeback
To: Tejun Heo <tj@kernel.org>
Cc: willy@infradead.org, akpm@linux-foundation.org, jack@suse.cz,
 hcochran@kernelspring.com, axboe@kernel.dk, mszeredi@redhat.com,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240425131724.36778-1-shikemeng@huaweicloud.com>
 <ZjJq2uvuXZoZ5aj3@slm.duckdns.org>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <55edec09-b54f-d02a-22ac-7ce90cb1e766@huaweicloud.com>
Date: Mon, 6 May 2024 09:25:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZjJq2uvuXZoZ5aj3@slm.duckdns.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgDn_AVuMThmCHKBLw--.3757S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr4xXF4kCr4xZFy8AFWxtFb_yoWfArb_W3
	yjkayqkFyDJrW2ganFgrs8WF1xCr48J34DJ34rXr1kt34fAF4DXan0kw1rZr1fJayxJr9x
	GFWqgw43Gwn7ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbI8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvj
	xUrR6zUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Hi Tejun,

on 5/2/2024 12:16 AM, Tejun Heo wrote:
> On Thu, Apr 25, 2024 at 09:17:20PM +0800, Kemeng Shi wrote:
>> v1->v2:
>> -rebase on up-to-date tree.
>> -add test result in "mm: correct calculation of wb's bg_thresh in cgroup
>> domain"
>> -drop "mm: remove redundant check in wb_min_max_ratio"
>> -collect RVB from Matthew to "mm: remove stale comment __folio_mark_dirty"
>>
>> This series contains some random cleanups and a fix to correct
>> calculation of wb's bg_thresh in cgroup domain. More details can
>> be found respective patches. Thanks!
> 
> Isn't this series already in -mm? Why is this being reposted? What tree is
> this based on? Please provide more context to help reviewing the patches.
> 
Sorry for late reply as I was on vacation these days. This series is based
on mm-unstable and was applied into -mm mm-unstable branch after this v2
series was posted.
Thanks
> Thanks.
> 



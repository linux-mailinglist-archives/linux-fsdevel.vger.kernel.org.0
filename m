Return-Path: <linux-fsdevel+bounces-26090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE6D953F74
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 04:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7C24B238E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 02:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7693C092;
	Fri, 16 Aug 2024 02:19:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C53F1EA91;
	Fri, 16 Aug 2024 02:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723774773; cv=none; b=PhnhS6lSsj4m4mGZ4Yi6NlLJ29caZS4h7GQA2XbmmVGQABoc1p8xTdqCrN6eGx9e4pYPrsxXxUXRrwwWQ0L1Oirdw/DntBE030tWUjeba6dd8EgBKnXdehlEwUAtOnx+0Bu1XUedGbAJhuwrVJCMs7eQ9qJOMk6BRowV4PW6Kk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723774773; c=relaxed/simple;
	bh=XLFbvPcZBtL+5+M6nAgxE6M5O/Y940W/lGEhJDbVtsk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZbVUUGdMOpbYBbeMrPWLMcDiEQ8ohyTwoxUXHScLsg10Z02Te8Jrc4hwKpbVlV8y1DSDGaL++tocygbUxXjnW/6o4l8KjyS+B1oe0Sr3ZeBHjuNbT07LLD+uyb+VOjhNDTekwRuUvgHRRp5Zc7O4JK731oncZT0goBEEbzc47Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WlQfR2KYhz4f3kw2;
	Fri, 16 Aug 2024 10:19:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 21F311A018D;
	Fri, 16 Aug 2024 10:19:26 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgBHboQst75mpGNDBw--.53631S3;
	Fri, 16 Aug 2024 10:19:25 +0800 (CST)
Subject: Re: [PATCH v2 4/6] iomap: correct the dirty length in page mkwrite
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, djwong@kernel.org, brauner@kernel.org,
 david@fromorbit.com, jack@suse.cz, willy@infradead.org, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com
References: <20240812121159.3775074-1-yi.zhang@huaweicloud.com>
 <20240812121159.3775074-5-yi.zhang@huaweicloud.com>
 <ZrxCYbqSHbpKpZjH@infradead.org>
 <7824fcb7-1de9-7435-e9f7-03dd7da6ec0a@huaweicloud.com>
 <Zr2ZMBS_0SC7Sysn@infradead.org>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <1728decf-2e29-1b79-f58b-388e671f5da2@huaweicloud.com>
Date: Fri, 16 Aug 2024 10:19:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zr2ZMBS_0SC7Sysn@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBHboQst75mpGNDBw--.53631S3
X-Coremail-Antispam: 1UD129KBjvdXoWrKFWxCry7trWDCFWkGryrXrb_yoW3AFX_Ww
	s0yw4kJw48ta43Xa1ftay5trWvgF4xXry3Zr4rGry7Gay5Zas5Gr4kCrs3Crn5KrWxGFZ0
	qa1rXr12kry3KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUba8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI
	1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7IU17KsUUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/8/15 13:59, Christoph Hellwig wrote:
> On Wed, Aug 14, 2024 at 03:49:41PM +0800, Zhang Yi wrote:
>> Sorry, this makes me confused. How does this could prevent setting
>> redundant dirty bits?
>>
>> Suppose we have a 3K regular file on a filesystem with 1K block size.
>> In iomap_page_mkwrite(), the iter.len is 3K, if the folio size is 4K,
>> folio_mark_dirty() will also mark all 4 bits of ifs dirty. And then,
>> if we expand this file size to 4K, and this will still lead to a hole
>> with dirty bit set but without any block allocated/reserved. Am I
>> missing something?
> 
> No, we still need the ifs manipulation in the loop indeed.  But
> the filemap_dirty_folio (and the not uptodate warning) can still
> move outside the iterator.
> 
Yes, right, I misunderstood.

Thanks,
Yi.



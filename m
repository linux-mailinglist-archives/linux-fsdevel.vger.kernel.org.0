Return-Path: <linux-fsdevel+bounces-8214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC0F8310DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 02:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52C3C284820
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 01:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD076468B;
	Thu, 18 Jan 2024 01:27:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA6B3D86;
	Thu, 18 Jan 2024 01:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705541243; cv=none; b=LwllQuoLShR7o7DWFAxzw6ZShtEvn0ZPlQaYJsmgHTEsYHehq3rbcPTpIBCWo1IE8u8YxN3r0UXdOssVBFjrywC+TSlyNX+osMeKhnIaFUMw3Ju3uhT8xljQXoyf00156ulnCYB0JbywSgVhKAFheruN4aajo5lnOaYZq7onw1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705541243; c=relaxed/simple;
	bh=WHyD5iPCBkA+qBJQvCftbeGK8fR2RfKEGijwDbE/Mks=;
	h=X-Alimail-AntiSpam:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=SvtyBtZxmUzUaXBgWLEQ1y1LLxjH6v89EZPOLlpKBTL6la1dtzeeomg4gwfZKcr3jHTENkBQxPR+uDrFK3jKa+WvEX62fC+Xymmfq+N8JqlwcPZAd9/QCDC+qR7uvbPYSnSKKHZIwIvdeWrkY6YbFZtbtZuk4cDAOMmNotNQgf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W-qs3Uk_1705541230;
Received: from 30.97.48.47(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W-qs3Uk_1705541230)
          by smtp.aliyun-inc.com;
          Thu, 18 Jan 2024 09:27:10 +0800
Message-ID: <07ccff45-a728-4ed1-86f4-91517c656609@linux.alibaba.com>
Date: Thu, 18 Jan 2024 09:27:41 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: improve dump_mapping() robustness
To: Christian Brauner <brauner@kernel.org>
Cc: willy@infradead.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org
References: <937ab1f87328516821d39be672b6bc18861d9d3e.1705391420.git.baolin.wang@linux.alibaba.com>
 <20240116-privat-zeitplan-21db23926f45@brauner>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240116-privat-zeitplan-21db23926f45@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/16/2024 7:16 PM, Christian Brauner wrote:
> On Tue, 16 Jan 2024 15:53:35 +0800, Baolin Wang wrote:
>> We met a kernel crash issue when running stress-ng testing, and the
>> system crashes when printing the dentry name in dump_mapping().
>>
>> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
>> pc : dentry_name+0xd8/0x224
>> lr : pointer+0x22c/0x370
>> sp : ffff800025f134c0
>> ......
>> Call trace:
>>    dentry_name+0xd8/0x224
>>    pointer+0x22c/0x370
>>    vsnprintf+0x1ec/0x730
>>    vscnprintf+0x2c/0x60
>>    vprintk_store+0x70/0x234
>>    vprintk_emit+0xe0/0x24c
>>    vprintk_default+0x3c/0x44
>>    vprintk_func+0x84/0x2d0
>>    printk+0x64/0x88
>>    __dump_page+0x52c/0x530
>>    dump_page+0x14/0x20
>>    set_migratetype_isolate+0x110/0x224
>>    start_isolate_page_range+0xc4/0x20c
>>    offline_pages+0x124/0x474
>>    memory_block_offline+0x44/0xf4
>>    memory_subsys_offline+0x3c/0x70
>>    device_offline+0xf0/0x120
>>    ......
>>
>> [...]
> 
> Seems fine for debugging purposes. Let me know if this needs to go through
> somewhere else.

Going through VFS tree is fine to me. Thanks.


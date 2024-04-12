Return-Path: <linux-fsdevel+bounces-16767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A558A2480
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 05:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 533DAB216A2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 03:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174E717BBF;
	Fri, 12 Apr 2024 03:49:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C4B5C82
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 03:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712893783; cv=none; b=avoef9i/9dLZ5ILHJfvFpe8pqXzZ0Ozi6JPCz8hu7LN8E4rd1KGaK0kume3+HsNAkoDgcHFxEp3bCCbbNq7qnC6cjl83o/yHtPxEkOUvJ/z2Z27IAwPyWecobXh45XjLghf1CIBP9IfDakqdJ7TfvTxaAqIlUSF81nF6TPfQIys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712893783; c=relaxed/simple;
	bh=w1576ZaS5XBQlIIKPCs2QjaxqTHgML4eTfaI3Fzxilw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fCJHNNnSoUw6orrjdfMgTmaamhZvJGWM8Jxc2iXJPkCnQqmgw9R7Cv5eow0iNhtxh5qmwPNsURK+gUmcS7qAxjIOU7PedFiL0A97pLZ9HDig84iWpXd7DCGNjqpt/FhTUiikpgV4AaOP+erLUyR6GM5pDuqUrVBtPF/LfQRtKIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VG2YX3QNZzwRcq;
	Fri, 12 Apr 2024 11:46:40 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id CD1EC140124;
	Fri, 12 Apr 2024 11:49:37 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 11:49:37 +0800
Message-ID: <4549178a-0168-4878-b4cd-db750d3ff6ac@huawei.com>
Date: Fri, 12 Apr 2024 11:49:37 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm: filemap: batch mm counter updating in
 filemap_map_pages()
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
CC: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>
References: <20240412025704.53245-1-wangkefeng.wang@huawei.com>
 <20240412025704.53245-3-wangkefeng.wang@huawei.com>
 <Zhin5gNVk8NHjxPP@casper.infradead.org>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <Zhin5gNVk8NHjxPP@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/4/12 11:17, Matthew Wilcox wrote:
> On Fri, Apr 12, 2024 at 10:57:04AM +0800, Kefeng Wang wrote:
>>   	} while ((folio = next_uptodate_folio(&xas, mapping, end_pgoff)) != NULL);
>> +
>> +	add_mm_counter(vma->vm_mm, mm_counter_file(folio), rss);
> 
> Can't folio be NULL here?
indeed, I need get mm counter type before while
> 


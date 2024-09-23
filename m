Return-Path: <linux-fsdevel+bounces-29813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9435497E4A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 03:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C75511C20F9A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 01:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F76A2CA9;
	Mon, 23 Sep 2024 01:39:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D000F10E9
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 01:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727055559; cv=none; b=IAexXS48x7n4xkgtjRk70FRABc5WJY556+aa6CY8P6RCPOE9IRZpqp4tIxxTOlVxTeaQ7e2tCv/GUMTKDPg96756BHGs/Jk7IU59qRTbPm4YiUnC9n/X00s4OxY5AN8ZHoVJqOjAthVzbBghMSkZpU7SlK30/qhxiiKvh2F6E5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727055559; c=relaxed/simple;
	bh=mk8klG6nd/2A0bgG4kS9BLpV/FYzkBW+OoAEWOXLDeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tNBjnd0YlPrDlLCWzkflQoTflgn7kw/+ZSxyR7sC7PxedhNRw9O4e/G7KdfJWksFwtSO4DiYdoHTxlWh7SbPfn8Vmw42pul8BaVzzr/2FlexhDJuvKXgmIo4IULCqz3E9LaccUr43ct5KErEm22du7szkFIICBn7376oAW/8ZLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XBlx61W77zyRpw;
	Mon, 23 Sep 2024 09:37:46 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 5D05F140F82;
	Mon, 23 Sep 2024 09:39:08 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 23 Sep 2024 09:39:07 +0800
Message-ID: <1d4f98aa-f57d-4801-8510-5c44e027c4e4@huawei.com>
Date: Mon, 23 Sep 2024 09:39:07 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tmpfs: fault in smaller chunks if large folio
 allocation not allowed
To: Matthew Wilcox <willy@infradead.org>
CC: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins
	<hughd@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Anna Schumaker
	<Anna.Schumaker@netapp.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>, Baolin Wang <baolin.wang@linux.alibaba.com>
References: <20240914140613.2334139-1-wangkefeng.wang@huawei.com>
 <20240920143654.1008756-1-wangkefeng.wang@huawei.com>
 <Zu9mbBHzI-MyRoHa@casper.infradead.org>
Content-Language: en-US
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <Zu9mbBHzI-MyRoHa@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 2024/9/22 8:35, Matthew Wilcox wrote:
> On Fri, Sep 20, 2024 at 10:36:54PM +0800, Kefeng Wang wrote:
>> The tmpfs supports large folio, but there is some configurable options
>> to enable/disable large folio allocation, and for huge=within_size,
>> large folio only allowabled if it fully within i_size, so there is
>> performance issue when perform write without large folio, the issue is
>> similar to commit 4e527d5841e2 ("iomap: fault in smaller chunks for
>> non-large folio mappings").
> 
> No.  What's wrong with my earlier suggestion?
> 

The tempfs has mount options(never/always/within_size/madvise) for large
folio, also has sysfs file /sys/kernel/mm/transparent_hugepage/shmem_enabled
to deny/force large folio at runtime, as replied in v1, I think it
breaks the rules of mapping_set_folio_order_range(),

   "Do not tune it based on, eg, i_size."
   --- for tmpfs, it does choose large folio or not based on the i_size

   "Context: This should not be called while the inode is active as it 
is non-atomic."
   --- during perform write, the inode is active

So this is why I don't use mapping_set_folio_order_range() here, but
correct me if I am wrong.




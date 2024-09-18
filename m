Return-Path: <linux-fsdevel+bounces-29617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C55297B722
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 05:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19760285AC4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 03:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A6A138490;
	Wed, 18 Sep 2024 03:55:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9679915A8
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2024 03:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726631754; cv=none; b=pFOT0oGy47XAY7d9gcDs+fkXsaS8HMP9r0moZuA7xYPiktN5JL+UxQHCWLxOo4Pz0XMxXvaUFNifN1LU89hYIrEpp4HNVPXgXrHW+EniJMq2YobWgWNyXHEJmXbWtR0g9xAdth0Rbr6CYVYQWPaixCqy2qdOVl0cBSEew4oWzpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726631754; c=relaxed/simple;
	bh=Xlim/11V5709b0cyE08z4VomTFtZ8XwyUxRTBIjWGGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tc0++ZXebao+iZoWqmecgKWLzb3/K++tRrIV6fV/ECETL31oO99hnDRXKYFTcq58Wa+p9/eww9sBkk8rd6ExZLrLbyp5TzgwO0FNct2uh3srx5owex0jOfRozGUK5o+PWZjJiKT30Tsg+h12sI82RJG6sQm4jgiYvI/KchCS1Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4X7lC82bpBzyQlM;
	Wed, 18 Sep 2024 11:54:28 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 16CF11402E0;
	Wed, 18 Sep 2024 11:55:44 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 18 Sep 2024 11:55:43 +0800
Message-ID: <1c8c7401-e68d-4636-923d-57bb31f33a3d@huawei.com>
Date: Wed, 18 Sep 2024 11:55:42 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] tmpfs: fault in smaller chunks if large folio
 allocation not allowed
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
CC: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins
	<hughd@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Anna Schumaker
	<Anna.Schumaker@netapp.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>
References: <20240914140613.2334139-1-wangkefeng.wang@huawei.com>
 <Zua5mDwhm7RlC0MS@casper.infradead.org>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <Zua5mDwhm7RlC0MS@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 2024/9/15 18:40, Matthew Wilcox wrote:
> On Sat, Sep 14, 2024 at 10:06:13PM +0800, Kefeng Wang wrote:
>> +++ b/mm/shmem.c
>> @@ -3228,6 +3228,7 @@ static ssize_t shmem_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>>   {
>>   	struct file *file = iocb->ki_filp;
>>   	struct inode *inode = file->f_mapping->host;
>> +	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
>>   	ssize_t ret;
>>   
>>   	inode_lock(inode);
>> @@ -3240,6 +3241,10 @@ static ssize_t shmem_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>>   	ret = file_update_time(file);
>>   	if (ret)
>>   		goto unlock;
>> +
>> +	if (!shmem_allowable_huge_orders(inode, NULL, index, 0, false))
>> +		iocb->ki_flags |= IOCB_NO_LARGE_CHUNK;
> 
> Wouldn't it be better to call mapping_set_folio_order_range() so we
> don't need this IOCB flag?
> 

I think it before, but the comment of mapping_set_folio_order_range() said,

  "The filesystem should call this function in its inode constructor to
  indicate which base size (min) and maximum size (max) of folio the VFS
  can use to cache the contents of the file.  This should only be used
  if the filesystem needs special handling of folio sizes (ie there is
  something the core cannot know).
  Do not tune it based on, eg, i_size.

  Context: This should not be called while the inode is active as it
  is non-atomic."

and dynamically modify mappings without protect maybe a risk.

Or adding a new __generic_perform_write() with a chunk_size argument to
avoid to use a IOCB flag?


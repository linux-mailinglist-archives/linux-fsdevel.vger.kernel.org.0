Return-Path: <linux-fsdevel+bounces-29948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61385984002
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 10:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B4C12841E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 08:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEC814BF85;
	Tue, 24 Sep 2024 08:11:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6430C14883F;
	Tue, 24 Sep 2024 08:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727165476; cv=none; b=sDR61A/7oVBWCCKpNNKtz2gTTbZ/9+OLgE01Nls5XFPk1Kfx/yiUw4ID6Ujjq6pkk/nTYg99hdG5u3WEjuqsnMDhML5kiOIK6vzmMTiI3oP6aoSX+etsMIV7GedENyI6A55SxSEYLAQrbye74ddlGIf/Y9WfcXZkYVH0CUn13Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727165476; c=relaxed/simple;
	bh=BBB2+zMUlgbn5hJn45cfafMDfms312TaWh9lZPab6vg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HqWV5SfrEPi6tUTG1sh1WaPbUZcbyQwXjwEkTduCh4kwM0kIfDRokjS6Cmart+hmlLu4RSjwDhydI5g34C8hEhQwkZHOnDYfjW3dGsHcawLwtMZ4ji/slGWxT2HpdpQe5h++y68AHfKBjTHV/fynoJaHLVVD5HdavW9ajEl+jN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XCXcF4wQkz4f3lDG;
	Tue, 24 Sep 2024 16:10:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8C7661A0359;
	Tue, 24 Sep 2024 16:11:10 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgAHPMgcdPJmzGLSCA--.38253S3;
	Tue, 24 Sep 2024 16:11:10 +0800 (CST)
Message-ID: <e6cceeee-9ff1-4638-8521-19ab40593693@huaweicloud.com>
Date: Tue, 24 Sep 2024 16:11:08 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] ext4: factor out a common helper to lock and
 flush data before fallocate
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 ritesh.list@gmail.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com
References: <20240904062925.716856-1-yi.zhang@huaweicloud.com>
 <20240904062925.716856-11-yi.zhang@huaweicloud.com>
 <20240923085402.amto7pryy67eadpj@quack3>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20240923085402.amto7pryy67eadpj@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAHPMgcdPJmzGLSCA--.38253S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXrW3JF1kKr45CF1xWFyfJFb_yoW5Aw43pF
	Z5GFn2gF40ga48uFn5Z3ZrZF4Fg3sYkrWxZry7Gas293s0yrn2kF1YkrWUuF17JrZ3Ar4U
	ZF4jv3sruF4jvrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/9/23 16:54, Jan Kara wrote:
> On Wed 04-09-24 14:29:25, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Now the beginning of the first four functions in ext4_fallocate() (punch
>> hole, zero range, insert range and collapse range) are almost the same,
>> they need to wait for the dio to finish, get filemap invalidate lock,
>> write back dirty data and finally drop page cache. Factor out a common
>> helper to do these work can reduce a lot of the redundant code.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> I like that we factor out this functionality in a common helper. But see
> below:
> 
>> @@ -4731,6 +4707,52 @@ static int ext4_fallocate_check(struct inode *inode, int mode,
>>  	return 0;
>>  }
>>  
>> +int ext4_prepare_falloc(struct file *file, loff_t start, loff_t end, int mode)
>> +{
>> +	struct inode *inode = file_inode(file);
>> +	struct address_space *mapping = inode->i_mapping;
>> +	int ret;
>> +
>> +	/* Wait all existing dio workers, newcomers will block on i_rwsem */
>> +	inode_dio_wait(inode);
>> +	ret = file_modified(file);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/*
>> +	 * Prevent page faults from reinstantiating pages we have released
>> +	 * from page cache.
>> +	 */
>> +	filemap_invalidate_lock(mapping);
>> +
>> +	ret = ext4_break_layouts(inode);
>> +	if (ret)
>> +		goto failed;
>> +
>> +	/*
>> +	 * Write data that will be zeroed to preserve them when successfully
>> +	 * discarding page cache below but fail to convert extents.
>> +	 */
>> +	ret = filemap_write_and_wait_range(mapping, start, end);
> 
> The comment is somewhat outdated now.

Sure, will update it in next iteration.

> Also the range is wrong for collapse
> and insert range. There we need to writeout data upto the EOF because we
> truncate it below.
> 

For collapse and insert range, I passed the length LLONG_MAX, which is
the same as before, this should've upto the EOF, so I think it's
right, or am I missing something?

ext4_collapse_range():

-	start = round_down(offset, PAGE_SIZE);
-	/* Write out all dirty pages */
-	ret = filemap_write_and_wait_range(mapping, start, LLONG_MAX);
+	ret = ext4_prepare_falloc(file, round_down(offset, PAGE_SIZE),
+				  LLONG_MAX, FALLOC_FL_COLLAPSE_RANGE);


ext4_insert_range():

-	start = round_down(offset, PAGE_SIZE);
-	/* Write out all dirty pages */
-	ret = filemap_write_and_wait_range(mapping, start, LLONG_MAX);
+	ret = ext4_prepare_falloc(file, round_down(offset, PAGE_SIZE),
+				  LLONG_MAX, FALLOC_FL_INSERT_RANGE);

Thanks,
Yi.

> 
>> +	if (ret)
>> +		goto failed;
>> +
>> +	/*
>> +	 * For insert range and collapse range, COWed private pages should
>> +	 * be removed since the file's logical offset will be changed, but
>> +	 * punch hole and zero range doesn't.
>> +	 */
>> +	if (mode & (FALLOC_FL_INSERT_RANGE | FALLOC_FL_COLLAPSE_RANGE))
>> +		truncate_pagecache(inode, start);
>> +	else
>> +		truncate_pagecache_range(inode, start, end);
>> +
>> +	return 0;
>> +failed:
>> +	filemap_invalidate_unlock(mapping);
>> +	return ret;
>> +}
> 



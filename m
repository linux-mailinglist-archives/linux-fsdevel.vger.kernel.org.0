Return-Path: <linux-fsdevel+bounces-29947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CA3983FB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 09:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46B5C1F23ADE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 07:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC1B149C69;
	Tue, 24 Sep 2024 07:53:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DA222334;
	Tue, 24 Sep 2024 07:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727164381; cv=none; b=rvUi3/bDqW6KeM9sS5MARC4mJqB0Y3hDfJ6P4W9ts7GiKckknhXhQlMbQxXhaYtcQlSQZnC/3QtZOonndSGbRziiLrjT3PCfI4AZdMidlLJO9db8ofzpFosnY1ugRMP7hjayJNo2lpwii2zKTOPnGfO3ATrgqcD3cZ/qPsOEqTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727164381; c=relaxed/simple;
	bh=WuR4vb28tjr6Pf4XLYRhxXmMoNRwxc5ZQTBeMUDtNi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fh2dBkb91GD0juDAD2Vj5rDZamSR+b2pAhOiWt50uw5kK6XEqghMXr8TSA11fapex9o2XJRGUpBJMgUbnEmwy1tqFOUCcl6yp7XC5yDvtVJ729dMNuGzeK0K0UXcw3Y6rJhc1E4PD+ttHipQtVu9qL8oa5XASK6RgIOalGbqsMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XCXCB05vqz4f3l2C;
	Tue, 24 Sep 2024 15:52:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DB1AB1A06D7;
	Tue, 24 Sep 2024 15:52:54 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgD3KsfWb_Jm2TPRCA--.34478S3;
	Tue, 24 Sep 2024 15:52:54 +0800 (CST)
Message-ID: <88bf7d21-2058-47fd-99f8-4266f87fcfd9@huaweicloud.com>
Date: Tue, 24 Sep 2024 15:52:53 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] ext4: factor out the common checking part of all
 fallocate operations
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 ritesh.list@gmail.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com
References: <20240904062925.716856-1-yi.zhang@huaweicloud.com>
 <20240904062925.716856-10-yi.zhang@huaweicloud.com>
 <20240923083122.amqnlzxj53beqtwj@quack3>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20240923083122.amqnlzxj53beqtwj@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgD3KsfWb_Jm2TPRCA--.34478S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF1xAr1UKrWkuF1kGryUJrb_yoW8tr1DpF
	WxtF18Zryqga4xWr1vqw1kXr1Fva95Wr4UX3yIqFyDAr93Za4fKry5GrZ09a4xG3sYyr10
	vFWYqry3Ca1jya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUb
	mii3UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/9/23 16:31, Jan Kara wrote:
> On Wed 04-09-24 14:29:24, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Now the beginning of all the five functions in ext4_fallocate() (punch
>> hole, zero range, insert range, collapse range and normal fallocate) are
>> almost the same, they need to hold i_rwsem and check the validity of
>> input parameters, so move the holding of i_rwsem to ext4_fallocate()
>> and factor out a common helper to check the input parameters can make
>> the code more clear.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ...
>> +static int ext4_fallocate_check(struct inode *inode, int mode,
>> +				loff_t offset, loff_t len)
>> +{
>> +	/* Currently except punch_hole, just for extent based files. */
>> +	if (!(mode & FALLOC_FL_PUNCH_HOLE) &&
>> +	    !ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
>> +		return -EOPNOTSUPP;
>> +
>> +	/*
>> +	 * Insert range and collapse range works only on fs cluster size
>> +	 * aligned regions.
>> +	 */
>> +	if (mode & (FALLOC_FL_INSERT_RANGE | FALLOC_FL_COLLAPSE_RANGE) &&
>> +	    !IS_ALIGNED(offset | len, EXT4_CLUSTER_SIZE(inode->i_sb)))
>> +		return -EINVAL;
>> +
>> +	if (mode & FALLOC_FL_INSERT_RANGE) {
>> +		/* Collapse range, offset must be less than i_size */
>> +		if (offset >= inode->i_size)
>> +			return -EINVAL;
>> +		/* Check whether the maximum file size would be exceeded */
>> +		if (len > inode->i_sb->s_maxbytes - inode->i_size)
>> +			return -EFBIG;
>> +	} else if (mode & FALLOC_FL_COLLAPSE_RANGE) {
>> +		/*
>> +		 * Insert range, there is no need to overlap collapse
>> +		 * range with EOF, in which case it is effectively a
>> +		 * truncate operation.
>> +		 */
>> +		if (offset + len >= inode->i_size)
>> +			return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
> 
> I don't think this helps. If the code is really shared, then the
> factorization is good but here you have to do various checks what operation
> we perform and in that case I don't think it really helps readability to
> factor out checks into a common function.
> 

Yeah, I think you are right, this is just move out the checks and
may increase the reading difficulty, it should be easier to understand
if they're still in their original places.

Thanks,
Yi.



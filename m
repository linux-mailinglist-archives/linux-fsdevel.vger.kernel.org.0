Return-Path: <linux-fsdevel+bounces-51445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D31CBAD6F31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 13:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1D83189857A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 11:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CD32F4332;
	Thu, 12 Jun 2025 11:37:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0B32F4333;
	Thu, 12 Jun 2025 11:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749728268; cv=none; b=hSOPXz5xcMHpNfbiAjyc7+Vn1XBdowCH7ua2uQxaozNkhGH+sjdAaF8UjMO7MPeoLdN4V9pXmJDjYD6WSCQapfhPiPdc2Uo19Mz+Iw91LDgTQ30ILvQwqrOH3foIW2hCzOXlu/1mOCSAofDOk6kj+pMPjeoWKBBBLC+dmuTBcmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749728268; c=relaxed/simple;
	bh=1hME+q7q5I+jjLm/t72QKjRqfoHtJN7hkve8S00L+WE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iW4W95KG9jb9KG8+tASQF0M91Z9u0VrjAaAr/YvGnA/tVpdNTsObEouIkzhMPwgRSQx1RziF1GKWg1ZlA3Kt3W+9aXxbd2+3t4qi+x3NK4RQBO+RKnRH5QYrwhKpw54ojqd+wOi2cnESBGbw4pVSXVTGztvlWxPm21imrK3fhZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bJ0rR4SwYzKHN95;
	Thu, 12 Jun 2025 19:37:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id ECED01A01A4;
	Thu, 12 Jun 2025 19:37:41 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgAXe18DvEpoJoUoPQ--.21926S3;
	Thu, 12 Jun 2025 19:37:41 +0800 (CST)
Message-ID: <b14aaa15-9d41-45cf-9bd8-fe92d256070d@huaweicloud.com>
Date: Thu, 12 Jun 2025 19:37:39 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] fs: introduce FALLOC_FL_WRITE_ZEROES to fallocate
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de,
 tytso@mit.edu, john.g.garry@oracle.com, bmarzins@redhat.com,
 chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com, brauner@kernel.org,
 martin.petersen@oracle.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com, yangerkun@huawei.com, linux-api@vger.kernel.org
References: <20250604020850.1304633-1-yi.zhang@huaweicloud.com>
 <20250604020850.1304633-8-yi.zhang@huaweicloud.com>
 <20250611150555.GB6134@frogsfrogsfrogs>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250611150555.GB6134@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAXe18DvEpoJoUoPQ--.21926S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGrykKF4xGr1UuryUJryUAwb_yoWrWF45pF
	W3Ca4UKr4kGFyfC3s3Z3Z7Cry5Zws3Kr43ZrW2gr1jvr15Wr1fKFsFgryYva4xJrs7Aa1Y
	qr40vFy3ua4DZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIa
	0PDUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/6/11 23:05, Darrick J. Wong wrote:
> [cc linux-api about a fallocate uapi change]
> 
> On Wed, Jun 04, 2025 at 10:08:47AM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> With the development of flash-based storage devices, we can quickly
>> write zeros to SSDs using the WRITE_ZERO command if the devices do not
>> actually write physical zeroes to the media. Therefore, we can use this
>> command to quickly preallocate a real all-zero file with written
>> extents. This approach should be beneficial for subsequent pure
>> overwriting within this file, as it can save on block allocation and,
>> consequently, significant metadata changes, which should greatly improve
>> overwrite performance on certain filesystems.
>>
>> Therefore, introduce a new operation FALLOC_FL_WRITE_ZEROES to
>> fallocate. This flag is used to convert a specified range of a file to
>> zeros by issuing a zeroing operation. Blocks should be allocated for the
>> regions that span holes in the file, and the entire range is converted
>> to written extents. If the underlying device supports the actual offload
>> write zeroes command, the process of zeroing out operation can be
>> accelerated. If it does not, we currently don't prevent the file system
>> from writing actual zeros to the device. This provides users with a new
>> method to quickly generate a zeroed file, users no longer need to write
>> zero data to create a file with written extents.
>>
>> Users can determine whether a disk supports the unmap write zeroes
>> operation through querying this sysfs interface:
>>
>>     /sys/block/<disk>/queue/write_zeroes_unmap
>>
>> Finally, this flag cannot be specified in conjunction with the
>> FALLOC_FL_KEEP_SIZE since allocating written extents beyond file EOF is
>> not permitted. In addition, filesystems that always require out-of-place
>> writes should not support this flag since they still need to allocated
>> new blocks during subsequent overwrites.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> ---
>>  fs/open.c                   |  1 +
>>  include/linux/falloc.h      |  3 ++-
>>  include/uapi/linux/falloc.h | 18 ++++++++++++++++++
>>  3 files changed, 21 insertions(+), 1 deletion(-)
>>
[...]
>> diff --git a/include/uapi/linux/falloc.h b/include/uapi/linux/falloc.h
>> index 5810371ed72b..265aae7ff8c1 100644
>> --- a/include/uapi/linux/falloc.h
>> +++ b/include/uapi/linux/falloc.h
>> @@ -78,4 +78,22 @@
>>   */
>>  #define FALLOC_FL_UNSHARE_RANGE		0x40
>>  
>> +/*
>> + * FALLOC_FL_WRITE_ZEROES is used to convert a specified range of a file to
>> + * zeros by issuing a zeroing operation. Blocks should be allocated for the
>> + * regions that span holes in the file, and the entire range is converted to
>> + * written extents.
> 
> I think you could simplify this a bit by talking only about the end
> state after a successful call:
> 
> "FALLOC_FL_WRITE_ZEROES zeroes a specified file range in such a way that
> subsequent writes to that range do not require further changes to file
> mapping metadata."
> 
> Note that we don't say how the filesystem gets to this goal.  Presumably
> the first implementations will send a zeroing operation to the block
> device during allocation and the fs will create written mappings, but
> there are other ways to get there -- a filesystem could maintain a pool
> of pre-zeroed space and hand those out; or it could zero space on
> freeing and mounting such that all new mappings can be created as
> written even without the block device zeroing operation.
> 
> Or you could be running on some carefully engineered system where you
> know the storage will always be zeroed at allocation time due to some
> other aspect of the system design, e.g. a single-use throwaway cloud vm
> where you allocate to the end of the disk and reboot the node.

Indeed, it makes sense to me. It appears to be more generic and obscures
the methods by which different file systems may achieve this goal. Thank
you for the suggestion.

Best regards,
Yi.



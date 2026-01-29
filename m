Return-Path: <linux-fsdevel+bounces-75835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GB4SA+q+emnw+AEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 02:59:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEC4AAF60
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 02:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80EDB3053B9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 01:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4603370FF;
	Thu, 29 Jan 2026 01:57:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247033203A9;
	Thu, 29 Jan 2026 01:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769651818; cv=none; b=dvZ+ow4KY75Vy0yAKPVAFkg/nieVnpBFJm2MmXTtJbjseC9kWU2ApbX1reMLQ9+A8xvSt+yFOw1lgOwUXLbrQVmDIPS78XXjacY6Vh0zhro3h2CRArl+Rotty2vGEMiYCTaDLfxD/XjcWH31J8wlq4Ekp+4ZF0Rat0m0/5Lpp5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769651818; c=relaxed/simple;
	bh=JA2gdwNXNSFboqPr70MZOjClN/dk/DvbRQehvr2TPxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N3tZ1ugSnyQTNvvFqcDaAQj86DJDCfDY/g5a5OpUvnhisDkm4gLAdNVcpT3aRB/tvq7t3zMdgZAn1nLAxMbdMgf9neuiRsABSP+hlsGc7cNwaXOU9NQ7NJpRHxwiJh3L9ymk3Fbi/sUdXJVrGVWUpT/El8wb8ueHL4Dyr+pNUKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4f1j1L2CLwzKHMPr;
	Thu, 29 Jan 2026 09:56:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9D30A40573;
	Thu, 29 Jan 2026 09:56:51 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP4 (Coremail) with SMTP id gCh0CgAXd_dgvnppTNTuFQ--.59374S3;
	Thu, 29 Jan 2026 09:56:51 +0800 (CST)
Message-ID: <d56ffd21-c835-47cd-8e70-85c0ab320ff8@huaweicloud.com>
Date: Thu, 29 Jan 2026 09:56:48 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: do not check fast symlink during orphan recovery
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 ojaswin@linux.ibm.com, ritesh.list@gmail.com, yi.zhang@huawei.com,
 yizhang089@gmail.com, libaokun1@huawei.com, yangerkun@huawei.com,
 yukuai@fnnas.com
References: <20260128021609.4061686-1-yi.zhang@huaweicloud.com>
 <ardxpk4lmdigmoren3o4gz6stg36vfywdpu5p24t56mlsjrhgo@buwmke3azxba>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <ardxpk4lmdigmoren3o4gz6stg36vfywdpu5p24t56mlsjrhgo@buwmke3azxba>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAXd_dgvnppTNTuFQ--.59374S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXry8ZrWDKw47Ar4DurW3ZFb_yoW5Ary7pF
	WSk3WkJr4UJF9Ygr4IqrWUXF10g3W0kr4jyrZ5AFWDZ3s8Aa4xKF12gF45WayUtrs8Aa1F
	vF1Igr9xZwn8GFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-75835-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,linux.ibm.com,gmail.com,huawei.com,fnnas.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yi.zhang@huaweicloud.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.961];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huaweicloud.com:mid]
X-Rspamd-Queue-Id: 7EEC4AAF60
X-Rspamd-Action: no action

On 1/28/2026 5:59 PM, Jan Kara wrote:
> On Wed 28-01-26 10:16:09, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Commit '5f920d5d6083 ("ext4: verify fast symlink length")' causes the
>> generic/475 test to fail during orphan cleanup of zero-length symlinks.
>>
>>   generic/475  84s ... _check_generic_filesystem: filesystem on /dev/vde is inconsistent
>>
>> The fsck reports are provided below:
>>
>>   Deleted inode 9686 has zero dtime.
>>   Deleted inode 158230 has zero dtime.
>>   ...
>>   Inode bitmap differences:  -9686 -158230
>>   Orphan file (inode 12) block 13 is not clean.
>>   Failed to initialize orphan file.
>>
>> In ext4_symlink(), a newly created symlink can be added to the orphan
>> list due to ENOSPC. Its data has not been initialized, and its size is
>> zero. Therefore, we need to disregard the length check of the symbolic
>> link when cleaning up orphan inodes.
>>
>> Fixes: 5f920d5d6083 ("ext4: verify fast symlink length")
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> Thanks for the patch!
> 
>> @@ -6079,18 +6079,22 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>>  			inode->i_op = &ext4_encrypted_symlink_inode_operations;
>>  		} else if (ext4_inode_is_fast_symlink(inode)) {
>>  			inode->i_op = &ext4_fast_symlink_inode_operations;
>> -			if (inode->i_size == 0 ||
>> -			    inode->i_size >= sizeof(ei->i_data) ||
>> -			    strnlen((char *)ei->i_data, inode->i_size + 1) !=
>> -								inode->i_size) {
>> -				ext4_error_inode(inode, function, line, 0,
>> -					"invalid fast symlink length %llu",
>> -					 (unsigned long long)inode->i_size);
>> -				ret = -EFSCORRUPTED;
>> -				goto bad_inode;
>> +
>> +			/* Orphan cleanup can get a zero-sized symlink. */
> 
> I was mulling over this for a while. I'd expand the comment here a bit:
> 
> 			/*
> 			 * Orphan cleanup can see inodes with i_size == 0
> 			 * and i_data uninitialized. Skip size checks in
> 			 * that case. This is safe because the first thing
> 			 * ext4_evict_inode() does for fast symlinks is
> 			 * clearing of i_data and i_size.
> 			 */
> 
> and I think we also need to verify that i_nlink is 0 (as otherwise we'd
> leave potentially invalid accessible inode in cache).
> 
> 								Honza

Thank you for the review and suggestions. These makes sense to me, I will
add them in my next iteration.

Thanks,
Yi.

> 
>> +			if (!(EXT4_SB(sb)->s_mount_state & EXT4_ORPHAN_FS)) {
>> +				if (inode->i_size == 0 ||
>> +				    inode->i_size >= sizeof(ei->i_data) ||
>> +				    strnlen((char *)ei->i_data, inode->i_size + 1) !=
>> +						inode->i_size) {
>> +					ext4_error_inode(inode, function, line, 0,
>> +						"invalid fast symlink length %llu",
>> +						(unsigned long long)inode->i_size);
>> +					ret = -EFSCORRUPTED;
>> +					goto bad_inode;
>> +				}
>> +				inode_set_cached_link(inode, (char *)ei->i_data,
>> +						      inode->i_size);
>>  			}
>> -			inode_set_cached_link(inode, (char *)ei->i_data,
>> -					      inode->i_size);
>>  		} else {
>>  			inode->i_op = &ext4_symlink_inode_operations;
>>  		}
>> -- 
>> 2.52.0
>>



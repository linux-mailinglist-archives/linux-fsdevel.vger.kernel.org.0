Return-Path: <linux-fsdevel+bounces-47706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B27DAAA45D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 10:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18C581C04AC5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 08:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7566A21930B;
	Wed, 30 Apr 2025 08:44:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31F621767D;
	Wed, 30 Apr 2025 08:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746002676; cv=none; b=K8cGrqbX1RQ/XRn8jwuknyIR1CoFa3XBlfQTb1pr82fatd1+v8SXXeDes5fjgrR41Zg68Q3MIiBwMps+s6fjp8W7Y7O76yWVzGYLltgItk5XZ1oXsBrrBfD2apVMdHJvOSg8aJNVS2/VN5B1k9Z+3QopSpEw7t75ph7bpX28974=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746002676; c=relaxed/simple;
	bh=hMq64hngGFSstWOr2pEMUIC+DWCr0d63A5M0vCkc+k0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q3QaGNLIgekeuds+Ul2UDK5pRSMvnvWlQyGyEX7pJn1Akv9Tnshp7dr1kU96Jhlc3Ze2BlBNr8qno4vyEO2g9E+IUB/0xmU9VtoHEorAtgzxA3JoSzdzADOGF8pRiNIMk5z8TkUlF3d7Cq9NVQDD/MidDFUHX0qd3uTeF5+uWfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZnW1s34sSz4f3lCm;
	Wed, 30 Apr 2025 16:44:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2B8041A1653;
	Wed, 30 Apr 2025 16:44:27 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgCnC2Dp4hFomugCLA--.14448S3;
	Wed, 30 Apr 2025 16:44:26 +0800 (CST)
Message-ID: <8c1f9230-a475-4fc3-9b2d-5f11f5122bb3@huaweicloud.com>
Date: Wed, 30 Apr 2025 16:44:25 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] ext4: fix incorrect punch max_end
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 wanghaichi0403@gmail.com, yi.zhang@huawei.com, libaokun1@huawei.com,
 yukuai3@huawei.com, yangerkun@huawei.com
References: <20250430011301.1106457-1-yi.zhang@huaweicloud.com>
 <20250430011301.1106457-2-yi.zhang@huaweicloud.com>
 <ykm27jvrnmhgd4spslhn4mano452c6z34fab7r3776dmjkgo7q@cv2lvsiteufa>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <ykm27jvrnmhgd4spslhn4mano452c6z34fab7r3776dmjkgo7q@cv2lvsiteufa>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCnC2Dp4hFomugCLA--.14448S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uF1ktw4DXrWrurWUArykAFb_yoW8ArW5pF
	y3C3WUKw4kuay7u3yFqF45ZFnFy3Z5AF4UXrWrWr13Wa43C34SkFyjgayjv3W2vw4Ikw40
	q3s8tryfA34j9aDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 2025/4/30 16:18, Jan Kara wrote:
> On Wed 30-04-25 09:12:59, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> For the extents inodes, the maxbytes should be sb->s_maxbytes instead of
>> sbi->s_bitmap_maxbytes. Correct the maxbytes value to correct the
>> behavior of punch hole.
>>
>> Fixes: 2da376228a24 ("ext4: limit length to bitmap_maxbytes - blocksize in punch_hole")
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> Thinking about this some more...
> 
>> @@ -4015,6 +4015,12 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>>  	trace_ext4_punch_hole(inode, offset, length, 0);
>>  	WARN_ON_ONCE(!inode_is_locked(inode));
>>  
>> +	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
>> +		max_end = sb->s_maxbytes;
>> +	else
>> +		max_end = EXT4_SB(sb)->s_bitmap_maxbytes;
>> +	max_end -= sb->s_blocksize;
> 
> I think the -= sb->s_blocksize is needed only for indirect-block based
> scheme (due to an implementation quirk in ext4_ind_remove_space()). But
> ext4_ext_remove_space() should be fine with punch hole ending right at
> sb->s_maxbytes. And since I find it somewhat odd that you can create file
> upto s_maxbytes but cannot punch hole to the end, it'd limit that behavior
> as much as possible. Ideally we'd fix ext4_ind_remove_space() but I can't
> be really bothered for the ancient format...
> 

Yes, I share your feelings. Currently, we do not seem to have any
practical issues. To maintain consistent behavior between the two inode
types and to keep the code simple, I retained the -= sb->s_blocksize
operation. Would you suggest that we should at least address the extents
inodes by removing the -=sb->s_blocksize now?

Thanks,
Yi.



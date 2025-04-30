Return-Path: <linux-fsdevel+bounces-47713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C11AA4942
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 12:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6A0A5A74F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 10:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E533F23BD0E;
	Wed, 30 Apr 2025 10:54:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386661CD15;
	Wed, 30 Apr 2025 10:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746010482; cv=none; b=BPJo1ixucZoGUhT26rUlL6wPJY5DP8IweCKzC7TtF86aY3jZqeYRiAvj6D9Gvuh7BcfdbeN7uEfVAefbpV7eUO84E2u/pqBLSiv39eFWvlKn2u/4m/Sxusppu74RVksOXv+0a1JVHu5cF6ElGIDPDSNlIo0pwGP735BoKxyBkSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746010482; c=relaxed/simple;
	bh=/BtwEq+TKoL4TxiHfus1NfzLpwf48XHvtcbEQ62q0Uc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xk0w2ztHjcIIf9eiOSu72d+faR9sDlI3dhPDuE35sXg9jI8IXFiUl9AdOFqTih8f7c9dTkogaWP05w4g/vyOH0STlvf2ALAQ3umK29BsSmB8nVCivpKgnAfIJB6WTRkaVgWTiqjSaEQ6G+mkIPLBIniNbHT7HBW2/us1eXuzodo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4ZnYwS21byzKHMWJ;
	Wed, 30 Apr 2025 18:54:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 39B471A0FB4;
	Wed, 30 Apr 2025 18:54:31 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgB3219lARJoGdoLLA--.26076S3;
	Wed, 30 Apr 2025 18:54:31 +0800 (CST)
Message-ID: <610525a1-5fb5-475e-9842-dc145aaf8718@huaweicloud.com>
Date: Wed, 30 Apr 2025 18:54:29 +0800
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
 <8c1f9230-a475-4fc3-9b2d-5f11f5122bb3@huaweicloud.com>
 <4u2frbxygagij6uxryijqmzgarhotk4cw2w4knm4rpivll5qvg@2d2wd2742v36>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <4u2frbxygagij6uxryijqmzgarhotk4cw2w4knm4rpivll5qvg@2d2wd2742v36>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgB3219lARJoGdoLLA--.26076S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyUXrykAr1fXr15Ww4rZrb_yoW8ur1fpF
	y3CF1UKw4kG3y7u34IqFn8ZFnFy3WkAF4UXr4rWr13XF90kw1SkFy2ga1j93ZFqw4Ikw40
	qas8tryfA34UKaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/4/30 18:09, Jan Kara wrote:
> On Wed 30-04-25 16:44:25, Zhang Yi wrote:
>> On 2025/4/30 16:18, Jan Kara wrote:
>>> On Wed 30-04-25 09:12:59, Zhang Yi wrote:
>>>> From: Zhang Yi <yi.zhang@huawei.com>
>>>>
>>>> For the extents inodes, the maxbytes should be sb->s_maxbytes instead of
>>>> sbi->s_bitmap_maxbytes. Correct the maxbytes value to correct the
>>>> behavior of punch hole.
>>>>
>>>> Fixes: 2da376228a24 ("ext4: limit length to bitmap_maxbytes - blocksize in punch_hole")
>>>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>>>
>>> Thinking about this some more...
>>>
>>>> @@ -4015,6 +4015,12 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>>>>  	trace_ext4_punch_hole(inode, offset, length, 0);
>>>>  	WARN_ON_ONCE(!inode_is_locked(inode));
>>>>  
>>>> +	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
>>>> +		max_end = sb->s_maxbytes;
>>>> +	else
>>>> +		max_end = EXT4_SB(sb)->s_bitmap_maxbytes;
>>>> +	max_end -= sb->s_blocksize;
>>>
>>> I think the -= sb->s_blocksize is needed only for indirect-block based
>>> scheme (due to an implementation quirk in ext4_ind_remove_space()). But
>>> ext4_ext_remove_space() should be fine with punch hole ending right at
>>> sb->s_maxbytes. And since I find it somewhat odd that you can create file
>>> upto s_maxbytes but cannot punch hole to the end, it'd limit that behavior
>>> as much as possible. Ideally we'd fix ext4_ind_remove_space() but I can't
>>> be really bothered for the ancient format...
>>>
>>
>> Yes, I share your feelings. Currently, we do not seem to have any
>> practical issues. To maintain consistent behavior between the two inode
>> types and to keep the code simple, I retained the -= sb->s_blocksize
>> operation. Would you suggest that we should at least address the extents
>> inodes by removing the -=sb->s_blocksize now?
> 
> Yes, what I'm suggesting is that we keep -=sb->s_blocksize specific for the
> case !ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS).
> 

Sure. Let's do it.

Thanks,
Yi.



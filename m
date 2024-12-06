Return-Path: <linux-fsdevel+bounces-36613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF469E6898
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 09:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D29E1686AB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 08:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872B41DF274;
	Fri,  6 Dec 2024 08:13:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BDC1D90B6;
	Fri,  6 Dec 2024 08:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733472805; cv=none; b=Q2Vww0R2yTdpSQenILE9kPRvk02bnAnmzmRScFkVd/g3tGHHZ3MH98Qg5KJcdPWPoITbvjo6TZkyfTY88wTos74jhfUng42j1aqqSc4Ygeo4QJuCVxUxYOG27FOWmHXy8CnDilO/mQ2cZkbrqSk7mRrPlIuEoYZcvC70JRMosec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733472805; c=relaxed/simple;
	bh=4gH76F3z/S8h4gBs3jqgD7UA9E+zfYeMzGechFnhMng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t+uzqHhiMaagN8LFB8s7rpWqyPUfxWlf/G/1qZxTL6nJlSi8PoLHVVfYOXaOHc5z/ISyTwtvRC4+yAy1H/EARvxvR+MlnHi1P2miCM/B0h5DwgLBB1NwIN5Q21+tmvq8JR8PD8PGGqogfIiescnRTb9x7zSGawHfh5JfKBruPDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Y4PC26DJsz4f3jq4;
	Fri,  6 Dec 2024 16:13:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DF6F41A0196;
	Fri,  6 Dec 2024 16:13:16 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgCHYoYaslJnY_s9Dw--.20633S3;
	Fri, 06 Dec 2024 16:13:16 +0800 (CST)
Message-ID: <792da260-656c-4e05-9d06-90580927bc20@huaweicloud.com>
Date: Fri, 6 Dec 2024 16:13:14 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/27] ext4: move out inode_lock into ext4_fallocate()
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 ritesh.list@gmail.com, hch@infradead.org, djwong@kernel.org,
 david@fromorbit.com, zokeefe@google.com, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
References: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
 <20241022111059.2566137-10-yi.zhang@huaweicloud.com>
 <20241204120527.jus6ymhsddxhlqjz@quack3>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20241204120527.jus6ymhsddxhlqjz@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCHYoYaslJnY_s9Dw--.20633S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KF48KF15Zw47XFWxJr1DJrb_yoW8JFy7pF
	Z5Jay8KF48WF9rGF1vvFs8ZFnYyw4DKr4UXrW8ua4ku3Zxur17KF15KF1UC3Z0yr48Cr40
	vF4Utry7u3W5A37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	0PfPUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/12/4 20:05, Jan Kara wrote:
> On Tue 22-10-24 19:10:40, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Currently, all five sub-functions of ext4_fallocate() acquire the
>> inode's i_rwsem at the beginning and release it before exiting. This
>> process can be simplified by factoring out the management of i_rwsem
>> into the ext4_fallocate() function.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> Ah, nice. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> and please ignore my comments about renaming 'out' labels :).
> 
> 								Honza
> 

...

>> @@ -4774,9 +4765,8 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>>  
>>  	inode_lock(inode);
>>  	ret = ext4_convert_inline_data(inode);
>> -	inode_unlock(inode);
>>  	if (ret)
>> -		return ret;
>> +		goto out;
>>  
>>  	if (mode & FALLOC_FL_PUNCH_HOLE)
>>  		ret = ext4_punch_hole(file, offset, len);
>> @@ -4788,7 +4778,8 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>>  		ret = ext4_zero_range(file, offset, len, mode);
>>  	else
>>  		ret = ext4_do_fallocate(file, offset, len, mode);
>> -
>> +out:
>> +	inode_unlock(inode);
>>  	return ret;
>>  }
>>  

I guess you may want to suggest rename this out to out_inode_lock as well.

Thanks,
Yi.




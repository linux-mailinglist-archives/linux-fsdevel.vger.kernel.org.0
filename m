Return-Path: <linux-fsdevel+bounces-48474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 379E7AAF9A0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 14:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 125E94C53D2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 12:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248CB22688B;
	Thu,  8 May 2025 12:17:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5C01DF25C;
	Thu,  8 May 2025 12:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746706650; cv=none; b=h+1XRrkUJuwDGHI0RyMtuUuTBIyb0I3H6YGCoGlzWCGooK2dsfjxhqmhsXEn/9MlWq/aUSpHpHh9F77TG9o4xd+sGFMI223jIk6PTBYlyyym/4HB22YxxUU0JXZJjAnZSHjdj3CunW0ZMFV5a/3EniBuzx4hGrbC0SQCDe2sdjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746706650; c=relaxed/simple;
	bh=7xiyatHuEYO5siH784i+66R6gDk//PcjZEueVmEeyvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FFfBF6u0J0thAeMNIaUgD7DmEwnGOk+zJb1u+E9v7Gu4Mu932+SvZIyNm+BjexwkSF2OKhOTV1YtNKNP9QIwaJZZc8TYMofOSZiQwQ0RlIm3vQgnocSsjDxOv/UVfiTfDYr9ZnwkSMHCpvDeZX0jdMdolV5zWNdP2WWO8FLslTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4ZtWNH1XsWzYQtwc;
	Thu,  8 May 2025 20:17:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 86C091A1A7E;
	Thu,  8 May 2025 20:17:18 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgDnSl_KoBxoXus0Lw--.707S3;
	Thu, 08 May 2025 20:17:16 +0800 (CST)
Message-ID: <68172a9e-cf68-4962-8229-68e283e894e1@huaweicloud.com>
Date: Thu, 8 May 2025 20:17:14 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 07/11] fs: statx add write zeroes unmap attribute
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, john.g.garry@oracle.com,
 bmarzins@redhat.com, chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com,
 brauner@kernel.org, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com, yangerkun@huawei.com
References: <20250421021509.2366003-1-yi.zhang@huaweicloud.com>
 <20250421021509.2366003-8-yi.zhang@huaweicloud.com>
 <20250505132208.GA22182@lst.de> <20250505142945.GJ1035866@frogsfrogsfrogs>
 <c7d8d0c3-7efa-4ee6-b518-f8b09ec87b73@huaweicloud.com>
 <20250506043907.GA27061@lst.de>
 <64c8b62a-83ba-45be-a83e-62b6ad8d6f22@huaweicloud.com>
 <20250506121102.GA21905@lst.de>
 <a39a6612-89ac-4255-b737-37c7d16b3185@huaweicloud.com>
 <20250508050147.GA26916@lst.de>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250508050147.GA26916@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnSl_KoBxoXus0Lw--.707S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXF43ZFW3Zry3Aw48Kw1xKrg_yoWrtrWDpF
	W8WF1jkF4DKr13Cw1v9w4Igrn0vFs3AF15C39Ykr48Cw45XF13KFnaga40yF9rXryxZayD
	tFZ0kFyUZa1Iy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/5/8 13:01, Christoph Hellwig wrote:
> On Wed, May 07, 2025 at 03:33:23PM +0800, Zhang Yi wrote:
>> On 2025/5/6 20:11, Christoph Hellwig wrote:
>>> On Tue, May 06, 2025 at 07:16:56PM +0800, Zhang Yi wrote:
>>>> Sorry, but I don't understand your suggestion. The
>>>> STATX_ATTR_WRITE_ZEROES_UNMAP attribute only indicate whether the bdev
>>>> and the block device that under the specified file support unmap write
>>>> zeroes commoand. It does not reflect whether the bdev and the
>>>> filesystems support FALLOC_FL_WRITE_ZEROES. The implementation of
>>>> FALLOC_FL_WRITE_ZEROES doesn't fully rely on the unmap write zeroes
>>>> commoand now, users simply refer to this attribute flag to determine
>>>> whether to use FALLOC_FL_WRITE_ZEROES when preallocating a file.
>>>> So, STATX_ATTR_WRITE_ZEROES_UNMAP and FALLOC_FL_WRITE_ZEROES doesn't
>>>> have strong relations, why do you suggested to put this into the ext4
>>>> and bdev patches that adding FALLOC_FL_WRITE_ZEROES?
>>>
>>> So what is the point of STATX_ATTR_WRITE_ZEROES_UNMAP?
>>
>> My idea is not to strictly limiting the use of FALLOC_FL_WRITE_ZEROES to
>> only bdev or files where bdev_unmap_write_zeroes() returns true. In
>> other words, STATX_ATTR_WRITE_ZEROES_UNMAP and FALLOC_FL_WRITE_ZEROES
>> are not consistent, they are two independent features. Even if some
>> devices STATX_ATTR_WRITE_ZEROES_UNMAP are not set, users should still be
>> allowed to call fallcoate(FALLOC_FL_WRITE_ZEROES). This is because some
>> devices and drivers currently cannot reliably ascertain whether they
>> support the unmap write zero command; however, certain devices, such as
>> specific cloud storage devices, do support it. Users of these devices
>> may also wish to use FALLOC_FL_WRITE_ZEROES to expedite the zeroing
>> process.
> 
> What are those "cloud storage devices" where you set it reliably,
> i.e.g what drivers?

I don't have these 'cloud storage devices' now, but Ted had mentioned
those cloud-emulated block devices such as Google's Persistent Desk or
Amazon's Elastic Block Device in. I'm not sure if they can accurately
report the BLK_FEAT_WRITE_ZEROES_UNMAP feature, maybe Ted can give more
details.

https://lore.kernel.org/linux-fsdevel/20250106161732.GG1284777@mit.edu/

> 
>> Therefore, I think that the current point of
>> STATX_ATTR_WRITE_ZEROES_UNMAP (possibly STATX_WRITE_ZEROES_UNMAP) should
>> be to just indicate whether a bdev or file supports the unmap write zero
>> command (i.e., whether bdev_unmap_write_zeroes() returns true). If we
>> use standard SCSI and NVMe storage devices, and the
>> STATX_ATTR_WRITE_ZEROES_UNMAP attribute is set, users can be assured
>> that FALLOC_FL_WRITE_ZEROES is fast and can choose to use
>> fallocate(FALLOC_FL_WRITE_ZEROES) immediately.
> 
> That's breaking the abstracton again.  An attribute must say something
> about the specific file, not about some underlying semi-related feature.

OK.

> 
>> Would you prefer to make STATX_ATTR_WRITE_ZEROES_UNMAP and
>> FALLOC_FL_WRITE_ZEROES consistent, which means
>> fallcoate(FALLOC_FL_WRITE_ZEROES) will return -EOPNOTSUPP if the block
>> device doesn't set STATX_ATTR_WRITE_ZEROES_UNMAP ?
> 
> Not sure where the block device comes from here, both of these operate
> on a file.

I am referring to the block device on which the filesystem is mounted.
The support status of the file is directly dependent on this block
device.

> 
>> If so, I'd suggested we need to:
>> 1) Remove STATX_ATTR_WRITE_ZEROES_UNMAP since users can check the
>>    existence by calling fallocate(FALLOC_FL_WRITE_ZEROES) directly, this
>>    statx flag seems useless.
> 
> Yes, that was my inital thought.
> 
>> 2) Make the BLK_FEAT_WRITE_ZEROES_UNMAP sysfs interface to RW, allowing
>>    users to adjust the block device's support state according to the
>>    real situation.
> 
> No, it's a feature and not a flag.
> 

I am a bit confused about the feature and the flag, I checked the other
features, and it appears that features such as BLK_FEAT_ROTATIONAL allow
to be modified, is this flexibility due to historical reasons or for the
convenience of testing?

Think about this again, I suppose we should keep the
BLK_FEAT_WRITE_ZEROES_UNMAP as read-only and add a new flag,
BLK_FALG_WRITE_ZEROES_UNMAP_DISABLED, to disable the
FALLOC_FL_WRITE_ZEROES. Since the Write Zeroes does not guarantee
performance, and some devices may claim to support **UNMAP** Write Zeroes
but exhibit extremely slow write-zeroes speeds. Users may want be able to
disable it. Thoughts？

Thanks,
Yi.



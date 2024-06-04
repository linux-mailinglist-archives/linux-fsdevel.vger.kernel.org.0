Return-Path: <linux-fsdevel+bounces-20914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1CD8FAB91
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 09:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FA2D1F25F00
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 07:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F768140374;
	Tue,  4 Jun 2024 07:09:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4959C2209B;
	Tue,  4 Jun 2024 07:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717484956; cv=none; b=f5eCi6NDobIXXV4u2W5RH4DFIuX3UVGQpbcOiatmceKt0zflf0w0bkoPlQrC8zP0qGU7GEhzKJNe9PIJrQudMZTL8xK0Ft70+ZJXHHgOEquVTHudOdBerzzSnpvzKksrTKYiBHW/9GguMTk5dTvuyhC/hCDOP+6ZTdD+qQ8iZk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717484956; c=relaxed/simple;
	bh=4iq3XeNrs7ltIrmz0ZFJGziDx9dE933s9OG2qHDTALw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VggV+qJ3AerzTMhbuKMzulihhSaFJCL5QLh8Q4yc7AvxgM6f1/8REyOiu3htxKTUuVn6Di+BnpRFrUsIVykGMy//ctrkG6F6sPQOQQsLwblDjFVYXUf0LvUojF9p9HJsdU3WAw8RwVqF6weGdBZPBYO8QMpwT2Kx1i2Ve0ljLHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VthXQ1B46z4f3jJ3;
	Tue,  4 Jun 2024 15:08:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id BF0101A0185;
	Tue,  4 Jun 2024 15:09:03 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgC32w6NvV5mPr6ROw--.1471S3;
	Tue, 04 Jun 2024 15:09:03 +0800 (CST)
Subject: Re: [RFC PATCH v4 8/8] xfs: improve truncate on a realtime inode with
 huge extsize
To: "Darrick J. Wong" <djwong@kernel.org>,
 Christoph Hellwig <hch@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, brauner@kernel.org, david@fromorbit.com,
 chandanbabu@kernel.org, jack@suse.cz, willy@infradead.org,
 yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
References: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
 <20240529095206.2568162-9-yi.zhang@huaweicloud.com>
 <ZlnUorFO2Ptz5gcq@infradead.org> <20240531141210.GI52987@frogsfrogsfrogs>
 <Zlnbht9rCiv-d2un@infradead.org> <20240531150016.GL52987@frogsfrogsfrogs>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <7b7d8062-65c3-9659-230a-bc8dea4785f6@huaweicloud.com>
Date: Tue, 4 Jun 2024 15:09:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240531150016.GL52987@frogsfrogsfrogs>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgC32w6NvV5mPr6ROw--.1471S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AF4Utw1rGrWxurWftryxXwb_yoW8CFyrpF
	WUtF9rKr4vy34DX392qr47X3WYqrn3JaySv34FqrW0kFnxu3yayrn3trW5Jws0qFs3J340
	v395t34fJr9YqrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/5/31 23:00, Darrick J. Wong wrote:
> On Fri, May 31, 2024 at 07:15:34AM -0700, Christoph Hellwig wrote:
>> On Fri, May 31, 2024 at 07:12:10AM -0700, Darrick J. Wong wrote:
>>> There are <cough> some users that want 1G extents.
>>>
>>> For the rest of us who don't live in the stratosphere, it's convenient
>>> for fsdax to have rt extents that match the PMD size, which could be
>>> large on arm64 (e.g. 512M, or two smr sectors).
>>
>> That's fine.  Maybe to rephrase my question.  With this series we
>> have 3 different truncate path:
>>
>>  1) unmap all blocks (!rt || rtextsizse == 1)
>>  2) zero leftover blocks in an rtextent (small rtextsize, but > 1)
>>  3) converted leftover block in an rtextent to unwritten (large
>>    rtextsize)
>>
>> What is the right threshold to switch between 2 and 3?  And do we
>> really need 2) at all?
> 
> I don't think we need (2) at all.
> 
> There's likely some threshold below where it's a wash -- compare with
> ext4 strategy of trying to write 64k chunks even if that requires
> zeroing pagecache to cut down on fragmentation on hdds -- but I don't
> know if we care anymore. ;)
> 

I supplemented some tests for small > 1 rtextsizes on my ramdisk,

  mkfs.xfs -f -m reflink=0,rmapbt=0, -d rtinherit=1 \
           -r rtdev=/dev/pmem1s,extsize=$rtextsize /dev/pmem2s
  mount -ortdev=/dev/pmem1s /dev/pmem2s /mnt/scratch
  for i in {1..1000}; \
  do dd if=/dev/zero of=/mnt/scratch/$i bs=$rtextsize count=1; done
  sync
  time for i in {1..1000}; \
  do xfs_io -c "truncate 4k" /mnt/scratch/$i; done

rtextsize            8k      16k      32k      64k     256k     1024k
zero out:          9.601s  10.229s  11.153s  12.086s  12.259s  20.141s
convert unwritten: 9.710s   9.642s   9.958s   9.441s  10.021s  10.526s

The test showed that there is no much difference between (2) and (3)
with small rtextsize, but if the size gets progressively larger, (3)
will be better, so I agree with you that we could just drop (2) for
rt device.

Thanks,
Yi.



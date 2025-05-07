Return-Path: <linux-fsdevel+bounces-48333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A201AADA0E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 10:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3AAE4E5DE2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 08:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52AF221DBA;
	Wed,  7 May 2025 08:23:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC6B221287;
	Wed,  7 May 2025 08:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746606195; cv=none; b=KzFhqhaSUrqQMJoK/r1qxQ2VTpc/Fi8RDxhHqJqkCClH+QDVNONXTdMUQYnBRJH0/ns0i9+MVJQw/lzIWJehppvnYA3PBLkk6tSf2cVAhk8p5Zdby7wLHIDORnjQwMJmhC2K42vJ2mzwgRdiKYqTCSEDo2sLnOCX1xXAt6lHFmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746606195; c=relaxed/simple;
	bh=dKQSYssCqjab+VThR2A6t9EL5/fdsI5w0NftenKqgO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ibWIb95PO3EaJJ/ByiG3lHgsKX15j1qGqKZaC6Dc4LKEDm/jpb38ip7Lkg/HFIzkJ0LX9mApPhyOL4ZVg3PloSyxrne0uuvQKjJaLcEEaom6lCYY1wQjBO+attNr0xXVFuOZrC4byyMXm1Zm86HoDCfW6j7r2CewVNK0dMfY4MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZspD501PTz4f3jXv;
	Wed,  7 May 2025 16:22:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 7419B1A018C;
	Wed,  7 May 2025 16:23:09 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP1 (Coremail) with SMTP id cCh0CgAXfHxqGBto+dv_LQ--.31348S3;
	Wed, 07 May 2025 16:23:08 +0800 (CST)
Message-ID: <6fc62631-fb6f-4207-badb-1964b20fa89a@huaweicloud.com>
Date: Wed, 7 May 2025 16:23:06 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 07/11] fs: statx add write zeroes unmap attribute
To: "Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: dhowells@redhat.com, brauner@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, john.g.garry@oracle.com,
 bmarzins@redhat.com, chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com,
 yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
 yangerkun@huawei.com
References: <20250421021509.2366003-1-yi.zhang@huaweicloud.com>
 <20250421021509.2366003-8-yi.zhang@huaweicloud.com>
 <20250505132208.GA22182@lst.de> <20250505142945.GJ1035866@frogsfrogsfrogs>
 <20250506050239.GA27687@lst.de> <20250506053654.GA25700@frogsfrogsfrogs>
 <20250506054722.GA28781@lst.de>
 <c3105509-9d63-4fa2-afaf-5b508ddeeaca@huaweicloud.com>
 <20250506121012.GA21705@lst.de> <20250506155515.GL1035866@frogsfrogsfrogs>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250506155515.GL1035866@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgAXfHxqGBto+dv_LQ--.31348S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uw1ktr18Gr17CFy8Kw48Zwb_yoW8CFWDpF
	WjgF4UGFWUKry3Jw1kuw1Igr15ZFn5GFy3C39Ykr18Zws0qr1kKF95W3ZYkF9ruryrAa1U
	ta9xK3sxWws3A37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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

On 2025/5/6 23:55, Darrick J. Wong wrote:
> On Tue, May 06, 2025 at 02:10:12PM +0200, Christoph Hellwig wrote:
>> On Tue, May 06, 2025 at 07:25:06PM +0800, Zhang Yi wrote:
>>> +       if (request_mask & STATX_WRITE_ZEROES_UNMAP &&
>>> +           bdev_write_zeroes_unmap(bdev))
>>> +               stat->result_mask |= STATX_WRITE_ZEROES_UNMAP;
>>
>> That would be my expectation.  But then again this area seems to
>> confuse me a lot, so maybe we'll get Christian or Dave to chim in.
> 
> Um... does STATX_WRITE_ZEROES_UNMAP protect a field somewhere?
> It might be nice to expose the request alignment granularity/max
> size/etc.

I think that simply returning the support state is sufficient at the
moment. __blkdev_issue_write_zeroes() will send write zeroes through
multiple iterations, and there are no specific restrictions on the
parameters provided by users.

> Or does this flag exist solely to support discovering that
> FALLOC_FL_WRITE_ZEROES is supported?  In which case, why not discover
> its existence by calling fallocate(fd, WRITE_ZEROES, 0, 0) like the
> other modes?
> 

Current STATX_WRITE_ZEROES_UNMAP and FALLOC_FL_WRITE_ZEROES are
inconsistent, we allow users to call fallocate(FALLOC_FL_WRITE_ZEROES) on
files that STATX_WRITE_ZEROES_UNMAP is not set. Users can check whether
the device supports unmap write zeroes through STATX_WRITE_ZEROES_UNMAP
and then decide to call fallocate(FALLOC_FL_WRITE_ZEROES) if it is
supported. Please see this explanation for details.

  https://lore.kernel.org/linux-fsdevel/20250421021509.2366003-1-yi.zhang@huaweicloud.com/T/#mc1618822bc27d486296216fc1643d5531fee03e1

However, removing STATX_WRITE_ZEROES_UNMAP also seems good to me(Perhaps
it would be better.).It means we do not allow to call
fallocate(FALLOC_FL_WRITE_ZEROES) if the device does not explicitly
support unmap write zeroes.

Thanks,
Yi.



Return-Path: <linux-fsdevel+bounces-48225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2859AAC27E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 13:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E83DF3B8BB1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 11:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4905027AC39;
	Tue,  6 May 2025 11:25:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9BB277021;
	Tue,  6 May 2025 11:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746530713; cv=none; b=EBlpECZN2/bM5Lbi10xw8fAcnlDPfy3nuexXmzRb2jNtTucg8ldd3suvRunOn6Y0hHhhL6Q1245gLJTHSoMDqlquVb3nEr1ZEmCCWAlTgylcmwQzWC8QP6fMSfj4Hf8zZtGxxnC6Hwb+ECWR+ZfwGBBqAMndgQIfsO9dGbJPh/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746530713; c=relaxed/simple;
	bh=LYEoDqW9Aw3HirRWc3fZPPqmXKbhw5VH1R/eJ7s7ey0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DbaBIHPJLzFbldzhHAqlBiBjSiWaKpArC6BKQDNIJYQ4+Kzlr0I6qBUl0rxqjB8vC5YvAOPZi2kDUmXL2eucqao6UKj0Vk/IohWmvbSaYh/v2jdLkdg9lwlIXiiPljz3toxtkcuirU+D4aPbHYLh4lRgo+aKmEBeGshUfzZ1R9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4ZsGK03YjSzYQv9t;
	Tue,  6 May 2025 19:25:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D0A9F1A1041;
	Tue,  6 May 2025 19:25:07 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgD3Wl+S8RlowhVpLg--.31381S3;
	Tue, 06 May 2025 19:25:07 +0800 (CST)
Message-ID: <c3105509-9d63-4fa2-afaf-5b508ddeeaca@huaweicloud.com>
Date: Tue, 6 May 2025 19:25:06 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 07/11] fs: statx add write zeroes unmap attribute
To: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 john.g.garry@oracle.com, bmarzins@redhat.com, chaitanyak@nvidia.com,
 shinichiro.kawasaki@wdc.com, brauner@kernel.org, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
References: <20250421021509.2366003-1-yi.zhang@huaweicloud.com>
 <20250421021509.2366003-8-yi.zhang@huaweicloud.com>
 <20250505132208.GA22182@lst.de> <20250505142945.GJ1035866@frogsfrogsfrogs>
 <20250506050239.GA27687@lst.de> <20250506053654.GA25700@frogsfrogsfrogs>
 <20250506054722.GA28781@lst.de>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250506054722.GA28781@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgD3Wl+S8RlowhVpLg--.31381S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tr4rXrW8WF4fKryrZw43ZFb_yoW8GF47pF
	WkCFyIkr4IkF47Ga1kZw1Ivr1Y9rn7JFy7C3s5Kr12yay2qrn7uFn5Ca42kFnaqr93uw4Y
	qFZxX342va1093DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	j7l19UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/5/6 13:47, Christoph Hellwig wrote:
> On Mon, May 05, 2025 at 10:36:54PM -0700, Darrick J. Wong wrote:
>> I think STATX_* (i.e. not STATX_ATTR_*) flags have two purposes: 1) to
>> declare that specific fields in struct statx actually have meaning, most
>> notably in scenarios where zeroes are valid field contents; and 2) if
>> filling out the field is expensive, userspace can elect not to have it
>> filled by leaving the bit unset.  I don't know how userspace is supposed
>> to figure out which fields are expensive.
> 
> Yes.
> 

IIUC, it seems I was misled by STATX_ATTR_WRITE_ATOMIC, adding this
STATX_ATTR_WRITE_ZEROES_UNMAP attribute flag is incorrect. The right
approach should be to add STATX_WRITE_ZEROES_UNMAP, setting it in the
result_mask if the request_mask includes this flag and
bdev_write_zeroes_unmap(bdev) returns true. Something like below. Is
my understanding right?

diff --git a/block/bdev.c b/block/bdev.c
index 4ba48b8735e7..e1367f30dbce 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1303,9 +1303,9 @@ void bdev_statx(const struct path *path, struct kstat *stat, u32 request_mask)
                        queue_atomic_write_unit_max_bytes(bd_queue));
        }

+       if (request_mask & STATX_WRITE_ZEROES_UNMAP &&
+           bdev_write_zeroes_unmap(bdev))
+               stat->result_mask |= STATX_WRITE_ZEROES_UNMAP;

        stat->blksize = bdev_io_min(bdev);

Thanks,
Yi.



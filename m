Return-Path: <linux-fsdevel+bounces-48331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 100EAAAD834
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 09:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E9E84E0FE4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 07:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0546121D00D;
	Wed,  7 May 2025 07:33:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534434414;
	Wed,  7 May 2025 07:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746603211; cv=none; b=mlff8vOTQorREuzqsgpKd4ClgJhwN4mvDC8ddV2wz3Ukva7D6FaZmGSB9g+kQ8gNJWX/rohoBbKbNI+bC8KWmFEAnbDbhNi/w3fITpPqfZiGPUVz7PjTM+mGqQVgv99tcvgAxNX0VjlSKkNH479/k0b+srFTLNqSHifpdLawNy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746603211; c=relaxed/simple;
	bh=yvE7hHuhZtqAdLiuiqL4X1jVqwVu03bNZyPR+Wo5Xtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gtFxrZ2F88qyLfCGV9e2lEeQMuG7dp0JmZMG5BS2f8fyy63RFaydiGU4cn3f0URejloJB58OfBuc7UVTfEEurt4G6iPsYlWJPDCn22vYuTOPyPZzzIbuchzYKRSDld+E63vuWHrbl7HheRUihgLWOZJFBhQn8relzk4hxUe3wL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zsn6g5Q4Sz4f3l26;
	Wed,  7 May 2025 15:32:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id AC97A1A1912;
	Wed,  7 May 2025 15:33:25 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgDX32LDDBtoLblhLg--.26256S3;
	Wed, 07 May 2025 15:33:25 +0800 (CST)
Message-ID: <a39a6612-89ac-4255-b737-37c7d16b3185@huaweicloud.com>
Date: Wed, 7 May 2025 15:33:23 +0800
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
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250506121102.GA21905@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgDX32LDDBtoLblhLg--.26256S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAFWkXw47uF13ZF4UWFWrGrg_yoW5WrWxpF
	W0gFyjkF4DKr13J3s5uw40grn5ZFs5AF15Cw4vkr18uw45XF1xKFn8W3WvyFyDJry7AayD
	JFZ0kFyUZa1xC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 2025/5/6 20:11, Christoph Hellwig wrote:
> On Tue, May 06, 2025 at 07:16:56PM +0800, Zhang Yi wrote:
>> Sorry, but I don't understand your suggestion. The
>> STATX_ATTR_WRITE_ZEROES_UNMAP attribute only indicate whether the bdev
>> and the block device that under the specified file support unmap write
>> zeroes commoand. It does not reflect whether the bdev and the
>> filesystems support FALLOC_FL_WRITE_ZEROES. The implementation of
>> FALLOC_FL_WRITE_ZEROES doesn't fully rely on the unmap write zeroes
>> commoand now, users simply refer to this attribute flag to determine
>> whether to use FALLOC_FL_WRITE_ZEROES when preallocating a file.
>> So, STATX_ATTR_WRITE_ZEROES_UNMAP and FALLOC_FL_WRITE_ZEROES doesn't
>> have strong relations, why do you suggested to put this into the ext4
>> and bdev patches that adding FALLOC_FL_WRITE_ZEROES?
> 
> So what is the point of STATX_ATTR_WRITE_ZEROES_UNMAP?

My idea is not to strictly limiting the use of FALLOC_FL_WRITE_ZEROES to
only bdev or files where bdev_unmap_write_zeroes() returns true. In
other words, STATX_ATTR_WRITE_ZEROES_UNMAP and FALLOC_FL_WRITE_ZEROES
are not consistent, they are two independent features. Even if some
devices STATX_ATTR_WRITE_ZEROES_UNMAP are not set, users should still be
allowed to call fallcoate(FALLOC_FL_WRITE_ZEROES). This is because some
devices and drivers currently cannot reliably ascertain whether they
support the unmap write zero command; however, certain devices, such as
specific cloud storage devices, do support it. Users of these devices
may also wish to use FALLOC_FL_WRITE_ZEROES to expedite the zeroing
process.

Therefore, I think that the current point of
STATX_ATTR_WRITE_ZEROES_UNMAP (possibly STATX_WRITE_ZEROES_UNMAP) should
be to just indicate whether a bdev or file supports the unmap write zero
command (i.e., whether bdev_unmap_write_zeroes() returns true). If we
use standard SCSI and NVMe storage devices, and the
STATX_ATTR_WRITE_ZEROES_UNMAP attribute is set, users can be assured
that FALLOC_FL_WRITE_ZEROES is fast and can choose to use
fallocate(FALLOC_FL_WRITE_ZEROES) immediately.

Would you prefer to make STATX_ATTR_WRITE_ZEROES_UNMAP and
FALLOC_FL_WRITE_ZEROES consistent, which means
fallcoate(FALLOC_FL_WRITE_ZEROES) will return -EOPNOTSUPP if the block
device doesn't set STATX_ATTR_WRITE_ZEROES_UNMAP ?

If so, I'd suggested we need to:
1) Remove STATX_ATTR_WRITE_ZEROES_UNMAP since users can check the
   existence by calling fallocate(FALLOC_FL_WRITE_ZEROES) directly, this
   statx flag seems useless.
2) Make the BLK_FEAT_WRITE_ZEROES_UNMAP sysfs interface to RW, allowing
   users to adjust the block device's support state according to the
   real situation.

Thanks,
Yi.



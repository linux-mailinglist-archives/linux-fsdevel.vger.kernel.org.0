Return-Path: <linux-fsdevel+bounces-38558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63429A03D93
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 12:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69331885084
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 11:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82AB1F236C;
	Tue,  7 Jan 2025 11:23:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301121EC013;
	Tue,  7 Jan 2025 11:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736248983; cv=none; b=OkJiKPDi2ISn2+549fR5F4gP6fFpuqzrFM1xC19JsBf64yrZFgSx+YTRsPpAqcjQKU7JpV5hqjeFAPJBq/mziAJcRU6f/LAqtF3/TVUUHvncfFnRVXFnqnjq9E37J3A8J+VYsuc3EX1LbrHUyf/ifVK/uvXZOvy8kyfikTH42hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736248983; c=relaxed/simple;
	bh=n/Px38k0FTwpHO1WE6onLWdX94BYQFfzAitPJXOsIBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qQC9MmHiD2HXPk/gxo8dCNERxns3nOaiGZxVcy2Dex++xzPFcIhZUcRZ3kipiG1tSfPczP/dFJXXUEDl0QroXxG2DFKHu3//57/a68DeHbRy6qmbq8slTjXFz69RO4vtDVMF/cN/+n5fvE2MMl4fc9qlL1/4Xym18htVqhD+SKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YS7v23Xvqz4f3jqL;
	Tue,  7 Jan 2025 19:22:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 728F81A094E;
	Tue,  7 Jan 2025 19:22:53 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgB321+LDn1nJtUoAQ--.45317S3;
	Tue, 07 Jan 2025 19:22:53 +0800 (CST)
Message-ID: <d8e93ca9-6c68-436d-8d8b-5320ab0f803a@huaweicloud.com>
Date: Tue, 7 Jan 2025 19:22:50 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] fs: introduce FALLOC_FL_FORCE_ZERO to fallocate
To: Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, djwong@kernel.org, adilger.kernel@dilger.ca,
 yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
 yangerkun@huawei.com, Sai Chaitanya Mitta <mittachaitu@gmail.com>,
 linux-xfs@vger.kernel.org
References: <20241228014522.2395187-1-yi.zhang@huaweicloud.com>
 <20241228014522.2395187-2-yi.zhang@huaweicloud.com>
 <Z3u-OCX86j-q7JXo@infradead.org> <20250106161732.GG1284777@mit.edu>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250106161732.GG1284777@mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgB321+LDn1nJtUoAQ--.45317S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCr43Gw1Utr4UArWktryDAwb_yoWrJF4rpa
	y8WFs2ka95Kr1xGwn7Z3yDCF4rCwsYy3y3GFyYgrW2yr98WF1Ikr4fKF1YkFyxXrn3Xa4j
	qr4Y9ry3C3Z8ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	aFAJUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/1/7 0:17, Theodore Ts'o wrote:
> On Mon, Jan 06, 2025 at 03:27:52AM -0800, Christoph Hellwig wrote:
>> There's a feature request for something similar on the xfs list, so
>> I guess people are asking for it.
> 
> Yeah, I have folks asking for this on the ext4 side as well.
> 
> The one caution that I've given to them is that there is no guarantee
> what the performance will be for WRITE SAME or equivalent operations,
> since the standards documents state that performance is out of scope
> for the document.  So in some cases, WRITE SAME might be fast (if for
> example it is just adjusing FTL metadata on an SSD, or some similar
> thing on cloud-emulated block devices such as Google's Persistent Desk
> or Amazon's Elastic Block Device --- what Darrick has called "software
> defined storage" for the cloud), but in other hardware deployments,
> WRITE SAME might be as slow as writing zeros to an HDD.
> 
> This is technically not the kernel's problem, since we can also use
> the same mealy-mouth "performance is out of scope and not the kernel's
> concern", but that just transfers the problem to the application
> programmers.  I could imagine some kind of tunable which we can make
> the block device pretend that it really doesn't support using WRITE
> SAME if the performance characteristics are such that it's a Bad Idea
> to use it, so that there's a single tunable knob that the system
> adminstrator can reach for as opposed to have different ways for
> PostgresQL, MySQL, Oracle Enterprise Database, etc have for
> configuring whether or not to disable WRITE SAME, but that's not
> something we need to decide right away.

Yes, I completely agree with you. At this time, it is not possible to
determine whether a disk supports fast write zeros only by checking if
the disk supports the write_zero command. Especially for some HDDs,
which should submit actual zeros to the disk even if they claim to
support the write_zero command, but that is very slow.

Therefore, I propose that we add a new feature flag, such as
BLK_FEAT_FAST_WRITE_ZERO, to queue->limits.features. This flag should
be set by each disk driver if the attached disk supports fast write
zeros. For instance, the NVMe SSD driver should set this flag if the
given namespace supports NVME_NS_DEAC. Additionally, we can add an
entry in sysfs that allows the user to enable and disable this feature
manually when the driver don't know the whether the disk supports it
or not for some corner cases.

> 
>> That being said this really should not be a modifier but a separate
>> operation, as the logic is very different from FALLOC_FL_ZERO_RANGE,
>> similar to how plain prealloc, hole punch and zero range are different
>> operations despite all of them resulting in reads of zeroes from the
>> range.
> 
> Yes.  And we might decide that it should be done using some kind of
> ioctl, such as BLKDISCARD, as opposed to a new fallocate operation,
> since it really isn't a filesystem metadata operation, just as
> BLKDISARD isn't.  The other side of the argument is that ioctls are
> ugly, and maybe all new such operations should be plumbed through via
> fallocate as opposed to adding a new ioctl.  I don't have strong
> feelings on this, although I *do* belive that whatever interface we
> use, whether it be fallocate or ioctl, it should be supported by block
> devices and files in a file system, to make life easier for those
> databases that want to support running on a raw block device (for
> full-page advertisements on the back cover of the Businessweek
> magazine) or on files (which is how 99.9% of all real-world users
> actually run enterprise databases.  :-)
> 

For this part, I still think it would be better to use fallocate.

Thanks,
Yi.




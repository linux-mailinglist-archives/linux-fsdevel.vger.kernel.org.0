Return-Path: <linux-fsdevel+bounces-51830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E15CCADBF25
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 04:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A2E91890031
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 02:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225A723771C;
	Tue, 17 Jun 2025 02:25:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C23523506E;
	Tue, 17 Jun 2025 02:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750127122; cv=none; b=jutBx0zxfLTM3qNPq16NLRabFq+bsn6BP74Ht9M+qpDr+VgDPtJ/5+ArOxyqwPNdflUZZoQksf2bSbT03jV+KZ7Q8fd6PYARfIG8EIUudw6f1NFndQMZL6ktctOWqEW9ml4a2ajprFuelQj7h7CfjcGnLea2xVNLHh277P40mAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750127122; c=relaxed/simple;
	bh=Xz9fkPVCSDMIjCo3EsGmjhJGHVFC4cBlxoxBxDimSD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=glD64iAxDC7x7IVkgkBqkCy850q27RJK/VOfRC358+UtUmOVHTBefdO2b1CD8GNNEBUU01KQj7lVDT7RL/J0rICyMYQzn/hA5a77OhfANR+INDdtNP0OJ7aXquukR2ADiUppiDXgUl/dUgEZUcpxmiKWBZm/+3yq2ea/Lj/J2sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bLrLl0Kp0zYQvlL;
	Tue, 17 Jun 2025 10:25:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 01DEE1A08C8;
	Tue, 17 Jun 2025 10:25:18 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgBHrGAL0lBoptoIPw--.40502S3;
	Tue, 17 Jun 2025 10:25:17 +0800 (CST)
Message-ID: <e48ab50f-ce8a-4426-b72b-8c0f66fe80ad@huaweicloud.com>
Date: Tue, 17 Jun 2025 10:25:15 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] fallocate: introduce FALLOC_FL_WRITE_ZEROES flag
To: "Martin K. Petersen" <martin.petersen@oracle.com>,
 Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de,
 tytso@mit.edu, djwong@kernel.org, john.g.garry@oracle.com,
 bmarzins@redhat.com, chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com,
 yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
 yangerkun@huawei.com
References: <20250604020850.1304633-1-yi.zhang@huaweicloud.com>
 <yq17c1k74jd.fsf@ca-mkp.ca.oracle.com>
 <20250616-wasser-replizieren-c47bcfaa418a@brauner>
 <yq1ecvj1v50.fsf@ca-mkp.ca.oracle.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <yq1ecvj1v50.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBHrGAL0lBoptoIPw--.40502S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYV7kC6x804xWl14x267AKxVW5JVWrJwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kI
	c2xKxwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AKxVW8ZVWrXwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/6/17 0:59, Martin K. Petersen wrote:
> 
> Christian,
> 
>>> This looks OK to me as long as the fs folks agree on the fallocate()
>>> semantics.
>>
>> That looks overall fine. Should I queue this up in the vfs tree?
> 
> We're expecting another revision addressing the queue limit sysfs
> override. Otherwise I believe it's good to go.
> 

Yeah, I'm going to revise the queue limits sysfs interface as
Christoph and Darrick suggested and send out v2.

Best regards,
Yi.



Return-Path: <linux-fsdevel+bounces-53094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F037AE9F89
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 15:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ACB37AA031
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 13:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4812E92B3;
	Thu, 26 Jun 2025 13:57:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08491922F6;
	Thu, 26 Jun 2025 13:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750946241; cv=none; b=sd2eZAyEaj2lhaf0Pwtn0XQXFoon4mRof2tFtjiYAfZLdNH1jsqGd+Le7RAVgZ9rv8yIgCc+TM6doyDK+rjS4XWzV6j6sMfhFyZQYe1Q21yfKhVBakMO9Cgzp4ZgtislYAIQE2ofOCiwOvLfZj/QN8/nzcB0rAMxh6Fj0lBbIuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750946241; c=relaxed/simple;
	bh=0c7ZHZLsdl7RngXjNl2NpX2L2Tdel9+PLaSBG+/n1XA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cu1w5KznyGw1a1CS4xnBWTUrzlk176gNs+l6rXVviwoMN0cua/ZFk9eJwci9Q8WEjNIFax1L6D9BExIE3VuCWsC78Mwbyxd78WIoq0MEeS2hrvJDZ8Nb3MfgVf0ImOKi9kXw8NuxEC6VbIiWTpXyIKpr0Zjj6O1R3J3wTB0YQM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bSgH11TkwzYQv0F;
	Thu, 26 Jun 2025 21:57:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 164801A236D;
	Thu, 26 Jun 2025 21:57:16 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgD3W2C6UV1ofP7jQg--.28741S3;
	Thu, 26 Jun 2025 21:57:15 +0800 (CST)
Message-ID: <e2fe408c-23be-4cb4-9cb2-04178fad947f@huaweicloud.com>
Date: Thu, 26 Jun 2025 21:57:14 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] fallocate: introduce FALLOC_FL_WRITE_ZEROES flag
To: "Martin K. Petersen" <martin.petersen@oracle.com>, hch@lst.de
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 djwong@kernel.org, john.g.garry@oracle.com, bmarzins@redhat.com,
 chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com, brauner@kernel.org,
 yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
 yangerkun@huawei.com
References: <20250619111806.3546162-1-yi.zhang@huaweicloud.com>
 <yq11praqywi.fsf@ca-mkp.ca.oracle.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <yq11praqywi.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgD3W2C6UV1ofP7jQg--.28741S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYV7kC6x804xWl14x267AKxVW5JVWrJwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kI
	c2xKxwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AKxVW8ZVWrXwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UdxhLUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/6/23 23:08, Martin K. Petersen wrote:
> 
> Zhang,
> 
>> This series implements the BLK_FEAT_WRITE_ZEROES_UNMAP feature and
>> BLK_FLAG_WRITE_ZEROES_UNMAP_DISABLED flag for SCSI, NVMe and
>> device-mapper drivers, and add the FALLOC_FL_WRITE_ZEROES and
>> STATX_ATTR_WRITE_ZEROES_UNMAP support for ext4 and raw bdev devices.
>> Any comments are welcome.
> 
> This looks OK to me.
> 
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> 

Thank you, Martin and Christoph, for the patient review. I will update
my test patches next.

Best regards,
Yi.



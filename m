Return-Path: <linux-fsdevel+bounces-3574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9530B7F6A32
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 02:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3381BB20FD8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 01:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76426801;
	Fri, 24 Nov 2023 01:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2C7D50;
	Thu, 23 Nov 2023 17:37:09 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SbyJc1Y0pz4f3jqx;
	Fri, 24 Nov 2023 09:37:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id ECB2E1A01A9;
	Fri, 24 Nov 2023 09:37:06 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
	by APP1 (Coremail) with SMTP id cCh0CgCnqxEx_l9ldXQRBw--.60281S3;
	Fri, 24 Nov 2023 09:37:04 +0800 (CST)
Subject: Re: [RFC PATCH 11/18] iomap: add a fs private parameter to
 iomap_ioend
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, tytso@mit.edu,
 adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
 djwong@kernel.org, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com
References: <20231123125121.4064694-1-yi.zhang@huaweicloud.com>
 <20231123125121.4064694-12-yi.zhang@huaweicloud.com>
 <ZV9xgAXbJMCJqWvt@infradead.org>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <12a61016-1df7-5cf7-94e3-3a07103cbbb6@huaweicloud.com>
Date: Fri, 24 Nov 2023 09:36:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZV9xgAXbJMCJqWvt@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgCnqxEx_l9ldXQRBw--.60281S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZF4fAF43XF4DZFW8Jw1UKFg_yoW3JrgE9r
	ZF9w4kK390kFn7Wa4DWF1rGFZxCryUWwn8A3y3Jry7Aa1kZF4kZF1vyrZ2yFWrGF48K3s8
	Cr95Xa47ZF12qjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbIxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU1zuWJUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2023/11/23 23:36, Christoph Hellwig wrote:
> On Thu, Nov 23, 2023 at 08:51:13PM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Add a private parameter to iomap_ioend structure, letting filesystems
>> can pass something they needed from .prepare_ioend() to IO end.
> 
> On it's own this looks fine.  Note that I have a series that I probably
> should send out ASAP:
> 
>    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/iomap-map-multiple-blocks
> 
> that makes each ioend only have the embdeed bio, and bi_private in that
> is unused, so you could just use that if we go down that route.
> 

Thanks for this improvement, I will analyze the changes of this series
in depth.

Thanks,
Yi.



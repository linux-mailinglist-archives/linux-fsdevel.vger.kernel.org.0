Return-Path: <linux-fsdevel+bounces-19159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D638C0C88
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 10:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1BA61C20C59
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 08:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144F9149E18;
	Thu,  9 May 2024 08:27:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B142FD528;
	Thu,  9 May 2024 08:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715243229; cv=none; b=KWTSOKXFzIlD0ZiN9VAOIaU2Bzq8tJj9fM9xq2t7RdLR+aFSUntFVpj4qqC5usnHehFYh8SwRvi3gqQYn6GQlwj3BWgR8v2kQgzSoAh+yzz7Gn5i7Kc4sNiXJIJv4O9C4JMlxK5ErWjIp68tnXbBm0RyHpK2DSGex/KBkdFeRTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715243229; c=relaxed/simple;
	bh=aQnnC1zwMqjpB6jOLDUkwiOfJfpN/2+N7Um3Xauwnrs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=eXR4E6xPmd1tOmxnFOrYrBAxopWya+xJUimu/dPEw7ouqXgGOcyHc/kUgSFyqobnPBtk501+KrAThzs/OhRfYLzcA0RqycALOXjvnwLxbazo780ijmULcYYkXky4jmTtZy9624e4rDFdGGrO28WlXAFOM0zMvf5uEyCnefyRO8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VZlVJ210Lz4f3jHy;
	Thu,  9 May 2024 16:26:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 97E2C1A017D;
	Thu,  9 May 2024 16:26:56 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgAXOQzNiDxmxDzdMQ--.44728S3;
	Thu, 09 May 2024 16:26:55 +0800 (CST)
Subject: Re: [PATCH v3 02/10] ext4: check the extent status again before
 inserting delalloc block
To: Markus Elfring <Markus.Elfring@web.de>, Zhang Yi <yi.zhang@huawei.com>,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.cz>,
 Ritesh Harjani <ritesh.list@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
 Yu Kuai <yukuai3@huawei.com>, Zhihao Cheng <chengzhihao1@huawei.com>
References: <20240508061220.967970-3-yi.zhang@huaweicloud.com>
 <34c08d45-a0fe-49c9-b7ba-de6a79d46ebc@web.de>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <90f21f4f-b619-ba23-48e2-c59c0fc18afd@huaweicloud.com>
Date: Thu, 9 May 2024 16:26:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <34c08d45-a0fe-49c9-b7ba-de6a79d46ebc@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAXOQzNiDxmxDzdMQ--.44728S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYI7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
	3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/5/8 23:02, Markus Elfring wrote:
> …
>> This patch fixes the problem by looking …
> 
> Will corresponding imperative wordings be desirable for an improved change description?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.9-rc7#n94
> 

Yes, it would be helpful.

Thanks,
Yi.



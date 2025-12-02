Return-Path: <linux-fsdevel+bounces-70416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD1BC99B75
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 02:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F0CD0345822
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 01:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D3E1DF258;
	Tue,  2 Dec 2025 01:15:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0846779CF;
	Tue,  2 Dec 2025 01:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764638136; cv=none; b=M4DQAvsg0As25yZnHwZ8jyAhzK7AGRZkVwnZty5fU9nK9UTqnfZYFcMVgf05kLP1C8EiNPIn0am2dcozn7WvkYfO503E2xn5ka0TcHcpNeScwvX8lW426C+s2w8rVcTmf47kwNon/RotYrrKcIDk6JfmdhHSrCbie5IA57MBEKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764638136; c=relaxed/simple;
	bh=27YmfSAf6ihD8Vwk8T//YvYVhcdQkw1zLlYlcmFuBGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cSB7vsBGZk/PHf7md9iMA8DHyMjrWDTnGYif9kolshrYLEqvj8YyK9DJ79vdqOWu8MXTs0nmEa6Ex0+DACyDmmuLOFCLUkkWOGGOCQfLMTlRKMaI2QzH9t+JT/BuiUvFwYY6ZZXxDtt/tqU9u2+R3FBmD/lEgMNV00kibI2M6dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dL2rf5rT4zYQtdy;
	Tue,  2 Dec 2025 09:15:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id AF0811A1719;
	Tue,  2 Dec 2025 09:15:31 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP2 (Coremail) with SMTP id Syh0CgAX+FGxPS5pG2YpAQ--.13757S3;
	Tue, 02 Dec 2025 09:15:31 +0800 (CST)
Message-ID: <b17bf8ae-7592-4c2f-a13c-de6199ca65ce@huaweicloud.com>
Date: Tue, 2 Dec 2025 09:15:29 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/14] ext4: replace ext4_es_insert_extent() when
 caching on-disk extents
To: Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 adilger.kernel@dilger.ca, jack@suse.cz, ojaswin@linux.ibm.com,
 yi.zhang@huawei.com, yizhang089@gmail.com, libaokun1@huawei.com,
 yangerkun@huawei.com
References: <20251129103247.686136-1-yi.zhang@huaweicloud.com>
 <176455640539.1349182.13217688668593418002.b4-ty@mit.edu>
 <20251201164244.GB52186@macsyma.lan>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20251201164244.GB52186@macsyma.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAX+FGxPS5pG2YpAQ--.13757S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYV7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kI
	c2xKxwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AKxVWUtVW8ZwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 12/2/2025 12:42 AM, Theodore Tso wrote:
> On Mon, Dec 01, 2025 at 11:23:50AM -0500, Theodore Ts'o wrote:
>> Applied, thanks!
> 
> n.b.  This is on the dev branch, but I plan to not include it in the initial
> pull request to Linus, so it can get a bit more soak testing.  I'll
> send to Linus after -rc1.
> 
> 					- Ted

Sure, thank you. It would be better to do more testing. Please let me
know if there is any regression. :-)

Thanks,
Yi.





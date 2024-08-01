Return-Path: <linux-fsdevel+bounces-24791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 433E5944D46
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 15:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 755A01C23DD9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 13:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BFF1A2C05;
	Thu,  1 Aug 2024 13:38:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC045183CC5
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Aug 2024 13:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722519517; cv=none; b=HpIioQxcpityT40UNcFsmf+zgKXlHgss2C+skQ4i+Ee4zmkMf7Pntgq/I9dBX0WR7Z/sowJe9ETskJCQB0AqlyeeJOBL+bZ+Vxs1IHKIAGM1t8cSe+UJKWrs5BsjH3Mdx6lvW1Zh33KMf4MGnwIK74N3QrqXUYD/FgVr8iT/BBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722519517; c=relaxed/simple;
	bh=ZYc6fVnIwj3jDeF1xYwS1FXCz6cCjogFogEvfWK2ak4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m/nWKUDd29ewPqLTjR59dzKd4nyxH9WIAImuQHomGnSQLBL/kCgqfrXZRVSoZIE2wKUnUpqTTrRsskB3ZFoUBE59bwpJV8p2B+fdsb8v3101G6Sa1HMtTXel+Aa7xWocYvYGvAM1QVwcJzU05pWQOLvktI6PhSwPEpUMFDeXcnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WZVQy3KVLz4f3n5n
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Aug 2024 21:38:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 796BB1A0568
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Aug 2024 21:38:32 +0800 (CST)
Received: from [10.174.177.210] (unknown [10.174.177.210])
	by APP4 (Coremail) with SMTP id gCh0CgBnj4XWj6tmDlTkAQ--.34883S3;
	Thu, 01 Aug 2024 21:38:32 +0800 (CST)
Message-ID: <608c3be9-4a44-21dc-fcea-199900d65200@huaweicloud.com>
Date: Thu, 1 Aug 2024 21:38:30 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] libfs: fix infinite directory reads for offset dir
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, chuck.lever@oracle.com,
 yangerkun <yangerkun@huawei.com>, hughd@google.com, zlang@kernel.org,
 fdmanana@suse.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 hch@infradead.org, viro@zeniv.linux.org.uk
References: <20240731043835.1828697-1-yangerkun@huawei.com>
 <20240731-pfeifen-gingen-4f8635e6ffcb@brauner>
 <9107aa4d-c888-3a73-0a07-a9d49f5ec558@huaweicloud.com>
 <20240801133007.jf6m223mszye66e5@quack3>
From: yangerkun <yangerkun@huaweicloud.com>
In-Reply-To: <20240801133007.jf6m223mszye66e5@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBnj4XWj6tmDlTkAQ--.34883S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw1ruF4kuFy8tF1DWF1rJFb_yoWDXwcEg3
	yrC34kCw1UXF1xKan0va13XrZ0kaykKF98tw4Utw4ku34fZFZ8ur4DGrna9rsYgFZ7KFna
	k34qva45tr1fWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbaxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/



在 2024/8/1 21:30, Jan Kara 写道:
> On Thu 01-08-24 11:32:25, yangerkun wrote:
>> Hi!
>>
>> 在 2024/7/31 22:16, Christian Brauner 写道:
>>> On Wed, 31 Jul 2024 12:38:35 +0800, yangerkun wrote:
>>>> After we switch tmpfs dir operations from simple_dir_operations to
>>>> simple_offset_dir_operations, every rename happened will fill new dentry
>>>> to dest dir's maple tree(&SHMEM_I(inode)->dir_offsets->mt) with a free
>>>> key starting with octx->newx_offset, and then set newx_offset equals to
>>>> free key + 1. This will lead to infinite readdir combine with rename
>>>> happened at the same time, which fail generic/736 in xfstests(detail show
>>>> as below).
>>>>
>>>> [...]
>>>
>>> @Chuck, @Jan I did the requested change directly. Please check!
>>
>> Thanks for applied this patch, the suggestions from Jan and Chuck will
>> be a separates patch!
> 
> Christian already updated the patch as I've suggested so no need for you
> to send anything.

OK, thanks for that!
> 
> 								Honza
> 



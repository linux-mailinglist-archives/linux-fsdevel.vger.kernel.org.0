Return-Path: <linux-fsdevel+bounces-35952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CC79DA113
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 04:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EBCFB2204A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 03:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B34558A5;
	Wed, 27 Nov 2024 03:11:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495F2139D;
	Wed, 27 Nov 2024 03:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732677086; cv=none; b=oDNEMAjv22JPGc2V4DapAEXdpzcSjaDVrJ40/2vGACYQzOODgnFtD6eXYFBxkRQTlnHkYuxINAPGWuSZJX7ZGWPdGk+YyziNnyYNDdXNfesYirhBOmcNKsN/zff6HCPMqdFAdAIC82YfcjBl7CvdrmYTotcQFozOEpDrgKvhHYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732677086; c=relaxed/simple;
	bh=JT7wu2Q9QL/H+3kDgRRdP1qEPj05LLgsw84fkuZQ6jk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AvGLTF6HpdrcWLo+QVDp49409mNlelCFHNGWuZhxfsdhbxd30xOF9tsZp0nNizOQDmNcOXMHgEoF81amYtzqTPiwUoAsFaAxk3pMzybXGY7+0gigKIUxinefzjB474tVKrDJH5iwX64R/4XTDm/xO4FQBBhcZIo8UUGs8f37U5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xykwg6Wtmz4f3lDh;
	Wed, 27 Nov 2024 11:10:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9D2D91A06D7;
	Wed, 27 Nov 2024 11:11:19 +0800 (CST)
Received: from [10.174.177.210] (unknown [10.174.177.210])
	by APP4 (Coremail) with SMTP id gCh0CgCXc4fWjUZnSxzICw--.31254S3;
	Wed, 27 Nov 2024 11:11:19 +0800 (CST)
Message-ID: <37bb7584-be0a-8932-d8a7-e51418641402@huaweicloud.com>
Date: Wed, 27 Nov 2024 11:11:18 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC PATCH v2 1/5] libfs: Return ENOSPC when the directory offset
 range is exhausted
To: cel@kernel.org, Hugh Dickens <hughd@google.com>,
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, yukuai3@huawei.com,
 Chuck Lever <chuck.lever@oracle.com>, stable@vger.kernel.org
References: <20241126155444.2556-1-cel@kernel.org>
 <20241126155444.2556-2-cel@kernel.org>
From: yangerkun <yangerkun@huaweicloud.com>
In-Reply-To: <20241126155444.2556-2-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXc4fWjUZnSxzICw--.31254S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyUKr45CFy8urWxWF1fXrb_yoW8GrWfpF
	WkJanIkFZxJr18C3ykXr4qyry0gwsrGr1xuFZxuw1UA3sxAFn7Ga12yr1Y9a4UKrs8CFnF
	qF4YkF1F9w1UJFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrs
	qXDUUUU
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

LGTM

Reviewed-by: Yang Erkun <yangerkun@huawei.com>

在 2024/11/26 23:54, cel@kernel.org 写道:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Testing shows that the EBUSY error return from mtree_alloc_cyclic()
> leaks into user space. The ERRORS section of "man creat(2)" says:
> 
>> 	EBUSY	O_EXCL was specified in flags and pathname refers
>> 		to a block device that is in use by the system
>> 		(e.g., it is mounted).
> 
> ENOSPC is closer to what applications expect in this situation.
> 
> Note that the normal range of simple directory offset values is
> 2..2^63, so hitting this error is going to be rare to impossible.
> 
> Fixes: 6faddda69f62 ("libfs: Add directory operations for stable offsets")
> Cc: <stable@vger.kernel.org> # v6.9+
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   fs/libfs.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 46966fd8bcf9..bf67954b525b 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -288,7 +288,9 @@ int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry)
>   
>   	ret = mtree_alloc_cyclic(&octx->mt, &offset, dentry, DIR_OFFSET_MIN,
>   				 LONG_MAX, &octx->next_offset, GFP_KERNEL);
> -	if (ret < 0)
> +	if (unlikely(ret == -EBUSY))
> +		return -ENOSPC;
> +	if (unlikely(ret < 0))
>   		return ret;
>   
>   	offset_set(dentry, offset);



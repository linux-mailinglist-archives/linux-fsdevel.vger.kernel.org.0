Return-Path: <linux-fsdevel+bounces-35951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 266D59DA10F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 04:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C71ED1665D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 03:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AFC5EE97;
	Wed, 27 Nov 2024 03:09:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066B026AD4
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Nov 2024 03:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732676964; cv=none; b=TJWSOYR4udZuzexN7X7jrKQFLR62Q2mGEq9k90u+uomANc1N+Diuz9zsmv5VtY6ljr9dCTejkIJyi/8WfA+zUMKmQUXrNah+AkU79bHi6XwgnVJLM465Gtc34pG1nuC5gLA22n/RBzTlKuIq7tkDQ/Nw6ZOSeLM5gH7P9dnExMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732676964; c=relaxed/simple;
	bh=bkrJzEZ2spY55X9W1+l2F1yxnL48I3W0fQdNSTcwCe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yw07jLdSSoDutiz3482v2mm4H8vo1JWnXr8veeIxUjcm0PvzX1IcVWnauebqXUI3vhUJlFVesdB3OxXE8hXPtWXXZUP1Fg8BA9qCDTXCLpKvWf9mz8eGh4grnPnI2BehIR9PSpaHwV4kbr7SsQ8eCaTKYjbfLw8qtvoDX75UpkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XyktD3D2Jz4f3l26
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Nov 2024 11:08:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2A64B1A07B6
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Nov 2024 11:09:12 +0800 (CST)
Received: from [10.174.177.210] (unknown [10.174.177.210])
	by APP4 (Coremail) with SMTP id gCh0CgB3U4dXjUZnw_fHCw--.28395S3;
	Wed, 27 Nov 2024 11:09:11 +0800 (CST)
Message-ID: <6917283e-d688-a133-9193-ca5d6255dafb@huaweicloud.com>
Date: Wed, 27 Nov 2024 11:09:11 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC PATCH v2 2/5] libfs: Check dentry before locking in
 simple_offset_empty()
To: cel@kernel.org, Hugh Dickens <hughd@google.com>,
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, yukuai3@huawei.com,
 Chuck Lever <chuck.lever@oracle.com>
References: <20241126155444.2556-1-cel@kernel.org>
 <20241126155444.2556-3-cel@kernel.org>
From: yangerkun <yangerkun@huaweicloud.com>
In-Reply-To: <20241126155444.2556-3-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3U4dXjUZnw_fHCw--.28395S3
X-Coremail-Antispam: 1UD129KBjvJXoW7try8ur47tw13Kr1xGFy5XFb_yoW8Xr47pa
	95KF4akr4rX34kWa92vwnF9r40q3Z7WF4jgFWrXw15ArZrtwn2q3yIkF4ag348Wr4xCFsx
	KFs8K3Z0ka1DZ3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UZSd
	gUUUUU=
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

Thank you very much for your efforts on this issue!

在 2024/11/26 23:54, cel@kernel.org 写道:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Defensive change: Don't try to lock a dentry unless it is positive.
> Trying to lock a negative entry will generate a refcount underflow.

Which member trigger this underflow?

> 
> The underflow has been seen only while testing.
> 
> Fixes: ecba88a3b32d ("libfs: Add simple_offset_empty()")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   fs/libfs.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index bf67954b525b..c88ed15437c7 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -347,13 +347,14 @@ int simple_offset_empty(struct dentry *dentry)
>   	index = DIR_OFFSET_MIN;
>   	octx = inode->i_op->get_offset_ctx(inode);
>   	mt_for_each(&octx->mt, child, index, LONG_MAX) {
> -		spin_lock(&child->d_lock);
>   		if (simple_positive(child)) {
> +			spin_lock(&child->d_lock);
> +			if (simple_positive(child))
> +				ret = 0;
>   			spin_unlock(&child->d_lock);
> -			ret = 0;
> -			break;
> +			if (!ret)
> +				break;
>   		}
> -		spin_unlock(&child->d_lock);
>   	}

Calltrace arrived here means this is a active dir(a dentry with positive 
inode), and nowdays only .rmdir / .rename2 for shmem can reach this 
point. Lock for this dir inode has already been held, maybe this can 
protect child been negative or active? So d_lock here is no need?

>   
>   	return ret;



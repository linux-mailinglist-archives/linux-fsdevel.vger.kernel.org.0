Return-Path: <linux-fsdevel+bounces-25849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD69F951199
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 03:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D305285245
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 01:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A301643A;
	Wed, 14 Aug 2024 01:33:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0B0195;
	Wed, 14 Aug 2024 01:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723599204; cv=none; b=fVFCxTB+2E1EASo5ccZofkGhdwzv0RNwbLcqyCv8QQZcNg+GJjYKgbEAuXaOOmi6YdmPqW+d5wW0yGfMNLdR4VBZFHr7acbv5idq3Vz1GX5uizUqtl6ab4lYK26peCfNB/Y7+gGXzcS0QKlecc/MfDzPcv+HnqL2gwK65zynRW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723599204; c=relaxed/simple;
	bh=wDTRoJXq1+5WgaMwT8JkuFyCS8wfq1HfaF/3VBgpZo8=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PZYZ1QIPjJMbUF5eH4TwtQE2VYlN9DL2SD8rTpFL0UOtLGQG4tdYUweoszvbaLQ3XlPwsBUIvBvEVbxOOXI6JzwC3rpVGn0DtiSxB33Y0bwEsAMRcSGIUwXxRjvlRpV3bSDoTqEDtIPy0whKJOBvEMJYTrimHXU0EqeADEgZPts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wk9ft0cnNz1HFwp;
	Wed, 14 Aug 2024 09:30:14 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 07FEB1402CF;
	Wed, 14 Aug 2024 09:33:18 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 14 Aug 2024 09:33:17 +0800
Subject: Re: [PATCH] vfs: drop one lock trip in evict()
To: Mateusz Guzik <mjguzik@gmail.com>, <brauner@kernel.org>
CC: <viro@zeniv.linux.org.uk>, <jack@suse.cz>, <jlayton@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <20240813143626.1573445-1-mjguzik@gmail.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <0be88aea-9438-2c74-762e-b8aaa549fd40@huawei.com>
Date: Wed, 14 Aug 2024 09:33:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240813143626.1573445-1-mjguzik@gmail.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000013.china.huawei.com (7.193.23.81)

ÔÚ 2024/8/13 22:36, Mateusz Guzik Ð´µÀ:
> Most commonly neither I_LRU_ISOLATING nor I_SYNC are set, but the stock
> kernel takes a back-to-back relock trip to check for them.
> 
> It probably can be avoided altogether, but for now massage things back
> to just one lock acquire.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> there are smp_mb's in the area I'm going to look at removing at some
> point(tm), in the meantime I think this is an easy cleanup
> 
> has a side effect of whacking a inode_wait_for_writeback which was only
> there to deal with not holding the lock
> 
>   fs/fs-writeback.c | 17 +++--------------
>   fs/inode.c        |  5 +++--
>   2 files changed, 6 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 4451ecff37c4..1a5006329f6f 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1510,13 +1510,12 @@ static int write_inode(struct inode *inode, struct writeback_control *wbc)
>    * Wait for writeback on an inode to complete. Called with i_lock held.
>    * Caller must make sure inode cannot go away when we drop i_lock.
>    */
> -static void __inode_wait_for_writeback(struct inode *inode)
> -	__releases(inode->i_lock)
> -	__acquires(inode->i_lock)
> +void inode_wait_for_writeback(struct inode *inode)
>   {
>   	DEFINE_WAIT_BIT(wq, &inode->i_state, __I_SYNC);
>   	wait_queue_head_t *wqh;
>   
> +	lockdep_assert_held(&inode->i_lock);
>   	wqh = bit_waitqueue(&inode->i_state, __I_SYNC);
>   	while (inode->i_state & I_SYNC) {
>   		spin_unlock(&inode->i_lock);
> @@ -1526,16 +1525,6 @@ static void __inode_wait_for_writeback(struct inode *inode)
>   	}
>   }
>   
> -/*
> - * Wait for writeback on an inode to complete. Caller must have inode pinned.
> - */
> -void inode_wait_for_writeback(struct inode *inode)
> -{
> -	spin_lock(&inode->i_lock);
> -	__inode_wait_for_writeback(inode);
> -	spin_unlock(&inode->i_lock);
> -}
> -
>   /*
>    * Sleep until I_SYNC is cleared. This function must be called with i_lock
>    * held and drops it. It is aimed for callers not holding any inode reference
> @@ -1757,7 +1746,7 @@ static int writeback_single_inode(struct inode *inode,
>   		 */
>   		if (wbc->sync_mode != WB_SYNC_ALL)
>   			goto out;
> -		__inode_wait_for_writeback(inode);
> +		inode_wait_for_writeback(inode);
>   	}
>   	WARN_ON(inode->i_state & I_SYNC);
>   	/*
> diff --git a/fs/inode.c b/fs/inode.c
> index 73183a499b1c..d48d29d39cd2 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -582,7 +582,7 @@ static void inode_unpin_lru_isolating(struct inode *inode)
>   
>   static void inode_wait_for_lru_isolating(struct inode *inode)
>   {
> -	spin_lock(&inode->i_lock);
> +	lockdep_assert_held(&inode->i_lock);
>   	if (inode->i_state & I_LRU_ISOLATING) {
>   		DEFINE_WAIT_BIT(wq, &inode->i_state, __I_LRU_ISOLATING);
>   		wait_queue_head_t *wqh;
> @@ -593,7 +593,6 @@ static void inode_wait_for_lru_isolating(struct inode *inode)
>   		spin_lock(&inode->i_lock);
>   		WARN_ON(inode->i_state & I_LRU_ISOLATING);
>   	}
> -	spin_unlock(&inode->i_lock);
>   }
>   
>   /**
> @@ -765,6 +764,7 @@ static void evict(struct inode *inode)
>   
>   	inode_sb_list_del(inode);
>   
> +	spin_lock(&inode->i_lock);
>   	inode_wait_for_lru_isolating(inode);
>   
>   	/*
> @@ -774,6 +774,7 @@ static void evict(struct inode *inode)
>   	 * the inode.  We just have to wait for running writeback to finish.
>   	 */
>   	inode_wait_for_writeback(inode);
> +	spin_unlock(&inode->i_lock);
>   
>   	if (op->evict_inode) {
>   		op->evict_inode(inode);
> 



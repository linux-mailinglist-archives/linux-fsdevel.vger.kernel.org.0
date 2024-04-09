Return-Path: <linux-fsdevel+bounces-16416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7637589D27A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 08:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6F0E1C229F0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 06:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FAA31A66;
	Tue,  9 Apr 2024 06:31:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AF91773A;
	Tue,  9 Apr 2024 06:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712644280; cv=none; b=VetG4MihlOdQpOzbk/xMzO9VNYAEkVyupGvH1ImN9ar0ROhI9XNv4GrOZ2HiLLg8IPSLZdqlzzI4Kzw3LFoAmHlfBVBOk+IugGOeG6ooyftbDGI6KUv3I2MqTv2bQVe9+AC/Zhr1MHx45sGNFpFygUmLtxdgzT5ePEoOg1bKQas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712644280; c=relaxed/simple;
	bh=URqtiEJVdrnUgHUx9SUvz6al5BcQ5UgCH5Yi0/qKvuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UZy5ZCSMYTjw1EIch6BhofefKNINv2RyWAP9Ply+cEWZYc1KRRXAGqQxAHLJ/9G8w5kCQ7ncqxr0H89kyUsX+tAAtBFXwWIihp/mFTjCINCzKj6LKNK2nL8RGX7jMMACGj2/7C9CwBlgCJMZT9UhJTJsc4ZurXjSZfTtWAQ3QC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VDGKy4qgGz1GGV5;
	Tue,  9 Apr 2024 14:30:30 +0800 (CST)
Received: from canpemm500009.china.huawei.com (unknown [7.192.105.203])
	by mail.maildlp.com (Postfix) with ESMTPS id 7AB341A0172;
	Tue,  9 Apr 2024 14:31:15 +0800 (CST)
Received: from [10.108.234.194] (10.108.234.194) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 14:31:15 +0800
Message-ID: <a2f7ae45-9e13-4b0c-a16f-637324565e14@huawei.com>
Date: Tue, 9 Apr 2024 14:31:14 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] quota: don't let mark_dquot_dirty() fail silently
To: Chao Yu <chao@kernel.org>, <jack@suse.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240407073128.3489785-1-chao@kernel.org>
Content-Language: en-US
From: "wangjianjian (C)" <wangjianjian3@huawei.com>
In-Reply-To: <20240407073128.3489785-1-chao@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)

On 2024/4/7 15:31, Chao Yu wrote:
> mark_dquot_dirty() will callback to specified filesystem function,
> it may fail due to any reasons, however, no caller will check return
> value of mark_dquot_dirty(), so, it may fail silently, let's print
> one line message for such case.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>   fs/quota/dquot.c | 23 +++++++++++++----------
>   1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index dacbee455c03..c5df7863942a 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -399,21 +399,20 @@ int dquot_mark_dquot_dirty(struct dquot *dquot)
>   EXPORT_SYMBOL(dquot_mark_dquot_dirty);
>   
>   /* Dirtify all the dquots - this can block when journalling */
> -static inline int mark_all_dquot_dirty(struct dquot __rcu * const *dquots)
> +static inline void mark_all_dquot_dirty(struct dquot __rcu * const *dquots)
>   {
> -	int ret, err, cnt;
> +	int ret, cnt;
>   	struct dquot *dquot;
>   
> -	ret = err = 0;
>   	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
>   		dquot = srcu_dereference(dquots[cnt], &dquot_srcu);
> -		if (dquot)
> -			/* Even in case of error we have to continue */
> -			ret = mark_dquot_dirty(dquot);
> -		if (!err)
> -			err = ret;
> +		if (!dquot)
> +			continue;
> +		ret = mark_dquot_dirty(dquot);
> +		if (ret < 0)
> +			quota_error(dquot->dq_sb,
> +				"mark_all_dquot_dirty fails, ret: %d", ret);
>   	}
> -	return err;
>   }
>   
>   static inline void dqput_all(struct dquot **dquot)
> @@ -2725,6 +2724,7 @@ static int do_set_dqblk(struct dquot *dquot, struct qc_dqblk *di)
>   {
>   	struct mem_dqblk *dm = &dquot->dq_dqb;
>   	int check_blim = 0, check_ilim = 0;
> +	int ret;
>   	struct mem_dqinfo *dqi = &sb_dqopt(dquot->dq_sb)->info[dquot->dq_id.type];
>   
>   	if (di->d_fieldmask & ~VFS_QC_MASK)
> @@ -2807,7 +2807,10 @@ static int do_set_dqblk(struct dquot *dquot, struct qc_dqblk *di)
>   	else
>   		set_bit(DQ_FAKE_B, &dquot->dq_flags);
>   	spin_unlock(&dquot->dq_dqb_lock);
> -	mark_dquot_dirty(dquot);
> +	ret = mark_dquot_dirty(dquot);
Here it overwrite previous error.

> +	if (ret < 0)
> +		quota_error(dquot->dq_sb,
> +			"mark_dquot_dirty fails, ret: %d", ret);
>   
>   	return 0;
>   }
-- 
Regards



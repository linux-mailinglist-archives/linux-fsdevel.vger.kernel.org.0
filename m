Return-Path: <linux-fsdevel+bounces-17269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B53A98AA6CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 04:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6FE31C21D89
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 02:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490D053BE;
	Fri, 19 Apr 2024 02:04:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AD415A4;
	Fri, 19 Apr 2024 02:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713492245; cv=none; b=jyw+iaAdsHOVBprcoREDHH36oHB8e5chbq9YKs+vZGh81Rmsqa8odyB6Yj1pNoZFlZA2ZucpoyO/MDeEqgrUxsSMfxHlXxB243Jg2S+/8yzwmWfGGMR7fJgEoh3IAA0jrWLDJDZeYwT8ECZrJXFElukwSzFu1uF5jdaQIzG3kR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713492245; c=relaxed/simple;
	bh=OykcDlVX+9nmzM/ihAuEwCvKbcJZwvq+flSaFWyV+AY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ci1GGGrZ5vqHsgxXCJqibuWz1KwuLuwzkFO9QnvvMUGbSRLb838z3TcRK6bx9hqL/azYdc9R9xGYUoKKvktxZoHNIqY+B2NzAjJkC5x58RY/GDV4g9ix1xaWjQFt+rT7o1Pz5rFVT7IfDqT9qqa+ByHZikReJRk+vj1cvvXDBog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4VLHTs0SfVz1RCsb;
	Fri, 19 Apr 2024 09:43:13 +0800 (CST)
Received: from canpemm500009.china.huawei.com (unknown [7.192.105.203])
	by mail.maildlp.com (Postfix) with ESMTPS id E244F14035F;
	Fri, 19 Apr 2024 09:46:12 +0800 (CST)
Received: from [10.108.234.194] (10.108.234.194) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 09:46:12 +0800
Message-ID: <070eba70-0168-42e6-8bca-0936711074e4@huawei.com>
Date: Fri, 19 Apr 2024 09:46:11 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] quota: fix to propagate error of mark_dquot_dirty() to
 caller
To: Jan Kara <jack@suse.cz>, Chao Yu <chao@kernel.org>
CC: Jan Kara <jack@suse.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240412094942.2131243-1-chao@kernel.org>
 <20240412121517.dydwqiqkdzvwpwf5@quack3>
 <20240412130130.m4msohzpiojtve7r@quack3>
Content-Language: en-US
From: "wangjianjian (C)" <wangjianjian3@huawei.com>
In-Reply-To: <20240412130130.m4msohzpiojtve7r@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)

On 2024/4/12 21:01, Jan Kara wrote:
> On Fri 12-04-24 14:15:17, Jan Kara wrote:
>> On Fri 12-04-24 17:49:42, Chao Yu wrote:
>>> in order to let caller be aware of failure of mark_dquot_dirty().
>>>
>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>
>> Thanks. I've added the patch to my tree.
> 
> So this patch was buggy because mark_all_dquots() dirty was returning 1 in
> case some dquot was indeed dirtied which resulted in e.g.
> dquot_alloc_inode() to return 1 and consequently __ext4_new_inode() to fail
This is what I try to say in my another f2fs patch, some callers use if 
return value is zero not *less than zero* to check success or not. 
Luckily, maybe f2fs doesn't use it this way.

> and eventually we've crashed in ext4_create().  I've fixed up the patch to
> make mark_all_dquots() return 0 or error.
> 
> 								Honza
> 
>>> ---
>>>   fs/quota/dquot.c | 21 ++++++++++++++-------
>>>   1 file changed, 14 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
>>> index dacbee455c03..b2a109d8b198 100644
>>> --- a/fs/quota/dquot.c
>>> +++ b/fs/quota/dquot.c
>>> @@ -1737,7 +1737,7 @@ int __dquot_alloc_space(struct inode *inode, qsize_t number, int flags)
>>>   
>>>   	if (reserve)
>>>   		goto out_flush_warn;
>>> -	mark_all_dquot_dirty(dquots);
>>> +	ret = mark_all_dquot_dirty(dquots);
>>>   out_flush_warn:
>>>   	srcu_read_unlock(&dquot_srcu, index);
>>>   	flush_warnings(warn);
>>> @@ -1786,7 +1786,7 @@ int dquot_alloc_inode(struct inode *inode)
>>>   warn_put_all:
>>>   	spin_unlock(&inode->i_lock);
>>>   	if (ret == 0)
>>> -		mark_all_dquot_dirty(dquots);
>>> +		ret = mark_all_dquot_dirty(dquots);
>>>   	srcu_read_unlock(&dquot_srcu, index);
>>>   	flush_warnings(warn);
>>>   	return ret;
>>> @@ -1990,7 +1990,7 @@ int __dquot_transfer(struct inode *inode, struct dquot **transfer_to)
>>>   	qsize_t inode_usage = 1;
>>>   	struct dquot __rcu **dquots;
>>>   	struct dquot *transfer_from[MAXQUOTAS] = {};
>>> -	int cnt, index, ret = 0;
>>> +	int cnt, index, ret = 0, err;
>>>   	char is_valid[MAXQUOTAS] = {};
>>>   	struct dquot_warn warn_to[MAXQUOTAS];
>>>   	struct dquot_warn warn_from_inodes[MAXQUOTAS];
>>> @@ -2087,8 +2087,12 @@ int __dquot_transfer(struct inode *inode, struct dquot **transfer_to)
>>>   	 * mark_all_dquot_dirty().
>>>   	 */
>>>   	index = srcu_read_lock(&dquot_srcu);
>>> -	mark_all_dquot_dirty((struct dquot __rcu **)transfer_from);
>>> -	mark_all_dquot_dirty((struct dquot __rcu **)transfer_to);
>>> +	err = mark_all_dquot_dirty((struct dquot __rcu **)transfer_from);
>>> +	if (err < 0)
>>> +		ret = err;
>>> +	err = mark_all_dquot_dirty((struct dquot __rcu **)transfer_to);
>>> +	if (err < 0)
>>> +		ret = err;
>>>   	srcu_read_unlock(&dquot_srcu, index);
>>>   
>>>   	flush_warnings(warn_to);
>>> @@ -2098,7 +2102,7 @@ int __dquot_transfer(struct inode *inode, struct dquot **transfer_to)
>>>   	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
>>>   		if (is_valid[cnt])
>>>   			transfer_to[cnt] = transfer_from[cnt];
>>> -	return 0;
>>> +	return ret;
>>>   over_quota:
>>>   	/* Back out changes we already did */
>>>   	for (cnt--; cnt >= 0; cnt--) {
>>> @@ -2726,6 +2730,7 @@ static int do_set_dqblk(struct dquot *dquot, struct qc_dqblk *di)
>>>   	struct mem_dqblk *dm = &dquot->dq_dqb;
>>>   	int check_blim = 0, check_ilim = 0;
>>>   	struct mem_dqinfo *dqi = &sb_dqopt(dquot->dq_sb)->info[dquot->dq_id.type];
>>> +	int ret;
>>>   
>>>   	if (di->d_fieldmask & ~VFS_QC_MASK)
>>>   		return -EINVAL;
>>> @@ -2807,7 +2812,9 @@ static int do_set_dqblk(struct dquot *dquot, struct qc_dqblk *di)
>>>   	else
>>>   		set_bit(DQ_FAKE_B, &dquot->dq_flags);
>>>   	spin_unlock(&dquot->dq_dqb_lock);
>>> -	mark_dquot_dirty(dquot);
>>> +	ret = mark_dquot_dirty(dquot);
>>> +	if (ret < 0)
>>> +		return ret;
>>>   
>>>   	return 0;
>>>   }
>>> -- 
>>> 2.40.1
>>>
>> -- 
>> Jan Kara <jack@suse.com>
>> SUSE Labs, CR
>>
-- 
Regards



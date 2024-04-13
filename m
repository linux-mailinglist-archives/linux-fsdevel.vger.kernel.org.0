Return-Path: <linux-fsdevel+bounces-16846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 680538A3A1F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 03:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ACC01F230D2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 01:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9358A954;
	Sat, 13 Apr 2024 01:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzstgtCA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBA063C8;
	Sat, 13 Apr 2024 01:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712971828; cv=none; b=MBNwKn6J6UA6OHtAQN06P7XxzWXmJ1qj5RzNy9/btmF5XJGoRGrjhMpQlqr6Plzg2kn9no5APSWR95HXQgop2/dVT/GS64wxNGuQ8uuMhVj5duuaqFF3ILTISZTXonyXASwIRpxjho3hdWann0soSquGYPwNn6ySjSP0gnQ1iWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712971828; c=relaxed/simple;
	bh=d2icaWJTTOCZ5p+K61BPO2+gXckymnqiwHcjN9WUKe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EzXmH94mKSxo0c9J1oWCAOFBleHXrMg8UkY1Rb40hhkM5dH4DTsbP2DXgr3i/v51L2LNwvF24Jgx4LENoXNoQ38M7EpUbkpG9YDKqrMc1glgNLS9rxRnImhyXQXCqkbwtwihe7QSuJwjAfEswzHvU8BPFtHwE4BQmaObzbenc4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzstgtCA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEA4C113CC;
	Sat, 13 Apr 2024 01:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712971827;
	bh=d2icaWJTTOCZ5p+K61BPO2+gXckymnqiwHcjN9WUKe0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nzstgtCALFZLYrHVuB/4ho0QONvxViQK41ZeNBgY1MirDR3BM9reA6wzV3ztKn/4Y
	 7olDDQ2OiPSG4aBWP6FQKq5GkNFvseLFwAhIKCfOaSTndLaiGXXwbg6YiB/Vf3RwrU
	 s/6cgMFMYGdfFB9DeQ+VHSdeB5+llLPq4peH4z7be9HlFEbjJ9na80l5IZVYTSJYxk
	 MYZloJslfAW5QblF1coreliXQcwNQiKovAm2Tljv5rxT1ZASKHUg1fiIubF+y8C+RN
	 u0U57Vzcoyd256Shgr/BihKR91Jb76oIKFTpxFqSoqd15BItGAeSvWhACmaPxcvarH
	 N6H4FU+hy7O6A==
Message-ID: <43f55f4b-cb2a-4845-9ded-40ce68f3351c@kernel.org>
Date: Sat, 13 Apr 2024 09:30:22 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] quota: fix to propagate error of mark_dquot_dirty() to
 caller
To: Jan Kara <jack@suse.cz>
Cc: Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240412094942.2131243-1-chao@kernel.org>
 <20240412121517.dydwqiqkdzvwpwf5@quack3>
 <20240412130130.m4msohzpiojtve7r@quack3>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240412130130.m4msohzpiojtve7r@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

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

Correct, I missed that case.

> and eventually we've crashed in ext4_create().  I've fixed up the patch to
> make mark_all_dquots() return 0 or error.

Thank you for catching and fixing it.

Thanks,

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


Return-Path: <linux-fsdevel+bounces-16663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 739038A0FCD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 12:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E14271F28E70
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 10:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99965146A9D;
	Thu, 11 Apr 2024 10:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8WrY15p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048021465BF;
	Thu, 11 Apr 2024 10:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831264; cv=none; b=YDoBXk1Op4smeXGE74bhZCZZ6MrfxzUvSnDIpQLDE+xE2LpDbV8m3yi59mnXTbSkg7BNJd+Rg5Sc/Hl8fQsATRa8LcDzNb5Bi0tFjoRBHTFvkyClXfP2gif3ggI2c1RSGpiOuk/XLF/g60C0+MQxcEbHVExdu3MIHes8D3Pb0ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831264; c=relaxed/simple;
	bh=Doc6T4T+MqzUHbYZk42u21UvBZKk16gYKFjpr6T3MZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F7HQBxee0/1nNg3xliCB9e+WqYQbclI7MUu7U8NWhHTboAl/2HP0vusyaSWN+YKPqNmbL+814cTt2diSAdCE9TUc0oQ8KBCBzmtxyUHG8/9jYVjRLZX/ZruAIoSu3opO6am9V2QuMXpu8ssi/sZSYW9sxgCqtarCURaNA5K5kYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8WrY15p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2490C433C7;
	Thu, 11 Apr 2024 10:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712831263;
	bh=Doc6T4T+MqzUHbYZk42u21UvBZKk16gYKFjpr6T3MZA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=s8WrY15pzeU5Jf64vbCaQSQz19L2Qed/V+tYW79kofkVqNR1JkBH4Lsgxj4fkKprc
	 3jYvaBuWGpptoun4AJJ94y8XQuWXpgU5Prg3rBvJNMHiVLpo0RQCA6kPgUuIYbQTuo
	 7pYs8YPqhJUiY3409bj3keNiyfK/OoQnKjrGHURSAveo2uu+qUw0/HDTER+aDyo83+
	 qI+F9gUvaMd91XdM4TkSouzL/ucI4IRDTp7SUAO08O+EbcZIRVdi5Is/yQQq3e/5I9
	 TZQgbB2I6NS0EY0pmfRRnyEYcOuVGp/p5VMLcYs+23gGQDeEdiU/ytvVrs0sxggPms
	 B+nyYSIW5Hv5A==
Message-ID: <4a4e6e08-3d4f-4e40-8bed-43aad2013b92@kernel.org>
Date: Thu, 11 Apr 2024 18:27:40 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] quota: don't let mark_dquot_dirty() fail silently
To: Jan Kara <jack@suse.cz>
Cc: jack@suse.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240407073128.3489785-1-chao@kernel.org>
 <20240408143043.65yowy2yvf46weab@quack3>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240408143043.65yowy2yvf46weab@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/4/8 22:30, Jan Kara wrote:
> On Sun 07-04-24 15:31:28, Chao Yu wrote:
>> mark_dquot_dirty() will callback to specified filesystem function,
>> it may fail due to any reasons, however, no caller will check return
>> value of mark_dquot_dirty(), so, it may fail silently, let's print
>> one line message for such case.
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/quota/dquot.c | 23 +++++++++++++----------
>>   1 file changed, 13 insertions(+), 10 deletions(-)
>>
>> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
>> index dacbee455c03..c5df7863942a 100644
>> --- a/fs/quota/dquot.c
>> +++ b/fs/quota/dquot.c
>> @@ -399,21 +399,20 @@ int dquot_mark_dquot_dirty(struct dquot *dquot)
>>   EXPORT_SYMBOL(dquot_mark_dquot_dirty);
>>   
>>   /* Dirtify all the dquots - this can block when journalling */
>> -static inline int mark_all_dquot_dirty(struct dquot __rcu * const *dquots)
>> +static inline void mark_all_dquot_dirty(struct dquot __rcu * const *dquots)
>>   {
>> -	int ret, err, cnt;
>> +	int ret, cnt;
>>   	struct dquot *dquot;
>>   
>> -	ret = err = 0;
>>   	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
>>   		dquot = srcu_dereference(dquots[cnt], &dquot_srcu);
>> -		if (dquot)
>> -			/* Even in case of error we have to continue */
>> -			ret = mark_dquot_dirty(dquot);
>> -		if (!err)
>> -			err = ret;
>> +		if (!dquot)
>> +			continue;
>> +		ret = mark_dquot_dirty(dquot);
>> +		if (ret < 0)
>> +			quota_error(dquot->dq_sb,
>> +				"mark_all_dquot_dirty fails, ret: %d", ret);
> 
> Do you have any practical case you care about? Because in practice the

Actually, no.

> filesystem will usually report if there's some catastrophic error (and the
> errors from ->mark_dirty() all mean the filesystem is in unhealthy state).
> So this message just adds to the noise in the error log - and e.g. if the
> disk goes bad so we cannot write, we could spew a lot of messages like
> this.

Agreed,

I guess we can propagate the error to caller rather than printing redundant
message in log.

> 
>>   	}
>> -	return err;
>>   }
>>   
>>   static inline void dqput_all(struct dquot **dquot)
>> @@ -2725,6 +2724,7 @@ static int do_set_dqblk(struct dquot *dquot, struct qc_dqblk *di)
>>   {
>>   	struct mem_dqblk *dm = &dquot->dq_dqb;
>>   	int check_blim = 0, check_ilim = 0;
>> +	int ret;
>>   	struct mem_dqinfo *dqi = &sb_dqopt(dquot->dq_sb)->info[dquot->dq_id.type];
>>   
>>   	if (di->d_fieldmask & ~VFS_QC_MASK)
>> @@ -2807,7 +2807,10 @@ static int do_set_dqblk(struct dquot *dquot, struct qc_dqblk *di)
>>   	else
>>   		set_bit(DQ_FAKE_B, &dquot->dq_flags);
>>   	spin_unlock(&dquot->dq_dqb_lock);
>> -	mark_dquot_dirty(dquot);
>> +	ret = mark_dquot_dirty(dquot);
>> +	if (ret < 0)
>> +		quota_error(dquot->dq_sb,
>> +			"mark_dquot_dirty fails, ret: %d", ret);
> 
> Here, we can propagate the error back to userspace, which is probably
> better than spamming the logs.

Yes, let me submit a new patch for this.

Thanks,

> 
> 								Honza


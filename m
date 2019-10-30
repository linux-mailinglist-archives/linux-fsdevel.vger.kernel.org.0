Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1955E9AFC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 12:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfJ3Lnc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 07:43:32 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:44558 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726088AbfJ3Lnc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 07:43:32 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 4B6692E14E5;
        Wed, 30 Oct 2019 14:43:28 +0300 (MSK)
Received: from iva4-c987840161f8.qloud-c.yandex.net (iva4-c987840161f8.qloud-c.yandex.net [2a02:6b8:c0c:3da5:0:640:c987:8401])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 82dg4vUT95-hRe8nwYV;
        Wed, 30 Oct 2019 14:43:28 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1572435808; bh=pA6mNmTIWq/Cwxmgu8JH1E701Iel80nhtPksH0lcKiI=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=ipAlUMbdXEs+AwZT4OP3cjhssAs6ZCUz0BCfWWjCwxLEL3py+H3xgj0DZ7wEvkOnB
         XPqF5Z2EGRueUUaT+DMVrAJzi2/G4zGw17UD4anJdfklWOLpCsDqMjcb3xz+kR5XFU
         BEFbpkC5qnFv6fhBCEYRPeIfeWR8NKQ7z3dNMrec=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:148a:8f3:5b61:9f4])
        by iva4-c987840161f8.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id 5J6hnNaLMQ-hRW0aKlN;
        Wed, 30 Oct 2019 14:43:27 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH] fs/ext4: get project quota from inode for mangling statfs
 results
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.com>, Li Xi <lixi@ddn.com>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
References: <157225912326.3929.8539227851002947260.stgit@buzz>
 <20191030105953.GC28525@quack2.suse.cz>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <dfb9185a-f16d-0a6f-06e1-219b7af59cd3@yandex-team.ru>
Date:   Wed, 30 Oct 2019 14:43:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191030105953.GC28525@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 30/10/2019 13.59, Jan Kara wrote:
> On Mon 28-10-19 13:38:43, Konstantin Khlebnikov wrote:
>> Right now ext4_statfs_project() does quota lookup by id every time.
>> This is costly operation, especially if there is no inode who hold
>> reference to this quota and dqget() reads it from disk each time.
>>
>> Function ext4_statfs_project() could be moved into generic quota code,
>> it is required for every filesystem which uses generic project quota.
>>
>> Reported-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>> ---
>>   fs/ext4/super.c |   25 ++++++++++++++++---------
>>   1 file changed, 16 insertions(+), 9 deletions(-)
>>
>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> index dd654e53ba3d..f841c66aa499 100644
>> --- a/fs/ext4/super.c
>> +++ b/fs/ext4/super.c
>> @@ -5532,18 +5532,23 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
>>   }
>>   
>>   #ifdef CONFIG_QUOTA
>> -static int ext4_statfs_project(struct super_block *sb,
>> -			       kprojid_t projid, struct kstatfs *buf)
>> +static int ext4_statfs_project(struct inode *inode, struct kstatfs *buf)
>>   {
>> -	struct kqid qid;
>> +	struct super_block *sb = inode->i_sb;
>>   	struct dquot *dquot;
>>   	u64 limit;
>>   	u64 curblock;
>> +	int err;
>> +
>> +	err = dquot_initialize(inode);
> 
> Hum, I'm kind of puzzled here: Your patch seems to be concerned with
> performance but how is this any faster than what we do now?
> dquot_initialize() will look up three dquots instead of one in the current
> code? Oh, I guess you are concerned about *repeated* calls to statfs() and
> thus repeated lookups of dquot structure? And this patch effectively caches
> looked up dquots in the inode?
> 
> That starts to make some sense but still, even if dquot isn't cached in any
> inode, we still hold on to it (it's in the free_list) until shrinker evicts
> it. So lookup of such dquot should be just a hash table lookup which should
> be very fast. Then there's the cost of dquot_acquire() / dquot_release()
> that get always called on first / last get of a dquot. So are you concerned
> about that cost? Or do you really see IO happening to fetch quota structure
> on each statfs call again and again? The only situation where I could see
> that happening is when the quota structure would be actually completely
> empty (i.e., not originally present in the quota file). But then this
> cannot be a case when there's actually an inode belonging to this
> project...
> 
> So I'm really curious about the details of what you are seeing as the
> changelog / patch doesn't quite make sense to me yet.

Yep, we have seen than disaster with non-present quota blocks.
For consistent quota performance loss should be much less significant,
but caching would not hurt.

Tools like "df" calls statfs for all mountpoints.
These inodes are never reclaimed because pinned by vfsmount.

> 
> 								Honza
> 
> 
>> +	if (err)
>> +		return err;
>> +
>> +	spin_lock(&inode->i_lock);
>> +	dquot = ext4_get_dquots(inode)[PRJQUOTA];
>> +	if (!dquot)
>> +		goto out_unlock;
>>   
>> -	qid = make_kqid_projid(projid);
>> -	dquot = dqget(sb, qid);
>> -	if (IS_ERR(dquot))
>> -		return PTR_ERR(dquot);
>>   	spin_lock(&dquot->dq_dqb_lock);
>>   
>>   	limit = (dquot->dq_dqb.dqb_bsoftlimit ?
>> @@ -5569,7 +5574,9 @@ static int ext4_statfs_project(struct super_block *sb,
>>   	}
>>   
>>   	spin_unlock(&dquot->dq_dqb_lock);
>> -	dqput(dquot);
>> +out_unlock:
>> +	spin_unlock(&inode->i_lock);
>> +
>>   	return 0;
>>   }
>>   #endif
>> @@ -5609,7 +5616,7 @@ static int ext4_statfs(struct dentry *dentry, struct kstatfs *buf)
>>   #ifdef CONFIG_QUOTA
>>   	if (ext4_test_inode_flag(dentry->d_inode, EXT4_INODE_PROJINHERIT) &&
>>   	    sb_has_quota_limits_enabled(sb, PRJQUOTA))
>> -		ext4_statfs_project(sb, EXT4_I(dentry->d_inode)->i_projid, buf);
>> +		ext4_statfs_project(dentry->d_inode, buf);
>>   #endif
>>   	return 0;
>>   }
>>

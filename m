Return-Path: <linux-fsdevel+bounces-36318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B519E16BB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 10:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 033F3B27E9F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 08:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8641D79A0;
	Tue,  3 Dec 2024 08:29:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2540D1BD50C;
	Tue,  3 Dec 2024 08:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733214579; cv=none; b=s3w5GJQs6WpyNwMjJLTddJ8bvLjFruwk/q22JCZx34w8P4qBECi0SS2PQCkmy1lxsmiyK6CrSUXM4bmAoAGefkrvKYbzxxBh0IYUqyD9CF6h2LkW8j9d+eNBn1TC6nuwDLevKOD/5jbZuumNYK1p4ApMJiIcqyf3zgbimBW5J/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733214579; c=relaxed/simple;
	bh=sPKy8bm3yUTC0HZtHiV+Cvibp3LmuP/kWLgsBwu6c2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FbAJRXb9Vju15G/J7AdW2YnZaOEhGB3m4TArbUUmAL3v/sZI6nvOpV3UoESAaSh/JEbrkn6Ayp058Xabr2wAQCvpAf9x5SBNcJJGvRLvPeLlVCu3FI+mPZLqo6G6R7vvsW/dYEIzUrafhiR+XrbBNuL3xcPi910gSu0Nf/AsOa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Y2Yfs69TQz1k19C;
	Tue,  3 Dec 2024 16:27:17 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 214F718001B;
	Tue,  3 Dec 2024 16:29:33 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 3 Dec
 2024 16:29:32 +0800
Message-ID: <8885691f-b977-409f-90f8-b24c41a49de0@huawei.com>
Date: Tue, 3 Dec 2024 16:29:31 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ext4: protect ext4_release_dquot against freezing
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
CC: <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.com>, Ritesh Harjani
	<ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>, Yang Erkun
	<yangerkun@huawei.com>
References: <20241121123855.645335-1-ojaswin@linux.ibm.com>
 <20241121123855.645335-3-ojaswin@linux.ibm.com>
 <cc2fcc33-9024-4ce8-bd52-cdcd23f6b455@huawei.com>
 <Z0a1x7yksOE4Jsha@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <Z0a1x7yksOE4Jsha@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2024/11/27 14:01, Ojaswin Mujoo wrote:
> On Tue, Nov 26, 2024 at 10:49:14PM +0800, Baokun Li wrote:
>> On 2024/11/21 20:38, Ojaswin Mujoo wrote:
>>> Protect ext4_release_dquot against freezing so that we
>>> don't try to start a transaction when FS is frozen, leading
>>> to warnings.
>>>
>>> Further, avoid taking the freeze protection if a transaction
>>> is already running so that we don't need end up in a deadlock
>>> as described in
>>>
>>>     46e294efc355 ext4: fix deadlock with fs freezing and EA inodes
>>>
>>> Suggested-by: Jan Kara <jack@suse.cz>
>>> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>>> ---
>>>    fs/ext4/super.c | 17 +++++++++++++++++
>>>    1 file changed, 17 insertions(+)
>>>
>>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>>> index 16a4ce704460..f7437a592359 100644
>>> --- a/fs/ext4/super.c
>>> +++ b/fs/ext4/super.c
>>> @@ -6887,12 +6887,25 @@ static int ext4_release_dquot(struct dquot *dquot)
>>>    {
>>>    	int ret, err;
>>>    	handle_t *handle;
>>> +	bool freeze_protected = false;
>>> +
>>> +	/*
>>> +	 * Trying to sb_start_intwrite() in a running transaction
>>> +	 * can result in a deadlock. Further, running transactions
>>> +	 * are already protected from freezing.
>>> +	 */
>>> +	if (!ext4_journal_current_handle()) {
>>> +		sb_start_intwrite(dquot->dq_sb);
>>> +		freeze_protected = true;
>>> +	}
>>>    	handle = ext4_journal_start(dquot_to_inode(dquot), EXT4_HT_QUOTA,
>>>    				    EXT4_QUOTA_DEL_BLOCKS(dquot->dq_sb));
>>>    	if (IS_ERR(handle)) {
>>>    		/* Release dquot anyway to avoid endless cycle in dqput() */
>>>    		dquot_release(dquot);
>>> +		if (freeze_protected)
>>> +			sb_end_intwrite(dquot->dq_sb);
>>>    		return PTR_ERR(handle);
>>>    	}
>>>    	ret = dquot_release(dquot);
>>> @@ -6903,6 +6916,10 @@ static int ext4_release_dquot(struct dquot *dquot)
>> The `git am` command looks for the following context code from line 6903
>> to apply the changes. But there are many functions in fs/ext4/super.c that
>> have similar code, such as ext4_write_dquot() and ext4_acquire_dquot().
> Oh that's strange, shouldn't it match the complete line like:
A rough look at the `git am` source code looks like it only focuses on
line numbers between two ‘@@’.

am_run
  run_apply
   apply_all_patches
    apply_patch
     parse_chunk
      find_header
       parse_fragment_header
     check_patch_list
      check_patch
       apply_data
        load_preimage
        apply_fragments
         apply_one_fragment
          find_pos
           match_fragment
>>> @@ -6903,6 +6916,10 @@ static int ext4_release_dquot(struct dquot *dquot)
> That should only have one occurence around line 6903? Or does it try to
> fuzzy match which ends up matching ext4_write_dquot etc?
In find_pos(), start from line 6903, compare the hash value of each line
of code line by line in forward direction, if it can't match, then match
the hash value of each line of code line by line in reverse direction from
line 6903. Fuzzy matching is used if some whitespace characters should be
ignored.


Regards,
Baokun



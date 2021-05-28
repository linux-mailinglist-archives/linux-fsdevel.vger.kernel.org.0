Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0E7393BCC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 May 2021 05:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236228AbhE1DIc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 23:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbhE1DIc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 23:08:32 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B94C061574;
        Thu, 27 May 2021 20:06:57 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id x10so41101plg.3;
        Thu, 27 May 2021 20:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5EWr/UPsn+8LytglWsMPVPEc0vhaEexKGGyaF6WchTI=;
        b=K2pde4eTG4laaqkR/Fb3JaZ8545CNvzs3jH/+v1wH+vtVl0kLTc6tDZqDrFLT+DyNs
         CutET31jqELKzE1X5TwNeXoQjzkPgfNOo+NfwbkFVgibdKBv3IpiW2gmlr1FXjKr2xrA
         4q5jQCIhCbLLAW8c2XAOpR6B8nYQ6dPgED4COAqlNOIDalnaG1nuvBcN6A3ih46C4/Hn
         9XbNsOLBZ+je3FTZcSBzXjMfd5hSDuIhjxryCvwkt5/4F/EorzVgif7SaJfYtheTcySN
         ZjP/Y+WfX6FCKbOErbwFDjn3Fdn10crSJxinpytxfQN9seWH3vPgVwRPLscHbGF1DYH2
         WIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5EWr/UPsn+8LytglWsMPVPEc0vhaEexKGGyaF6WchTI=;
        b=KJkewHeOVl9ZleiNhGoPR3U5it2XAOwcAKJlO0D2tmqU7dXVwXAWv9kybNXr3vyowB
         lhqFqAOxIciL5TSu1PN6Vtp69rKu7KDQxzuiXgy4MZMaxyDz6lvqpJfURK6ao59OlpH7
         1w1VoMyxbOXu/IMy5d1KArfkFkQnTYmWCN3yEWJDq4rR7/8tZzy/cixVr1xr1V6WBYw8
         BUBC6Q58WeZMeAd8H2s2pjXzOguHKqtLAqIF0r/GIBMDTJ/5xMVDIaegFk+d8pH0Lh7+
         0thzWH/sp8LTAZjJ5+SqSSidgBST3ppcZUp+F/g5NoFAM+P2MB+Ir0RiRvewKS6b+0Y/
         w7kw==
X-Gm-Message-State: AOAM531eIhQ1++sVz2kktKhYulXssxPCBHbEAMKYCTgtvGRASRsZAv9G
        M/WQRFfDB98WbxG7kMfjrgTIToYe5QkPAw==
X-Google-Smtp-Source: ABdhPJzITJcwiMkMk998Y9Cvrr3+GNT39k6cl1IYo8KMGAdA6ZG8Odn9rCwGL+ETAFlsW6MepSyF2Q==
X-Received: by 2002:a17:90b:1bca:: with SMTP id oa10mr1865214pjb.100.1622171216863;
        Thu, 27 May 2021 20:06:56 -0700 (PDT)
Received: from jianchwadeMacBook-Pro.local ([2402:5ec0:1fff:ffff:6f68:d793:b2e3:9de6])
        by smtp.gmail.com with ESMTPSA id k7sm3095177pjj.46.2021.05.27.20.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 20:06:56 -0700 (PDT)
Subject: Re: [PATCH V2 7/7] ext4: get discard out of jbd2 commit kthread
 contex
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        lishujin@kuaishou.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <164ffa3b-c4d5-6967-feba-b972995a6dfb@gmail.com>
 <a602a6ba-2073-8384-4c8f-d669ee25c065@gmail.com>
 <49382052-6238-f1fb-40d1-b6b801b39ff7@gmail.com>
 <48e33dea-d15e-f211-0191-e01bd3eb17b3@gmail.com>
 <67eeb65a-d413-c4f9-c06f-d5dcceca0e4f@gmail.com>
 <0b7915bc-193a-137b-4e52-8aaef8d6fef3@gmail.com>
 <a4e350a9-ef27-dc82-f610-0d3a0588afdf@gmail.com>
 <2BC51066-DC7C-4DAF-80B4-EEE8BD9FD814@dilger.ca>
From:   Wang Jianchao <jianchao.wan9@gmail.com>
Message-ID: <60e8710a-1d4a-e415-a364-f6f1c75c54d6@gmail.com>
Date:   Fri, 28 May 2021 11:06:52 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <2BC51066-DC7C-4DAF-80B4-EEE8BD9FD814@dilger.ca>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/5/28 4:18 AM, Andreas Dilger wrote:
> On May 26, 2021, at 2:44 AM, Wang Jianchao <jianchao.wan9@gmail.com> wrote:
>>
>> Right now, discard is issued and waited to be completed in jbd2
>> commit kthread context after the logs are committed. When large
>> amount of files are deleted and discard is flooding, jbd2 commit
>> kthread can be blocked for long time. Then all of the metadata
>> operations can be blocked to wait the log space.
>>
>> One case is the page fault path with read mm->mmap_sem held, which
>> wants to update the file time but has to wait for the log space.
>> When other threads in the task wants to do mmap, then write mmap_sem
>> is blocked. Finally all of the following read mmap_sem requirements
>> are blocked, even the ps command which need to read the /proc/pid/
>> -cmdline. Our monitor service which needs to read /proc/pid/cmdline
>> used to be blocked for 5 mins.
>>
>> This patch frees the blocks back to buddy after commit and then do
>> discard in a async kworker context in fstrim fashion, namely,
>> - mark blocks to be discarded as used if they have not been allocated
>> - do discard
>> - mark them free
>> After this, jbd2 commit kthread won't be blocked any more by discard
>> and we won't get NOSPC even if the discard is slow or throttled.
> 
> I definitely agree that sharing the existing fstrim functionality makes
> the most sense here.  Some comments inline on the implementation.
> 
>> Link: https://marc.info/?l=linux-kernel&m=162143690731901&w=2
>> Suggested-by: Theodore Ts'o <tytso@mit.edu>
>> Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
>> ---
>> fs/ext4/ext4.h    |   2 +
>> fs/ext4/mballoc.c | 162 +++++++++++++++++++++++++++++++++---------------------
>> fs/ext4/mballoc.h |   3 -
>> 3 files changed, 101 insertions(+), 66 deletions(-)
>>
>> @@ -3024,30 +3039,77 @@ static inline int ext4_issue_discard(struct super_block *sb,
>> 		return sb_issue_discard(sb, discard_block, count, GFP_NOFS, 0);
>> }
>>
>> -static void ext4_free_data_in_buddy(struct super_block *sb,
>> -				    struct ext4_free_data *entry)
>> +static void ext4_discard_work(struct work_struct *work)
>> {
>> +	struct ext4_sb_info *sbi = container_of(work,
>> +			struct ext4_sb_info, s_discard_work);
>> +	struct super_block *sb = sbi->s_sb;
>> +	ext4_group_t ngroups = ext4_get_groups_count(sb);
>> +	struct ext4_group_info *grp;
>> +	struct ext4_free_data *fd, *nfd;
>> 	struct ext4_buddy e4b;
>> -	struct ext4_group_info *db;
>> -	int err, count = 0, count2 = 0;
>> +	int i, err;
>> +
>> +	for (i = 0; i < ngroups; i++) {
>> +		grp = ext4_get_group_info(sb, i);
>> +		if (RB_EMPTY_ROOT(&grp->bb_discard_root))
>> +			continue;
> 
> For large filesystems there may be millions of block groups, so it
> seems inefficient to scan all of the groups each time the work queue

Yes it seems to be. At the moment I cooked the patch, I thought kwork is
running on background, it should not be a big deal. 

> is run.  Having a list of block group numbers, or bitmap/rbtree/xarray
> of the group numbers that need to be trimmed may be more efficient?

Maybe we can use a bitmap to record the bgs that need to be trimed

Best regards
Jianchao

> 
> Most of the complexity in the rest of the patch goes away if the trim
> tracking is only done on a whole-group basis (min/max or just a single
> bit per group).
> 
> Cheers, Andreas
> 
>> -	mb_debug(sb, "gonna free %u blocks in group %u (0x%p):",

> 
> 
> 
> 

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCCC613050
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 07:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiJaGb7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 02:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJaGb5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 02:31:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2172A7652;
        Sun, 30 Oct 2022 23:31:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A396EB8112D;
        Mon, 31 Oct 2022 06:31:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5611DC433D7;
        Mon, 31 Oct 2022 06:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667197914;
        bh=WMgot3r3lmIGWk8l/1uUXf340754ZrT4DVOXSAzPkY4=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=AwcaUC6GrQ/oLpwR4UQRmwFS+JjGMMjs1d1aI11H8Ff1OSfxuaI77glJG1ChBWUQ9
         yqptdMwauC4bstCap1l3DYqgZTiAR+c3WHPBdiUsbImRI8B0kEQi8w8SQR910VWrY5
         Yr0gvicOfeDk5LYLao5/0G7Yq+izPqS7X286jV6OFZIU6vB+QKgtoi6VUCybOTY95F
         e7OaH9of+VyBRr8myDdRUkZGMkK85FC1Fp1T7g4UkSe9BOpoQAC4rHlc9a3bP6sgj6
         zlU3L62/JLo4iYJz2RYAWhqMzC+M2k4L3ZH+8qV2WSzO+PAKBEukfMqDUDR/dIGCy6
         iOZYrW6y+fX9g==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-13c569e5ff5so12157394fac.6;
        Sun, 30 Oct 2022 23:31:54 -0700 (PDT)
X-Gm-Message-State: ACrzQf34Y6ukQyq1tHRgo4sA5yNRRcSQBeBK1s484DyULRkO07ijy2t4
        8M7GcOwWuIQqG/YHqUMKJ3EUdmNcvGE+Qgpgj7A=
X-Google-Smtp-Source: AMsMyM6wZuPRo9OagYDF9cG0wBpiY56+hnEbTmvL3KqDljUrDj80P69jRQHICLVd+/U4jU6e2K40T48kptxwNu8XGMw=
X-Received: by 2002:a05:6871:58b:b0:13c:be46:a02 with SMTP id
 u11-20020a056871058b00b0013cbe460a02mr5070202oan.8.1667197913541; Sun, 30 Oct
 2022 23:31:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6839:1a4e:0:0:0:0 with HTTP; Sun, 30 Oct 2022 23:31:53
 -0700 (PDT)
In-Reply-To: <014c01d8ecf0$6e74bc80$4b5e3580$@samsung.com>
References: <CGME20221019072854epcas1p2a2b272458803045b4dfa95b17fb4f547@epcas1p2.samsung.com>
 <PUZPR04MB631604A0BBD29713D3F8DAB0812B9@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <014c01d8ecf0$6e74bc80$4b5e3580$@samsung.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Mon, 31 Oct 2022 15:31:53 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9omiOTAaAWSnzE5jCQFDL8Nkok_wm_OAYwxVpgcCxykg@mail.gmail.com>
Message-ID: <CAKYAXd9omiOTAaAWSnzE5jCQFDL8Nkok_wm_OAYwxVpgcCxykg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] exfat: hint the empty entry which at the end of
 cluster chain
To:     Sungjong Seo <sj1557.seo@samsung.com>,
        Yuezhang Mo <Yuezhang.Mo@sony.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add missing Cc: Yuezhang Mo.

2022-10-31 15:17 GMT+09:00, Sungjong Seo <sj1557.seo@samsung.com>:
> Hi, Yuezhang Mo,
>
>> After traversing all directory entries, hint the empty directory
>> entry no matter whether or not there are enough empty directory
>> entries.
>>
>> After this commit, hint the empty directory entries like this:
>>
>> 1. Hint the deleted directory entries if enough;
>> 2. Hint the deleted and unused directory entries which at the
>>    end of the cluster chain no matter whether enough or not(Add
>>    by this commit);
>> 3. If no any empty directory entries, hint the empty directory
>>    entries in the new cluster(Add by this commit).
>>
>> This avoids repeated traversal of directory entries, reduces CPU
>> usage, and improves the performance of creating files and
>> directories(especially on low-performance CPUs).
>>
>> Test create 5000 files in a class 4 SD card on imx6q-sabrelite
>> with:
>>
>> for ((i=0;i<5;i++)); do
>>    sync
>>    time (for ((j=1;j<=1000;j++)); do touch file$((i*1000+j)); done)
>> done
>>
>> The more files, the more performance improvements.
>>
>>             Before   After    Improvement
>>    1~1000   25.360s  22.168s  14.40%
>> 1001~2000   38.242s  28.72ss  33.15%
>> 2001~3000   49.134s  35.037s  40.23%
>> 3001~4000   62.042s  41.624s  49.05%
>> 4001~5000   73.629s  46.772s  57.42%
>>
>> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
>> Reviewed-by: Andy Wu <Andy.Wu@sony.com>
>> Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>
>> ---
>>  fs/exfat/dir.c   | 26 ++++++++++++++++++++++----
>>  fs/exfat/namei.c | 22 ++++++++++++++--------
>>  2 files changed, 36 insertions(+), 12 deletions(-)
>>
>> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
>> index a569f285f4fd..7600f3521246 100644
>> --- a/fs/exfat/dir.c
>> +++ b/fs/exfat/dir.c
>> @@ -936,18 +936,25 @@ struct exfat_entry_set_cache
>> *exfat_get_dentry_set(struct super_block *sb,
>>
>>  static inline void exfat_hint_empty_entry(struct exfat_inode_info *ei,
>>  		struct exfat_hint_femp *candi_empty, struct exfat_chain *clu,
>> -		int dentry, int num_entries)
>> +		int dentry, int num_entries, int entry_type)
>>  {
>>  	if (ei->hint_femp.eidx == EXFAT_HINT_NONE ||
>>  	    ei->hint_femp.count < num_entries ||
>>  	    ei->hint_femp.eidx > dentry) {
>> +		int total_entries = EXFAT_B_TO_DEN(i_size_read(&ei-
>> >vfs_inode));
>> +
>>  		if (candi_empty->count == 0) {
>>  			candi_empty->cur = *clu;
>>  			candi_empty->eidx = dentry;
>>  		}
>>
>> -		candi_empty->count++;
>> -		if (candi_empty->count == num_entries)
>> +		if (entry_type == TYPE_UNUSED)
>> +			candi_empty->count += total_entries - dentry;
>
> This seems like a very good approach. Perhaps the key fix that improved
> performance seems to be the handling of cases where empty space was not
> found and ended with TYPE_UNUSED.
>
> However, there are concerns about trusting and using the number of free
> entries after TYPE_UNUSED calculated based on directory size. This is
> because, unlike exFAT Spec., in the real world, unexpected TYPE_UNUSED
> entries may exist. :(
> That's why exfat_search_empty_slot() checks if there is any valid entry
> after TYPE_UNUSED. In my experience, they can be caused by a wrong FS
> driver
> and H/W defects, and the probability of occurrence is not low.
>
> Therefore, when the lookup ends with TYPE_UNUSED, if there are no empty
> entries found yet, it would be better to set the last empty entry to
> hint_femp.eidx and set hint_femp.count to 0.
> If so, even if the lookup ends with TYPE_UNUSED, exfat_search_empty_slot()
> can start searching from the position of the last empty entry and check
> whether there are actually empty entries as many as the required
> num_entries as now.
>
> what do you think?
>
>> +		else
>> +			candi_empty->count++;
>> +
>> +		if (candi_empty->count == num_entries ||
>> +		    candi_empty->count + candi_empty->eidx == total_entries)
>>  			ei->hint_femp = *candi_empty;
>>  	}
>>  }
> [snip]
>> --
>> 2.25.1
>
>

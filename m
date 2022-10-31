Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9DD613048
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 07:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiJaGbE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 02:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiJaGbC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 02:31:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3026E7646;
        Sun, 30 Oct 2022 23:31:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE22160FD7;
        Mon, 31 Oct 2022 06:30:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351AEC433C1;
        Mon, 31 Oct 2022 06:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667197859;
        bh=wBOFg2KkW6zTkbxIFhT9XYLFofPkBuxJYP83GwiBeyA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=bRMY8huywR4hqF53NgxTYDvV/69u9v5ZgHnaELJfwvBk9xLm+GS6csBU0XCQ/bZLl
         ojDnsT3edSzcegIlmFav664wT/92/WG2iB4zIaYAu2tczTx5YX6EhHdBcHk54hFl1v
         m6/Fo2eNnieLu95x3igQNhKmb87VR6p6rSZmkz/31r6+8HRHy+0felouVlVYLiSu6y
         cl7Yav+ybrzDQHZ/y+C5w33UZlEDJvnMpmnZqry2eG60sKjH872eIV7GD5QrnQGIFt
         +8lzWxWnBPPWQO8akWHM5gRx47w8Bh034jCLecNwvYXIuY9Xbp8fRiZ1DUtCNWHrnO
         2urVpJ52r/f2w==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-12c8312131fso12555738fac.4;
        Sun, 30 Oct 2022 23:30:59 -0700 (PDT)
X-Gm-Message-State: ACrzQf2/ue7033MwnTvqvccC2Jz5j+HnwqGZoIyf50Hv7aZdrnSlzNL5
        4iTg7CpbuaI1fyHLWbGKawUmIjtmkwGXidH9oDQ=
X-Google-Smtp-Source: AMsMyM7rPiMCqfGIkMs3aCxnKe13r3XDdmLnlnS01BNOD+tL4v+2mP8a0izrjpUpHa2rcPrHxFRnzOscN9bvy44oZdY=
X-Received: by 2002:a05:6870:63aa:b0:13a:fe6c:5ed0 with SMTP id
 t42-20020a05687063aa00b0013afe6c5ed0mr6609243oap.257.1667197858356; Sun, 30
 Oct 2022 23:30:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6839:1a4e:0:0:0:0 with HTTP; Sun, 30 Oct 2022 23:30:58
 -0700 (PDT)
In-Reply-To: <000001d8ece8$0241bca0$06c535e0$@samsung.com>
References: <CGME20221019072850epcas1p459b27e0d44eb0cc36ec09e9a734dcf60@epcas1p4.samsung.com>
 <PUZPR04MB6316EBE97C82DFBEFE3CCDAF812B9@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <000001d8ece8$0241bca0$06c535e0$@samsung.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Mon, 31 Oct 2022 15:30:58 +0900
X-Gmail-Original-Message-ID: <CAKYAXd__ypbjLpnNVDxf3UE4M+au2QwYYe2PeY8QsKZCBaO54w@mail.gmail.com>
Message-ID: <CAKYAXd__ypbjLpnNVDxf3UE4M+au2QwYYe2PeY8QsKZCBaO54w@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] exfat: simplify empty entry hint
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

2022-10-31 14:16 GMT+09:00, Sungjong Seo <sj1557.seo@samsung.com>:
> Hello, Yuezhang Mo,
>
>> This commit adds exfat_hint_empty_entry() to reduce code complexity and
>> make code more readable.
>>
>> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
>> Reviewed-by: Andy Wu <Andy.Wu@sony.com>
>> Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>
>> ---
>>  fs/exfat/dir.c | 56 ++++++++++++++++++++++++++++----------------------
>>  1 file changed, 32 insertions(+), 24 deletions(-)
>>
>> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c index
>> 7b648b6662f0..a569f285f4fd 100644
>> --- a/fs/exfat/dir.c
>> +++ b/fs/exfat/dir.c
>> @@ -934,6 +934,24 @@ struct exfat_entry_set_cache
>> *exfat_get_dentry_set(struct super_block *sb,
>>  	return NULL;
>>  }
>>
>> +static inline void exfat_hint_empty_entry(struct exfat_inode_info *ei,
>> +		struct exfat_hint_femp *candi_empty, struct exfat_chain *clu,
>> +		int dentry, int num_entries)
>> +{
>> +	if (ei->hint_femp.eidx == EXFAT_HINT_NONE ||
>> +	    ei->hint_femp.count < num_entries ||
>
> It seems like a good approach.
> BTW, ei->hint_femp.count was already reset at the beginning of
> exfat_find_dir_entry(). So condition-check above could be removed.
> Is there any scenario I'm missing?
>
>> +	    ei->hint_femp.eidx > dentry) {
>> +		if (candi_empty->count == 0) {
>> +			candi_empty->cur = *clu;
>> +			candi_empty->eidx = dentry;
>> +		}
>> +
>> +		candi_empty->count++;
>> +		if (candi_empty->count == num_entries)
>> +			ei->hint_femp = *candi_empty;
>> +	}
>> +}
>> +
>>  enum {
>>  	DIRENT_STEP_FILE,
>>  	DIRENT_STEP_STRM,
>> @@ -958,7 +976,7 @@ int exfat_find_dir_entry(struct super_block *sb,
>> struct exfat_inode_info *ei,  {
>>  	int i, rewind = 0, dentry = 0, end_eidx = 0, num_ext = 0, len;
>>  	int order, step, name_len = 0;
>> -	int dentries_per_clu, num_empty = 0;
>> +	int dentries_per_clu;
>>  	unsigned int entry_type;
>>  	unsigned short *uniname = NULL;
>>  	struct exfat_chain clu;
>> @@ -976,7 +994,15 @@ int exfat_find_dir_entry(struct super_block *sb,
>> struct exfat_inode_info *ei,
>>  		end_eidx = dentry;
>>  	}
>>
>> -	candi_empty.eidx = EXFAT_HINT_NONE;
>> +	if (ei->hint_femp.eidx != EXFAT_HINT_NONE &&
>> +	    ei->hint_femp.count < num_entries)
>> +		ei->hint_femp.eidx = EXFAT_HINT_NONE;
>> +
>> +	if (ei->hint_femp.eidx == EXFAT_HINT_NONE)
>> +		ei->hint_femp.count = 0;
>> +
>> +	candi_empty = ei->hint_femp;
>> +
>
> It would be nice to make the code block above a static inline function as
> well.
>
>>  rewind:
>>  	order = 0;
>>  	step = DIRENT_STEP_FILE;
> [snip]
>> --
>> 2.25.1
>
>

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E860B665729
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 10:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238492AbjAKJRM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Jan 2023 04:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238487AbjAKJQl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:16:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8878FC6;
        Wed, 11 Jan 2023 01:13:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8DA92B81ACE;
        Wed, 11 Jan 2023 09:13:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D5BC433D2;
        Wed, 11 Jan 2023 09:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673428401;
        bh=0WVLdCVwcdgtGPOdr929/5D8vJGUAgy4wFl12/1hm9I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=urgqz4m9ghxcuXnHzqU12VEd6UaLsrYZDk02vDVv9vIKSWf35A8VyG+3dANyFgHyk
         hQS0KEdk32KFrcSXpuPH1qbITmgTEwcTU/FTQYRCYoEmlFxqgtka5VlU+4ePjdJUxg
         vZIV9fh/BqF9A3QJuDPM/kM46yxQBRo+oATSNlj7aTRzaciczDHXKxwYQeu+52P/2d
         wwRFbsrf/3MgnvaQL7RTgE5lcu18wNCYb0mYC6f7Ap230/FN3E5tNg+PZHR9X/kW1T
         SmMs5hhu+9EqruncQaA8HJnMIHNd15liZ3m8omnPphQ3VgsKiZlY4yMT7DyRL7dxQz
         M3LSxqXfMZawA==
Message-ID: <e015e927-283a-2685-07b5-11b28f12e4f9@kernel.org>
Date:   Wed, 11 Jan 2023 17:13:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] proc: fix to check name length in proc_lookup_de()
Content-Language: en-US
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20230110152112.1119517-1-chao@kernel.org> <Y72oBFXX6DiEh2/p@p183>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <Y72oBFXX6DiEh2/p@p183>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023/1/11 2:01, Alexey Dobriyan wrote:
> On Tue, Jan 10, 2023 at 11:21:12PM +0800, Chao Yu wrote:
>> __proc_create() has limited dirent's max name length with 255, let's
>> add this limitation in proc_lookup_de(), so that it can return
>> -ENAMETOOLONG correctly instead of -ENOENT when stating a file which
>> has out-of-range name length.
> 
> Both returns are correct and this is trading one errno for another.

Oh, but it looks ENOENT is a little bit ambiguity, it may indicate file name
length is valid for procfs, but the entry is not exist.

This change is trying to make lookup logic keeping align w/ most other
filesystems' behavior. Also it can avoid running into unneeded lookup logic
in proc_lookup_de() for such ENAMETOOLONG case.

How do you think? :)

Thanks,

> 
>> --- a/fs/proc/generic.c
>> +++ b/fs/proc/generic.c
>> @@ -246,6 +246,9 @@ struct dentry *proc_lookup_de(struct inode *dir, struct dentry *dentry,
>>   {
>>   	struct inode *inode;
>>   
>> +	if (dentry->d_name.len > PROC_NAME_LEN)
>> +		return ERR_PTR(-ENAMETOOLONG);

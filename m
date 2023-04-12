Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E686DED65
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 10:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjDLISm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 04:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDLISl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 04:18:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593B0101;
        Wed, 12 Apr 2023 01:18:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0DC7628BF;
        Wed, 12 Apr 2023 08:18:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6621EC4339B;
        Wed, 12 Apr 2023 08:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681287519;
        bh=QSicr5mrALt9A0DHx31xXuJbWSy0cFJuT000niRtI90=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sOz/Z4HbjF/d86Shdee4qy9zGXAma1nruikqtVEPJont9pf9mwWMWgS6KAKR56sRm
         lYFFrMSwP4V5qxYUIYclxVwyMJqoKAjfw3R794Qu0E4XVDstjkUrbvNTil7OJxUZQ9
         yRU4xg/t7gnUW3ozuldST4AMt9q9n5ik5hgamqnu7IpA9CNDjPG6Jx9ATF8b5R4tYh
         Suyxw6QDyT90J9sZS7gc9+7VlmVM6NivJShLnP11H31Qd9RET+h5gH21uW27VH3maR
         CNbfNR9hpi0jg+ZM2nvioRBeFMcWorGAiviZJITUP0LshWVtTGyN3Fger5n4J7J/qg
         +q6ugG66PeKbg==
Message-ID: <6899de08-252e-3558-fca7-b7f91b33ec61@kernel.org>
Date:   Wed, 12 Apr 2023 17:18:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] zonefs: remove unnecessary kobject_del()
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230412031904.13739-1-frank.li@vivo.com>
 <9a92e541-cf98-4ac5-c181-4a6ba76d08f8@kernel.org>
 <2023041238-stench-magnetism-0256@gregkh>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <2023041238-stench-magnetism-0256@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/12/23 17:11, Greg KH wrote:
> On Wed, Apr 12, 2023 at 05:04:16PM +0900, Damien Le Moal wrote:
>> On 4/12/23 12:19, Yangtao Li wrote:
>>> kobject_put() actually covers kobject removal automatically, which is
>>> single stage removal. So kill kobject_del() directly.
>>>
>>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>>> ---
>>>  fs/zonefs/sysfs.c | 1 -
>>>  1 file changed, 1 deletion(-)
>>>
>>> diff --git a/fs/zonefs/sysfs.c b/fs/zonefs/sysfs.c
>>> index 8ccb65c2b419..a535bdea1097 100644
>>> --- a/fs/zonefs/sysfs.c
>>> +++ b/fs/zonefs/sysfs.c
>>> @@ -113,7 +113,6 @@ void zonefs_sysfs_unregister(struct super_block *sb)
>>>  	if (!sbi || !sbi->s_sysfs_registered)
>>>  		return;
>>>  
>>> -	kobject_del(&sbi->s_kobj);
>>>  	kobject_put(&sbi->s_kobj);
>>>  	wait_for_completion(&sbi->s_kobj_unregister);
>>>  }
>>
>> What I am not sure about here is that if CONFIG_DEBUG_KOBJECT_RELEASE is
>> enabled, the kobj release is delayed, so the kobject will stay in sysfs
>> potentially after the umount() returns. Not exactly nice as that potentially
>> create races in user space... Not 100% sure though.
>>
>> Greg ? Any thoughts on this ?
> 
> Yes, it's all a mess :(
> 
> See the other messatges in this thread:
> 	https://lore.kernel.org/r/20230406120716.80980-1-frank.li@vivo.com
> 
> Please don't take this patch for now, this all needs to be revisited.
> 
> We have two reference counted objects with different lifespans trying to
> be embedded in the same structure, causing a mess.
> 
> But, if we split them apart, that too has issues.  I've been thinking
> about how to resolve this, but don't have any solid ideas yet, and been
> swamped with other things...
> 
> For now, let's just leave this all alone, it's not unique to this one
> filesystem, they all have the same pattern, and we need to solve them
> all properly at the same time by moving the common code into the driver
> core so that filesystems don't have to worry about this mess.

That was my thinking. Will try to think about a solution as well.
Likely, some helpers for FSes sysfs attributes somewhere in fs/*.c are needed to
not use the kobj directly as part of the fs_info structs.



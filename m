Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5F867FFB1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Jan 2023 15:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbjA2O7g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Jan 2023 09:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbjA2O71 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Jan 2023 09:59:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D8C1E9C1;
        Sun, 29 Jan 2023 06:59:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7595B80AFB;
        Sun, 29 Jan 2023 14:59:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49EBEC433D2;
        Sun, 29 Jan 2023 14:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675004340;
        bh=7PnkG6cXSgqkthc5IsQqkSUlfwU6Hep2/uLd/k+YrJ8=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=CR2y4HApF/O2D62eJ80aW1ipeS58H8YqfTtaiFxfiB3J/ty3LbhDBqRHuTFnIZvFC
         T2EkTcm8YS9pALut5rGfOURB4RASDqMRRrvN3iPj/np1jNv49lBA1tuTaaRjf1KsOw
         ajiz6UTOhERpY8HDcS+7sTnGcOrZaSLzUFU5U7t17j3JPGdmpMWTnI+e5LzB4BsYfp
         cHQDXugUL3SlTfz6QGDLpYVfD094VBwrajhLQ8IwdNCIglVvBrjnjjTbckWRCaMy5L
         92jrJ+knnzF5j9bc2p5yWzr57weNhl18vfefUpkoiL7oQHVEK8mOFCm9YTZ1nW5eLR
         YWOTUD7/iPq1Q==
Message-ID: <a746c612-7cb0-6085-9250-9ddfde8713df@kernel.org>
Date:   Sun, 29 Jan 2023 22:58:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     adobriyan@gmail.com, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20230112032720.1855235-1-chao@kernel.org>
 <20230112144323.2fa71c10876c0f5e0b5321a4@linux-foundation.org>
From:   Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] proc: remove mark_inode_dirty() in proc_notify_change()
In-Reply-To: <20230112144323.2fa71c10876c0f5e0b5321a4@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Andrew,

Sorry for the long delay. :(

On 2023/1/13 6:43, Andrew Morton wrote:
> On Thu, 12 Jan 2023 11:27:20 +0800 Chao Yu <chao@kernel.org> wrote:
> 
>> proc_notify_change() has updated i_uid, i_gid and i_mode into proc
>> dirent, we don't need to call mark_inode_dirty() for later writeback,
>> remove it.
>>
>> --- a/fs/proc/generic.c
>> +++ b/fs/proc/generic.c
>> @@ -127,7 +127,6 @@ static int proc_notify_change(struct user_namespace *mnt_userns,
>>   		return error;
>>   
>>   	setattr_copy(&init_user_ns, inode, iattr);
>> -	mark_inode_dirty(inode);
>>   
>>   	proc_set_user(de, inode->i_uid, inode->i_gid);
>>   	de->mode = inode->i_mode;
> 
> procfs call mark_inode_dirty() in three places.

Correct.

> 
> Does mark_inode_dirty() of a procfs file actually serve any purpose?

I don't see any particular reason that procfs inode needs to be set dirty,
as an in-memory filesystem, there is no backing device, so all attributes
should have been updated into procfs dirent directly in .setattr().

In fact, also procfs doesn't implement .dirty_inode, .write_inode or
.writepage{,s} interfaces which serves delayed inode update, pages writeback
after inode is set as dirty.

Thanks,

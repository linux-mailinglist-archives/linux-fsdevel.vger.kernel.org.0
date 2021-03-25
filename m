Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A430C349A4A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 20:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhCYTcI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 15:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhCYTbr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 15:31:47 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D45AC06174A;
        Thu, 25 Mar 2021 12:31:47 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 0A0F11F46850
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org, chao@kernel.org,
        drosen@google.com, yuchao0@huawei.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com,
        andre.almeida@collabora.com
Subject: Re: [PATCH v4 2/5] fs: Check if utf8 encoding is loaded before
 calling utf8_unload()
Organization: Collabora
References: <20210325000811.1379641-1-shreeya.patel@collabora.com>
        <20210325000811.1379641-3-shreeya.patel@collabora.com>
        <YFziza/VMyzEs4s1@sol.localdomain>
Date:   Thu, 25 Mar 2021 15:31:42 -0400
In-Reply-To: <YFziza/VMyzEs4s1@sol.localdomain> (Eric Biggers's message of
        "Thu, 25 Mar 2021 12:21:49 -0700")
Message-ID: <878s6bt4gx.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> writes:

> On Thu, Mar 25, 2021 at 05:38:08AM +0530, Shreeya Patel wrote:
>> utf8_unload is being called if CONFIG_UNICODE is enabled.
>> The ifdef block doesn't check if utf8 encoding has been loaded
>> or not before calling the utf8_unload() function.
>> This is not the expected behavior since it would sometimes lead
>> to unloading utf8 even before loading it.
>> Hence, add a condition which will check if sb->encoding is NOT NULL
>> before calling the utf8_unload().
>> 
>> Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
>> ---
>>  fs/ext4/super.c | 6 ++++--
>>  fs/f2fs/super.c | 9 ++++++---
>>  2 files changed, 10 insertions(+), 5 deletions(-)
>> 
>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> index ad34a37278cd..e438d14f9a87 100644
>> --- a/fs/ext4/super.c
>> +++ b/fs/ext4/super.c
>> @@ -1259,7 +1259,8 @@ static void ext4_put_super(struct super_block *sb)
>>  	fs_put_dax(sbi->s_daxdev);
>>  	fscrypt_free_dummy_policy(&sbi->s_dummy_enc_policy);
>>  #ifdef CONFIG_UNICODE
>> -	utf8_unload(sb->s_encoding);
>> +	if (sb->s_encoding)
>> +		utf8_unload(sb->s_encoding);
>>  #endif
>>  	kfree(sbi);
>>  }
>
>
> What's the benefit of this change?  utf8_unload is a no-op when passed a NULL
> pointer; why not keep it that way?

For the record, it no longer is a no-op after patch 5 of this series.
Honestly, I prefer making it explicitly at the caller that we are not
entering the function, like the patch does, instead of returning from it
immediately.  Makes it more readable, IMO.

-- 
Gabriel Krisman Bertazi

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA032B0136
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Nov 2020 09:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgKLIah (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 03:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgKLIag (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 03:30:36 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D6FC0613D1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2020 00:30:36 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id s2so2407182plr.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2020 00:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=TLFN/LATVHz0Otz4gum8L+XUbArBA5q5q9A2rFFljIc=;
        b=oaquZcLqDAsF+rz7+8RuM46hMW+J4ezejO51YSSW+wSDYfj0ayzKCuWUuEMYy0Z7vI
         HCAdHB0rKQYHaaCitTqAWElzyqYOs9yCP3kG7X2wQYShEd4iUqP8J31Cg2wU7z2Wbc9V
         cZb9v6k4A7U4VrGzEiebCyFuYka+EFVRMRWWFNziFXXkP7zxCtAo4KHlQaav/fk4SyuI
         i0qDZn56JZ2rvoxYr/AUOVd1j6eAyVQ6+MU4chF8fkTV2068AT1DLmLiniMJzYzA8vBl
         JiMap8RqFLfCUG2+c8pbx6sxVDxu6JKuh2VZ9QjJ2AOBsSlsW62KMr0VTZUhrASMHmdM
         ui9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=TLFN/LATVHz0Otz4gum8L+XUbArBA5q5q9A2rFFljIc=;
        b=X4vAcx1DFzmq8qOfG5AEJ6U4+hI+XMulSvmp5BHM6sZR6C9mxTYJx13llfGpHHA2Cx
         MfPOuKmZ3T12kmty2+klYipdGPYhvmwGW0UsqpcyfYf/uKkemsxNDG4rJ9fh/GZ+Gf6a
         +UKqMcC0ZILHNOKRQrX1b+K+lE97y7CwGzsMUHoUoEuOPmmP1zUCzZ2OdYugPNJm9y0o
         zMt0t4SsqCeYwvtf5pA+aH66mcLjND3H6Ej2lPu1vTYEqXlRvd0E6BgqFODgrFhBKUB8
         02CA0FNH0S3A9swTtuMQvh8D4+XP0RMBnCSQg6tP+6gnSBRaGFbJXzo4k3frdOd1OOxL
         8oDA==
X-Gm-Message-State: AOAM533unwCBJ8nWa2lotQXPtQaoJ2TntXn45RUT3Ngk09k5ZNYP0BJH
        WXQ0+V/p+iDsXBWE5AD1cJM=
X-Google-Smtp-Source: ABdhPJzIvGCoCaoEpnMCFNMhuT6+gAIR5opIOPmp1IFU3GqBM+iWYWMqOcn1M3IZ4y9AQ6Us88i2tQ==
X-Received: by 2002:a17:902:a9c7:b029:d6:da66:253c with SMTP id b7-20020a170902a9c7b02900d6da66253cmr1550636plr.19.1605169835994;
        Thu, 12 Nov 2020 00:30:35 -0800 (PST)
Received: from [192.168.0.12] ([125.186.151.199])
        by smtp.googlemail.com with ESMTPSA id n68sm5349463pfn.161.2020.11.12.00.30.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2020 00:30:35 -0800 (PST)
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix double free of unicode map
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     yuchao0@huawei.com, jaegeuk@kernel.org,
        linux-fsdevel@vger.kernel.org, hyeongseok.kim@lge.com,
        linux-f2fs-devel@lists.sourceforge.net,
        Daniel Rosenberg <drosen@google.com>
References: <20201112080201.149359-1-hyeongseok@gmail.com>
 <X6zvndTKKQfISlcj@sol.localdomain>
From:   hyeongseok <hyeongseok@gmail.com>
Message-ID: <41c4c6ac-ccde-1fb9-28bb-b22f8e1c34cb@gmail.com>
Date:   Thu, 12 Nov 2020 17:30:31 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <X6zvndTKKQfISlcj@sol.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: ko-KR
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/12/20 5:17 PM, Eric Biggers wrote:
> On Thu, Nov 12, 2020 at 05:02:01PM +0900, Hyeongseok Kim wrote:
>> In case of retrying fill_super with skip_recovery,
>> s_encoding for casefold would not be loaded again even though it's
>> already been freed because it's not NULL.
>> Set NULL after free to prevent double freeing when unmount.
>>
>> Signed-off-by: Hyeongseok Kim <hyeongseok@gmail.com>
>> ---
>>   fs/f2fs/super.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 00eff2f51807..fef22e476c52 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -3918,6 +3918,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>>   
>>   #ifdef CONFIG_UNICODE
>>   	utf8_unload(sb->s_encoding);
>> +	sb->s_encoding = NULL;
>>   #endif
>>   free_options:
>>   #ifdef CONFIG_QUOTA
>> -- 
> This is:
>
> Fixes: eca4873ee1b6 ("f2fs: Use generic casefolding support")
>
> Right?
>
> - Eric
>
Right. Should I add "Fixes" tag and send v2?


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624A91D1CAC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 19:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733070AbgEMR4P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 13:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732488AbgEMR4O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 13:56:14 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E49C061A0C
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2020 10:56:14 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id b15so518115ilq.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2020 10:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F16QtRSzf878DRAHE3ucRhzTHi9PQVc2FyzR7+y/rko=;
        b=gC6Ys2Z0X4VwL2tBzGS4x3OiTHrcdcOLARYEx4CguoyfFZEmU4tW2Ja48mydzgWx9B
         AS/BjGGUEfFjY2ALTRclJ/53GMtL/GU0s43O9XH4Hj+ik2iurcHuGpCjz+H302iTMblx
         EaeAJujlOc/UM+k5YOzD/iG25gUfMG5IiyWx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F16QtRSzf878DRAHE3ucRhzTHi9PQVc2FyzR7+y/rko=;
        b=QsnqfEzkXZ035T8FXwIF30OJmyycTE2DPwOl/OHKBxSK8JshT6Q/g4ncYnjPzf3YI0
         U3JJorI6jLeXskLdphEP0vTabugPEwH9wyKLCixtJ+PHUoiga4cosM5mdgEhuOn4cg6C
         R7xGRAOOVORjZ70b69u2FNJSdgYgxigJkrqdRvcCEob+/hKwWjwg9P+eYW6QNdGG6WXu
         DRnjvhX2ff6nsN12UJl5TQNqQI4Bt/X7pOsUIE6NPhhsRIuq3NIn93CU64wgIAqsYBVf
         tIRZ8JnKKz4TrgCwzGpXA06MLX2zvr5QyBafWdAi19SLKQaLwAByCU5h+hs36KGwlBqN
         nvMg==
X-Gm-Message-State: AOAM532+M5nKcC9alFTCYv7RGdcABVb01oVXEbpGmJjGPLFAUIBfqgF9
        5N2350jnjdyZhbloLMaM6q2a2g==
X-Google-Smtp-Source: ABdhPJwUOgAGpAYb/jTO3l+3l7qXYKvLIv6vcxoLLkh3FRieCG+8TXXKp1Lml1CQgay7kjWqptMGsQ==
X-Received: by 2002:a92:8144:: with SMTP id e65mr313116ild.242.1589392573981;
        Wed, 13 May 2020 10:56:13 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e13sm88045ils.27.2020.05.13.10.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 10:56:13 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] fs: avoid fdput() after failed fdget() in
 kernel_read_file_from_fd()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     axboe@kernel.dk, zohar@linux.vnet.ibm.com, mcgrof@kernel.org,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1589311577.git.skhan@linuxfoundation.org>
 <1159d74f88d100521c568037327ebc8ec7ffc6ef.1589311577.git.skhan@linuxfoundation.org>
 <20200513054950.GT23230@ZenIV.linux.org.uk>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <19709a34-68be-abb2-a8e1-f42e37a103ee@linuxfoundation.org>
Date:   Wed, 13 May 2020 11:56:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513054950.GT23230@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/12/20 11:49 PM, Al Viro wrote:
> On Tue, May 12, 2020 at 01:43:05PM -0600, Shuah Khan wrote:
>> Fix kernel_read_file_from_fd() to avoid fdput() after a failed fdget().
>> fdput() doesn't do fput() on this file since FDPUT_FPUT isn't set
>> in fd.flags. Fix it anyway since failed fdget() doesn't require
>> a fdput().
>>
>> This was introduced in a commit that added kernel_read_file_from_fd() as
>> a wrapper for the VFS common kernel_read_file().
>>
>> Fixes: b844f0ecbc56 ("vfs: define kernel_copy_file_from_fd()")
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>> ---
>>   fs/exec.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/exec.c b/fs/exec.c
>> index 06b4c550af5d..ea24bdce939d 100644
>> --- a/fs/exec.c
>> +++ b/fs/exec.c
>> @@ -1021,8 +1021,8 @@ int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
>>   		goto out;
>>   
>>   	ret = kernel_read_file(f.file, buf, size, max_size, id);
>> -out:
>>   	fdput(f);
>> +out:
>>   	return ret;
> 
> Again, that goto is a pointless obfuscation; just return -EBADF
> and be done with that.
> 

My reasoning is if this routine ends up growing it might be useful
to handle the return this way.

In any case, I will send v3 for both of these patches.

thanks,
-- Shuah

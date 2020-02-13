Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB0615CBB7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 21:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbgBMUKb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 15:10:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:51426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbgBMUKb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 15:10:31 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB6E424673;
        Thu, 13 Feb 2020 20:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581624631;
        bh=wCa5vRNZGSPGzqcXpTyE+mHqN/Ye42Xpuhgjo/0QB/s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nviCRg1g4MZAo0jKL456uD4cVnAykwAnapNmSYMDXqWZJw1ziRRyAUYClXejO8gEk
         qljLS/l1HBJwOPpefFXMCgNASTZ7WCRkVRpjiFV36MpTyl1JRIS+9HbQTeAZWD+uOU
         9V8/fJLMmUxaNNLCaix5dKc1eZtd9CCuONPTjs+Q=
Subject: Re: [PATCH] selftests: openat2: fix build error on newer glibc
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200213072656.15611-1-cyphar@cyphar.com>
From:   shuah <shuah@kernel.org>
Message-ID: <0126e205-e11e-f107-24b8-3673b1c749e3@kernel.org>
Date:   Thu, 13 Feb 2020 13:10:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200213072656.15611-1-cyphar@cyphar.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/13/20 12:26 AM, Aleksa Sarai wrote:
> It appears that newer glibcs check that openat(O_CREAT) was provided a
> fourth argument (rather than passing garbage), resulting in the
> following build error:
> 
>> In file included from /usr/include/fcntl.h:301,
>>                   from helpers.c:9:
>> In function 'openat',
>>      inlined from 'touchat' at helpers.c:49:11:
>> /usr/include/x86_64-linux-gnu/bits/fcntl2.h:126:4: error: call to
>> '__openat_missing_mode' declared with attribute error: openat with O_CREAT
>> or O_TMPFILE in third argument needs 4 arguments
>>    126 |    __openat_missing_mode ();
>>        |    ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> Reported-by: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
>   tools/testing/selftests/openat2/helpers.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/openat2/helpers.c b/tools/testing/selftests/openat2/helpers.c
> index e9a6557ab16f..5074681ffdc9 100644
> --- a/tools/testing/selftests/openat2/helpers.c
> +++ b/tools/testing/selftests/openat2/helpers.c
> @@ -46,7 +46,7 @@ int sys_renameat2(int olddirfd, const char *oldpath,
>   
>   int touchat(int dfd, const char *path)
>   {
> -	int fd = openat(dfd, path, O_CREAT);
> +	int fd = openat(dfd, path, O_CREAT, 0700);
>   	if (fd >= 0)
>   		close(fd);
>   	return fd;
> 

Thanks for a quick patch. It compiles now.

I will take this through kselftest tree.

thanks,
-- Shuah



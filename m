Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6131B54FDD1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jun 2022 21:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242751AbiFQTiX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jun 2022 15:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiFQTiW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jun 2022 15:38:22 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BDF22B2F
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 12:38:21 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id s1so3641393ilj.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 12:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wmbuV7JBORPXXzvNtfIZq/lTzS3aE7SHxRte41av5uM=;
        b=E0B1WMNGy43PvdJGAw2GYGQ5aKuCRPlGDVLSnor2QZJNSRe5zTPsqxbwe6DludNLxs
         R4wYYbLa/fc/Ecl0bf0NnRRH8HbpYCn+8yNpx2sS/CcpcFAfgg29nSpNUvdaE7ZyKLUe
         X2pIoc6EroL/LYddX/FkGtSPgP77qKkI6tr/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wmbuV7JBORPXXzvNtfIZq/lTzS3aE7SHxRte41av5uM=;
        b=6VfIt4HCVpBZZMcx1mD8rGkg8QCuzkZR4hhHJWOybCHxhgDW5d9tZ8CeZ/eWzbpG93
         a/uxbJft+19wqEEw0aHAJ2KgdZQtr8FkubAfG/ufAyhoTt5c2tCqHZt26g40qrUXAg+B
         7RUZs9sBElf8L7gBewV7j71WlsWXWXcQqRu7H0IsTfaCkKITB5I76L54D0DdWAXJVDxm
         tzIDE/Ptn9ZAZLX0SqMU+Lx4CbfUkmPyqWKlS6Qy8gPAJgnnN77tfBD8e2V9+r9UWtl2
         nEqi+uBfKf6awAOwKNLN2gC41mpgsL4goI+NGD4bfnQ8NKQglmBDBmihoP1MrcMKS5eZ
         qXfw==
X-Gm-Message-State: AJIora/sL2l227feax1XYF4Scqnw7+wjEmcJZl7hDth4CvGQ3U/7+naT
        pBRxi9LtjDGomOtUK8MUXss1yw==
X-Google-Smtp-Source: AGRyM1tEue9xzls/gET9Q/THpzqGhH2Ss/UxUuncgPwKpQV957JCH1xLpqkKlgCFSExHWhnOMXGSmw==
X-Received: by 2002:a05:6e02:1a23:b0:2d3:82bb:4dae with SMTP id g3-20020a056e021a2300b002d382bb4daemr6485677ile.62.1655494700776;
        Fri, 17 Jun 2022 12:38:20 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id m2-20020a6bbc02000000b006656f9eefa3sm2917727iof.18.2022.06.17.12.38.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 12:38:20 -0700 (PDT)
Subject: Re: [PATCH] selftests/proc: Fix proc-pid-vm for vsyscall=xonly.
To:     Dylan Hatch <dylanbhatch@google.com>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220616211016.4037482-1-dylanbhatch@google.com>
 <941e0991-eb3e-f988-8262-3d51ff8badad@linuxfoundation.org>
 <CADBMgpwt2ALzBTtEm7v6DLL_9pjUhVLDpBLHXn1b0bvVf2BSvg@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <47312e8a-87fe-c7dc-d354-74e81482bc1e@linuxfoundation.org>
Date:   Fri, 17 Jun 2022 13:38:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CADBMgpwt2ALzBTtEm7v6DLL_9pjUhVLDpBLHXn1b0bvVf2BSvg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/17/22 12:45 PM, Dylan Hatch wrote:
> On Thu, Jun 16, 2022 at 4:01 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 6/16/22 3:10 PM, Dylan Hatch wrote:
>>> This test would erroneously fail the /proc/$PID/maps case if
>>> vsyscall=xonly since the existing probe of the vsyscall page only
>>> succeeds if the process has read permissions. Fix this by checking for
>>> either no vsyscall mapping OR an execute-only vsyscall mapping in the
>>> case were probing the vsyscall page segfaults.
>>>
>>
>> Does this fix include skipping the test with a clear message that
>> says why test is skipped?
>>
>>> Signed-off-by: Dylan Hatch <dylanbhatch@google.com>
>>> ---
>>>    tools/testing/selftests/proc/proc-pid-vm.c | 20 +++++++++++++++-----
>>>    1 file changed, 15 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/proc/proc-pid-vm.c b/tools/testing/selftests/proc/proc-pid-vm.c
>>> index 28604c9f805c..5ca85520131f 100644
>>> --- a/tools/testing/selftests/proc/proc-pid-vm.c
>>> +++ b/tools/testing/selftests/proc/proc-pid-vm.c
>>> @@ -213,9 +213,12 @@ static int make_exe(const uint8_t *payload, size_t len)
>>>
>>>    static bool g_vsyscall = false;
>>>
>>> -static const char str_vsyscall[] =
>>> +static const char str_vsyscall_rx[] =
>>>    "ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0                  [vsyscall]\n";
>>>
>>> +static const char str_vsyscall_x[] =
>>> +"ffffffffff600000-ffffffffff601000 --xp 00000000 00:00 0                  [vsyscall]\n";
>>> +
>>>    #ifdef __x86_64__
>>>    static void sigaction_SIGSEGV(int _, siginfo_t *__, void *___)
>>>    {
>>> @@ -261,6 +264,7 @@ int main(void)
>>>        int exec_fd;
>>>
>>>        vsyscall();
>>> +     const char *str_vsyscall = g_vsyscall ? str_vsyscall_rx : str_vsyscall_x;
>>>
>>>        atexit(ate);
>>>
>>> @@ -314,7 +318,8 @@ int main(void)
>>>
>>>        /* Test /proc/$PID/maps */
>>>        {
>>> -             const size_t len = strlen(buf0) + (g_vsyscall ? strlen(str_vsyscall) : 0);
>>> +             const size_t len_buf0 = strlen(buf0);
>>> +             const size_t len_vsys = strlen(str_vsyscall);
>>>                char buf[256];
>>>                ssize_t rv;
>>>                int fd;
>>> @@ -325,11 +330,16 @@ int main(void)
>>>                        return 1;
>>>                }
>>>                rv = read(fd, buf, sizeof(buf));
>>> -             assert(rv == len);
>>> -             assert(memcmp(buf, buf0, strlen(buf0)) == 0);
>>>                if (g_vsyscall) {
>>> -                     assert(memcmp(buf + strlen(buf0), str_vsyscall, strlen(str_vsyscall)) == 0);
>>> +                     assert(rv == len_buf0 + len_vsys);
>>> +             } else {
>>> +                     /* If vsyscall isn't readable, it's either x-only or not mapped at all */
>>> +                     assert(rv == len_buf0 + len_vsys || rv == len_buf0);
>>>                }
>>> +             assert(memcmp(buf, buf0, len_buf0) == 0);
>>> +             /* Check for vsyscall mapping if buf is long enough */
>>> +             if (rv == len_buf0 + len_vsys)
>>> +                     assert(memcmp(buf + len_buf0, str_vsyscall, len_vsys) == 0);
>>>        }
>>>
>>>        /* Test /proc/$PID/smaps */
>>>
>>
>> The change looks good to me. Doesn't look like it skips the test though?
> 
> Instead of skipping the test, it changes the passing condition to
> accept both cases of an unmapped vsyscall page and an x-only vsyscall
> page. Differentiating between these two cases without relying on
> /proc/$PID/maps would involve both checking the kernel command line
> for vsyscall=xonly and having a special ifdef block for
> CONFIG_VSYSCALL_XONLY, so accepting both as passing conditions seems
> like a simpler solution.
> 

It depends on the goal of the test. Is the test looking to see if the
probe fails with insufficient permissions, then you are changing the
test to not check for that condition.

I would say in this case, the right approach would be to leave the test
as is and report expected fail and add other cases.

The goal being adding more coverage and not necessarily opt for a simple
solution.

thanks,
-- Shuah

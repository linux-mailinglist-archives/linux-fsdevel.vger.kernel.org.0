Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D16054FFDF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jun 2022 00:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbiFQW1i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jun 2022 18:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiFQW1g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jun 2022 18:27:36 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7609BE8A
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 15:27:34 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id v143so6919218oie.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 15:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BWoZH05gfMTA7sYUbTkU0N63/c9r6q3L+sOo8Fl00Ng=;
        b=Xgyi4MQcDW1OVDu1nFkyetAQAAdhN/kvJcA3uyoQR+T1CXxXyUwGN4a/pqHIDHVX4P
         07fxzEziBlveMKdrE416PECbuRmAyrHT+Kx96DJJ/+xyjg5WDtYkTeuAJdwdp4aCRAMr
         d97NyRLt9uX9EAw9QAQbWhcI1MQQJzTkHD6ug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BWoZH05gfMTA7sYUbTkU0N63/c9r6q3L+sOo8Fl00Ng=;
        b=NAp5yO5el2xr1QVft35xkWQXHTwPbyRetmM3jFimnexW7yPXhcML7i/KjEUkToipFg
         kPixBzq90rAJQ7kyTUW1Fd9AKaCV/NPZ3qLe9dMt/yhrULjO2oCeA6wpFXDnLxU1YhYk
         umNqf6v52/0WjfxdDCtVEx5i1abdhnzorhJ6Av6jI1Mo/ctQOac1kvpAHPq33mv8cfhI
         TPvRCpvAsaQnXOM1HXIVGJ4/2fjrKyYG7xYPVBDM3H4zHmpjKAMoritTcqhZx8dcVvPr
         O5IiWTlS9SnXCkJ7Yr3Xdi8k73pH/VzD2FQEdJchdEfuJDxIzSROpnI70cvnz4AwOz5r
         26Sw==
X-Gm-Message-State: AJIora+Y07XgAlAHdOrrvKBxg9GZ+w0vMfGEQlNwAQXcV/5pKZ8caXOP
        gIZTmMpi2rueSfQNgqWfuk1pGA==
X-Google-Smtp-Source: AGRyM1vwbUKpGIaPpmfhAkyPsgnwGP8/J7U2qq1EK/rp9ZP2Hd/8lvIt2wjzbVH62NfsvERArFJJ6Q==
X-Received: by 2002:a05:6808:23d6:b0:333:1a12:f682 with SMTP id bq22-20020a05680823d600b003331a12f682mr1216419oib.44.1655504853779;
        Fri, 17 Jun 2022 15:27:33 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id 89-20020a9d0362000000b0060603221281sm3223566otv.81.2022.06.17.15.27.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 15:27:33 -0700 (PDT)
Subject: Re: [PATCH] selftests/proc: Fix proc-pid-vm for vsyscall=xonly.
To:     Dylan Hatch <dylanbhatch@google.com>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220616211016.4037482-1-dylanbhatch@google.com>
 <941e0991-eb3e-f988-8262-3d51ff8badad@linuxfoundation.org>
 <CADBMgpwt2ALzBTtEm7v6DLL_9pjUhVLDpBLHXn1b0bvVf2BSvg@mail.gmail.com>
 <47312e8a-87fe-c7dc-d354-74e81482bc1e@linuxfoundation.org>
 <CADBMgpx9hwHaWe=m2kQhKOJFWnLSejoWa6wz1VECEkLhWq4qog@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a5f46e4e-a472-77ce-f61e-b2f9922bdd50@linuxfoundation.org>
Date:   Fri, 17 Jun 2022 16:27:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CADBMgpx9hwHaWe=m2kQhKOJFWnLSejoWa6wz1VECEkLhWq4qog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/17/22 4:05 PM, Dylan Hatch wrote:
> On Fri, Jun 17, 2022 at 12:38 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 6/17/22 12:45 PM, Dylan Hatch wrote:
>>> On Thu, Jun 16, 2022 at 4:01 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>>
>
>>
>> It depends on the goal of the test. Is the test looking to see if the
>> probe fails with insufficient permissions, then you are changing the
>> test to not check for that condition.
> 
> The goal of the test is to validate the output of /proc/$PID/maps, and
> the memory probe is only needed as setup to determine what the
> expected output should be. This used to be sufficient, but now it can
> no longer fully disambiguate it with the introduction of
> vsyscall=xonly. The solution proposed here is to disambiguate it by
> also checking the length read from /proc/$PID/maps.
> 
>>

Makes sense. However the question is does this test need to be enhanced
with the addition of vsyscall=xonly?

>> I would say in this case, the right approach would be to leave the test
>> as is and report expected fail and add other cases.
>>
>> The goal being adding more coverage and not necessarily opt for a simple
>> solution.
> 
> What does it mean to report a test as expected fail? Is this a
> mechanism unique to kselftest? I agree adding another test case would
> work, but I'm unsure how to do it within the framework of kselftest.
> Ideally, there would be separate test cases for vsyscall=none,
> vsyscall=emulate, and vsyscall=xonly, but these options can be toggled
> both in the kernel config and on the kernel command line, meaning (to
> the best of my knowledge) these test cases would have to be built
> conditionally against the conflig options and also parse the command
> line for the 'vsyscall' option.
> 

Expected fail isn't unique kselftest. It is a testing criteria where
a test is expected to fail. For example if a file can only be opened
with privileged user a test that runs and looks for failure is an
expected to fail case - we are looking for a failure.

A complete battery of tests for vsyscall=none, vsyscall=emulate,
vsyscall=xonly would test for conditions that are expected to pass
and fail based on the config.

tools/testing/selftests/proc/config doesn't have any config options
that are relevant to VSYSCALL

Can you please send me the how you are running the test and what the
failure output looks like?

thanks,
-- Shuah

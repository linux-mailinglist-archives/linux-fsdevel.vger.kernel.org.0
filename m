Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B27855521F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 19:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358288AbiFVRP7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 13:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235274AbiFVRP6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:15:58 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6CB10F5
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jun 2022 10:15:57 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id z7so602981ioe.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jun 2022 10:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U991fSAn0e5OZS8n2s3T8TVs+b1TUclU+3UhI11zgD8=;
        b=BLyBaiszrCrs1vOtd+028zjudoDFopra4uBSPF/4NSvS/7/1P0OqEJNhi6TdAFfFFf
         cxaifim4gniuyKxI4LmozvFGz+Fe+IkzstYW2hZP0/yrMFffhXnLeDZL/vQvmsTOia2T
         zUIszU7rZWknL4EUAKsGNQqbRBJOj6cFiwNbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U991fSAn0e5OZS8n2s3T8TVs+b1TUclU+3UhI11zgD8=;
        b=pyfkpRPafyrJyBW4l8Yag7JvuHFo8K1hx5YNTNiLPHo73TVjELF9MyB70gn5O3C6B4
         a+FTSINJUDAW+XnQ0ZKG63cJ+kIPqfNgY58zUI//L5m2hdQ7D8YorOJhlNQmCqpsrcYL
         KP+BdRBp1y0i5BMRrgUy9O9+uc+n4YcNaxHAMdm5eG9Li8Pk1TFyHzrK8WZ5rDClgGps
         8+7mfCdiJp1xBoRZFdPl9/6Qt20TLXgcHDEbWh+YhrcHxQ3K0JXELzruoIETt2xt0EmJ
         hwz7RdBHfHWUEyskjGtUAED4j1C4zhUMVK51L0RE0chZ6/lzmYRCV8HmNFmj2x7d+D1X
         7pZg==
X-Gm-Message-State: AJIora/z/ROiTUWOhhHwQbEROgXym8eaNI65J4coS0ecrF2ls4Np3Dnr
        E9Q2Xbu0HxQjpQUtgPENpDD4ZA==
X-Google-Smtp-Source: AGRyM1vMWbFbwbHk5Y8rFat/zxwyxlAxYc0W9Kg5pR33va+8Y3w2hjduUHVzjF5gp+dHUpfihWXXFA==
X-Received: by 2002:a05:6602:3d3:b0:65d:f99a:2ed1 with SMTP id g19-20020a05660203d300b0065df99a2ed1mr2306309iov.109.1655918156612;
        Wed, 22 Jun 2022 10:15:56 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id c9-20020a029609000000b00331d411da60sm8693375jai.75.2022.06.22.10.15.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 10:15:56 -0700 (PDT)
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
 <a5f46e4e-a472-77ce-f61e-b2f9922bdd50@linuxfoundation.org>
 <CADBMgpzyOKVO1ju_WkxYLhXGvwJjHoL6V-+Nw49UdTFoPY7NvQ@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b48cc574-302c-e74f-0720-9912f4663cbe@linuxfoundation.org>
Date:   Wed, 22 Jun 2022 11:15:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CADBMgpzyOKVO1ju_WkxYLhXGvwJjHoL6V-+Nw49UdTFoPY7NvQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/21/22 6:18 PM, Dylan Hatch wrote:
> On Fri, Jun 17, 2022 at 3:27 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 6/17/22 4:05 PM, Dylan Hatch wrote:
>>> On Fri, Jun 17, 2022 at 12:38 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>>
>>>> On 6/17/22 12:45 PM, Dylan Hatch wrote:
>>>>> On Thu, Jun 16, 2022 at 4:01 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>>>>
>>>
>>>>
>>>> It depends on the goal of the test. Is the test looking to see if the
>>>> probe fails with insufficient permissions, then you are changing the
>>>> test to not check for that condition.
>>>
>>> The goal of the test is to validate the output of /proc/$PID/maps, and
>>> the memory probe is only needed as setup to determine what the
>>> expected output should be. This used to be sufficient, but now it can
>>> no longer fully disambiguate it with the introduction of
>>> vsyscall=xonly. The solution proposed here is to disambiguate it by
>>> also checking the length read from /proc/$PID/maps.
>>>
>>>>
>>
>> Makes sense. However the question is does this test need to be enhanced
>> with the addition of vsyscall=xonly?
>>
>>>> I would say in this case, the right approach would be to leave the test
>>>> as is and report expected fail and add other cases.
>>>>
>>>> The goal being adding more coverage and not necessarily opt for a simple
>>>> solution.
>>>
>>> What does it mean to report a test as expected fail? Is this a
>>> mechanism unique to kselftest? I agree adding another test case would
>>> work, but I'm unsure how to do it within the framework of kselftest.
>>> Ideally, there would be separate test cases for vsyscall=none,
>>> vsyscall=emulate, and vsyscall=xonly, but these options can be toggled
>>> both in the kernel config and on the kernel command line, meaning (to
>>> the best of my knowledge) these test cases would have to be built
>>> conditionally against the conflig options and also parse the command
>>> line for the 'vsyscall' option.
>>>
>>
>> Expected fail isn't unique kselftest. It is a testing criteria where
>> a test is expected to fail. For example if a file can only be opened
>> with privileged user a test that runs and looks for failure is an
>> expected to fail case - we are looking for a failure.
>>
>> A complete battery of tests for vsyscall=none, vsyscall=emulate,
>> vsyscall=xonly would test for conditions that are expected to pass
>> and fail based on the config.
>>
>> tools/testing/selftests/proc/config doesn't have any config options
>> that are relevant to VSYSCALL
>>
>> Can you please send me the how you are running the test and what the
>> failure output looks like?
> 
> I'm building a kernel with the following relevant configurations:
> 
> $ cat .config | grep VSYSCALL
> CONFIG_GENERIC_TIME_VSYSCALL=y
> CONFIG_X86_VSYSCALL_EMULATION=y
> CONFIG_LEGACY_VSYSCALL_XONLY=y
> # CONFIG_LEGACY_VSYSCALL_NONE is not set
> 
> Running the test without this change both in virtme and on real
> hardware gives the following error:
> 
> # ./tools/testing/selftests/proc/proc-pid-vm
> proc-pid-vm: proc-pid-vm.c:328: int main(void): Assertion `rv == len' failed.
> Aborted
> 
> This is because when CONFIG_LEGACY_VSYSCALL_XONLY=y a probe of the
> vsyscall page results in a segfault. This test was originally written
> before this option existed so it incorrectly assumes the vsyscall page
> isn't mapped at all, and the expected buffer length doesn't match the
> result.
> 
> An alternate method of fixing this test could involve setting the
> expected result based on the config with #ifdef blocks, but I wasn't
> sure if that could be done for kernel config options in kselftest
> code. There's also the matter of checking the kernel command line for
> a `vsyscall=` arg, is parsing /proc/cmdline the best way to do this?
> 

We have a few tests do ifdef to be able to test the code as well as deal
with config specific tests. Not an issue.

Parsing /proc/cmdline line is flexible for sure, if you want to use that
route.

Thank you for finding the problem and identifying missing coverage. Look
forward to any patches fixing the problem.

thanks,
-- Shuah

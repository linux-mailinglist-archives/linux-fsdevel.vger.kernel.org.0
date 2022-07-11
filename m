Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4034570E1B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jul 2022 01:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiGKXRf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jul 2022 19:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiGKXRd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jul 2022 19:17:33 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C8C87F7F
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jul 2022 16:17:31 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id y3so6373644iof.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jul 2022 16:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X4V9spvk1I9jjtr8sVusqF9oSSPPa+R7P/GUBMC4gLc=;
        b=iL2mD/P0V4lfh23PpOV1RJOguNLsoUgdYgJwIjkRgS64rurYUXaVJSd3k7136hlWh+
         aSX3Sy9hkwO1TextBrkhg7/G0fkAst9YMLYeZGIPYO0n1vg88u4nguP2uIcjBSJdIG2s
         TQRIQWOEtYP10f+luBeND/Wq3Hi7OU8xOISJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X4V9spvk1I9jjtr8sVusqF9oSSPPa+R7P/GUBMC4gLc=;
        b=p/kLPyEWKjZew5vwTmcJmOFot45oFtMv7Db+IuWswbb2UvNhrPJXwZDkC0CedXMqqr
         T85I2peipFu8zRGgxP9yv7l+OJAOpG7LBXutVTv0zC/NTePSAVj8JVC0MNSIQgv6WbxN
         ZORdB/zzQ9vsfIur9DuFYdkGNdDBxKzaFEmSy1jZ+uAq2eIO45VedqLhFE9ESBXblrKu
         LTtKrrU8BXfrH9V+CFSZqtcka6O2S3tHfMW4KMKdsmPysz68cxaeB7PPaynoYg/J3uas
         XYiK/ZVoss/DSTnlPqErmPcOAcCwTtAWX9+l/azqqTalxvSAy9wJ/3XxdDKpCrGcClxM
         r0VQ==
X-Gm-Message-State: AJIora9NM0N+6a88oUaSvV1wEjl54Pwz3ssPAhVNsU2mIyud+CLES5mV
        DXZyVRm2D4WzVXVUFxlZNEQPT3jlCzBFPA==
X-Google-Smtp-Source: AGRyM1uj5haGzpa8pwS0HQnvZKEjcACNgX12g8/rtIBFbcZxuC0BrgiAPyKTyF5FN6ouZQ+LKJ9q5Q==
X-Received: by 2002:a05:6602:2e0c:b0:669:b7a8:fb0a with SMTP id o12-20020a0566022e0c00b00669b7a8fb0amr10334823iow.121.1657581450696;
        Mon, 11 Jul 2022 16:17:30 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id y20-20020a056e02119400b002dc239fbd04sm3185890ili.22.2022.07.11.16.17.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 16:17:30 -0700 (PDT)
Subject: Re: [PATCH v6 3/4] kunit: Taint the kernel when KUnit tests are run
To:     David Gow <davidgow@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Sebastian Reichel <sre@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Joe Fradley <joefradley@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220708044847.531566-1-davidgow@google.com>
 <20220708044847.531566-3-davidgow@google.com>
 <fc638852-ac9a-abab-8fdb-01b685cdec96@linuxfoundation.org>
 <CAGS_qxpODhSEs_sMm5Gu55EsYy-M9V98eLU-8O+xGMxncXmY4A@mail.gmail.com>
 <f25f96ce-1c9b-7e66-a5be-96d7cf2988cf@linuxfoundation.org>
 <a00efaa8-71e0-c531-b6a4-e3d695ad628b@linuxfoundation.org>
 <CABVgOSkroVjxTDoKTLBxiX_Fw5qZQmchDpY4U3XCCRYfXbS2bQ@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <4e5ca5b9-cdb8-4ddf-b057-27f721427f52@linuxfoundation.org>
Date:   Mon, 11 Jul 2022 17:17:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CABVgOSkroVjxTDoKTLBxiX_Fw5qZQmchDpY4U3XCCRYfXbS2bQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/8/22 9:35 PM, David Gow wrote:
> On Sat, Jul 9, 2022 at 5:24 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 7/8/22 3:22 PM, Shuah Khan wrote:
>>> On 7/8/22 3:00 PM, Daniel Latypov wrote:
>>>> On Fri, Jul 8, 2022 at 1:22 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>>>
>>>>> On 7/7/22 10:48 PM, David Gow wrote:
>>>>>> Make KUnit trigger the new TAINT_TEST taint when any KUnit test is run.
>>>>>> Due to KUnit tests not being intended to run on production systems, and
>>>>>> potentially causing problems (or security issues like leaking kernel
>>>>>> addresses), the kernel's state should not be considered safe for
>>>>>> production use after KUnit tests are run.
>>>>>>
>>>>>> This both marks KUnit modules as test modules using MODULE_INFO() and
>>>>>> manually taints the kernel when tests are run (which catches builtin
>>>>>> tests).
>>>>>>
>>>>>> Acked-by: Luis Chamberlain <mcgrof@kernel.org>
>>>>>> Tested-by: Daniel Latypov <dlatypov@google.com>
>>>>>> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
>>>>>> Signed-off-by: David Gow <davidgow@google.com>
>>>>>> ---
>>>>>>
>>>>>> No changes since v5:
>>>>>> https://lore.kernel.org/linux-kselftest/20220702040959.3232874-3-davidgow@google.com/
>>>>>>
>>>>>> No changes since v4:
>>>>>> https://lore.kernel.org/linux-kselftest/20220701084744.3002019-3-davidgow@google.com/
>>>>>>
>>>>>
>>>>> David, Brendan, Andrew,
>>>>>
>>>>> Just confirming the status of these patches. I applied v4 1/3 and v4 3/4
>>>>> to linux-kselftest kunit for 5.20-rc1.
>>>>> I am seeing v5 and v6 now. Andrew applied v5 looks like. Would you like
>>>>> me to drop the two I applied? Do we have to refresh with v6?
>>>>
>>>> Just noting here that there'll be a merge conflict between this patch
>>>> (3/4) and some other patches lined up to go through the kunit tree:
>>>> https://patchwork.kernel.org/project/linux-kselftest/patch/20220625050838.1618469-2-davidgow@google.com/
>>>>
>>>> Not sure how we want to handle that.
>>>>
>>>
>>> I can go drop the two patches and have Andrew carry the series through
>>> mm tree.
>>>
>>
>> Sorry spoke too soon. Yes there are others that might have conflicts as
>> Daniel pointed out:
>>
>> https://patchwork.kernel.org/project/linux-kselftest/patch/20220625050838.1618469-2-davidgow@google.com/
>>
>> thanks,
>> -- Shuah
>>
> 
> Thanks everyone for pointing these out.
> 
> I've rebased the other series (the KUnit module support one:
> https://lore.kernel.org/linux-kselftest/20220709032001.819487-1-davidgow@google.com/
> ) on top of this.
> 
> If they all go in via the kselftest/kunit tree, everything should be fine now.
> 
> Cheers,
> -- David
> 

Thank you David. All patches applied now to linux-kselftest kunit for 5.20-rc1

thanks,
-- Shuah

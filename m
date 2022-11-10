Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CE4624498
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Nov 2022 15:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiKJOpk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Nov 2022 09:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiKJOpi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Nov 2022 09:45:38 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5680F554F3
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Nov 2022 06:45:36 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id t4so1270339wmj.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Nov 2022 06:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ElDuHUZHiM1bGpzs5ou38zzllblj5DI9IW1M1Yt0P50=;
        b=OaF5C7rzAKEgktC4eN0TcGzuvj550ImBQVe5qE+aFDCuuJaU6OPiTfHB1f9sEQJW1P
         a7KRiRplvHcfiGjzC8dHqePkZVHfK6NT59RLIxYCBeRs35MxrWFuZwhEAY3p5gFKMJ0Z
         Xm/JeWoAh7Qjzcq3GfOfWENu7QrvAQIEep/B31Cf4LdpP775ItTcySZ6IB1pyxBBd/iz
         HSpL3xaHK8zTDlfRZV9GVvUwxZLDpwcCf2rBhDInNIIA+sIq9E4g6bJDcbHq+TuexHgQ
         b7WkQ5yoXhYcFwxUAQD4tG9nZ2OFJqkDWtrcOCZSklyjKtlfFZwsk6GO7KbKEujLgpFp
         icXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ElDuHUZHiM1bGpzs5ou38zzllblj5DI9IW1M1Yt0P50=;
        b=KrtZ15oGHRGb4w+elB9nPQiiDwvJtFQCnaDKzufTXQhoJm9TVijvVZJJdGFNGeX502
         MVJDMAED64q+f53kOqnoOWGMahZ1hrveaL/0nBRxPYl919jn8aIo++ZvfcJhbMztzUGC
         CtHr5d4bvlqST+CsiHLu74f3qsL8Hw5LYQY0I8XbTMfHkDv0MUtISjzhCDqN+2v0Zb6u
         UdlUnppvpuowVI9Lhj2w8ZNex/Vyi/z007g1LjNJYAKpaajZ870nv+jUM+4e05kHERgz
         x3nb+4FkkAYsveoeGptJXdbiDM6QGSE6xUCPdbtzGx4TTVA1wLjUJm80mEcY+Eb1oL45
         NIeA==
X-Gm-Message-State: ACrzQf3Je8KjmeS+FCpKutR6b7iQBc5aIFKNhg7tu354yT5QieeFyHmY
        rQ+wry+bqhUth/7splKSWRVGuw==
X-Google-Smtp-Source: AMsMyM6ZyCI5gRrCxV6Griy0N+86N9+UUa1vir1qlm25yDQNFlgP8KiD1FGW9nWQ1klM1KK+SvkcnA==
X-Received: by 2002:a05:600c:2053:b0:3cf:9b39:8585 with SMTP id p19-20020a05600c205300b003cf9b398585mr21533827wmg.106.1668091534904;
        Thu, 10 Nov 2022 06:45:34 -0800 (PST)
Received: from localhost ([95.148.15.66])
        by smtp.gmail.com with ESMTPSA id n15-20020a05600c3b8f00b003c6c3fb3cf6sm6368356wms.18.2022.11.10.06.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 06:45:34 -0800 (PST)
From:   Punit Agrawal <punit.agrawal@bytedance.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Punit Agrawal <punit.agrawal@bytedance.com>,
        akpm@linux-foundation.org, shuah@kernel.org, adobriyan@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [External] Re: [PATCH v2 1/2] selftests: proc: Fix
 proc-empty-vm build error on non x86_64
References: <20221109221104.1797802-1-punit.agrawal@bytedance.com>
        <6b6cd1e2-3ab7-eede-e04b-738bbcbb5760@linuxfoundation.org>
Date:   Thu, 10 Nov 2022 14:45:33 +0000
In-Reply-To: <6b6cd1e2-3ab7-eede-e04b-738bbcbb5760@linuxfoundation.org> (Shuah
        Khan's message of "Wed, 9 Nov 2022 17:20:23 -0700")
Message-ID: <87tu36zx4i.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Shuah,

Shuah Khan <skhan@linuxfoundation.org> writes:

> On 11/9/22 15:11, Punit Agrawal wrote:
>> The proc-empty-vm test is implemented for x86_64 and fails to build
>> for other architectures. Rather then emitting a compiler error it
>> would be preferable to only build the test on supported architectures.
>> Mark proc-empty-vm as a test for x86_64 and customise the Makefile
>> to
>> build it only when building for this target architecture.
>> Fixes: 5bc73bb3451b ("proc: test how it holds up with mapping'less
>> process")
>> Signed-off-by: Punit Agrawal <punit.agrawal@bytedance.com>
>> ---
>> v1 -> v2
>> * Fixed missing compilation on x86_64
>> Previous version
>> * https://lore.kernel.org/all/20221109110621.1791999-1-punit.agrawal@bytedance.com/
>> tools/testing/selftests/proc/Makefile | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>> diff --git a/tools/testing/selftests/proc/Makefile
>> b/tools/testing/selftests/proc/Makefile
>> index cd95369254c0..743aaa0cdd52 100644
>> --- a/tools/testing/selftests/proc/Makefile
>> +++ b/tools/testing/selftests/proc/Makefile
>> @@ -1,14 +1,16 @@
>>   # SPDX-License-Identifier: GPL-2.0-only
>> +
>> +# When ARCH not overridden for crosscompiling, lookup machine
>> +ARCH ?= $(shell uname -m 2>/dev/null || echo not)
>> +
>>   CFLAGS += -Wall -O2 -Wno-unused-function
>>   CFLAGS += -D_GNU_SOURCE
>>   LDFLAGS += -pthread
>>   -TEST_GEN_PROGS :=
>>   TEST_GEN_PROGS += fd-001-lookup
>>   TEST_GEN_PROGS += fd-002-posix-eq
>>   TEST_GEN_PROGS += fd-003-kthread
>>   TEST_GEN_PROGS += proc-loadavg-001
>> -TEST_GEN_PROGS += proc-empty-vm
>>   TEST_GEN_PROGS += proc-pid-vm
>>   TEST_GEN_PROGS += proc-self-map-files-001
>>   TEST_GEN_PROGS += proc-self-map-files-002
>> @@ -26,4 +28,8 @@ TEST_GEN_PROGS += thread-self
>>   TEST_GEN_PROGS += proc-multiple-procfs
>>   TEST_GEN_PROGS += proc-fsconfig-hidepid
>>   +TEST_GEN_PROGS_x86_64 += proc-empty-vm
>
> Why do you need this? You already have conditional compiles.
> Conditionally add proc-empty-vm to TEST_GEN_PROGS like other
> tests do.

I copied this approach from KVM tests. Looks like we've got a few
different ways of disabling compilation within selftests.

I can respin to conditionally compile as suggested if that is the way
forward.

>> +
>> +TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(ARCH))
>> +
>>   include ../lib.mk
>
> Same question Andrews asked you. What does it take to get this
> to work on other architectures. proc and vm tests should be
> arch. agnostic as a rule unless it is absolutely necessary to
> have them acrh. aware.

Please see my reply elsewhere in the thread for an assessment of the
architecture dependencies.

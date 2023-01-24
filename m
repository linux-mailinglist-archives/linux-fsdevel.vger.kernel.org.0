Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDE5679EE7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 17:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbjAXQjh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 11:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjAXQjg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:39:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55144C2E
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 08:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674578323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Rx2z0k7BUxOegxeHoQtWpkmv6MaMTCI5y68M3kfHOU=;
        b=VC0Nm3o4xcF34mhSEDz60fulKKS+fQ7g0Z0CCsyZ6oWBYRmFGh1UosEZBrArFNAR1n9IoP
        z8AXECIWf3e9yDG+mSENPy6/TL7sJ+Ffr4Ab0UGj04KXDyT0XIPqT84N1NF/z5grRy6RBV
        hhuLSRBi8qED5xHP7Zt8Zj9t2cvEmFc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-43-n18D80x_MuK3v_ddbpyi6g-1; Tue, 24 Jan 2023 11:38:42 -0500
X-MC-Unique: n18D80x_MuK3v_ddbpyi6g-1
Received: by mail-wm1-f71.google.com with SMTP id z11-20020a1c4c0b000000b003db062505b9so4153320wmf.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 08:38:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Rx2z0k7BUxOegxeHoQtWpkmv6MaMTCI5y68M3kfHOU=;
        b=2+rXt6DRMpVlUmgBzMt/vNBz1KHnxrXHi7r3Wd+oDzoyXXTUGp2sJ5DMZrC1h0EAjw
         o1JU+n7pJ2acEBVlVUDr0B3Hm99+8C6Gbm4FXCVDpE/lbFUewve9aDfr6E86dWp3iROM
         ZaTdUFPQJBE3RV8wvk68xfSgMOula9mnIv9Ad8tpZcvCc3q0RsJKbwYYMpzTX2P2XKHy
         xYJU6vnJsKQljXhECimdnekwld+P0Hpc/HJPSaXi9Ktt9rc1XfHO215WxpLc9KwkOO8+
         8HeLd7BYqlJyUuAmSIUxowINHtjM0sEJIEvgrPhBw2q+PDGFq7L/eQikGltOqAo5xLiN
         1x2A==
X-Gm-Message-State: AFqh2ko0x5h8E4qwYvXz98Jua00fFsLNXMisWAmlVBJ6iuMIz4Bihci4
        1k3e4Do0W4c9psYDZME73O5ToNAIycxgdx/lx9y/ujTJi5aC5gBXg5QqRYf2rM5w7CEthQVuqzM
        Ffttm2A+FcICwxjYJu5vHZRPdyA==
X-Received: by 2002:a1c:4b19:0:b0:3da:fb5c:8754 with SMTP id y25-20020a1c4b19000000b003dafb5c8754mr25522203wma.2.1674578321649;
        Tue, 24 Jan 2023 08:38:41 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvVtbfb9k89pLyrSioWTGvup1rj2EisIjnE2x0FKAleLGpTUyvPeeUYg++4LJXskdcWl0OzyA==
X-Received: by 2002:a1c:4b19:0:b0:3da:fb5c:8754 with SMTP id y25-20020a1c4b19000000b003dafb5c8754mr25522189wma.2.1674578321360;
        Tue, 24 Jan 2023 08:38:41 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:9d00:9303:90ce:6dcb:2bc9? (p200300cbc7079d00930390ce6dcb2bc9.dip0.t-ipconnect.de. [2003:cb:c707:9d00:9303:90ce:6dcb:2bc9])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c350f00b003db0b0cc2afsm15324053wmq.30.2023.01.24.08.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 08:38:40 -0800 (PST)
Message-ID: <5844ee9f-1992-a62a-2141-3b694a1e1915@redhat.com>
Date:   Tue, 24 Jan 2023 17:38:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Stefan Roesch <shr@devkernel.io>, linux-mm@kvack.org
Cc:     linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, CGEL <cgel.zte@gmail.com>,
        Michal Hocko <mhocko@kernel.org>, Jann Horn <jannh@google.com>
References: <20230123173748.1734238-1-shr@devkernel.io>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RESEND RFC PATCH v1 00/20] mm: process/cgroup ksm support
In-Reply-To: <20230123173748.1734238-1-shr@devkernel.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 23.01.23 18:37, Stefan Roesch wrote:
> So far KSM can only be enabled by calling madvise for memory regions. What is
> required to enable KSM for more workloads is to enable / disable it at the
> process / cgroup level.

Did you stumble over the proposals from last year to enable this 
per-process [1] and system-wide [2]? I remember there was also regarding 
enabling it system-wide.

I'm going to point out the security aspect, and that e.g., Windows used 
to enable it system-wide before getting taught by security experts 
otherwise. Details on KSM and security aspects can be found in that thread.

Long story short: one has to be very careful with that and only enable 
it for very carefully selected worklads. Letting a workload opt-in on a 
VMA level is most probably safer than an admin blindly turning this on 
for random processes ...

Last attempts got nacked ...

[1] 
https://lore.kernel.org/all/20220517092701.1662641-1-xu.xin16@zte.com.cn/
[2] https://lore.kernel.org/all/20220609055658.703472-1-xu.xin16@zte.com.cn/

> 
> 1. New options for prctl system command
> This patch series adds two new options to the prctl system call. The first
> one allows to enable KSM at the process level and the second one to query the
> setting.
> 
> The setting will be inherited by child processes.
> 
> With the above setting, KSM can be enabled for the seed process of a cgroup
> and all processes in the cgroup will inherit the setting.
> 
> 2. Changes to KSM processing
> When KSM is enabled at the process level, the KSM code will iterate over all
> the VMA's and enable KSM for the eligible VMA's.
> 
> When forking a process that has KSM enabled, the setting will be inherited by
> the new child process.
> 
> In addition when KSM is disabled for a process, KSM will be disabled for the
> VMA's where KSM has been enabled.
> 
> 3. Add tracepoints to KSM
> Currently KSM has no tracepoints. This adds tracepoints to the key KSM functions
> to make it easier to debug KSM.
> 
> 4. Add general_profit metric
> The general_profit metric of KSM is specified in the documentation, but not
> calculated. This adds the general profit metric to /sys/kernel/debug/mm/ksm.
> 
> 5. Add more metrics to ksm_stat
> This adds the process profit and ksm type metric to /proc/<pid>/ksm_stat.
> 
> 6. Add more tests to ksm_tests
> This adds an option to specify the merge type to the ksm_tests. This allows to
> test madvise and prctl KSM. It also adds a new option to query if prctl KSM has
> been enabled. It adds a fork test to verify that the KSM process setting is
> inherited by client processes.
> 
> 
> Stefan Roesch (20):
>    mm: add new flag to enable ksm per process
>    mm: add flag to __ksm_enter
>    mm: add flag to __ksm_exit call
>    mm: invoke madvise for all vmas in scan_get_next_rmap_item
>    mm: support disabling of ksm for a process
>    mm: add new prctl option to get and set ksm for a process
>    mm: add tracepoints to ksm
>    mm: split off pages_volatile function
>    mm: expose general_profit metric
>    docs: document general_profit sysfs knob
>    mm: calculate ksm process profit metric
>    mm: add ksm_merge_type() function
>    mm: expose ksm process profit metric in ksm_stat
>    mm: expose ksm merge type in ksm_stat
>    docs: document new procfs ksm knobs
>    tools: add new prctl flags to prctl in tools dir
>    selftests/vm: add KSM prctl merge test
>    selftests/vm: add KSM get merge type test
>    selftests/vm: add KSM fork test
>    selftests/vm: add two functions for debugging merge outcome
> 
>   Documentation/ABI/testing/sysfs-kernel-mm-ksm |   8 +
>   Documentation/admin-guide/mm/ksm.rst          |   8 +-
>   MAINTAINERS                                   |   1 +
>   fs/proc/base.c                                |   5 +
>   include/linux/ksm.h                           |  19 +-
>   include/linux/sched/coredump.h                |   1 +
>   include/trace/events/ksm.h                    | 257 ++++++++++++++++++
>   include/uapi/linux/prctl.h                    |   2 +
>   kernel/sys.c                                  |  29 ++
>   mm/ksm.c                                      | 134 ++++++++-
>   tools/include/uapi/linux/prctl.h              |   2 +
>   tools/testing/selftests/vm/Makefile           |   3 +-
>   tools/testing/selftests/vm/ksm_tests.c        | 254 ++++++++++++++---
>   13 files changed, 665 insertions(+), 58 deletions(-)
>   create mode 100644 include/trace/events/ksm.h
> 
> 
> base-commit: c1649ec55708ae42091a2f1bca1ab49ecd722d55

-- 
Thanks,

David / dhildenb


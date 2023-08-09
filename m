Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DE37755E8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 10:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjHIIy5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 04:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjHIIy4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 04:54:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF0910C8
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Aug 2023 01:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691571248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z99Te0ewydPNT8GWInBn0+qpbTNem2LwIV3S4FZb4eQ=;
        b=d2QWDonR9sn8+VmFzZMI2gz12E7AIPMoNHaVmlpKP765uxGX3talXcEBO4rm5yJz3HdJSu
        d1d7j5XU9fyDjytK8j78gnzmycBASej0VL5vRA+Lq8TTThnsExZRM+6MLjFS007kupfVLM
        iopPgEsw8W6XuMosIBmaz+f/iCeYcpw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-pz79SnzRMOeRiXCzL5KX0g-1; Wed, 09 Aug 2023 04:54:06 -0400
X-MC-Unique: pz79SnzRMOeRiXCzL5KX0g-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3176c4de5bbso3159738f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Aug 2023 01:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691571245; x=1692176045;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z99Te0ewydPNT8GWInBn0+qpbTNem2LwIV3S4FZb4eQ=;
        b=iu1Td9YxNrHJtdW0CZc1QV+0kgGS1WKeLaKgnvOKlx+0eIwO67TNTLuc7fx6uuHhkY
         vO8hkTp+rIXmCJhMTJ4uHfS2t+FfQNZHaS+GIYavoV40z7wlsMU9dBTbuQcoq1PiyQB5
         5MB5eY6kJ2xcL+SaKz5B9IBN3U3O15LXngJCpvEXt4OByuo9p1Ab1O9PYoIXsvjBvmB5
         ip1aPEerhX92uOx4C5MqQNnHKtvQK7YyqhbJ8KFHe008tcwMXjIi3VmuUN4KChjzlBUu
         tv6BqtnjhRmjOZ0c3aWxFdFA8/vB4oxbltzu+J+aJr3cegb1oD0nKHxV5djEJJLPvW5t
         n4Ig==
X-Gm-Message-State: AOJu0YwJR4JvB0uBXUHdyBQD2knumhgmipkAD4D70T1G9JZEvn9sur/L
        DvSisqxCmZy8x5XANkOTCmpfmNQOvmzxcEyBAYVxBmW/SBl9fE33XU2P0lNSPVZ4vxwDZZ4R/33
        N5cRkPl5SNn+CEMKDG3R1BL3mY4dzDoIacg==
X-Received: by 2002:adf:ea4d:0:b0:314:2ea7:af4a with SMTP id j13-20020adfea4d000000b003142ea7af4amr1453951wrn.13.1691571245524;
        Wed, 09 Aug 2023 01:54:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFHr4ZAWKsMDxNFfYtBhictKcmgQlwLG0UV+p2IJItpYwU1UDsTqsJ7WNVZyAEgyT92S/6Qw==
X-Received: by 2002:adf:ea4d:0:b0:314:2ea7:af4a with SMTP id j13-20020adfea4d000000b003142ea7af4amr1453932wrn.13.1691571245082;
        Wed, 09 Aug 2023 01:54:05 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70e:6800:9933:28db:f83a:ef5? (p200300cbc70e6800993328dbf83a0ef5.dip0.t-ipconnect.de. [2003:cb:c70e:6800:9933:28db:f83a:ef5])
        by smtp.gmail.com with ESMTPSA id h5-20020a05600004c500b003143aa0ca8asm16196386wri.13.2023.08.09.01.54.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 01:54:04 -0700 (PDT)
Message-ID: <107af1a4-a6ff-9048-07bd-248336e44980@redhat.com>
Date:   Wed, 9 Aug 2023 10:54:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1] proc/ksm: add ksm stats to /proc/pid/smaps
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Stefan Roesch <shr@devkernel.io>
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        hannes@cmpxchg.org, riel@surriel.com
References: <20230808170858.397542-1-shr@devkernel.io>
 <20230808101713.766c270cc0465c3938f24182@linux-foundation.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230808101713.766c270cc0465c3938f24182@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08.08.23 19:17, Andrew Morton wrote:
> On Tue,  8 Aug 2023 10:08:58 -0700 Stefan Roesch <shr@devkernel.io> wrote:
> 
>> With madvise and prctl KSM can be enabled for different VMA's. Once it
>> is enabled we can query how effective KSM is overall. However we cannot
>> easily query if an individual VMA benefits from KSM.
>>
>> This commit adds a KSM section to the /prod/<pid>/smaps file. It reports
>> how many of the pages are KSM pages.
>>
>> Here is a typical output:
>>
>> 7f420a000000-7f421a000000 rw-p 00000000 00:00 0
>> Size:             262144 kB
>> KernelPageSize:        4 kB
>> MMUPageSize:           4 kB
>> Rss:               51212 kB
>> Pss:                8276 kB
>> Shared_Clean:        172 kB
>> Shared_Dirty:      42996 kB
>> Private_Clean:       196 kB
>> Private_Dirty:      7848 kB
>> Referenced:        15388 kB
>> Anonymous:         51212 kB
>> KSM:               41376 kB
>> LazyFree:              0 kB
>> AnonHugePages:         0 kB
>> ShmemPmdMapped:        0 kB
>> FilePmdMapped:         0 kB
>> Shared_Hugetlb:        0 kB
>> Private_Hugetlb:       0 kB
>> Swap:             202016 kB
>> SwapPss:            3882 kB
>> Locked:                0 kB
>> THPeligible:    0
>> ProtectionKey:         0
>> ksm_state:          0
>> ksm_skip_base:      0
>> ksm_skip_count:     0
>> VmFlags: rd wr mr mw me nr mg anon
>>
>> This information also helps with the following workflow:
>> - First enable KSM for all the VMA's of a process with prctl.
>> - Then analyze with the above smaps report which VMA's benefit the most
>> - Change the application (if possible) to add the corresponding madvise
>> calls for the VMA's that benefit the most
> 
> smaps is documented in Documentation/filesystems/proc.rst, please.
> (And it looks a bit out of date).
> 
> Did you consider adding this info to smaps_rollup as well?

It would be great to resend that patch to linux-mm + kernel. Otherwise 
I'll have to do some digging / downloading from linux-fsdevel ;)

-- 
Cheers,

David / dhildenb


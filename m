Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59EC477C878
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Aug 2023 09:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbjHOHUo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Aug 2023 03:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234771AbjHOHUP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Aug 2023 03:20:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576B5E5B
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Aug 2023 00:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692083967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nhUenfMGwp0x5jxIRMORVV7d69eUXbxJCsT6e0oA0vs=;
        b=ix0NyW0zdzcUeW03yUucwPmHT3P8+mJAeIHMEaEAjdg3dw2KcpOXsTUCzZiZo3r88zD/uj
        +qHs/H2BI9LaMJ13D1kyD9VqVFM7r8ync0DiJramjTgfhGdsD8QgmPPC2rwZ8gJ5wxGZLN
        0T2RdM7bXKqR/0XPM/7SL4e73RKLT+s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-xxo_3ReOPg6xFVLr-mrIdg-1; Tue, 15 Aug 2023 03:19:25 -0400
X-MC-Unique: xxo_3ReOPg6xFVLr-mrIdg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3196e92c3f6so1030882f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Aug 2023 00:19:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692083964; x=1692688764;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nhUenfMGwp0x5jxIRMORVV7d69eUXbxJCsT6e0oA0vs=;
        b=aFSU3rm7a7nqob6sV40Biv4to1Pg3hn+L5A2A3n4akMvcEmWr9UIq7W/FmdU4aWtZq
         4850ocOmwjFJTu9H6KhRwryUitedHHXhv6zpKWY958EBP+blyhlQauMMOyu37INGRxnZ
         RTTVIIDy1DD/oOfjcDVXmgG9/XGE+R0SG/wyZpL25b9aENP5E8Ehg9OnGvBxLXR5ZI1x
         iOEnsp+vBw6NLvkgvdm6sZ6zDuKhOuAgGSPbGu921O1nb9JWhDxSN1qMqP+t2ZEKchI8
         p+yQZcBn/bYp3WomNiLePGAU0BIZ5BFgSu3QNEpklzdzvXWh4mVx2iMp14F4F3Pk2Duz
         vmXw==
X-Gm-Message-State: AOJu0Yx6Qkq0hj1eTspn7eD+f54GBI+QADi+nsOPy52RH5XzuScz1aYD
        TXB98MWuofIgj+ZyTq+KWf6Pn/ExnYQ+ASCupIsT/MdFkRuhELvdv4RU7qK9sQnS8K8cQ468Yxo
        vafeSDER4iDDQKhttOvHTtx7H6g==
X-Received: by 2002:a5d:5945:0:b0:317:597f:3aa6 with SMTP id e5-20020a5d5945000000b00317597f3aa6mr875029wri.18.1692083964478;
        Tue, 15 Aug 2023 00:19:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBvNLJnqnIvB7tpGpds9xV93tOCXiH5bAU3H7ji/HpMR5b/Pe1T1NZ0nGfIBCeqH+mr8CAhg==
X-Received: by 2002:a5d:5945:0:b0:317:597f:3aa6 with SMTP id e5-20020a5d5945000000b00317597f3aa6mr875008wri.18.1692083964102;
        Tue, 15 Aug 2023 00:19:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:3100:c642:ba83:8c37:b0e? (p200300cbc7013100c642ba838c370b0e.dip0.t-ipconnect.de. [2003:cb:c701:3100:c642:ba83:8c37:b0e])
        by smtp.gmail.com with ESMTPSA id c6-20020adfe746000000b003197c7d08ddsm4163213wrn.71.2023.08.15.00.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 00:19:23 -0700 (PDT)
Message-ID: <43d64aee-4bd9-bba0-9434-55cec26bd9dc@redhat.com>
Date:   Tue, 15 Aug 2023 09:19:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] proc/ksm: add ksm stats to /proc/pid/smaps
Content-Language: en-US
To:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        hannes@cmpxchg.org, riel@surriel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230811162803.1361989-1-shr@devkernel.io>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230811162803.1361989-1-shr@devkernel.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sorry for the late reply, Gmail once again decided to classify your 
mails as spam (for whatever reason).

On 11.08.23 18:28, Stefan Roesch wrote:
> With madvise and prctl KSM can be enabled for different VMA's. Once it
> is enabled we can query how effective KSM is overall. However we cannot
> easily query if an individual VMA benefits from KSM.
> 
> This commit adds a KSM section to the /prod/<pid>/smaps file. It reports
> how many of the pages are KSM pages.
> 
> Here is a typical output:
> 
> 7f420a000000-7f421a000000 rw-p 00000000 00:00 0
> Size:             262144 kB
> KernelPageSize:        4 kB
> MMUPageSize:           4 kB
> Rss:               51212 kB
> Pss:                8276 kB
> Shared_Clean:        172 kB
> Shared_Dirty:      42996 kB
> Private_Clean:       196 kB
> Private_Dirty:      7848 kB
> Referenced:        15388 kB
> Anonymous:         51212 kB
> KSM:               41376 kB
> LazyFree:              0 kB
> AnonHugePages:         0 kB
> ShmemPmdMapped:        0 kB
> FilePmdMapped:         0 kB
> Shared_Hugetlb:        0 kB
> Private_Hugetlb:       0 kB
> Swap:             202016 kB
> SwapPss:            3882 kB
> Locked:                0 kB
> THPeligible:    0
> ProtectionKey:         0
> ksm_state:          0
> ksm_skip_base:      0
> ksm_skip_count:     0
> VmFlags: rd wr mr mw me nr mg anon
> 
> This information also helps with the following workflow:
> - First enable KSM for all the VMA's of a process with prctl.
> - Then analyze with the above smaps report which VMA's benefit the most
> - Change the application (if possible) to add the corresponding madvise
> calls for the VMA's that benefit the most
> 
> Signed-off-by: Stefan Roesch <shr@devkernel.io>
> ---
>   Documentation/filesystems/proc.rst | 3 +++
>   fs/proc/task_mmu.c                 | 5 +++++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 7897a7dafcbc..4ef3c0bbf16a 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -461,6 +461,7 @@ Memory Area, or VMA) there is a series of lines such as the following::
>       Private_Dirty:         0 kB
>       Referenced:          892 kB
>       Anonymous:             0 kB
> +    KSM:                   0 kB
>       LazyFree:              0 kB
>       AnonHugePages:         0 kB
>       ShmemPmdMapped:        0 kB
> @@ -501,6 +502,8 @@ accessed.
>   a mapping associated with a file may contain anonymous pages: when MAP_PRIVATE
>   and a page is modified, the file page is replaced by a private anonymous copy.
>   
> +"KSM" shows the amount of anonymous memory that has been de-duplicated.


How do we want to treat memory that has been deduplicated into the 
shared zeropage?

It would also match this description.

See in mm-stable:

commit 30ff6ed9a65c7e73545319fc15f7bcf9c52457eb
Author: xu xin <xu.xin16@zte.com.cn>
Date:   Tue Jun 13 11:09:28 2023 +0800

     ksm: support unsharing KSM-placed zero pages

     Patch series "ksm: support tracking KSM-placed zero-pages", v10.


-- 
Cheers,

David / dhildenb


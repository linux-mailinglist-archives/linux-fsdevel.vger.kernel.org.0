Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7B958E941
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Aug 2022 11:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbiHJJDZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Aug 2022 05:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbiHJJDR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Aug 2022 05:03:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 962A9868AA
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Aug 2022 02:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660122195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zDfT4OTVP3mlZybmyw3sBtbkZmpGAIdes/TJqqs05cY=;
        b=K41H2IPUCe719RNH+3PxUB4HiOEMzqAiee70EBMEGPSp+05paCus67bm6WKAsbeu5BpVQS
        wNVujc69GzXls0AaUIWivGtx5X9Nm+/StgrSCVgF9u/z3YcGHqRvDIXabKYN0pTIoxdqdM
        f+pb2iJqDG8dGHrVZifT+JOO55CEu9w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-YNAx-gqlMxWOGTt4-5WomA-1; Wed, 10 Aug 2022 05:03:14 -0400
X-MC-Unique: YNAx-gqlMxWOGTt4-5WomA-1
Received: by mail-wr1-f69.google.com with SMTP id c20-20020adfa314000000b0021f1757ea8aso2162248wrb.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Aug 2022 02:03:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=zDfT4OTVP3mlZybmyw3sBtbkZmpGAIdes/TJqqs05cY=;
        b=u4uEgOsdAL+qQQ/EeKUrG7gaMoNwqmOmnpMN9bBQe1Pit8STMDSvgbOgV4Qscsx8hg
         Kosie4jvSzaDboUcoRnBDMf1w7wmVsLzeSKmn/lLLRsyePa2jw8r8fv7LFTd8MxlSiBC
         XpEULcELslRXWNiVdikyy6hcBG7dmztzSOHXjhqzLmiCF+TYDLlz/zhAj4obz/VsD76g
         drER0PX3rxK+1WfzZJjNHy6m9kfP3iWCDnoTy5IxM72HYosfUjLN2MYMrSyhR36h5ERF
         EIJxISBMOoCAhtn1Bjn4DiiJXumUve7fuQAuJq5mrBL7QrUxstQDqVJ+OQ0THNPG1/cT
         YWPg==
X-Gm-Message-State: ACgBeo0qdwXx8TYk7AQz4GAH63HLuouSSO36ezGZI4tIOfWAU8Rp9qZ0
        Hx/reYaXK+waIOiGVj9LIVu+q3tPOfWF6F6cio6jvePuvcFkkID3jiEUx4zlUeZ5kS9FA6E1EB7
        B7gACSSQSmKTB6rQThcelEtEQqA==
X-Received: by 2002:a5d:5a94:0:b0:221:6cec:2589 with SMTP id bp20-20020a5d5a94000000b002216cec2589mr15124084wrb.336.1660122193176;
        Wed, 10 Aug 2022 02:03:13 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7B/fed6AkUKvETZNZzY2Aw/ljCBjLPi20tQHr8C2p9Bwqnl1tq+PpkGuYpyjcrSsB3Ep52mA==
X-Received: by 2002:a5d:5a94:0:b0:221:6cec:2589 with SMTP id bp20-20020a5d5a94000000b002216cec2589mr15124042wrb.336.1660122192829;
        Wed, 10 Aug 2022 02:03:12 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:1600:a3ce:b459:ef57:7b93? (p200300cbc7071600a3ceb459ef577b93.dip0.t-ipconnect.de. [2003:cb:c707:1600:a3ce:b459:ef57:7b93])
        by smtp.gmail.com with ESMTPSA id i9-20020a05600c050900b003a3187a2d4csm1655413wmc.22.2022.08.10.02.03.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 02:03:12 -0700 (PDT)
Message-ID: <95ed1a81-ff8e-2c48-8838-4b3995af51b7@redhat.com>
Date:   Wed, 10 Aug 2022 11:03:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PROC FILESYSTEM" <linux-fsdevel@vger.kernel.org>,
        "open list:ABI/API" <linux-api@vger.kernel.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, krisman@collabora.com
Cc:     kernel@collabora.com
References: <20220726161854.276359-1-usama.anjum@collabora.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 0/5] Add process_memwatch syscall
In-Reply-To: <20220726161854.276359-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 26.07.22 18:18, Muhammad Usama Anjum wrote:
> Hello,

Hi,

> 
> This patch series implements a new syscall, process_memwatch. Currently,
> only the support to watch soft-dirty PTE bit is added. This syscall is
> generic to watch the memory of the process. There is enough room to add
> more operations like this to watch memory in the future.
> 
> Soft-dirty PTE bit of the memory pages can be viewed by using pagemap
> procfs file. The soft-dirty PTE bit for the memory in a process can be
> cleared by writing to the clear_refs file. This series adds features that
> weren't possible through the Proc FS interface.
> - There is no atomic get soft-dirty PTE bit status and clear operation
>   possible.

Such an interface might be easy to add, no?

> - The soft-dirty PTE bit of only a part of memory cannot be cleared.

Same.

So I'm curious why we need a new syscall for that.

> 
> Historically, soft-dirty PTE bit tracking has been used in the CRIU
> project. The Proc FS interface is enough for that as I think the process
> is frozen. We have the use case where we need to track the soft-dirty
> PTE bit for running processes. We need this tracking and clear mechanism
> of a region of memory while the process is running to emulate the
> getWriteWatch() syscall of Windows. This syscall is used by games to keep
> track of dirty pages and keep processing only the dirty pages. This
> syscall can be used by the CRIU project and other applications which
> require soft-dirty PTE bit information.
> 
> As in the current kernel there is no way to clear a part of memory (instead
> of clearing the Soft-Dirty bits for the entire processi) and get+clear
> operation cannot be performed atomically, there are other methods to mimic
> this information entirely in userspace with poor performance:
> - The mprotect syscall and SIGSEGV handler for bookkeeping
> - The userfaultfd syscall with the handler for bookkeeping

You write "poor performance". Did you actually implement a prototype
using userfaultfd-wp? Can you share numbers for comparison?

Adding an new syscall just for handling a corner case feature
(soft-dirty, which we all love, of course) needs good justification.

> 
>         long process_memwatch(int pidfd, unsigned long start, int len,
>                               unsigned int flags, void *vec, int vec_len);
> 
> This syscall can be used by the CRIU project and other applications which
> require soft-dirty PTE bit information. The following operations are
> supported in this syscall:
> - Get the pages that are soft-dirty.
> - Clear the pages which are soft-dirty.
> - The optional flag to ignore the VM_SOFTDIRTY and only track per page
> soft-dirty PTE bit

Huh, why? VM_SOFTDIRTY is an internal implementation detail and should
remain such.

VM_SOFTDIRTY translates to "all pages in this VMA are soft-dirty".

-- 
Thanks,

David / dhildenb


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678375E4EEE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 20:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiIUS0e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 14:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiIUS0d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 14:26:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0599E6BD;
        Wed, 21 Sep 2022 11:26:31 -0700 (PDT)
Received: from [192.168.10.9] (unknown [39.45.34.16])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 86C166601F3F;
        Wed, 21 Sep 2022 19:26:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663784789;
        bh=So86y159AbWJGTLFx2a5tmcV8v05eppZwwAmrovWgMM=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=IGDJJARkqok3B6pKtzC9Wf7OvwLPfsce/uxiqcj2w9+vuT/nKW+Tks5OD65FDuCuX
         H/ap7da1XCgHuIvU/XoqGGV4A8u28RcxRxhH9jJr8DwSY6p1zURGwZxRoZ6mSc/hIJ
         tfwYtCeXl39rr5ol291NlnhTqquo5POJ3kuKgzTLo4tWJPeBRjQN3gpoQKbCDHRNQe
         N2Dx3YQGKt+qQX+l1X+V+GFHp+5ww+zNHJoh3/aB01Sz9WYhlATyMSmRmulP7978mI
         JqFUDHrzQblaK5hcEicjIUcmsBR2stbPew4HBYXDSiweegz2o2i7VBbflfbJWxlhrh
         qy9Igt7cKbb5A==
Message-ID: <2c8b7116-56e9-3202-c47e-e42078c85793@collabora.com>
Date:   Wed, 21 Sep 2022 23:26:21 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Cc:     usama.anjum@collabora.com, Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PROC FILESYSTEM" <linux-fsdevel@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kernel@collabora.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 0/4] Implement IOCTL to get and clear soft dirty PTE
Content-Language: en-US
To:     Andrei Vagin <avagin@gmail.com>
References: <20220826064535.1941190-1-usama.anjum@collabora.com>
 <YyiDg79flhWoMDZB@gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <YyiDg79flhWoMDZB@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Thank you for reviewing.

On 9/19/22 7:58 PM, Andrei Vagin wrote:
>> This ioctl can be used by the CRIU project and other applications which
>> require soft-dirty PTE bit information. The following operations are
>> supported in this ioctl:
>> - Get the pages that are soft-dirty.
> 
> I think this interface doesn't have to be limited by the soft-dirty
> bits only. For example, CRIU needs to know whether file, present and swap bits
> are set or not.
These operations can be performed by pagemap procfs file. Definitely
performing them through IOCTL will be faster. But I'm trying to add a
simple IOCTL by which some specific PTE bit can be read and cleared
atomically. This IOCTL can be extended to include other bits like file,
present and swap bits by keeping the interface simple. The following
mask advice is nice. But if we add that kind of masking, it'll start to
look like a filter on top of pagemap. My intention is to not duplicate
the functionality already provided by the pagemap. One may ask, then why
am I adding "get the soft-dirty pages" functionality? I'm adding it to
complement the get and clear operation. The "get" and "get and clear"
operations with special flag (PAGEMAP_SD_NO_REUSED_REGIONS) can give
results quicker by not splitting the VMAs.

> 
> I mean we should be able to specify for what pages we need to get info
> for. An ioctl argument can have these four fields:
> * required bits (rmask & mask == mask) - all bits from this mask have to be set.
> * any of these bits (amask & mask != 0) - any of these bits is set.
> * exclude masks (emask & mask == 0) = none of these bits are set.
> * return mask - bits that have to be reported to user.
> 
>> - Clear the pages which are soft-dirty.
>> - The optional flag to ignore the VM_SOFTDIRTY and only track per page
>> soft-dirty PTE bit
>>
>> There are two decisions which have been taken about how to get the output
>> from the syscall.
>> - Return offsets of the pages from the start in the vec
> 
> We can conside to return regions that contains pages with the same set
> of bits.
> 
> struct page_region {
> 	void *start;
> 	long size;
> 	u64 bitmap;
> }
> 
> And ioctl returns arrays of page_region-s. I believe it will be more
> compact form for many cases.
Thank you for mentioning this. I'd considered this while development.
But I gave up and used the simple array to return the offsets of the
pages as in the problem I'm trying to solve, the dirty pages may be
present amid non-dirty pages. The range may not be useful in that case.
Also we want to return only a specific number of pages of interest. The
following paragraph explains it.

> 
>> - Stop execution when vec is filled with dirty pages
>> These two arguments doesn't follow the mincore() philosophy where the
>> output array corresponds to the address range in one to one fashion, hence
>> the output buffer length isn't passed and only a flag is set if the page
>> is present. This makes mincore() easy to use with less control. We are
>> passing the size of the output array and putting return data consecutively
>> which is offset of dirty pages from the start. The user can convert these
>> offsets back into the dirty page addresses easily. Suppose, the user want
>> to get first 10 dirty pages from a total memory of 100 pages. He'll
>> allocate output buffer of size 10 and the ioctl will abort after finding the
>> 10 pages. This behaviour is needed to support Windows' getWriteWatch(). The
>> behaviour like mincore() can be achieved by passing output buffer of 100
>> size. This interface can be used for any desired behaviour.
>>
>> [1] https://lore.kernel.org/lkml/54d4c322-cd6e-eefd-b161-2af2b56aae24@collabora.com/
>>
>> Regards,
>> Muhammad Usama Anjum
>>
>> Muhammad Usama Anjum (4):
>>   fs/proc/task_mmu: update functions to clear the soft-dirty PTE bit
>>   fs/proc/task_mmu: Implement IOCTL to get and clear soft dirty PTE bit
>>   selftests: vm: add pagemap ioctl tests
>>   mm: add documentation of the new ioctl on pagemap
>>
>>  Documentation/admin-guide/mm/soft-dirty.rst |  42 +-
>>  fs/proc/task_mmu.c                          | 342 ++++++++++-
>>  include/uapi/linux/fs.h                     |  23 +
>>  tools/include/uapi/linux/fs.h               |  23 +
>>  tools/testing/selftests/vm/.gitignore       |   1 +
>>  tools/testing/selftests/vm/Makefile         |   2 +
>>  tools/testing/selftests/vm/pagemap_ioctl.c  | 649 ++++++++++++++++++++
>>  7 files changed, 1050 insertions(+), 32 deletions(-)
>>  create mode 100644 tools/testing/selftests/vm/pagemap_ioctl.c
>>
>> -- 
>> 2.30.2
>>

-- 
Muhammad Usama Anjum

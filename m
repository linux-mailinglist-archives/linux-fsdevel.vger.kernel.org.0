Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A7A6B3080
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 23:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjCIWYV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 17:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjCIWYU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 17:24:20 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C5019AE;
        Thu,  9 Mar 2023 14:24:18 -0800 (PST)
Received: from [192.168.10.12] (unknown [39.45.15.64])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0DAE46602F6A;
        Thu,  9 Mar 2023 22:24:10 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678400657;
        bh=/fKmZ3AxGipBaMNDjvWUp4yitIpEwvuH+fTIosEDhJM=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=QROnWgSXmt43lCdF2jI5YfWXLtGnkM5+GH3k3x+YY4ceuhuAmfTZ6MZ1KMq92/5ZA
         wu8avl403ciw4Qm9epCJijio2LSApV6vDKuPWVwPRS2EZYde/ObiZOHbsUlEF9eQYb
         wfTGsEiKyh9O0WmdCNKpM7n8KSATipV6BEgpzd4T43uI2i2dk8b98FWccwj2wdG+O2
         gvqwIwjk9beySEkifqNPF8KH/ndu5QF/IfL8DtLH3b38g9hzEmvjjm/DFJjaGf89lt
         0DtD3eDf7rEA6bLGZEn938AQvp/ZiFkTyS1cmvL1o0y9J6GVszKkzwhNsW0vj1+iOy
         cNRQPNjMPdMzA==
Message-ID: <92f3e9e8-e4ee-e330-517e-21ea4461ab37@collabora.com>
Date:   Fri, 10 Mar 2023 03:24:06 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v11 0/7] Implement IOCTL to get and optionally clear info
 about PTEs
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>
References: <20230309135718.1490461-1-usama.anjum@collabora.com>
 <20230309115818.170dd5ef2cde7b58b9354ecd@linux-foundation.org>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20230309115818.170dd5ef2cde7b58b9354ecd@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Andrew,

Thank you for your message.

On 3/10/23 12:58 AM, Andrew Morton wrote:
> On Thu,  9 Mar 2023 18:57:11 +0500 Muhammad Usama Anjum <usama.anjum@collabora.com> wrote:
> 
>> The information related to pages if the page is file mapped, present and
>> swapped is required for the CRIU project [5][6]. The addition of the
>> required mask, any mask, excluded mask and return masks are also required
>> for the CRIU project [5].
> 
> It's a ton of new code and what I'm not seeing in here (might have
> missed it?) is a clear statement of the value of this feature to our
> users.
Sorry, let me give some clear details about its value.

> 
> I see hints that CRIU would like it, but no description of how valuable
> this is to CRIU's users.
> 
> So please spend some time preparing this info.
> 
> Also, are any other applications of this feature anticipated?  If so,
> what are they?
> 
> IOW, please sell this stuff to us!
The real motivation for adding PAGEMAP_SCAN IOCTL is to emulate Windows
GetWriteWatch() syscall [1].
> The GetWriteWatch{} retrieves the addresses of the pages that are written
> to in a region of virtual memory.
This syscall is used in Windows applications and games etc. This syscall is
being emulated in pretty slow manner in userspace. Our purpose is to
enhance the kernel such that we translate it efficiently in a better way.
Currently some out of tree hack patches are being used to efficiently
emulate it in some kernels. We intend to replace those with these patches.
So the whole gaming on Linux can effectively get benefit from this. It
means there would be tons of users of this code.

CRIU use case [2] was mentioned by Andrei and Danylo:
> Use cases for migrating sparse VMAs are binaries sanitized with ASAN,
> MSAN or TSAN [3]. All of these sanitizers produce sparse mappings of
> shadow memory [4]. Being able to migrate such binaries allows to highly
> reduce the amount of work needed to identify and fix post-migration
> crashes, which happen constantly.
At [10]:
> For Andrei's use case is to iteratively dump memory.

@Andrei and Danylo can elaborate more on their use cases.


*Implementation Evolution (Short Summary)*
From the definition of GetWriteWatch(), we feel like kernel's soft-dirty
feature can be used under the hood with some additions like:
* reset soft-dirty flag for only a specific region of memory instead of
clearing the flag for the entire process
* get and clear soft-dirty flag for a specific region atomically

So we decided to use ioctl on pagemap file to read or/and reset soft-dirty
flag. But using soft-dirty flag, sometimes we get extra pages which weren't
even written. They had become soft-dirty because of VMA merging and
VM_SOFTDIRTY flag. This breaks the definition of GetWriteWatch(). We were
able to by-pass this short coming by ignoring VM_SOFTDIRTY until David
reported that mprotect etc messes up the soft-dirty flag while ignoring
VM_SOFTDIRTY [5]. This wasn't happening until [6] got introduced. We
discussed if we can revert these patches. But we could not reach to any
conclusion. So at this point, I made couple of tries to solve this whole
VM_SOFTDIRTY issue by correcting the soft-dirty implementation:
* [7] Correct the bug fixed wrongly back in 2014. It had potential to cause
regression. We left it behind.
* [8] Keep a list of soft-dirty part of a VMA across splits and merges. I
got the reply don't increase the size of the VMA by 8 bytes.

At this point, we left soft-dirty considering it is too much delicate and
userfaultfd [9] seemed like the only way forward. From there onward, we
have been basing soft-dirty emulation on userfaultfd wp feature where
kernel resolves the faults itself when WP_ASYNC feature is used. It was
straight forward to add WP_ASYNC feature in userfautlfd. Now we get only
those pages dirty or written-to which are really written in reality. (PS
There is another WP_UNPOPULATED userfautfd feature is required which is
needed to avoid pre-faulting memory before write-protecting [9].)

All the different masks were added on the request of CRIU devs to create
interface more generic and better.

[1]
https://learn.microsoft.com/en-us/windows/win32/api/memoryapi/nf-memoryapi-getwritewatch
[2] https://lore.kernel.org/all/20221014134802.1361436-1-mdanylo@google.com
[3] https://github.com/google/sanitizers	
[4] https://github.com/google/sanitizers/wiki/AddressSanitizerAlgorithm#64-bit
[5]
https://lore.kernel.org/all/bfcae708-db21-04b4-0bbe-712badd03071@redhat.com
[6] https://lore.kernel.org/all/20220725142048.30450-1-peterx@redhat.com/
[7]
https://lore.kernel.org/all/20221122115007.2787017-1-usama.anjum@collabora.com
[8]
https://lore.kernel.org/all/20221220162606.1595355-1-usama.anjum@collabora.com
[9] https://lore.kernel.org/all/20230306213925.617814-1-peterx@redhat.com
[10] https://lore.kernel.org/all/20230125144529.1630917-1-mdanylo@google.com

-- 
BR,
Muhammad Usama Anjum

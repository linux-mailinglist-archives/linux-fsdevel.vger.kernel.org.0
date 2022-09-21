Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49025E4F73
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 20:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiIUSag (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 14:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiIUSaa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 14:30:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABD39F8D1;
        Wed, 21 Sep 2022 11:30:28 -0700 (PDT)
Received: from [192.168.10.9] (unknown [39.45.34.16])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 35B1A6601F3F;
        Wed, 21 Sep 2022 19:30:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663785027;
        bh=BbYZK5kjusKrIzNZUnjNshwXR92l04FpzHFY3oAXOF8=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=dN+DilH/wnaFUJha/f9OBaTCtJ6DFgoJK3l36TGxNBiPRssCKNcwUvcyf8XaPbbs5
         p+wQQtinjAwPUk6viinSpyeBt5zSg8MqKoVBdthJ4refOtSR8TxHtulRa+Jbg4lYeO
         Kbfpu1w+Xxe5FUMw49jmvbcFcPEBBvmJdBit9KgzmL6sShDfUnZCXogJtrsvtbeTQv
         fgi3I7i+K+gzwQ+XB2CzmkQxg9PwfRFOhbkzXTKaVIgFx5xSona7MR0t0BuqeWBABD
         PO1UZm+rxhGvfmrXLyGBl55mZz2Aq65gw72hB2BKMK4wLH18y+XKu+gias70wj/rQM
         JJRS6GALkD1Pw==
Message-ID: <ab6014a2-80c1-7f6e-036c-1dd32f488710@collabora.com>
Date:   Wed, 21 Sep 2022 23:30:21 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Cc:     usama.anjum@collabora.com, kernel@collabora.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PROC FILESYSTEM" <linux-fsdevel@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v3 0/4] Implement IOCTL to get and clear soft dirty PTE
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>
References: <20220826064535.1941190-1-usama.anjum@collabora.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20220826064535.1941190-1-usama.anjum@collabora.com>
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

Hi Suren,

I'd shared this problem with you at Plumbers. Please review and share
your thoughts.

Thanks,
Usama


On 8/26/22 11:45 AM, Muhammad Usama Anjum wrote:
> 
> Hello,
> 
> This patch series implements a new ioctl on the pagemap proc fs file to
> get, clear and perform both get and clear at the same time atomically on
> the specified range of the memory.
> 
> Soft-dirty PTE bit of the memory pages can be viewed by using pagemap
> procfs file. The soft-dirty PTE bit for the whole memory range of the
> process can be cleared by writing to the clear_refs file. This series
> adds features that weren't present earlier.
> - There is no atomic get soft-dirty PTE bit status and clear operation
>   present.
> - The soft-dirty PTE bit of only a part of memory cannot be cleared.
> 
> Historically, soft-dirty PTE bit tracking has been used in the CRIU
> project. The proc fs interface is enough for that as I think the process
> is frozen. We have the use case where we need to track the soft-dirty
> PTE bit for the running processes. We need this tracking and clear
> mechanism of a region of memory while the process is running to emulate
> the getWriteWatch() syscall of Windows. This syscall is used by games to
> keep track of dirty pages and keep processing only the dirty pages. This
> new ioctl can be used by the CRIU project and other applications which
> require soft-dirty PTE bit information.
> 
> As in the current kernel there is no way to clear a part of memory (instead
> of clearing the Soft-Dirty bits for the entire process) and get+clear
> operation cannot be performed atomically, there are other methods to mimic
> this information entirely in userspace with poor performance:
> - The mprotect syscall and SIGSEGV handler for bookkeeping
> - The userfaultfd syscall with the handler for bookkeeping
> Some benchmarks can be seen [1].
> 
> This ioctl can be used by the CRIU project and other applications which
> require soft-dirty PTE bit information. The following operations are
> supported in this ioctl:
> - Get the pages that are soft-dirty.
> - Clear the pages which are soft-dirty.
> - The optional flag to ignore the VM_SOFTDIRTY and only track per page
> soft-dirty PTE bit
> 
> There are two decisions which have been taken about how to get the output
> from the syscall.
> - Return offsets of the pages from the start in the vec
> - Stop execution when vec is filled with dirty pages
> These two arguments doesn't follow the mincore() philosophy where the
> output array corresponds to the address range in one to one fashion, hence
> the output buffer length isn't passed and only a flag is set if the page
> is present. This makes mincore() easy to use with less control. We are
> passing the size of the output array and putting return data consecutively
> which is offset of dirty pages from the start. The user can convert these
> offsets back into the dirty page addresses easily. Suppose, the user want
> to get first 10 dirty pages from a total memory of 100 pages. He'll
> allocate output buffer of size 10 and the ioctl will abort after finding the
> 10 pages. This behaviour is needed to support Windows' getWriteWatch(). The
> behaviour like mincore() can be achieved by passing output buffer of 100
> size. This interface can be used for any desired behaviour.
> 
> [1] https://lore.kernel.org/lkml/54d4c322-cd6e-eefd-b161-2af2b56aae24@collabora.com/
> 
> Regards,
> Muhammad Usama Anjum
> 
> Muhammad Usama Anjum (4):
>   fs/proc/task_mmu: update functions to clear the soft-dirty PTE bit
>   fs/proc/task_mmu: Implement IOCTL to get and clear soft dirty PTE bit
>   selftests: vm: add pagemap ioctl tests
>   mm: add documentation of the new ioctl on pagemap
> 
>  Documentation/admin-guide/mm/soft-dirty.rst |  42 +-
>  fs/proc/task_mmu.c                          | 342 ++++++++++-
>  include/uapi/linux/fs.h                     |  23 +
>  tools/include/uapi/linux/fs.h               |  23 +
>  tools/testing/selftests/vm/.gitignore       |   1 +
>  tools/testing/selftests/vm/Makefile         |   2 +
>  tools/testing/selftests/vm/pagemap_ioctl.c  | 649 ++++++++++++++++++++
>  7 files changed, 1050 insertions(+), 32 deletions(-)
>  create mode 100644 tools/testing/selftests/vm/pagemap_ioctl.c
> 

-- 
Muhammad Usama Anjum

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4857D671520
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 08:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjARHhU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 02:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjARHg1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 02:36:27 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245B253E60;
        Tue, 17 Jan 2023 22:55:13 -0800 (PST)
Received: from [192.168.10.12] (unknown [39.45.186.163])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 844086602DFC;
        Wed, 18 Jan 2023 06:55:04 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674024911;
        bh=SdStpbIeDfkXq/1WkTzofAiJMRrTWL+qD20mCilFltQ=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=anhLzEm37WQ6kJ4UtYhDvRe26HBXPdy/oeRrEKqfRDiSEJYxq5AxJHpRaTWN1ihnf
         FBQ91Au57i3n6rC9GSLR9RbYDBo9AFNh+zQpGepL19MEc3XS/luuOqeHYIMEtWIZYf
         ykP8R2El8dtUmTW9F+dj6qk6EI2fospl9EWep7ZLX7BSUGGmXyO2AHrGh2e1a7EkiF
         Xcl56ehFn/bxd0pQerwN5LW5AeLii3v1tzn7/qE8lnbAE3q546gZP5/O97S3FlyGM6
         j28jF8wf39CO0eJDIqb8SQECmnxfanQMDtUMjT8ywgbfEfGcvptNVc5/P2ZkE1DlGi
         KBKwb/LNXbj7Q==
Message-ID: <9bc72983-91dc-74b5-54dd-cf419d6deab4@collabora.com>
Date:   Wed, 18 Jan 2023 11:55:00 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
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
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com,
        Paul Gofman <pgofman@codeweavers.com>
Subject: Re: [PATCH v7 0/4] Implement IOCTL to get and/or the clear info about
 PTEs
To:     Cyrill Gorcunov <gorcunov@gmail.com>, Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WC?= =?UTF-8?Q?aw?= 
        <emmir@google.com>, Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>
References: <20230109064519.3555250-1-usama.anjum@collabora.com>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20230109064519.3555250-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/9/23 11:45 AM, Muhammad Usama Anjum wrote:
> *Changes in v7:*
> - Add uffd wp async
> - Update the IOCTL to use uffd under the hood instead of soft-dirty
>   flags
> 
> Stop using the soft-dirty flags for finding which pages have been
> written to. It is too delicate and wrong as it shows more soft-dirty
> pages than the actual soft-dirty pages. There is no interest in
> correcting it [A][B] as this is how the feature was written years ago.
> It shouldn't be updated to changed behaviour. Peter Xu has suggested
> using the async version of the UFFD WP [C] as it is based inherently
> on the PTEs.
> 
> So in this patch series, I've added a new mode to the UFFD which is
> asynchronous version of the write protect. When this variant of the
> UFFD WP is used, the page faults are resolved automatically by the
> kernel. The pages which have been written-to can be found by reading
> pagemap file (!PM_UFFD_WP). This feature can be used successfully to
> find which pages have been written to from the time the pages were
> write protected. This works just like the soft-dirty flag without
> showing any extra pages which aren't soft-dirty in reality.
Any thoughts on this version are highly welcome. Please review.

> 
> [A] https://lore.kernel.org/all/20221220162606.1595355-1-usama.anjum@collabora.com
> [B] https://lore.kernel.org/all/20221122115007.2787017-1-usama.anjum@collabora.com
> [C] https://lore.kernel.org/all/Y6Hc2d+7eTKs7AiH@x1n
> 
> *Changes in v6:*
> - Updated the interface and made cosmetic changes
> 
> *Cover Letter in v5:*
> Hello,
> 
> This patch series implements IOCTL on the pagemap procfs file to get the
> information about the page table entries (PTEs). The following operations
> are supported in this ioctl:
> - Get the information if the pages are soft-dirty, file mapped, present
>   or swapped.
> - Clear the soft-dirty PTE bit of the pages.
> - Get and clear the soft-dirty PTE bit of the pages atomically.
> 
> Soft-dirty PTE bit of the memory pages can be read by using the pagemap
> procfs file. The soft-dirty PTE bit for the whole memory range of the
> process can be cleared by writing to the clear_refs file. There are other
> methods to mimic this information entirely in userspace with poor
> performance:
> - The mprotect syscall and SIGSEGV handler for bookkeeping
> - The userfaultfd syscall with the handler for bookkeeping
> Some benchmarks can be seen here[1]. This series adds features that weren't
> present earlier:
> - There is no atomic get soft-dirty PTE bit status and clear operation
>   possible.
> - The soft-dirty PTE bit of only a part of memory cannot be cleared.
> 
> Historically, soft-dirty PTE bit tracking has been used in the CRIU
> project. The procfs interface is enough for finding the soft-dirty bit
> status and clearing the soft-dirty bit of all the pages of a process.
> We have the use case where we need to track the soft-dirty PTE bit for
> only specific pages on demand. We need this tracking and clear mechanism
> of a region of memory while the process is running to emulate the
> getWriteWatch() syscall of Windows. This syscall is used by games to
> keep track of dirty pages to process only the dirty pages.
> 
> The information related to pages if the page is file mapped, present and
> swapped is required for the CRIU project[2][3]. The addition of the
> required mask, any mask, excluded mask and return masks are also required
> for the CRIU project[2].
> 
> The IOCTL returns the addresses of the pages which match the specific masks.
> The page addresses are returned in struct page_region in a compact form.
> The max_pages is needed to support a use case where user only wants to get
> a specific number of pages. So there is no need to find all the pages of
> interest in the range when max_pages is specified. The IOCTL returns when
> the maximum number of the pages are found. The max_pages is optional. If
> max_pages is specified, it must be equal or greater than the vec_size.
> This restriction is needed to handle worse case when one page_region only
> contains info of one page and it cannot be compacted. This is needed to
> emulate the Windows getWriteWatch() syscall.
> 
> Some non-dirty pages get marked as dirty because of the kernel's
> internal activity (such as VMA merging as soft-dirty bit difference isn't
> considered while deciding to merge VMAs). The dirty bit of the pages is
> stored in the VMA flags and in the per page flags. If any of these two bits
> are set, the page is considered to be soft dirty. Suppose you have cleared
> the soft dirty bit of half of VMA which will be done by splitting the VMA
> and clearing soft dirty bit flag in the half VMA and the pages in it. Now
> kernel may decide to merge the VMAs again. So the half VMA becomes dirty
> again. This splitting/merging costs performance. The application receives
> a lot of pages which aren't dirty in reality but marked as dirty.
> Performance is lost again here. Also sometimes user doesn't want the newly
> allocated memory to be marked as dirty. PAGEMAP_NO_REUSED_REGIONS flag
> solves both the problems. It is used to not depend on the soft dirty flag
> in the VMA flags. So VMA splitting and merging doesn't happen. It only
> depends on the soft dirty bit of the individual pages. Thus by using this
> flag, there may be a scenerio such that the new memory regions which are
> just created, doesn't look dirty when seen with the IOCTL, but look dirty
> when seen from procfs. This seems okay as the user of this flag know the
> implication of using it.
> 
> [1] https://lore.kernel.org/lkml/54d4c322-cd6e-eefd-b161-2af2b56aae24@collabora.com/
> [2] https://lore.kernel.org/all/YyiDg79flhWoMDZB@gmail.com/
> [3] https://lore.kernel.org/all/20221014134802.1361436-1-mdanylo@google.com/
> 
> Regards,
> Muhammad Usama Anjum
> 
> Muhammad Usama Anjum (4):
>   userfaultfd: Add UFFD WP Async support
>   userfaultfd: split mwriteprotect_range()
>   fs/proc/task_mmu: Implement IOCTL to get and/or the clear info about
>     PTEs
>   selftests: vm: add pagemap ioctl tests
> 
>  fs/proc/task_mmu.c                         | 300 +++++++
>  fs/userfaultfd.c                           | 161 ++--
>  include/linux/userfaultfd_k.h              |  10 +
>  include/uapi/linux/fs.h                    |  50 ++
>  include/uapi/linux/userfaultfd.h           |   6 +
>  mm/userfaultfd.c                           |  40 +-
>  tools/include/uapi/linux/fs.h              |  50 ++
>  tools/testing/selftests/vm/.gitignore      |   1 +
>  tools/testing/selftests/vm/Makefile        |   5 +-
>  tools/testing/selftests/vm/pagemap_ioctl.c | 884 +++++++++++++++++++++
>  10 files changed, 1424 insertions(+), 83 deletions(-)
>  create mode 100644 tools/testing/selftests/vm/pagemap_ioctl.c
> 

-- 
BR,
Muhammad Usama Anjum

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB7A617A98
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 11:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiKCKHz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 06:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbiKCKHx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 06:07:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02325394;
        Thu,  3 Nov 2022 03:07:52 -0700 (PDT)
Received: from localhost.localdomain (unknown [39.45.244.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 453DE6602910;
        Thu,  3 Nov 2022 10:07:45 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667470070;
        bh=q0mDi05Vur2jUnA+vSo0MMcydIOFtDk66qXLL7ktXSo=;
        h=From:To:Subject:Date:From;
        b=PPVcWP8vA5jI5lieJfGxE/o4Et4FaRn41IOoU4HKXM5oSt6tSYpHit3G1k1RM0kM1
         A67Mczn8dgKDNz9lKBzjwd2AAxd+Tx3tIIgMppIjeEcH+tfIj3xTKdgTgBxhPrWiRF
         4TOW0ZnNch1fdBaWr2MSBtoSXyxn0ciybFXW1zaY9Rwd/PB54MgE3tDeo2qcUIhI1q
         hsxIiy/2ifi36kFvKafDS5hbXO/RuG42gpxfP1I8VR7JP7baMLLj3AFWsqNeKotziM
         Pg9Ib/PW5mH+SafRWrFJcq7mFYgUebHIQdTj8U+Dvq/OZ2gjht6gDDNJ7XDsXsl1Td
         FQuQLAhqMeLjg==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <emmir@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Peter Xu <peterx@redhat.com>, Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Zach O'Keefe" <zokeefe@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        "open list : KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list : PROC FILESYSTEM" <linux-fsdevel@vger.kernel.org>,
        "open list : MEMORY MANAGEMENT" <linux-mm@kvack.org>
Subject: [PATCH v4 0/3] Implement IOCTL to get and/or the clear info about PTEs
Date:   Thu,  3 Nov 2022 15:07:33 +0500
Message-Id: <20221103100736.2356351-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

This patch series implements IOCTL on the pagemap procfs file to get the
information about the page table entries (PTEs). The following operations
are supported in this ioctl:
- Get the information if the pages are soft-dirty, file mapped, present
  or swapped.
- Clear the soft-dirty PTE bit of the pages.
- Get and clear the soft-dirty PTE bit of the pages atomically.

Soft-dirty PTE bit of the memory pages can be read by using the pagemap
procfs file. The soft-dirty PTE bit for the whole memory range of the
process can be cleared by writing to the clear_refs file. There are other
methods to mimic this information entirely in userspace with poor
performance:
- The mprotect syscall and SIGSEGV handler for bookkeeping
- The userfaultfd syscall with the handler for bookkeeping
Some benchmarks can be seen here[1]. This series adds features that weren't
present earlier:
- There is no atomic get soft-dirty PTE bit status and clear operation
  possible.
- The soft-dirty PTE bit of only a part of memory cannot be cleared.

Historically, soft-dirty PTE bit tracking has been used in the CRIU
project. The procfs interface is enough for finding the soft-dirty bit
status and clearing the soft-dirty bit of all the pages of a process.
We have the use case where we need to track the soft-dirty PTE bit for
only specific pages on demand. We need this tracking and clear mechanism
of a region of memory while the process is running to emulate the
getWriteWatch() syscall of Windows. This syscall is used by games to
keep track of dirty pages to process only the dirty pages.

The information related to pages if the page is file mapped, present and
swapped is required for the CRIU project[2][3]. The addition of the
required mask, any mask, excluded mask and return masks are also required
for the CRIU project[2].

The IOCTL returns the addresses of the pages which match the specific masks.
The page addresses are returned in struct page_region in a compact form.
The max_pages is needed to support a use case where user only wants to get
a specific number of pages. So there is no need to find all the pages of
interest in the range when max_pages is specified. The IOCTL returns when
the maximum number of the pages are found. The max_pages is optional. If
max_pages is specified, it must be equal or greater than the vec_size.
This restriction is needed to handle worse case when one page_region only
contains info of one page and it cannot be compacted. This is needed to
emulate the Windows getWriteWatch() syscall.

Some non-dirty pages get marked as dirty because of the kernel's
internal activity (such as VMA merging as soft-dirty bit difference isn't
considered while deciding to merge VMAs). The dirty bit of the pages is
stored in the VMA flags and in the per page flags. If any of these two bits
are set, the page is considered to be soft dirty. Suppose you have cleared
the soft dirty bit of half of VMA which will be done by splitting the VMA
and clearing soft dirty bit flag in the half VMA and the pages in it. Now
kernel may decide to merge the VMAs again. So the half VMA becomes dirty
again. This splitting/merging costs performance. The application receives
a lot of pages which aren't dirty in reality but marked as dirty.
Performance is lost again here. Also sometimes user doesn't want the newly
allocated memory to be marked as dirty. PAGEMAP_NO_REUSED_REGIONS flag
solves both the problems. It is used to not depend on the soft dirty flag
in the VMA flags. So VMA splitting and merging doesn't happen. It only
depends on the soft dirty bit of the individual pages. Thus by using this
flag, there may be a scenerio such that the new memory regions which are
just created, doesn't look dirty when seen with the IOCTL, but look dirty
when seen from procfs. This seems okay as the user of this flag know the
implication of using it.

[1] https://lore.kernel.org/lkml/54d4c322-cd6e-eefd-b161-2af2b56aae24@collabora.com/
[2] https://lore.kernel.org/all/YyiDg79flhWoMDZB@gmail.com/
[3] https://lore.kernel.org/all/20221014134802.1361436-1-mdanylo@google.com/

Regards,
Muhammad Usama Anjum

Muhammad Usama Anjum (3):
  fs/proc/task_mmu: update functions to clear the soft-dirty PTE bit
  fs/proc/task_mmu: Implement IOCTL to get and/or the clear info about
    PTEs
  selftests: vm: add pagemap ioctl tests

 fs/proc/task_mmu.c                         | 400 +++++++++++-
 include/uapi/linux/fs.h                    |  53 ++
 tools/include/uapi/linux/fs.h              |  53 ++
 tools/testing/selftests/vm/.gitignore      |   1 +
 tools/testing/selftests/vm/Makefile        |   5 +-
 tools/testing/selftests/vm/pagemap_ioctl.c | 681 +++++++++++++++++++++
 6 files changed, 1160 insertions(+), 33 deletions(-)
 create mode 100644 tools/testing/selftests/vm/pagemap_ioctl.c

-- 
2.30.2


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C0878A62A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 08:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjH1G6b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 02:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjH1G6J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 02:58:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5225CA2;
        Sun, 27 Aug 2023 23:58:00 -0700 (PDT)
Received: from [192.168.100.7] (unknown [59.103.217.254])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 860806606E9D;
        Mon, 28 Aug 2023 07:57:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693205878;
        bh=HhsU8AkTByw0hcLD8Of9x5RBa5g/fpRR/eFqHC92OFs=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=ndlTZXvtxIZR+jz3o5U447EFR3/LjVag2wTe//HGvH8z6NEdkiOSClZrEjEDeHkv5
         5IaXWMOeDutPhGS/bZOk4S0E9O4bHjIznUT4jae24qHDZdGcB2NnchnWqbT84j/CuC
         iujMeg1+4OK2osK3PNUn1IMrf56T9aORvJ0Z6+VSdClyQEYIBDIOVEcbwuv+QY0h3E
         3eeF3PP/LHuku+DDJ+ECAYVzx5NMx7Qpn9mf1+Ki5ZgXKkHC0HaYkU2eZ0hUzCU8OP
         3BgiC8XZSnj6mFgsnlbnET4OClM2e8nA1aRO1/k5y+FPUhlPEXYalNYZcO6N9NbPFr
         iepHsSDRVGm3Q==
Message-ID: <31981423-9edd-46b6-b5f8-17aae07b8336@collabora.com>
Date:   Mon, 28 Aug 2023 11:57:44 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v33 2/6] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
To:     Andrew Morton <akpm@linux-foundation.org>
References: <20230821141518.870589-1-usama.anjum@collabora.com>
 <20230821141518.870589-3-usama.anjum@collabora.com>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20230821141518.870589-3-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/21/23 7:15 PM, Muhammad Usama Anjum wrote:
> The PAGEMAP_SCAN IOCTL on the pagemap file can be used to get or optionally
> clear the info about page table entries. The following operations are
> supported in this IOCTL:
> - Scan the address range and get the memory ranges matching the provided
>   criteria. This is performed when the output buffer is specified.
> - Write-protect the pages. The PM_SCAN_WP_MATCHING is used to write-protect
>   the pages of interest. The PM_SCAN_CHECK_WPASYNC aborts the operation if
>   non-Async Write Protected pages are found. The ``PM_SCAN_WP_MATCHING``
>   can be used with or without PM_SCAN_CHECK_WPASYNC.
> - Both of those operations can be combined into one atomic operation where
>   we can get and write protect the pages as well.
> 
> Following flags about pages are currently supported:
> - PAGE_IS_WPALLOWED - Page has async-write-protection enabled
> - PAGE_IS_WRITTEN - Page has been written to from the time it was write protected
> - PAGE_IS_FILE - Page is file backed
> - PAGE_IS_PRESENT - Page is present in the memory
> - PAGE_IS_SWAPPED - Page is in swapped
> - PAGE_IS_PFNZERO - Page has zero PFN
> - PAGE_IS_HUGE - Page is THP or Hugetlb backed
> 
> This IOCTL can be extended to get information about more PTE bits. The
> entire address range passed by user [start, end) is scanned until either
> the user provided buffer is full or max_pages have been found.
> 
> Reviewed-by: Andrei Vagin <avagin@gmail.com>
> Reviewed-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Now we have the reviewed-by tags as well. The reviewers are happy with
current version. Can you please have a look and possibly pick these up?

-- 
BR,
Muhammad Usama Anjum

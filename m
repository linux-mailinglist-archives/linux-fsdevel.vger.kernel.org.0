Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5FF6EEEF4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Apr 2023 09:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239490AbjDZHK3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Apr 2023 03:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239739AbjDZHJg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Apr 2023 03:09:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9943C4216;
        Wed, 26 Apr 2023 00:07:49 -0700 (PDT)
Received: from [192.168.10.39] (unknown [39.37.187.173])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8740F6603009;
        Wed, 26 Apr 2023 08:06:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682492797;
        bh=T3Dk0jGRz9/2fOegjbJqSPN2JZCavQCXqoVb+ayBtjw=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=heHwYz8FI2HL0QOQtQqZjCTQl3/ivGoc0Ks5vyxH99Br7r7OLOLSOXPnE/vYxkSLx
         84ErM1CHSxywdPQkwCtYpH+KoalbTt7IdzZheQnlJ9aREA5Gb47T3/W4Ywx3Je+UAE
         uvdWjFNtKe/V/xNiIjo9ok9vGa33L0x9VPg0sx5kwwPL9ncSczi0a0JfewVO39ZtR5
         3pbzi0yJh0DagVoQWIeX/9p+rS9X6VHA3fjCvW3gyIxandOjYAKl1oh5LB0uBuUZQx
         rXgd7QPkDz6mgBqyjIOxu1nrr2BUse87YkLax+frWKhT+6jSkTLft7YLpN2FY+3fnT
         o9hd6hEebRQIw==
Message-ID: <fd9ddd43-6737-88bd-4054-3d5b94534271@collabora.com>
Date:   Wed, 26 Apr 2023 12:06:23 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: [PATCH RESEND v15 2/5] fs/proc/task_mmu: Implement IOCTL to get
 and optionally clear info about PTEs
To:     Peter Xu <peterx@redhat.com>, Paul Gofman <pgofman@codeweavers.com>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com,
        Nadav Amit <namit@vmware.com>
References: <20230420060156.895881-1-usama.anjum@collabora.com>
 <20230420060156.895881-3-usama.anjum@collabora.com>
Content-Language: en-US
In-Reply-To: <20230420060156.895881-3-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/20/23 11:01 AM, Muhammad Usama Anjum wrote:
> +/* Supported flags */
> +#define PM_SCAN_OP_GET	(1 << 0)
> +#define PM_SCAN_OP_WP	(1 << 1)
We have only these flag options available in PAGEMAP_SCAN IOCTL.
PM_SCAN_OP_GET must always be specified for this IOCTL. PM_SCAN_OP_WP can
be specified as need. But PM_SCAN_OP_WP cannot be specified without
PM_SCAN_OP_GET. (This was removed after you had asked me to not duplicate
functionality which can be achieved by UFFDIO_WRITEPROTECT.)

1) PM_SCAN_OP_GET | PM_SCAN_OP_WP
vs
2) UFFDIO_WRITEPROTECT

After removing the usage of uffd_wp_range() from PAGEMAP_SCAN IOCTL, we are
getting really good performance which is comparable just like we are
depending on SOFT_DIRTY flags in the PTE. But when we want to perform wp,
PM_SCAN_OP_GET | PM_SCAN_OP_WP is more desirable than UFFDIO_WRITEPROTECT
performance and behavior wise.

I've got the results from someone else that UFFDIO_WRITEPROTECT block
pagefaults somehow which PAGEMAP_IOCTL doesn't. I still need to verify this
as I don't have tests comparing them one-to-one.

What are your thoughts about it? Have you thought about making
UFFDIO_WRITEPROTECT perform better?

I'm sorry to mention the word "performance" here. Actually we want better
performance to emulate Windows syscall. That is why we are adding this
functionality. So either we need to see what can be improved in
UFFDIO_WRITEPROTECT or can I please add only PM_SCAN_OP_WP back in
pagemap_ioctl?

Thank you so much for the help.

-- 
BR,
Muhammad Usama Anjum

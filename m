Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A1F77E059
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 13:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbjHPLaG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 07:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244622AbjHPL3r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:29:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D881B4;
        Wed, 16 Aug 2023 04:29:46 -0700 (PDT)
Received: from [192.168.100.7] (unknown [59.103.216.185])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6B23A66071DF;
        Wed, 16 Aug 2023 12:29:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692185383;
        bh=jzdDeX6pUFEUXGNfKX/EwXm6M3rdWUmKoZ0lN9Hznw4=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=Dt8B2jZbp7t6JaXUWr+dIqQM9RjQq2p/RnIdZ7kiF6zOcLSro8jgoV7XUdcMc1Oit
         LRpKHs3AGqiYDS0sD2De3J020Bpt9SOeJ2KYtIfKLsSTQXfXh1eXWSvgux/FypoVoh
         uDT5bj7M1rdgnPp92pQpljqC4mx10HCV9jLjzPJdSMX1nAm1QP6LaPa580+5aH2QQ6
         KGRBk0B8KPf6RRK4DvtGuBN+VnROAGEAed2E/cqkkHdbn94+1AzLpTkw4RZqCi43IZ
         1+wfOIvDjh92S1UnnqihPgYK7/K2CaMMdJbKyGKV663ah8AkBHAKERhHuxY1wYbkxt
         kUXWM+tOZCd7w==
Message-ID: <eab0a5be-0f8d-4e63-683f-0628e891719a@collabora.com>
Date:   Wed, 16 Aug 2023 16:29:34 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
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
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v31 2/6] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
Content-Language: en-US
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
References: <20230816103814.1522393-1-usama.anjum@collabora.com>
 <20230816103814.1522393-3-usama.anjum@collabora.com>
 <ZNywVhVe1H8S60FR@qmqm.qmqm.pl>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <ZNywVhVe1H8S60FR@qmqm.qmqm.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/16/23 4:17 PM, Michał Mirosław wrote:
> On Wed, Aug 16, 2023 at 03:38:10PM +0500, Muhammad Usama Anjum wrote:
>> The PAGEMAP_SCAN IOCTL on the pagemap file can be used to get or optionally
>> clear the info about page table entries.
> [...]
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
> [...]
>> +static long do_pagemap_scan(struct mm_struct *mm, unsigned long uarg)
>> +{
> [...]
>> +	for (walk_start = p.arg.start; walk_start < p.arg.end;
>> +			walk_start = p.arg.walk_end) {
> [...]
>> +		/* The walk_end isn't set when ret is zero  */
>> +		if (!p.arg.walk_end)
>> +			p.arg.walk_end = p.arg.end;
> 
> This is now redundant with the `if` after the loop. [1]
> 
>> +		if (ret != -ENOSPC)
>> +			break;
>> +
>> +		if (p.arg.vec_len == 0 || p.found_pages == p.arg.max_pages)
>> +			break;
>> +	}
>> +
>> +	/* ENOSPC signifies early stop (buffer full) from the walk. */
>> +	if (!ret || ret == -ENOSPC)
>> +		ret = n_ranges_out;
>> +
>> +	if (!p.arg.walk_end)
>> +		p.arg.walk_end = p.arg.end;
> 
> [1] The one above.
Thank you for noting it down. Let me remove it.

> 
> Best Regards
> Michał Mirosław

-- 
BR,
Muhammad Usama Anjum

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B317718FD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 06:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjHGE2e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 00:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjHGE2d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 00:28:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34F410F6;
        Sun,  6 Aug 2023 21:28:31 -0700 (PDT)
Received: from [192.168.100.7] (unknown [39.34.184.20])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4BA076607095;
        Mon,  7 Aug 2023 05:28:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691382510;
        bh=wyfC01K6b0rH0xfssr+2AthD/ZY4mDdRepl4Mcer+1Y=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=iFs9XlTi8bs3WTdv05bVWWsLMcOgXgBfvOnKLeAilg75v6YB/L/h+l+ECUKsHZN91
         s92AZhJygXX5nqG1ZeMv6N2Yz+kHunuKuML9taIZnomjB/odsIFKjRWQPvF62Vwxh0
         MagPXlH8/VI4cR7v9T3R17x/sQ3YBAnAEHrl5qGaiD8l0/j6dMR4LnLFAlKdzep6t5
         H71sS2QLyLIO1OAIV4ac9DIgCAtfeg2N+0u3L2V7nlPvaKhU+aehUuzd6cJNtNvPqq
         NXtNBan9kc+1m5j/u5KUYWVIgyFhuW7J/B4sn6Trcsy0k4ci9lOyWgojHJCGq6Kkm0
         D9qvM2Q3bKtbw==
Message-ID: <10f947a2-3917-a5fe-837d-214d70991bcb@collabora.com>
Date:   Mon, 7 Aug 2023 09:28:19 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WC?= =?UTF-8?Q?aw?= 
        <emmir@google.com>, Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
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
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH v26 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
To:     Andrei Vagin <avagin@gmail.com>
References: <20230727093637.1262110-1-usama.anjum@collabora.com>
 <20230727093637.1262110-3-usama.anjum@collabora.com>
 <CANaxB-zZFq7VD7tBBUmACUJPE9iVuTyQKfg4Jw82-U_1qw6ALg@mail.gmail.com>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CANaxB-zZFq7VD7tBBUmACUJPE9iVuTyQKfg4Jw82-U_1qw6ALg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/5/23 2:53 AM, Andrei Vagin wrote:
> On Thu, Jul 27, 2023 at 2:37 AM Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>>
> 
> <snip>
> 
>> +static long do_pagemap_scan(struct mm_struct *mm, unsigned long uarg)
>> +{
>> +       unsigned long walk_start, walk_end;
>> +       struct mmu_notifier_range range;
>> +       struct pagemap_scan_private p;
>> +       size_t n_ranges_out = 0;
>> +       int ret;
>> +
>> +       memset(&p, 0, sizeof(p));
>> +       ret = pagemap_scan_get_args(&p.arg, uarg);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = pagemap_scan_init_bounce_buffer(&p);
>> +       if (ret)
>> +               return ret;
>> +
>> +       /* Protection change for the range is going to happen. */
>> +       if (p.arg.flags & PM_SCAN_WP_MATCHING) {
>> +               mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_VMA, 0,
>> +                                       mm, p.arg.start, p.arg.end);
>> +               mmu_notifier_invalidate_range_start(&range);
>> +       }
>> +
>> +       walk_start = walk_end = p.arg.start;
>> +       for (; walk_end != p.arg.end; walk_start = walk_end) {
>> +               int n_out;
>> +
>> +               walk_end = min_t(unsigned long,
>> +                                (walk_start + PAGEMAP_WALK_SIZE) & PAGEMAP_WALK_MASK,
>> +                                p.arg.end);
> 
> This approach has performance implications. The basic program that scans
> its address space takes around 20-30 seconds, but it has just a few
> small mappings. The first optimization that comes to mind is to remove
> the PAGEMAP_WALK_SIZE limit and instead halt walk_page_range when the
> bounce buffer is full. After draining the buffer, the walk_page_range
> function can be restarted.
Yeah, I've this implemented in WIP and will be posting in next revision.

> 
> The test program and perf data can be found here:
> https://gist.github.com/avagin/c5a22f3c78f8cb34281602dfe9c43d10
> 
>> +
>> +               ret = mmap_read_lock_killable(mm);
>> +               if (ret)
>> +                       break;
>> +               ret = walk_page_range(mm, walk_start, walk_end,
>> +                                     &pagemap_scan_ops, &p);
>> +               mmap_read_unlock(mm);
>> +
>> +               n_out = pagemap_scan_flush_buffer(&p);
>> +               if (n_out < 0)
>> +                       ret = n_out;
>> +               else
>> +                       n_ranges_out += n_out;
>> +
>> +               if (ret)
>> +                       break;
>> +       }
>> +
> 
> Thanks,
> Andrei

-- 
BR,
Muhammad Usama Anjum

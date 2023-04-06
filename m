Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B595B6DA47E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 23:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237963AbjDFVMp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 17:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbjDFVMo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 17:12:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C628A79;
        Thu,  6 Apr 2023 14:12:43 -0700 (PDT)
Received: from [192.168.10.39] (unknown [119.155.57.40])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E1DF666031CB;
        Thu,  6 Apr 2023 22:12:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680815562;
        bh=jpv185g+czi+1tMEl7JrJg752pEJcPwtivD3XpZ0TXw=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=DrBepuaie+n9o6W1SSg0a0FDPSz0KooP8jIDuIrlC8GOYZwq5SG35XM9e2z8HzpDb
         Rzkga9U1BnxIDZVnxhWOiiekt2s4E7+JisS1+X2AQoZjtBXcpEXwiX9Rjp7uCfOz4F
         JR63zOkdQGDf35/NbuYvRx9q0IYvMDelsStedGQc7NbDHDdkvWWxS/STyNtn0RTIeX
         7Q6KJm8padayOB9G3s2dUYCkAwlSN9OTRhXzGOfEzC8vnDQgP4cClBUGPtXe8OXNYT
         NDrh+5gNUuM5R54q89+uxsIMK70bC8CE0UxFfOZmeH40c9wSXs7yifEPwR3gc6CsEm
         qevdtb/oURlaA==
Message-ID: <b737dceb-a228-7ffe-0758-421505f1a61d@collabora.com>
Date:   Fri, 7 Apr 2023 02:12:31 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
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
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v12 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
Content-Language: en-US
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
References: <20230406074005.1784728-1-usama.anjum@collabora.com>
 <20230406074005.1784728-3-usama.anjum@collabora.com>
 <CABb0KFFTb3LCbyPWLSodtntw=tizYki-pc4nSHBmQOFhKoNYfA@mail.gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABb0KFFTb3LCbyPWLSodtntw=tizYki-pc4nSHBmQOFhKoNYfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/7/23 1:12 AM, Michał Mirosław wrote:
> On Thu, 6 Apr 2023 at 09:40, Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
> [...]
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
> [...]
>> +static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
>> +                                 unsigned long end, struct mm_walk *walk)
>> +{
>> +       struct pagemap_scan_private *p = walk->private;
>> +       bool is_written, is_file, is_present, is_swap;
>> +       struct vm_area_struct *vma = walk->vma;
>> +       unsigned long addr = end;
>> +       spinlock_t *ptl;
>> +       int ret = 0;
>> +       pte_t *pte;
>> +
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +       ptl = pmd_trans_huge_lock(pmd, vma);
>> +       if (ptl) {
> [...]
>> +               return ret;
>> +       }
>> +process_smaller_pages:
>> +       if (pmd_trans_unstable(pmd))
>> +               return 0;
> 
> Why pmd_trans_unstable() is needed here and not only after split_huge_pmd()?
I'm not entirely sure. But the idea is if THP is unstable, we should
return. As it doesn't seem like after splitting THP can be unstable, we
should not check it. Do you agree with the following?


--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1957,11 +1957,11 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd,
unsigned long start,

 		return ret;
 	}
-process_smaller_pages:
+
 	if (pmd_trans_unstable(pmd))
 		return 0;
 #endif
-
+process_smaller_pages:
 	for (addr = start; addr < end && !ret; pte++, addr += PAGE_SIZE)


-- 
BR,
Muhammad Usama Anjum

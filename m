Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5457B70F870
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 16:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235778AbjEXOQd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 10:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235635AbjEXOQa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 10:16:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F45212F;
        Wed, 24 May 2023 07:16:28 -0700 (PDT)
Received: from [192.168.10.48] (unknown [119.155.11.156])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AFC8E6605943;
        Wed, 24 May 2023 15:16:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684937786;
        bh=AuJTdSQvXF6YuhHcmscNAwhCf5setc7Hta7xDcqui0k=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=fIm4enJ3OeMwYz3UmiX6os2xp2qfzmCLKiUjTfJ4WEheyVlpslMtqmurhm5tWkKaE
         B5c862c9aeNgkl2gI4F0CHbOHo9bCwe0x1uvKAZ/Ysnlpi3cIWXeQ2Bz3HiLhkEeRM
         9a8r0sAzu0TsuTVvBmJ4/eabCHK0KDuQFc/s+dr0jaSKCc0cjrKYJEahnBrOKm4PRi
         QLsTEsZBuLUD9wscuazomaYC3KRhTITFTzEJJ+rp00hx1mdxxV5Ijtx4xWfAaB52sm
         xDB1AKaJuABxKR46EqktjF1zovF2M9Zmgm1WFZ4OkXRpgzwW3Q6Qb/m0OIcDkaoDUD
         ByXuRdFihANXg==
Message-ID: <8947d94d-8229-f8ee-e981-9b73462ecb94@collabora.com>
Date:   Wed, 24 May 2023 19:16:02 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        linux-mm@kvack.org, Paul Gofman <pgofman@codeweavers.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
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
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com,
        Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH RESEND v15 2/5] fs/proc/task_mmu: Implement IOCTL to get
 and optionally clear info about PTEs
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
References: <20230420060156.895881-1-usama.anjum@collabora.com>
 <20230420060156.895881-3-usama.anjum@collabora.com>
 <fd9ddd43-6737-88bd-4054-3d5b94534271@collabora.com> <ZEkxh6dbnAOuYuJj@x1n>
 <ff17a13f-ccc2-fc39-7731-6d794c7dd980@collabora.com>
 <0edfaf12-66f2-86d3-df1c-f5dff10fb743@collabora.com> <ZG0XUZSBI2I3/3bY@x1n>
 <a2615158-a0a6-9c2f-b04a-964dfa932aec@collabora.com> <ZG4Xb3rYK0p8BoB9@x1n>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <ZG4Xb3rYK0p8BoB9@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/24/23 6:55 PM, Peter Xu wrote:
...
>>> What is the steps of the test?  Is it as simple as "writeprotect",
>>> "unprotect", then write all pages in a single thread?
>>>
>>> Is UFFDIO_WRITEPROTECT sent in one range covering all pages?
>>>
>>> Maybe you can attach the test program here too.
>>
>> I'd not attached the test earlier as I thought that you wouldn't be
>> interested in running the test. I've attached it now. The test has multiple
> 
> Thanks.  No plan to run it, just to make sure I understand why such a
> difference.
> 
>> threads where one thread tries to get status of flags and reset them, while
>> other threads write to that memory. In main(), we call the pagemap_scan
>> ioctl to get status of flags and reset the memory area as well. While in N
>> threads, the memory is written.
>>
>> I usually run the test by following where memory area is of 100000 * pages:
>> ./win2_linux 8 100000 1 1 0
>>
>> I'm running tests on real hardware. The results are pretty consistent. I'm
>> also testing only on x86_64. PM_SCAN_OP_WP wins every time as compared to
>> UFFDIO_WRITEPROTECT.
> 
> If it's multi-threaded test especially when the ioctl runs together with
> the writers, then I'd assume it's caused by writers frequently need to
> flush tlb (when writes during UFFDIO_WRITEPROTECT), the flush target could
> potentially also include the core running the main thread who is also
> trying to reprotect because they run on the same mm.
> 
> This makes me think that your current test case probably is the worst case
> of Nadav's patch 6ce64428d6 because (1) the UFFDIO_WRITEPROTECT covers a
> super large range, and (2) there're a _lot_ of concurrent writers during
> the ioctl, so all of them will need to trigger a tlb flush, and that tlb
> flush will further slow down the ioctl sender.
> 
> While I think that's the optimal case sometimes, of having minimum tlb
> flush on the ioctl(UFFDIO_WRITEPROTECT), so maybe it makes sense somewhere
> else where concurrent writers are not that much. I'll need to rethink a bit
> on all these to find out whether we can have a good way for both..
> 
> For now, if your workload is mostly exactly like your test case, maybe you
> can have your pagemap version of WP-only op there, making sure tlb flush is
> within the pgtable lock critical section (so you should be safe even
> without Nadav's patch).  If so, I'd appreciate you can add some comment
> somewhere about such difference of using pagemap WP-only and
> ioctl(UFFDIO_WRITEPROTECT), though.  In short, functional-wise they should
> be the same, but trivial detail difference on performance as TBD (maybe one
> day we can have a good approach for all and make them aligned again, but
> maybe that also doesn't need to block your work).
Thank you for understanding what I've been trying to convey. We are going
to translate Windows syscall to this new ioctl. So it is very difficult to
find out the exact use cases as application must be using this syscall in
several different ways. There is one thing for sure is that we want to get
best performance possible which we are getting by adding WP-only. I'll add
it and send v16. I think that we are almost there.

> 

-- 
BR,
Muhammad Usama Anjum

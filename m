Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2579874FD9B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 05:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbjGLDRs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 23:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbjGLDRI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 23:17:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA86D173C;
        Tue, 11 Jul 2023 20:16:46 -0700 (PDT)
Received: from [192.168.10.54] (unknown [119.155.40.122])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 990C06607014;
        Wed, 12 Jul 2023 04:16:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689131805;
        bh=d0MKyXvEz9rNcdSpXroyWsAKTvzVbR9miYy+PdH4Kts=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=hU1K1QYW+MlNfQPWD72zoUpOnSseJ+RU8jsLZGi2179js+KdceOo0CcHXGu1MhmhI
         o/UW+yQY+YQoZwiqHuV1vaZyXashyjmHka9u9OCPZqtbTbEzpWCzPaShDVPhfxHlWi
         EXQLts4VxTQU/2dga7RK3vBbfJeCvXRuSZOIsxDGDTJuu/eIETGNCveVi/FMfjlqjt
         FOsDOc2UvnSzbgK8hSSvPyy2sh2LUubKmig31qoEdgTx8NmvfWgWqmIUE8e9huaEKb
         6ypMsa7wEPyrADBw1aP1Z2u7/nFli+8zgDaxNmW7FuiVFNx+PBiM8RweDHcT/zj/vu
         /byPNQJfPnkow==
Message-ID: <2a4e523a-9d8d-5370-b6f0-f24505f0acea@collabora.com>
Date:   Wed, 12 Jul 2023 08:16:34 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
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
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v24 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
To:     Andrei Vagin <avagin@gmail.com>
References: <20230711125241.1587820-1-usama.anjum@collabora.com>
 <20230711125241.1587820-3-usama.anjum@collabora.com>
 <CANaxB-zvYpKw-aeF8nd_spARdkV29H7ZJDDhusnmqOPZX1xXtw@mail.gmail.com>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CANaxB-zvYpKw-aeF8nd_spARdkV29H7ZJDDhusnmqOPZX1xXtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/12/23 12:42 AM, Andrei Vagin wrote:
> On Tue, Jul 11, 2023 at 5:53 AM Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
> 
> <snip>
> 
>> +static int pagemap_scan_pte_hole(unsigned long addr, unsigned long end,
>> +                                int depth, struct mm_walk *walk)
>> +{
>> +       unsigned long n_pages = (end - addr)/PAGE_SIZE;
>> +       struct pagemap_scan_private *p = walk->private;
>> +       struct vm_area_struct *vma = walk->vma;
>> +       int ret = 0;
>> +
>> +       if (!vma)
>> +               return 0;
>> +
>> +       if (IS_PM_SCAN_GET(p->flags)) {
>> +               if (n_pages > p->max_pages - p->found_pages)
>> +                       n_pages = p->max_pages - p->found_pages;
>> +
>> +               ret = pagemap_scan_output(PM_SCAN_FLAGS(false, false, false,
>> +                                         false, false), p, addr, n_pages);
> 
> Why do we report holes unconditionally?
It seems I've missed the filtering part for holes. It got missed and no
test/reviewer caught it earlier. I'll add it pretty quickly.

Are you satisfied with the remaining patch and can you sent reviewed/acked
by tag?

> 
>> +       }
>> +
>> +       if (IS_PM_SCAN_WP(p->flags) &&
>> +           uffd_wp_range(vma, addr, end - addr, true) < 0)
>> +               ret = -EINVAL;
>> +
>> +       return ret;
>> +}
> 
> Thanks,
> Andrei

-- 
BR,
Muhammad Usama Anjum

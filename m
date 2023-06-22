Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE43739DEB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 12:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjFVKAI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jun 2023 06:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjFVKAG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jun 2023 06:00:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D27B1A4;
        Thu, 22 Jun 2023 03:00:04 -0700 (PDT)
Received: from [192.168.10.55] (unknown [182.179.162.32])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id ACB56660700E;
        Thu, 22 Jun 2023 10:59:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687428003;
        bh=j6EIKy4cSoieiiC75xDAROKxOVZOc1C1Q3ERjaD2rrg=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=kRefeMfElCB0LrRwAPYztcZVCqNLKlAY97v3Q/+gSbt8FQGxVOiOkBAPJfhVBGx6v
         mmAZmocJdVTX/rjNz+1F8eGoJUORk1IdrLsGp3Z+dcEEKCCY/1POO+SLkGxgtPyYea
         iClcyMr22ugS09ZVw0JKZ6pJdESY0iN07Ru7l6Qh33JovoYECG8HFySgIz9RZ5dsJu
         m9TQvgRJTypc6GSUtvLPgvhCEmkeWHTN2YsuBmkHOGCG5voJ/WyscBGvjpKtQx2QQX
         5Af7LXdLzf2Ldq09coY0AWmqPVxnnPRgYHszu5hdJrN502Q6JPV8YwM4auwxYskvqc
         pr/YXHD+luiDA==
Message-ID: <76725a75-b17d-8a88-8d41-15c8daafe7e4@collabora.com>
Date:   Thu, 22 Jun 2023 14:59:48 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrei Vagin <avagin@gmail.com>, Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH v19 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
References: <20230615141144.665148-1-usama.anjum@collabora.com>
 <20230615141144.665148-3-usama.anjum@collabora.com>
 <ZJHp6hSeS6lMo7qx@gmail.com>
 <1c1beeda-ceed-fdab-bbf5-1881e0a8b102@collabora.com>
 <CABb0KFHpE+jJH0MmxZTFaQ9FNFNUnJcnnv7sSGDYqDqqB_FRqw@mail.gmail.com>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABb0KFHpE+jJH0MmxZTFaQ9FNFNUnJcnnv7sSGDYqDqqB_FRqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 6/21/23 6:29 PM, Michał Mirosław wrote:
> On Wed, 21 Jun 2023 at 08:35, Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>> On 6/20/23 11:03 PM, Andrei Vagin wrote:
>> ...
>>>> +struct pagemap_scan_private {
>>>> +    struct page_region *vec_buf, cur_buf;
>>>> +    unsigned long long vec_buf_len, vec_buf_index, max_pages, found_pages, flags;
>>>
>>> should it be just unsigned long?
>> These internal values are storing data coming from user in struct
>> pm_scan_arg in which all variables are 64 bit(__u64) explicitly. This is
>> why we have unsigned long long here. It is absolutely necessary.
> 
> vec_buf_len and vec_buf_index can only have values in 0..512 range.
> flags has only a few lower bits defined (this is checked on ioctl
> entry) and max_pages can be limited to ULONG_MAX. Actually putting `if
> (!max_pages || max_pages > ULONG_MAX) max_pages = ULONG_MAX` would
> avoid having to check !max_pages during the walk.
I'll update.

> 
> Best Regards
> Michał Mirosław

-- 
BR,
Muhammad Usama Anjum

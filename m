Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A683767CE30
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 15:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjAZOdP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 09:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjAZOdL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:33:11 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D358A47437;
        Thu, 26 Jan 2023 06:33:06 -0800 (PST)
Received: from [192.168.10.12] (unknown [39.45.165.226])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A80EE6602E70;
        Thu, 26 Jan 2023 14:32:58 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674743585;
        bh=mV9P8bJmZu6ZoVaX/AoLhr6Mb+mbynE4WbhCFBSCjyE=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=FNbePeBQeO8Fdj/wt46vQOVYphnTBs4KEpYulFjh8hvNua+sMT7opUr8ibsC+Eh93
         0OQeEXt+yEX3c+Z0t8r2Q9gNHLjgXearU+jHnYfS3oRNcYb+N+/Em2U8UtgyPclSLE
         vlk/ZrkmCi95r9EKBWKa3Xrw4J4Vj6ODkBva2Q5Ea+X7BNJKCyvUflEpMFUWEz203F
         wMJuADIlJs3vX2xWykkCRgcMGahtzEAeLo/1AzxnsOogEh325x7/m4ITpd6I1Enq3j
         QKm4ZnmMS6hH+0lSbMnk6o1qbx7GKkAKA+wqtZTXMA97N1HPH0yAiLNKZO8RyjmLD6
         NiKy62m6D6/6g==
Message-ID: <e14875ff-7d59-ae24-9fb0-8169c54c7a17@collabora.com>
Date:   Thu, 26 Jan 2023 19:32:53 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WC?= =?UTF-8?Q?aw?= 
        <emmir@google.com>, Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
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
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v7 3/4] fs/proc/task_mmu: Implement IOCTL to get and/or
 the clear info about PTEs
To:     Peter Xu <peterx@redhat.com>
References: <20230109064519.3555250-1-usama.anjum@collabora.com>
 <20230109064519.3555250-4-usama.anjum@collabora.com> <Y8hyqhgx41/ET7bC@x1n>
 <31b71791-66b0-c2d8-81da-e17eff5ffbe8@collabora.com> <Y9AVuF63y9UjEYcj@x1n>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <Y9AVuF63y9UjEYcj@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/24/23 10:30 PM, Peter Xu wrote:
> On Mon, Jan 23, 2023 at 05:18:13PM +0500, Muhammad Usama Anjum wrote:
>>>> +	if (IS_GET_OP(p) && p->max_pages && (p->found_pages == p->max_pages))
>>>> +		return -ENOSPC;
>>>
>>> This is the function to test "whether the walker should walk the vma
>>> specified".  This check should IIUC be meaningless because found_pages
>>> doesn't boost during vma switching, while OTOH your pmd walker fn should do
>>> proper check when increasing found_pages and return -ENOSPC properly when
>>> the same condition met.  That should be enough, IMHO.
>> This check is needed in case we want to abort the walk at once. We return
>> negative value from here which aborts the walk. Returning negative value
>> from pmd_entry doesn't abort the walk. So this check is needed in the
>> test_walk.
> 
> Why?  What I see locally is (walk_pmd_range):
> 
> 		if (ops->pmd_entry)
> 			err = ops->pmd_entry(pmd, addr, next, walk);
> 		if (err)
> 			break;
Sorry, mistake on my part. I'll correct it in next version (v9).

> 
> Thanks,
> 

-- 
BR,
Muhammad Usama Anjum

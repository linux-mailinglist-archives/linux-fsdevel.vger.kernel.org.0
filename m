Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F9C7652E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 13:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbjG0Ltu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 07:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjG0Ltt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:49:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590411FDA;
        Thu, 27 Jul 2023 04:49:48 -0700 (PDT)
Received: from [192.168.100.7] (unknown [59.103.218.24])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8C5206607057;
        Thu, 27 Jul 2023 12:49:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690458587;
        bh=NC/0VSOPtAjML62vw26aYCCXLVTxIUCUUJS7zYvPPmc=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=g5Gw9jVrYVSkBWRsfZ85xC9Pv7jkspf3yqXuJtKBaFobfMRIpTo5ZqoUhbu8S/A/r
         KiRk5MZNS3mhjapKKtlHZC4pnXcxUCGVOv65GG+DMRFdp+oV8tCZZIXzIIEDFXmIWv
         mFczKH20FJBTCjgqeo0glCPBkHqZ21380lsTwdi2jxEihxtgS+kAGxfJzcqIsOEJui
         Pu8DJACPMXee76vw9s8ZB8oxlGZcA8Eu9490oMKx6BEmSG5Mu82JOWWv67EfzSlLCC
         Z3hwEQXPjDVKWqrtsmnQHurlKRdV1d9eZA8LV5n/VW89lQ2b4iG4sDAeLH4/7ocJd5
         GmEh8qxav/0Rw==
Message-ID: <82de29db-85fc-0d44-ef41-3ccfe0d3d2c1@collabora.com>
Date:   Thu, 27 Jul 2023 16:49:36 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
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
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH v26 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
Content-Language: en-US
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
References: <20230727093637.1262110-1-usama.anjum@collabora.com>
 <20230727093637.1262110-3-usama.anjum@collabora.com>
 <CABb0KFFphs6gLCH9+tenmoJ_3nNAop30pOMhKDwKT2Pthvb=6g@mail.gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABb0KFFphs6gLCH9+tenmoJ_3nNAop30pOMhKDwKT2Pthvb=6g@mail.gmail.com>
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

On 7/27/23 4:46 PM, Michał Mirosław wrote:
> On Thu, 27 Jul 2023 at 11:37, Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
> [...]
>> --- a/include/uapi/linux/fs.h
>> +++ b/include/uapi/linux/fs.h
> [...]
>> +/*
>> + * struct pm_scan_arg - Pagemap ioctl argument
>> + * @size:              Size of the structure
>> + * @flags:             Flags for the IOCTL
>> + * @start:             Starting address of the region
>> + * @end:               Ending address of the region
>> + * @walk_end:          Ending address of the visited memory is returned
>> + *                     (This helps if entire range hasn't been visited)
> 
> "Address where the scan stopped (written by kernel). walk_end == end
> informs that the scan completed."
I'll update comment.

> 
> (To make the userspace life easier, we can copy `end` (only) in case
> of full scan completion, so that the tag is retained.)
Lets be consist and not copy tag from end to walk_end as we'll now know
about tag every time. It should be the responsibility of the user to deal
with it.

> 
>> + * @vec:               Address of page_region struct array for output
>> + * @vec_len:           Length of the page_region struct array
>> + * @max_pages:         Optional limit for number of returned pages (0 = disabled)
>> + * @category_inverted: PAGE_IS_* categories which values match if 0 instead of 1
>> + * @category_mask:     Skip pages for which any category doesn't match
>> + * @category_anyof_mask: Skip pages for which no category matches
>> + * @return_mask:       PAGE_IS_* categories that are to be reported in `page_region`s returned
>> + */

-- 
BR,
Muhammad Usama Anjum

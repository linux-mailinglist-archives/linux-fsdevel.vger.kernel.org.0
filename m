Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4799A69C9F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 12:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjBTLiZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 06:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjBTLiX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 06:38:23 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1FC35AC;
        Mon, 20 Feb 2023 03:38:22 -0800 (PST)
Received: from [192.168.10.12] (unknown [39.45.217.110])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 55780660213E;
        Mon, 20 Feb 2023 11:38:14 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676893101;
        bh=ndUssL4D1NSI2lJLSJV36jCT/BCfVQI0pK6z5TpTdQk=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=J+Vq/Y68W1ffVfJE823stvVS/Jvb3F21LdI7gG43d65Iw7HY0JniN8cd/FPpNjn13
         GNhFn5rzaJy0D3jlUFAVVLIUkJv7STQ4SlYmG2ex4CZW0d8kXRtpgydJ9sL4HOGXbQ
         fNE11J0kxAin8LpX5jpmthIdEnRaDyRfudVjARxnQ1sIJXHfpekHikfsBqxE7/cOMC
         eWtwOwHVsb0rqUg1Zeo0wkS/CssID6Ok8n9PmBw5AQPiuUoRBTUihOuf0v6ogd4d54
         1nyYIdaRdEGSlTTxCK2lPRgPrAlN5Uahrv+XWUPLIVq79/ymr/GLTxuaehbBOqlkpO
         GPO2MNx92epTA==
Message-ID: <da84e16e-ba8f-db2a-fbc5-c05fe730758c@collabora.com>
Date:   Mon, 20 Feb 2023 16:38:10 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Peter Xu <peterx@redhat.com>,
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
        Nadav Amit <namit@vmware.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v10 3/6] fs/proc/task_mmu: Implement IOCTL to get and/or
 the clear info about PTEs
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>
References: <20230202112915.867409-1-usama.anjum@collabora.com>
 <20230202112915.867409-4-usama.anjum@collabora.com>
 <Y+9SjpwS9LsRKQz0@kernel.org>
 <05962e92-9d14-eaf9-2e0b-d683986c9d7f@collabora.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <05962e92-9d14-eaf9-2e0b-d683986c9d7f@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/20/23 3:38 PM, Muhammad Usama Anjum wrote:
>>> +#define PAGEMAP_BITS_ALL		(PAGE_IS_WRITTEN | PAGE_IS_FILE |	\
>>> +					 PAGE_IS_PRESENT | PAGE_IS_SWAPPED)
>>> +#define PAGEMAP_NON_WRITTEN_BITS	(PAGE_IS_FILE |	PAGE_IS_PRESENT | PAGE_IS_SWAPPED)
>>> +#define IS_WP_ENGAGE_OP(a)		(a->flags & PAGEMAP_WP_ENGAGE)
>>> +#define IS_GET_OP(a)			(a->vec)
>>> +#define HAS_NO_SPACE(p)			(p->max_pages && (p->found_pages == p->max_pages))
>>> +
>>> +#define PAGEMAP_SCAN_BITMAP(wt, file, present, swap)	\
>>> +	(wt | file << 1 | present << 2 | swap << 3)
>>> +#define IS_WT_REQUIRED(a)				\
>>> +	((a->required_mask & PAGE_IS_WRITTEN) ||	\
>>> +	 (a->anyof_mask & PAGE_IS_WRITTEN))
>> All these macros are specific to pagemap_scan_ioctl() and should be
>> namespaced accordingly, e.g. PM_SCAN_BITS_ALL, PM_SCAN_BITMAP etc.
>>
>> Also, IS_<opname>_OP() will be more readable as PM_SCAN_OP_IS_<opname> and
>> I'd suggest to open code IS_WP_ENGAGE_OP() and IS_GET_OP() and make
>> HAS_NO_SPACE() and IS_WT_REQUIRED() static inlines rather than macros.
> Will do in next version.
> 

IS_WP_ENGAGE_OP() and IS_GET_OP() which can be renamed to
PM_SCAN_OP_IS_WP() and PM_SCAN_OP_IS_GET() seem better to me instead of
open code as they seem more readable to me. I can open code if you insist.

-- 
BR,
Muhammad Usama Anjum

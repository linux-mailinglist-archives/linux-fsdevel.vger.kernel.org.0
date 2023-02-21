Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2FD769DADE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Feb 2023 08:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbjBUHCd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Feb 2023 02:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbjBUHCd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Feb 2023 02:02:33 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7653720059;
        Mon, 20 Feb 2023 23:02:31 -0800 (PST)
Received: from [192.168.10.12] (unknown [39.45.217.110])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BEA1D6602122;
        Tue, 21 Feb 2023 07:02:21 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676962949;
        bh=q1iXczc30PAPRbZTcDYbH7vJbpyxeUSIqxAjfl8Qb6g=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=ZPCyihoR9qUJFNmmKid0RyywCmvk3wS08sLKOUNc/Tr9LnRLG7a5rMwTJxq1x9bEs
         fHuXI2zg4g15roQmUyI/cnbRQjaZQZ8y0jikf72DfaeOL9BKldffuIzHsNpqLCGHtp
         17/9fZjkhBLm9vcM2zcsRa5X7H0vAhQFiDJlFRO11e/q+OlIS/qSky7z+jnsH7ZvxH
         H8QAkl4/NDjB/a0p0FeZFjXVaVwwcvXj6X7Dal93/sYqdGhCYjCE1Lde4dvgSXGfvE
         Lx2lz0oDIfEYjqGBWjU0oLEEpOe3AO9XXys1kbR7DvHKSr+waWtnMJBsQH35oBukEp
         xOdVh5jwH9xKw==
Message-ID: <af55d3d8-31d8-0deb-d76f-b6d464ad7262@collabora.com>
Date:   Tue, 21 Feb 2023 12:02:17 +0500
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
 <Y/N1EnEEE9y0qp/n@kernel.org>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <Y/N1EnEEE9y0qp/n@kernel.org>
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

On 2/20/23 6:26 PM, Mike Rapoport wrote:
> Hi,
> 
> On Thu, Feb 02, 2023 at 04:29:12PM +0500, Muhammad Usama Anjum wrote:
>> This IOCTL, PAGEMAP_SCAN on pagemap file can be used to get and/or clear
>> the info about page table entries. The following operations are supported
>> in this ioctl:
>> - Get the information if the pages have been written-to (PAGE_IS_WRITTEN),
>>   file mapped (PAGE_IS_FILE), present (PAGE_IS_PRESENT) or swapped
>>   (PAGE_IS_SWAPPED).
>> - Write-protect the pages (PAGEMAP_WP_ENGAGE) to start finding which
>>   pages have been written-to.
>> - Find pages which have been written-to and write protect the pages
>>   (atomic PAGE_IS_WRITTEN + PAGEMAP_WP_ENGAGE)
>>
>> +/*
>> + * struct pagemap_scan_arg - Pagemap ioctl argument
>> + * @start:		Starting address of the region
>> + * @len:		Length of the region (All the pages in this length are included)
>> + * @vec:		Address of page_region struct array for output
>> + * @vec_len:		Length of the page_region struct array
>> + * @max_pages:		Optional max return pages
>> + * @flags:		Flags for the IOCTL
>> + * @required_mask:	Required mask - All of these bits have to be set in the PTE
>> + * @anyof_mask:		Any mask - Any of these bits are set in the PTE
>> + * @excluded_mask:	Exclude mask - None of these bits are set in the PTE
>> + * @return_mask:	Bits that are to be reported in page_region
>> + */
>> +struct pagemap_scan_arg {
>> +	__u64 start;
>> +	__u64 len;
>> +	__u64 vec;
>> +	__u64 vec_len;
>> +	__u32 max_pages;
>> +	__u32 flags;
>> +	__u64 required_mask;
>> +	__u64 anyof_mask;
>> +	__u64 excluded_mask;
>> +	__u64 return_mask;
>> +};
> 
> After Nadav's comment I've realized I missed the API part :)
> 
> A few quick notes for now:
> * The arg struct is fixed, so it would be impossible to extend the API
> later. Following the clone3() example, I'd add 'size' field to the
> pagemam_scan_arg so that it would be possible to add new fields afterwards.
> * Please make flags __u64, just in case
> * Put size and flags at the beginning of the struct, e.g.
> 
> strucr pagemap_scan_arg {
> 	size_t size;
> 	__u64 flags;
> 	/* all the rest */
> };
Updated. Thank you so much!

> 
>> +
>> +/* Special flags */
>> +#define PAGEMAP_WP_ENGAGE	(1 << 0)
>> +
>>  #endif /* _UAPI_LINUX_FS_H */
>> -- 
>> 2.30.2
>>
> 

-- 
BR,
Muhammad Usama Anjum
